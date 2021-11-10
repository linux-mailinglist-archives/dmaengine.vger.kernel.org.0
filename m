Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B444C0C0
	for <lists+dmaengine@lfdr.de>; Wed, 10 Nov 2021 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhKJMJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Nov 2021 07:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhKJMIS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Nov 2021 07:08:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64AC4611ED;
        Wed, 10 Nov 2021 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636545931;
        bh=JzIbMq+7kunI5DNdzU02uwvqlI184e8UlvxT6Wtvzlw=;
        h=Date:From:To:Cc:Subject:From;
        b=B28j495gxqjHX4UfKE4GvmqSdEJqXintNPmWBf149xPvkXN1JfQCcF6kWrkbrMHMo
         5vWGliCZ/jLHnXqqZ9MsCYwvlqaT8jhmTXQVdUkji5+hxfVFf6GTsdeIHUzUEiTaY1
         B1V+2kFRIc67mGkGS915dQyPK37St4Nb71H2jR+YzBM6wqgXD0epUSEyrgvEGuvGsx
         +MXT8natMOCbFHJ2HvUAbc7GqVKrNm+W6cWazvUPnX2j1ID4CkOWjuF9QHvr1e0Syo
         3fLrdxeSMy/5zTSlRTxtQukvz9HP0mIRYQTiICLm5QFwT1Q1yCKW5YLotDRR5YotWy
         Q4aBoJjsApGIg==
Date:   Wed, 10 Nov 2021 17:35:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.16-rc1
Message-ID: <YYu1huhCBnGJUPZg@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55uKwjtuR0hH29Lc"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--55uKwjtuR0hH29Lc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine update. Bunch of driver updates, no
new driver or controller support this time though!

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.16-rc1

for you to fetch changes up to eb91224e47ec33a0a32c9be0ec0fcb3433e555fd:

  dmaengine: ti: k3-udma: Set r/tchan or rflow to NULL if request fail (202=
1-11-09 11:24:06 +0530)

----------------------------------------------------------------
dmaengine updates for v5.16-rc1

Updates:
 - Another pile of idxd updates
 - pm routines cleanup for at_xdmac driver
 - Correct handling of callback_result for few drivers
 - zynqmp_dma driver updates and descriptor management refinement
 - Hardware handshaking support for dw-axi-dmac
 - Support for remotely powered controllers in Qcom bam dma
 - tegra driver updates

----------------------------------------------------------------
Amelie Delaunay (3):
      dmaengine: stm32-dma: mark pending descriptor complete in terminate_a=
ll
      dmaengine: stm32-dma: fix stm32_dma_get_max_width
      dmaengine: stm32-dma: fix burst in case of unaligned memory address

Anatolij Gustschin (1):
      dmaengine: bestcomm: fix system boot lockups

Angelo Dureghello (1):
      dmaengine: fsl-edma: fix for missing dmamux module

Arnd Bergmann (2):
      dmaengine: remove debugfs #ifdef
      dmaengine: stm32-dma: avoid 64-bit division in stm32_dma_get_max_width

Artur Rojek (1):
      dmaengine: jz4780: Set max number of SGs per burst

Biju Das (1):
      dmaengine: sh: rz-dmac: Add DMA clock handling

Bixuan Cui (1):
      dmaengine: idxd: Use list_move_tail instead of list_del/list_add_tail

Cai Huoqing (2):
      dmaengine: sa11x0: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEE=
P_PM_OPS()
      dmaengine: sa11x0: Mark PM functions as __maybe_unused

Christophe JAILLET (1):
      dmaengine: dw-edma: Remove an unused variable

Claudiu Beznea (5):
      dmaengine: at_xdmac: call at_xdmac_axi_config() on resume path
      dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro
      dmaengine: at_xdmac: use __maybe_unused for pm functions
      dmaengine: at_xdmac: use pm_ptr()
      dmaengine: at_xdmac: fix compilation warning

Colin Ian King (2):
      dmaengine: Remove redundant initialization of variable err
      dmaengine: sh: make array ds_lut static

Dave Jiang (9):
      dmaengine: idxd: move out percpu_ref_exit() to ensure it's outside su=
