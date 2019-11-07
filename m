Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E796F2507
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfKGCLo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:11:44 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35512 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfKGCLo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:11:44 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so361323ilp.2
        for <dmaengine@vger.kernel.org>; Wed, 06 Nov 2019 18:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj5nVV7hFwHQ61cfvcd7q5vRxcIEvVb9YfJiy7fOWvA=;
        b=QS6qH6KplAbzHfCsXrTMxGf7/EoowWyvJoRyUXZH5b5nSj1rJMvUcnL5KVNbQa9KdY
         N7i/quh0dY0FujcDlilijbFSYfm+WYVmUB93UA2Xy8j5TZaYNXzxMRgwikJx6kcbcwjZ
         +rW1WFH9ixpIEG9zzF8ddoItXj1z9E6alHN7AGV7acyoPCvPcI7sHP8ttXAIGmEAKtCK
         Hz0uyLuIhA5QFb+zP2QX1ZsobUpOaQQqodCyVcoolVvXWupcllpLHiVyiD2+A+Asc8d0
         /rB//XJsfvWLnv+UVN+KizmMR88BlZNGvmYMYj5nVVmpPKTZnYpRTre5rsbXzRdjcPfG
         0WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj5nVV7hFwHQ61cfvcd7q5vRxcIEvVb9YfJiy7fOWvA=;
        b=Y1827i5zm7Qx3hW8K2/UIqLUZMc1N9So4wo3RuGw7ENTgXc2Wn9sc3AxSeKcqNX/vE
         aU1QuQxLxPdekAr3mksm226pT9mx1m9naqfWs8+VjEiQ7iFk7G+kc6CNojtaJ9fweux7
         gpz4cpK81CX59FtB94eASg+lOXpgayR4Il+1U8ny1SbO/mpu6Mpo879MYCyYgbTSRvQR
         sZ4bX9Gjwkxl18wjqj795RZMHcG16aLSvxXyFOLrCoPEvB8BgHF6lFUj40K13qxd8ljA
         sRw9cAn9kw40QJtaP7cxddkSS12j4prkq/JxYD1UIdV8z0zfgSqSY2PnWUC5EEtOijBq
         TeOA==
X-Gm-Message-State: APjAAAUlfrWl1Njah5tuf7oiwgpXqtsPaWPj7m/OSEeNOwA6QSM9ytUa
        QXXmKqkHWCdU+EXYt6nMXkFvIluTc4366btxUzuWOg==
X-Google-Smtp-Source: APXvYqzyeDjr5TTdOJAdTcs2Mr8QC5C9jpLr0O1hsPKOR4KROaGVbyvqfBoBKMTT9YtrQzx5v4HhQifzo5shXhGLKpw=
X-Received: by 2002:a92:4555:: with SMTP id s82mr1356329ila.228.1573092702728;
 Wed, 06 Nov 2019 18:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20191028075658.12143-1-green.wan@sifive.com> <20191028075658.12143-4-green.wan@sifive.com>
 <20191105174823.GF952516@vkoul-mobl>
