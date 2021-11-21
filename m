Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0495A458441
	for <lists+dmaengine@lfdr.de>; Sun, 21 Nov 2021 16:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhKUPFl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Nov 2021 10:05:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:58551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238335AbhKUPFh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Nov 2021 10:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637506951;
        bh=E2btNeFRA3GGsbq5L/SotP+/jQ/dSxz3Noz23olq0u4=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=Hy3L4m48u/kwwQxjOcBs0cw2J+Bq80ux+SivO6CtqcTMeYG17uHe5aZPkcnTv8CUz
         0ydLLdfUAl4GhrxGzpSr/YmANhontpCeMZPc/L/nEnDHAVDtprzLG9ly+8qjKp9RlL
         /EEkXGRrRXlURZeNXKyaZSpEzD9HrdDDv1thegQ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.6.127.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1mrYzo3wlC-00H7OQ; Sun, 21
 Nov 2021 16:02:31 +0100
Message-ID: <747802b9-6c5d-cdb5-66e2-05b820f5213c@gmx.de>
Date:   Sun, 21 Nov 2021 16:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: compile error for 5.15.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uNQHiFJp8tRsTyJkn/mjNH13VO4TkrchGNKyrrezdYlm9F2M4RG
 6ektVLEgFsUgV+pnsyP67aAGw+d8LMWnBexp1kMJtN6EbTei4uf9iOyc0p5po4iAbCkpZhx
 k61Rvy76Hb+IUyy7gd6/MaxS7e0Ev0otg8rSmD3ta1UlNxios244QCU8oHiRFkJ8W7Sj2YK
 iqz9Bsm9nN9LATWu45+Zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:djnb1xtSlSA=:k337GDmwoR7b90Nw/0ByAl
 psUi37nQauW0QSRXSBBiblM4m71d2XjRUFhiEXuC/8nd3QRhq9KOj1kboxIv+QwrO6+1VCtb1
 TfGzqPCzD0umUVItVwgHsfJCikd42RXB52MraYcIKgK5lD73NIvcaH6wlHLQxiBZr5vZU8pOK
 uMT1xt0Uh+kPdg+vDrozW8M+hhOzTWT3293UMQ9GNvbuW0Le/y/6mXBOgwfrg9MLmX40CT4bn
 XSts3E4XFvMeejnZKcW5WtLrJbVKN/C/7AoyCAZ+d7auIlxBp2S7p9blZUste5mgmi3t6SZXb
 LZ4AuU7pAzrCHkI4OpItVnSdxCbbNpoQljoKplVQHTdZIwuWGNRlGaTq1VGVCoALEmidwT+Fa
 QWyJ8JYd7qDFKBKRQdSTxdJk3DkSHqx/pVzxWP1WNKwp3vCy+UcYbNNhqYwJr+HyVv0G2yrDQ
 A5vuBoqvSyiHcFhV4EabTWaO91sA1NIeejfTytTfQopi3T9gY8WbdVc/BpOBHaCyFHD1Un8z4
 /fVFa3Q9WKpKkSflQRUMcTGX2OfpO5rjpUnb6R6CNChNlcrW71DV+uuOXUl3o3yIPrmT8pq6E
 ymfjOm8xx6TeYkcgMiqApFB2mCXTvNjq4kBeiDcr408ONI5V+de/w/nXhm35CPEcsHsTvdLS6
 dLKivAF8KSczsgtVzcLdvnLL5yB5NuzlfR/Zh6RroHgvbakIYA+m2IHXq6BTqsW+JwuM4QN2B
 Xo4AfOjJ6Zsq9smQLRJWxxTKIExvqfwpeTbcKJDM5Tn3K+LtrTk+jETrxm7XYDgQmoNyE3P3+
 Gd57+5LprNKaBEWvhMVLfdYrzxdZ4fQ4gJiepkySOUvzs9qS0MYAFbaBFFMMzzkPHUjdfWw4E
 /Q8MmuakeOP0ODbQlQfUKLdqeoV5ZPuesKvm11CCaf7TgXNffueSSNBwQxmubRQ2apb5fmRSn
 iNrYq+8EkrAxFgTfeX+03pR/ulWXzalMQunGzV4x3Mlv3RdqZ75jjentP4Xue5YDNxYu6tPkv
 cT5svJu7SMA0358/FBjvJqTDFSlTwRm4RP56Aqh2MkxlZ6h1ptZqzz7CYDkHsOttp+b7jKWM5
 lc4aZoFqgET7xo=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

got this at a hardened stable Gentoo Server:

# uname -a
Linux mr-fox 5.14.17 #1 SMP Thu Nov 18 14:02:58 CET 2021 x86_64 AMD
Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux


   CC      net/ipv4/tcp_timer.o
   CC      lib/raid6/sse1.o
drivers/dma/ptdma/ptdma-debugfs.c: In function =E2=80=98ptdma_debugfs_setu=
p=E2=80=99:
drivers/dma/ptdma/ptdma-debugfs.c:93:54: error: =E2=80=98struct dma_device=
=E2=80=99 has
no member named =E2=80=98dbg_dev_root=E2=80=99
    93 |         debugfs_create_file("info", 0400,
pt->dma_dev.dbg_dev_root, pt,
       |                                                      ^
drivers/dma/ptdma/ptdma-debugfs.c:96:55: error: =E2=80=98struct dma_device=
=E2=80=99 has
no member named =E2=80=98dbg_dev_root=E2=80=99
    96 |         debugfs_create_file("stats", 0400,
pt->dma_dev.dbg_dev_root, pt,
       |                                                       ^
drivers/dma/ptdma/ptdma-debugfs.c:102:52: error: =E2=80=98struct dma_devic=
e=E2=80=99 has
no member named =E2=80=98dbg_dev_root=E2=80=99
   102 |                 debugfs_create_dir("q", pt->dma_dev.dbg_dev_root)=
;
       |                                                    ^
make[3]: *** [scripts/Makefile.build:277:
drivers/dma/ptdma/ptdma-debugfs.o] Error 1
make[2]: *** [scripts/Makefile.build:540: drivers/dma/ptdma] Error 2
make[1]: *** [scripts/Makefile.build:540: drivers/dma] Error 2
make[1]: *** Waiting for unfinished jobs....
   CC      mm/usercopy.o
   CC      lib/argv_split.o

=2D-
Toralf
