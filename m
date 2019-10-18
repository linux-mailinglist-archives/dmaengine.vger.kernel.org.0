Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BEDC1C1
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfJRJue (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 05:50:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbfJRJue (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Oct 2019 05:50:34 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iLOu0-00089m-UX; Fri, 18 Oct 2019 11:50:32 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iLOu0-0005Tx-5Y; Fri, 18 Oct 2019 11:50:32 +0200
Date:   Fri, 18 Oct 2019 11:50:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org,
        vkoul@kernel.org, miquel.raynal@bootlin.com, bth@kamstrup.com,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: Regression: dmaengine: imx28 with emmc
Message-ID: <20191018095032.akdis5anygjl4pio@pengutronix.de>
References: <CAH+2xPB7rbeJnOPU10Ss9BhV_2DJV-ToQ3XNOy97+vrGx+ubcg@mail.gmail.com>
 <20191014141344.uwnzy3j3kxngzv7a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014141344.uwnzy3j3kxngzv7a@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:49:27 up 102 days, 15:59, 102 users,  load average: 0.31, 0.13,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 14, 2019 at 04:13:44PM +0200, Sascha Hauer wrote:
> Hi Bruno,
> 
> On Tue, Oct 08, 2019 at 10:03:16AM +0200, Bruno Thomsen wrote:
> > Hi
> > 
> > I am getting a kernel oops[1] during boot on imx28 with emmc flash right
> > around rootfs mounting. Using git bisect I found the cause to be the
> > following commit.
> > 
> > Regression: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> > 
> > Reverting the 2 changes in drivers/dma/mxs-dma.c fixes the oops,
> > but I am not sure that is the right solution as I don't have the full
> > mxs-dma + mtd/mmc overview.
> > 
> > I did see that the patch isn't a simple rename but also a bit define
> > change.
> > From: DMA_CTRL_ACK = (1 << 1) = BIT(1)
> > To: MXS_DMA_CTRL_WAIT4END = BIT(31)
> > 
> 
> Damn, I wasn't aware the DMA driver has other users than the GPMI Nand.
> Please try the attached patch, it should fix it for MMC/SD. It seems
> however, that I2C and AUART and SPI are also affected. Are you able to
> test any of these?

I just sent out the patch again for inclusion with the collected
tested-by tags.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
