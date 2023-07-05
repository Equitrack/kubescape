FROM oraclelinux:8-slim

MAINTAINER Equitrack

# AutoUpdate kubescape binary when building

RUN \
  microdnf update -y && \
  microdnf install -y unzip && \
  KUBESCAPE_VERSION=$(curl --silent "https://api.github.com/repos/kubescape/kubescape/releases" | grep -oP '"tag_name": "\K(.*)(?=")' | head -n 1) && \
  echo -e "KUBESCAPE LAST VERSION: [${KUBESCAPE_VERSION}]" && \
  curl -LO https://github.com/kubescape/kubescape/archive/refs/tags/${KUBESCAPE_VERSION}.zip && \
  unzip ${KUBESCAPE_VERSION}.zip && \
  rm ${KUBESCAPE_VERSION}.zip && \
  mv kubescape* /kubescape && \
  sh /kubescape/install.sh && \
  rm -rf /kubescape && \
  mkdir /root/.kube
  
ENTRYPOINT ["/usr/local/bin/kubescape"]

CMD ["--help"]
