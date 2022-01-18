Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7D492453
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiARLI2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 06:08:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40812 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiARLHu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 06:07:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7034612BF;
        Tue, 18 Jan 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49C2C00446;
        Tue, 18 Jan 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642504069;
        bh=Vx2fx+W+t3dFaXeuTvt/cA8OqgPMzwmmsPBVeorFzIc=;
        h=Date:From:To:Cc:Subject:From;
        b=IKhkE4cm7nJNqiQp42ckDeIsNmJX+rJPVBV03E4CFP2UFr7+UjU28GvCJYB8m8EXL
         JLiGqEMBlDiTNBrFhA4VWP0cJOSW7J+1imhvkhtu24u8L6LXPCRRD1AcwTJOuZqzuf
         B2ak90Lq2fAxHilgK7/T0otsbHxdsgwBTaFig3qeL5qjv/SHDWt3e3r3P1Uthv1Bsm
         qa5SFstMZdNIL0junuNYYHrDkNyM17oGCuFkXOq1DVM88RyaDAXn1nVFf9N1hM85/s
         C/VBaCoOjNRk/3hDTyZxtG6PlYf6G2usev06TiLILPs2yAZLYwjuacTBW2gktHUqCG
         mBzklrp8tJ8bg==
Date:   Tue, 18 Jan 2022 16:37:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.17-rc1
Message-ID: <YeafgZT1M7IbK8cF@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BZG0rreLBHwE8wc7"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--BZG0rreLBHwE8wc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates which contain bunch of new
support and few updates to drivers. Since some changes were dependent
upon fixes, I had to merge the fixes tag sent earlier to next, changelog
indicating so.

