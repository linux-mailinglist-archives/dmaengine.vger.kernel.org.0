Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27BCBF790
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 19:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfIZR2A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 13:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfIZR17 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 13:27:59 -0400
Received: from localhost (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE18222C7;
        Thu, 26 Sep 2019 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569518878;
        bh=+kUKKkoU3NS4CPTGiKMYje27qC3S1qVrJa2ymZOWb1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF+FcB0EzC9lgecWmuufTBcJm3gXe12+5aCwHz3lXh4wvUlPoycec36fWLFn5D7FD
         gzk9XufsonBHtFISX6/uU0CjFmFc3v0IEVIGc013P0sfJvPjFwWcjsGSRT7i+DLVd2
         OQSJHBKsVTJweTHoIc68DKf9s/UuxU71XABSzcHI=
Date:   Thu, 26 Sep 2019 10:26:57 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers <linux-hackers@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] dmaengine: sf-pdma: add platform DMA support for
 HiFive Unleashed A00
Message-ID: <20190926172657.GO3824@vkoul-mobl>
References: <20190920090205.19552-1-green.wan@sifive.com>
 <20190924212011.GG3824@vkoul-mobl>
 <CAJivOr4qZ7s20cME5=Fdw6G2-2JQGjO2ZT-ar2oHk3aad0R1gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJivOr4qZ7s20cME5=Fdw6G2-2JQGjO2ZT-ar2oHk3aad0R1gg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-19, 12:18, Green Wan wrote:
> Hi Vinod,
> 
> Thanks for the comments. Check my reply below.
> 
> On Wed, Sep 25, 2019 at 5:21 AM Vinod Koul <vkoul@kernel.org> wrote:
> 
> > Hi Green,
> >
> > On 20-09-19, 17:01, Green Wan wrote:
> >
> > Please make sure threading is *not* broken in your patch series. Atm
> > they are all over place in my mailbox!
> >
> > K, I'll check. Just simply git send to the list retrieved from "
> get_maintainer.pl".

Well I guess you used each patch on git-send, you should pass on the
whole series so that it threads as well

To test: you can send to yourself and check if threading is fine or not.

> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d0caa09a479e..c5f0662c9106 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14594,6 +14594,7 @@ F:    drivers/media/mmc/siano/
> > >  SIFIVE PDMA DRIVER
> > >  M:   Green Wan <green.wan@sifive.com>
> > >  S:   Maintained
> > > +F:   drivers/dma/sf-pdma/
> > >  F:   Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> >
> > What is this generated against, only one line?
> >
> > against patch v3 1/3. I split the maintainer modification into patch 1/3
> and 3/3 to make "checkpatch.pl --strict" zero warning for both of them. And
> to give info more specifically, I can add

Ah, Can you please add these changes in a separate patch at the end
please

> > > +                                chan->dma_dev_addr,
> > > +                                chan->dma_dev_size,
> > > +                                chan->dma_dir, 0);
> > > +     chan->dma_dir = DMA_NONE;
> > > +}
> > > +
> > > +static int sf_pdma_slave_config(struct dma_chan *dchan,
> > > +                             struct dma_slave_config *cfg)
> > > +{
> > > +     struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> > > +
> > > +     memcpy(&chan->cfg, cfg, sizeof(*cfg));
> > > +     sf_pdma_unprep_slave_dma(chan);
> >
> > Why unprep?
> >
> 
> I think the original idea from ./drivers/dma/fsl-edma* is to make sure the

We should fix that too!

> > > +static enum dma_status
> > > +sf_pdma_tx_status(struct dma_chan *dchan,
> > > +               dma_cookie_t cookie,
> > > +               struct dma_tx_state *txstate)
> > > +{
> > > +     struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
> > > +     enum dma_status status;
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&chan->lock, flags);
> > > +     if (chan->xfer_err) {
> > > +             chan->status = DMA_ERROR;
> > > +             spin_unlock_irqrestore(&chan->lock, flags);
> > > +             return chan->status;
> > > +     }
> > > +
> > > +     spin_unlock_irqrestore(&chan->lock, flags);
> > > +
> > > +     status = dma_cookie_status(dchan, cookie, txstate);
> > > +
> > > +     if (status == DMA_COMPLETE)
> > > +             return status;
> > > +
> > > +     if (!txstate)
> > > +             return chan->status;
> >
> > why not return status? Is that expected to be different than status?
> >
> >
> Depends on the value set by dma_cookie_status(). At the moment, the value
> of chan->status should be DMA_IN_PROGRESS till changed by
> sf_pdma_desc_residue() or set to DMA_ERROR by err ISR. The value could be
> different between status and chan->status.

In case !txstate there is no sf_pdma_desc_residue() so it doesnt make
sense to me to have return different things here!

-- 
~Vinod
