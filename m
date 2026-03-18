Return-Path: <dmaengine+bounces-9505-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEQpB191ummTWwIAu9opvQ
	(envelope-from <dmaengine+bounces-9505-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 10:50:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD882B9671
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD8D303F7E5
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4D3A6EE8;
	Wed, 18 Mar 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz73OzDM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13E393DD4;
	Wed, 18 Mar 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827123; cv=none; b=dv1/DXg0S9NlOHxy04k/Brk1S1mBLMcOrxn31gl7BMwidyWP2CXryORCUI1FJqV0smT7O6iLj/clDv12KatvPYo+oKpJDqvsJyAJW72ljGTPDyeySpgyQYb77TljYxNKyvmNa3o9K2QlLNfC10RKYEQXVBZN05WQhdKlW0IoDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827123; c=relaxed/simple;
	bh=jJJAOAhyTb7bPZvt1p0uNhPirIqYdboc/W+YV/r/RrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmit8k6E6Rs+YlO2XxPGQyabzsYMRvb/pihud6Lfc5TDxs5KlP/t74NqVxB7ATCBWmBBW+Ojt1hCPbihdn7DQJtMW0OgiPRb1iH0Ysn69aPfBuqKKdaYbgt7K7PVKThggb2OYPr6DGZ9H/gL51xf46DJTSa4wGAawnIskNgmrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz73OzDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C928DC19421;
	Wed, 18 Mar 2026 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773827122;
	bh=jJJAOAhyTb7bPZvt1p0uNhPirIqYdboc/W+YV/r/RrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kz73OzDM1uf8dLgZbgCbf8SOlLGbo+YMZNROWSK/5BHoKTLHJfKMbiwaHRgrcZvS4
	 lvfHxyMWMAGT/oaU3tMW8m90MGfBTR8yQ/jSSj+m9DOX+Y0p/3AuPc4yDe2TtDp8U9
	 EXoC6RvoVREXHj58Iu6O956bSwcJqqM4NxkC2G3/FCfD/J2iw84Gvi4jRKsz2aDZ4r
	 Li4ucekRo/XZ24ENhh2txdBxIeehKNTLfHwXyOCgHgWD2WbnRUgfdCNkOKxCTs+azS
	 a9I+PDpOW5a3zmAPdmrsUngjEeBSyK+9wIn0nGF9lf3xnIDI74+MI5EMGYwdp5/FJb
	 J3QWpj4PbB1XA==
Date: Wed, 18 Mar 2026 15:15:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sheetal <sheetal@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Add error logging on failure
 paths
Message-ID: <abp0LhQf4gP0Vv0X@vaman>
References: <20260318073922.1760132-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318073922.1760132-1-sheetal@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9505-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CD882B9671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18-03-26, 07:39, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.

This fails to build. Please enable W=1 and send

drivers/dma/tegra210-adma.c: In function ‘tegra_adma_set_xfer_params’:
drivers/dma/tegra210-adma.c:677:39: error: format ‘%u’ expects argument of type ‘unsigned int’, but argument 3 has type ‘size_t’ {aka ‘long unsigned int’} [-Werror=format=]
  677 |                 dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",


> 
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 48 +++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..a50cd52fec18 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
>  	struct tegra_adma *tdma = tdc->tdma;
>  	unsigned int sreq_index = tdc->sreq_index;
>  
> -	if (tdc->sreq_reserved)
> -		return tdc->sreq_dir == direction ? 0 : -EINVAL;
> +	if (tdc->sreq_reserved) {
> +		if (tdc->sreq_dir != direction) {
> +			dev_err(tdma->dev,
> +				"DMA request direction mismatch: reserved=%s, requested=%s\n",
> +				dmaengine_get_direction_text(tdc->sreq_dir),
> +				dmaengine_get_direction_text(direction));
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
>  
>  	if (sreq_index > tdma->cdata->ch_req_max) {
>  		dev_err(tdma->dev, "invalid DMA request\n");
> @@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>  	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
>  	unsigned int burst_size, adma_dir, fifo_size_shift;
>  
> -	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
> +	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
> +		dev_err(tdc2dev(tdc), "invalid DMA periods %u (max %u)\n",
> +			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
>  		return -EINVAL;
> +	}
>  
>  	switch (direction) {
>  	case DMA_MEM_TO_DEV:
> @@ -1047,38 +1058,50 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
>  	if (res_page) {
>  		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
> -		if (IS_ERR(tdma->ch_base_addr))
> +		if (IS_ERR(tdma->ch_base_addr)) {
> +			dev_err(&pdev->dev, "failed to map page resource\n");
>  			return PTR_ERR(tdma->ch_base_addr);
> +		}
>  
>  		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>  		if (res_base) {
>  			resource_size_t page_offset, page_no;
>  			unsigned int ch_base_offset;
>  
> -			if (res_page->start < res_base->start)
> +			if (res_page->start < res_base->start) {
> +				dev_err(&pdev->dev, "invalid page/global resource order\n");
>  				return -EINVAL;
> +			}
> +
>  			page_offset = res_page->start - res_base->start;
>  			ch_base_offset = cdata->ch_base_offset;
>  			if (!ch_base_offset)
>  				return -EINVAL;
>  
>  			page_no = div_u64(page_offset, ch_base_offset);
> -			if (!page_no || page_no > INT_MAX)
> +			if (!page_no || page_no > INT_MAX) {
> +				dev_err(&pdev->dev, "invalid page number %llu\n", page_no);
>  				return -EINVAL;
> +			}
>  
>  			tdma->ch_page_no = page_no - 1;
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> +			if (IS_ERR(tdma->base_addr)) {
> +				dev_err(&pdev->dev, "failed to map global resource\n");
>  				return PTR_ERR(tdma->base_addr);
> +			}
>  		}
>  	} else {
>  		/* If no 'page' property found, then reg DT binding would be legacy */
>  		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		if (res_base) {
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> +			if (IS_ERR(tdma->base_addr)) {
> +				dev_err(&pdev->dev, "failed to map base resource\n");
>  				return PTR_ERR(tdma->base_addr);
> +			}
>  		} else {
> +			dev_err(&pdev->dev, "failed to map mem resource\n");
>  			return -ENODEV;
>  		}
>  
> @@ -1130,6 +1153,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  		tdc->irq = of_irq_get(pdev->dev.of_node, i);
>  		if (tdc->irq <= 0) {
>  			ret = tdc->irq ?: -ENXIO;
> +			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
>  			goto irq_dispose;
>  		}
>  
> @@ -1141,12 +1165,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "runtime PM resume failed: %d\n", ret);
>  		goto rpm_disable;
> +	}
>  
>  	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
>  		goto rpm_put;
> +	}
>  
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> -- 
> 2.17.1

-- 
~Vinod