In-Reply-To: <20191105174823.GF952516@vkoul-mobl>
From:   Green Wan <green.wan@sifive.com>
Date:   Thu, 7 Nov 2019 10:11:33 +0800
Message-ID: <CAJivOr7ZGwm8Bp1oGcYQHkao2zr0GsMQrcdawMHukmeA8wYVnQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 6, 2019 at 1:48 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 28-10-19, 15:56, Green Wan wrote:
> > Add PDMA driver, sf-pdma, to enable DMA engine on HiFive Unleashed
> > Rev A00 board.
> >
> >  - Implement dmaengine APIs, support MEM_TO_MEM async copy.
> >  - Tested by DMA Test client
> >  - Supports 4 channels DMA, each channel has 1 done and 1 err
> >    interrupt connected to platform-level interrupt controller (PLIC).
> >  - Depends on DMA_ENGINE and DMA_VIRTUAL_CHANNELS
> >
> > The datasheet is here:
> >
> >   https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> >
> > Follow the DMAengine controller doc,
> > "./Documentation/driver-api/dmaengine/provider.rst" to implement DMA
> > engine. And use the dma test client in doc,
> > "./Documentation/driver-api/dmaengine/dmatest.rst", to test.
> >
> > Each DMA channel has separate HW regs and support done and error ISRs.
> > 4 channels share 1 done and 1 err ISRs. There's no expander/arbitrator
> > in DMA HW.
> >
> >    ------               ------
> >    |    |--< done 23 >--|ch 0|
> >    |    |--< err  24 >--|    |     (dma0chan0)
> >    |    |               ------
> >    |    |               ------
> >    |    |--< done 25 >--|ch 1|
> >    |    |--< err  26 >--|    |     (dma0chan1)
> >    |PLIC|               ------
> >    |    |               ------
> >    |    |--< done 27 >--|ch 2|
> >    |    |--< err  28 >--|    |     (dma0chan2)
> >    |    |               ------
> >    |    |               ------
> >    |    |--< done 29 >--|ch 3|
> >    |    |--< err  30 >--|    |     (dma0chan3)
> >    ------               ------
> >
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
>
> when did i provide this?
>
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Fixes: 31c3b98b5a01 ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
>
> Fixes what... this is not a upstream commit?
>

Since I received a RFC patch from kbuild with the fix commit number I
thought it was about merged. RFC requested to add the "Reported-by"
and "Fixes" but looks miss the contributor so I added them as well.
I'll remove them in next submit. Sorry for causing confusion.

> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > ---
>
> Please list the changes done from prev version, here or in cover letter
>
will add change log.

> > +static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
> > +{
> > +     struct sf_pdma_desc *desc;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&chan->lock, flags);
> > +
> > +     if (chan->desc && !chan->desc->in_use) {
> > +             spin_unlock_irqrestore(&chan->lock, flags);
> > +             return chan->desc;
> > +     }
> > +
> > +     spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +     desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> > +
>
> this empty line in not required
>
> > +static struct dma_async_tx_descriptor *
> > +     sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,
> > +                             dma_addr_t dest,
>
> please make it left justified

will fix.
>
> > +static int sf_pdma_slave_config(struct dma_chan *dchan,
> > +                             struct dma_slave_config *cfg)
> > +{
> > +     struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> > +
> > +     memcpy(&chan->cfg, cfg, sizeof(*cfg));
> > +     chan->dma_dir = DMA_MEM_TO_MEM;
>
> ?? looking at changelog we have only memcpy support, so this should not
> be here, pls remove this.
>
> > +static enum dma_status
> > +sf_pdma_tx_status(struct dma_chan *dchan,
> > +               dma_cookie_t cookie,
> > +               struct dma_tx_state *txstate)
> > +{
> > +     struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> > +     enum dma_status status;
> > +
> > +     status = dma_cookie_status(dchan, cookie, txstate);
> > +
> > +     if (txstate && status != DMA_ERROR)
> > +             dma_set_residue(txstate, sf_pdma_desc_residue(chan));
>
> which residue? the query can be for a cookie which is still in pending
> list! you need to check the cookie and only read register for cookie if
> submitted
>

WIll fix this.

> > +static int sf_pdma_remove(struct platform_device *pdev)
> > +{
> > +     struct sf_pdma *pdma = platform_get_drvdata(pdev);
> > +     struct sf_pdma_chan *ch;
> > +     int i;
> > +
> > +     for (i = 0; i < PDMA_NR_CH; i++) {
> > +             ch = &pdma->chans[i];
> > +
> > +             list_del(&ch->vchan.chan.device_node);
> > +             tasklet_kill(&ch->vchan.task);
> > +             tasklet_kill(&ch->done_tasklet);
> > +             tasklet_kill(&ch->err_tasklet);
>
> you have an isr registered which can fire and schedule tasklets..

will fix it by free irq first. Thanks for reviewing.

> --
> ~Vinod
