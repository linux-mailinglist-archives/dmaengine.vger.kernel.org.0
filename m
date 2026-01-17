Return-Path: <dmaengine+bounces-8319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB4D38DF6
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B55300980B
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC292DE719;
	Sat, 17 Jan 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM7IEuum"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DB1B4156;
	Sat, 17 Jan 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647805; cv=none; b=EZ3xITPauzyQcuI8gxFlYo6e7jsb2GDouKUZ4lK12V2sbzVRjMhV6ezdCEfRHUIKRdSnraZF4T40uHfYUVtLFRomHs9yhBtB6W144vIy5iyx3/v7E3YAJjwiVFW4dQmk/U79dZX902h4Le/8hnyEkiVn/lpkHj8fLgFOCtrF2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647805; c=relaxed/simple;
	bh=O+duQ4JNA7Nott7rAhBuH0I1nT89hCgeyNw0mpwEzjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou5AvrVShVD7jFeJqk1PeFcyR82evMc5VBpS7MDKXVHg2F9OmCpkDx29SFp4azqCSgCEOVJvqQAtrKfpcre9LATS9fhUvx5mojuxaLG2zRKMKDLwT/3qSNyY7GTehjZto3c+P/P2qmlA+GWUxC4xmkLG6Wb6MYaP969uqc/4Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM7IEuum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B213C4CEF7;
	Sat, 17 Jan 2026 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647805;
	bh=O+duQ4JNA7Nott7rAhBuH0I1nT89hCgeyNw0mpwEzjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CM7IEuumCuUr8tQUn1mAa4brRyWwMxEit3KmPILt6x24ftoLF98QlqWD5qfVxIR/r
	 cHrq2Uu+a46tPnQs+qKfKkWpXfb6Ql5sciUqUPASd9K/XM9CjkaJbepmQ9U6aj2jIr
	 3Y5AWv6plm78hBx7NmUyVSJxTyeVEaXn4B3/5ULcT3j7Sq7NJZ1kWtl/wa2qEJxquW
	 v1ewSD7+Ee05NqQg9++H3A74uX4sMuDnVIz/YxWP2mwF0WpwaNp/ERXIuCjIxCZXxs
	 qnSpVTY5KwIKiflyZiodClza/H/dMqzzFXeNASuTK8FT8lDjhXcWAUDADrTV20u8DS
	 wXdSRp5nOVZFg==
Date: Sat, 17 Jan 2026 16:33:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single()
 to simplify code
Message-ID: <lsvjhgxkpk3drbu4nvika5rj7yvc3dqvu6fhibj4nlsuq7fulx@odbkesxm377n>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-8-a8480362fd42@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105-dma_prep_config-v3-8-a8480362fd42@nxp.com>

On Mon, Jan 05, 2026 at 05:46:58PM -0500, Frank Li wrote:
> Use dmaengine_prep_config_single() to simplify
> pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Keep mutex lock because sync with other function.
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
>  1 file changed, 16 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..0bf51fd467395182161555f83aa78f3839e36773 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_DEV_TO_MEM;
>  	config.src_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_FROM_DEVICE);
>  	ret = dma_mapping_error(dma_dev, dst_addr);
> @@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -399,12 +394,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_MEM_TO_DEV;
>  	config.dst_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_TO_DEVICE);
>  	ret = dma_mapping_error(dma_dev, src_addr);
> @@ -413,9 +402,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
> +					    DMA_MEM_TO_DEV,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -502,12 +492,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_DEV_TO_MEM;
>  	config.src_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_FROM_DEVICE);
>  	ret = dma_mapping_error(dma_dev, dst_addr);
> @@ -516,9 +500,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
> -					   DMA_DEV_TO_MEM,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
> +					    DMA_DEV_TO_MEM,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -581,12 +566,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>  	config.direction = DMA_MEM_TO_DEV;
>  	config.dst_addr = buf_info->host_addr;
>  
> -	ret = dmaengine_slave_config(chan, &config);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto err_unlock;
> -	}
> -
>  	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
>  				  DMA_TO_DEVICE);
>  	ret = dma_mapping_error(dma_dev, src_addr);
> @@ -595,9 +574,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_unlock;
>  	}
>  
> -	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
> -					   DMA_MEM_TO_DEV,
> -					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
> +					    DMA_MEM_TO_DEV,
> +					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
> +					    &config);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

