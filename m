Return-Path: <dmaengine+bounces-9921-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCU5MqYM1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9921-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:54:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA53AF8A4
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EEFF300D56B
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674F3B6BF0;
	Tue,  7 Apr 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="WiB9wYMO";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="WiB9wYMO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF35315D46;
	Tue,  7 Apr 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570043; cv=none; b=dWDQlboxQI0/f+eJ9udJXEYU6hgCtmRFd4aKhDMcilP9SWsbaqmAA4mHAGDIpp6hfuaNFXmCMn5iz1djwDEJ1+A0BOMoZRUlrtYgkPeeTCTiBHjI7bC1ecDQqJ4zRvOTNbosZdlC0daRckpKNirytwYhWDr22lW1QaPzDtW4tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570043; c=relaxed/simple;
	bh=6GRFt8L4mbLAx7fvx09zE9b6UjgeSYAlR8JyuWvN858=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogA01TmQMEcGHSyCoZC6tofV5Ha9Nb9kxsDAluiJNMzGFoTrHO7HbGOtlQiRPRDwSQ1p4vp/sDnBJKosPSeY7wtSUA1UG45gf9GBbnOHLKkGXBORGJm2DliTEOK4qaMgb9eynC2dNNlWERU85HUiRLJ8nPuW3Vpm/XGYRRfXSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=WiB9wYMO; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=WiB9wYMO; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1775569567; bh=6GRFt8L4mbLAx7fvx09zE9b6UjgeSYAlR8JyuWvN858=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WiB9wYMOfCCsVvTYgFlvB0MHL/KB09+t7CS4MYPR84J+EEm3ZLn1m2H7zgc7wuJ2r
	 /OeIWbfnZtCfF+bYxzuYQvdYj1RfGuZU58Z6nZhTbCWp5pwB9d7NERzwvr1U0qAtl6
	 2Ofpq2zUjMyc70bOFROhhzyCJp90PlPCkwxSRLTHCLHTBxzXqgLMBi8TMk7et/ngDW
	 0ZTSQ5sP4RgRKRQwyE8ONBmwbCe6x6S1EIwtsXvRkE/5KCfw8dicShg6HXmf5XXhVq
	 D+XF0PWr0AEmj8H/lRzY27kvII1Btw8AjXom+OWL9ZT/BRAbTADu5DaaRjPL8wLdbA
	 46/KVgZLeKxug==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 3BF5E3827F0;
	Tue,  7 Apr 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1775569567; bh=6GRFt8L4mbLAx7fvx09zE9b6UjgeSYAlR8JyuWvN858=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WiB9wYMOfCCsVvTYgFlvB0MHL/KB09+t7CS4MYPR84J+EEm3ZLn1m2H7zgc7wuJ2r
	 /OeIWbfnZtCfF+bYxzuYQvdYj1RfGuZU58Z6nZhTbCWp5pwB9d7NERzwvr1U0qAtl6
	 2Ofpq2zUjMyc70bOFROhhzyCJp90PlPCkwxSRLTHCLHTBxzXqgLMBi8TMk7et/ngDW
	 0ZTSQ5sP4RgRKRQwyE8ONBmwbCe6x6S1EIwtsXvRkE/5KCfw8dicShg6HXmf5XXhVq
	 D+XF0PWr0AEmj8H/lRzY27kvII1Btw8AjXom+OWL9ZT/BRAbTADu5DaaRjPL8wLdbA
	 46/KVgZLeKxug==
Message-ID: <a8918d4f-282d-4b14-905b-b637d2708e24@mleia.com>
Date: Tue, 7 Apr 2026 16:46:06 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: lpc18xx-dmamux: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/LPC18XX ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260407035132.99037-1-rosenp@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260407035132.99037-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260407_134607_263802_D44D80CC 
X-CRM114-Status: GOOD (  17.33  )
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mleia.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mleia.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9921-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mleia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vz@mleia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mleia.com:dkim,mleia.com:email,mleia.com:mid]
X-Rspamd-Queue-Id: BFCA53AF8A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 06:51, Rosen Penev wrote:
> Use a flexible array member to combine allocations. Requires
> preparation, aka reshuffling before the actual allocation to get the
> proper size.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/dma/lpc18xx-dmamux.c | 42 +++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
> index d3ff521951b8..5dfefbc496da 100644
> --- a/drivers/dma/lpc18xx-dmamux.c
> +++ b/drivers/dma/lpc18xx-dmamux.c
> @@ -32,11 +32,11 @@ struct lpc18xx_dmamux {
>   
>   struct lpc18xx_dmamux_data {
>   	struct dma_router dmarouter;
> -	struct lpc18xx_dmamux *muxes;
>   	u32 dma_master_requests;
>   	u32 dma_mux_requests;
>   	struct regmap *reg;
>   	spinlock_t lock;
> +	struct lpc18xx_dmamux muxes[] __counted_by(dma_master_requests);
>   };
>   
>   static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
> @@ -122,12 +122,30 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
>   {
>   	struct device_node *dma_np, *np = pdev->dev.of_node;
>   	struct lpc18xx_dmamux_data *dmamux;
> +	u32 dma_master_requests;
>   	int ret;
>   
> -	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> +	dma_np = of_parse_phandle(np, "dma-masters", 0);
> +	if (!dma_np) {
> +		dev_err(&pdev->dev, "can't get dma master\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_property_read_u32(dma_np, "dma-requests",
> +				   &dma_master_requests);
> +	of_node_put(dma_np);
> +	if (ret) {
> +		dev_err(&pdev->dev, "missing master dma-requests property\n");
> +		return ret;
> +	}
> +
> +	dmamux = devm_kzalloc(&pdev->dev, struct_size(dmamux, muxes, dma_master_requests),
> +			GFP_KERNEL);
>   	if (!dmamux)
>   		return -ENOMEM;
>   
> +	dmamux->dma_master_requests = dma_master_requests;
> +
>   	dmamux->reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
>   	if (IS_ERR(dmamux->reg)) {
>   		dev_err(&pdev->dev, "syscon lookup failed\n");
> @@ -141,26 +159,6 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	dma_np = of_parse_phandle(np, "dma-masters", 0);
> -	if (!dma_np) {
> -		dev_err(&pdev->dev, "can't get dma master\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = of_property_read_u32(dma_np, "dma-requests",
> -				   &dmamux->dma_master_requests);
> -	of_node_put(dma_np);
> -	if (ret) {
> -		dev_err(&pdev->dev, "missing master dma-requests property\n");
> -		return ret;
> -	}
> -
> -	dmamux->muxes = devm_kcalloc(&pdev->dev, dmamux->dma_master_requests,
> -				     sizeof(struct lpc18xx_dmamux),
> -				     GFP_KERNEL);
> -	if (!dmamux->muxes)
> -		return -ENOMEM;
> -
>   	spin_lock_init(&dmamux->lock);
>   	platform_set_drvdata(pdev, dmamux);
>   	dmamux->dmarouter.dev = &pdev->dev;

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

