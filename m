Return-Path: <dmaengine+bounces-5128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F8AB1A76
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 18:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BC01885767
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB772356C5;
	Fri,  9 May 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkFvJNV7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AD231841;
	Fri,  9 May 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808114; cv=none; b=cD8oatvlf9VJjmed4qiAbZmY15a7RWAY7T8yDVFgXepFz2+Dm3aTsZ3hgAoID8VzFTWxC9eixoWWVFAQVxrTNyrtF4Lqvslby40Q09wDz/RdmwXPl/o8IpK+nMFz3xdRuAljQSmXrjWd1Rjgf1CvhwuOki/DvHGSKrapA5WkI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808114; c=relaxed/simple;
	bh=XhKWd7Cbton1PmuNKvkjSjQqgDhXUx4DilgBjLgbDPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R11c0UQh/YzNOqm5v7v8PnXvlgStMyyp3j69efQlVymDfgjPZ+QnBTeGwbRKzGWQKuVexgWHByB8NIK3WxyQMgVqfRFdH2iymbn2A/iUskDdEhIlTE1Xq55Poj6PX/LbLsiXpTnUg32KkQm1pTpQW58lgISRmeJZlHAtLiY8pPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkFvJNV7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54998f865b8so2546446e87.3;
        Fri, 09 May 2025 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746808108; x=1747412908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNoGYCfFn1Ise+cYyN4rMghXeEvaDWlpHmEHwktQf4A=;
        b=AkFvJNV7K3vKgyMJXu7X00SexEw/dw+8OL4WCXB7izGhCQYJGUivAeCb6VPPvMxfRV
         9DJyEw723w6NfWM3tE+q8Z2ghKyTxleQf4SxOYx1K1Cz6WJbJfG0q3S1ikBGrZn79ttG
         /Xqtw/fbm/yb/u01pGZsAemoar2omrLazDV+UZ5DAbI9DMDJ7an5IBfCGj335G2JOIb+
         JkZwYE0lrsaLPDbm1xDQMUE+cTvHGNKZywwmzCBrV0jhlizk9UT+4sfji8hlKFuFbYbV
         ZCfmGkuzorCh9RlxgzlrJGKnvxJ0Xt2qu7T3mQEQFTtte5bt1Y1Sp2S+24qJ5zyrIifG
         /Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808108; x=1747412908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNoGYCfFn1Ise+cYyN4rMghXeEvaDWlpHmEHwktQf4A=;
        b=q4JhteL5H5F1GCgyZaBwkuaOh07INEx+y95xxL64xQqJO5l1aElyt51OpEvpwOV1w+
         nBEimlp27+xPITiGpkub16gXfHD0rY6uQ66FP8F9lP+91/Jhl8M5LR8mVr80GxjmOZfc
         T8GV7fkE9ws5To2as0bLujTXsaP8VForwOveZLGz5Pt5q5SUEWqAkYHj8V3U4bU0z7d0
         ccLQnelr90FFSN1A8D4ZMKS16iunPvARqVEAu1GYc/RFek3yRHmQDAkL68FpNl4TT+UR
         /lhKWtd5pLjsQVdxFFRhZeVFbE/7uNyNmzRcaQvjHqkyTabVWiGMx09alC6/urP4cqmx
         MaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGwhVMV+Z4SXxgsULm7tXEEwzbZAos6lMRR1zy2Jjvb0734JFKYdlqRnXVE5FZe3F0cgDUE4cNXjYW@vger.kernel.org, AJvYcCUsmtRx6cFssNKfJ5ViRdhLV9geYs9VPLgwAYnS18G/cQHB37N5lNL/p1JlPOL/OETbsNK8aUoMlei4@vger.kernel.org, AJvYcCXpjn2zVOuRkT3kiuqrso/Dze0nCWKU6TwYU77yhcVQdLwvxtGiHnptmfCrrAjSzXsF9i55bmv/p/QJVkg7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAC6dE1bIETJznuc+fnBMFBN5826KYlEEs3yqDqI5OzhjBNzdb
	d1z1HuHhNcki/Sqr2Dd1d5apcJUKzr/tSTvaFx5QfDQt5lYWLK57SvMKhitDPlE=
