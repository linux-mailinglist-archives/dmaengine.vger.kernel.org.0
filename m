Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5F118AA8
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJOT7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 09:19:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47347 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJOT6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 09:19:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iegMn-0003F5-7p; Tue, 10 Dec 2019 15:19:57 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iegMm-0006Sc-3C; Tue, 10 Dec 2019 15:19:56 +0100
Date:   Tue, 10 Dec 2019 15:19:56 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/6] dmaengine: virt-dma: Do not call desc_free() under a
 spin_lock
Message-ID: <20191210141956.ymbivsl5tshv6rl2@pengutronix.de>
References: <20191210123352.7555-1-s.hauer@pengutronix.de>
 <20191210123352.7555-2-s.hauer@pengutronix.de>
 <7f8c4ae6-88f9-7818-a9d6-cc55bcf62bd5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f8c4ae6-88f9-7818-a9d6-cc55bcf62bd5@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:52:19 up 155 days, 20:02, 150 users,  load average: 0.06, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 10, 2019 at 03:12:47PM +0200, Peter Ujfalusi wrote:
> 
> 
> On 10/12/2019 14.33, Sascha Hauer wrote:
> > vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
> > in two places, once in vchan_terminate_vdesc() and once in
> > vchan_synchronize(). Instead of freeing the vdesc right away, collect
> > the aborted vdescs on a separate list and free them along with the other
> > vdescs. The terminated descs are also freed in vchan_synchronize as done
> > before this patch.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/dma/virt-dma.c |  1 +
> >  drivers/dma/virt-dma.h | 18 +++++++++---------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> > index ec4adf4260a0..02c0a8885a53 100644
> > --- a/drivers/dma/virt-dma.c
> > +++ b/drivers/dma/virt-dma.c
> > @@ -135,6 +135,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
> >  	INIT_LIST_HEAD(&vc->desc_submitted);
> >  	INIT_LIST_HEAD(&vc->desc_issued);
> >  	INIT_LIST_HEAD(&vc->desc_completed);
> > +	INIT_LIST_HEAD(&vc->desc_terminated);
> >  
> >  	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
> >  
> > diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> > index ab158bac03a7..e213137b6bc1 100644
> > --- a/drivers/dma/virt-dma.h
> > +++ b/drivers/dma/virt-dma.h
> > @@ -31,9 +31,9 @@ struct virt_dma_chan {
> >  	struct list_head desc_submitted;
> >  	struct list_head desc_issued;
> >  	struct list_head desc_completed;
> > +	struct list_head desc_terminated;
> >  
> >  	struct virt_dma_desc *cyclic;
> > -	struct virt_dma_desc *vd_terminated;
> >  };
> >  
> >  static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
> > @@ -141,11 +141,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
> >  {
> >  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> >  
> > -	/* free up stuck descriptor */
> > -	if (vc->vd_terminated)
> > -		vchan_vdesc_fini(vc->vd_terminated);
> > +	list_add_tail(&vd->node, &vc->desc_terminated);
> >  
> > -	vc->vd_terminated = vd;
> >  	if (vc->cyclic == vd)
> >  		vc->cyclic = NULL;
> >  }
> > @@ -179,6 +176,7 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
> >  	list_splice_tail_init(&vc->desc_submitted, head);
> >  	list_splice_tail_init(&vc->desc_issued, head);
> >  	list_splice_tail_init(&vc->desc_completed, head);
> > +	list_splice_tail_init(&vc->desc_terminated, head);
> >  }
> >  
> >  static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
> > @@ -207,16 +205,18 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
> >   */
> >  static inline void vchan_synchronize(struct virt_dma_chan *vc)
> >  {
> > +	LIST_HEAD(head);
> >  	unsigned long flags;
> >  
> >  	tasklet_kill(&vc->task);
> >  
> >  	spin_lock_irqsave(&vc->lock, flags);
> > -	if (vc->vd_terminated) {
> > -		vchan_vdesc_fini(vc->vd_terminated);
> > -		vc->vd_terminated = NULL;
> > -	}
> > +
> > +	list_splice_tail_init(&vc->desc_terminated, &head);
> > +
> >  	spin_unlock_irqrestore(&vc->lock, flags);
> > +
> > +	vchan_dma_desc_free_list(vc, &head);
> 
> My only issue with the vchan_dma_desc_free_list() is that it prints with
> dev_dbg() for each descriptor it is freeing up.
> The 'stuck' descriptor happens quite frequently if you start/stop audio
> for example.

if we consider the message useful then I would say it's equally useful
both for the 'stuck' descriptor and for the regular case.

IMO the debug message only makes sense if we make sure it is printed
each time a descriptor is freed. Currently it's printed when the
descriptor is freed from vchan_dma_desc_free_list(), but not when it's
freed from vchan_vdesc_fini(). This is confusing as looking at the dmesg
suggests that we lose descriptors.

> 
> This is why I proposed a local
> 
> list_for_each_entry_safe(vd, _vd, &head, node) {
> 	list_del(&vd->node);
> 	vchan_vdesc_fini(vd);
> }
> 
> On the other hand what vchan_dma_desc_free_list() is doing is exactly
> the same thing as this loop is doing with the addition of the debug print.
> 
> I'm not sure how useful that debug print is, not sure if anyone would
> miss if it is gone?
> 
> If not, than see my comment on patch 2.

We could add the dev_dbg into vchan_vdesc_fini() as well and still
implement your suggestion on patch 2...

Anyway, I don't care much if the dev_dbg is there or not. I'll happily
add a patch removing it for the next round if that's what we agree upon.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
