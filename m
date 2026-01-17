Return-Path: <dmaengine+bounces-8318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C889AD38DEA
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196063019BB5
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D195311940;
	Sat, 17 Jan 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2iAT2H9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67926E71F;
	Sat, 17 Jan 2026 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647454; cv=none; b=VKFyIVeNhwCXkjMl/YR6UKFbgn/RM1HeBHNcZ0w86o2v7mXgsKMe/6uMLed5EhGMyYd5+VewICnL3SKStmc66z03uTrOVFtTYoTafelHx6WQh9UjZrNHevj2z9VqcmLn/4W0B6T5XKhdVj4UdF3LekDeFE2z1dHOKkGrR9ljQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647454; c=relaxed/simple;
	bh=hNiv/W3QHHIP4X/UDBU+nEtCmGt9Wf1fVOHzvFVeeME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggPl5GDPfmsk38TRli14c3faXnY9wXUmCI4b5rpdMjcicgWhoswqlbFMDE214DMUfVyaBLTCATgm0GP7L6G+16EADrPL+XIotBNIuZ8VEen6JT5fZSAPzCrBiZFi4Qk2xtx+UZ9MstrjEWeS4qdOhcQCiwqftNhrTzTDgQUe39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2iAT2H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD7CC4CEF7;
	Sat, 17 Jan 2026 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768647453;
	bh=hNiv/W3QHHIP4X/UDBU+nEtCmGt9Wf1fVOHzvFVeeME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2iAT2H9xieXc+E/UTKamvCsKyuamRllOQz07wrpzr/PFi03FyaK4eix67vMva8qa
	 Bn2N808rm098VDDpvZTC7LgjiODtwl4HQKvRT3/ijbN3qLd20pZfoW0AdaS9XU75Dr
	 PxXMKKiB7b6oWbwSGDpalEE5EnqZcDDklM6V19UXWYu+eqE7/XXXgpiZ2cZIbX7ygJ
	 jYHGXN9RnkohyW7Stm5PItZbX1l/sS+wVBYMXanm3cAFRILY8t+WLiXy5eAjO8V86k
	 QNUmcYX0M83kItZP/zIuTCTT8uDcJMGostfKfUc619iS02/er1Dsuh7NsICE3aAH7j
	 o4A7dzhUg14PA==
Date: Sat, 17 Jan 2026 16:27:15 +0530
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <tfqwmj24eu2rf6h4ecvkgom44tgjkaihtgmln7v3zcyy5burcb@sg3q5qafbzgf>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <20260105-dma_prep_config-v3-3-a8480362fd42@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105-dma_prep_config-v3-3-a8480362fd42@nxp.com>

On Mon, Jan 05, 2026 at 05:46:53PM -0500, Frank Li wrote:
> Use dmaenigne_prep_config_single() to simplify code.
> 
> No functional change.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change in v3
> - add Damien Le Moal review tag
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index debd235253c5ba54eb8f06d13261c407ee3768ec..95b046c678da7ca4a0d9616acdd544251dc05aac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -162,12 +162,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		else
>  			sconf.src_addr = dma_remote;
>  
> -		if (dmaengine_slave_config(chan, &sconf)) {
> -			dev_err(dev, "DMA slave config fail\n");
> -			return -EIO;
> -		}
> -		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
> -						 flags);
> +		tx = dmaengine_prep_config_single(chan, dma_local, len,
> +						  dir, flags, &sconf);
>  	} else {
>  		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
>  					       flags);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

