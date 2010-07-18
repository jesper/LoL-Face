#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDebug>
#include <QQueue>
#include <QSettings>
#include <QProcess>
#include <QDir>
#include <QDateTime>
#include <QTimer>
#include <QCloseEvent>
#include <QApplication>
#include <QVBoxLayout>
#include <QStandardItemModel>
#include <QtGui>

#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeContext>

#include "keylogger_x11.h"


class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

public slots:
    //Needed to be able to quit from QML. Qt.quit() doesn't seem to work.
    void quit();

protected:
    void closeEvent(QCloseEvent *closeEvent);

private:
    void lolFace();
    bool imageGrabberExists();
    void webcamSnapshot(const QString path);
    void showSysTrayUsage();
    void populateImageModel();

private slots:
    void keylogger_keypress(QString key);
    void setNeutralTrayIcon();

signals:
    void newImage(QString path);

private:
    Keylogger *m_keylogger;
    QString m_logged;
    QSystemTrayIcon *m_sysTray;
    QString m_dataPath;
    QDeclarativeView *m_qmlView;
    QDeclarativeContext *m_qmlContext;
    QStandardItemModel *m_imageModel;

};

#endif // MAINWINDOW_H
