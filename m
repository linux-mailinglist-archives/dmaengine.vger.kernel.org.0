Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6724C4D8
	for <lists+dmaengine@lfdr.de>; Thu, 20 Aug 2020 19:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTRwj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHTRwh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Aug 2020 13:52:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19146C061385;
        Thu, 20 Aug 2020 10:52:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v16so1392341plo.1;
        Thu, 20 Aug 2020 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SO5U3LrCCVrf0dhuFlFyMlSOUAOsC6v7W5XQx077kFg=;
        b=Paw7cVq8IFNYWJuVDtDRqbXOeBEhfkSKmXF4VPw4sZ3HY7RS0bmIUeryQL9QLF9Ag1
         3JA54+ZzAsWPyuMqhr0rLj3AxuMlWxcc/G+HScpYXRhNpnIYw7/9HXs9yZAsawCVtD5t
         QWaJ7sgIwbwyqsXGvYGn/pBDcYVUqWGiLe7fjfnA9Hj37ghG03btEL4DNCNRr6GaW17p
         5E6bzkjwoABE59EcUkMP+6fLwQXH0YVXU+DcMdjD4DAcoNDk6aIDX1GcILDbJnx5hf8s
         LsZ2UQwJ3SxFes81ci5/BoKNPJLTIoV4OiRG8RoAqQiUe+fb0duAIFemxcuSx2ZKPoB0
         pYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SO5U3LrCCVrf0dhuFlFyMlSOUAOsC6v7W5XQx077kFg=;
        b=t8hReHGnbHo+gHUgfnfl7Kq0on2ZbDmCTFH7UX73A7Rm+ihISyreOKmA8BQJh5hfGU
         ByyrlV3MSE0bap6ncFK1+MWfUMaUITjlvrUw5vqUpC/IXnM7b6qvCANQg5Qa5bzc/19m
         n/Oe4uhrmALKu4M0odK6NIJ1xDfsw1VkWEpMH3dYgQwjv7WEvEurgIzov3P0cs7QQT5D
         jy80jtMf1r+zv1W1fQbG0w6bajg6jDYeBYSZWU8w47ObBnM11DFNwbAKTdzSVSm5W54j
         Vo6mpaCHQVPf59P/TGTKo89LaBm7FQv1S42epraYTcMkPGebjE6H6h/CdQq6H43+90U4
         AxLA==
X-Gm-Message-State: AOAM533wiRxGPqS9JGv7nudYy4+VdnDejNv+0SHCeyigjg/HUdFamth+
        RYIaGo7qIIKRhC8ZL3443g==
X-Google-Smtp-Source: ABdhPJzgjNLdGHMdCDp5swqoxlSW24QwZJ+2gkR4xTOfq2s5l36kJ4AyJCj3jEGPSK/jRxQQePOPjg==
X-Received: by 2002:a17:90a:3b09:: with SMTP id d9mr3533629pjc.210.1597945956504;
        Thu, 20 Aug 2020 10:52:36 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2409:4071:230b:2f0d:b051:6744:d734:a674])
        by smtp.gmail.com with ESMTPSA id d93sm2918274pjk.44.2020.08.20.10.52.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 10:52:35 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 20 Aug 2020 23:22:28 +0530
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     madhuparnabhowmik10@gmail.com, dan.j.williams@intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers/dma/dma-jz4780: Fix race condition between probe
 and irq handler
Message-ID: <20200820175228.GA7168@madhuparna-HP-Notebook>
References: <20200816072253.13817-1-madhuparnabhowmik10@gmail.com>
 <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM2DFQ.KQQJYLJ02WTD3@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 20, 2020 at 01:59:23PM +0200, Paul Cercueil wrote:
> Hi,
> 
> Le dim. 16 août 2020 à 12:52, madhuparnabhowmik10@gmail.com a écrit :
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > In probe IRQ is requested before zchan->id is initialized which can be
> > read in the irq handler. Hence, shift request irq and enable clock after
> > other initializations complete. Here, enable clock part is not part of
> > the race, it is just shifted down after request_irq to keep the error
> > path same as before.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> I don't think there is a race at all, the interrupt handler won't be called
> before the DMA is registered.
> 
> More importantly, this patch will break things, as there are now register
> writes in the probe before the clock is enabled.
>
Okay, thanks for reviewing the patch anyway, and sorry for the trouble.

Regards,
Madhuparna
> Cheers,
> -Paul
> 
> > ---
> >  drivers/dma/dma-jz4780.c | 44 ++++++++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> > index 448f663da89c..5cbc8c3bd6c7 100644
> > --- a/drivers/dma/dma-jz4780.c
> > +++ b/drivers/dma/dma-jz4780.c
> > @@ -879,28 +879,6 @@ static int jz4780_dma_probe(struct platform_device
> > *pdev)
> >  		return -EINVAL;
> >  	}
> > 
> > -	ret = platform_get_irq(pdev, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	jzdma->irq = ret;
> > -
> > -	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0,
> > dev_name(dev),
> > -			  jzdma);
> > -	if (ret) {
> > -		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> > -		return ret;
> > -	}
> > -
> > -	jzdma->clk = devm_clk_get(dev, NULL);
> > -	if (IS_ERR(jzdma->clk)) {
> > -		dev_err(dev, "failed to get clock\n");
> > -		ret = PTR_ERR(jzdma->clk);
> > -		goto err_free_irq;
> > -	}
> > -
> > -	clk_prepare_enable(jzdma->clk);
> > -
> >  	/* Property is optional, if it doesn't exist the value will remain 0.
> > */
> >  	of_property_read_u32_index(dev->of_node, "ingenic,reserved-channels",
> >  				   0, &jzdma->chan_reserved);
> > @@ -949,6 +927,28 @@ static int jz4780_dma_probe(struct platform_device
> > *pdev)
> >  		jzchan->vchan.desc_free = jz4780_dma_desc_free;
> >  	}
> > 
> > +	ret = platform_get_irq(pdev, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	jzdma->irq = ret;
> > +
> > +	ret = request_irq(jzdma->irq, jz4780_dma_irq_handler, 0,
> > dev_name(dev),
> > +			  jzdma);
> > +	if (ret) {
> > +		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
> > +		return ret;
> > +	}
> > +
> > +	jzdma->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(jzdma->clk)) {
> > +		dev_err(dev, "failed to get clock\n");
> > +		ret = PTR_ERR(jzdma->clk);
> > +		goto err_free_irq;
> > +	}
> > +
> > +	clk_prepare_enable(jzdma->clk);
> > +
> >  	ret = dmaenginem_async_device_register(dd);
> >  	if (ret) {
> >  		dev_err(dev, "failed to register device\n");
> > --
> > 2.17.1
> > 
> 
> 
