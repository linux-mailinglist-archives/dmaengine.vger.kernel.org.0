Return-Path: <dmaengine+bounces-4251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA3A25981
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 13:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A903A4217
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A42045B7;
	Mon,  3 Feb 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="dcFHh2th"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0121FFC69;
	Mon,  3 Feb 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586128; cv=none; b=DAxNEJRvXLAZLlgspC45RlyCOOSj2E181fqqRn7ETbriIUfoa+Cr/pPxKMIw5Z3n1WAQ6cWD1gH6vwyUfRQuS7qObPMqrS5Su/+qM1caawpQcCxLiG472L/4R/fPJ+n/1Zks1PvzZgT4olvwZO96wJ5+1gPPx2atymWF59vPnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586128; c=relaxed/simple;
	bh=CxfZW7dBnO3GBXmccZ9Y/mBeu6zRLvvGYqVPWtDM8rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNr5kxnDTzocd9kv4p9wttEOC2sEnAwTtqqePwqpfyon0uwSmoMDQKSq28YZQqD1pDhgjFIIYh3+U4Uta5XTFPitoPn0brGlqb51amalU+jDjwg9+YK9J6GKiBlm0XFROmRa5nhd59geUD7xkq2vY/FA9SFAE/GkYVuXuKA6WoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=dcFHh2th; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F6CF14830BD;
	Mon,  3 Feb 2025 13:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1738585624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKnI1H6bH4Cdf0+aRcBE2xV6xY9vSuXcbUzXoEYfRuc=;
	b=dcFHh2thNZzdlG/h8AL7zj5T96WsL+ZwTrkv5rpW0fA/Kbb4iKWfX1iy4NXnl+IExfYHop
	OM2xWT4w4gmASbcQBsWPh5kUdKj34Oe3rPrXk3ylNGsjiWjeVDagfe3x8y4tQpyr3i1Qs3
	z61tW7ik4TKnPj7QLFWnn/A9T6xJ+vX/LY4j8RGwXTXs5R60oK9Oyt05jvFYV4MQ7Cgq0B
	+T1VU0dr5xPXc/7tRVI7CYFm5tcrP7pi7DGNXeSlJdY4e6kLkddZv/ucgIso/5dGdkCWff
	aXLMZjF3FNIwnkApjt/Q9ykr97zmzLKwRjPYP7JXmdTtTrWuE2j2K3k7BAySwQ==
Date: Mon, 3 Feb 2025 13:27:02 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dma: Add devm_dma_request_chan()
Message-ID: <20250203-chalice-ninth-8235590e29d2@thorsis.com>
Mail-Followup-To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
 <20250124085221.766303-8-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124085221.766303-8-csokas.bence@prolan.hu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Fri, Jan 24, 2025 at 09:52:20AM +0100 schrieb Bence Csókás:
> Expand the arsenal of devm functions for DMA
> devices, this time for requesting channels.
> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
>  drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
>  include/linux/dmaengine.h |  7 +++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c1357d7f3dc6..02c29d26ac85 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -926,6 +926,36 @@ void dma_release_channel(struct dma_chan *chan)
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
>  
> +static void dmaenginem_release_channel(void *chan)
> +{
> +	dma_release_channel(chan);
> +}
> +
> +/**
> + * devm_dma_request_chan - try to allocate an exclusive slave channel
> + * @dev:	pointer to client device structure
> + * @name:	slave channel name
> + *
> + * Returns pointer to appropriate DMA channel on success or an error pointer.
> + *
> + * The operation is managed and will be undone on driver detach.
> + */
> +
> +struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
> +{
> +	struct dma_chan *chan = dma_request_chan(dev, name);
> +	int ret = 0;
> +
> +	if (!IS_ERR(chan))
> +		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);

Why not using dma_release_channel() directly here?  What's the point
of introducing dmaenginem_release_channel() further above?

Greets
Alex

> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_dma_request_chan);
> +
>  /**
>   * dmaengine_get - register interest in dma_channels
>   */
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 346251bf1026..ffb54b52ef0c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1528,6 +1528,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name);
>  struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> +struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
>  
>  void dma_release_channel(struct dma_chan *chan);
>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
> @@ -1564,6 +1565,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +
> +static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static inline void dma_release_channel(struct dma_chan *chan)
>  {
>  }
> -- 
> 2.48.1
> 
> 
> 

