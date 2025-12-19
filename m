Return-Path: <dmaengine+bounces-7837-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885CCCF6F3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BA87300B2AB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409C2EB878;
	Fri, 19 Dec 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1fDJI5J"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483622DA771;
	Fri, 19 Dec 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140693; cv=none; b=kggCZUFmOcAnLD37WAGnNIdQLyYVThvmOgiTHn+rvhykHqfqB48EGlirXWPj4muRbBIUek+XScWtXpb1o1LtneQksXlCaqBPdkIu/SIsnhyBxpL7O+xZDS94oFuGMuB69bYhsnLNLiRPKyrPtL6AkXBlvxbP7ZyERfCUlCX1nB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140693; c=relaxed/simple;
	bh=TKxHdYDWPMHS6PrRcH0CtD5eVxCTGhtjbjlyqik0m/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gax8oC/YSTIW4Ty+2uY0HWQbqDDGyKt2vQZtQJDvBiIaGXM5pHAGY/BGeP0RsvqMgYfEVa4Er+lTGPxSPz88xXWhsAlaNjgPnVwTx5PMShmzVYbelb724g6tW4l/lfuHQ6Zsx5y+Px13/nA1Og0JWQt0irgOfzQHRNvSkk7nRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1fDJI5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF531C116B1;
	Fri, 19 Dec 2025 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140691;
	bh=TKxHdYDWPMHS6PrRcH0CtD5eVxCTGhtjbjlyqik0m/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E1fDJI5JmYCCrnC3Xi03l3Q/ACQw/BfazpJ2GrSaVBNYE1cxHPCne/bMKl6nRjQCE
	 BjlcE+Zj/3/p6G6izv1O0fbpSDHB+WUyZMHxi4uvr6UvZpzPY38mnUbffSAzWsUNg4
	 6RJ4OTerbo7WCvZUwsncP7NuxFyc2gLAsEU4+fcGHjlwfsfQ4ggN1T7nIRn5DALMmT
	 cn2KCeJ6y3NJGbqjngYwSwDKIpouXL9u/OavqvqM8/f2gGeQAA14yPlCN3rY0lsrAu
	 GyPDm5PMwLDio+dRAalT1cEMVpLQSMHIVN6sUW4pxp79UT3/hzW+Xj7xpE+9ygtjA8
	 mIWWZ/t+CRV5g==
Message-ID: <bff84f52-a23c-4a76-977b-9deb2306b154@kernel.org>
Date: Fri, 19 Dec 2025 19:38:07 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
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
 <20251218-dma_prep_config-v2-4-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-4-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
> Pass dma_slave_config to dw_edma_device_transfer() to support atomic
> configuration and descriptor preparation when a non-NULL config is
> provided to device_prep_config_sg().
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index e005b7bdaee156a3f4573b4734f50e3e47553dd2..1863254bf61eb892cb0cf8934e53b40d32027dfa 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -230,6 +230,15 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  	return 0;
>  }
>  
> +static struct dma_slave_config *
> +dw_edma_device_get_config(struct dma_chan *dchan,
> +			  struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	return config ? config : &chan->config;
> +}

I would rewrite this as:

static struct dma_slave_config *
dw_edma_device_get_config(struct dma_chan *dchan,
			  struct dma_slave_config *config)
{
	struct dw_edma_chan *chan;

	if (config)
		return config;

	chan = dchan2dw_edma_chan(dchan);

	return &chan->config;
}

That avoids the call to dchan2dw_edma_chan() if config is specified.

-- 
Damien Le Moal
Western Digital Research

