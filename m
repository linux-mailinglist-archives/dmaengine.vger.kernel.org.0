Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB527112EF2
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2019 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfLDPvU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Dec 2019 10:51:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfLDPvT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Dec 2019 10:51:19 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1icWvu-0001a8-IC; Wed, 04 Dec 2019 16:51:18 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1icWvs-0003qa-Pm; Wed, 04 Dec 2019 16:51:16 +0100
Date:   Wed, 4 Dec 2019 16:51:16 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>
Subject: Re: vchan helper broken wrt locking
Message-ID: <20191204155116.uqxioshtombxfe5g@pengutronix.de>
References: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
 <12ec3499-ac9a-2722-2052-02d77975c26c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ec3499-ac9a-2722-2052-02d77975c26c@ti.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:49:40 up 149 days, 21:59, 147 users,  load average: 0.08, 0.13,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 04, 2019 at 01:47:03PM +0200, Peter Ujfalusi wrote:
> Hi Sascha,
> 
> On 03/12/2019 13.50, Sascha Hauer wrote:
> > Hi All,
> > 
> > vc->desc_free() used to be called in non atomic context which makes
> > sense to me. This changed over time and now vc->desc_free() is sometimes
> > called in atomic context and sometimes not.
> > 
> > The story starts with 13bb26ae8850 ("dmaengine: virt-dma: don't always
> > free descriptor upon completion"). This introduced a vc->desc_allocated
> > list which is mostly handled with the lock held, except in vchan_complete().
> > vchan_complete() moves the completed descs onto a separate list for the sake
> > of iterating over that list without the lock held allowing to call
> > vc->desc_free() without lock. 13bb26ae8850 changes this to:
> > 
> > @@ -83,8 +110,10 @@ static void vchan_complete(unsigned long arg)
> >                 cb_data = vd->tx.callback_param;
> >  
> >                 list_del(&vd->node);
> > -
> > -               vc->desc_free(vd);
> > +               if (dmaengine_desc_test_reuse(&vd->tx))
> > +                       list_add(&vd->node, &vc->desc_allocated);
> > +               else
> > +                       vc->desc_free(vd);
> > 
> > vc->desc_free() is still called without lock, but the list operation is done
> > without locking as well which is wrong.
> 
> Hrm, yes all list operation against desc_* should be protected by the
> lock, it is a miss.
> 
> > Now with 6af149d2b142 ("dmaengine: virt-dma: Add helper to free/reuse a
> > descriptor") the hunk above was moved to a separate function
> > (vchan_vdesc_fini()). With 1c7f072d94e8 ("dmaengine: virt-dma: Support for
> > race free transfer termination") the helper is started to be called with
> > lock held resulting in vc->desc_free() being called under the lock as
> > well. It is still called from vchan_complete() without lock.
> 
> Right.
> I think the most elegant way to fix this would be to introduce a new
> list_head in virt_dma_chan, let's name it desc_terminated.
> 
> We would add the descriptor to this within vchan_terminate_vdesc() (lock
> is held).
> In vchan_synchronize() we would
> list_splice_tail_init(&vc->desc_terminated, &head);
> with the lock held and outside of the lock we free them up.
> 
> So we would put the terminated descs to the new list and free them up in
> synchronize.
> 
> This way the vchan_vdesc_fini() would be only called without the lock held.

Ok, this sounds like a plan. I'll try and make up a patch for this.

Thanks,
  Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
