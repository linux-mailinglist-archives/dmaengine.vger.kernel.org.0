Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C474D5088
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiCJRai (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiCJRag (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:30:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6CBD31FB;
        Thu, 10 Mar 2022 09:29:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z11so10590586lfh.13;
        Thu, 10 Mar 2022 09:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCcJQMSaPqi5zt8beLRmZW0zLGixAnNgDgtiWNv73Rs=;
        b=ISQq8THvz/51DUMhVJ3UFf3Ho63QuDN/kRcpTlugmvqKPEbqM1q/rMng0POdpiQH7+
         eHWgM0UgfucUKetTOrVEjA4VheUOp3CwSu03WI1z3e8VRMUeORi80qXAHEAxWWo3HNeg
         oF2QPEr3K7f9otkKTOMhHdq3ESlicBx3CDQorgMikF3dnWIbKsqQZ4VQLZ/gTJZNA9eO
         nxovBAXQ5JYSh7J1FsmL9uaPNdImv4jRpIxeRbVo/Bg03xFdEvG1+CThPYrdgTMv+zFB
         5aSa/F+djggaJR6GXqBnWuttYazanYuB1UYfNfiN4oqivTQ1sUSJ/rqXOU4+dci7cmxi
         ZKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCcJQMSaPqi5zt8beLRmZW0zLGixAnNgDgtiWNv73Rs=;
        b=VMWQwQVxQslP39x/WQgOgwbu/cQ0T4cQ4hHto1fox+Rwnv+ww+7h3HesyeibyHnwOQ
         pUtnsXIE6He4ijeugIDJ2RkOO4hijvlTRb89WWAtIX7OAp9RsjWqSEhIe+GTsQlZ5AtT
         u/84s2EjMtZUH+KUj+GdcckyLk1YVWbNdWJOEBhKaQsV0jJhEH9GLO4bXDus08xzWv5F
         JYa+MBM3gAfEBltt3C6YKccOViKbPJWVR7zp/TpGRxl+kZzzqYY6kUD6v2wMFZZlEOwp
         bfaBcj+2SUI3FLcqXa859ISf0OOuQArjoTt9J7k7hnK/la1/7og+bBpdTPx/pw11R17U
         GhDA==
X-Gm-Message-State: AOAM532y68NcI6Z8LdujEptwOj39OC6NBpV14tL40lh4OdvfvA3wPffI
        pttXesLPj+juP87uZ3U5MHcm1pG2Bir0uw==
X-Google-Smtp-Source: ABdhPJy1JXlSLyEoN59U7UXV5OXbjbLlUYc1uwaDWO3g8d3m7WcrHEIflElLRjuyqx08dJxQSxDuYQ==
X-Received: by 2002:ac2:4c52:0:b0:448:27b1:8668 with SMTP id o18-20020ac24c52000000b0044827b18668mr3642876lfk.308.1646933373961;
        Thu, 10 Mar 2022 09:29:33 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id f8-20020a2eb5a8000000b00247eb1b937csm1181649ljn.127.2022.03.10.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:29:33 -0800 (PST)
Date:   Thu, 10 Mar 2022 20:29:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 6/8] dmaengine: dw-edma: Don't rely on the deprecated
 "direction" member
Message-ID: <20220310172930.g7xq3txjkbwtdmbw@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-7-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-7-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:12:02PM -0600, Frank Li wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> The "direction" member of the "dma_slave_config" structure is deprecated.
> The clients no longer use this field to specify the direction of the slave
> channel. But in the eDMA core, this field is used to differentiate between the
> Root complex (remote) and Endpoint (local) DMA accesses.
> 
> Nevertheless, we can't differentiate between local and remote accesses without
> a dedicated flag. So let's get rid of the old check and add a new check for
> verifying the DMA operation between local and remote memory instead.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> no chang between v1 to v4
>  drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 507f08db1aad3..47c6a52929fcd 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
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

> +	/* eDMA supports only read and write between local and remote memory */

The comment is a bit confusing because both cases are named as
"memory" while the permitted directions contains DEV-part, which
means "device". What I would suggest to write here is something like:
"DW eDMA supports transferring data from/to the CPU/Application memory
to/from the PCIe link partner device by injecting the PCIe MWr/MRd TLPs."

-Sergey

> +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
>  		return NULL;
> -	default: /* remote DMA */
> -		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
> -			break;
> -		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
> -			break;
> -		return NULL;
> -	}
>  
>  	if (xfer->type == EDMA_XFER_CYCLIC) {
>  		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> -- 
> 2.24.0.rc1
> 
