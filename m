Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5C8F9F8
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 06:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfHPEoT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 00:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPEoT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Aug 2019 00:44:19 -0400
Received: from localhost (unknown [106.51.111.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE2B206C1;
        Fri, 16 Aug 2019 04:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565930657;
        bh=HoOiP4Os9/9fBa74N3hlSgQz1gtiyi53N9679RT9kfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AClldIkLtgr6Aw7Lzwr2ibQAoLDn7DS5kMi1dfVqMq8HSouTAgobXYCHzJCkopIRp
         DtIbTsmbT5akTq9h9QDrVVPqZooaqvOpskhXYRdEuQ+SAv7ZMvXJCH6GMJ5knWAJUB
         VZekHf5C8lqwCUnKsRPoB6m1gFNPpcmH9JkCRG3k=
Date:   Fri, 16 Aug 2019 10:13:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, orito.takao@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] dmaengine: milbeaut-hdmac: Add HDMAC driver for
 Milbeaut platforms
Message-ID: <20190816044304.GZ12733@vkoul-mobl.Dlink>
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
 <20190613005247.2048-1-jassisinghbrar@gmail.com>
 <20190624064442.GW2962@vkoul-mobl>
 <CABb+yY3pLBA=Y_4kUZ-E_VWOiJsofung2bMA5HqkNeNJkOOZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3pLBA=Y_4kUZ-E_VWOiJsofung2bMA5HqkNeNJkOOZxQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-08-19, 21:25, Jassi Brar wrote:
> On Mon, Jun 24, 2019 at 1:47 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 12-06-19, 19:52, jassisinghbrar@gmail.com wrote:
> >
> > > +#include <linux/bits.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/dmaengine.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_dma.h>
> >
> > Do we need both, IIRC of_dma.h does include of.h!
> >
> OK
> 
> > > +/* mc->vc.lock must be held by caller */
> > > +static void milbeaut_chan_start(struct milbeaut_hdmac_chan *mc,
> > > +                             struct milbeaut_hdmac_desc *md)
> > > +{
> > > +     struct scatterlist *sg;
> > > +     u32  cb, ca, src_addr, dest_addr, len;
> >            ^^
> > double space
> >
> OK
> 
> > > +static irqreturn_t milbeaut_hdmac_interrupt(int irq, void *dev_id)
> > > +{
> > > +     struct milbeaut_hdmac_chan *mc = dev_id;
> > > +     struct milbeaut_hdmac_desc *md;
> > > +     irqreturn_t ret = IRQ_HANDLED;
> > > +     u32 val;
> > > +
> > > +     spin_lock(&mc->vc.lock);
> > > +
> > > +     /* Ack and Disable irqs */
> > > +     val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACB);
> > > +     val &= ~(FIELD_PREP(MLB_HDMAC_SS, 0x7));
> >                                          ^^^^
> > Magic ..?
> >
> OK, will define a macro for 7
> 
> > > +static int milbeaut_hdmac_chan_pause(struct dma_chan *chan)
> > > +{
> > > +     struct virt_dma_chan *vc = to_virt_chan(chan);
> > > +     struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
> > > +     u32 val;
> > > +
> > > +     spin_lock(&mc->vc.lock);
> > > +     val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
> > > +     val |= MLB_HDMAC_PB;
> > > +     writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
> >
> > We really should have an updatel() and friends in kernel, feel free to
> > add in your driver though!
> >
> I'll pass on that for now.
> 
> > > +static int milbeaut_hdmac_chan_init(struct platform_device *pdev,
> > > +                                 struct milbeaut_hdmac_device *mdev,
> > > +                                 int chan_id)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct milbeaut_hdmac_chan *mc = &mdev->channels[chan_id];
> > > +     char *irq_name;
> > > +     int irq, ret;
> > > +
> > > +     irq = platform_get_irq(pdev, chan_id);
> > > +     if (irq < 0) {
> > > +             dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
> > > +                     chan_id);
> > > +             return irq;
> > > +     }
> > > +
> > > +     irq_name = devm_kasprintf(dev, GFP_KERNEL, "milbeaut-hdmac-%d",
> > > +                               chan_id);
> > > +     if (!irq_name)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = devm_request_irq(dev, irq, milbeaut_hdmac_interrupt,
> > > +                            IRQF_SHARED, irq_name, mc);
> >
> > I tend to dislike using devm_request_irq(), we have no control over when
> > the irq is freed and what is a spirious irq is running while we are
> > unrolling, so IMHO it make sense to free up and ensure all tasklets are
> > quiesced when remove returns
> >
> If the code is written clean and tight we need not be so paranoid.
> 
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     mc->mdev = mdev;
> > > +     mc->reg_ch_base = mdev->reg_base + MLB_HDMAC_CH_STRIDE * (chan_id + 1);
> > > +     mc->vc.desc_free = milbeaut_hdmac_desc_free;
> > > +     vchan_init(&mc->vc, &mdev->ddev);
> >
> > who kills the vc->task?
> >
> vchan_synchronize() called from milbeaut_hdmac_synchronize()

But that can be skipped by called, from driver pov we need to ensure
that it is killed

> > > +static int milbeaut_hdmac_remove(struct platform_device *pdev)
> > > +{
> > > +     struct milbeaut_hdmac_device *mdev = platform_get_drvdata(pdev);
> > > +     struct dma_chan *chan;
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * Before reaching here, almost all descriptors have been freed by the
> > > +      * ->device_free_chan_resources() hook. However, each channel might
> > > +      * be still holding one descriptor that was on-flight at that moment.
> > > +      * Terminate it to make sure this hardware is no longer running. Then,
> > > +      * free the channel resources once again to avoid memory leak.
> > > +      */
> > > +     list_for_each_entry(chan, &mdev->ddev.channels, device_node) {
> > > +             ret = dmaengine_terminate_sync(chan);
> > > +             if (ret)
> > > +                     return ret;
> > > +             milbeaut_hdmac_free_chan_resources(chan);
> > > +     }
> > > +
> > > +     of_dma_controller_free(pdev->dev.of_node);
> > > +     dma_async_device_unregister(&mdev->ddev);
> > > +     clk_disable_unprepare(mdev->clk);
> >
> > And as suspected we have active tasklets and irq at this time :(
> >
> Not sure how is that....

Since you use devm variants, and driver tasklet is not killed, irq can
be fired (spurious as well) and can run irq and schedule a tasklet. How
do you prevent that?

Thanks
-- 
~Vinod
