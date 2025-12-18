Return-Path: <dmaengine+bounces-7798-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E2CCABA5
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6679B300E812
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 07:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730C2248A0;
	Thu, 18 Dec 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YCgKcs/j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D62E175F
	for <dmaengine@vger.kernel.org>; Thu, 18 Dec 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044104; cv=none; b=XkvmaDbsrbnVrX78nEuBEfhwPaAdsD/qEtgxCVsjd4mzuotiaSvlYBf1Lo6UTq2bDvOhQzMFPjd+DCeti2jkx3ubx3FrXsdRBKnBsL5nHirx75n74zrHanOQ2zYV4CcTgFQ4OOU4tpLPAgFzUwLjxH3urG3Ih5w4wb2I7PpfPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044104; c=relaxed/simple;
	bh=K5uK47+WW5FjLdyB+AQJmTbA3e07dSwTYQbFZcwjObY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuTfelxXbKX8fzvV5xt1aEkV3eBtC8vrtU2puawwcHtC0k3YBp6N7jYNYyNFYLn/FsTsk8bvSBbRaV2nAICCY8YWkSo2UChzhvg6s6upBc/LbV3SRy0U5rc4TAR02uDvMoIiFbxJctiyYyJKYiD1noW4LF7o5w5HXFUBnRAbMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YCgKcs/j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47796a837c7so1990055e9.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766044101; x=1766648901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nb9467quSjbI4BCMeKp7Lg5mze+L6FKwbjedwnMjf/Q=;
        b=YCgKcs/jWBcSQx4+mQtLda4YNp6WS78CIKRmzBl9VqqyvjcqPE9q+FETlVXre4tj4l
         dQpOpYh6ROJ07rjVMJx+P91RQrgtNDAPi9TCYDBw/KVDywB/3ASrZ9xcJjNVbcMhQzcs
         XnBNfXPGFgC2FZqX8gHxl4Z9/0Jm+BNrvYNK5+Mvm1EqavjH/RgBTcspNKhRYqvFPC2R
         0jmSdrLir2ViTvtFA1VBQzBW+SHzpVv2kn6CxLca1X0HSbwNxlYdtqygmDC2O976jMEm
         B003TNkvElzsb6WBV95kRs995AozfyJbixXlNB5AZuDMThXvG9VynkURw0ImB2vLE8CL
         3M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766044101; x=1766648901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nb9467quSjbI4BCMeKp7Lg5mze+L6FKwbjedwnMjf/Q=;
        b=vgdXvQu/r1QW0Gc4awS99Agv2H2o8SqCak9t9Nt4WOyXefC4IA9HTCDBG/UESK2Fi1
         6D9Zr9jxRwH3jKXnlZAnjW8tzQtRNPmgp7XPO/dN8vrXObK4DtsWOCF654f/+NfaFF7Y
         f2/YuD4UsN9JMvoHHMF4kFBWLByRAcJHs3X8wBSuIvx6P2gf4hgj7jdcRlZxOkiSdTSf
         jDF1U+z5nDzZxFoshKtOVlrXcc3QkIy2JBl86bYxJOcqSikfXsOZwVzbkBxnlW+TKsc/
         t/Erv1tFGH1qBKoNozmTv6Qmeanwic7ygc1wyTJ/8lF4ZR0wHIiU7qgnLz7YykUOoNHB
         c2xA==
X-Gm-Message-State: AOJu0Yx9OOCw9M2d1g0sRGvwTAKdyqF9XvFViOi8S9Nf09+zjtRT9SmP
	6Y/QG5mczUAfhSWR3xHApMuUIBrDZzjiu8OkGjL4xLg9/r08CHxvaTxhWfco2RwgV7EOKfodptt
	7ndra
X-Gm-Gg: AY/fxX7pcJQu/fVDKnhktT4W/cpVxLywV5+5dGpoxLowhPG1LDTzXbJWCSkji5vYnMt
	BIqUGrSCnbxN9Nq+rjt14KcktewOpUW/M4LyLpH3zjJXTZNsp5iuaDwWZCyomInHEJVZVkaL4dX
	mQBpIGrp1yJn96kerKW0ldS3PrI8EjHLPgBKXnkOfBp1/O9hNAY2vfclsRPmoiGOqXWqfC2HA+P
	JkXJd6VzcKhqM362bUKGijK/q01xzElCdIsfmM4wPt6lIGgF1iZd88SJEowappZIAh0zTA6d1AA
	Kw9sUmxUS5mZTsRpdtuvbMFyzu72k8hEfTlrt6/Bt3DWe2LP4PzdyVdUQlpKMPvG5OEeMfIl86T
	T2Jxnw/OZMQZhlw5x3jFG9CV5LkwDpP6sgmYY0V0fbo7Yk3KU+0JVdM2ssKHgF7x7tCOTcnc5Jc
	tUGvA1e5GmYx292NzRgXGimgpS6NkR
X-Google-Smtp-Source: AGHT+IHPsvRvux6/aR1+pH9ZEVuMlPSAdqBQpGZ0qCU5K9j/lVLnUkjqIW3hPcn0hMNFBg+qzM3HCA==
X-Received: by 2002:a05:600c:a31b:b0:47b:d949:9b87 with SMTP id 5b1f17b1804b1-47bd9499db0mr60638845e9.12.1766044100488;
        Wed, 17 Dec 2025 23:48:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273e4d5sm29709125e9.6.2025.12.17.23.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 23:48:19 -0800 (PST)
Message-ID: <a0a4666a-edc4-4455-9e62-d61254447e36@tuxon.dev>
Date: Thu, 18 Dec 2025 09:48:18 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
To: vkoul@kernel.org, fabrizio.castro.jz@renesas.com,
 biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217135213.400280-7-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251217135213.400280-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/17/25 15:52, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add support for device_{pause, resume}() callbacks. These are required by
> the RZ/G2L SCIFA driver.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v5:
> - used suspend capability of the controller to pause/resume
>    the transfers
> 
>   drivers/dma/sh/rz-dmac.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c3035b94ef2c..e349ade1845f 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -135,6 +135,7 @@ struct rz_dmac {
>   #define CHANNEL_8_15_COMMON_BASE	0x0700
>   
>   #define CHSTAT_ER			BIT(4)
> +#define CHSTAT_SUS			BIT(3)
>   #define CHSTAT_EN			BIT(0)
>   
>   #define CHCTRL_CLRINTMSK		BIT(17)
> @@ -827,6 +828,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>   	return status;
>   }
>   
> +static int rz_dmac_device_pause(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 val;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		val = rz_dmac_ch_readl(channel, CHCTRL, 1);
> +		val |= CHCTRL_CLRSUS;

This is wrong, I overlooked it. It should have set the CHCTRL_SETSUS bit.

> +		rz_dmac_ch_writel(channel, val, CHCTRL, 1);
> +	}
> +
> +	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					(val & CHSTAT_SUS), 1, 1024, false,
> +					channel, CHSTAT, 1);
> +}
> +
> +static int rz_dmac_device_resume(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 val;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		val = rz_dmac_ch_readl(channel, CHCTRL, 1);
> +		val &= ~CHCTRL_CLRSUS;

Same here. It should have set the CHCTRL_CLRSUS bit.

I'll update it in the next version.

Thank you,
Claudiu

