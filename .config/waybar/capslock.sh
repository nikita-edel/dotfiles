#!/usr/bin/env python3
import struct, glob, select, json, sys

EV_LED    = 17
LED_CAPSL = 1
FMT = '@qqHHi'
SZ  = struct.calcsize(FMT)

def sysfs_state():
    for f in glob.glob('/sys/class/leds/input*::capslock/brightness'):
        try:
            if open(f).read().strip() == '1':
                return True
        except:
            pass
    return False

def emit(on):
    s = 'on' if on else 'off'
    print(json.dumps({'alt': s, 'class': s}), flush=True)

emit(sysfs_state())

fds = []
for dev in glob.glob('/dev/input/by-path/*-event-kbd'):
    try:
        fds.append(open(dev, 'rb', buffering=0))
    except OSError:
        pass

while fds:
    r, _, _ = select.select(fds, [], [])
    for fd in r:
        data = fd.read(SZ)
        if len(data) < SZ:
            continue
        _, _, typ, code, value = struct.unpack(FMT, data)
        if typ == EV_LED and code == LED_CAPSL:
            emit(value == 1)
