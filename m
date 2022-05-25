Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36F5338E3
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiEYI43 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiEYI42 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 04:56:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE3F67;
        Wed, 25 May 2022 01:56:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h10so2395811ljb.6;
        Wed, 25 May 2022 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=80aPqe+7Pw6vDZHIq4vmZmpzPyTskcXhhyN+lLUN030=;
        b=lnCZ97/1gpYTqqBwOO5aCiGlgYpDFzAdVm9dP47LqKGSWmHFYo6f0TOyKFjrjqFG3t
         VmfUNv5i9FRtx4jcSDF8cUOhNmZ+6evNl6L66zpOFreqtnJVe016NTy0IUDaZJgpZfnv
         tEDK19nwOkEaMFMF13lgoP0vYtLP9LH+Tz4u+5UERF+fGrUTbDqShxON803ze+X8V+MA
         k2Tj1Y7lg+bDFA9aKo8KCuI4GhpWvcGuoSOilNXaVS6ICQljhamzLhIQqDLzp1dfbcv/
         lCQ6gRWjqW1mZf96GC4Icn9J8FqsF77iwKMdWQ7qNPv3CUEXr/qa2ZwqAV57X03PG8+K
         n4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=80aPqe+7Pw6vDZHIq4vmZmpzPyTskcXhhyN+lLUN030=;
        b=uBOnARVIZljwNvV4KHAQqAIS1dEASyWNKUaWh8BPoTbmk8UmcZvAkGmuv0S/Nq0epP
         qpxu0yukKy32zFJc1WQYgiBomO72I/lNjgY1yOr0HPm8FTu4vPK60U5J2UAt7GywZMdN
         6kdaQvNySqusfa+2IBujcpoaRaKGk+FhgwC48LSbDRTZ4XeuZN2RNlJmgB2pbzXcj9lX
         msHuRRixve0D8iqeyH0C9m7+rG08LUqWh/jBaEVI3uJfJhBYTBjuXpxa9O6X3WyzBLoG
         cSzf2tFq7YqnYhWOzuGuD0Q/Fsow+38JGB+X+gRbJNIUHiH9bijsI5QmBc0vlkLfg3W9
         AK7g==
X-Gm-Message-State: AOAM533ElzIoX95qANKoDUvLfFY+LenWPGrehzUhHZ7OEJFLzPFLUVCM
        GF6H2Cl9gqp4SxV0AWYZFbU=
X-Google-Smtp-Source: ABdhPJxLVekLSEbQ5D9mfU6jcjvQKQZmERaUxmy/PahOXSMioMIo0S9I4CeYSQs6pkEjLyLBIGpx0g==
X-Received: by 2002:a05:651c:510:b0:254:11c:8376 with SMTP id o16-20020a05651c051000b00254011c8376mr2997413ljp.45.1653468985455;
        Wed, 25 May 2022 01:56:25 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651c102900b002509783c8f8sm2996277ljm.83.2022.05.25.01.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 01:56:24 -0700 (PDT)
Date:   Wed, 25 May 2022 11:56:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/26] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20220525085621.xvxnbvsddp6uqwpm@mobilestation>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-24-Sergey.Semin@baikalelectronics.ru>
 <20220524131959.GA5745@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524131959.GA5745@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 24, 2022 at 06:49:59PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 04, 2022 at 01:51:01AM +0300, Serge Semin wrote:
> > DW eDMA doesn't perform any translation of the traffic generated on the
> > CPU/Application side. It just generates read/write AXI-bus requests with
> > the specified addresses. But in case if the dma-ranges DT-property is
> > specified for a platform device node, Linux will use it to map the CPU
> > memory regions into the DMAable bus ranges. This isn't what we want for
> > the eDMA embedded into the locally accessed DW PCIe Root Port and
> > End-point. In order to work that around let's set the chan_dma_dev flag
> > for each DW eDMA channel thus forcing the client drivers to getting a
> > custom dma-ranges-less parental device for the mappings.
> > 
> > Note it will only work for the client drivers using the
> > dmaengine_get_dma_device() method to get the parental DMA device.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > ---
> > 
> > Changelog v2:
> > - Fix the comment a bit to being clearer. (@Manivannan)
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 6a8282eaebaf..908607785401 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -716,6 +716,21 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >  	if (chan->status != EDMA_ST_IDLE)
> >  		return -EBUSY;
> >  
> > +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> > +	 * controlled from the CPU/Application side since in that case
> > +	 * the local memory address is left untranslated.
> > +	 */
> > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> > +		dchan->dev->chan_dma_dev = true;
> > +
> > +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
> 

> I happen to test this series on Qcom ARM32 machine and it errors out during the
> compilation due to "dma_coherent" not available on !SWIOTLB ARM32 configs.

Nice catch! Thanks. I'll fix it in the next patchset version.

-Sergey

> 
> Thanks,
> Mani
> 
> > +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> > +					     dma_get_mask(chan->dw->chip->dev));
> > +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> > +	} else {
> > +		dchan->dev->chan_dma_dev = false;
> > +	}
> > +
> >  	pm_runtime_get(chan->dw->chip->dev);
> >  
> >  	return 0;
> > -- 
> > 2.35.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
