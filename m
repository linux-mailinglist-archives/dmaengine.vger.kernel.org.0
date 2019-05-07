Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF115B31
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 07:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfEGFj2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 01:39:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:58579 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfEGFj1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 01:39:27 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 May 2019 14:39:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A12B16117D;
        Tue,  7 May 2019 14:39:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 May 2019 14:39:25 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7B19A1A04E0;
        Tue,  7 May 2019 14:39:25 +0900 (JST)
Received: from localhost (unknown [10.213.234.103])
        by yuzu.css.socionext.com (Postfix) with ESMTPS id 656A7121B6C;
        Tue,  7 May 2019 14:39:25 +0900 (JST)
Date:   Tue, 7 May 2019 14:39:24 +0900
From:   Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 2/2] dmaengine: milbeaut: Add Milbeaut AXI DMA controller
Message-ID: <20190507053924.GA3359@ubuntu>
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
 <1553487314-9185-3-git-send-email-kasai.kazuhiro@socionext.com>
 <20190426114629.GU28103@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190426114629.GU28103@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Thank you very much for reviewing my patch.
Sorry for my late reply. Japan was in Spring Vacation.

On Fri, Apr 26, 2019 at 17:16 +0530, Vinod Koul wrote:
> On 25-03-19, 13:15, Kazuhiro Kasai wrote:
> > Add Milbeaut AXI DMA controller. This DMA controller has
> > only capable of memory to memory transfer.
>
> Have you tested this with dmatest?
Yes, I have tested this with dmatest.

I use dmatest with the following parameter.
>echo 10 > iterations
>echo "" > channel
>echo 1 > run

And I got the below report from dmatest.
[11675.231268] dmatest: dma0chan0-copy0: summary 10 tests, 0 failures 6910.84 iops 67035 KB/s (0)
[ 5646.689234] dmatest: dma0chan1-copy0: summary 10 tests, 0 failures 7949.12 iops 59618 KB/s (0)
[12487.712996] dmatest: dma0chan2-copy0: summary 10 tests, 0 failures 1493.87 iops 15088 KB/s (0)
[12487.733932] dmatest: dma1chan0-copy0: summary 10 tests, 0 failures 490.98 iops 3142 KB/s (0)
[11675.282428] dmatest: dma1chan2-copy0: summary 10 tests, 0 failures 7112.37 iops 56187 KB/s (0)
[ 5646.754230] dmatest: dma1chan3-copy0: summary 10 tests, 0 failures 6609.38 iops 61467 KB/s (0)
[ 5043.009255] dmatest: dma0chan3-copy0: summary 10 tests, 0 failures 498.08 iops 4183 KB/s (0)
[ 5043.018385] dmatest: dma1chan1-copy0: summary 10 tests, 0 failures 350.62 iops 3155 KB/s (0)

>
> > +struct m10v_dma_chan {
> > +	struct dma_chan chan;
> > +	struct m10v_dma_device *mdmac;
> > +	void __iomem *regs;
> > +	int irq;
> > +	struct m10v_dma_desc mdesc;
>
> So there is a *single* descriptor? Not a list??

Yes, single descriptor.

>
> > +static void m10v_xdmac_disable_dma(struct m10v_dma_device *mdmac)
> > +{
> > +	unsigned int val;
> > +
> > +	val = readl(mdmac->regs + M10V_XDACS);
> > +	val &= ~M10V_XDACS_XE;
> > +	val |= FIELD_PREP(M10V_XDACS_XE, 0);
> > +	writel(val, mdmac->regs + M10V_XDACS);
>
> Why not create a modifyl() macro and use it here

Thank you for advise, I will creat modifyl() macro and use it in next version.

>
> > +static void m10v_xdmac_issue_pending(struct dma_chan *chan)
> > +{
> > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
> > +
> > +	m10v_xdmac_config_chan(mchan);
> > +
> > +	m10v_xdmac_enable_chan(mchan);
>
> You dont check if anything is already running or not?

Yes, I think I don't need check if dma is running or not.
Because there's a single descriptor.

>
> > +static dma_cookie_t m10v_xdmac_tx_submit(struct dma_async_tx_descriptor *txd)
> > +{
> > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(txd->chan);
> > +	dma_cookie_t cookie;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&mchan->lock, flags);
> > +	cookie = dma_cookie_assign(txd);
> > +	spin_unlock_irqrestore(&mchan->lock, flags);
> > +
> > +	return cookie;
>
> sounds like vchan_tx_submit() i think you can use virt-dma layer and then
> get rid of artificial limit in driver and be able to queue up the txn on
> dmaengine.

OK, I will try to use virt-dma layer in next version.

>
> > +static struct dma_async_tx_descriptor *
> > +m10v_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
> > +			   dma_addr_t src, size_t len, unsigned long flags)
> > +{
> > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
> > +
> > +	dma_async_tx_descriptor_init(&mchan->mdesc.txd, chan);
> > +	mchan->mdesc.txd.tx_submit = m10v_xdmac_tx_submit;
> > +	mchan->mdesc.txd.callback = NULL;
> > +	mchan->mdesc.txd.flags = flags;
> > +	mchan->mdesc.txd.cookie = -EBUSY;
> > +
> > +	mchan->mdesc.len = len;
> > +	mchan->mdesc.src = src;
> > +	mchan->mdesc.dst = dst;
> > +
> > +	return &mchan->mdesc.txd;
>
> So you support single descriptor and dont check if this has been already
> configured. So I guess this has been tested by doing txn one at a time
> and not submitted bunch of txn and wait for them to complete. Please fix
> that to really enable dmaengine capabilities.

Thank you for advice. I want to fix it and I have 2 questions.

1. Does virt-dma layer help to fix this?
2. Can dmatest test that dmaengine capabilities?

>
> > +static int m10v_xdmac_remove(struct platform_device *pdev)
> > +{
> > +	struct m10v_dma_chan *mchan;
> > +	struct m10v_dma_device *mdmac = platform_get_drvdata(pdev);
> > +	int i;
> > +
> > +	m10v_xdmac_disable_dma(mdmac);
> > +
> > +	for (i = 0; i < mdmac->channels; i++) {
> > +		mchan = &mdmac->mchan[i];
> > +		devm_free_irq(&pdev->dev, mchan->irq, mchan);
> > +	}
>
> No call to dma_async_device_unregister()?

Thank you, I will call dma_async_device_unregister in next version.

Thanks,
Kasai

