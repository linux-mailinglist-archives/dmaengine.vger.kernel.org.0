Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A84E6419
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 14:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350449AbiCXNbq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbiCXNbp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 09:31:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997E66616
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 06:30:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y6so2150723plg.2
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pg5zMHUoMOtfnb1TjqGEq+NoQ1459IJ3m+O0DUiruc0=;
        b=omvcrbN7lriPpSW5JaDifABkKoRy+47eDe5UOjgYcZYvGQlbPu6UX9LSEe8FXyZJsa
         iA4E7Y1dEpDv1TBqcgYb0x+NLebJXtHBP1M1Pcwa8JX29WOxvSReHn8/l0PVwcnvF430
         59aicx9zgfahnRG9MD556r2AI1GFa1lRuBvga4UxFpm3SaxZJ6ERW+ZXis8i/PwMdIbb
         02CFAatVGbDSo2MjvyGdNcdvX7Zu/dcFEHnuZJyddYEShRstLEZm6jwWWEi6M+VaOx3D
         2UW+1n54RTfwPrZEn29ASdd7e8IPfJBCHfwiJBaSJz5tNddYOfSfiVtIOtS1CxFICfb2
         InGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pg5zMHUoMOtfnb1TjqGEq+NoQ1459IJ3m+O0DUiruc0=;
        b=GvMHHUKBz7kM0eUAVVDFEiAQMxmAfO0Xhb8mltHUCRJQ2Zn29tOnCUvMb3OXVxrpSU
         PJUXYmS3IlcRWIPPS/8lqM3yA6SPjTOsErQZZ7eporjvwpzyd+hBQNBGssjUrYz1AC19
         Jle7YkidiDXL7sqvqTDY+PZ311hpXv53YrXjjse+ULsbvgRbDkWuqgAPChjNwVFHPh/E
         p1IsuNKE0SBwbljmGsrTXIV6Qs+whn1ZwUTUSVrsc5dXyf9tyx2a3INlNiLJ1V7aAH64
         KPQYqg31lPTW+5JRUaWS5ygXK7/hQy4Q4tuf1xmHz/Q8X3q+3lI83zvQavb7CavENJbK
         u6yA==
X-Gm-Message-State: AOAM5330QYf0y203ttKkGaemWA/aPyWFllxigHCIQC3sHmMs2meRz7jN
        sqQTTpBUMUsLnqlOLocckHvR
X-Google-Smtp-Source: ABdhPJxo834+q44cy6Y/VdrbWR6viwcZl217ze+h8Xiz6Pw+AFEkkQShW97freIJEBaF33PZjpG9Xw==
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id bj6-20020a170902850600b001548692a7acmr5896100plb.10.1648128611696;
        Thu, 24 Mar 2022 06:30:11 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b001c72b632222sm10085543pjb.32.2022.03.24.06.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:30:11 -0700 (PDT)
Date:   Thu, 24 Mar 2022 19:00:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] dmaengine: dw-edma: Drop
 dma_slave_config.direction field usage
Message-ID: <20220324133004.GM2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:12AM +0300, Serge Semin wrote:
> The dma_slave_config.direction field usage in the DW eDMA driver has been
> introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
> dma device transfer semantics"). Mainly the change introduced there was
> correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
> WR-channel for the case of having eDMA accessed locally from
> CPU/Application side), but providing an additional
> MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
> potentially harmful (when it comes to removing the denoted field). First
> of all since the dma_slave_config.direction field has been marked as
> obsolete (see [1] and the structure dc [2]) and will be discarded in
> future, using it especially in a non-standard way is discouraged. Secondly
> in accordance with the commit denoted above the default
> dw_edma_device_transfer() semantics has been changed despite what it's
> message said. So claiming that the method was left backward compatible was
> wrong.
> 
> Anyway let's fix the problems denoted above and simplify the
> dw_edma_device_transfer() method by dropping the parsing of the
> DMA-channel direction field. Instead of having that implicit
> dma_slave_config.direction field semantic we can use the recently added
> DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
> eDMA setups thus preserving both cases support. In addition to that an
> ASCII-figure has been added to clarify the complication out.
> 
> [1] Documentation/driver-api/dmaengine/provider.rst
> [2] include/linux/dmaengine.h: dma_slave_config.direction
> 
> Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> In accordance with agreement with Frank and Manivannan this patch is
> supposed to be moved to the series:
> Link: https://lore.kernel.org/dmaengine/20220310192457.3090-1-Frank.Li@nxp.com/
> in place of the patch:
> [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> Link: https://lore.kernel.org/dmaengine/20220310192457.3090-7-Frank.Li@nxp.com/
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 5be8a5944714..e9e32ed74aa9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -339,21 +339,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  	if (!chan->configured)
>  		return NULL;
>  
> -	switch (chan->config.direction) {
> -	case DMA_DEV_TO_MEM: /* local DMA */
> -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
> -			break;
> -		return NULL;
> -	case DMA_MEM_TO_DEV: /* local DMA */
> -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
> -			break;
> -		return NULL;
> -	default: /* remote DMA */
> -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> -			break;
> -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> -			break;
> -		return NULL;
> +	/*
> +	 * Local Root Port/End-point              Remote End-point
> +	 * +-----------------------+ PCIe bus +----------------------+
> +	 * |                       |    +-+   |                      |
> +	 * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
> +	 * |                       |    | |   |                      |
> +	 * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
> +	 * |                       |    +-+   |                      |
> +	 * +-----------------------+          +----------------------+
> +	 *
> +	 * 1. Normal logic:
> +	 * If eDMA is embedded into the DW PCIe RP/EP and controlled from the
> +	 * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be used
> +	 * for the device read operations (DEV_TO_MEM) and the Tx channel
> +	 * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
> +	 *
> +	 * 2. Inverted logic:
> +	 * If eDMA is embedded into a Remote PCIe EP and is controlled by the
> +	 * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
> +	 * channel (EDMA_DIR_WRITE) will be used for the device read operations
> +	 * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the write
> +	 * operations (MEM_TO_DEV).
> +	 *
> +	 * It is the client driver responsibility to choose a proper channel
> +	 * for the DMA transfers.
> +	 */

I think it'd be good to document this using some form in "enum dw_edma_dir"
declaration.

Thanks,
Mani

> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		if ((chan->dir == EDMA_DIR_READ && dir != DMA_DEV_TO_MEM) ||
> +		    (chan->dir == EDMA_DIR_WRITE && dir != DMA_MEM_TO_DEV))
> +			return NULL;
> +	} else {
> +		if ((chan->dir == EDMA_DIR_WRITE && dir != DMA_DEV_TO_MEM) ||
> +		    (chan->dir == EDMA_DIR_READ && dir != DMA_MEM_TO_DEV))
> +			return NULL;
>  	}
>  
>  	if (xfer->type == EDMA_XFER_CYCLIC) {
> -- 
> 2.35.1
> 
