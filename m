Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8FF538AD8
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiEaFYH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiEaFYH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 01:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29989155B;
        Mon, 30 May 2022 22:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68E0861186;
        Tue, 31 May 2022 05:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A69FC385A9;
        Tue, 31 May 2022 05:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653974644;
        bh=K25t52uoCNYvpbrLQpbyibAodXjFdV5vwswnYCvnAS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbfNNbDisfkjIlr5el8eLItHfExKRxouOzQFTz3IXOPK5GxLJ/7y42vhbJ540tT7z
         ECvyb3tU88oyGuzT2uQXjilZJkYgxWoHHL9d7iRavTTqfq3w32fKXbhZJGzVC7hedC
         zfSM/eokCABKe0sUG8NWiqaqNiGpmijT1TeOKpEj5gtYGAs/Wcq1gEyfX/Ha90AyAt
         vYEKUDI1Aqcahh6wTtreeLtROTqh1TQDftikVx/wa8Wl6X3q024QYhzYe7R44fm0nc
         B60RLQp7trDb9lo2rsc9heRaqHESHWQDtP4TCKji+6qkaBtjx6uXsdQGw8W93ASWe5
         SEqO4WzP7XDfA==
Date:   Tue, 31 May 2022 10:54:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: add verification of DMA_INTERRUPT capability
 for dmatest
Message-ID: <YpWmcHtGzrv4oP5L@matsya>
References: <164978679251.2361020.5856734256126725993.stgit@djiang5-desk3.ch.intel.com>
 <CAMuHMdVjDTAW-84c9Fh21f_GWOhnD4+VW2nqSTQ6EK-m+KG=vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVjDTAW-84c9Fh21f_GWOhnD4+VW2nqSTQ6EK-m+KG=vQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-05-22, 10:06, Geert Uytterhoeven wrote:
> Hi Dave, Vinod,

Hi Geert,

> 
> On Wed, Apr 13, 2022 at 12:58 AM Dave Jiang <dave.jiang@intel.com> wrote:
> > Looks like I forgot to add DMA_INTERRUPT cap setting to the idxd driver and
> > dmatest is still working regardless of this mistake. Add an explicit check
> > of DMA_INTERRUPT capability for dmatest to make sure the DMA device being used
> > actually supports interrupt before the test is launched and also that the
> > driver is programmed correctly.
> >
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for your patch, which is now commit a8facc7b988599f8
> ("dmaengine: add verification of DMA_INTERRUPT capability for
> dmatest") upstream.
> 
> > --- a/drivers/dma/dmatest.c
> > +++ b/drivers/dma/dmatest.c
> > @@ -675,10 +675,16 @@ static int dmatest_func(void *data)
> >         /*
> >          * src and dst buffers are freed by ourselves below
> >          */
> > -       if (params->polled)
> > +       if (params->polled) {
> >                 flags = DMA_CTRL_ACK;
> > -       else
> > -               flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > +       } else {
> > +               if (dma_has_cap(DMA_INTERRUPT, dev->cap_mask)) {
> > +                       flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > +               } else {
> > +                       pr_err("Channel does not support interrupt!\n");
> > +                       goto err_pq_array;
> > +               }
> > +       }
> >
> >         ktime = ktime_get();
> >         while (!(kthread_should_stop() ||
> > @@ -906,6 +912,7 @@ static int dmatest_func(void *data)
> 
> Shimoda-san reports that this commit breaks dmatest on rcar-dmac.
> Like most DMA engine drivers, rcar-dmac does not set the DMA_INTERRUPT
> capability flag, hence dmatest now fails to start:
> 
>     dmatest: Channel does not support interrupt!
> 
> To me, it looks like the new check is bogus, as I believe it confuses
> two different concepts:
> 
>   1. Documentation/driver-api/dmaengine/provider.rst says:
> 
>        - DMA_INTERRUPT
> 
>          - The device is able to trigger a dummy transfer that will
>            generate periodic interrupts
> 
>   2. In non-polled mode, dmatest sets DMA_PREP_INTERRUPT.
>      include/linux/dmaengine.h says:
> 
>        * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon
> completion of
>        *  this transaction
> 
> As dmatest uses real transfers, I think it does not depend on
> the ability to use interrupts from dummy transfers.

Yes this does not look right to me. DMA_INTERRUPT is for a specific
capability which is linked to dma_prep_interrupt() which dmatest does
not use so i think it is not correct for dmatest to use this...

I can revert this patch... Dave?

-- 
~Vinod