bmission
      dmaengine: idxd: check GENCAP config support for gencfg register
      dmaengine: idxd: remove gen cap field per spec 1.2 update
      dmaengine: idxd: remove kernel wq type set when load configuration
      dmanegine: idxd: fix resource free ordering on driver removal
      dmaengine: idxd: add halt interrupt support
      dmaengine: idxd: reconfig device after device reset command
      dmaengine: idxd: cleanup completion record allocation
      dmaengine: idxd: fix resource leak on dmaengine driver disable

Dongliang Mu (3):
      dmaengine: rcar-dmac: refactor the error handling code of rcar_dmac_p=
robe
      dmaengine: tegra210-adma: fix pm runtime unbalance
      dmaengine: tegra210-adma: fix pm runtime unbalance in tegra_adma_remo=
ve

Flavio Suligoi (4):
      dmaengine: imx-sdma: remove useless braces
      dmaengine: imx-sdma: add missed braces
      dmaengine: imx-sdma: align statement to open parenthesis
      dmaengine: imx-sdma: remove space after sizeof

Geert Uytterhoeven (1):
      dmaengine: dw-axi-dmac: Simplify assignment in dma_chan_pause()

Gustavo A. R. Silva (1):
      dmaengine: stm32-mdma: Use struct_size() helper in devm_kzalloc()

Joy Zou (1):
      dmaengine: fsl-edma: support edma memcpy

Kishon Vijay Abraham I (2):
      dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
      dmaengine: ti: k3-udma: Set r/tchan or rflow to NULL if request fail

Lars-Peter Clausen (4):
      dmaengine: dmaengine_desc_callback_valid(): Check for `callback_resul=
t`
      dmaengine: altera-msgdma: Correctly handle descriptor callbacks
      dmaengine: xilinx_dma: Correctly handle cyclic descriptor callbacks
      dmaengine: zynqmp_dma: Correctly handle descriptor callbacks

Len Baker (1):
      dmaengine: milbeaut-hdmac: Prefer kcalloc over open coded arithmetic

Michael Tretter (7):
      dmaengine: zynqmp_dma: simplify with dev_err_probe
      dmaengine: zynqmp_dma: drop message on probe success
      dmaengine: zynqmp_dma: enable COMPILE_TEST
      dmaengine: zynqmp_dma: cleanup includes
      dmaengine: zynqmp_dma: cleanup after completing all descriptors
      dmaengine: zynqmp_dma: refine dma descriptor locking
      dmaengine: zynqmp_dma: fix lockdep warning in tasklet

Pandith N (3):
      dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8
      dmaengine: dw-axi-dmac: Hardware handshake configuration
      dmaengine: dw-axi-dmac: set coherent mask

Qing Wang (5):
      dmaengine: dw: switch from 'pci_' to 'dma_' API
      dmaengine: hisi_dma: switch from 'pci_' to 'dma_' API
      dmaengine: hsu: switch from 'pci_' to 'dma_' API
      dmaengine: ioat: switch from 'pci_' to 'dma_' API
      dmaengine: switch from 'pci_' to 'dma_' API

Sameer Pujar (3):
      dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
      dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
      dmaengine: tegra210-adma: Override ADMA FIFO size

Shravya Kumbham (1):
      dmaengine: xilinx_dma: Fix kernel-doc warnings

Stephan Gerhold (2):
      dt-bindings: dmaengine: bam_dma: Add "powered remotely" mode
      dmaengine: qcom: bam_dma: Add "powered remotely" mode

Wang Qing (1):
      dmaengine: dw-edma-pcie: switch from 'pci_' to 'dma_' API

Xin Xiong (1):
      dmaengine: mmp_pdma: fix reference count leaks in mmp_pdma_probe

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |   2 +
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/altera-msgdma.c                        |  10 +-
 drivers/dma/at_xdmac.c                             |  69 ++++++-------
 drivers/dma/bestcomm/ata.c                         |   2 +-
 drivers/dma/bestcomm/bestcomm.c                    |  22 ++--
 drivers/dma/bestcomm/fec.c                         |   4 +-
 drivers/dma/bestcomm/gen_bd.c                      |   4 +-
 drivers/dma/dma-jz4780.c                           |   1 +
 drivers/dma/dmaengine.c                            |   3 +-
 drivers/dma/dmaengine.h                            |   2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 112 +++++++++++++++--=
