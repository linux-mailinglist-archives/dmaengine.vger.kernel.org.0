Return-Path: <dmaengine+bounces-2295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9F8FF3AD
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 19:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C412B1C26904
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0D1990D8;
	Thu,  6 Jun 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHRnrKN9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F61990C8;
	Thu,  6 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694835; cv=none; b=UDxVBQbfT2sujRcKeU3tMZ0DdrIUvrJgl62pa+xQh6/PE1wJ7qVsVcgxFr2DopEz5KKBt83g4HFc8EIbFfTyxV+pNsg/W9wDqKIT6+meeZso227t7k4Khfu1AV+A+Zvs2m5gq8+GR0mi00CMaSRpTYowQeWpEZDQt38naZsPyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694835; c=relaxed/simple;
	bh=00CNnKfYf4m94sDjDxhhBBDOl45dZ+7MLCQdgobspB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp2T3yzgaEQC3PumC9XSd+CxQnJCVBte6z7YGyOYrgvi8VySzcR8GkG+7bRQFRKj9Wql29bP5tFXoKuyqpTeP8z6Scauax0bVzYbmde9HhQ/NqDgeaD9n+UT3tb2xFH7qF/xuKEdXhL0hFG+f2Iw3fkveWtO+tmiWhk6CpronNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHRnrKN9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b919d214cso1239245e87.2;
        Thu, 06 Jun 2024 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694831; x=1718299631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma8i9n0Ul2xhEENoFuQX+QsntPlbItenEYXbdtOE3xI=;
        b=iHRnrKN9IegKtTFMMs670+xcdcbx/IT7ak2Wax5SAmL7vvWTwBR+clQms4fOjXDE73
         faXzvTq0svubA0pn05aoE0pr61G8ihfs3E1kblcdwD7vREaIO3sf4kzvJg2nGclU8WXk
         I8AOsE2cw3tUuvStxFD1beTH9TIPpHWAFCknUsxgF+pgi5CRNkyGiHdqVwYtVzMFNWLN
         tg5P+YtaBpQHP/wPHyIxi8HeCCuSwSQg78JCpIGo79DCAZwWyMslCswU4pgm/lHjea4I
         W/+Z27a7wpIW9/qlKfDomOhGtCTCy3nxMRGs2BbXvHKO8bH5kBZnTYPFhCIIG/lMSFu5
         hQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694831; x=1718299631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma8i9n0Ul2xhEENoFuQX+QsntPlbItenEYXbdtOE3xI=;
        b=dbw3mf5DOFMYBFpmIURnTqebNH/5Lm3Qr1IUqwxUDVhNPs/BEfMxplCLG2Q6fCLfHg
         Oyi9fRT/8dsGZzd2ZUOfvgn2dFC7GU7BMQ3+cY5DvuCl9HSw3RvPiOAxGhuCFaDeTG8m
         3CeUWpGvdYExSCXo1JZ3TZbRwUUBKgO2Cv2zspSMGOlV5cAFrgyWEsa76AUwd7HkPH7a
         hb2t5u1xXw83cpUDw32Ca4S3dZNlnk/tHp8AwFSWoffZSH4VT2sHJ1/7Sp0UHAhsXjPX
         oRvMqUBSQtvXI1ikuwVm5lF7sPE/iIkPMwVGu83d7XPOBCwXR7iCxt8CSzqUSL1aEnTg
         HzOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfq8c8FUmp0T4r+aI8C8Sfbz+R2JE6CttGOmNXjpPeK4n8LWWcyXSxj1nJ6ts3ICFSWjoavPfHF+b8Oa7LJAZxlqNxSWXMgrkSz+GXedHOOS9OeltKA2eb43Q490RzZwjbXp13JhW7w0TTC/464vmq6ikLmgHBn9mMe6WHSqbzOqJhwgV6LeYzLUTafSupMQtliHAAGUCqWwzusDSDWKB4
X-Gm-Message-State: AOJu0YxgRNfokfHx/8Rf3mlpevCeIcayQCWQFfCJLtb+5yw0uSMPE35X
	ccW4ZKTldXQM8sFsx2zfogolGpS+UP836CzBUtxhKYEoa8c6fALy
X-Google-Smtp-Source: AGHT+IEbM6f+wbNlbLV6qSOqxDLFngYi99yMRrr1PnbH4p95Hn9PHtQN5YFpne5N83Yh7dK9IqDr3w==
X-Received: by 2002:a05:6512:2812:b0:529:b6e9:7978 with SMTP id 2adb3069b0e04-52bb9f8ef6fmr224153e87.37.1717694831074;
        Thu, 06 Jun 2024 10:27:11 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433c894sm251499e87.256.2024.06.06.10.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:27:10 -0700 (PDT)
Message-ID: <0a77e955-e5a6-4a0e-8c1d-8b2ebd0d1eec@gmail.com>
Date: Thu, 6 Jun 2024 20:30:43 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dmaengine: ti: k3-udma-glue: clean up return in
 k3_udma_glue_rx_get_irq()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Julien Panis <jpanis@baylibre.com>, Chintan Vankar <c-vankar@ti.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
References: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/6/24 5:23 PM, Dan Carpenter wrote:
> Currently the k3_udma_glue_rx_get_irq() function returns either negative
> error codes or zero on error.  Generally, in the kernel, zero means
> success so this be confusing and has caused bugs in the past.  Also the
> "tx" version of this function only returns negative error codes.  Let's
> clean this "rx" function so both functions match.
> 
> This patch has no effect on runtime.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/dma/ti/k3-udma-glue.c                | 3 +++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 4 ++--
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 4 +---
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index c9b93055dc9d..b96b448a0e69 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -1531,6 +1531,9 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
>  		flow->virq = k3_ringacc_get_ring_irq_num(flow->ringrx);
>  	}
>  
> +	if (!flow->virq)
> +		return -ENXIO;
> +
>  	return flow->virq;
>  }
>  EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 4e50b3792888..8c26acc9cde1 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2424,10 +2424,10 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
>  
>  		rx_chn->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
>  
> -		if (rx_chn->irq <= 0) {
> +		if (rx_chn->irq < 0) {
>  			dev_err(dev, "Failed to get rx dma irq %d\n",
>  				rx_chn->irq);
> -			ret = -ENXIO;
> +			ret = rx_chn->irq;
>  			goto err;
>  		}
>  	}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 088ab8076db4..cac7863c5cb2 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -440,9 +440,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  			fdqring_id = k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
>  								     i);
>  		ret = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
> -		if (ret <= 0) {
> -			if (!ret)
> -				ret = -ENXIO;
> +		if (ret < 0) {
>  			netdev_err(ndev, "Failed to get rx dma irq");
>  			goto fail;
>  		}

-- 
Péter

