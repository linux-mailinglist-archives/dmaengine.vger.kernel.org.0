Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42924505A41
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345016AbiDROt2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345367AbiDROtA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 10:49:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF92654E;
        Mon, 18 Apr 2022 06:36:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g19so10337999lfv.2;
        Mon, 18 Apr 2022 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ctahVpxYVe7pa97C6ZwRQ8zFh/8uy2grZsYwheAauuE=;
        b=NxMyNxmv7McG7vfliC1sRp0myrwa6Wv7BfcUYKikzQmk5Mt510X3E+12/xtEyYLMfe
         GNuYAaVLux+ypQXaJJzRunyq+wC5RbMjsyTrCqfGs+c2oWrVJzmWqZRSpz11s9ix67hK
         u7cE+aTPuABrOJuDDLPbZAlpW17f4t1G6wDveD93J3bBsLVnE3Hjkgd0IR7hjog2ExRz
         Tx9s7Q6kk5FDd80+FIeyAGQA2tOgLViV1EGqlt+dV0SSLKv2+Izl9pbBq+xVxkqgRfTy
         nNJIPGlQ5DlotePRLQQLkox40caEv55Slmb+wQuQWdyMnnN6M7pRkLmEVPd7ePXhOCTn
         Jf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctahVpxYVe7pa97C6ZwRQ8zFh/8uy2grZsYwheAauuE=;
        b=4QydTPEl6l70aCX4yi09fLCIQ5lVvjm/vKlsuCOdIbBtQlvdQXoQ3x1+AenjeAtsSW
         n7IPa6Up/aeIu2zpse3Ahmbj/L6G84KCtZe5dpeMB9WS1ggEA4Ahtf3tO7ouRI3l4vEs
         DFbd4URriLcErmFblqs8Px5oRC6r3J+Hb0hUSKXrW3BNZI8vvGyZZ/rWvwRqGOyvEQMP
         ktudUaZyvjLvefuX1z9/NHTbf5PWDQmulQw/5R5e4CTpiG9qO39nlRGZ4O2vx28GcUmp
         dNEYI+7w7olijtjEIIj7EC0AtiL5XsIstbRa2QSnq6WzzMfIuOkYKHe4BHwlH2lb27YK
         JWRA==
X-Gm-Message-State: AOAM531v1/lEDuXVd3aBRbc/nj5RS1W7ZR2f2846tVCRAucm2aFRBytA
        Yo4eQmLZXRqex0yO0AdeGNIn8vs+azv0GQ==
X-Google-Smtp-Source: ABdhPJxqojB+379Aoz4aRU9p0SqnQukj3Oda4tTeABagBaaNG6KqN67puNwm0y9Ptz+xYXNKnB7few==
X-Received: by 2002:a19:6046:0:b0:46e:e5c5:12c2 with SMTP id p6-20020a196046000000b0046ee5c512c2mr7826936lfk.625.1650288976716;
        Mon, 18 Apr 2022 06:36:16 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id m17-20020a197111000000b0046d0f737777sm1221369lfc.178.2022.04.18.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:36:16 -0700 (PDT)
Date:   Mon, 18 Apr 2022 16:36:14 +0300
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
Subject: Re: [PATCH 23/25] dmaengine: dw-edma: Bypass dma-ranges mapping for
 the local setup
Message-ID: <20220418133614.atbndfymcn45i3id@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-24-Sergey.Semin@baikalelectronics.ru>
 <20220325181042.GA12218@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325181042.GA12218@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 11:40:42PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:34AM +0300, Serge Semin wrote:
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
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 72a51970bfba..ca5cd7c99571 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -716,6 +716,21 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >  	if (chan->status != EDMA_ST_IDLE)
> >  		return -EBUSY;
> >  
> > +	/* Bypass the dma-ranges based memory regions mapping since the
> > +	 * inbound iATU only affects the traffic incoming from the
> > +	 * PCIe bus.
> > +	 */
> 

> Bypass the dma-ranges based memory regions mapping since eDMA doesn't do any
> address translation for the CPU address?

Seems reasonable. I'll fix the comment to being clearer.

BTW since we omit setting the DMA_BYPASS flag of the outbound iATU
windows, the DMA address is actually affected by the DW PCIe
controller but in a bit of a sophisticated way. AFAIU if no DMA_BYPASS
flag specified and the resultant TLP address falls into any outbound
iATU window, the address will be translated in accordance with that
window translation rule. So happen the chains like this:
+ DMA write:
CPU memory <-,-> eDMA LLi:SAR(CPU address, data) -> eDMA LLi:DAR(DMA address, data) ->
Outbound iATU TLP MWr(PCIe address, data) -> PCIe memory.
+ DMA read:
eDMA SAR(DMA address, ?) -> Outbound iATU TLP MRd(PCIe address, ?) ->
PCIe memory -> Outbound iATU TLP MRd(PCIe address, data) -> eDMA
SAR(DMA address, data) -> eDMA DAR(CPU address, data) -> CPU memory

Due to that handy feature we don't need to search for the PCIe bus
memory range matching the passed source and destination DMA addresses
of the SG-lists. It is done by the Outbound iATU engine automatically.
If the DMA_BYPASS flag was set, all the Outbound iATU-related stages
would have been omitted from the diagram above and the DMA<->PCIe
translations would have needed to be performed in the eDMA driver
code.

-Sergey

> 
> Other than this,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> > +		dchan->dev->chan_dma_dev = true;
> > +
> > +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
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
