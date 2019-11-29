Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3764610D0D3
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2019 06:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfK2FS0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Nov 2019 00:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfK2FS0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 Nov 2019 00:18:26 -0500
Received: from localhost (unknown [171.76.96.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1605A21736;
        Fri, 29 Nov 2019 05:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575004704;
        bh=8TDfWpKo7ujSp4Fi/bzPRzCEStOkz2GptZ0MFqjFvOI=;
        h=Date:From:To:Cc:Subject:From;
        b=ES4VZCMad9YM16JleW+dCY6yBR5Gc95NeoL4fdz05TUCaXas0ggJUrjCohWj87kxk
         79NUK5OFfTaxx+YkFJqHUW8S5LQTIE+IrqqRXNt3DGGK5W/5BerdLS26cmDRb6X0Iq
         SKIlrlCWcFHMEeJ51vavPsPxd+0Rry2kN1zm38GU=
Date:   Fri, 29 Nov 2019 10:48:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v5.5-rc1
Message-ID: <20191129051819.GX82508@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here are the changes this time around, couple of new drivers and updates
to few more. This time the changes are based on dmaengine-fix-5.4-rc6 as
I had to merge fixes to next for a dependency. The below commit is
dmaengine-fix-5.4-rc6 already in you tree.

The following changes since commit bacdcb6675e170bb2e8d3824da220e10274f42a7:

  dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle (2019-10-23 2=
1:15:21 +0530)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.5-rc1

for you to fetch changes up to 67805a4b3c924927d9e064bca235461941f89e4a:

  dmaengine: Fix Kconfig indentation (2019-11-22 11:16:26 +0530)

----------------------------------------------------------------
dmaengine updates for v5.5-rc1

 - New drivers for SiFive PDMA, Socionext Milbeaut HDMAC and XDMAC,
   Freescale dpaa2 qDMA
 - Support for X1000 in JZ4780
 - Xilinx dma updates and support for Xilinx AXI MCDM controller
 - New bindings for rcar R8A774B1
 - Minor updates to dw, dma-jz4780, ti-edma, sprd drivers

----------------------------------------------------------------
Andy Shevchenko (1):
      dmaengine: dw: platform: Mark 'hclk' clock optional

Baolin Wang (1):
      dmaengine: sprd: Change to use devm_platform_ioremap_resource()

Biju Das (1):
      dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings

Chuhong Yuan (4):
      dmaengine: dma-jz4780: add missed clk_disable_unprepare in remove
      dmaengine: mmp_tdma: add missed of_dma_controller_free
      dmaengine: mmp_pdma: add missed of_dma_controller_free
      dmaengine: ti: edma: fix missed failure handling

Colin Ian King (2):
      dmaengine: iop-adma: make array 'handler' static const, makes object =
smaller
      dmaengine: iop-adma: clean up an indentation issue

Eric Long (1):
      dmaengine: sprd: Add wrap address support for link-list mode

Green Wan (5):
      dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
      dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00
      MAINTAINERS: Add Green as SiFive PDMA driver maintainer
      dmaengine: sf-pdma: replace /** with /* for non-function comment
      dmaengine: sf-pdma: move macro to header file

Jassi Brar (4):
      dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC bindin=
gs
      dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms
      dt-bindings: milbeaut-m10v-xdmac: Add Socionext Milbeaut XDMAC bindin=
gs
      dmaengine: milbeaut-xdmac: Add XDMAC driver for Milbeaut platforms

Krzysztof Kozlowski (2):
      dmaengine: fsl-qdma: Handle invalid qdma-queue0 IRQ
      dmaengine: Fix Kconfig indentation

Markus Elfring (7):
      dmaengine: at_xdmac: Use devm_platform_ioremap_resource() in at_xdmac=
_probe()
      dmaengine: jz4780: Use devm_platform_ioremap_resource() in jz4780_dma=
_probe()
      dmaengine: k3dma: Use devm_platform_ioremap_resource() in k3_dma_prob=
e()
      dmaengine: mediatek: Use devm_platform_ioremap_resource() in mtk_cqdm=
a_probe()
      dmaengine: mediatek: Use devm_platform_ioremap_resource() in mtk_uart=
_apdma_probe()
      dmaengine: owl: Use devm_platform_ioremap_resource() in owl_dma_probe=
()
      dmaengine: zx: Use devm_platform_ioremap_resource() in zx_dma_probe()

Masahiro Yamada (1):
      dmaengine: uniphier-mdmac: use devm_platform_ioremap_resource()

Nathan Chancellor (1):
      dmaengine: fsl-dpaa2-qdma: Remove unnecessary local variables in DPDM=
AI_CMD_CREATE macro

Nicholas Graumann (5):
      dmaengine: xilinx_dma: Merge get_callback and _invoke
      dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue
      dmaengine: xilinx_dma: Add callback_result support
      dmaengine: xilinx_dma: Print debug message when no free tx segments
      dmaengine: xilinx_dma: Clear desc_pendingcount in xilinx_dma_reset

Peng Ma (3):
      dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA Interface) su=
pport
      dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for L=
ayerscape SoCs
      dmaengine: fsl-dpaa2-qdma: export the symbols

Peter Ujfalusi (3):
      dt-bindings: dmaengine: dma-common: Change dma-channel-mask to uint32=
-array
      dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
      dmaengine: ti: edma: Add support for handling reserved channels

Radhey Shyam Pandey (10):
      dmaengine: xilinx_dma: use devm_platform_ioremap_resource()
      dmaengine: xilinx_dma: Remove clk_get error message for probe defer
      dmaengine: xilinx_dma: Remove desc_callback_valid check
      dmaengine: xilinx_dma: Remove residue from channel data
      dt-bindings: dmaengine: xilinx_dma: Remove axidma multichannel support
      dt-bindings: dmaengine: xilinx_dma: Fix formatting and style
      dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
      dmaengine: xilinx_dma: Remove axidma multichannel mode support
      dmaengine: xilinx_dma: Extend dma_config struct to store irq routine =
handle
      dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support

Satendra Singh Thakur (2):
      dmaengine: mediatek: hsdma_probe: fixed a memory leak when devm_reque=
st_irq fails
      dmaengine: zx: remove: removed dmam_pool_destroy

Vinod Koul (3):
      dmaengine: milbeaut-hdmac: remove redundant error log
      dmaengine: milbeaut-xdmac: remove redundant error log
      Merge branch 'fixes' into next

Yoshihiro Shimoda (3):
      dmaengine: rcar-dmac: Use of_data values instead of a macro
      dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
      dmaengine: rcar-dmac: Add dma-channel-mask property support

YueHaibing (1):
      dmaengine: ti: edma: remove unused code

Zhou Yanjie (2):
      dt-bindings: dmaengine: Add X1000 bindings.
      dmaengine: JZ4780: Add support for the X1000.

 .../devicetree/bindings/dma/dma-common.yaml        |   9 +-
 .../devicetree/bindings/dma/jz4780-dma.txt         |   3 +-
 .../bindings/dma/milbeaut-m10v-hdmac.txt           |  32 +
 .../bindings/dma/milbeaut-m10v-xdmac.txt           |  24 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |  55 ++
 Documentation/devicetree/bindings/dma/ti-edma.txt  |   8 +
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  24 +-
 MAINTAINERS                                        |   6 +
 drivers/dma/Kconfig                                |  88 ++-
 drivers/dma/Makefile                               |   4 +
 drivers/dma/at_xdmac.c                             |   7 +-
 drivers/dma/dma-jz4780.c                           |  16 +-
 drivers/dma/dw/platform.c                          |   2 +-
 drivers/dma/fsl-dpaa2-qdma/Kconfig                 |   9 +
 drivers/dma/fsl-dpaa2-qdma/Makefile                |   3 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            | 825 +++++++++++++++++=
++++
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h            | 153 ++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c                | 376 ++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h                | 177 +++++
 drivers/dma/fsl-qdma.c                             |   3 +
 drivers/dma/iop-adma.c                             |  10 +-
 drivers/dma/k3dma.c                                |   7 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |  10 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   4 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   9 +-
 drivers/dma/milbeaut-hdmac.c                       | 578 +++++++++++++++
 drivers/dma/milbeaut-xdmac.c                       | 415 +++++++++++
 drivers/dma/mmp_pdma.c                             |   2 +
 drivers/dma/mmp_tdma.c                             |   3 +
 drivers/dma/owl-dma.c                              |   7 +-
 drivers/dma/sf-pdma/Kconfig                        |   6 +
 drivers/dma/sf-pdma/Makefile                       |   1 +
 drivers/dma/sf-pdma/sf-pdma.c                      | 620 ++++++++++++++++
 drivers/dma/sf-pdma/sf-pdma.h                      | 124 ++++
 drivers/dma/sh/rcar-dmac.c                         |  47 +-
 drivers/dma/sprd-dma.c                             |  17 +-
 drivers/dma/ti/edma.c                              |  77 +-
 drivers/dma/uniphier-mdmac.c                       |   4 +-
 drivers/dma/xilinx/xilinx_dma.c                    | 649 ++++++++++++----
 drivers/dma/zx_dma.c                               |   8 +-
 include/dt-bindings/dma/x1000-dma.h                |  40 +
 include/linux/dma/sprd-dma.h                       |   4 +
 43 files changed, 4198 insertions(+), 269 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdm=
ac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdm=
ac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000=
-pdma.yaml
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/Kconfig
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/Makefile
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai.c
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai.h
 create mode 100644 drivers/dma/milbeaut-hdmac.c
 create mode 100644 drivers/dma/milbeaut-xdmac.c
 create mode 100644 drivers/dma/sf-pdma/Kconfig
 create mode 100644 drivers/dma/sf-pdma/Makefile
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.c
 create mode 100644 drivers/dma/sf-pdma/sf-pdma.h
 create mode 100644 include/dt-bindings/dma/x1000-dma.h

Thanks
--=20
~Vinod

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl3gqhsACgkQfBQHDyUj
g0d3Ng/+MzKni7+oB7/vEy69MEssbwPyfTrORMMpsYcc5bNr0jsb1ECSVbwvstZp
mYm/MbtrF/21zjmTb1fZV1fn3gQCCA/wUrugj1m0xg0Ydpg/wAjUJE1yaRMNwm7z
/II2b4KT8MJcOAuhevHcBFfpJsVeztApEFDHelKloxU8VWtEuCFGyeKKCw0Oxev4
RZUW9Ubl0EDjpVB3DSwGAnwazm1NSfnisifAsQyZwaLjLij0fGCaeBZYShsMwsmc
T/26YOfenGum2VBh5uMtiZ2V3qP514xVSMyiU8SL7iivye0lGzJySSw2DZeOmvSg
939GGhxQXyRzVcMDLGnTEVUn6Si/MCaQJ84l71sebL3F/1jP7cKtvZFNIa7cj7Xi
7Cvpev9nBmmbBz5OdCOgnJOBfl/7XKSRCL8bSd7tjtjSxm0gwDrGBY8KVZjhtKP8
mQgIAZDiS+4T6nxueVCT19RSeBuycmQEp/zx3ZHreTg1MuwY10F8yjeRVl2DI4K6
E7WOx9ESRpIg80Nap6qArXaklALYJ3DK78uomE5gS720kXSjp04S/IZ9e9xQLwQY
SwVjiZn36rq43Tm6rLWTYUHiHzqGKgUzxLf1CIw/Tf/rmOTD2hD103kso74ahc+P
ih563WxycjgW0yr7HO2vxzwEP2OTdhFlCFeN5Jq7KQ/oxD3bVg8=
=Z2Yk
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
