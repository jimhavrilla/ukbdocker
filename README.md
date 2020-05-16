# ukbdocker

This is a small repository for making [`ukbgene`](https://biobank.ctsu.ox.ac.uk/crystal/download.cgi?id=665&ty=ut), a Linux-only binary that downloads the UK Biobank genotype and imputation data files run on Mac/Windows.  There are two reasons for this, one being that your server is behind several firewalls and that downloads take literal months to complete, and the second reason is if you are using a Windows-based server.

#### Before doing anything else, download:
[Docker Desktop for Mac or Windows](https://www.docker.com/products/docker-desktop), but this link is [different for Windows Servers](https://docs.docker.com/ee/docker-ee/windows/docker-ee/)

## How to do it:

Obviously, I cannot upload the `.ukbkey` authentication file here, as it is specific to my project and would be a major HIPAA violation (and the UK's equivalent, the Data Protection Act), but if you have your own approved UKB Project you can simply replace your keyfile in the command (and you can use its name too).

Modify the `Dockerfile` with your key name and run:

`docker build -t ukbgene:latest`

After the build succeeds (should be pretty fast and easy) run:

`docker run -v /fullpath/to/where/you/want/your/files:/ukb ukbgene "ukbgene imp -c1 -a/.ukbkey"`

And this will download the imputation data for the first chromosome (~180 GB) for the UK Biobank cohort.  Obviously, you should replace `/fullpath/to/where/you/want/your/files` with whatever you want to store it, and `imp` with the data type you want `cal` for base genotype calls, `rel` gives you relatedness files, `hap` haplotype files, etc.  Also, replace `-c1` with chromsome you want.  It's all [in the UKB documentation](https://biobank.ndph.ox.ac.uk/showcase/showcase/docs/ukbgene_instruct.html).  Then of course, replace `.ukbkey` with your key name and do so in the `Dockerfile` or just rename your key to `.ukbkey` (it's what I did).

Then just `scp` or `rsync` (my choice) to your server without timeout as in:

`rsync --timeout=0 --partial --progress -v --blocksize=1048576 your/filedirectory/ukb_imp_chr1_v3.bgen username@remoteserver.edu:/where/to/store/them`

And that's it~!