The following changes since commit 822c9f2b833c53fc67e8adf6f63ecc3ea24d502c:

  dmaengine: st_fdma: fix MODULE_ALIAS (2021-12-13 13:18:48 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.17-rc1

for you to fetch changes up to bbd0ff07ed12fda9dbd0cc5f239bb678a775833a:

  dt-bindings: dma-controller: Split interrupt fields in example (2022-01-0=
8 22:57:15 +0530)

----------------------------------------------------------------
dmaengine updates for v5.17-rc1

New support:
 - DMA_MEMCPY_SG support is bought back as we have a user in Xilinx driver
 - Support for TI J721S2 SoC in k3-udma driver
 - Support for Ingenic MDMA and BDMA in the JZ4760
 - Support for Renesas r8a779f0 dmac

Updates:
 - We are finally getting rid of slave_id, so this brings in the changes
   across tree for that using tag dmaengine_topic_slave_id_removal_5.17
 - updates for idxd driver
 - at_xdmac driver cleanup

----------------------------------------------------------------
Adrian Larumbe (3):
      dmaengine: Add documentation for new memcpy scatter-gather function
      dmaengine: Add core function and capability check for DMA_MEMCPY_SG
      dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.

Amelie Delaunay (1):
      dmaengine: stm32-mdma: fix STM32_MDMA_CTBR_TSEL_MASK

Arnd Bergmann (11):
      ASoC: tegra20-spdif: stop setting slave_id
      dmaengine: tegra20-apb: stop checking config->slave_id
      ASoC: dai_dma: remove slave_id field
      spi: pic32: stop setting dma_config->slave_id
      mmc: bcm2835: stop setting chan_config->slave_id
      dmaengine: shdma: remove legacy slave_id parsing
      dmaengine: pxa/mmp: stop referencing config->slave_id
      dmaengine: sprd: stop referencing config->slave_id
      dmaengine: qcom-adm: stop abusing slave_id config
      dmaengine: xilinx_dpdma: stop using slave_id field
      dmaengine: remove slave_id config field

Aswath Govindraju (2):
      dmaengine: ti: k3-udma: Add SoC dependent data for J721S2 SoC
      drivers: dma: ti: k3-psil: Add support for J721S2

Christophe JAILLET (3):
      dmaengine: ti: edma: Use 'for_each_set_bit' when possible
      dmaengine: sh: Use bitmap_zalloc() when applicable
      dmaengine: pch_dma: Remove usage of the deprecated "pci-dma-compat.h"=
 API

Colin Ian King (1):
      dmaengine: stm32-mdma: Remove redundant initialization of pointer hwd=
esc

Daniel Thompson (2):
      Documentation: dmaengine: Add a description of what dmatest does
      Documentation: dmaengine: Correctly describe dmatest with channel uns=
et

Dave Jiang (15):
      dmaengine: idxd: rework descriptor free path on failure
      dmaengine: idxd: int handle management refactoring
      dmaengine: idxd: move interrupt handle assignment
      dmaengine: idxd: add helper for per interrupt handle drain
      dmaengine: idxd: create locked version of idxd_quiesce() call
      dmaengine: idxd: handle invalid interrupt handle descriptors
      dmaengine: idxd: handle interrupt handle revoked event
      dmaengine: idxd: set defaults for wq configs
      dmaengine: idxd: add knob for enqcmds retries
      dmaengine: idxd: embed irq_entry in idxd_wq struct
      dmaengine: idxd: fix descriptor flushing locking
      dmaengine: idxd: change MSIX allocation based on per wq activation
      dmaengine: idxd: fix wq settings post wq disable
      dmaengine: idxd: change bandwidth token to read buffers
      dmaengine: idxd: deprecate token sysfs attributes for read buffers

Geert Uytterhoeven (2):
      dt-bindings: dma: snps,dw-axi-dmac: Document optional reset
      dmaengine: stm32-mdma: Use bitfield helpers

Greg Kroah-Hartman (1):
      dmaengine: ioatdma: use default_groups in kobj_type

Gustavo A. R. Silva (1):
      dmaengine: at_xdmac: Use struct_size() in devm_kzalloc()

Jason Wang (1):
      dmaengine: ppc4xx: remove unused variable `rval'

Kunihiko Hayashi (1):
      dmaengine: uniphier-xdmac: Fix type of address variables

Lars-Peter Clausen (1):
      dmaengine: xilinx: Handle IRQ mapping errors

Paul Cercueil (6):
      dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
      dt-bindings: dma: ingenic: Support #dma-cells =3D <3>
      dmaengine: jz4780: Work around hardware bug on JZ4760 SoCs
      dmaengine: jz4780: Add support for the MDMA and BDMA in the JZ4760(B)
      dmaengine: jz4780: Replace uint32_t with u32
      dmaengine: jz4780: Support bidirectional I/O on one channel

Rob Herring (4):
      dt-bindings: dma: pl08x: Fix unevaluatedProperties warnings
      dt-bindings: dma: ti: Add missing ti,k3-sci-common.yaml reference
      dt-bindings: dma: pl330: Convert to DT schema
      dt-bindings: dma-controller: Split interrupt fields in example

Tudor Ambarus (12):
      dmaengine: at_xdmac: Don't start transactions at tx_submit level
      dmaengine: at_xdmac: Start transfer for cyclic channels in issue_pend=
ing
      dmaengine: at_xdmac: Print debug message after realeasing the lock
      dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
      dmaengine: at_xdmac: Fix race for the tx desc callback
      dmaengine: at_xdmac: Move the free desc to the tail of the desc list
      dmaengine: at_xdmac: Fix concurrency over xfers_list
      dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_advanc=
e_work()
      dmaengine: at_xdmac: Fix lld view setting
      dmaengine: at_xdmac: Fix at_xdmac_lld struct definition
      dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_taskle=
t()
      dmaengine: at_xdmac: Fix race over irq_status

Vinod Koul (3):
      Merge tag 'dmaengine_topic_slave_id_removal_5.17' into next
      dmaengine: xilinx_dpdma: use correct SDPX tag for header file
      Merge branch 'fixes' into next

Xu Wang (1):
      dmaengine: qcom: gpi: Remove unnecessary print function dev_err()

Yoshihiro Shimoda (2):
      dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
      dmaengine: rcar-dmac: Add support for R-Car S4-8

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |  52 ++++-
 .../devicetree/bindings/dma/arm,pl330.yaml         |  83 +++++++
 .../devicetree/bindings/dma/arm-pl08x.yaml         |   4 +
 .../devicetree/bindings/dma/arm-pl330.txt          |  49 -----
 .../devicetree/bindings/dma/dma-controller.yaml    |   8 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |  42 ++--
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   5 +
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |   3 +
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |   1 +
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml      |   1 +
 Documentation/driver-api/dmaengine/dmatest.rst     |  17 +-
 Documentation/driver-api/dmaengine/provider.rst    |  23 ++
 drivers/dma/at_xdmac.c                             | 194 ++++++++---------
 drivers/dma/dma-jz4780.c                           | 118 +++++++---
 drivers/dma/dmaengine.c                            |   7 +
 drivers/dma/idxd/device.c                          | 222 ++++++++++++-----=
--
 drivers/dma/idxd/dma.c                             |  40 +++-
 drivers/dma/idxd/idxd.h                            |  67 ++++--
 drivers/dma/idxd/init.c                            | 196 +++--------------
 drivers/dma/idxd/irq.c                             | 239 +++++++++++++++++=
+++-
 drivers/dma/idxd/registers.h                       |  15 +-
 drivers/dma/idxd/submit.c                          |  69 +++---
 drivers/dma/idxd/sysfs.c                           | 215 ++++++++++++++----
 drivers/dma/ioat/sysfs.c                           |   3 +-
 drivers/dma/mmp_pdma.c                             |   6 -
 drivers/dma/pch_dma.c                              |   2 +-
 drivers/dma/ppc4xx/adma.c                          |   3 +-
 drivers/dma/pxa_dma.c                              |   7 -
 drivers/dma/qcom/gpi.c                             |   4 +-
 drivers/dma/qcom/qcom_adm.c                        |  56 ++++-
 drivers/dma/sh/rcar-dmac.c                         |  17 +-
 drivers/dma/sh/shdma-base.c                        |  14 +-
 drivers/dma/sprd-dma.c                             |   3 -
 drivers/dma/stm32-mdma.c                           |  78 +++----
 drivers/dma/tegra20-apb-dma.c                      |   6 -
 drivers/dma/ti/Makefile                            |   3 +-
 drivers/dma/ti/edma.c                              |   3 +-
 drivers/dma/ti/k3-psil-j721s2.c                    | 167 ++++++++++++++
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |   1 +
 drivers/dma/ti/k3-udma.c                           |   1 +
 drivers/dma/uniphier-xdmac.c                       |   5 +-
 drivers/dma/xilinx/xilinx_dma.c                    | 133 +++++++++++-
 drivers/dma/xilinx/xilinx_dpdma.c                  |  17 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |   9 +-
 drivers/mmc/host/bcm2835.c                         |   2 -
 drivers/mtd/nand/raw/qcom_nandc.c                  |  14 +-
 drivers/spi/spi-pic32.c                            |   2 -
 drivers/tty/serial/msm_serial.c                    |  15 +-
 include/linux/dma/qcom_adm.h                       |  12 ++
 include/linux/dma/xilinx_dpdma.h                   |  11 +
 include/linux/dmaengine.h                          |  24 ++-
 include/sound/dmaengine_pcm.h                      |   2 -
 include/uapi/linux/idxd.h                          |   1 +
 sound/core/pcm_dmaengine.c                         |   5 +-
 sound/soc/tegra/tegra20_spdif.c                    |   1 -
 56 files changed, 1581 insertions(+), 717 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm,pl330.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt
 create mode 100644 drivers/dma/ti/k3-psil-j721s2.c
 create mode 100644 include/linux/dma/qcom_adm.h
 create mode 100644 include/linux/dma/xilinx_dpdma.h

Thanks
--=20
~Vinod

--BZG0rreLBHwE8wc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmHmn4AACgkQfBQHDyUj
g0dgEBAAtK/rngZCRykpIYl0C9dGqzwOIUOtjU3SwOzXCUZNdp0U8bl7aFJj3TrR
9nHKtCfk0+/DjeraaxK27S3EDFlGRx8iVfk1wcBNaO4Hebcpk7Ikte7mm/rmSDT6
bS2pou0v/YGvmnd6kY2DoD5wjmSdQlzJ6RVd7nn+3mGhPQDstsJ+NDn8UGk8BpZS
dlC05qfhUARn22gAgVSb/cil33pMjhqlPtgSUepgEJMw7Eih1iDjL/Qz8AhmoR/l
k9LKW1WCRssIc6cLZiL5nDJ3OJdU8O8ZsjvpRpwsk5mqii7ZxVY8Z0lhGVWIf492
JGt5i/4+KlSbpvCUXpA2OLHn8LqhJyMzTX69ra/1dvWwflggkLe3KMpAXCNRotcy
C+ahIyeki1ZAbCTJe4EBLITHO2Wnf4KnhPCC5p3XLMEVmDX1dVjayzeGzRcso+O7
XmLbpxMfTbHrKStjajERcn0D9xtwTFPZu8xZb8Cq37D1o6skwtxuNjNUUXpC8G9O
X5qYl3R1maE9/uu8Q0jt0FuGBvEPxpFmf6YUcpOidZcgJA19JJYbISsbXGdXkR6z
iva2ar52GfwQ8n1f5jhKkBOGjnm9+oovcV/NxBBKB6S7Cr0FQp38I0PnD28kwoRr
cTCI+6JVDUammvqiudsUwgNSczMAPOHXVECL6XuSCfLn40Wm9NY=
=trmO
-----END PGP SIGNATURE-----

--BZG0rreLBHwE8wc7--
