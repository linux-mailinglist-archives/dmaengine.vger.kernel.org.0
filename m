Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAF1F3A1E
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgFILyX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 07:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFILyV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 07:54:21 -0400
Received: from localhost (unknown [122.171.156.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4823B2078C;
        Tue,  9 Jun 2020 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591703660;
        bh=knQypo/H7OW2GERNn0JI6gYkVB3uPnwjPjakhxiatFs=;
        h=Date:From:To:Cc:Subject:From;
        b=Y3dYv9YC4+bDCIv7LZ5/TvOFs3tckVwqvdQfeaX+aebwFq0MScGWaxaB1WSrdsbgP
         ZaCQ9ft7ovceBpCTSNjscA2SL5MTOJvIXSNunmgguYwnJtZaToe2DPkQS6iiv6xw+K
         BUUxJqQSGKKamww+SKTj3E8tkb3rPr8qEAvKYhC8=
Date:   Tue, 9 Jun 2020 17:24:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.8-rc1
Message-ID: <20200609115416.GC1084979@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive fairly small dmaengine updates which include
mostly driver updates for drivers in this round.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.8-rc1

for you to fetch changes up to be4cf718cd9929e867ed1ff06d23fb4d08cc2d36:

  dmaengine: imx-sdma: initialize all script addresses (2020-05-15 12:31:06=
 +0530)

----------------------------------------------------------------
dmaengine updates for v5.8-rc1

	Bunch of updates to drivers like dmatest, dw-edma, ioat,
mmp-tdma and k3-udma along with Renesas binding update to json-schema

----------------------------------------------------------------
Alan Mikhak (3):
      dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
      dmaengine: dw-edma: Check MSI descriptor before copying
      dmaengine: dw-edma: support local dma device transfer semantics

Amelie Delaunay (2):
      dt-bindings: dma: add direct mode support through device tree in stm3=
2-dma
      dmaengine: stm32-dma: direct mode support through device tree

Andy Shevchenko (6):
      Revert "dmaengine: dmatest: timeout value of -1 should specify infini=
te wait"
      dmaengine: dmatest: Allow negative timeout value to specify infinite =
wait
      dmaengine: dmatest: Describe members of struct dmatest_params
      dmaengine: dmatest: Describe members of struct dmatest_info
      dmaengine: Include dmaengine.h into dmaengine.c
      dmaengine: Fix doc strings to satisfy validation script

Christophe JAILLET (2):
      dmaengine: qcom_hidma: Simplify error handling path in hidma_probe
      dmaengine: sf-pdma: Simplify the error handling path in 'sf_pdma_prob=
e()'

Dave Jiang (1):
      dmaengine: idxd: export hw version through sysfs

Geert Uytterhoeven (1):
      dmaengine: Fix misspelling of "Analog Devices"

Gustavo A. R. Silva (3):
      dmaengine: qcom: bam_dma: Replace zero-length array with flexible-arr=
ay
      dmaengine: at_hdmac: Replace zero-length array with flexible-array
      dmaengine: at_xdmac: Replace zero-length array with flexible-array

Jason Yan (1):
      dmaengine: qcom_hidma: use true,false for bool variable

Leonid Ravich (5):
      dmaengine: ioat: fixing chunk sizing macros dependency
      dmaengine: ioat: Decreasing allocation chunk size 2M->512K
      dmaengine: ioat: removing duplicate code from timeout handler
      dmaengine: ioat: remove unnesesery double complition timer modificati=
on.
      dmaengine: ioat: adding missed issue_pending to timeout handler

Lubomir Rintel (5):
      dmaengine: mmp_tdma: Drop "mmp_tdma: from error messages
      dmaengine: mmp_tdma: Log an error if channel is in wrong state
      dmaengine: mmp_tdma: Fill in slave capabilities
      dmaengine: mmp_tdma: Remove the MMP_SRAM dependency
      dmaengine: mmp_tdma: Validate the transfer direction

Peter Ujfalusi (5):
      dmaengine: ti: k3-udma: Drop COMPILE_TEST for the drivers for now
      dmaengine: ti: k3-udma: Disable memcopy via MCU NAVSS on am654
      dmaengine: ti: k3-udma: Add missing dma_sync call for rx flush descri=
ptor
      dmaengine: ti: k3-udma: Remove udma_chan.in_ring_cnt
      dmaengine: ti: k3-udma: Use proper return code in alloc_chan_resources

Samuel Zou (1):
      dmaengine: ti: k3-udma: Use PTR_ERR_OR_ZERO() to simplify code

Sascha Hauer (1):
      dmaengine: imx-sdma: initialize all script addresses

Yoshihiro Shimoda (2):
      dt-bindings: dma: renesas,rcar-dmac: convert bindings to json-schema
      dt-bindings: dma: renesas,usb-dmac: convert bindings to json-schema

YueHaibing (1):
      dmaengine: moxart-dma: Drop pointless static qualifier in moxart_prob=
e()

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   6 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  | 117 ----------------
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml | 150 +++++++++++++++++=
++++
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |  55 --------
 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  | 102 ++++++++++++++
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   5 +
 drivers/dma/Kconfig                                |   4 +-
 drivers/dma/at_hdmac_regs.h                        |   2 +-
 drivers/dma/at_xdmac.c                             |   2 +-
 drivers/dma/dmaengine.c                            |  98 +++++++-------
 drivers/dma/dmatest.c                              |  24 ++--
 drivers/dma/dw-edma/dw-edma-core.c                 |  65 ++++++---
 drivers/dma/dw-edma/dw-edma-core.h                 |   4 +
 drivers/dma/dw-edma/dw-edma-pcie.c                 |  10 ++
 drivers/dma/idxd/sysfs.c                           |  11 ++
 drivers/dma/imx-sdma.c                             |   2 +-
 drivers/dma/ioat/dma.c                             |  85 +++++++-----
 drivers/dma/ioat/dma.h                             |  10 +-
 drivers/dma/ioat/init.c                            |   2 +-
 drivers/dma/mmp_tdma.c                             |  26 +++-
 drivers/dma/moxart-dma.c                           |   2 +-
 drivers/dma/qcom/bam_dma.c                         |   2 +-
 drivers/dma/qcom/hidma.c                           |   3 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |  25 +---
 drivers/dma/stm32-dma.c                            |  41 ++++--
 drivers/dma/ti/Kconfig                             |   4 +-
 drivers/dma/ti/k3-udma.c                           |  34 ++---
 27 files changed, 535 insertions(+), 356 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac=
=2Eyaml
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.=
txt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.=
yaml

--=20
~Vinod

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl7feGAACgkQfBQHDyUj
g0cPmhAAllVt68+KhGxspkoDJs2kKNkIGHb6vHOa54/dPhlqYg9aQpfVvNkLX91J
TShAItsQcrcpOE+lVgAYk3kPn01btJQG9Fn3q+jXbR2ivP1D70Xq6gP+EFvDukJY
57oA9YMVbD2bVi/awwHvenDwk/oCxPoJCJmrqBKD1Tanqve0gvARJxoiqNyz7c9B
xb1wVkhJNel5U6t+zKPXk71ihOA/CkwvET2F7g37XkbnEfaR5c56k9cj37zL8K26
yNplHs6nEmNswEGQLSWXtQ94dEuzSEeoOc1ytxDAT/+3N4khLRZZ6vfAWeOnOAS9
s0hAxd/V19+4rN2qYYrxG8HSs91gZT6hAlfvTqBpN74wbhyqGOuaSeOx8gpPV4se
aMQzoROWD2zOxcVdwoXTwqwFs+twH5gaAaDJIkznDLQRq7LSwZctxliX9AqiOmdW
/HjH2TUygCX+rp7ayuHKia0Aze3hiGGy3m6Twc89wqDtB9WaZngpMtotePg93j8J
7YhBVhSHB33TYCTER1oAEDu2NTtJV5kUr39NFsWoMdSQ/e3Fv/WDt/16BqEklslB
j1SXFNAlJanlnR+DjYd5ZHhggBX+KdS7oWgifL+fCqX0gmtPtGh9ko9uLFOFiWIk
ohNXV2KaPFIvNVi7RYIwT2+a7D/b4X/WqagR9zQlSSGUV4ajQp4=
=eyuu
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
