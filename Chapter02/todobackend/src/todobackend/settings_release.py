from .settings import *
import os

# Disable debug
DEBUG = True

# Set secret key
SECRET_KEY = os.environ.get('SECRET_KEY', SECRET_KEY)

# Must be explicitly specified when Debug is disabled
ALLOWED_HOSTS = os.environ.get('ALLOWED_HOSTS', '*').split(',')

# Database settings
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': os.environ.get('MYSQL_DATABASE','todobackend'),
        'USER': os.environ.get('MYSQL_USER','todo'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD','password'),
        'HOST': os.environ.get('MYSQL_HOST','localhost'),
        'PORT': os.environ.get('MYSQL_PORT','3306'),
    },
    'OPTIONS': {
      'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
    }
}

STATIC_ROOT = os.environ.get('STATIC_ROOT', '/public/static')
MEDIA_ROOT = os.environ.get('MEDIA_ROOT', '/public/media')