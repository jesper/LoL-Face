#include "mainwindow.h"
#define TIMEOUT 1000

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    QCoreApplication::setOrganizationName("lol-face");
    QCoreApplication::setOrganizationDomain("lol-face");
    QCoreApplication::setApplicationName("lol-face");

    if (!imageGrabberExists())
    {
        QMessageBox::critical(this, "Webcam Grabber not found :(", "Could not find the webcam image grabber (v4lctl), please make sure you have the xawtv package installed.");
        exit(1);
    }


    m_dataPath = QDir::homePath() + "/lolface/";

    QDir dir(m_dataPath);

    if (!dir.exists())
        dir.mkpath(m_dataPath);

    m_imageModel = new QStandardItemModel(this);
    populateImageModel();

    m_triggerModel = new QStandardItemModel(this);
    populateTriggerModel();

    setFixedSize(800, 600);

    m_qmlView = new QDeclarativeView(this);

    m_qmlContext = m_qmlView->rootContext();
    m_qmlContext->setContextProperty("imageModel", m_imageModel);
    m_qmlContext->setContextProperty("triggerModel", m_triggerModel);

    m_qmlContext->setContextProperty("cplusplus", this);
    m_qmlView->setSource(QUrl("qrc:qml/view.qml"));

    m_qmlView->show();


#ifdef Q_WS_X11
    m_keylogger = new Keylogger_x11();
#endif

    connect(m_keylogger, SIGNAL(keyPressed(QString)), this, SLOT(keylogger_keypress(QString)));

    //better pray you're running one of the above keylogger platforms, else you're dooooomed!
    m_keylogger->start();

    m_sysTray = new QSystemTrayIcon(this);
    setNeutralTrayIcon();
    connect(m_sysTray, SIGNAL(activated(QSystemTrayIcon::ActivationReason)), this, SLOT(sysTrayClicked()));
    m_sysTray->show();
}

MainWindow::~MainWindow()
{
    delete m_sysTray;
}

void MainWindow::sysTrayClicked()
{
    setVisible(!isVisible());
}

void MainWindow::quit()
{
    QCoreApplication::exit(0);
}

void MainWindow::addTrigger(QString trigger)
{
    if (trigger.isEmpty())
        return;

    for (int i=0; i < m_triggerModel->rowCount(); ++i)
    {
        if (m_triggerModel->item(i)->text() == trigger)
            return;
    }

    m_triggerModel->appendRow(new QStandardItem(trigger));
    saveTriggerModel();
}

void MainWindow::removeTrigger(QString trigger)
{
    for (int i=0; i < m_triggerModel->rowCount(); ++i)
    {
        if (m_triggerModel->item(i)->text() == trigger)
        {
            m_triggerModel->removeRow(i);
            saveTriggerModel();
            return;
        }
    }
}

void MainWindow::saveTriggerModel()
{
    QStringList triggers;

    for (int i=0; i < m_triggerModel->rowCount(); ++i)
        triggers.append(m_triggerModel->item(i)->text());

    QSettings settings;
    settings.setValue("triggers", triggers);
}

void MainWindow::populateTriggerModel()
{
    QSettings settings;
    QStringList triggers = settings.value("triggers", "lol").toStringList();

    for (int i=0; i < triggers.size(); ++i)
        m_triggerModel->appendRow(new QStandardItem(triggers.at(i)));
}

void MainWindow::populateImageModel()
{
    QDir dir(m_dataPath);
    QStringList webcamPics = dir.entryList(QStringList("*webcam.jpg"), QDir::Files, QDir::Name);

    for (int i=0; i < webcamPics.size(); ++i)
        m_imageModel->appendRow(new QStandardItem(QUrl::fromLocalFile(m_dataPath + webcamPics.at(i)).toString()));
}


bool MainWindow::imageGrabberExists()
{
    return (QProcess::execute("v4lctl") == 1);
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    showSysTrayUsage();
    hide();
    event->ignore();
}

void MainWindow::setNeutralTrayIcon()
{
    m_sysTray->setIcon(QIcon(":images/neutral.svg"));
}

void MainWindow::showSysTrayUsage()
{
    QSettings settings;

    if (settings.value("firstTimeUser", true).toBool())
        m_sysTray->showMessage("LoL Face","LoL Face will keep running in the system tray. Click the icon to bring up application.");

    settings.setValue("firstTimeUser", QVariant(false));
    return;
}

void MainWindow::lolFace()
{
    m_sysTray->setIcon(QIcon(":images/happy.svg"));
    QTimer::singleShot(TIMEOUT, this, SLOT(setNeutralTrayIcon()));

    // Grabbing the entire desktop, and not just the current window, incase something off-window made you LoL
    // Rationale: Stashbert.
    QPixmap screenshot = QPixmap::grabWindow(QApplication::desktop()->winId());
    QDateTime timestamp = QDateTime::currentDateTime();

    QString path = m_dataPath + timestamp.toString(Qt::ISODate);
    screenshot.save(path + ".desktop.jpg", "JPG");
    webcamSnapshot(path + ".webcam.jpg");

    QStandardItem *item = new QStandardItem(QUrl::fromLocalFile(path + ".webcam.jpg").toString());
    m_imageModel->appendRow(item);
}

void MainWindow::webcamSnapshot(const QString path)
{
    QProcess::execute("v4lctl snap jpeg full \"" + path + "\"");
}

void MainWindow::keylogger_keypress(QString key)
{
    m_logged.append(key);

    if (m_logged.length() > 10)
        m_logged.remove(0, m_logged.length()-10);

    for (int i=0; i < m_triggerModel->rowCount(); ++i)
    {
        if (m_logged.toUpper().endsWith(m_triggerModel->item(i)->text().toUpper()))
        {
            lolFace();
            m_logged.clear();
        }
    }
}
