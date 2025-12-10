Return-Path: <dmaengine+bounces-7561-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1ABCB42FC
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 23:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394233016CE8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0302E7657;
	Wed, 10 Dec 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BslJAJRj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD971AC44D;
	Wed, 10 Dec 2025 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407296; cv=none; b=CpjXd7dxHK8qc51s181Lt4YBJ1+ZqAmPhzizzXF611O/rqCowAwCV/Fh/R+JHRzYrr0OXCRXG0udXmpgyygj5k7xNPR8KW22ZVIrSzTO+BZATgrXiYchL/ytAWwqypebHSOAhZSXHAot0as9+st9vFt46r2z3ecccPiV55vQbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407296; c=relaxed/simple;
	bh=8JOdnH8KktNBpZMvUsGFkBLybLSALb0U05AElB0cFO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c72HzfvbUZ5K9F1StaNf/bV5otdNC49SMkhYZTWEsMBPKGCsMHZxBVivnnPOFhspoC+yFlcccCuJga+aYsxiXNPGP5thMRojgK+RVbgDCd5R0VQSnHOJL2zvo8W6MbccwLkg4szffL9ExOr1V2RFXpiSGj7ansV+l/6CPczWHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BslJAJRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48847C4CEF1;
	Wed, 10 Dec 2025 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407296;
	bh=8JOdnH8KktNBpZMvUsGFkBLybLSALb0U05AElB0cFO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BslJAJRjXviWwZqQk04+V3QQDrmDTUkC45Jv3BiKvpuSlqZ/PhPXfINN6TNP1FBgm
	 /O8W07PM1aA6dZ2tX/6MvQXI/QBbWxqhNWgL4PBWD+DEeKoZg2UlCQMAzGBqzRZsLc
	 6nktTVq8q2rOs+0zYDkmjN1NGbit7v1Ctr91smzqnKXl+30sGnTbooG+BRUK2cxrJv
	 Z2oxKn9y4kj1teNsPoUAIUq4GrQmvyGQ7rkWAZTZEorZTUi4MKzP4I11qOceqBXOwY
	 KG3c613LwXnUwUAQa2vxWvCSHJRR54w1+jqJnIRhD3GUy/iWVwj9WZi/MQtdjXBNrT
	 +q85oSr3ibLdA==
Date: Wed, 10 Dec 2025 16:54:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <20251210225455.GA3544539@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>

On Mon, Dec 08, 2025 at 12:09:45PM -0500, Frank Li wrote:
> Use the new dmaengine_prep_slave_single_config() API to combine the
> configuration and descriptor preparation into a single call.
> 
> Since dmaengine_prep_slave_single_config() performs the configuration
> and preparation atomically, the mutex can be removed.

> @@ -386,22 +386,16 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(lock);
> -
>  	dma_dev = dmaengine_get_dma_device(chan);
>  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
>  	ret = dma_mapping_error(dma_dev, dma_addr);
>  	if (ret)
> -		goto unlock;
> -
> -	ret = dmaengine_slave_config(chan, &sconf);
> -	if (ret) {
> -		dev_err(dev, "Failed to configure DMA channel\n");
> -		goto unmap;
> -	}
> +		return ret;
>  
> -	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> -					   sconf.direction, DMA_CTRL_ACK);
> +	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
> +						  sconf.direction,
> +						  DMA_CTRL_ACK,
> +						  &sconf);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -423,9 +417,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> -unlock:
> -	mutex_unlock(lock);
> -

I don't know the dmaengine code, but it's not obvious to me what makes
dmaengine_prep_slave_single_config() itself atomic, since it doesn't
contain any locking.

Bjorn

