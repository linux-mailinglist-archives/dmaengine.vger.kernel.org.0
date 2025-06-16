Return-Path: <dmaengine+bounces-5486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6BADAE46
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 13:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2CA3B22F2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45942C324D;
	Mon, 16 Jun 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQhhMCxE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEB2BD5B3
	for <dmaengine@vger.kernel.org>; Mon, 16 Jun 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073061; cv=none; b=feBEXwTbMWqEzEXT6c8xoCAkJ11COrcXfx3QUGEP2GSa5ozZ27xe9dOkbWrWn8gE0z8HpCkhCokDr1H3QEE6dYakRU312RqE2T/yGka+eN8dGVX7UWCNfO8v2kn3+dK+LY2LAESwUEex9a6cfKjPRx7aucbVVxs0bAaoTw817Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073061; c=relaxed/simple;
	bh=rebvp2cpkk8NcQdyiEZpB0yg9PnEC3G4PHfr+hIW0lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+UCt9xLSzx/cd071aFSlYn6WvW5R9TaC0GP8charjAbdYx9lccsSB3HPwxAfhPnG0EYfN6ZK8+OXiLPetDVF3lNlsauCtg63iZWXK3R+HLAcPCwH8QnNm5bJBxizb66ePcYRmb6OEXIpRqahc0egK7q0RhOukE3Qi9yugcexcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQhhMCxE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addcea380eeso696397166b.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Jun 2025 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750073056; x=1750677856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbV9M4aDHf72M9H3YVkYBz+teJq6aW3dMMcIgDjIjB0=;
        b=eQhhMCxEuL954yTgshbjUL7DfVWLKMwRhxTO9AEoi4zws67b9mQLYfSSC2WSL55tsO
         NUnMXisMNgw3l9lCAjFczJ59df5zf4THQojNJw6q/zuhYU3JsDulUZy8/4a2bV6gqlD6
         w7FsY+qpFKRkOtNcm5b8g5pdEEMbVsJGa0WwjamCkDC7TgjoRalMuew5o6iso/uKtDU6
         27yn3mioWimLyeiyvoo5ggPggnh2ymCnriruI7LLbYlhQ2szFpfO7JelttJF1hRXjyIQ
         Gxz0lhX3lkAo/YML98PooVrtPhOFZsw1FkWQljjqG2JYngkiBcV+sREYqRZ6sbtfFAxh
         S+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750073056; x=1750677856;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbV9M4aDHf72M9H3YVkYBz+teJq6aW3dMMcIgDjIjB0=;
        b=SU/NntwYfXfXQI21Tcdz+er6Gh7bJk6eTE9CfiaepUIwlyQGkJMaqigLZ8qNpRhXJF
         5zpcYARx009cOgWU81pWhFpz3jJFAZjF8DlqBusbOqtvgTSjtkjwpSUolSsXmqizKg/+
         89flT/ImbLzjgkm/hC2kEciGfaoccF4rfUAr687OIInY6uIIWktkxwpa5CKkSlMBy7CM
         Gp8lCNowWNHUHDKRferUSi9VL1xWAGEqoclt1yYLXLPYWAQSP9ny1z4YLD6NDAVPOiQy
         BdcKPxj3LjxwW9rzvD5ln4hT9/C3unvtQghK9mXdLwuJ47J+w0WVjcy+tvQDd+rjTNw4
         OpVg==
X-Gm-Message-State: AOJu0YxOZfzkXQ12SOVBDMjuFMSu0yTuUx3RbPY/nFxis9tl535VjEDm
	P5ajSElQzRzYI1BaS5+pvF2MpJxehrbJnLtFeCZlzooK7bmL5OYhC2r7NJzwGNZmc1c=
X-Gm-Gg: ASbGncvyy5T73agu/PpfSBbRBA+4SF7zc1dg4kNFeYAnhA7+6e16X5pdu5wSvvd9mIN
	EjwKevI49T0fNqteQKngb5cgbKYrUoiDfczga9VoVe6l11Nb1esUhi/ovmd3FfDUZuF4b7WxcQG
	OnyQUhTZUsl8xAG2MFETV9QKM13c6gHVV97xdcfchzQPCUEYsDJVL8kfHpAMLdRXaR/JOai1NSR
	BKjXKuQvLR0l0ijtnv2tMf6rb5OURjaBj/8GH6Jdn4/0gIrd9evC8/HiU3V/w4rfda6w+So+62J
	7RhxNgpDJCWXOuZ7xks8iQIgx3/xilKofakr6l54YEPDBAZAgE3LkeEGRDWyA8S10OYzj7Bxjen
	0D/+E
X-Google-Smtp-Source: AGHT+IHPuq9aBuI6TRaihWL5uiY5RCyARuy/T3/fbEewo0xAONkAM9tB5ptUeAG85+/kjuw1/rSxAA==
X-Received: by 2002:a17:907:2d9f:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-adfad31a905mr894228766b.17.1750073056200;
        Mon, 16 Jun 2025 04:24:16 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8929307sm638202566b.113.2025.06.16.04.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 04:24:15 -0700 (PDT)
Message-ID: <fb1dcbcf-0467-4a68-9d17-2a75dfcdc1d1@linaro.org>
Date: Mon, 16 Jun 2025 14:24:15 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dmaengine: Add NULL check in lpc18xx_dmamux_reserve()
To: Charles Han <hanchunchao@inspur.com>, vkoul@kernel.org, vz@mleia.com,
 manabian@gmail.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250616104420.1720-1-hanchunchao@inspur.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250616104420.1720-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/25 13:44, Charles Han wrote:
> The function of_find_device_by_node() may return NULL if the device
> node is not found or CONFIG_OF not defined.
> Add  check whether the return value is NULL and set the error code
> to be returned as -ENODEV.
> 
> Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Can you have the subject include the driver which you are modifying ? if
you say `dmaengine: Add...` it looks like you are modifying the core.
> ---
>  drivers/dma/lpc18xx-dmamux.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
> index 2b6436f4b193..f61183a1d0ba 100644
> --- a/drivers/dma/lpc18xx-dmamux.c
> +++ b/drivers/dma/lpc18xx-dmamux.c
> @@ -53,11 +53,17 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
>  static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>  				    struct of_dma *ofdma)
>  {
> -	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> -	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct platform_device *pdev;
> +	struct lpc18xx_dmamux_data *dmamux;
>  	unsigned long flags;
>  	unsigned mux;
>  
> +	pdev = of_find_device_by_node(ofdma->of_node);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	dmamux = platform_get_drvdata(pdev);
> +
>  	if (dma_spec->args_count != 3) {
>  		dev_err(&pdev->dev, "invalid number of dma mux args\n");
>  		return ERR_PTR(-EINVAL);


As I see it, the function lpc18xx_dmamux_reserve is only used as passed
to of_dma_router_register . In every driver, functions that have a
similar role are written in the same way, not checking if
of_find_device_by_node fails.
Can you detail what happens in your case that of_find_device_by_node
would fail ?
Would it be required to have this check in all the other drivers ?

Eugen

