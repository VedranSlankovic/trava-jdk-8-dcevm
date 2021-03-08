export PATH=/cygdrive/c/tools/cygwin/bin:$PATH

wget -q -O OpenJDK8_x64_Windows.zip "https://api.adoptopenjdk.net/v2/binary/releases/openjdk8?openjdk_impl=hotspot&os=windows&arch=x64&release=latest&type=jdk"
JDK8_BOOT_DIR="$PWD/$(unzip -Z1 OpenJDK8_x64_Windows.zip | grep 'bin/javac'  | tr '/' '\n' | tail -3 | head -1)"
unzip -q OpenJDK8_x64_Windows.zip

# unset cygwin's gcc preconfigured
unset -v CC
unset -v CXX
export JAVA_HOME=${JDK_BOOT_DIR}

cd ./openjdk-build
export LOG=info
./makejdk-any-platform.sh --tag "${SOURCE_JDK_TAG}" --build-variant dcevm  --branch "${SOURCE_JDK_BRANCH}" --jdk-boot-dir ${JDK8_BOOT_DIR} --hswap-agent-download-url ${HSWAP_AGENT_DOWNLOAD_URL} --hswap-agent-core-download-url ${HSWAP_AGENT_CORE_DOWNLOAD_URL} --disable-test-image --check-fingerprint false --configure-args '-disable-warnings-as-errors --disable-hotspot-gtest' --target-file-name java8-openjdk-dcevm-${TRAVIS_OS_NAME}.zip jdk8u
