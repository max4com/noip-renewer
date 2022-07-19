FROM python:3.10.5-alpine@sha256:90971a0dab4513876b3d46c381069908f2fd57e5e1a42ca5a539042658268967

ARG PIP_VERSION
ARG SELENIUM_VERSION
ARG GOOGLETRANS_VERSION
ARG REQUESTS_VERSION

RUN apk add --no-cache gcc libc-dev libffi-dev && \
    pip install --no-cache-dir pip=="$PIP_VERSION" && \
    pip install --no-cache-dir --user selenium=="$SELENIUM_VERSION" googletrans=="$GOOGLETRANS_VERSION" requests=="$REQUESTS_VERSION"



FROM python:3.10.5-alpine@sha256:90971a0dab4513876b3d46c381069908f2fd57e5e1a42ca5a539042658268967

RUN apk add --no-cache chromium chromium-chromedriver && \
    rm -rf /var/cache/apk/* /tmp/* /usr/share/doc

COPY --from=0 /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

ADD renew.py .

ENTRYPOINT ["python3", "renew.py"]
