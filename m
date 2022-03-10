Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58364D50C3
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiCJRnP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbiCJRnL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:43:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1B13DE2D
        for <dmaengine@vger.kernel.org>; Thu, 10 Mar 2022 09:42:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so5328378pgn.2
        for <dmaengine@vger.kernel.org>; Thu, 10 Mar 2022 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PPQrHzg1RDdeLhtFhdnuQYSIQ6hbxsQcozaEjk0rKTc=;
        b=NT4G4OhHf0pNzBrjWY22EwZ+334hXYIAdDA3szv3lOp+Mv1TCwUd+8gwFSO+/gf7mG
         SVLygApkB1LZG3lo30ntnbPKFt4gemd5X+zmLmxhiCM7VT+9j+fnYRaD8cA4MBSJP8dy
         ihwAQHksyh00aYS7NjjCMEY5Uaj+WepWILaggX89XeXYlyuTURIWqUV9aa9yReYB/6MV
         6deooqP+5v+kYLyWE0WgJO5IpbthDaBxAIKKU71T2obDABC4mtVR0970LfnS6PHHxN95
         vLKhQrn4YoskOWmmLPcnGnBk/JQhji8JBypEY9abCNV51Jwj4Wy5OjEr13eL42RF0pB6
         1RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PPQrHzg1RDdeLhtFhdnuQYSIQ6hbxsQcozaEjk0rKTc=;
        b=BY6ct7+Jk+mu/k5UrWyMU1ymKArUNQnWgv8vIBmuyUeMMtQrMYxn9lnbwkckrzXJd4
         YD5/HsUKGD4HB649DZxLGx7ouav+mfr5ElLn6M18/9g0XRrnjKvgcG7ov/Eaa0eJCKGZ
         cIQA9KJquB0RuQdyZQxuqZtPmP6FEnSWwk+JoSZd942NDUoGOz/mevuoSAdSZ4i7ppw/
         Yiuh/cUMKnnenTMjrnL73Y+1RCE7f/oSgLAU99xJCtwZZyRAwaGStiQnqlkUMtWXAW/K
         9/Gwb3jHzEdkx0c7HHC10qyVaX76OO90RWKhtbmcUSziw/RAi/E9jX1KN0betwJ9zOs7
         SBiw==
X-Gm-Message-State: AOAM5301r9m47zh0Q9K/IV1KsC2Ns8RV2gg21d91ouNx1HTsgGBrVlSW
        TMwtFh+jJFNv5vNEfS+3zNTP
X-Google-Smtp-Source: ABdhPJxgmOVLg5W51riJwemoiqEV4yFlNNx7wZNqDsX+5ixCNLw0gGHal4UZaOCNmIRiT4fCTUsk7Q==
X-Received: by 2002:a63:7e44:0:b0:378:5645:90f6 with SMTP id o4-20020a637e44000000b00378564590f6mr4899912pgn.505.1646934126932;
        Thu, 10 Mar 2022 09:42:06 -0800 (PST)
Received: from thinkpad ([117.207.29.167])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f737480bb8sm7539431pfj.4.2022.03.10.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:42:06 -0800 (PST)
Date:   Thu, 10 Mar 2022 23:11:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 6/8] dmaengine: dw-edma: Don't rely on the deprecated
 "direction" member
Message-ID: <20220310174159.GF4869@thinkpad>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-7-Frank.Li@nxp.com>
 <20220310172930.g7xq3txjkbwtdmbw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310172930.g7xq3txjkbwtdmbw@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 08:29:30PM +0300, Serge Semin wrote:
> On Wed, Mar 09, 2022 at 03:12:02PM -0600, Frank Li wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > The "direction" member of the "dma_slave_config" structure is deprecated.
> > The clients no longer use this field to specify the direction of the slave
> > channel. But in the eDMA core, this field is used to differentiate between the
> > Root complex (remote) and Endpoint (local) DMA accesses.
> > 
> > Nevertheless, we can't differentiate between local and remote accesses without
> > a dedicated flag. So let's get rid of the old check and add a new check for
> > verifying the DMA operation between local and remote memory instead.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > no chang between v1 to v4
> >  drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 507f08db1aad3..47c6a52929fcd 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  	if (!chan->configured)
> >  		return NULL;
> >  
> > -	switch (chan->config.direction) {
> > -	case DMA_DEV_TO_MEM: /* local DMA */
> > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
> > -			break;
> > -		return NULL;
> > -	case DMA_MEM_TO_DEV: /* local DMA */
> > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
> > -			break;
> 
> > +	/* eDMA supports only read and write between local and remote memory */
> 
> The comment is a bit confusing because both cases are named as
> "memory" while the permitted directions contains DEV-part, which
> means "device". What I would suggest to write here is something like:
> "DW eDMA supports transferring data from/to the CPU/Application memory
> to/from the PCIe link partner device by injecting the PCIe MWr/MRd TLPs."
> 

End of the day, you'd be transferring data between remote and local memory
only and the terms (local and remote) are also used in the databook. So I think
the comment is fine.

Thanks,
Mani

> -Sergey
> 
> > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> >  		return NULL;
> > -	default: /* remote DMA */
> > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> > -			break;
> > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> > -			break;
> > -		return NULL;
> > -	}
> >  
> >  	if (xfer->type == EDMA_XFER_CYCLIC) {
> >  		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > -- 
> > 2.24.0.rc1
> > 
