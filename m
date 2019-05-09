Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5604918656
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2019 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEIHqW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 May 2019 03:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfEIHqW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 May 2019 03:46:22 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1907208C3;
        Thu,  9 May 2019 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557387980;
        bh=KtcjRZP4ucm527TvlD27ppwZGdEIAwlIHfU35QQ0cDw=;
        h=Date:From:To:Cc:Subject:From;
        b=th5eLfIda6Lrjes/LRLw7hScvlDhR110tr/U2Wl37eS5CTUBBx+MSz4XNCJpaxa3H
         68OECXZiLQK39nYDA2ylG8E2YCoMXCw+JJhmvI6ihqV+up8uN5qBYZ6hCt1nrEd88R
         EmZneXYSacytReywETVDH9XAKT4fbwG6iANIomgs=
Date:   Thu, 9 May 2019 13:16:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.2-rc1
Message-ID: <20190509074615.GB16052@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the updates to dmaengine subsystem for v5.2-rc1. Please pull to
get following updates:

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.2-rc1

for you to fetch changes up to f33e7bb3eb922618612a90f0a828c790e8880773:

  dmaengine: tegra210-adma: restore channel status (2019-05-04 16:13:42 +05=
30)

----------------------------------------------------------------
dmaengine updates for v5.2-rc1

 - Updates to stm32 dma residue calculations
 - Interleave dma capability to axi-dmac and
   support for ZynqMP arch
 - Rework of channel assignment for rcar dma
 - Debugfs for pl330 driver
 - Support for Tegra186/Tegra194, refactoring for new chips
   and support for pause/resume
 - Updates to axi-dmac, bcm2835, fsl-edma, idma64, imx-sdma,
   rcar-dmac, stm32-dma etc
 - dev_get_drvdata() updates on few drivers

----------------------------------------------------------------
Alexandru Ardelean (1):
      dmaengine: axi-dmac: Don't check the number of frames for alignment

Andy Shevchenko (2):
      dmaengine: idma64: Use actual device for DMA transfers
      dmaengine: idma64: Move driver name to the header

Angus Ainslie (Purism) (1):
      dmaengine: imx-sdma: Only check ratio on parts that support 1:1

Arnaud Pouliquen (1):
      dmaengine: stm32-dma: fix residue calculation in stm32-dma

Colin Ian King (1):
      dmaengine: xgene-dma: fix spelling mistake "descripto" -> "descriptor"

Dan Carpenter (1):
      dmaengine: at_xdmac: remove a stray bottom half unlock

Dragos Bogdan (1):
      dmaengine: axi-dmac: Enable DMA_INTERLEAVE capability

Fabien Dessenne (1):
      dmaengine: stm32-dma: use platform_get_irq()

Hiroyuki Yokoyama (1):
      dmaengine: rcar-dmac: Update copyright information

Jean-Nicolas Graux (1):
      dmaengine: pl08x: be fair when re-assigning physical channel

Jeff Xie (1):
      dmaengine: xgene-dma: move spin_lock_bh to spin_lock in tasklet

Katsuhiro Suzuki (1):
      dmaengine: pl330: introduce debugfs interface

Kefeng Wang (2):
      dmaengine: bcm-sba-raid: Use dev_get_drvdata()
      dmaengine: nbpfaxi: Use dev_get_drvdata()

Krzysztof Kozlowski (2):
      dmaengine: fsl-edma: Fix typo in Vybrid name
      dmaengine: fsl-edma: Adjust indentation

Lars-Peter Clausen (2):
      dmaengine: axi-dmac: Split too large segments
      dmaengine: axi-dmac: Infer synthesis configuration parameters hardware

Michael Hennerich (1):
      dmaengine: axi-dmac: extend support for ZynqMP arch

Michal Suchanek (1):
      dmaengine: bcm2835: Drop duplicate capability setting.

Nicolas Ferre (3):
      dmaengine: at_xdmac: remove BUG_ON macro in tasklet
      dmaengine: at_xdmac: enhance channel errors handling in tasklet
      dmaengine: at_xdmac: only monitor overflow errors for peripheral xfer

