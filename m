Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F46552510A
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355835AbiELPQZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355828AbiELPQW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 11:16:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CFE24944
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:16:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv2so5445450pjb.4
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uDcp7Fr6kVrbDckvqemxf1bjJUOb2sUHGZ/gB3g+T9Q=;
        b=i7IDKf7c84d+to1uFHsDJd7dZ9+pzQmyk8p6VQgI19pCi+SOPT9lzMQaa1qbo1ei6r
         je+bc6hntQYIf4MxN5Q8C2F/kPyNnOdoqjYlP2EG4mGlEUDvEB+z1vmuC01Ll0XjDYlX
         KjQ6Td0YTl+u6iJMyWPIVbC5rYDCIXLOylsBXejXnVr8Z8E9if/bnGHzYnztn278UgCw
         CrTuTiNeR9xAybfnOg6TCzvmAaN4y21yhM4hMZDCOrLhPko5YrvjD8WloCpsIEZIIikS
         YT+Chpqj7lEbbxDfGLG7sLaVSGzZLU6qTkcwABSafQ5JOBvLBYJuawjRoHFhxaEIw/vL
         cEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uDcp7Fr6kVrbDckvqemxf1bjJUOb2sUHGZ/gB3g+T9Q=;
        b=1E08vnevtj/3YPbP7K9yGD1UWrNx13JmClyZP57ovsEBW8xEoHneYHzygnNLp+fxj2
         V95UBIUNUNJBSB5ulYO97DY14vygswwzF4zdugtkTubYPx+jf2fLN0rq2nsCb8URTBAK
         XjfLJZ8zzzl4QtwncSQmDKlv45jN9vzK+VP1e+ECTdLrWV7LNPrM0MKF0QT3pmBNaQij
         vJUYNlbCwg2QdoU13/nSHuMPgVodwF2F+07ySC8XORb9IxDA8ntu32hZ3VCzqa5JjydC
         XZjSTOW2gg2uqQheK6jCkZCQROfIYp3Ca8QeZzcOjHdv/wCFebZF1O/bUgbmsanW7OzT
         jTwQ==
X-Gm-Message-State: AOAM5328PEpRHv8kDztrBhFM62JzDLBh9JwVPJgUUIMcGWaGiBYORVYv
        SnA3AQBvizMln4xVKU+T8qBf
X-Google-Smtp-Source: ABdhPJx9TY0e+Bz8FwfX0si04XSocPxFrp3V8rEkPklcxoR2ntfaEXu9MtW7iABywOeA2JKpwCpnmg==
X-Received: by 2002:a17:903:1cd:b0:15e:8c4a:c543 with SMTP id e13-20020a17090301cd00b0015e8c4ac543mr423157plh.126.1652368580393;
        Thu, 12 May 2022 08:16:20 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b0015e8d4eb238sm28599plb.130.2022.05.12.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:16:19 -0700 (PDT)
Date:   Thu, 12 May 2022 20:46:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/26] dmaengine: dw-edma: Fix invalid interleaved
 xfers semantics
Message-ID: <20220512151611.GJ35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:45AM +0300, Serge Semin wrote:
> The interleaved DMA transfer support added in commit 85e7518f42c8
> ("dmaengine: dw-edma: Add device_prep_interleave_dma() support") seems
> contradicting to what the DMA-engine defines. The next conditional
> statements:
> 	if (!xfer->xfer.il->numf)
> 		return NULL;
> 	if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
> 		return NULL;
> basically mean that numf can't be zero and frame_size must always be zero,
> otherwise the transfer won't be executed. But further the transfer
> execution method takes the frames size from the
> dma_interleaved_template.sgl[] array for each frame. That array in
> accordance with [1] is supposed to be of
> dma_interleaved_template.frame_size size, which as we discovered before
> the code expects to be zero. So judging by the dw_edma_device_transfer()
> implementation the method implies the dma_interleaved_template.sgl[] array
> being of dma_interleaved_template.numf size, which is wrong. Since the
> dw_edma_device_transfer() method doesn't permit
> dma_interleaved_template.frame_size being non-zero then actual multi-chunk
> interleaved transfer turns to be unsupported even though the code implies
> having it supported.
> 
> Let's fix that by adding a fully functioning support of the interleaved
> DMA transfers. First of all dma_interleaved_template.frame_size is
> supposed to be greater or equal to one thus having at least simple linear
> chunked frames. Secondly we can create a walk-through all over the chunks
> and frames just by initializing the number of the eDMA burst transactios
> as a multiple of dma_interleaved_template.numf and
> dma_interleaved_template.frame_size and getting the frame_size-modulo of
> the iteration step as an index of the dma_interleaved_template.sgl[]
> array. The rest of the dw_edma_device_transfer() method code can be left
> unchanged.
> 
> [1] include/linux/dmaengine.h: doc struct dma_interleaved_template
> 
> Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 225eab58acb7..ef49deb5a7f3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -333,6 +333,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  	struct dw_edma_chunk *chunk;
>  	struct dw_edma_burst *burst;
>  	struct dw_edma_desc *desc;
> +	size_t fsz = 0;
>  	u32 cnt = 0;
>  	int i;
>  
> @@ -382,9 +383,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		if (xfer->xfer.sg.len < 1)
>  			return NULL;
>  	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
> -		if (!xfer->xfer.il->numf)
> -			return NULL;
> -		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
> +		if (!xfer->xfer.il->numf || xfer->xfer.il->frame_size < 1)
>  			return NULL;
>  		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
>  			return NULL;
> @@ -414,10 +413,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		cnt = xfer->xfer.sg.len;
>  		sg = xfer->xfer.sg.sgl;
>  	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
> -		if (xfer->xfer.il->numf > 0)
> -			cnt = xfer->xfer.il->numf;
> -		else
> -			cnt = xfer->xfer.il->frame_size;
> +		cnt = xfer->xfer.il->numf * xfer->xfer.il->frame_size;
> +		fsz = xfer->xfer.il->frame_size;
>  	}
>  
>  	for (i = 0; i < cnt; i++) {
> @@ -439,7 +436,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		else if (xfer->type == EDMA_XFER_SCATTER_GATHER)
>  			burst->sz = sg_dma_len(sg);
>  		else if (xfer->type == EDMA_XFER_INTERLEAVED)
> -			burst->sz = xfer->xfer.il->sgl[i].size;
> +			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
>  
>  		chunk->ll_region.sz += burst->sz;
>  		desc->alloc_sz += burst->sz;
> @@ -482,10 +479,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  
>  		if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
>  			sg = sg_next(sg);
> -		} else if (xfer->type == EDMA_XFER_INTERLEAVED &&
> -			   xfer->xfer.il->frame_size > 0) {
> +		} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
>  			struct dma_interleaved_template *il = xfer->xfer.il;
> -			struct data_chunk *dc = &il->sgl[i];
> +			struct data_chunk *dc = &il->sgl[i % fsz];
>  
>  			src_addr += burst->sz;
>  			if (il->src_sgl)
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
