Return-Path: <dmaengine+bounces-7275-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6DFC77FF9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 09:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C5C292B987
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2AA2EA749;
	Fri, 21 Nov 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBfs4G3l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CA33BBB4
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715130; cv=none; b=QJnHGi6RRw5Yzm8y3Ru5pwtK39l+8Z+7KqOERVgeLgU/UeAHt08ZRLwDFx+9YFJudtt7Z0s1SFb1cajOGhYwA+/X6LDliE/LclAqYC+FkH+cLR4Iqg3Fs4k8sFCUsDOY4HG4fRzJwqCHzx81GXg3CF9obmW1M2HXin8eMNWReiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715130; c=relaxed/simple;
	bh=xwkfU6OqSfZS/vCDQ0KI/KgXHuZGee8JRlFYylBTPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6JGvLKqTMy5fGNG45YtZX2m3izEL/yfV0XUEL4AsV8i9WGES2u7fNG9XL6NO5ndiKxlehxchklGIlrfHhhCKKFI1FGBlTFkE3Lg8cOC/BU30O82gYz3b5jjEeCWF2jrB1XtrRzUrw4Ck3RDP3qBd0IqMJLWGb+8Fv5He06HLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBfs4G3l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47790b080e4so9554215e9.3
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763715125; x=1764319925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQD6IPCAAuAQSaBuKc7iCXVSBWn0b9pFdIhTL2DU8uw=;
        b=NBfs4G3lwfZS+/foKQOcBu9ctP/8QJeNiHS3bnKZPYi3i4kVt6TboNTUto2+I8sV2d
         Zw5Ycrawn2rFiE4SA33ERWoYlFnt3gKSSUU0rfnGEtKPSFBA9cJVj8dI4aJorQhQ6Iv2
         DPbscpfabNRV6UF9hgWyHhy2IxjdSSKiesnCgVyPZz4oPaqOAEzovXgjDiC7DvdUM/W1
         dOLvv4qV5hTdumfqivpOntvsTam7u3PiYW4XId/fuBGMHfxAOyYQ7aNyq6JLCmo8ohM9
         GM3UuH2QqsX/YMXHv81JoXmLN9UK1hOrezdil2Nj2pWcNbBl7LjfsIlJjhIMTl5y/QRN
         u0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763715125; x=1764319925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQD6IPCAAuAQSaBuKc7iCXVSBWn0b9pFdIhTL2DU8uw=;
        b=RynsGklagXRrKMADHDlIkkXSBKV0jnQHMujfwaWqF/LgK7FP5HghCzJU07NsRk6cGS
         0kHw0jRnJAxq8KVDSC4uoNPHDkUIsVsCHTxnagC70kU65f/VunSaQ3zq+PbUlMmPC9Wj
         /aYMFMh39NZuhV6AdrzuZ3UQLobFpPgNEK0lyhI0xWIlFoj1x6zgNU7FHrxZyfxKYnSy
         gJCEOxEqpgKQoSdWsP9rxSL5EQgtRYazlgzDzs0tezR+FaBEDO2aSpvJefpPOsS2t5bQ
         Jp/rL+Hbn24wX9UlYyIbX+bv5pXv6jXBqB8Y/3Vyx3nJWCuCoRO0pvmfiqfy/dqps2Rm
         UCjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhEl9OdtPR3CGoEzXJMCoxs6xRJmVgUrhoMsKlmV39/z1dM0dksgKqV7efw4/QuOqud935cLUIPBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqIFRW6S9ng8BeCWpNMj5evaqytspuV/hIb4lQe5w5SgGFbW3
	kAIHufX/zkPREiMeuBJckYT8QjxehWvTp+65U56uOxsv+9/S5PuUM7rwQLhbfV8xAM8C2j6YjRC
	uGcP431M=
X-Gm-Gg: ASbGncuAosB5G70uYOtu80ZUf5IFKUMIj0rJM0+51FcGeSgo/oTQHYEEbe7OAyPtYrm
	8c1/ITZ3jpzXWpNtVmIDD5PcyuLp5POYg5YD5P0Oow5DC0Bt1pM4r8p9+GxHJSiTFuRkBScWYNk
	SYfOSP45dwAPf5ofCH0s2/YMTj6lTlbnmrIawGUGtwBrIVMvUuEGefXu+93hgO1OGnOVVxU/DLy
	8XFGNhjJggJbzYbdsGfyWIAy1xO/W4UqirMLGu7yL4Y3lB0eWSJYhFwJaq9fV4ZP2vo1OzFEZNL
	tW/NewLRq1PZwWjAUBuSJbhKQkukTMG9QRvLueaUFpjMbYS78hjyPfDyFMMfWKaN0O5/fWm97ES
	lbfQthGW2wPo7lzyJu6+VUfg5zbFMzSs/L1FiDgNwYIBLKMO2mywmtpB9/q+ss94+4wezGQJHAT
	GT5zs6BBhaQ8Iv+1F2F+NJ81mLyfPU
X-Google-Smtp-Source: AGHT+IEinokPPaK0hYNLhqdwlX0uFESNUqrKrPuclcH1lbM4qDAV3Wx0cwOCGh0v5dfKc0oa55/cew==
X-Received: by 2002:a05:600c:3588:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-477c11179ffmr14043965e9.22.1763715125067;
        Fri, 21 Nov 2025 00:52:05 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm10032980f8f.26.2025.11.21.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 00:52:04 -0800 (PST)
Message-ID: <af7028da-34cc-42e5-8768-b6218ebae3f2@linaro.org>
Date: Fri, 21 Nov 2025 10:52:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dmaengine 1/2] dmaengine: at_hdmac: fix formats under
 64-bit
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:MICROCHIP AT91 DMA DRIVERS"
 <linux-arm-kernel@lists.infradead.org>
References: <20251106022405.85604-1-rosenp@gmail.com>
 <20251106022405.85604-2-rosenp@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106022405.85604-2-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 04:24, Rosen Penev wrote:
> size_t formats under 32-bit evaluate to the same thing and GCC does not
> warn against it. Not the case with 64-bit.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
>  drivers/dma/at_hdmac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 2d147712cbc6..7d226453961f 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -887,7 +887,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
>  	first = xt->sgl;
>  
>  	dev_info(chan2dev(chan),
> -		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
> +		 "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
>  		__func__, &xt->src_start, &xt->dst_start, xt->numf,
>  		xt->frame_size, flags);
>  
> @@ -1174,7 +1174,7 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
>  	int			i;
>  	int			ret;
>  
> -	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
> +	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%x f0x%lx\n", __func__,
>  		 value, sg_len, flags);
>  
>  	if (unlikely(!sgl || !sg_len)) {
> @@ -1503,7 +1503,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  	unsigned int		periods = buf_len / period_len;
>  	unsigned int		i;
>  
> -	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
> +	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
>  			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
>  			&buf_addr,
>  			periods, buf_len, period_len);


