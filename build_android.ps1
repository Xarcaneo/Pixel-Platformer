$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
Write-Host "Using Java version:"
& "$env:JAVA_HOME\bin\java" -version
Write-Host "`nStarting build..."
cd android\build
& "$env:JAVA_HOME\bin\java" "-Dorg.gradle.java.home=$env:JAVA_HOME" -jar .\gradle\wrapper\gradle-wrapper.jar assembleDebug
