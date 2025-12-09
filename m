Return-Path: <dmaengine+bounces-7544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926FCAF124
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 07:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F0F530057BD
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0927F4E7;
	Tue,  9 Dec 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh2lEhnt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83327B4F5;
	Tue,  9 Dec 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765263401; cv=none; b=RBm60orp/amN+yNSkvpz+TXfGZpubXj2r2usmEJdi7DtHdOR8++LhgfByJ6edR8CSJVA10b3Ei8IL5fxoyTu8QADk7Xy+XS9t31vBnEHibKhi1JHRNS4lPYeT6fJztKv0cqM4+8oGyE/xGEwNzDoMcMfBoARieL4hpqVDZa0hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765263401; c=relaxed/simple;
	bh=quZ4ePEejJ/v56bJo7+xw5JlJt6hVQjFZUg0aioFOzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRN9xAN7MxwsuRlA+0ld3G0Sf6cPD0goZTRZEdrCcizDZ3qZ1vjI5V0ccCukdM/Rw6vqbq3Gwyaf/UawysCS/VYX0eM/ZayOyCHOzlaPBa0IpbuKCQzweFL72h3FvlkNCBZzW9XxVFZcphF+ZKDdSEsnivdP8b9/HkH4V+mpU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh2lEhnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B74C4CEF5;
	Tue,  9 Dec 2025 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765263400;
	bh=quZ4ePEejJ/v56bJo7+xw5JlJt6hVQjFZUg0aioFOzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mh2lEhntDrWHFMndpdS7620G82z6B+4ORoHPUempGKaW8ETRAh27mll2d2fBvUE6O
	 C1Bf6n8jjBX8XExWhMXeDs+DohLaorXzgqx4SpSDDk30mSGWPV/C0cXuuZjyMyLK5r
	 vm0FBKdAZgTTtU9Ts1avBERBqrYxXgSIiJmoyhZUUH23V+Qqt5k4s5kAHq0fQTBqkV
	 W32om+yZWERYPYBjz8m21VrQRpNE/RMLuM0oxz6ZPbE7AnGxDRLGpBOt0qdTKMdnXr
	 DANnylJZCFtTIO/oeLxSCLw/vldM7yoIa05rJbC9kY6G9rLVialvrtVRGU9ZRhzRGO
	 jGoBxJl4NRHnQ==
Message-ID: <f9107db3-491e-4224-a337-821a89f99132@kernel.org>
Date: Tue, 9 Dec 2025 15:52:15 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
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
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 2:09 AM, Frank Li wrote:
> dmaengine_terminate_sync() cancels all pending requests. Calling it for
> every DMA transfer is unnecessary and counterproductive. This function is
> generally intended for cleanup paths such as module removal, device close,
> or unbind operations.
> 
> Remove the redundant calls.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> This one also fix stress test failure after remove mutex and use new API
> dmaengine_prep_slave_sg_config().
> ---
>  drivers/nvme/target/pci-epf.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2e78397a7373a7d8ba67150f301f392123db88d1..85225a4f75b5bd7abb6897d064123766af021542 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -420,8 +420,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>  		ret = -EIO;
>  	}
>  
> -	dmaengine_terminate_sync(chan);

If the above dma_sync_wait failed, we better call this here as we have no idea
why we got the failure, no ?
For success case, we indeed may want to remove it.

> -
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>  
> 


-- 
Damien Le Moal
Western Digital Research