X-Gm-Gg: ASbGncuHSag8NLIgZ8bxPP75V2z4cuIgpJxTNpC3cO462ccfoAVomy+/zRC6heKN1eG
	IzxTJgZ3PetDAhWvM+FNy0nYUHQMUstEDL5B0JmUxKXn4DUxIhXQU2XNqU8Gj1cJ7WhRiu6jYkO
	V8yQMocfuUXPvatJ7fkKBXfxp0uY+UyNKJE4SiqMpdtL+fc2hHhCGB/Xswegr4fKKfElpVtcKt6
	OFqggvua8UPJ2ReCIqh842oEsTZZPmaxy8j2YntRyAfAB9THMGmIdgtNRTfAQ1Zg8XHcuU9F4Vb
	siN17DxrU9mN23Vk6ombcO89nwa8ZEQS2vqCvsBpfIO8Zj4iRDyhlT3vRoo+Xg+o1fIcf+1rDVt
	OQWnujYQPIoXE
X-Google-Smtp-Source: AGHT+IH/EXb373raBKjt6WQfYf9//Y986Nd2SlGxe0WcdFkLId+97MeCHvJVp1WwYjOQkLDE9lalsA==
X-Received: by 2002:a05:6512:6501:b0:54f:c074:869a with SMTP id 2adb3069b0e04-54fc67e28c9mr1175869e87.45.1746808107398;
        Fri, 09 May 2025 09:28:27 -0700 (PDT)
