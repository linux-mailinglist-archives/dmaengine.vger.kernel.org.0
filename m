Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0530916DE2
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2019 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEGXhc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 19:37:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:9568 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGXhc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 19:37:32 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 May 2019 08:37:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5990A6117D;
        Wed,  8 May 2019 08:37:30 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 8 May 2019 08:37:30 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id F18AD40357;
        Wed,  8 May 2019 08:37:29 +0900 (JST)
Received: from localhost (unknown [10.213.234.103])
        by yuzu.css.socionext.com (Postfix) with ESMTPS id DA230121B6C;
        Wed,  8 May 2019 08:37:29 +0900 (JST)
Date:   Wed, 8 May 2019 08:37:29 +0900
From:   Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: milbeaut: Add Milbeaut AXI DMA controller
Message-ID: <20190507233729.GB3359@ubuntu>
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
 <1553487314-9185-3-git-send-email-kasai.kazuhiro@socionext.com>
 <20190426114629.GU28103@vkoul-mobl>
 <20190507053924.GA3359@ubuntu>
 <20190507171042.GS16052@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507171042.GS16052@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Thank you very much for quick response!
I appreciate your comments.

Maybe it takes long time, but I will try to write v2 patch with virt-dma.

On Tue, May 07, 2019 at 22:40 +0530, Vinod Koul wrote:
> On 07-05-19, 14:39, Kazuhiro Kasai wrote:
> > On Fri, Apr 26, 2019 at 17:16 +0530, Vinod Koul wrote:
> > > On 25-03-19, 13:15, Kazuhiro Kasai wrote:
>
> > > > +struct m10v_dma_chan {
> > > > +	struct dma_chan chan;
> > > > +	struct m10v_dma_device *mdmac;
> > > > +	void __iomem *regs;
> > > > +	int irq;
> > > > +	struct m10v_dma_desc mdesc;
> > >
> > > So there is a *single* descriptor? Not a list??
> >
> > Yes, single descriptor.
>
> And why is that, you can create a list and keep getting descriptors and
> issue them to hardware and get better pref!

I understand, thank you.

>
> > > > +static dma_cookie_t m10v_xdmac_tx_submit(struct dma_async_tx_descriptor *txd)
> > > > +{
> > > > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(txd->chan);
> > > > +	dma_cookie_t cookie;
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&mchan->lock, flags);
> > > > +	cookie = dma_cookie_assign(txd);
> > > > +	spin_unlock_irqrestore(&mchan->lock, flags);
> > > > +
> > > > +	return cookie;
> > >
> > > sounds like vchan_tx_submit() i think you can use virt-dma layer and then
> > > get rid of artificial limit in driver and be able to queue up the txn on
> > > dmaengine.
> >
> > OK, I will try to use virt-dma layer in next version.
>
> And you will get lists to manage descriptor for free! so you can use
> that to support multiple txns as well!

It sounds great! I start to study virt-dma layer for next version.

>
> > > > +static struct dma_async_tx_descriptor *
> > > > +m10v_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
> > > > +			   dma_addr_t src, size_t len, unsigned long flags)
> > > > +{
> > > > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
> > > > +
> > > > +	dma_async_tx_descriptor_init(&mchan->mdesc.txd, chan);
> > > > +	mchan->mdesc.txd.tx_submit = m10v_xdmac_tx_submit;
> > > > +	mchan->mdesc.txd.callback = NULL;
> > > > +	mchan->mdesc.txd.flags = flags;
> > > > +	mchan->mdesc.txd.cookie = -EBUSY;
> > > > +
> > > > +	mchan->mdesc.len = len;
> > > > +	mchan->mdesc.src = src;
> > > > +	mchan->mdesc.dst = dst;
> > > > +
> > > > +	return &mchan->mdesc.txd;
> > >
> > > So you support single descriptor and dont check if this has been already
> > > configured. So I guess this has been tested by doing txn one at a time
> > > and not submitted bunch of txn and wait for them to complete. Please fix
> > > that to really enable dmaengine capabilities.
> >
> > Thank you for advice. I want to fix it and I have 2 questions.
> >
> > 1. Does virt-dma layer help to fix this?
>
> Yes

It sounds very good news for me. Thank you.

>
> > 2. Can dmatest test that dmaengine capabilities?
>
> Yes for memcpy operations, see Documentation/driver-api/dmaengine/dmatest.rst
>

OK, I will read the document.

Thanks,
Kasai
