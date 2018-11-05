#import cert chain

$cert = ($env:temp + "\SpecRep.pfx")
Import-PfxCertificate -FilePath $cert -CertStoreLocation Cert:\LocalMachine\Root


