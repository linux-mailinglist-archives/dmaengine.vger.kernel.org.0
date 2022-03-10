Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DB4D50E7
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbiCJRxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiCJRxd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:53:33 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81D64CE;
        Thu, 10 Mar 2022 09:52:31 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q10so8821873ljc.7;
        Thu, 10 Mar 2022 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yMflaALqNIK/uYdTmUhrkOZWhLjUgZsk7oLgGietDOI=;
        b=V3eZV4d6WEJn5p6GUuiJxDjVxhkHl6ZUt/D+Q/3SN4+yk30gsFXmEpln2l0W56lhM9
         qirkXX/6tqKtLWHNx5PbLR2nj0mJuC9wGaT267g+0bEwiI0Bankmq7DPzjQ+N1FTCDzr
         RQeYtFWCGxcavxNBP0c0z5+7yYL4LNKX88khLo49pYS0h9U+wYeiH8CvbRBV4RN0QeF0
         53sCHq4qfqEHluqi2GD/GaZITYSmI2Ca8T4UU9NCZ1aKey8ew2D7VDfM5KtArzuYjeNM
         6pgdbW7DrgxLA+IGEEv9Oo2jim1CEGwTdPfN+/YidH57DWXN5PZB/us3rUaRJR8vQv1K
         uAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yMflaALqNIK/uYdTmUhrkOZWhLjUgZsk7oLgGietDOI=;
        b=tZeOCpTZzFyABRVHJpMvbSDstsdDWPDAEH6f9I5H9jBHppi+S7fHmBcMJ2MzEFUGhs
         RWfK65ZUAA50EAJNCT2lCbsbHQULjeTRopp1PdTzKA4yOKfUlRXP+WhGg70t8UFVCoyX
         FlvYchIWnc4djcEstdLSe3kXfTDt0AsCHoH0tjq2axP5yguNcZJNwpHufXNeiRPlYfrd
         vTRdYZl49ZHCvR9Y3RspakX8rq96ULjEOztKHgbDgetc/qpvupKjNq2s7oawsiQkhaF2
         hjfBK0KVKesKrfQ2XV92+kshLUStR5EXicv+5ywzgNyqc8dJ4drujQnJWzhHSx6S36Sx
         lF1g==
X-Gm-Message-State: AOAM533KelJeE1g8NafjaUjjylKKFdgDqDwCaidZ8bbsBQPFJWEXdq7X
        75ynmoTAx7cj3SCN/b++2p8=
X-Google-Smtp-Source: ABdhPJwrR+ce4J6U5LpAOGcTNMb3ZzuUVAn0MxnLEehp7KYOfsDExg+WkCmoV10pUx0JOWwIqyRqYQ==
X-Received: by 2002:a05:651c:1a20:b0:247:ee55:76fb with SMTP id by32-20020a05651c1a2000b00247ee5576fbmr3752597ljb.89.1646934749517;
        Thu, 10 Mar 2022 09:52:29 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b00443d980bbaasm1093313lfc.96.2022.03.10.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:52:27 -0800 (PST)
Date:   Thu, 10 Mar 2022 20:52:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 6/8] dmaengine: dw-edma: Don't rely on the deprecated
 "direction" member
Message-ID: <20220310175225.66k6cor4afjlybew@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-7-Frank.Li@nxp.com>
 <20220310172930.g7xq3txjkbwtdmbw@mobilestation>
 <20220310174159.GF4869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310174159.GF4869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 11:11:59PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 10, 2022 at 08:29:30PM +0300, Serge Semin wrote:
> > On Wed, Mar 09, 2022 at 03:12:02PM -0600, Frank Li wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > The "direction" member of the "dma_slave_config" structure is deprecated.
> > > The clients no longer use this field to specify the direction of the slave
> > > channel. But in the eDMA core, this field is used to differentiate between the
> > > Root complex (remote) and Endpoint (local) DMA accesses.
> > > 
> > > Nevertheless, we can't differentiate between local and remote accesses without
> > > a dedicated flag. So let's get rid of the old check and add a new check for
> > > verifying the DMA operation between local and remote memory instead.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > no chang between v1 to v4
> > >  drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
> > >  1 file changed, 2 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 507f08db1aad3..47c6a52929fcd 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > >  	if (!chan->configured)
> > >  		return NULL;
> > >  
> > > -	switch (chan->config.direction) {
> > > -	case DMA_DEV_TO_MEM: /* local DMA */
> > > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
> > > -			break;
> > > -		return NULL;
> > > -	case DMA_MEM_TO_DEV: /* local DMA */
> > > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
> > > -			break;
> > 
> > > +	/* eDMA supports only read and write between local and remote memory */
> > 
> > The comment is a bit confusing because both cases are named as
> > "memory" while the permitted directions contains DEV-part, which
> > means "device". What I would suggest to write here is something like:
> > "DW eDMA supports transferring data from/to the CPU/Application memory
> > to/from the PCIe link partner device by injecting the PCIe MWr/MRd TLPs."
> > 
> 

> End of the day, you'd be transferring data between remote and local memory
> only and the terms (local and remote) are also used in the databook. So I think
> the comment is fine.

Yes, but the databook either adds a note regarding what memory it is
or it can be inferred from the text context. So at least it would be
appropriate to preserve the notes here two:
"eDMA supports only read and write between local (CPU/application) and
remote (PCIe/link partner) memory." Otherwise it's hard to understand
what memory the comment states about.

-Sergey

> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > >  		return NULL;
> > > -	default: /* remote DMA */
> > > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> > > -			break;
> > > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> > > -			break;
> > > -		return NULL;
> > > -	}
> > >  
> > >  	if (xfer->type == EDMA_XFER_CYCLIC) {
> > >  		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > > -- 
> > > 2.24.0.rc1
> > > 
