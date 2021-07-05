Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935473BBD7A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jul 2021 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGENcE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Jul 2021 09:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGENcE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Jul 2021 09:32:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A942861376;
        Mon,  5 Jul 2021 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625491767;
        bh=9S3ZvOTf49yCGvZ6lL6Y2sz7nhvlfqmFceEOZmIIkzw=;
        h=Date:From:To:Cc:Subject:From;
        b=U+vt1/n9Db8b1J6pbRXu8GhSaAiPe1bcVF6dfgiuVFL8djcuhicRpcgRnqbfVhPsC
         QdrW8QtAu5qskKgoGy/PGPyKmswR55u6JSwlvFZDamfD2UQHx6BSKqxLd3/Qgao6Ha
         uYxtUFhG6uPcwpgSknriXNCF2Md2kRBz7qb/QaH3OQk/+qMstZdq9rdiDvogvGasbq
         2JKNDxdV4XiH/LlWTn3hsrhOnF5MoTRZtsk81Vx4cxS9j5SqK6TbuO25bB0v50clj0
         u+0akaJDZ6Ge21CuORSjH+luZppwcKi/8I2VdIbrwZcTJrDvu/K2YO6it/Ahuda5Yc
         z2RjfOEX+U6tg==
Date:   Mon, 5 Jul 2021 18:59:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.14-rc1
Message-ID: <YOMJM1UjXOsbtIDe@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhApdVrgjPoJ8yOe"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--mhApdVrgjPoJ8yOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

This time around we have a smaller pull request than usual and this
includes code removal, so should be good!

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.14-rc1

for you to fetch changes up to 8d11cfb0c37547bd6b1cdc7c2653c1e6b5ec5abb:

  dmaengine: imx-sdma: Remove platform data header (2021-06-24 16:44:38 +05=
30)

----------------------------------------------------------------
dmaengine updates for v5.14-rc1

New drivers/devices
 - Support for QCOM SM8250 GPI DMA
 - removal of shdma-of driver and binding

Updates:
 - arm-pl08x yaml binding move
 - altera-msgdma gained DT support
 - removal of imx-sdma platform data support
 - idxd and xilinx driver updates

----------------------------------------------------------------
Andy Shevchenko (2):
      dmaengine: Move kdoc description of struct dma_chan_percpu closer to =
it
      dmaengine: hsu: Account transferred bytes

Austin Kim (1):
      dmaengine: sf-pdma: apply proper spinlock flags in sf_pdma_prep_dma_m=
emcpy()

Corentin Labbe (1):
      dt-bindings: dma: convert arm-pl08x to yaml

Dave Jiang (1):
      dmaengine: idxd: remove devm allocation for idxd->int_handles

Geert Uytterhoeven (2):
      dt-bindings: dmaengine: Remove SHDMA Device Tree bindings
      dmaengine: sh: Remove unused shdma-of driver

Jiapeng Chong (1):
      dmaengine: idxd: Remove redundant variable cdev_ctx

Konrad Dybcio (2):
      dt-bindings: dmaengine: qcom: gpi: add compatible for sm8250
      dmaengine: qcom: gpi: Add SM8250 compatible

Laurent Pinchart (2):
      dmaengine: xilinx: dpdma: Print channel number in kernel log messages
      dmaengine: xilinx: dpdma: Print debug message when losing vsync race

Michal Simek (2):
      dmaengine: xilinx: dpdma: Use kernel type u32 over uint32_t
      dmaengine: xilinx: dpdma: Fix spacing around addr[i-1]

Olivier Dautricourt (3):
      dt-bindings: dma: add schema for altera-msgdma
      MAINTAINERS: add entry for Altera mSGDMA
      dmaengine: altera-msgdma: add OF support

Robin Gong (1):
      dmaengine: fsl-qdma: check dma_set_mask return value

Tony Lindgren (1):
      dmaengine: ti: omap-dma: Skip pointless cpu_pm context restore on err=
ors

Vladimir Zapolskiy (1):
      dmaengine: imx-sdma: Remove platform data header

Yang Li (1):
      dmaengine: xilinx: dpdma: fix kernel-doc

Zou Wei (1):
      dmaengine: sun4i: Use list_move_tail instead of list_del/list_add_tail

 .../devicetree/bindings/dma/altr,msgdma.yaml       |  61 +++++++++
 .../devicetree/bindings/dma/arm-pl08x.txt          |  59 ---------
 .../devicetree/bindings/dma/arm-pl08x.yaml         | 136 +++++++++++++++++=
++++
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 .../devicetree/bindings/dma/renesas,shdma.txt      |  84 -------------
 MAINTAINERS                                        |   8 ++
 drivers/dma/altera-msgdma.c                        |  20 +++
 drivers/dma/fsl-qdma.c                             |   6 +-
 drivers/dma/hsu/hsu.c                              |   3 +
 drivers/dma/idxd/cdev.c                            |   2 -
 drivers/dma/idxd/init.c                            |   3 +-
 drivers/dma/imx-sdma.c                             |  56 ++++++++-
 drivers/dma/qcom/gpi.c                             |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                      |   5 +-
 drivers/dma/sh/Makefile                            |   2 +-
 drivers/dma/sh/shdma-of.c                          |  76 ------------
 drivers/dma/sun4i-dma.c                            |   5 +-
 drivers/dma/ti/omap-dma.c                          |   3 +-
 drivers/dma/xilinx/xilinx_dpdma.c                  |  44 ++++---
 include/linux/dmaengine.h                          |  11 +-
 include/linux/platform_data/dma-imx-sdma.h         |  60 ---------
 21 files changed, 333 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,shdma.txt
 delete mode 100644 drivers/dma/sh/shdma-of.c
 delete mode 100644 include/linux/platform_data/dma-imx-sdma.h

Thanks
--=20
~Vinod

--mhApdVrgjPoJ8yOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmDjCTMACgkQfBQHDyUj
g0frVxAAua5p28hNLM4jlvtGMX3F5COoYq4KBxbXHyMyZAsD/N1aXi9FKd0SWJUU
Op1hnQ33oMGgIcOjRGbbsZv+dC6Ku0PyRnEJgQC01n5ebfhHBj8rItlEU2Ysyrc+
7iWd4ueMPfmZi3V/hP12OQqeBr+ZFmGoMJBioRFeXKwR/WSiSpvcgBveXNhdo5hd
SbeAwGfDKGT2k8p6jxjx0WP3ib349oxtrKLTEPqV6uYomAo594dHrNUe6ElC3kF2
wWnb/rKS4DRsztyR0I1FGvavnsDGLD9KYPUhIfTbHMs8k3oW3yzbXzr2Pqs2ACXM
+euftEqQZ+dB8XvVhuRfBYhkyLtwqkDgebxveWyixguqGnwtTGNu/41ElH/BGoUF
fvMQ53fIwyoPAY2X+g45po2aCeupWYahVbDUX1vCNjYhqUU6j3UkhSlWZqxMTxna
+cQSAslsyfWzK+7XRUxsdAEHK5OfNKh2iSWw/m21K1h00a0de9GLOSJlXEnY5ssE
mpWCN++tXNlgMTfEdOICWbyV+agGN+T+QX2vQ8YYy7mV9S8kJZYxPzCCTLt8hfuF
yrgaj/UzScOA0l9Kk3axcjXugp+NRJSCLEgRP0uwRcErrRo3ea0xmdNh73VkAoCQ
QtkuMJhqvLTB3meXaYy/IUX2l2rkMdH2DCM1/EjAS95PHVVp0Gw=
=BLbi
-----END PGP SIGNATURE-----

--mhApdVrgjPoJ8yOe--
