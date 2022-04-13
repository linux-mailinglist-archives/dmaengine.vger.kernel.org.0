Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D764FF380
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiDMJah (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDMJah (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 05:30:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D553E18
        for <dmaengine@vger.kernel.org>; Wed, 13 Apr 2022 02:28:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so1462537plg.5
        for <dmaengine@vger.kernel.org>; Wed, 13 Apr 2022 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28Y4AXGdOewpVRbXEjMGIX/ARjyRjAnOQvJcW1lvtng=;
        b=aoH8uHDmyBV4x+kmHMjd3YGeIrDr35G6Q4VH2Ht6mwvq0uZ5x01dqewBqYS1OIYi8i
         ehivk6aU08YPcpg+gP8ghWam0Zxf8rTnvBb1Lpg5BcQwFSoewoywcrugr8Y1wF1UNFD/
         5ZAOeyGB9VncmXh3soRJIVSKNJzY9HULt9mxuM86yxq6o+SsxcG+yQVmEcqkOafyzdvv
         zs1NqWwQAYofPvw4FuJ85FTHn1VMbV3zbHUKf9fwz1Q4RcfDNvvNFyLR7bVtA8vcm7P3
         XUAOEbzRrJEX6+Wz49llb97HA11FsDMqMTUxUKkQ4WBR1fns/ik/blR1KzT+XhwdQrYX
         NUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28Y4AXGdOewpVRbXEjMGIX/ARjyRjAnOQvJcW1lvtng=;
        b=VVRX527+ZWMBWnPnqnFNeZ6c/Lj4m5oOk+uMGXOwBvsK5VXoPGjcmSxRaigR3c29Hq
         +ydZQybNfA1VVZzO6+Fjz/jLSd3SkGNQGSwmsuf9q9NRhV7cZHmc59riescacnrQEUeK
         fqX4T2EERKfL6MkqtqJrdIjMF7FVfyKhwDndxoWCCC8AuQ7eKcMM1tLROXk4SidFqs7p
         CLMOHPiLkcBKIeBdDA4Fj/wdHtkqG4eKk5WkEQtsr15zCLeP6h8ezzmccjaGkTjW40e1
         uhzWZkAl8M7E48ogsrj0pAcEP5JXf1tIVsGDZU1Y7ZJrLW1JHtDcpSN7BwVSgJdVTTLg
         fBRQ==
X-Gm-Message-State: AOAM532MmSt9BKeqEN60yxOw+jytPB8O2+INQ8rczLv7SqelXkyVn2Nv
        OjTeUmCwNLqfRcen9Dkfuepw
X-Google-Smtp-Source: ABdhPJytshglGxi7FyS2HNDL5a7p0Ty+ck4P5FLk00+hKQ8AgjoveRHCKqEcQSUdgG66Evn2nfJeBA==
X-Received: by 2002:a17:90b:3502:b0:1c7:2920:7c5f with SMTP id ls2-20020a17090b350200b001c729207c5fmr9744138pjb.89.1649842096008;
        Wed, 13 Apr 2022 02:28:16 -0700 (PDT)
Received: from thinkpad ([117.207.28.99])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b001c6f4991cd4sm2224241pjb.45.2022.04.13.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:28:15 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:58:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20220413092808.GF2015@thinkpad>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
 <20220406152347.85908-8-Frank.Li@nxp.com>
 <20220413091837.an75fiqazjhpapf4@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413091837.an75fiqazjhpapf4@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 13, 2022 at 12:18:37PM +0300, Serge Semin wrote:
> On Wed, Apr 06, 2022 at 10:23:45AM -0500, Frank Li wrote:
> > Add a "flags" field to the "struct dw_edma_chip" so that the controller
> > drivers can pass flags that are relevant to the platform.
> > 
> > DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
> > locally. Local eDMA access doesn't require generating MSIs to the remote.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> > Change from v5 to v6
> >  - use enum instead of define
> 
> Hm, why have you decided to do that? I don't see a well justified
> reason to use the enumeration here, but see my next comment for
> details.

It was me who suggested using the enums for flags instead of defines.
Enums helps with kdoc and it also provides a neat way to group flags together.

> 
> > 
> > Change from v4 to v5
> >  - split two two patch
> >  - rework commit message
> > Change from v3 to v4
> > none
> > Change from v2 to v3
> >  - rework commit message
> >  - Change to DW_EDMA_CHIP_32BIT_DBI
> >  - using DW_EDMA_CHIP_LOCAL control msi
> >  - Apply Bjorn's comments,
> >         if (!j) {
> >                control |= DW_EDMA_V0_LIE;
> >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> >                                control |= DW_EDMA_V0_RIE;
> >         }
> > 
> >         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
> >               !IS_ENABLED(CONFIG_64BIT)) {
> >           SET_CH_32(...);
> >           SET_CH_32(...);
> >        } else {
> >           SET_CH_64(...);
> >        }
> > 
> > 
> > Change from v1 to v2
> > - none
> > 
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 9 ++++++---
> >  include/linux/dma/edma.h              | 9 +++++++++
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 8ddc537d11fd6..30f8bfe6e5712 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c

[...]

> > +	enum dw_edma_chip_flags	flags;
> 
> There is no point in having the named enumeration here since the flags
> field semantics is actually a bitfield rather than a single value. If
> you want to stick to the enumerated flags, then please use the
> anonymous enum like this:

I agree with using u32 for flags field but I don't agree with anonymous enums.
Enums with a name conveys information of what the enumerated types represent.
If you just look at your example below, it is difficult to guess the purpose of
this enum.

Thanks,
Mani

> +enum {
> +	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +};
> and explicit unsigned int type of the flags field.
> 
> -Sergey
> 
> >  
> >  	void __iomem		*reg_base;
> >  
> > -- 
> > 2.35.1
> > 
