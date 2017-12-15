FROM jacobsvante/python:3.7.0a3-alpine3.6-with-bpo-31940-lchown-fix

WORKDIR /app/
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
ENTRYPOINT ["tox"]

RUN apk add --no-cache\
    curl\
    git\
    # Bash (needed by pyenv) and general build packages
    bash make gcc musl-dev linux-headers\
    # For CFFI support
    libffi-dev\
    # For cairosvg
    cairo-dev\
    # For lxml
    libxml2-dev libxslt-dev\
    # PIL/Pillow support
    zlib-dev jpeg-dev libwebp-dev freetype-dev lcms2-dev openjpeg-dev\
    # For psycopg2
    postgresql-dev
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | sh

ARG versions="2.7.14 3.3.7 3.4.7 3.5.4 3.6.3 pypy2.7-5.9.0 pypy3.5-5.9.0"
RUN for version in $versions; do pyenv install -v $version; done

