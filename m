Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18864FF2C
	for <lists+dmaengine@lfdr.de>; Sun, 18 Dec 2022 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLROtl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Dec 2022 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLROtl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Dec 2022 09:49:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B1B1FD;
        Sun, 18 Dec 2022 06:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F40E3CE0B98;
        Sun, 18 Dec 2022 14:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8AC433D2;
        Sun, 18 Dec 2022 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671374976;
        bh=TWHHoXfRMeDcTkI5W62fhjv9lM3WGkTTXMkTRGAKtdg=;
        h=Date:From:To:Cc:Subject:From;
        b=KaYiw7ncEef3Tox++Y9cOvN4wj56D3RySEdwuW03UL6z2k/VF9gmylzaZ2OFR54v6
         Pi05DR4wDO1a8ElXQ2NtPMiQ1TueCwLQLu2JvhE2LLDP+Ahr4QmyTmJ62RGx5Yz//c
         4XDT+E605D407FNHTz+yNV/58KJrwnuSu+iHzoRYMsSzW4VfKK5oQ0J4B0JyAzMwg3
         0wftOXUU7znUSH0bEIO0azo7t6Iq5rIjpoS3SAF9mqLJFmuLqIzCM/QbfOZthf10sl
         sL6u5mV3DPRqCztPJOSco+Zcu8wsmUkpTSgdCnFoW5D6koanp6Ef7LngVb7RobLIyh
         Kan34PRJX989Q==
Date:   Sun, 18 Dec 2022 20:19:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.2
Message-ID: <Y58oexapv1XevgDL@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LS/XGU1mXv0O2pQZ"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--LS/XGU1mXv0O2pQZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for 6.2 for dmaengine subsystem. We have
couple of controller support, removal of iop-adma driver and bunch of
at_hdmac modernizing support.
Also we had to revert s3c24xx driver removal due to build failures, this
should come to you thru arm tree.
This is based on dmaengine-fix-6.1 tag you merged earlier.

