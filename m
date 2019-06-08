Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2539C05
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2019 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFHJMd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 Jun 2019 05:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfFHJMd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 8 Jun 2019 05:12:33 -0400
Received: from localhost (unknown [106.200.229.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA954206E0;
        Sat,  8 Jun 2019 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559985152;
        bh=+dfOuCygM4XWeeIt+7I1WNiQHNRsX6McvspPEEKD0tQ=;
        h=Date:From:To:Cc:Subject:From;
        b=gTK1m1t1hpgJfSOsHJhw9jxnTsQ6inJpQIWW5Ku+Mb6K6H6pIAG2H0W+aLdYnxdcp
         qhxpQPnbUoLm+oNPy1RwFDUwbuky2fqmnoW2gDftPfYtKxfu4nDGi7/P14wrehzva3
         Pk5mfG/So68FyZfFj1KN6NB1NgYoyGioIQNRMCLA=
Date:   Sat, 8 Jun 2019 14:39:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.2-rc4
Message-ID: <20190608090908.GE9160@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive dmaengine fixes. These fixes are on drivers.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.2-=
rc4

for you to fetch changes up to 9bb9fe0cfbe0aa72fed906ade0590e1702815e5d:

  dmaengine: sprd: Add interrupt support for 2-stage transfer (2019-05-21 1=
9:23:54 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.2-rc4

The fixes for this round are in drivers:
 - jz4780 transfer fix for acking descriptors early
 - fsl-qdma: clean registers on error
 - dw-axi-dmac: null pointer dereference fix
 - mediatek-cqdma: fix sleeping in atomic context
 - tegra210-adma: fix bunch os issues like crashing in driver
   probe, channel FIFO configuration etc.
 - sprd: Fixes for possible crash on descriptor status, block
   length overflow. For 2-stage transfer fix incorrect start,
   configuration and interrupt handling.

----------------------------------------------------------------
Baolin Wang (3):
      dmaengine: sprd: Fix the possible crash when getting descriptor status
      dmaengine: sprd: Add validation of current descriptor in irq handler
      dmaengine: sprd: Add interrupt support for 2-stage transfer

Colin Ian King (1):
      dmaengine: dw-axi-dmac: fix null dereference when pointer first is nu=
ll

Dan Carpenter (1):
      dmaengine: mediatek-cqdma: sleeping in atomic context

Eric Long (3):
      dmaengine: sprd: Fix the incorrect start for 2-stage destination chan=
nels
      dmaengine: sprd: Fix block length overflow
      dmaengine: sprd: Fix the right place to configure 2-stage transfer

Jon Hunter (3):
      dmaengine: tegra210-adma: Fix crash during probe
      dmaengine: tegra210-adma: Fix channel FIFO configuration
      dmaengine: tegra210-adma: Fix spelling

Paul Cercueil (1):
      dmaengine: jz4780: Fix transfers being ACKed too soon

Peng Ma (1):
      dmaengine: fsl-qdma: Add improvement

 drivers/dma/dma-jz4780.c                       | 32 ++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  3 +-
 drivers/dma/fsl-qdma.c                         |  4 +-
 drivers/dma/mediatek/mtk-cqdma.c               |  4 +-
 drivers/dma/sprd-dma.c                         | 49 +++++++++++++++++-----
 drivers/dma/tegra210-adma.c                    | 57 ++++++++++++++++------=
----
 6 files changed, 100 insertions(+), 49 deletions(-)

Thanks
--=20
~Vinod

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc+3s0AAoJEHwUBw8lI4NHSiAQAIV8eF0ELY3XJTbXfd4vttgU
QzWJRogJgIN82F29IvWz2EjfrI9t6rHo9Jq7qiSlLUDFfNrFw3XXIS5bcswgIFX2
MuOatTXtYl8eROLlg8SD1DL+uRJWzAtuRIFezESSclmnryViDgazQUQr559G8XqQ
zzcyjs5vbnpE5+zpltUK856bcRg72oj6fb7nZyZYXa1FlzzJDOagjwsZsGJVWwfU
o6mnlM224t8gZnvhx5Ih7seBDi6Q9DMCKrbr6xs6Jxe+/coIXdDuDC/KZkoUrqYf
OvV+GPiZ4D+k/hhYveYwW/e5DfFmNCWUy3PIGojk4urGHt1ShmFzelepkKvbgs1A
2yrEMwj3xKtB5y3Ic5ykXXfGsIoPActfswOyYcFrTWsClFSVkd8dd+M9Vp5SOnQI
Mc6KXy3RByKL8XifXHusOQeA3qSsODhwcChuP9ZRjyaK5zs5cU/7ExrwftRvZRZU
azpsZ+Or+Obc64l2sokPFs0fJpb5XvmJ/Ea7thmR/TWqwkRV1JFaUR6fh27c3cEW
tvkG8RQ+XXPmeZHHRYHLfZnU5wlFHEuDu8raeXLCf9+n/MAbt5SW5+mQEQB3waUi
A3ZT9hxtPFjzonXfLeoTsNgTYUgTjXeF4pakltJQcvNzhAhoUwOc9MJ2cyEmkq9j
6NsT1Wnm9phCfte/tDWo
=6WFh
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
