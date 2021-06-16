Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED1A3A9B56
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhFPNB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 09:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhFPNB7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 09:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C3386135C;
        Wed, 16 Jun 2021 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623848393;
        bh=MeDLpTIC/OyeDClsFEbjeW6RyqDjdiLOmvB+LiUp3qA=;
        h=Date:From:To:Cc:Subject:From;
        b=oFObymhq1pLCGNkleEPKLlj3RnngFik249k3OMUA08Z7m+IJeiOyE0cjg1Ybb13Hu
         LCZVaW+VDNQcg/NYas7E/hcIM/trFLBCsxsIHiBUzUAdzi3SaVqBCTWi7AVXxLeKbc
         Bhv+ql45h4tdgUMIOyeTx02jhfi64KoFR8uzf9mb4EfKrfOCo+rd3c8+aD0YSGhVVT
         SBCu1+2DjRxrpO/doFQF3E67qrNxQkttwVXMCggMyP0XbqD2AzjU6D/aUy1hqLKqvo
         vkgOra4IRiExBfmN3TU99f6o0JH4ZazLwH6sN8lOkQcklN6OIpE8qpa5AaEvPLGvUW
         5GNGN9XqC/NGQ==
Date:   Wed, 16 Jun 2021 18:29:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.13
Message-ID: <YMn1xTAqhOUI5sle@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KSE0lpjpp8E196Wp"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--KSE0lpjpp8E196Wp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the fixes for dmaengine subsystem for v5.13

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.13

for you to fetch changes up to 9041575348b21ade1fb74d790f1aac85d68198c7:

  dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma (20=
21-06-07 12:23:47 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.13

Bunch of driver fixes, notably:
- More idxd fixes for driver unregister, error handling and bus
  assignment
- HAS_IOMEM depends fix for few drivers
- lock fix in pl330 driver
- xilinx drivers fixes for initialize registers, missing dependencies
  and limiting descriptor IDs
- mediatek descriptor management fixes

----------------------------------------------------------------
Bumyong Lee (1):
      dmaengine: pl330: fix wrong usage of spinlock flags in dma_cyclc

Dave Jiang (3):
      dmaengine: idxd: add engine 'struct device' missing bus type assignme=
nt
      dmaengine: idxd: add missing dsa driver unregister
      dmaengine: idxd: Add missing cleanup for early error out in probe call

Guillaume Ranquet (3):
      dmaengine: mediatek: free the proper desc in desc_free handler
      dmaengine: mediatek: do not issue a new desc if one is still current
      dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma

Jiapeng Chong (1):
      dmaengine: idxd: Fix missing error code in idxd_cdev_open()

Laurent Pinchart (2):
      dmaengine: xilinx: dpdma: Add missing dependencies to Kconfig
      dmaengine: xilinx: dpdma: Limit descriptor IDs to 16 bits

Quanyang Wang (1):
      dmaengine: xilinx: dpdma: initialize registers before request_irq

Randy Dunlap (3):
      dmaengine: ALTERA_MSGDMA depends on HAS_IOMEM
      dmaengine: QCOM_HIDMA_MGMT depends on HAS_IOMEM
      dmaengine: SF_PDMA depends on HAS_IOMEM

Yang Yingliang (2):
      dmaengine: stedma40: add missing iounmap() on error in d40_probe()
      dmaengine: ipu: fix doc warning in ipu_irq.c

Yu Kuai (2):
      dmaengine: zynqmp_dma: Fix PM reference leak in zynqmp_dma_alloc_chan=
_resourc()
      dmaengine: stm32-mdma: fix PM reference leak in stm32_mdma_alloc_chan=
_resourc()

Zhen Lei (1):
      dmaengine: fsl-dpaa2-qdma: Fix error return code in two functions

Zou Wei (1):
      dmaengine: rcar-dmac: Fix PM reference leak in rcar_dmac_probe()

 drivers/dma/Kconfig                     |  2 ++
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  3 ++
 drivers/dma/idxd/cdev.c                 |  1 +
 drivers/dma/idxd/init.c                 | 63 +++++++++++++++++++++++++++++=
++--
 drivers/dma/ipu/ipu_irq.c               |  2 +-
 drivers/dma/mediatek/mtk-uart-apdma.c   | 27 +++++++-------
 drivers/dma/pl330.c                     |  6 ++--
 drivers/dma/qcom/Kconfig                |  1 +
 drivers/dma/sf-pdma/Kconfig             |  1 +
 drivers/dma/sh/rcar-dmac.c              |  2 +-
 drivers/dma/ste_dma40.c                 |  3 ++
 drivers/dma/stm32-mdma.c                |  4 +--
 drivers/dma/xilinx/xilinx_dpdma.c       | 31 ++++++++++++++--
 drivers/dma/xilinx/zynqmp_dma.c         |  2 +-
 14 files changed, 122 insertions(+), 26 deletions(-)

--=20
~Vinod

--KSE0lpjpp8E196Wp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmDJ9cUACgkQfBQHDyUj
g0fGag/8Cay29G/Wm3ea9gv6wD9RFp/4O8BTyZWeGwfZNlZXlhcEyUzm9JbAGaTg
PyKJ03LhQVSadCUw5sPnhyxXAW0CHAmb2QioED14uwwyYZ2+/cDEeAy7wJJ+1QJ+
4mpVNDNZMfPWoH2mQ5Ppd1PXKrmw8Y5FfKz2Iv9YpuKdWPhh3b/zAkBIHiJRFmPy
bINGgx1MR547UzmkSqbtvwQ4Qr/SdAdBySKJ5JOVERr3kZrTF10t+0ezvgSW8izy
KFHxOqKRQM/UYbt0bVSLeiiAV2jvzCjof1BjBJXyPrUZ8CtYrnXYlD3KvVKODdOf
iYrPa/BEqUyBCPwWishaKwkhQMtEPp7CCAic/ecKvEyulyXp/MTDYxayT/wH5qxe
JNieEneuZFp51r5YC2yFgJVlFgDDhkNnTzlrRWKjfava9CvmZjDlj9Zc7eSwxGBr
9LpcHO+dNHz0qsEva1LYFpZNh9o9UE9N43Y9+qZjf93CQ6DVmLR3pK5jwGV0+ZhG
K9dg4yTO+cHbllPoePGdL9oRNHQSygETLcP2wbpey0G5QTBwWXB1CfmF7u7/Ipu9
V6+AcuIp3pi2dGCi5uoV/ihVrbvRqwkeD2t2FJhn7YsgIvR4pIZgO2F7s4na7lJb
vecJQyhwJe4qFIB427aL3QgulJZSItYlK/hzFEj+JFzwTkpSoE8=
=CGQo
-----END PGP SIGNATURE-----

--KSE0lpjpp8E196Wp--