Received: from [10.0.0.100] (host-185-69-73-15.kaisa-laajakaista.fi. [185.69.73.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cdaasm325994e87.60.2025.05.09.09.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 09:28:27 -0700 (PDT)
Message-ID: <aa852707-9be9-4e88-a0b3-034ebd47a9ac@gmail.com>
Date: Fri, 9 May 2025 19:29:40 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drivers: soc: ti: k3-ringacc: handle absence of tisci
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-6-s-adivi@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20250428072032.946008-6-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/04/2025 10:20, Sai Sree Kartheek Adivi wrote:
> Handle absence of tisci with direct register writes. This will support
> platforms that do not have tisci firmware like AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/soc/ti/k3-ringacc.c       | 162 +++++++++++++++++++++++++-----
>  include/linux/soc/ti/k3-ringacc.h |   4 +
>  2 files changed, 142 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 82a15cad1c6c4..49e0483676a14 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -45,6 +45,38 @@ struct k3_ring_rt_regs {
>  	u32	hwindx;
>  };
>  
> +#define K3_RINGACC_RT_CFG_REGS_OFS	0x40
> +#define K3_DMARING_CFG_ADDR_HI_MASK	GENMASK(3, 0)
> +#define K3_DMARING_CFG_ASEL_SHIFT	16
> +#define K3_DMARING_CFG_SIZE_MASK	GENMASK(15, 0)
> +
> +/**
> + * struct k3_ring_cfg_regs - The RA Configuration Registers region
> + *
> + * @ba_lo: Ring Base Address Low Register
> + * @ba_hi: Ring Base Address High Register
> + * @size: Ring Size Register
> + */
> +struct k3_ring_cfg_regs {
> +	u32	ba_lo;
> +	u32	ba_hi;
> +	u32	size;
> +};
> +
> +#define K3_RINGACC_RT_INT_REGS_OFS		0x140
> +#define K3_RINGACC_RT_INT_ENABLE_SET_COMPLETE	BIT(0)
> +#define K3_RINGACC_RT_INT_ENABLE_SET_TR			BIT(2)
> +
> +struct k3_ring_intr_regs {
> +	u32	enable_set;
> +	u32	resv_4;
> +	u32	clr;
> +	u32	resv_16;
> +	u32	status_set;
> +	u32	resv_8;
> +	u32	status;
> +};
> +
>  #define K3_RINGACC_RT_REGS_STEP			0x1000
>  #define K3_DMARING_RT_REGS_STEP			0x2000
>  #define K3_DMARING_RT_REGS_REVERSE_OFS		0x1000
> @@ -157,6 +189,8 @@ struct k3_ring_state {
>   */
>  struct k3_ring {
>  	struct k3_ring_rt_regs __iomem *rt;
> +	struct k3_ring_cfg_regs __iomem *cfg;
> +	struct k3_ring_intr_regs __iomem *intr;
>  	struct k3_ring_fifo_regs __iomem *fifos;
>  	struct k3_ringacc_proxy_target_regs  __iomem *proxy;
>  	dma_addr_t	ring_mem_dma;
> @@ -465,16 +499,30 @@ static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
>  	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
>  	struct k3_ringacc *ringacc = ring->parent;
>  	int ret;
> +	u32 reg;
>  
> -	ring_cfg.nav_id = ringacc->tisci_dev_id;
> -	ring_cfg.index = ring->ring_id;
> -	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID;
> -	ring_cfg.count = ring->size;
> +	if (!ringacc->tisci) {

these are not in hot path, right?
The reg can be moved here and in other functions.

> +		if (ring->cfg == NULL)
> +			return;
> +		reg = readl(&ring->cfg->size);
> +		reg &= ~K3_DMARING_CFG_SIZE_MASK;
>  
> -	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> -	if (ret)
> -		dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx %d\n",
> -			ret, ring->ring_id);
> +		writel(reg, &ring->cfg->size);
> +		wmb();
> +		reg |= ring->size;
> +
> +		writel(reg, &ring->cfg->size);
> +	} else {
> +		ring_cfg.nav_id = ringacc->tisci_dev_id;
> +		ring_cfg.index = ring->ring_id;
> +		ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID;
> +		ring_cfg.count = ring->size;
> +
> +		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> +		if (ret)
> +			dev_err(ringacc->dev, "TISCI reset ring fail (%d) ring_idx %d\n",
> +				ret, ring->ring_id);
> +	}
>  }
>  
>  void k3_ringacc_ring_reset(struct k3_ring *ring)
> @@ -494,16 +542,30 @@ static void k3_ringacc_ring_reconfig_qmode_sci(struct k3_ring *ring,
>  	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
>  	struct k3_ringacc *ringacc = ring->parent;
>  	int ret;
> +	u32 reg;
>  
>  	ring_cfg.nav_id = ringacc->tisci_dev_id;
>  	ring_cfg.index = ring->ring_id;
>  	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_RING_MODE_VALID;
>  	ring_cfg.mode = mode;
>  
> -	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> -	if (ret)
> -		dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx %d\n",
> -			ret, ring->ring_id);
> +	if (!ringacc->tisci) {
> +		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
> +		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
> +				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
> +				&ring->cfg->ba_hi);
> +
> +		reg = readl(&ring->cfg->size);
> +		reg &= ~K3_DMARING_CFG_SIZE_MASK;
> +		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
> +
> +		writel(reg, &ring->cfg->size);
> +	} else {
> +		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> +		if (ret)
> +			dev_err(ringacc->dev, "TISCI reconf qmode fail (%d) ring_idx %d\n",
> +					ret, ring->ring_id);
> +	}
>  }
>  
>  void k3_ringacc_ring_reset_dma(struct k3_ring *ring, u32 occ)
> @@ -570,15 +632,29 @@ static void k3_ringacc_ring_free_sci(struct k3_ring *ring)
>  	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
>  	struct k3_ringacc *ringacc = ring->parent;
>  	int ret;
> +	u32 reg;

