Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4C4F3EE0
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiDEOJE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356447AbiDELze (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 07:55:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D31034;
        Tue,  5 Apr 2022 04:15:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b43so16586854ljr.10;
        Tue, 05 Apr 2022 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KKe+mIlQBUIwvKVa06G3uVTMkCxHX4Htb5pg4RZxzhg=;
        b=ABQNLW/vYg5pYwMyN5PJmiwoIgtn/341GnSMHpr8eM1wWv71qL84BUvIqpRjesuXQ7
         KhkcHoiCFKYUzdoD9VbzOjGd3OLbpUBq32kRpvO9csu2LR0KLF2Slh3eSY2IAoNH/0Es
         xu69KfygMVU6oCHFQSuzwPlFtnM0Kzc5kamXFpsDpWopdejjIleUu7XXdEHAojgAgawd
         BF1MhWkCOV3gE6sUeEwDDRP6MPoBOJcgQdNDlhOP5WwMdrcNc6DL8x7dfo3KEQlbc5r5
         bCcA2crvKwe/9uPLyBKoo52sJb4Y5TlHeNC37vj8dlS41p1WeHUec+5eXX2Zf60yxZmh
         H9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KKe+mIlQBUIwvKVa06G3uVTMkCxHX4Htb5pg4RZxzhg=;
        b=43JibDKwqSldk/L5xfjs2AP4ziEGr1+75md3/vx4ECddvcGUuxrn4jECgdRZssyX2A
         YluAPObaf4EIIoufStVT6Z5/TMc/9wHlK3FPrWwQeRmvuPY5bUKGy2QNRqaowGRLNFPz
         b9Mb0qOqdupjrw+5/Hp5jKwMxpfjVKRvjtkX808mzLji9oLTz12rKqeqbNjAjeDNo7Os
         rEZuigQ5CLJNFsQOw0G/6PrS3O5lIcoIobr6cLSXZqYL39l2xkfaZVks25/TPc2+d9JR
         C+TT4b6vnbj/s3xPupzeqB0CXGXf+vjxmGd0FPVlLbrju4WAEAPcH4NTXKo12tNqf5zg
         mrWA==
X-Gm-Message-State: AOAM532VrnSAtSDR6A+JzVfZzis7icco6Sj6MTquVxgPH5dNrszqHU2Y
        Y6H5qWWZvi0co8Hm1+T0NjU=
X-Google-Smtp-Source: ABdhPJxSh27o37jD1zZo2k4S0Jf7NO6/98sGHWML8ZRw8+dIWO7pLj3iaVua1piJgAhMIorCsArSYw==
X-Received: by 2002:a2e:9f47:0:b0:24b:12a9:36dd with SMTP id v7-20020a2e9f47000000b0024b12a936ddmr1767594ljk.509.1649157340680;
        Tue, 05 Apr 2022 04:15:40 -0700 (PDT)
Received: from mobilestation ([85.249.23.165])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e94d7000000b0024b1565bba8sm717942ljh.118.2022.04.05.04.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:15:39 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:15:37 +0300
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
Subject: Re: [PATCH 01/25] dmaengine: dw-edma: Drop
 dma_slave_config.direction field usage
Message-ID: <20220405111537.5g6izfutmx5e4gkj@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-2-Sergey.Semin@baikalelectronics.ru>
 <20220324133004.GM2854@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324133004.GM2854@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 07:00:04PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:12AM +0300, Serge Semin wrote:
> > The dma_slave_config.direction field usage in the DW eDMA driver has been
> > introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
> > dma device transfer semantics"). Mainly the change introduced there was
> > correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
> > WR-channel for the case of having eDMA accessed locally from
> > CPU/Application side), but providing an additional
> > MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
> > potentially harmful (when it comes to removing the denoted field). First
> > of all since the dma_slave_config.direction field has been marked as
> > obsolete (see [1] and the structure dc [2]) and will be discarded in
> > future, using it especially in a non-standard way is discouraged. Secondly
> > in accordance with the commit denoted above the default
> > dw_edma_device_transfer() semantics has been changed despite what it's
> > message said. So claiming that the method was left backward compatible was
> > wrong.
> > 
> > Anyway let's fix the problems denoted above and simplify the
> > dw_edma_device_transfer() method by dropping the parsing of the
> > DMA-channel direction field. Instead of having that implicit
> > dma_slave_config.direction field semantic we can use the recently added
> > DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
> > eDMA setups thus preserving both cases support. In addition to that an
> > ASCII-figure has been added to clarify the complication out.
> > 
> > [1] Documentation/driver-api/dmaengine/provider.rst
> > [2] include/linux/dmaengine.h: dma_slave_config.direction
> > 
> > Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > In accordance with agreement with Frank and Manivannan this patch is
> > supposed to be moved to the series:
> > Link: https://lore.kernel.org/dmaengine/20220310192457.3090-1-Frank.Li@nxp.com/
> > in place of the patch:
> > [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > Link: https://lore.kernel.org/dmaengine/20220310192457.3090-7-Frank.Li@nxp.com/
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
> >  1 file changed, 34 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 5be8a5944714..e9e32ed74aa9 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -339,21 +339,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
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
> > -		return NULL;
> > -	default: /* remote DMA */
> > -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> > -			break;
> > -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> > -			break;
> > -		return NULL;
> > +	/*
> > +	 * Local Root Port/End-point              Remote End-point
> > +	 * +-----------------------+ PCIe bus +----------------------+
> > +	 * |                       |    +-+   |                      |
> > +	 * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
> > +	 * |                       |    | |   |                      |
> > +	 * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
> > +	 * |                       |    +-+   |                      |
> > +	 * +-----------------------+          +----------------------+
> > +	 *
> > +	 * 1. Normal logic:
> > +	 * If eDMA is embedded into the DW PCIe RP/EP and controlled from the
> > +	 * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be used
> > +	 * for the device read operations (DEV_TO_MEM) and the Tx channel
> > +	 * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
> > +	 *
> > +	 * 2. Inverted logic:
> > +	 * If eDMA is embedded into a Remote PCIe EP and is controlled by the
> > +	 * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
> > +	 * channel (EDMA_DIR_WRITE) will be used for the device read operations
> > +	 * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the write
> > +	 * operations (MEM_TO_DEV).
> > +	 *
> > +	 * It is the client driver responsibility to choose a proper channel
> > +	 * for the DMA transfers.
> > +	 */
> 

> I think it'd be good to document this using some form in "enum dw_edma_dir"
> declaration.

Well, I'd rather leave the comment here.  The dw_edma_dir enumeration
only defines the actual device channel direction, while the actual
semantics is determined by the PCIe device residence/configuration
(local + host/end-point, remote + end-point) and is reflected in the
data transfer function - dw_edma_device_transfer(). So as I see it the
comment is more suitable to be left here in the place where the
semantic is actually implemented.

-Sergey

> 
> Thanks,
> Mani
> 
> > +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> > +		if ((chan->dir == EDMA_DIR_READ && dir != DMA_DEV_TO_MEM) ||
> > +		    (chan->dir == EDMA_DIR_WRITE && dir != DMA_MEM_TO_DEV))
> > +			return NULL;
> > +	} else {
> > +		if ((chan->dir == EDMA_DIR_WRITE && dir != DMA_DEV_TO_MEM) ||
> > +		    (chan->dir == EDMA_DIR_READ && dir != DMA_MEM_TO_DEV))
> > +			return NULL;
> >  	}
> >  
> >  	if (xfer->type == EDMA_XFER_CYCLIC) {
> > -- 
> > 2.35.1
> > 
