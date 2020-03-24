Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80B7190544
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2020 06:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgCXFkX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Mar 2020 01:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXFkX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Mar 2020 01:40:23 -0400
Received: from localhost (unknown [122.167.122.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D62F20663;
        Tue, 24 Mar 2020 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585028422;
        bh=ogg9uEIrDneD7d+0XGXZHzAa2bCpqbGF8ExOM9/BgYA=;
        h=Date:From:To:Cc:Subject:From;
        b=PGlZeuMbdjr4did3lfuNkd+IvJcUXQz4PlYvHKrcK4UFMpRyFbveKwkY3WKp69VeB
         xTzbzPR1wmcn6ZP7SLtT02uSGbdw8WuoWf1HbY7Q4kE7OkOlJgSmo5ZZuNOFSXK/EZ
         Posx3K+ivmErsNZUxWalkFRiBEc6FFlLyN4PD/+U=
Date:   Tue, 24 Mar 2020 11:10:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.6
Message-ID: <20200324054017.GU72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Couple of fixes came in and would be good to have in v5.6. Please
pull to get:

The following changes since commit 25962e1a7f1d522f1b57ead2f266fab570042a70:

  dmaengine: imx-sdma: Fix the event id check to include RX event for UART6=
 (2020-02-25 14:15:26 +0530)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.6

for you to fetch changes up to 018af9be3dd54e6f24f828966bdd873f4d63ad9b:

  dmaengine: ti: k3-udma-glue: Fix an error handling path in 'k3_udma_glue_=
cfg_rx_flow()' (2020-03-23 11:48:34 +0530)

----------------------------------------------------------------
dmaengine-fix-5.6

Late fixes in dmaengine for v5.6:
  - move .device_release missing log warning to debug
  - couple of maintainer entries for HiSilicon and IADX drivers
  - one off fix for idxd driver
  - documentation warn fixes
  - TI k3 dma error handling fix

----------------------------------------------------------------
Christophe JAILLET (1):
      dmaengine: ti: k3-udma-glue: Fix an error handling path in 'k3_udma_g=
lue_cfg_rx_flow()'

Dave Jiang (1):
      dmaengine: idxd: fix off by one on cdev dwq refcount

Lukas Bulwahn (1):
      MAINTAINERS: rectify the INTEL IADX DRIVER entry

Mauro Carvalho Chehab (1):
      docs: dmaengine: provider.rst: get rid of some warnings

Vinod Koul (1):
      dmaengine: move .device_release missing log warning to debug level

Zhou Wang (1):
      MAINTAINERS: Add maintainer for HiSilicon DMA engine driver

 Documentation/driver-api/dmaengine/provider.rst | 12 ++++++++--
 MAINTAINERS                                     |  7 +++++-
 drivers/dma/dmaengine.c                         |  2 +-
 drivers/dma/idxd/cdev.c                         |  4 ++--
 drivers/dma/ti/k3-udma-glue.c                   | 29 ++++++++++++++++-----=
----
 5 files changed, 38 insertions(+), 16 deletions(-)

Thanks
--=20
~Vinod

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl55nTwACgkQfBQHDyUj
g0dXORAAsWMFkBCbrjTB/SS8SgeXJ872M7LiIsysp90aDpREUIZKLi0QXcuQAcW5
As0fKb/WHgt1F/x86Xqj750wjA0/yzqXK2CcV1G2mqA5eCLNinN0QdrhYgSmBTFf
PDT3GNGBJubsC2sZjkiJyYS0MmYs1abXuorO9TeicJq+uyKQHYVknnyCDzkKml20
TE1dvpE1lwJgK7kpPJx5bb6ra28i6Dd/mn5n/vJBKzs17wFCYt2ogvWguDV+me2Z
DiG5GPzAXAVzjjgEdzDOGY9qWtLc2l1NzECaZBGNLYThdJI8RAznDl80yzSpm8zV
ESrsajI4eTEraQRRpdn7qtdk4qkFUTa2Rday0Awk+nuJB9qFMsqRsM+5e6S+F4jD
IVeAtwllWYxZqE5SZmzMvNFwAKLmh+PbChSu9X9RzGZTZ3gSstf2qCMXwUjk8Yrl
JpexrhpIwOUHEyKRYkwWHGMyeIKTn9246+uywQXHQfG+bDeTeylK9Qj4n/UcYMgU
pQE7lIXtrXR95jXIJjhO5T/Tw24zth+BOMeIKoQ8pybDYkHE3Z101diXeyrWT282
OHcC48u1W7AX17doYuWs3RI1BH00W8fO+Bk4VKSA8B+RiVYcohzKre43eNmkAJ2N
7srxXPOMj87GBJXUYxem+6nqLuSPbdkvXttAbccJtQoxfBR/zEI=
=W6bl
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
