Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6435140510
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQINQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 03:13:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgAQINP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 03:13:15 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1isMkd-0001Cc-OT; Fri, 17 Jan 2020 09:13:07 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1isMkc-0004pJ-7a; Fri, 17 Jan 2020 09:13:06 +0100
Date:   Fri, 17 Jan 2020 09:13:06 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Han Xu <xhnjupt@gmail.com>
Cc:     Han Xu <han.xu@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Esben Haabendal <esben@geanix.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] dmaengine: mxs: add the power management functions
Message-ID: <20200117081306.eeuf3fvph5rb7tjf@pengutronix.de>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
 <1579038243-28550-4-git-send-email-han.xu@nxp.com>
 <20200115080257.dtd4vss4uhopbvn2@pengutronix.de>
 <CA+EcR23TCUU83Y7BYX5LCvGAj20+s67n+rWaGR5R9BSMHUH82A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EcR23TCUU83Y7BYX5LCvGAj20+s67n+rWaGR5R9BSMHUH82A@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:08:04 up 193 days, 14:18, 87 users,  load average: 0.09, 0.28,
 0.30
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 16, 2020 at 10:36:33AM -0600, Han Xu wrote:
> On Wed, Jan 15, 2020 at 2:03 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Wed, Jan 15, 2020 at 05:44:00AM +0800, Han Xu wrote:
> > > add the power management functions and leverage the runtime pm for
> > > system suspend/resume
> > >
> > > Signed-off-by: Han Xu <han.xu@nxp.com>
> > > ---
> > >  drivers/dma/mxs-dma.c | 97 +++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 90 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > > index b458f06f9067..251492c5ea58 100644
> > > --- a/drivers/dma/mxs-dma.c
> > > +++ b/drivers/dma/mxs-dma.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/of_dma.h>
> > >  #include <linux/list.h>
> > >  #include <linux/dma/mxs-dma.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  #include <asm/irq.h>
> > >
> > > @@ -39,6 +40,8 @@
> > >  #define dma_is_apbh(mxs_dma) ((mxs_dma)->type == MXS_DMA_APBH)
> > >  #define apbh_is_old(mxs_dma) ((mxs_dma)->dev_id == IMX23_DMA)
> > >
> > > +#define MXS_DMA_RPM_TIMEOUT 50 /* ms */
> > > +
> > >  #define HW_APBHX_CTRL0                               0x000
> > >  #define BM_APBH_CTRL0_APB_BURST8_EN          (1 << 29)
> > >  #define BM_APBH_CTRL0_APB_BURST_EN           (1 << 28)
> > > @@ -416,6 +419,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> > >  {
> > >       struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> > >       struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> > > +     struct device *dev = &mxs_dma->pdev->dev;
> > >       int ret;
> > >
> > >       mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
> > > @@ -431,9 +435,11 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> > >       if (ret)
> > >               goto err_irq;
> > >
> > > -     ret = clk_prepare_enable(mxs_dma->clk);
> > > -     if (ret)
> > > +     ret = pm_runtime_get_sync(dev);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "Failed to enable clock\n");
> > >               goto err_clk;
> >
> > From looking at other DMA drivers I know we are in good company here,
> > but I think this is wrong. Doing pm_runtime_get_sync() in
> > alloc_chan_resources() and going to autosuspend in free_chan_resources()
> > effectively disables runtime_pm as clients normally acquire their
> > channels during driver probe and release them only in driver remove.
> 
> Thanks for the comments.
> That's why I moved acquire_dma_resource from the probe to
> runtime_resume in the gpmi driver, this change won't disable the
> runtime_pm function and the incremental counter always balanced.

Yes, that's what I've written a few lines further down:

> 
> >
> > In the next patch you release the DMA channels in the GPMI nand drivers
> > runtime_suspend hook just to somehow trigger the runtime_suspend of the
> > DMA driver.

And I consider doing this a crude hack. Here is what I suggested doing
instead:

> >
> > What you should do instead is to make sure the hook runtime_pm to the
> > DMA drivers activity phases, like for example the pl330 driver does.
> > Then you wouldn't have to care about manually putting the DMA driver into
> > suspend from the GPMI NAND driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
