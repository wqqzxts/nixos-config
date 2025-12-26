{
  services.zapret = {
    enable = true;
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "ytimg.com"
      "youtu.be"
      "googleapis.com"
    ];

    params = [
      "--filter-tcp=80 ˂HOSTLIST˃"
      "--dpi-desync=fake,fakedsplit"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=md5sig"
      "--new"
      "--filter-tcp=443"
      "--dpi-desync=fake,multidisorder"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-split-pos=midsld"
      "--dpi-desync-fake-tls=0x00000000"
    ];
  };

}