Sameer Pujar (8):
      dmaengine: tegra210-adma: use devm_clk_*() helpers
      dmaengine: tegra210-adma: update system sleep callbacks
      dmaengine: tegra210-adma: prepare for supporting newer Tegra chips
      Documentation: DT: Add compatibility binding for Tegra186
      dmaengine: tegra210-adma: add support for Tegra186/Tegra194
      dmaengine: tegra210-adma: add pause/resume support
      dmaengine: tegra210-dma: free dma controller in remove()
      dmaengine: tegra210-adma: restore channel status

Sugar Zhang (1):
      dmaengine: pl330: _stop: clear interrupt status

Vinod Koul (1):
      dmaengine: stm32-dma: Fix unsigned variable compared with zero

 .../devicetree/bindings/dma/adi,axi-dmac.txt       |   4 +-
 .../bindings/dma/nvidia,tegra210-adma.txt          |   4 +-
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/amba-pl08x.c                           |  22 +-
 drivers/dma/at_xdmac.c                             |  67 ++++-
 drivers/dma/bcm-sba-raid.c                         |   3 +-
 drivers/dma/bcm2835-dma.c                          |   1 -
 drivers/dma/dma-axi-dmac.c                         | 116 ++++++---
 drivers/dma/fsl-edma-common.h                      |   2 +-
 drivers/dma/fsl-edma.c                             |   6 +-
 drivers/dma/idma64.c                               |  15 +-
 drivers/dma/idma64.h                               |   2 +
 drivers/dma/imx-sdma.c                             |  15 +-
 drivers/dma/nbpfaxi.c                              |   4 +-
 drivers/dma/pl330.c                                |  61 ++++-
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/dma/stm32-dma.c                            | 103 ++++++--
 drivers/dma/tegra210-adma.c                        | 269 ++++++++++++++++-=
----
 drivers/dma/xgene-dma.c                            |   6 +-
 drivers/mfd/intel-lpss.c                           |   4 +-
 drivers/spi/spi-pxa2xx.c                           |   7 +-
 drivers/tty/serial/8250/8250_dw.c                  |   4 +-
 include/linux/dma/idma64.h                         |  14 ++
 23 files changed, 566 insertions(+), 169 deletions(-)
 create mode 100644 include/linux/dma/idma64.h

Thanks
--=20
~Vinod

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc09rHAAoJEHwUBw8lI4NHifkP/1g+an09RrQmVnUxWz9emBO9
Ea0i1xQYF7zg8p7MblRC3yQNBuphJ9Qhd51GlOHR/uy+4JP0Llg4RfAh4WhuVLCJ
GlLk3BHwI2jb9okfe5dBFP09RRdG/XarBp5nl9qqcRIfyXg8iwADwBBvEabaXT1L
vkvjyRpH6uGHRiTmP6ZPB1pRTF4OoiyJWLc4g2i40Xn0NMRGrMNUHYuTOHq7aDJO
MK+WbCgL6KJFlPHnJt1rRCtp7EdY092pFNhyw79BMXE5uvwWnxihDB+ylf+eHgLL
8mfnBYlUnKPkIPwGiaNb/uv9xKfXejN41ZK0FhC4GjkKU2tbwKAAJduVyLccwq9v
KcrYcCvwyBXpAOlfWxNZ+97jQBqL4iG7fMq0OUViv96HXJNXc8ynu6r495rPX69I
b/ZgJ5FmXkkR2Fl/wiE9Jdr6q83ASHNvaV+LXDHTsIj8OYxod+Z+qVBs31iUNlXL
wHxVcn61edvfRZp4EOD+/dgEPCsNfRWOTmTCSdjlyj0fwr2qs40WjAOXC5f1uOHu
QwetmVNvKg3d5WURUH89SDb+Xh/7DaLzkkgbyMqlBQDu+OHOTrJva2ekZczdIpIY
CGdplxGz7tVD01JeswoRkBYyeuIXi9bjp6Eyda/qLfHL0ybAC2z00Y8HTFKYTE0U
vF9uXW6yL7DAqfMmEOBq
=WatB
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
