Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1D1B2E4
	for <lists+dmaengine@lfdr.de>; Mon, 13 May 2019 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfEMJbx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 May 2019 05:31:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57233 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfEMJbx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 May 2019 05:31:53 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hQ7J3-0007BB-G5; Mon, 13 May 2019 11:31:37 +0200
Message-ID: <1557739890.3997.1.camel@pengutronix.de>
Subject: Re: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc family
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 13 May 2019 11:31:30 +0200
In-Reply-To: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

Am Dienstag, den 07.05.2019, 09:15 +0000 schrieb Robin Gong:
>   There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
> or not.
>   The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
>   Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
> 
> PS:
>   Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

This series is unfit for merging, as long as it depends on a SDMA RAM
script that is known to break serial DMA. When can we expect to get a
firmware version with the broken serial script removed out into the
public?

Regards,
Lucas

> v2:
>   1. add commit log for reverted patches.
>   2. add comment for 'ecspi_fixed' in sdma driver.
>   3. add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
>      rather than remove.
> v3:
>   1. confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ull
>   /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
>   Correct dts related dts patch in v2.
>   2. clean eratta information in binding doc and new 'tx_glitch_fixed' flag
>   in spi-imx driver to state ERR009165 fixed or not.
>   3. Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
>   errata workaroud, thus improve performance as possible.
> 
> Robin Gong (14):
>   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
>   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
>   Revert "dmaengine: imx-sdma: refine to load context only once"
>   dmaengine: imx-sdma: remove dupilicated sdma_load_context
>   dmaengine: imx-sdma: add mcu_2_ecspi script
>   spi: imx: fix ERR009165
>   spi: imx: remove ERR009165 workaround on i.mx6ul
>   dt-bindings: spi: imx: add new i.mx6ul compatible name
>   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
>   dt-bindings: dma: imx-sdma: add i.mx6ul/6sx compatible name
>   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
>   ARM: dts: imx6ul: add dma support on ecspi
>   ARM: dts: imx6sll: correct sdma compatible
>   arm64: defconfig: Enable SDMA on i.mx8mq/8mm
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  2 +
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
>  arch/arm/boot/dts/imx6sll.dtsi                     |  2 +-
>  arch/arm/boot/dts/imx6ul.dtsi                      |  8 +++
>  arch/arm64/configs/defconfig                       |  3 +
>  drivers/dma/imx-sdma.c                             | 78 ++++++++++++++++------
>  drivers/spi/spi-imx.c                              | 61 ++++++++++++++---
>  include/linux/platform_data/dma-imx-sdma.h         |  1 +
>  10 files changed, 132 insertions(+), 34 deletions(-)
> 
> -- 
> 2.7.4
> 