The following changes since commit c47e6403fa099f200868d6b106701cb42d181d2b:

  dmaengine: at_hdmac: Check return code of dma_async_device_register (2022=
-11-08 10:43:57 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.2-rc1

for you to fetch changes up to 25483dedd2f5d9bc6928cd790ee59772fb880a79:

  dmaengine: Revert "dmaengine: remove s3c24xx driver" (2022-12-02 17:11:50=
 +0530)

----------------------------------------------------------------
dmaengine updates for v6.2

 New support:
 - Qualcomm SDM670, SM6115 and SM6375 GPI controller support
 - Ingenic JZ4755 dmaengine support
 - Removal of iop-adma driver

 Updates:
 - Tegra support for dma-channel-mask
 - at_hdmac cleanup and virt-chan support for this driver

----------------------------------------------------------------
Adam Skladowski (1):
      dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115

Akhil R (2):
      dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
      dmaengine: tegra: Add support for dma-channel-mask

Arnd Bergmann (2):
      dmaengine: remove iop-adma driver
      dmaengine: remove s3c24xx driver

Colin Ian King (1):
      dmaengine: ioat: Fix spelling mistake "idel" -> "idle"

Fenghua Yu (1):
      dmaengine: idxd: Fix crc_val field for completion record

Kevin Hilman (3):
      of/irq: export of_msi_get_domain
      dmaengine: ti: convert k3-udma to module
      dmaengine: ti: convert PSIL to be buildable as module

Konrad Dybcio (1):
      dt-bindings: dmaengine: qcom: gpi: add compatible for SM6375

Krzysztof Kozlowski (2):
      dt-bindings: dma: qcom: gpi: Use sm6350 fallback
      dmaengine: qcom: gpi: Document preferred SM6350 binding

Lukas Bulwahn (1):
      MAINTAINERS: remove section INTEL IOP-ADMA DMA DRIVER

Martin Povi=C5=A1er (1):
      dmaengine: apple-admac: Allocate cache SRAM to channels

Radhey Shyam Pandey (2):
      dmaengine: xilinx_dma: fix xilinx_dma_child_probe() return documentat=
ion
      dmaengine: xilinx_dma : add xilinx_dma_device_config() return documen=
tation

Richard Acayan (3):
      dt-bindings: dma: qcom: gpi: add fallback compatible
      dt-bindings: dma: qcom: gpi: add compatible for sdm670
      dmaengine: qcom: deprecate redundant of_device_id entries

Siarhei Volkau (2):
      dt-bindings: ingenic: Add support for the JZ4755 dmaengine
      dmaengine: JZ4780: Add support for the JZ4755.

Stephen Kitt (1):
      dmaengine: sh: Remove unused shdma-arm.h

Thomas Gleixner (1):
      dmaengine: idxd: Remove linux/msi.h include

Tudor Ambarus (17):
      dmaengine: at_hdmac: Do not print messages on console while holding t=
he lock
      dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when txsta=
te is NULL
      dmaengine: at_hdmac: Remove superfluous cast
      dmaengine: at_hdmac: Pass residue by address to avoid unnecessary imp=
licit casts
      dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
      dmaengine: at_hdmac: Introduce atc_get_llis_residue()
      dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
      dmaengine: at_hdmac: Use devm_platform_ioremap_resource
      dmaengine: at_hdmac: Use devm_clk_get()
      dmaengine: at_hdmac: Use pm_ptr()
      dmaengine: at_hdmac: Set include entries in alphabetic order
      dmaengine: at_hdmac: Keep register definitions and structures private=
 to at_hdmac.c
      dmaengine: at_hdmac: Use bitfield access macros
      dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
      dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
      dmaengine: at_hdmac: Remove unused member of at_dma_chan
      dmaengine: at_hdmac: Convert driver to use virt-dma

Uwe Kleine-K=C3=B6nig (1):
      dmaengine: idma64: Make idma64_remove() return void

Vinod Koul (2):
      Merge branch 'fixes' into next
      dmaengine: Revert "dmaengine: remove s3c24xx driver"

Xiaochen Shen (2):
      dmaengine: idxd: Make max batch size attributes in sysfs invisible fo=
r Intel IAA
      dmaengine: idxd: Make read buffer sysfs attributes invisible for Inte=
l IAA

Yang Yingliang (1):
      Documentation: devres: add missing devm_acpi_dma_controller_free() he=
lper

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   12 +
 .../devicetree/bindings/dma/ingenic,dma.yaml       |    1 +
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |    7 +-
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   26 +-
 Documentation/driver-api/driver-model/devres.rst   |    1 +
 MAINTAINERS                                        |    6 -
 drivers/dma/Kconfig                                |    9 +-
 drivers/dma/Makefile                               |    1 -
 drivers/dma/apple-admac.c                          |  102 +-
 drivers/dma/at_hdmac.c                             | 1854 +++++++++++-----=
----
 drivers/dma/at_hdmac_regs.h                        |  478 -----
 drivers/dma/dma-jz4780.c                           |    8 +
 drivers/dma/idma64.c                               |    8 +-
 drivers/dma/idxd/device.c                          |    1 -
 drivers/dma/idxd/sysfs.c                           |   68 +
 drivers/dma/ioat/dma.c                             |    2 +-
 drivers/dma/iop-adma.c                             | 1554 ----------------
 drivers/dma/iop-adma.h                             |  914 ----------
 drivers/dma/qcom/gpi.c                             |    7 +-
 drivers/dma/sh/shdma-arm.h                         |   48 -
 drivers/dma/tegra186-gpc-dma.c                     |   37 +-
 drivers/dma/ti/Kconfig                             |    7 +-
 drivers/dma/ti/Makefile                            |   15 +-
 drivers/dma/ti/k3-psil.c                           |    2 +
 drivers/dma/ti/k3-udma-glue.c                      |    5 +-
 drivers/dma/ti/k3-udma.c                           |   40 +-
 drivers/dma/xilinx/xilinx_dma.c                    |    4 +-
 drivers/of/irq.c                                   |    1 +
 include/uapi/linux/idxd.h                          |    2 +-
 29 files changed, 1268 insertions(+), 3952 deletions(-)
 delete mode 100644 drivers/dma/at_hdmac_regs.h
 delete mode 100644 drivers/dma/iop-adma.c
 delete mode 100644 drivers/dma/iop-adma.h
 delete mode 100644 drivers/dma/sh/shdma-arm.h
--=20
~Vinod

--LS/XGU1mXv0O2pQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmOfKHoACgkQfBQHDyUj
g0c5bxAAud/L54ND/aYisnDXDNy7kIiR/xwr/VV8iySfuVbIJyvXc7N5pgmzBKOP
XWPcb6cyq/8PHVz6voxi9eDwGlGs9bw+iDrtby3mCTfPAjIryK1eCjy+NjlnxaS/
NGeZe9Irayq0VCpJYvxzbEpW+O96qxC5UY9AzgqkrZsA35zkdMozO9DhFbak1Pkf
fwYzhvBW99V4fx3VbPHtq/6BeXpiFgpLe8yJGwALSixRLgD3uJL1xnbX3zzMtICa
HpsAvU6sU3TCTqV1JQu6GndqI38nqP/Fyxoy8dsHjOhdPXD/Xm644tjiRCRuyK56
8Vdnfkf97bHjjkBnIvdiDStMkB+NiLz1OK01kwKJ7B/i3yRhXyGeF/GsQ6wlgO3A
mMpGz7ES/Cyq/r4SroCuvOGghTPrm+3FQwT/WTfHpmPy4w/aMctUOp8crpGqJR5v
ZlzSg/1lvPt1UW21W+LCkWOsYbOS94Y5irBEKHnmhtRdVuq1/ncz8Qrp07fKez5B
GOS9xinJ+dMM0a+9g9NK/x56wZeML3joqPwnd+HSVuHA12K4jBk9j0EpnwG1TnFj
fqigdKykVL9CJZOz96XQzBZalYUfGRlGMNlU3Uy6yhpd81rnVsQqqrRnkRnSpCLq
2oTZSvi+JaMVml6M7BdYvADLTFN5xfH/hBZz7nmlNuaSx0ygHSQ=
=ooo9
-----END PGP SIGNATURE-----

--LS/XGU1mXv0O2pQZ--
