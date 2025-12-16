Return-Path: <dmaengine+bounces-7664-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA12CC3BB1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44B563003056
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F13930DE;
	Tue, 16 Dec 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnoL6OaL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C53930D7;
	Tue, 16 Dec 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889123; cv=none; b=RISljcSKVNz5/AcS+bRCLk7cAcXTAxL/s9lJZvPT11tFWLz7KTNxJdDE1ILmiwusNYcxvCeyggCB+QFZd/G6zIKXjEjKS1jCFJAYQi96xp++UlS49JB6fLtPayUmzY1NXAhJ7bkHoT6h6qc5QqcywuGGDdh8knkOn4I6oinPmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889123; c=relaxed/simple;
	bh=BB7cuc1NoM/ZjbE9WkcQ3syZOkeMW0I8NGbpaVWvHrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfBs/CIOO0HN03GvKycn3ThHu/46AYYiTtK5hmlfnw/N9XmOQTicc5LsefRf4JGqafQ7lnwUEh0w7oLjj3bPNoA2lJzSoFmvhLY9Y3w/HiR8oxlFqWwl2D6SjF7+TOcyOoaPraDfzv/hA/RlDdi3p6XmQYabfnKc+D3CdSjdkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnoL6OaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8388FC4CEF1;
	Tue, 16 Dec 2025 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765889123;
	bh=BB7cuc1NoM/ZjbE9WkcQ3syZOkeMW0I8NGbpaVWvHrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnoL6OaLXuO+HTBjme5kokBg0mnjS5RwOuZ6J05mjCYsgC+8P5QwHuW5NKH2ESn6J
	 G3W5VhnMayk+dn5VjLfT5UFuTX93YBBL9G/2FKYLk/kw3iPFRGcDCSZtUBKzRMSV/a
	 RouZAANdXw1Db478Bn39VjR3zqFC0RYvl5Id7A9t1MT39UIG2Jd87pr3U/+5olFHoC
	 sbo5M9OnE+as1zxfENAdombBcAwZECL0O0bltvRPFc1jAQuExxy57AQ05hCuQs4JP5
	 JLaTsl2h5ZXDDzL+jnGJYuCiJB+YdY2g2Siou/HnXT76l2YwUQRT7WyHzz09vv+OZ4
	 9GDNXf1AYoSfQ==
Date: Tue, 16 Dec 2025 18:15:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUFUX0e_h7RGAecz@vaman>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>

On 08-12-25, 12:09, Frank Li wrote:

Spell check on subject please :-)

> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose.
> 
> 	if (dmaengine_slave_config(chan, &sconf)) {
> 		dev_err(dev, "DMA slave config fail\n");
> 		return -EIO;
> 	}
> 
> 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> 
> After new API added
> 
> 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);

Nak, we cant change the API like this.
I agree that you can add a new way to call dmaengine_slave_config() and
dmaengine_prep_slave_single() together.
maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
cant drop it, as absence means something else entire).

I would like to retain the dmaengine_prep_slave_single() as an API for
users to call and invoke. There are users who configure channel once as
well

> 
> Additional, prevous two calls requires additional locking to ensure both
> steps complete atomically.
> 
>     mutex_lock()
>     dmaengine_slave_config()
>     dmaengine_prep_slave_single()
>     mutex_unlock()
> 
> after new API added, mutex lock can be moved. See patch
>      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (8):
>       dmaengine: Add API to combine configuration and preparation (sg and single)
>       PCI: endpoint: pci-epf-test: use new DMA API to simple code
>       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
>       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
>       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
>       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
>       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
>       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> 
>  drivers/crypto/atmel-aes.c                    | 10 ++---
>  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
>  drivers/nvme/target/pci-epf.c                 | 21 +++------
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
>  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
>  6 files changed, 111 insertions(+), 82 deletions(-)
> ---
> base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> change-id: 20251204-dma_prep_config-654170d245a2
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>

-- 
~Vinod

