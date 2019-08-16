Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA08F8D0
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 04:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHPCZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Aug 2019 22:25:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36901 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHPCZ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Aug 2019 22:25:57 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so3307099iog.4;
        Thu, 15 Aug 2019 19:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fibelXvW+1LdGP+tmxyfYovRPGaPOb71lYeqEJPE9w=;
        b=LvvLFypJqUtGcuZAf7ZZQjdIPS/eQWQeafYVUPKL0TI7ZJ3ta88iENF7vQ0U3UtOEe
         02YnSNW4M8rIg/utVyCb8+KAtzniL/7SQyZEBFlXCM+D+B1v7XrbE7hlJ6TE98z40BJD
         ZBIKgVBaJqaiq+sqCWlRDoXRmy8DkG6FuBGG6RHONt919JykRE3qnSXyUj3KOgJ4BmD2
         /+nmFsNnn/93bVI0P1voTaMAxIwmhLKwdryt9Xp+UVBlGoVMWEMHR7yf7nMuJBr4q7PB
         5Lyczt7kyUz9eR9fMBILvzTKdPYDd3AtHTXBKo+ijHKr5r6GuVgInnjZTmPvy0TYxAYg
         F/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fibelXvW+1LdGP+tmxyfYovRPGaPOb71lYeqEJPE9w=;
        b=otcjsziFZo+yxVUXINuDRuYcvRHz60rBxH6jcC3c9Ts8HvrXj65pLRW9jpQPoLe+4R
         kFX0FrNccEP5MKddfoTfHmCNGiaR7ylW5orfJ+em78AjcdFCy6bqrHqoNoLJPObjPNdg
         tAOOilP+PmuFDCPIkwLM1boZi5Vbch8igudzrFLJJRDy/FY0yVoaSFL/MguFkO+9l8IY
         3+12872h3OAUwci3ec6abFvXi28Wz3+/smL+OJUf41P2TLPtOpIoBnZspkr2tiOQmKtA
         JciP045UBUMNqCQ6T6rmRdXIA6hiuQk+jP7Fnh6PnWBXa+p3fRXW27BTrXKL/wm7qL5X
         1jaQ==
X-Gm-Message-State: APjAAAXkcSjg6X9miI61+UDANCCsZAOo6Dnr7yZXiZwIdWuBUBWGaB+c
        cPb3EUViHAXulCE2NGAHl7e2ZrMhRSPz0Bsqxu0=
X-Google-Smtp-Source: APXvYqyfmapAZhacZLbg2eN8uGz/g14h/u54c3qPjhPxRzsQXwC5ZPILLOCDagZSKqk7giCm7DH7ECRbNI8H/GXpZjk=
X-Received: by 2002:a02:8387:: with SMTP id z7mr1847813jag.117.1565922355684;
 Thu, 15 Aug 2019 19:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
 <20190613005247.2048-1-jassisinghbrar@gmail.com> <20190624064442.GW2962@vkoul-mobl>
In-Reply-To: <20190624064442.GW2962@vkoul-mobl>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 15 Aug 2019 21:25:44 -0500
Message-ID: <CABb+yY3pLBA=Y_4kUZ-E_VWOiJsofung2bMA5HqkNeNJkOOZxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: milbeaut-hdmac: Add HDMAC driver for
 Milbeaut platforms
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, orito.takao@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        kasai.kazuhiro@socionext.com,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 24, 2019 at 1:47 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 12-06-19, 19:52, jassisinghbrar@gmail.com wrote:
>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_dma.h>
>
> Do we need both, IIRC of_dma.h does include of.h!
>
OK

