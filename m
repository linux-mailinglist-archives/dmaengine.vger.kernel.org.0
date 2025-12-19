Return-Path: <dmaengine+bounces-7839-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938BCCF741
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D54B30E976B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC5C2FFDF9;
	Fri, 19 Dec 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoSCk23s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854782376FD;
	Fri, 19 Dec 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140983; cv=none; b=GAJxY/SLTRBY55SJYQCM00S9p4zUDp5MFn7cVRpwMsek1H+x10yPUdodcbJe1H9VzPeypexoga/Gll1zb2Rl/+d2eJtfQL6KoCUYwMJqXmXi2ThUaGjjArUoIgQvK4hX0P7GwD7APze+8DV+DPFb4fzTYP4QcQu/hDuyrpu60vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140983; c=relaxed/simple;
	bh=xkz5LUlBElFB9CvO+KaW9xJq6o3zkwL/JUJof/pyJKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duZNV3qQdGCYfd5z6Oj72GMxTB9ZKoUFQsLH73hhV6vhcCD5NVQjf5pDGfUYJqK3T9srdXHdCUA5/uyvJkptI4+NLouOK7O6QdKddL8lbWdRYfhcBy6n4staKKUQE3g2ukU+yXFDFs4M700A4VTMDsoklK9q1tINDt28ves/cKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoSCk23s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA22C116B1;
	Fri, 19 Dec 2025 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140982;
	bh=xkz5LUlBElFB9CvO+KaW9xJq6o3zkwL/JUJof/pyJKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IoSCk23sz5zIAMhhpVSs+yWPq39dQ9XP469p2h5DRvRKuQSWJCW2G3aAoGFxmnsjR
	 Y32S/nKLSMqJ8XvXJKKPt1Pzpofi4UzTmoFWnZQTyGWFQz4ePg61LHGxoS+EcGC+NQ
	 rfPbh8jYbxXKaB/AGYclGcYhStpeiAoJ/12kcGwbssjeStmDEloHn/SePTEosz4mwy
	 G+vuPh2d0k95qzFbVEsc/KQWud+YIsUIaPB8UK+YQUGKiFYja2/8mIkLB/xrgH7i4X
	 V+i7y2DKw0yuhlxec2sGVW+fAC912w7KlOivIwf7iRrBCC+ahIV3bcQIFwCrmc/BQQ
	 Lj3bhY4plfj4w==
Message-ID: <0fa95ea2-4539-472b-adae-300e46a78f20@kernel.org>
Date: Fri, 19 Dec 2025 19:42:57 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-6-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-6-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
> Use the new dmaengine_prep_config_single_safe() API to combine the
> configuration and descriptor preparation into a single call.
> 
> Since dmaengine_prep_config_single_safe() performs the configuration and
> preparation atomically and dw edma driver implement prep_config_sg() call
> back, so dmaengine_prep_config_single() is reentriable, the mutex can be
> removed.

What about for platforms other than DesignWare EDMA ?
This is a generic endpoint driver that can work on any platform that is endpoint
capable and that has a DMA channel for the PCI endpoint.

The dmaengine_prep_config_single_safe() API should be handling everything
transparently for any platform, regardless of the DMA channel driver
implementing or not the prep_config_sg() callback.

For platforms that do not implement it, I suspect that the mutex will still be
needed here. So how to we resolve this ? Ideally, all of that should be hidden
by the DMA API. The endpoint driver should not need to deal with these differences.

> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 56b1c6a7706a9e2dd9d8aaf17b440129b948486c..8b5ea5d4c79dfd461b767cfd4033a9e4604c94b1 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
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
> +	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
> +						 sconf.direction,
> +						 DMA_CTRL_ACK, &sconf);
>  	if (!desc) {
>  		dev_err(dev, "Failed to prepare DMA\n");
>  		ret = -EIO;
> @@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }
>  
> 


-- 
Damien Le Moal
Western Digital Research

