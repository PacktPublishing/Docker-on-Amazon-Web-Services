"""
WSGI config for todobackend project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "todobackend.settings")

from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

# Required to avoid SegmentNameMissingException errors
xray_recorder.configure(service="todobackend")

patch_all()

application = get_wsgi_application()
