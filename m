Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC410505A8F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiDRPJD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiDRPAk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 11:00:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07D44749;
        Mon, 18 Apr 2022 06:48:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq30so24251581lfb.3;
        Mon, 18 Apr 2022 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6s0/7WUuExY5QvSFDhYR/dpHqslKqd7vt8L+xMDv2JE=;
        b=TL1IYGp2O8w+kYDDIMZDkAEKiFssAm31h+fR00bd5XoL+N4k4crVR4UTGh4zQ++O4M
         GwOj7tgCREXNZzdTKIAoMXtC93wsHnKBvwfydzvnCMu7Gd/fZ48ZOvl59CDCZ2OwKyWz
         OWWzDyylTI5mFQENEr23TIkjholwEhJoW8l0jaezwPuMaBYi+OECdFxzziH+SaeQDWlP
         03FDYHvfAnqLsZNuIzmCFb0kpbLPghZ9y26gL2wqZtIOrBVvB9LP+TsZZwjeiqHERcCN
         Ya0Qj2Hr07Q5adp5WCFIyIA18SlS+Znl/YYTcSH+vwwJjCUssDFbJ2c6xdooGSU0xSEQ
         D+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6s0/7WUuExY5QvSFDhYR/dpHqslKqd7vt8L+xMDv2JE=;
        b=knj8smyO/iJAX4JhKQFb6QYZyJ2j08oYEDiJSDI+qpZ4x9XoFiVYJQLtXW5AKYygqk
         I4YvnJ7Mg7ya42GMs9jqWsBzggreoRICciNdS7keURqG3RtEWiFHevOxeNVshG93mk/S
         UD9LfQHNJlPkWnmA0p+uX/EiYSbDiNyTL6yp4I7z95Oo4j4nE3gpeFIwz9CQmAf8ekV8
         UZLA9qI7gbO3nYpH7xKrh/hk2TStrehTzlxjyk4ll7H5+k1fxnVpo7itisLQlWybXKPQ
         U72y0sqE+pP1K6eOwf0rwPFu5fZ5t+9n8dCHvngFTEIK+GR/XXgmRG7xGJnmGjjDOssx
         HQDA==
X-Gm-Message-State: AOAM5335ROnbKnfY/x9lkam9nkjp4fpDQSUr6cVRg2FPi275SVFOdRYj
        IYsov7DUFnOZQN0Vf6CRrdk=
X-Google-Smtp-Source: ABdhPJzXZq+JgJ1TYtSuJip4RD7L1lnwXQ/RuA+GOhavTrB4JiUxKTBEVI10LhyQeITFJbOJLZOdTg==
X-Received: by 2002:ac2:4e0f:0:b0:471:308f:1b9e with SMTP id e15-20020ac24e0f000000b00471308f1b9emr6079570lfr.514.1650289715822;
        Mon, 18 Apr 2022 06:48:35 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id t15-20020a2e9d0f000000b0024ad0cf21a5sm1182968lji.137.2022.04.18.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:48:35 -0700 (PDT)
Date:   Mon, 18 Apr 2022 16:48:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] dmaengine: dw-edma: Skip cleanup procedure if no
 private data found
Message-ID: <20220418134833.awogzzfq745mc5dm@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-25-Sergey.Semin@baikalelectronics.ru>
 <20220325181503.GB12218@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325181503.GB12218@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 11:45:03PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:35AM +0300, Serge Semin wrote:
> > DW eDMA driver private data is preserved in the passed DW eDMA chip info
> > structure. If either probe procedure failed or for some reason the passed
> > info object doesn't have private data pointer initialized we need to halt
> > the DMA device cleanup procedure in order to prevent possible system
> > crashes.
> > 
> 

> How come remove() could happen when probe() failed? If you hit this issue then
> something else is utterly going wrong.

It fully depends on the DW eDMA client driver implementation, which
can't and in general shouldn't be guessed. But what must be done in
the DW eDMA driver is a protection against the invalid data being
passed to the exported API methods. That wrong situation must be
detected and handled in the API user code. It's much easier to do by
having an error code returned from the dw_edma_remove() method than
catching random system crashes.

-Sergey

> 
> Thanks,
> Mani
> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index ca5cd7c99571..b932682a8ba8 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1030,6 +1030,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  	struct dw_edma *dw = chip->dw;
> >  	int i;
> >  
> > +	/* Skip removal if no private data found */
> > +	if (!dw)
> > +		return -ENODEV;
> > +
> >  	/* Disable eDMA */
> >  	dw_edma_v0_core_off(dw);
> >  
> > -- 
> > 2.35.1
> > 
