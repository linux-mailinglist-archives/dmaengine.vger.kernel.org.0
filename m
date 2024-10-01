Return-Path: <dmaengine+bounces-3247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7354598B46C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C77C1C23401
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0B191F8D;
	Tue,  1 Oct 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eu++3UY/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1671BE22C
	for <dmaengine@vger.kernel.org>; Tue,  1 Oct 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764205; cv=none; b=lHQtJF5UqvesMgdRLHK1f/I04KBXVWSColTO2MS2p4y5OcpoPHWG3/CBz3Q1SEuz0veUaTf1ORu8tCtVytK0F5x0HcxH1eJRNHnkVhht81OTX9IQ+ES0VD5/lxL+gZSMxZyqWRbFxDAQ5Ox4pF9wMIgwhLI6luX+Onyn/n05H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764205; c=relaxed/simple;
	bh=2UwbEr1u02+4WdUm3dvggywbyMgk8f7Etg8+hOkC93o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3woCKEcqTsC6Ru9OPAXhOc8Tn4Gw1NDbJHiPZYNIhAeD1w7JRISazxH9DCI5wxtHqdh2Hb2vBsM+8EIljP8RH/JmgPDPQONIW9ZxoLmckI5paBPk4Cxhswr7uu1ssy2Ub7oNf5H9W0RYZGK0Gwv5zoRbb5EInirQILhTA+HHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eu++3UY/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cca239886so2904074f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1727764201; x=1728369001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0u/e6TihOcGdjRnY03UvUv5RbdNzFWsDmO3OGcYR+A=;
        b=eu++3UY/QIjCmm6+U9rjB6Adp/m5lkoEECscSnviBWrAAl7nhCFLo5kXL35vcyqBXe
         zbWDzrGINyWReGbZDx5XehIH8Bf/kJidmUxE8Nx7pbin+ab2Y4p6ApFeD8kK9SEsXaRB
         pzMJVAr+dLKMIgHOuLlEitRmyS3m59wT3dTUiCkcdNbsY4iTpVfI9rS/K/OEr6RlKt/7
         5gdIBnkAYunWbbgQbivu25R7oPLnc01Ox1hJqYM7TVObtplZsvsdj+bnfhc2kEPIrOVW
         oho2hf0+ENg8HM6kWP0lAoxOJWzU/CFJhKzQ/Fjuy878wZzp9+aTgaUz0v3C51PUQile
         etcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764201; x=1728369001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0u/e6TihOcGdjRnY03UvUv5RbdNzFWsDmO3OGcYR+A=;
        b=KHwt8BgLOvWXv3er1WoP92hYZwtY8fpU+LoIP3pOrcEcvGL5NSMqfbES7f/1TCe0uu
         ID9qMPakCYjgUyS79zGgfsveKgM51OQMMQcf79W8Xev/6Re+a2i02O+malKVQ30BvZKK
         pzcpphdubcXxNzhW737SWv5nrid+sDdrJ9OlsY41zYlY7YtxeKmv+2wBTtsLeQ+v/Lna
         FQjkqaUDShBTVL+32b68KLdzf6kZmDuy2UGXQdoBql4gLP+YgndyNY4mHadhykjBHGby
         jRK/kfTdgjczx6NtUjOr9we0IEBDVYRRq7i1b5tMhBK897KXcjXN1g+GgR1Z6p/H0YI5
         SPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpVB9mZzbaHhAxvJN6+vKh3xjiubIjsOieH8LtlSQCGKUib+iI+ytifkRNfgFA+Tq8QxRLZ4J3ERQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FWMoo8DHD54O9EdgJS/tZILPm32npnjREEPTstEtqcDsmczi
	/Hty6P2QPTADqRUniLIUTpq8iVAdBdjt/IMmBprlDGVJajNt23YpRDhhn1AHlqg=
X-Google-Smtp-Source: AGHT+IHe0wreEOvEy+ZVkGTsRiKjFj14br8CmbkIvdfydF6eY8D09GgeK1waIXRdXRqcN0XZ1tLu/w==
X-Received: by 2002:a5d:534a:0:b0:374:c793:7bad with SMTP id ffacd0b85a97d-37cd5abc58amr7567440f8f.16.1727764201020;
        Mon, 30 Sep 2024 23:30:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57450c7sm10949292f8f.101.2024.09.30.23.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 23:30:00 -0700 (PDT)
Message-ID: <f7b6ead3-a8f3-4d07-a56b-27a23701c7c3@tuxon.dev>
Date: Tue, 1 Oct 2024 09:29:58 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 dmaengine@vger.kernel.org
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.09.2024 17:59, Wolfram Sang wrote:
> Configs like the ones coming from the MMC subsystem will have either
> 'src' or 'dst' zeroed, resulting in an unknown bus width. This will bail
> out on the RZ DMA driver because of the sanity check for a valid bus
> width. Reorder the code, so that the check will only be applied when the
> corresponding address is non-zero.
> 
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 65a27c5a7bce..811389fc9cb8 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -601,22 +601,25 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
>  	u32 val;
>  
> -	channel->src_per_address = config->src_addr;
>  	channel->dst_per_address = config->dst_addr;
> -
> -	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> -	if (val == CHCFG_DS_INVALID)
> -		return -EINVAL;
> -
>  	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
> -	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> +	if (channel->dst_per_address) {
> +		val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> +		if (val == CHCFG_DS_INVALID)
> +			return -EINVAL;
>  
> -	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
> -	if (val == CHCFG_DS_INVALID)
> -		return -EINVAL;
> +		channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> +	}
>  
> +	channel->src_per_address = config->src_addr;
>  	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
> -	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> +	if (channel->src_per_address) {
> +		val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
> +		if (val == CHCFG_DS_INVALID)
> +			return -EINVAL;
> +
> +		channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> +	}
>  
>  	return 0;
>  }

