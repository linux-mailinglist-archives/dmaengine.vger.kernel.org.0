Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0E1DCFFE
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2020 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgEUOfc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 May 2020 10:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgEUOfa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 May 2020 10:35:30 -0400
Received: from localhost (unknown [106.200.226.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637FB20671;
        Thu, 21 May 2020 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590071730;
        bh=4tcL5zIpbnK3JCtGgVSZL3BbB1I7NqnUw6yXrSq6uOU=;
        h=Date:From:To:Cc:Subject:From;
        b=ub6x9B3clpTd26PF3fCUduAawm8RxawGAqR+dmIFAWOIai/TTJvPekM7ijSFDhGSc
         j0288WAYSoLeFs4xksKHVeF7RFY0rCNbmo4bW6WptUPQl1MfpXqowehdHaBVzeZsy8
         RQ6mn2ACFoOaxN/1PuoiXBJNz3lf1eH2ogil5xGc=
Date:   Thu, 21 May 2020 20:05:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.7-rc7
Message-ID: <20200521143521.GC374218@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Couple of late fixes for dmaengine, please pull.

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.7-=
rc7

for you to fetch changes up to 3a5fd0dbd87853f8bd2ea275a5b3b41d6686e761:

  dmaengine: tegra210-adma: Fix an error handling path in 'tegra_adma_probe=
()' (2020-05-19 22:26:01 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.7-rc7

Couple of driver fixes:
 - dmatest restoration of defaults
 - tegra210-adma probe handling fix
 - k3-udma flags fixed for slave_sg and memcpy
 - List fix for zynqmp_dma
 - idxd interrupt completion fix
 - lock fix for owl

----------------------------------------------------------------
Christophe JAILLET (1):
      dmaengine: tegra210-adma: Fix an error handling path in 'tegra_adma_p=
robe()'

Cristian Ciocaltea (1):
      dmaengine: owl: Use correct lock in owl_dma_get_pchan()

Dave Jiang (1):
      dmaengine: idxd: fix interrupt completion after unmasking

Peter Ujfalusi (1):
      dmaengine: ti: k3-udma: Fix TR mode flags for slave_sg and memcpy

Rafa=C5=82 Hibner (1):
      dmaengine: zynqmp_dma: Move list_del inside zynqmp_dma_free_descripto=
r.

Vladimir Murzin (1):
      dmaengine: dmatest: Restore default for channel

 drivers/dma/dmatest.c           |  9 +++++----
 drivers/dma/idxd/device.c       |  7 +++++++
 drivers/dma/idxd/irq.c          | 26 +++++++++++++++++++-------
 drivers/dma/owl-dma.c           |  8 +++-----
 drivers/dma/tegra210-adma.c     |  2 +-
 drivers/dma/ti/k3-udma.c        |  6 ++++--
 drivers/dma/xilinx/zynqmp_dma.c |  3 +--
 7 files changed, 40 insertions(+), 21 deletions(-)

--=20
~Vinod

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl7GkagACgkQfBQHDyUj
g0dZSg//WxIuJF6+RqQqLgsH6wO1SZ9yPuEz2TIoZqKICePm3azDU1fRJJqcZbqw
LtBwg17fcCEm3JE4AQtxzi1h+0r6ediQBxq6SAQe8s6gNQbyVGrjGeV+FFt93BzU
MgSMsdM1PRYrN3b/bdyZC4HYNuUqkh7fT03OxOyD1gFbGMy48hvsc3UITwjYRxUx
2k0KBttLbTQVWoxD0tK6xy2vrqzxfn7XrGstbWQtci0lRl661FKSVz3c+Gm9d/cH
LEx+bbWOWQSAoxU3G26WmqO+eo4yZDyh/eB4auDJ47IacWkpQTq326Zp9tSaq2W3
V2/DlUpmlEpWMF6tBlOrwhLh9B6Dvl+tNZT7aSwI0z/eucgSKk22z6ej/4kMy/4O
Oe7gOmhVGWxvcUTsEgmS3zIKM3f6SCoeJkI/CYbsw3wYD8gTKjlPNfQPzvf0Tr5V
Zq4iPhKvH8t1xRJBfXr2spTsQRtBaDdHfcvCaYzJX259Syx0uOCYkLJuybBOvCwM
+eN2vm0EdGEPaQac4MGEiJjT4k/RitmP0fk0E8uphqP5kP4qYrGDA5XCqZBQ6rQo
zE0cCXq/4Syxmm0/A/a7T4kcKdSPdDe80DVIm48v67ZJt8Cm5ITOydt1TSde3j9s
ZW2sED5PF7PlBWGfdoCWTFCDJ0PD3FUg5idrhb0z1ZyEj9RwxaY=
=BIQW
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
