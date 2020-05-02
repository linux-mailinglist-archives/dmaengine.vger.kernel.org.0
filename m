Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79041C2490
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2020 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEBLEB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 May 2020 07:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgEBLEB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 2 May 2020 07:04:01 -0400
Received: from localhost (unknown [117.99.89.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF9D216FD;
        Sat,  2 May 2020 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588417440;
        bh=Pg5WQCD32iVLP/ezBlUn7r2Q1U1atV4LE5nchd33Huk=;
        h=Date:From:To:Cc:Subject:From;
        b=WWvPzYScb1Lp93W/bugKq64qeNjtJWcZBf/HRhBPdHmNNyf28/uSRDDPX/UnD49FJ
         8mAn9gxHLhTftbFEvG6tRbUV20wRAeYmkI76Nss7oyzsGk5HWdf/bggBzHoVhuhvsw
         BY7gUuU9mkS50ejPQBeTA/D26JXvlV8HCGWRM4hU=
Date:   Sat, 2 May 2020 16:33:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.7-rc4
Message-ID: <20200502110348.GM948789@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to recived few fixes for dmaengine. A core fix, with
documentation fixes as well as driver fixes:

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.7-=
rc4

for you to fetch changes up to aa72f1d20ee973d68f26d46fce5e1cf6f9b7e1ca:

  dmaengine: dmatest: Fix process hang when reading 'wait' parameter (2020-=
04-28 21:46:35 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.7-rc4

Core:
 - Documentation typo fixes
 - fix the channel indexes
 - Dmatest: fixes for process hang and iterations
Drivers:
 - hisilicon: build error fix without PCI_MSI
 - ti-k3: deadlock fix
 - uniphier-xdmac: fix for reg region
 - pch: fix data race
 - tegra: fix clock state

----------------------------------------------------------------
Andy Shevchenko (2):
      dmaengine: dmatest: Fix iteration non-stop logic
      dmaengine: dmatest: Fix process hang when reading 'wait' parameter

Dave Jiang (1):
      dmaengine: fix channel index enumeration

Dmitry Osipenko (1):
      dmaengine: tegra-apb: Ensure that clock is enabled during of DMA sync=
hronization

Grygorii Strashko (1):
      dmaengine: ti: k3-psil: fix deadlock on error path

Lubomir Rintel (2):
      dmaengine: mmp_tdma: Do not ignore slave config validation errors
      dmaengine: mmp_tdma: Reset channel error on release

Maciej Grochowski (1):
      include/linux/dmaengine: Typos fixes in API documentation

Madhuparna Bhowmik (1):
      dmaengine: pch_dma.c: Avoid data race between probe and irq handler

Masahiro Yamada (1):
      dt-bindings: dma: uniphier-xdmac: switch to single reg region

Sebastian von Ohr (1):
      dmaengine: xilinx_dma: Add missing check for empty list

YueHaibing (1):
      dmaengine: hisilicon: Fix build error without PCI_MSI

 .../bindings/dma/socionext,uniphier-xdmac.yaml     |  7 ++-
 drivers/dma/Kconfig                                |  3 +-
 drivers/dma/dmaengine.c                            | 60 ++++++++++--------=
----
 drivers/dma/dmatest.c                              |  6 +--
 drivers/dma/mmp_tdma.c                             |  5 +-
 drivers/dma/pch_dma.c                              |  2 +-
 drivers/dma/tegra20-apb-dma.c                      |  9 ++++
 drivers/dma/ti/k3-psil.c                           |  1 +
 drivers/dma/xilinx/xilinx_dma.c                    | 20 ++++----
 include/linux/dmaengine.h                          | 12 ++---
 10 files changed, 65 insertions(+), 60 deletions(-)

--=20
~Vinod

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl6tU5QACgkQfBQHDyUj
g0dPQRAAsR4mNVNv1eCt4LScsDT16pXID511hiFa1VIbsmA02SZBK5+RsKjGJ3bh
pAgIvPYjbg1ijbxeE8xWlXVOgYb4jtbd4B/tbmkwT53VRhgYNiWuxC+3NtGTmobN
XijkOpt2c0ulb8derWp4VOjcjdEzMoqVvfUE/2ENq3b7XE3ZN//JXiT9VIFGwsJv
SjkTu4e9WDnQ+WT3kHpl+vxJmCLSxKnZ3xYE+dHFCg2decw29VT67C5MMddMEbQu
SUI4ed20BfKF4d1R3aneHr7Hj40fa2r1Vyu+0jKDs2fNDuMIwxcVDI6V9anDDOA6
1OnjYtnIOub4ZalVgpTvh5q5wsmnmn/KZFECcytbtgIjRYZlAtcN9JGmbuxe5tx1
kqTsDqjqkI0pVY6B39VOMvQk52GZezXv+kJhiy88UjXjUqto1gOd3KGKGAYlCAo/
5VlDbRWOkli6es8EgspwvHWElKS4quhNOzhkkggZb2LX7A2a55lI1YDsUVtsbFcd
jW4Y7Gi//VEefPwcWwmGGfvHbBOQ3w54kZw5SF6g2e8nstUP2FeWSASPBCtEHgrI
v0tguCMOYnWnX4MFgCLE9z4bmafGlye1priIQmpQ1lf8r6vQlxE4dAEHAj1Zld1E
Ah/EUyFwQQyPihlAWTNt6QiXz10hgRSgGkp8Wbb8g29iI7qzU5E=
=9jS/
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
