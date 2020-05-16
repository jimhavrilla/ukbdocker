FROM centos
COPY ukbgene /bin/
COPY .ukbkey .
WORKDIR /ukb
ENTRYPOINT ["bash", "-c"]
CMD ["ukbgene"]
