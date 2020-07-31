#!/bin/bash
exec /bin/tini -- /usr/bin/supervisord -n
