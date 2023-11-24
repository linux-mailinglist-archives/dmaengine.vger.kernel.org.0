Return-Path: <dmaengine+bounces-216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFAC7F737B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2276B212EB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF523768;
	Fri, 24 Nov 2023 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjFsjhJc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D820303;
	Fri, 24 Nov 2023 12:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98825C433C8;
	Fri, 24 Nov 2023 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700827900;
	bh=hUSNeT8w2Ovv/qRsF9dJwQ3T21rZ7awLhr/c8/siSeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjFsjhJcdh1kjeVJRqLvqBmHLs4+QeKFabtHHpvqWZ/Boaf/jqKpCKggvUdVkb9tV
	 /D8tU/7yDwqTsja4jZ97ifEMOtJkfWivJYMBG2+OJSoH5QwvtIkdVX90YO2Sf6cXgp
	 fh2HSVF5TWjSpwo4m1NRsSyrRUTWBYGL7ckc5Yz5P0Ki7Ti32oLYQ4wf/QS9Z0SHEf
	 15DHso6QUEGOZWQAijtG+krZPUHaPQqUOZv62NK0OqCgpCzvR8xN+rKzc1QDEoAuH7
	 qTCfwM4IgXEdLA/ZtD7XBr8P+pIljJZhK8p0+2iMB0U8JCGm4YojupWhaj8FknLrKX
	 OXjM3MGXJ9IKw==
Date: Fri, 24 Nov 2023 17:41:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: shravan chippa <shravan.chippa@microchip.com>
Cc: green.wan@sifive.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, conor+dt@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	nagasuresh.relli@microchip.com, praveen.kumar@microchip.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v4 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Message-ID: <ZWCS+ECGTgwVPR1u@matsya>
References: <20231031052753.3430169-1-shravan.chippa@microchip.com>
 <20231031052753.3430169-4-shravan.chippa@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031052753.3430169-4-shravan.chippa@microchip.com>

On 31-10-23, 10:57, shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Sifive platform dma does not allow out-of-order transfers,
> Add a PolarFire SoC specific compatible and code to support
> for out-of-order dma transfers

By default dma xtions are not supposed to be out of order, so why does
it make sense specifying that here?

> 
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
>  drivers/dma/sf-pdma/sf-pdma.h |  8 +++++++-
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 4c456bdef882..82ab12c40743 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -25,6 +25,8 @@
>  
>  #include "sf-pdma.h"
>  
> +#define PDMA_QUIRK_NO_STRICT_ORDERING   BIT(0)
> +
>  #ifndef readq
>  static inline unsigned long long readq(void __iomem *addr)
>  {
> @@ -66,7 +68,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
>  static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
>  			      u64 dst, u64 src, u64 size)
>  {
> -	desc->xfer_type = PDMA_FULL_SPEED;
> +	desc->xfer_type =  desc->chan->pdma->transfer_type;
>  	desc->xfer_size = size;
>  	desc->dst_addr = dst;
>  	desc->src_addr = src;
> @@ -520,6 +522,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
>  
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
> +	const struct sf_pdma_driver_platdata *ddata;
>  	struct sf_pdma *pdma;
>  	int ret, n_chans;
>  	const enum dma_slave_buswidth widths =
> @@ -545,6 +548,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  
>  	pdma->n_chans = n_chans;
>  
> +	pdma->transfer_type = PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
> +
> +	ddata  = device_get_match_data(&pdev->dev);
> +	if (ddata) {
> +		if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
> +			pdma->transfer_type &= ~PDMA_STRICT_ORDERING;
> +	}
> +
>  	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pdma->membase))
>  		return PTR_ERR(pdma->membase);
> @@ -632,9 +643,19 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct sf_pdma_driver_platdata mpfs_pdma = {
> +	.quirks = PDMA_QUIRK_NO_STRICT_ORDERING,
> +};
> +
>  static const struct of_device_id sf_pdma_dt_ids[] = {
> -	{ .compatible = "sifive,fu540-c000-pdma" },
> -	{ .compatible = "sifive,pdma0" },
> +	{
> +		.compatible = "sifive,fu540-c000-pdma",
> +	}, {
> +		.compatible = "sifive,pdma0",
> +	}, {
> +		.compatible = "microchip,mpfs-pdma",
> +		.data	    = &mpfs_pdma,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 5c398a83b491..267e79a5e0a5 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -48,7 +48,8 @@
>  #define PDMA_ERR_STATUS_MASK				GENMASK(31, 31)
>  
>  /* Transfer Type */
> -#define PDMA_FULL_SPEED					0xFF000008
> +#define PDMA_FULL_SPEED					0xFF000000
> +#define PDMA_STRICT_ORDERING				BIT(3)
>  
>  /* Error Recovery */
>  #define MAX_RETRY					1
> @@ -112,8 +113,13 @@ struct sf_pdma {
>  	struct dma_device       dma_dev;
>  	void __iomem            *membase;
>  	void __iomem            *mappedbase;
> +	u32			transfer_type;
>  	u32			n_chans;
>  	struct sf_pdma_chan	chans[];
>  };
>  
> +struct sf_pdma_driver_platdata {
> +	u32 quirks;
> +};
> +
>  #endif /* _SF_PDMA_H */
> -- 
> 2.34.1

-- 
~Vinod

