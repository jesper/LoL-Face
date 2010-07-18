#ifndef KEYLOGGER_H
#define KEYLOGGER_H

#include <QThread>

class Keylogger : public QThread
{
    Q_OBJECT
public:
    Keylogger() {};
    virtual void run() = 0;

signals:
    void keyPressed(QString key);
};

#endif // KEYLOGGER_H
