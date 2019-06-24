Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E34FF7B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 04:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfFXCmY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Jun 2019 22:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfFXCmY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 23 Jun 2019 22:42:24 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312382073F;
        Mon, 24 Jun 2019 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561335418;
        bh=rlOHzwEHb6pqbLmFFdbDpWnjpgMeLjwtJXHuyHU99k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roJv8fNnUZ0dRiuDvVUwCMeTZKp+rYD7LINPyt/Equnhsgqrl0uw2KlYXz3yv/oOz
         LsjbdcChTu9SBpwoJkep+EimMkvVRkjQ0BK0ZtsArotoz5QR34PwqBsyCMuDxcASBL
         BZJmJN/MJsDoVQKxEcXbXI5c6+E4rwQscQOAaLSc=
Date:   Mon, 24 Jun 2019 08:16:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Message-ID: <20190624001643.GB3800@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <1561135476.7537.5.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561135476.7537.5.camel@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 21, 2019 at 08:42:48AM +0000, Robin Gong wrote:
> Hello Shawn/Will,
>   Do you have comments for this V5 patch set? I got tags from Mark,
> Vinod and Rob.

I'm fine with the DTS change, but not sure how the series should be
merged.

Shawn

> 
> On 2019-06-10 at 08:17 +0000, yibin.gong@nxp.com wrote:
> > From: Robin Gong <yibin.gong@nxp.com>
> > 
> >   There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> > transfer to be send twice in DMA mode. Please get more information
> > from:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> > .nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=02%7C01%7Cyibin
> > .gong%40nxp.com%7C67d3e78fe5ef4428b3af08d6ed7beb74%7C686ea1d3bc2b4c6f
> > a92cd99c5c301635%7C0%7C1%7C636957513814970412&amp;sdata=%2F9sbrDEmIpu
> > OazcIAVpIrELZMEjO94%2Bjen7wOOlVsVk%3D&amp;reserved=0. The workaround
> > is adding
> > new sdma ram script which works in XCH  mode as PIO inside sdma
> > instead
> > of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should
> > be
> > exist on all legacy i.mx6/7 soc family before i.mx6ul.
> >   NXP fix this design issue from i.mx6ul, so newer chips including
> > i.mx6ul/
> > 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8
> > chips
> > still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> > for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need
> > errata
> > or not.
> >   The first two reverted patches should be the same issue, though, it
> > seems 'fixed' by changing to other shp script. Hope Sean or Sascha
> > could
> > have the chance to test this patch set if could fix their issues.
> >   Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not
> > work
> > on i.mx8mm because the event id is zero.
> > 
> > PS:
> >    Please get sdma firmware from below linux-firmware and copy it to
> > your
> > local rootfs /lib/firmware/imx/sdma.
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-
> > firmware.git%2Ftree%2Fimx%2Fsdma&amp;data=02%7C01%7Cyibin.gong%40nxp.
> > com%7C67d3e78fe5ef4428b3af08d6ed7beb74%7C686ea1d3bc2b4c6fa92cd99c5c30
> > 1635%7C0%7C1%7C636957513814970412&amp;sdata=xXHBWpSaSLmMosb%2FajOAiXn
> > nkxaYV6HCt25OOzgRLbI%3D&amp;reserved=0
> > 
> > v2:
> >   1.Add commit log for reverted patches.
> >   2.Add comment for 'ecspi_fixed' in sdma driver.
> >   3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
> >     rather than remove.
> > v3:
> >   1.Confirm with design team make sure ERR009165 fixed on
> > i.mx6ul/i.mx6ull
> >     /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy
> > chips.
> >     Correct dts related dts patch in v2.
> >   2.Clean eratta information in binding doc and new 'tx_glitch_fixed'
> > flag
> >     in spi-imx driver to state ERR009165 fixed or not.
> >   3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in
> > the
> >     errata workaroud, thus improve performance as possible.
> > v4:
> >   1.add Ack tag from Mark and Vinod
> >   2. remove checking 'event_id1' zero as 'event_id0'.
> > v5:
> >   1.Add another patch for compatible with the current uart driver
> > which
> >     using rom script, so both uart ram script and rom script
> > supported
> >     in latest firmware, by default uart rom script used. UART driver
> >     will be broken without this patch. Latest sdma firmware has been
> >     already updated in linux-firmware. 
> > 
> > Robin Gong (15):
> >   Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
> >   Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
> >   Revert "dmaengine: imx-sdma: refine to load context only once"
> >   dmaengine: imx-sdma: remove dupilicated sdma_load_context
> >   dmaengine: imx-sdma: add mcu_2_ecspi script
> >   spi: imx: fix ERR009165
> >   spi: imx: remove ERR009165 workaround on i.mx6ul
> >   spi: imx: add new i.mx6ul compatible name in binding doc
> >   dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
> >   dma: imx-sdma: add i.mx6ul/6sx compatible name
> >   dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
> >   ARM: dts: imx6ul: add dma support on ecspi
> >   ARM: dts: imx6sll: correct sdma compatible
> >   arm64: defconfig: Enable SDMA on i.mx8mq/8mm
> >   dmaengine: imx-sdma: add uart rom script
> > 
> >  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  2 +
> >  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
> >  arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
> >  arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
> >  arch/arm/boot/dts/imx6sll.dtsi                     |  2 +-
> >  arch/arm/boot/dts/imx6ul.dtsi                      |  8 ++
> >  arch/arm64/configs/defconfig                       |  3 +
> >  drivers/dma/imx-sdma.c                             | 88
> > ++++++++++++++++------
> >  drivers/spi/spi-imx.c                              | 61
> > ++++++++++++---
> >  include/linux/platform_data/dma-imx-sdma.h         | 11 ++-
> >  10 files changed, 145 insertions(+), 41 deletions(-)
> > 
