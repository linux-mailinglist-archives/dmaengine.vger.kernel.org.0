Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9B118777
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 12:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLJL6x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 06:58:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJL6x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 06:58:53 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeAG-0001F9-0N; Tue, 10 Dec 2019 12:58:52 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeAF-0008Aw-Im; Tue, 10 Dec 2019 12:58:51 +0100
Date:   Tue, 10 Dec 2019 12:58:51 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/5] dmaengine: virt-dma: Do not call desc_free() under a
 spin_lock
Message-ID: <20191210115851.mxzadx4z47tadwzv@pengutronix.de>
References: <20191206135344.29330-1-s.hauer@pengutronix.de>
 <20191206135344.29330-3-s.hauer@pengutronix.de>
 <65b923ed-4370-089c-1d6c-ce7efac176e6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b923ed-4370-089c-1d6c-ce7efac176e6@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:56:43 up 155 days, 18:06, 143 users,  load average: 0.12, 0.14,
 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 09, 2019 at 09:48:22AM +0200, Peter Ujfalusi wrote:
> Hi Sascha,
> 
> 
> On 06/12/2019 15.53, Sascha Hauer wrote:
> > vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
> > in two places, once in vchan_terminate_vdesc() and once in
> > vchan_synchronize(). Instead of freeing the vdesc right away, collect
> > the aborted vdescs on a separate list and free them along with the other
> > vdescs.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/dma/virt-dma.c |  1 +
> >  drivers/dma/virt-dma.h | 17 +++--------------
> >  2 files changed, 4 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> > index ec4adf4260a0..87d5bd53c98b 100644
> > --- a/drivers/dma/virt-dma.c
> > +++ b/drivers/dma/virt-dma.c
> > @@ -135,6 +135,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
> >  	INIT_LIST_HEAD(&vc->desc_submitted);
> >  	INIT_LIST_HEAD(&vc->desc_issued);
> >  	INIT_LIST_HEAD(&vc->desc_completed);
> > +	INIT_LIST_HEAD(&vc->desc_aborted);
> 
> Can we keep the terminated term instead of aborted: desc_terminated

Sure.

> >  	tasklet_kill(&vc->task);
> > -
> > -	spin_lock_irqsave(&vc->lock, flags);
> > -	if (vc->vd_terminated) {
> > -		vchan_vdesc_fini(vc->vd_terminated);
> > -		vc->vd_terminated = NULL;
> > -	}
> > -	spin_unlock_irqrestore(&vc->lock, flags);
> 
> We don't want the terminated descriptors to accumulate until the channel
> is freed up.

Nothing easier than that. I just have to revert to an earlier version
before I decided that it's better to free up the descriptors at the end ;)

I'll send a v2 shortly.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
