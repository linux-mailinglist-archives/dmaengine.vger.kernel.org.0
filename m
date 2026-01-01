Return-Path: <dmaengine+bounces-7989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B23CECFD2
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 12:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C47ED3000E99
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC26242D66;
	Thu,  1 Jan 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar2Cr2B0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357711922F5;
	Thu,  1 Jan 2026 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767268279; cv=none; b=MRQKN3yMQ0VE67X0q9UaHcOFgc5YzsA6hPp08gZ5hjoUJwI3wHU+k6wtCOiu2CY84MXf1VbjObxIGqywH/28Q1Ii6w1vHgl1rzef1EKrnxQxoH/45drX/or7XHHY9zmNFsNr4oMhZp2rE71MSTmlkKzCairLnnRraE1yo9l7X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767268279; c=relaxed/simple;
	bh=RLsSabfas5/C1+TbA4/GiVfPW37dt/rGXwX8nVp6QVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m91dzeZgEASoUt1QR/SaB9U+RiEehSXKTaVwcw2J/3ndHAoHqB5LQEZkX3t2G21RtddBgt7n3ChGOrKa82J6z42KIEFe11xGdGzQ1rCLrE05WH0dLqTByLYz1jLIvn3in6BynnPUVrkliiqaEFtVjc5GauZIZDVDVm1dr49brx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar2Cr2B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A062C4CEF7;
	Thu,  1 Jan 2026 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767268278;
	bh=RLsSabfas5/C1+TbA4/GiVfPW37dt/rGXwX8nVp6QVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ar2Cr2B0aQU9dFwhMmo+/bf6IyS7BPuG+cWXtHxa7d7mQmQuCrLgXJyCXysHneQ90
	 KCgHxWKkhK6PfF663+qKzYNwXi3QAV0vnM5QEclffItM7YRLGV0mcNkalhItKZclFu
	 T88yIRmgYhMXaPtjFXz75ExTQw2FSYmZI1CCPUSiUCvd7GbIyIXou/lBk2pVPZMnyd
	 ANPwrZQO3taXMk1knw6Fd7gDrFt5takK6s8yLXJOcog+XOQNOrvXI3YXonUh4JXn/H
	 qNgMi6QoTAt7siBmXHKhr3tIh18y7JYdg56j7DXaQB5K5R6KwXUj1JSJNftlsDclVy
	 14IZ9eVhlAmtg==
Date: Thu, 1 Jan 2026 17:21:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Simplify with scoped for each
 OF child loop
Message-ID: <aVZfs3yPrkWYwNCw@vaman>
References: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224124531.208682-3-krzysztof.kozlowski@oss.qualcomm.com>

On 24-12-25, 13:45, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.

Hey Krzysztof,

This fails to apply for me, can you please rebase and post again

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 5b06b0dc67ee..45364b1e47f4 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -925,24 +925,21 @@ static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
>  
>  static int axi_dmac_parse_dt(struct device *dev, struct axi_dmac *dmac)
>  {
> -	struct device_node *of_channels, *of_chan;
> -	int ret;
> +	struct device_node *of_channels;
> +	int ret = 0;
>  
>  	of_channels = of_get_child_by_name(dev->of_node, "adi,channels");
>  	if (of_channels == NULL)
>  		return -ENODEV;
>  
> -	for_each_child_of_node(of_channels, of_chan) {
> +	for_each_child_of_node_scoped(of_channels, of_chan) {
>  		ret = axi_dmac_parse_chan_dt(of_chan, &dmac->chan);
> -		if (ret) {
> -			of_node_put(of_chan);
> -			of_node_put(of_channels);
> -			return -EINVAL;
> -		}
> +		if (ret)
> +			break;
>  	}
>  	of_node_put(of_channels);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int axi_dmac_read_chan_config(struct device *dev, struct axi_dmac *dmac)
> -- 
> 2.51.0

-- 
~Vinod

