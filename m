Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9648D21C606
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2020 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGKTxt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Jul 2020 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGKTxt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Jul 2020 15:53:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3BC08C5DD
        for <dmaengine@vger.kernel.org>; Sat, 11 Jul 2020 12:53:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68C62259;
        Sat, 11 Jul 2020 21:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594497224;
        bh=v7VBriiEJK1VvvWtUbGoyuVU/XKa26GlA+c5Tn5HuyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAMTTmmhqN/GRYstM50KKuVWrn0GTFuW+4UeDvQcqeYHroeyps0/6Z5ir1FJuUwun
         G75OUzEjRXkv3az4Yb2GPwFBwXkHchiWTk6xP3rylgPqXfpgSCvvv2ZDPiKmTUFDhY
         c32up+U4txqKLJV3u3lR8enzlZHeicJWM5rLsLk8=
Date:   Sat, 11 Jul 2020 22:53:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v6 2/6] dmaengine: virt-dma: Use lockdep to check locking
 requirements
Message-ID: <20200711195338.GB5954@pendragon.ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-3-laurent.pinchart@ideasonboard.com>
 <c4ae1bd2-eafd-136e-71f6-1d85149d776a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4ae1bd2-eafd-136e-71f6-1d85149d776a@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Thu, Jul 09, 2020 at 04:07:38PM +0300, Peter Ujfalusi wrote:
> On 08/07/2020 23.19, Laurent Pinchart wrote:
> > A few virt-dma functions are documented as requiring the vc.lock to be
> > held by the caller. Check this with lockdep.
> > 
> > The vchan_vdesc_fini() and vchan_find_desc() functions gain a lockdep
> 
> vchan_vdesc_fini() is used outside of held vc->lock via vchan_complete()
> and the customized local re-implementation of it in ti/k3-udma.c
> 
> This patch did not adds the lockdep_assert_held() to the _fini.
> The vchan_complete() can be issue only in  case when the descriptor is
> set to DMA_CTRL_REUSE.

I'll drop the patch completely, I don't need it for this series. I still
think it's useful though, so if someone wants to pick it up and fix it,
please don't hesitate.

> > check as well, because, even though they are not documented with this
> > requirement (and not documented at all for the latter), they touch
> > fields documented as protected by vc.lock. All callers have been
> > manually inspected to verify they call the functions with the lock held.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/dma/virt-dma.c |  2 ++
> >  drivers/dma/virt-dma.h | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> > index 23e33a85f033..1cb36ab3d9c1 100644
> > --- a/drivers/dma/virt-dma.c
> > +++ b/drivers/dma/virt-dma.c
> > @@ -68,6 +68,8 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
> >  {
> >  	struct virt_dma_desc *vd;
> >  
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	list_for_each_entry(vd, &vc->desc_issued, node)
> >  		if (vd->tx.cookie == cookie)
> >  			return vd;
> > diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> > index e9f5250fbe4d..59d9eabc8b67 100644
> > --- a/drivers/dma/virt-dma.h
> > +++ b/drivers/dma/virt-dma.h
> > @@ -81,6 +81,8 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
> >   */
> >  static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
> >  {
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
> >  	return !list_empty(&vc->desc_issued);
> >  }
> > @@ -96,6 +98,8 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
> >  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> >  	dma_cookie_t cookie;
> >  
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	cookie = vd->tx.cookie;
> >  	dma_cookie_complete(&vd->tx);
> >  	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> > @@ -146,6 +150,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
> >  {
> >  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> >  
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	list_add_tail(&vd->node, &vc->desc_terminated);
> >  
> >  	if (vc->cyclic == vd)
> > @@ -160,6 +166,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
> >   */
> >  static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
> >  {
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	return list_first_entry_or_null(&vc->desc_issued,
> >  					struct virt_dma_desc, node);
> >  }
> > @@ -177,6 +185,8 @@ static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
> >  static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
> >  	struct list_head *head)
> >  {
> > +	lockdep_assert_held(&vc->lock);
> > +
> >  	list_splice_tail_init(&vc->desc_allocated, head);
> >  	list_splice_tail_init(&vc->desc_submitted, head);
> >  	list_splice_tail_init(&vc->desc_issued, head);

-- 
Regards,

Laurent Pinchart