> > +/* mc->vc.lock must be held by caller */
> > +static void milbeaut_chan_start(struct milbeaut_hdmac_chan *mc,
> > +                             struct milbeaut_hdmac_desc *md)
> > +{
> > +     struct scatterlist *sg;
> > +     u32  cb, ca, src_addr, dest_addr, len;
>            ^^
> double space
>
OK

> > +static irqreturn_t milbeaut_hdmac_interrupt(int irq, void *dev_id)
> > +{
> > +     struct milbeaut_hdmac_chan *mc = dev_id;
> > +     struct milbeaut_hdmac_desc *md;
> > +     irqreturn_t ret = IRQ_HANDLED;
> > +     u32 val;
> > +
> > +     spin_lock(&mc->vc.lock);
> > +
> > +     /* Ack and Disable irqs */
> > +     val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACB);
> > +     val &= ~(FIELD_PREP(MLB_HDMAC_SS, 0x7));
>                                          ^^^^
> Magic ..?
>
OK, will define a macro for 7

> > +static int milbeaut_hdmac_chan_pause(struct dma_chan *chan)
> > +{
> > +     struct virt_dma_chan *vc = to_virt_chan(chan);
> > +     struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
> > +     u32 val;
> > +
> > +     spin_lock(&mc->vc.lock);
> > +     val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
> > +     val |= MLB_HDMAC_PB;
> > +     writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
>
> We really should have an updatel() and friends in kernel, feel free to
> add in your driver though!
>
I'll pass on that for now.

> > +static int milbeaut_hdmac_chan_init(struct platform_device *pdev,
> > +                                 struct milbeaut_hdmac_device *mdev,
> > +                                 int chan_id)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct milbeaut_hdmac_chan *mc = &mdev->channels[chan_id];
> > +     char *irq_name;
> > +     int irq, ret;
> > +
> > +     irq = platform_get_irq(pdev, chan_id);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
> > +                     chan_id);
> > +             return irq;
> > +     }
> > +
> > +     irq_name = devm_kasprintf(dev, GFP_KERNEL, "milbeaut-hdmac-%d",
> > +                               chan_id);
> > +     if (!irq_name)
> > +             return -ENOMEM;
> > +
> > +     ret = devm_request_irq(dev, irq, milbeaut_hdmac_interrupt,
> > +                            IRQF_SHARED, irq_name, mc);
>
> I tend to dislike using devm_request_irq(), we have no control over when
> the irq is freed and what is a spirious irq is running while we are
> unrolling, so IMHO it make sense to free up and ensure all tasklets are
> quiesced when remove returns
>
If the code is written clean and tight we need not be so paranoid.

> > +     if (ret)
> > +             return ret;
> > +
> > +     mc->mdev = mdev;
> > +     mc->reg_ch_base = mdev->reg_base + MLB_HDMAC_CH_STRIDE * (chan_id + 1);
> > +     mc->vc.desc_free = milbeaut_hdmac_desc_free;
> > +     vchan_init(&mc->vc, &mdev->ddev);
>
> who kills the vc->task?
>
vchan_synchronize() called from milbeaut_hdmac_synchronize()

> > +static int milbeaut_hdmac_remove(struct platform_device *pdev)
> > +{
> > +     struct milbeaut_hdmac_device *mdev = platform_get_drvdata(pdev);
> > +     struct dma_chan *chan;
> > +     int ret;
> > +
> > +     /*
> > +      * Before reaching here, almost all descriptors have been freed by the
> > +      * ->device_free_chan_resources() hook. However, each channel might
> > +      * be still holding one descriptor that was on-flight at that moment.
> > +      * Terminate it to make sure this hardware is no longer running. Then,
> > +      * free the channel resources once again to avoid memory leak.
> > +      */
> > +     list_for_each_entry(chan, &mdev->ddev.channels, device_node) {
> > +             ret = dmaengine_terminate_sync(chan);
> > +             if (ret)
> > +                     return ret;
> > +             milbeaut_hdmac_free_chan_resources(chan);
> > +     }
> > +
> > +     of_dma_controller_free(pdev->dev.of_node);
> > +     dma_async_device_unregister(&mdev->ddev);
> > +     clk_disable_unprepare(mdev->clk);
>
> And as suspected we have active tasklets and irq at this time :(
>
Not sure how is that....

thanks.
