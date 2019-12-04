Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB5112D22
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2019 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLDOBS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Dec 2019 09:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDOBS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Dec 2019 09:01:18 -0500
Received: from localhost (unknown [122.178.246.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFEF205F4;
        Wed,  4 Dec 2019 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575468077;
        bh=61Cj72oRv0JHSjGbWXtj3mk2DE3IKgsrpLNIkbH/oys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOs0nTI8bdm2PZ8u8o30otqkwRisxRmEXBVm5xUSQlxxDsjNADfg2qA2s6sgbkvp0
         KwHWW42U3Nd6oB8xf+ByMLGpVYZLNdpww93Jp5Hd7/yFjGEx4meGrC5xq4CUy990dd
         NMVv2j8j4h76SAK6znUogXcbv3NCEpd3oiSoWwHg=
Date:   Wed, 4 Dec 2019 19:31:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, dmaengine@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>
Subject: Re: vchan helper broken wrt locking
Message-ID: <20191204140112.GD82508@vkoul-mobl>
References: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
 <12ec3499-ac9a-2722-2052-02d77975c26c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12ec3499-ac9a-2722-2052-02d77975c26c@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-12-19, 13:47, Peter Ujfalusi wrote:
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

This makes sense to me as well. I would like the vc->desc_free() to be
always called with lock and in non-atomic context.
> 
> > I think vc->desc_free() being called under a spin_lock is unfortunate as
> > the i.MX SDMA driver does a dma_free_coherent() there which is required
> > to be called with interrupts enabled.
> 
> In the in review k3-udma driver I use dma_pool or dma_alloc_coherent in
> mixed mode depending on the type of the channel.
> 
> I did also see the same issue and what I ended up doing is to have
> desc_to_purge list and udma_purge_desc_work()
> in udma_desc_free() if the descriptor is from the dma_pool, I free it
> right away, if it needs dma_free_coherent() then I put it to the
> desc_to_purge list and schedule the purge worker to deal with them at a
> later time.
> 
> In this driver I don't use vchan_terminate_vdesc() because of this.
> 
> > I am not sure where to go from here hence I'm writing this mail. Do we
> > agree that vc->desc_free() should be called without lock?
> 
> I think it should be called without the lock held.
> 
> > 
> > Sascha
> > 
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