this can be added to if (!ringacc->tisci) { } scope.>
>  	ring_cfg.nav_id = ringacc->tisci_dev_id;
>  	ring_cfg.index = ring->ring_id;
>  	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
>  
> -	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> -	if (ret)
> -		dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
> -			ret, ring->ring_id);
> +	if (!ringacc->tisci) {
> +		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
> +		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
> +				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
> +				&ring->cfg->ba_hi);
> +
> +		reg = readl(&ring->cfg->size);
> +		reg &= ~K3_DMARING_CFG_SIZE_MASK;
> +		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
> +
> +		writel(reg, &ring->cfg->size);
> +	} else {
> +		ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
> +		if (ret)
> +			dev_err(ringacc->dev, "TISCI ring free fail (%d) ring_idx %d\n",
> +					ret, ring->ring_id);
> +	}
>  }
>  
>  int k3_ringacc_ring_free(struct k3_ring *ring)
> @@ -669,15 +745,31 @@ int k3_ringacc_get_ring_irq_num(struct k3_ring *ring)
>  }
>  EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_irq_num);
>  
> +u32 k3_ringacc_ring_get_irq_status(struct k3_ring *ring)
> +{
> +	struct k3_ringacc *ringacc = ring->parent;
> +	struct k3_ring *ring2 = &ringacc->rings[ring->ring_id];
> +
> +	return readl(&ring2->intr->status);
> +}
> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_irq_status);
> +
> +void k3_ringacc_ring_clear_irq(struct k3_ring *ring)
> +{
> +	struct k3_ringacc *ringacc = ring->parent;
> +	struct k3_ring *ring2 = &ringacc->rings[ring->ring_id];
> +
> +	writel(0xFF, &ring2->intr->status);
> +}
> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_clear_irq);
> +
>  static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
>  {
>  	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
>  	struct k3_ringacc *ringacc = ring->parent;
> +	u32 reg;
>  	int ret;
>  
> -	if (!ringacc->tisci)
> -		return -EINVAL;
> -
>  	ring_cfg.nav_id = ringacc->tisci_dev_id;
>  	ring_cfg.index = ring->ring_id;
>  	ring_cfg.valid_params = TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER;
> @@ -688,11 +780,26 @@ static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
>  	ring_cfg.size = ring->elm_size;
>  	ring_cfg.asel = ring->asel;
>  
> +	if (!ringacc->tisci) {
> +		writel(ring_cfg.addr_lo, &ring->cfg->ba_lo);
> +		writel((ring_cfg.addr_hi & K3_DMARING_CFG_ADDR_HI_MASK) +
> +				(ring_cfg.asel << K3_DMARING_CFG_ASEL_SHIFT),
> +				&ring->cfg->ba_hi);
> +
> +		reg = readl(&ring->cfg->size);
> +		reg &= ~K3_DMARING_CFG_SIZE_MASK;
> +		reg |= ring_cfg.count & K3_DMARING_CFG_SIZE_MASK;
> +
> +		writel(reg, &ring->cfg->size);
> +		writel(K3_RINGACC_RT_INT_ENABLE_SET_COMPLETE | K3_RINGACC_RT_INT_ENABLE_SET_TR,
> +				&ring->intr->enable_set);
> +		return 0;
> +	}
> +
>  	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
>  	if (ret)
>  		dev_err(ringacc->dev, "TISCI config ring fail (%d) ring_idx %d\n",
> -			ret, ring->ring_id);
> -
> +				ret, ring->ring_id);

suprious change? The alignment was correct.

>  	return ret;
>  }
>  
> @@ -1480,9 +1587,12 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>  
>  	mutex_init(&ringacc->req_lock);
>  
> -	base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
> -	if (IS_ERR(base_rt))
> -		return ERR_CAST(base_rt);
> +	base_rt = data->base_rt;
> +	if (!base_rt) {
> +		base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
> +		if (IS_ERR(base_rt))
> +			return ERR_CAST(base_rt);
> +	}
>  
>  	ringacc->rings = devm_kzalloc(dev,
>  				      sizeof(*ringacc->rings) *
> @@ -1498,6 +1608,10 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>  		struct k3_ring *ring = &ringacc->rings[i];
>  
>  		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i;
> +		ring->cfg = base_rt + K3_RINGACC_RT_CFG_REGS_OFS +
> +			    K3_DMARING_RT_REGS_STEP * i;
> +		ring->intr = base_rt + K3_RINGACC_RT_INT_REGS_OFS +
> +			     K3_DMARING_RT_REGS_STEP * i;
>  		ring->parent = ringacc;
>  		ring->ring_id = i;
>  		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
> index 39b022b925986..fcf6fbd4a8594 100644
> --- a/include/linux/soc/ti/k3-ringacc.h
> +++ b/include/linux/soc/ti/k3-ringacc.h
> @@ -158,6 +158,9 @@ u32 k3_ringacc_get_ring_id(struct k3_ring *ring);
>   */
>  int k3_ringacc_get_ring_irq_num(struct k3_ring *ring);
>  
> +u32 k3_ringacc_ring_get_irq_status(struct k3_ring *ring);
> +void k3_ringacc_ring_clear_irq(struct k3_ring *ring);
> +
>  /**
>   * k3_ringacc_ring_cfg - ring configure
>   * @ring: pointer on ring
> @@ -262,6 +265,7 @@ struct k3_ringacc_init_data {
>  	const struct ti_sci_handle *tisci;
>  	u32 tisci_dev_id;
>  	u32 num_rings;
> +	void __iomem *base_rt;
>  };
>  
>  struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,

-- 
Péter


