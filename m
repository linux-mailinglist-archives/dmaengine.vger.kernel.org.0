Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8807C4FF61A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiDMLz7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDMLz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 07:55:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04672DA96;
        Wed, 13 Apr 2022 04:53:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq30so3062713lfb.3;
        Wed, 13 Apr 2022 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dk5auBCWugUMx+wNUzpQYBvP/argsfGCd5qKpmD6z4U=;
        b=ABta0IUM2lxij+E/bvj7bKxQyXy4aHV/3JgS7tBITrzOrJJmRADvzE7cWSBC51L9Lm
         NCb6Xct6SgKjbzLNa5sX2Yb5i6hp8DU/n0ZTircS30BLKZi6b6uPiIEdpOXJlTGlzFdk
         EzuY3Uv1f3rDoO8RVyiMZFqqPN4JrLdpH5sRDmGsBFgU9/pdpDR0d4ojcZ9v6eqW54QG
         UkBC/48b2hgnACuW+YTTJRltUSUAE5V73CSILIscO5WFjsBFwNGNTISaI3AjwCJXvCdL
         s4B7UGsIT53I8vFTJNyPFQqyUR3hdi5KDQimEgQ/UnMh3bwddCVBfzpGenJrw7WWdl01
         +cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dk5auBCWugUMx+wNUzpQYBvP/argsfGCd5qKpmD6z4U=;
        b=ywadLHcKbXs2X5ngw6DhtJyf1AyrWefcYAOSKidwCbyxHFLUyWNz9hwJ2AUyoH62OM
         KDezx6JjRjm+zmw3RgGcof9Gry+M0slOnAp5nMFiUPAL/Cm7f2nUiajFGjJhTeuJMY7x
         gYch2GL+3HlQUDJsRy/KqTFN3PdEIuISgdrw+CQee1uQkfK/hmUKV+aPPczqa+XeYf0/
         DEScYX0Abs0hmwK/uoLQbhUr7Rfa3OXMMlP0tHxPoTyE9SWvaCywNKF3gHW5ZG+W0nZj
         mo7FKohdM1GJW1vJR/RnwqBy/cpiK9MmyUJuJa0lyLkIzD6kGcWz0q1541wU/adg0Nwt
         6GLQ==
X-Gm-Message-State: AOAM532hKW/eBepsX84Vx2nVZ9vOfvNLvckhK2NmyDp9KHktMlY7Duk4
        rZnz7vILaXNe0QLGlgxrkGt2FwvIkUvGew==
X-Google-Smtp-Source: ABdhPJzjXr6wNWDz5s/VL2yNUpjf7wzIpomsIZwKvlkwiy7xfu3UcOhinX1a8I6DeyLti+qEc/ZFqw==
X-Received: by 2002:a05:6512:10cc:b0:44a:24da:f621 with SMTP id k12-20020a05651210cc00b0044a24daf621mr27850223lfg.7.1649850815919;
        Wed, 13 Apr 2022 04:53:35 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25ca2000000b00464f83782efsm2069913lfq.116.2022.04.13.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:53:35 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:53:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Subject: Re: [PATCH v6 7/9] dmaengine: dw-edma: Add support for chip specific
 flags
Message-ID: <20220413115333.bc5g5vaxdygnbcuc@mobilestation>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
 <20220406152347.85908-8-Frank.Li@nxp.com>
 <20220413091837.an75fiqazjhpapf4@mobilestation>
 <20220413092808.GF2015@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413092808.GF2015@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 13, 2022 at 02:58:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 13, 2022 at 12:18:37PM +0300, Serge Semin wrote:
> > On Wed, Apr 06, 2022 at 10:23:45AM -0500, Frank Li wrote:
> > > Add a "flags" field to the "struct dw_edma_chip" so that the controller
> > > drivers can pass flags that are relevant to the platform.
> > > 
> > > DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
> > > locally. Local eDMA access doesn't require generating MSIs to the remote.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > > Change from v5 to v6
> > >  - use enum instead of define
> > 
> > Hm, why have you decided to do that? I don't see a well justified
> > reason to use the enumeration here, but see my next comment for
> > details.
> 
> It was me who suggested using the enums for flags instead of defines.
> Enums helps with kdoc and it also provides a neat way to group flags together.
> 
> > 
> > > 
> > > Change from v4 to v5
> > >  - split two two patch
> > >  - rework commit message
> > > Change from v3 to v4
> > > none
> > > Change from v2 to v3
> > >  - rework commit message
> > >  - Change to DW_EDMA_CHIP_32BIT_DBI
> > >  - using DW_EDMA_CHIP_LOCAL control msi
> > >  - Apply Bjorn's comments,
> > >         if (!j) {
> > >                control |= DW_EDMA_V0_LIE;
> > >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > >                                control |= DW_EDMA_V0_RIE;
> > >         }
> > > 
> > >         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
> > >               !IS_ENABLED(CONFIG_64BIT)) {
> > >           SET_CH_32(...);
> > >           SET_CH_32(...);
> > >        } else {
> > >           SET_CH_64(...);
> > >        }
> > > 
> > > 
> > > Change from v1 to v2
> > > - none
> > > 
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 9 ++++++---
> > >  include/linux/dma/edma.h              | 9 +++++++++
> > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 8ddc537d11fd6..30f8bfe6e5712 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> 
> [...]
> 

> > > +	enum dw_edma_chip_flags	flags;
> > 
> > There is no point in having the named enumeration here since the flags
> > field semantics is actually a bitfield rather than a single value. If
> > you want to stick to the enumerated flags, then please use the
> > anonymous enum like this:
> 
> I agree with using u32 for flags field but I don't agree with anonymous enums.
> Enums with a name conveys information of what the enumerated types represent.
> If you just look at your example below, it is difficult to guess the purpose of
> this enum.

I see your point. Ok, no anonymization then.) @Frank could you please update
the field type to unsigned int or u32 then? Personally I prefer having
"unsigned int" here, since that's the type used by the compiler if no
negative values is enumerated. Though u32 would be ok too.

-Serget

> 
> Thanks,
> Mani
> 
> > +enum {
> > +	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > +};
> > and explicit unsigned int type of the flags field.
> > 
> > -Sergey
> > 
> > >  
> > >  	void __iomem		*reg_base;
> > >  
> > > -- 
> > > 2.35.1
> > > 
