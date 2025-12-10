Return-Path: <dmaengine+bounces-7562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966FCB4310
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 23:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EAB301918C
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E62EBDE3;
	Wed, 10 Dec 2025 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5H4a8R2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAB2E542B;
	Wed, 10 Dec 2025 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407346; cv=none; b=Hg531DYr+kfnxqJc9vNgEo+ajCn95NgxG/SkdpUkUXw46tu6kFXBBZ1/L7itkIW9A6pVhm9iK/5OS7JJuLtU0T3xy2sDN9U2k3BbKhU08RHSQCSIYxseEnrNOjXBxPhnx4PvmA73oH23cmBEyoS12gibCozE3l+96Afhsnzw1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407346; c=relaxed/simple;
	bh=PLadVEoeY0hC43TAV5onwNBUDm6mGg+NAew2uNOTqz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lHOth6QqACNX4ryKMSB/k4uRYM7GNnBWfEgkmyiReQ2KKJWQmMRqT5ClkDkl5GOj9ZXl2smevwPEK2jyAMeEr1hf8goF8QVbXR3nQ5l9BhaCEA5pMmTPVe+btJpnggd1fttIyMREo6F35Azpf6VRJ4roRjAgSBn9nS5SVDHDdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5H4a8R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61867C4CEF1;
	Wed, 10 Dec 2025 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407345;
	bh=PLadVEoeY0hC43TAV5onwNBUDm6mGg+NAew2uNOTqz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j5H4a8R2dmy5EQ5NgEAM5ZOX9qKNGt4t0kpMwZOPmJG/R/u0HvKJ7oB+NOEPfFg5s
	 d0ihiuYSi0voOpdZ1cp2/NnCCP9mwrcVXZ0hlsDA0DvNA1FOtgmbRCGJ0vk0zEnQ6q
	 hAyFoGDt4ZIGJhA4G4DDZnuH6GKECDX8k1mctL63Ch8M1YvzurGfJt+4oqX+PGOfa6
	 +mpk6a7gpMF109MaYL3YBAarAg8R1K4AQv2mhN8od8A/a7o57Als7T7rx5PUZg1Ctv
	 u2PmGE/O3Hzlpu+nkGcec/Q6sTIxDdqG+tHlhYUyEvI8ggmHbVxU82uRk8uyXbjIF9
	 MQsjca9LE5NiA==
Date: Wed, 10 Dec 2025 16:55:44 -0600
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
Subject: Re: [PATCH 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <20251210225544.GA3542977@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>

On Mon, Dec 08, 2025 at 12:09:40PM -0500, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
> 
> Add a new API and callback device_prep_slave_sg_config that combines
> configuration and preparation into a single operation. If the configuration
> argument is passed as NULL, fall back to the existing implementation.

Add "()" after function name.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/linux/dmaengine.h | 64 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 57 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea9844ca6161208362ef18ef111d96..6c563549133a28e26f1bdc367372b1e4a748afcf 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -835,6 +835,8 @@ struct dma_filter {
>   *	where the address and size of each segment is located in one entry of
>   *	the dma_vec array.
>   * @device_prep_slave_sg: prepares a slave dma operation
> + *	(Depericated, use @device_prep_slave_sg_config)
> + * @device_prep_slave_sg_config: prepares a slave dma operation

s/Depericated/Deprecated/
s/slave dma/slave DMA/ to match other "DMA" uses