----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |  35 ++++++-
 drivers/dma/dw-edma/dw-edma-core.c                 |   1 -
 drivers/dma/dw-edma/dw-edma-pcie.c                 |  17 +---
 drivers/dma/dw/pci.c                               |   6 +-
 drivers/dma/fsl-edma-common.c                      |  35 ++++++-
 drivers/dma/fsl-edma-common.h                      |   4 +
 drivers/dma/fsl-edma.c                             |   7 ++
 drivers/dma/hisi_dma.c                             |   6 +-
 drivers/dma/hsu/pci.c                              |   6 +-
 drivers/dma/idxd/device.c                          |  29 ++----
 drivers/dma/idxd/dma.c                             |   5 +-
 drivers/dma/idxd/idxd.h                            |   2 -
 drivers/dma/idxd/init.c                            |  14 ++-
 drivers/dma/idxd/irq.c                             |   8 +-
 drivers/dma/idxd/registers.h                       |   4 +-
 drivers/dma/imx-sdma.c                             |  28 +++---
 drivers/dma/ioat/init.c                            |  10 +-
 drivers/dma/milbeaut-hdmac.c                       |   2 +-
 drivers/dma/mmp_pdma.c                             |   1 +
 drivers/dma/plx_dma.c                              |  10 +-
 drivers/dma/qcom/bam_dma.c                         |  90 +++++++++++------
 drivers/dma/sa11x0-dma.c                           |  11 +-
 drivers/dma/sh/rcar-dmac.c                         |  13 +--
 drivers/dma/sh/rz-dmac.c                           |  16 ++-
 drivers/dma/stm32-dma.c                            |  24 +++--
 drivers/dma/stm32-mdma.c                           |   3 +-
 drivers/dma/tegra210-adma.c                        |  58 +++++++----
 drivers/dma/ti/k3-udma.c                           |  32 ++++--
 drivers/dma/xilinx/xilinx_dma.c                    |  14 ++-
 drivers/dma/xilinx/xilinx_dpdma.c                  |  15 +--
 drivers/dma/xilinx/zynqmp_dma.c                    |  79 +++++++--------
 include/linux/dmaengine.h                          |   2 -
 44 files changed, 490 insertions(+), 330 deletions(-)

Thanks
--=20
~Vinod

--55uKwjtuR0hH29Lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmGLtYYACgkQfBQHDyUj
g0djcw/9EI8k/d3h2ouKB+JwGA12TxNzjAgGf98bj/NHHC3W6XXs1sICkaBHo5T2
cRIS+87Ku/EzAB1ILLGPl2kDs3XTWKnaHPLrtCm8I4kOlqXJBvEaT1aFrBFwl3pB
PjR2RBTRRhmXln8J7zWnO8KG+snUei+KtU9mlXRG+I066SYD386YvdfpafxrVphi
TVnQRp5m17VjiUTyKmiHo76JxcsmqRHimRc+LoaBBSzAukqtpwLiHdU7aNFXF8PD
jSjlIJWHzamxW8kQUgKTWc0Zs/7fv7Z/DrYM1uS6P4dbykporl8KkqYuFou0pHT0
zeI2dy8RZ6xFiaT2rUfS6n3+RXlqBTeagfgWUdLBIvzqVkAsGLW+57zPfBBmDH0f
eHMhO7+C5QDVXQrOpMufEUVe4bzHAwLww7+m33ZPMDYUWj6WarJrRx/858s+yc35
AF+TOqb0BMVBh+46EVXD3sJv71nZCfFjWC7soMFu2E4VW+t9KcMB5F+bBmSoGaEO
JbvJe/jxvjWn/2ad+qLs5jxd5Pb9LCT6NJnZ8iWQ4hbWeBZ6p5e+qzxzPD4119FV
bDbQQqxjMPrPrJDZ+aZqBsM1XqmpAcgnuSY0WogfSlU8B2GP2lLUE1tY4CFj5I6Y
5Aa4DE+LlwHxjW8TpaEeqFn5yDKgklPa38h3gYMGq0ObDct0Zak=
=Ug+G
-----END PGP SIGNATURE-----

--55uKwjtuR0hH29Lc--
