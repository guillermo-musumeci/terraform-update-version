# download the page of Terraform releases
$WebResponse = Invoke-WebRequest "https://releases.hashicorp.com/terraform"

# describe the file to download, for the 32-bits, use “ _windows_386.zip” instead
$tfFile = $WebResponse.Links[1].outerText + "_windows_amd64.zip"

# define the full URL of the file to download from the Terraform web site
$tfURL = "https://releases.hashicorp.com" + $WebResponse.Links[1].href + $tfFile

# search for Terraform in Path environment variable
$tfPath = $env:Path -split ';' | Where-Object {$_ -Match "Terraform"}

# define the output file where we will download the .zip file of Terraform
$tfOutFile = $tfPath + "\" + $tfFile

# download the .zip file from the Terraform web site
Invoke-WebRequest -Uri $tfURL -OutFile $tfOutFile

# extract the content of the .zip file to the Terraform folder
Expand-Archive -LiteralPath $tfOutFile -DestinationPath $tfPath-force

# check version of Terraform installed
terraform -v
