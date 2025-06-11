Return-Path: <dmaengine+bounces-5363-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E70AD5680
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88FC188C7A8
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997E26A1CF;
	Wed, 11 Jun 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9PQQeTz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B328688A
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647139; cv=none; b=LsGHWpNGLsXMrKwNt4AbBhYNmQk2EXNWWckQNb4vvtxjOaSE/MSh0ThE86dkFIiHolrcpFhaD4FKTVT2iHiYhmw1I9PQyZwXdkO5z3bn2GSXrAntwyq9LEme9IF1jaVaPsKQBjYbQ8z9xJ53t9X1zTWCQHdixboPsl6y1zfaGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647139; c=relaxed/simple;
	bh=EjVY2ArlQ4qGt0K73z9GDztVoL7a90MNu70YfxiFca8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DofCT5d4Ua2lJvyDQRIRjyilX4tZERj7mu4IJ0Vb/hwlL25b7rb3JD3CQeqPRGUqOK5ZGJDd7Ja1glpaNCGHPblywRneCKydGKVFf9C2yuDdPnTeukB4GjgnprR7uxEOydcPMzApbGRrxYLK1I0dxDooUX8frM1tNuYFUBP6kS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9PQQeTz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so7929375e9.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749647136; x=1750251936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3R09Iyu+oVEvrLJByqrLxu4/r9hm8EBVtdwnnJnPEk=;
        b=x9PQQeTzy3IXKBRpR4zz1vRcjNz1UqBcdJnRxpRqPQ5BJ1zdDDk7rTCyplxj1ja7o7
         H0IwxvhW8b0CoK1Zfi8vcwanQKReI02MnD7aO4/TL9Z9SxjIDQRfabRAJFtkIX5d0Z8B
         DuKhD0WQVNSSdcYDzRHhXK4PDhpo/bCqW+62vcpiL2UQJzyye0Mca1nUxnQkufrucfXa
         crx6NoAjLxi5rjLMTl54QAmnbw2ebUKNO51eVOBsX/w3yaAOTk2WIDHoHIRSj5QnMlvQ
         87VmpEm0a1WZOUHmzk6W7o/o4JEfHDJOkmVBk4TorWNQWAbKMoExmg66UJToCijzyt0j
         OcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647136; x=1750251936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3R09Iyu+oVEvrLJByqrLxu4/r9hm8EBVtdwnnJnPEk=;
        b=parg4ejMZAzS0GdWMuMVdkwwIY/1g3ZVmUs+IdIq6MH7JRROH8qpkdYw/MEWl/DA73
         HUDYbEClk0iay0Rjma/dc9/RuLSC/9dVU4loF4AFx//0tCs16jxFtjvIQqXar1/zNjvh
         g4MsnjdcobYn7eRN1OBrZiqxYfhrQ9u//D8jmacbFhNO77B2KF266oekckVXGUvhA6Hs
         dozWa0KsmCPMTVwa8T+Vqgm6tGvlorniwPVKedsbSziV284IA4HRYOVrfaymS6YSpqGp
         hw86OxQa0SUwOz4Nap/ySkt+YDRmHuPfAO8vRHoyjqMRdymIJLDoGQdRaIEbdDLkMd5O
         8OmQ==
X-Gm-Message-State: AOJu0Ywo/QXASVRcZG2xF6I1eF881/Dxim6r7MHjaS06dqcj2YxUCDCO
	pslY+iaMAJeI0En//zcl9M/7rwXYmTQgTA39PhJz0UbhNSrLvpFDqVodqwO2Y4r1ldo=
X-Gm-Gg: ASbGncsEOZzki8UbMFvVmHamBkjQddGb0RvN/3dO9VPRcUWPdpdrxiaTP6yTo5vIOjb
	9WK4o8Y1wJgMcYOyBRTpZV3i8NvAfz6fRJFiI/GhZPv6NREgLo4i/K0yhWxhkr2T4Xuw5aBFr9h
	Yw2HzT1CzlqMcOCq2dEyXgmF3dDnF29ft0l5BAucPTLuz1Yt0NuXX2+qPXY92KdnPQvojU9dic4
	EkvE8zoNRchoJonwf1Wha0TtHcKcjkYZ4ZnJ3lSkqNxEOwDOYFBmLZSzJgUbAEOE3t0KjY13Bd+
	aJX6lQcW8pzhR7Gy9vArXj4mXXQ8ITK5OITiP1ExKODIvq5/M1jvcu9MGokGG2hzrxnB3Idtsg/
	kp8R7n9O3TjN9NyAlS62fgHaNhBelHLdvvuE2GXN0IXB0gTl4RBfcNNvw
X-Google-Smtp-Source: AGHT+IE/+ZF0202H2gGrgjMZ/XMTAOBrohuHjeBubUtp7vBfdN9DADireHyArZ8FK4FEDHt2MkhIeg==
X-Received: by 2002:a05:600c:314c:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-453240b0e39mr34289735e9.3.1749647136238;
        Wed, 11 Jun 2025 06:05:36 -0700 (PDT)
Received: from [192.168.1.105] (92-184-112-57.mobile.fr.orangecustomers.net. [92.184.112.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325141397sm21364185e9.8.2025.06.11.06.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 06:05:36 -0700 (PDT)
Message-ID: <0e1ae53e-e2a9-44ec-a59b-432bbf8d4b49@linaro.org>
Date: Wed, 11 Jun 2025 16:05:34 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: mediatek: Fix a flag reuse error in
 mtk_cqdma_tx_status()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sean.wang@mediatek.com,
 vkoul@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250606090017.5436-1-chenqiuji666@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250606090017.5436-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/6/25 12:00, Qiu-ji Chen wrote:
> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> 
> Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
> V2:
> Change the inner vc lock from spin_lock_irqsave() to spin_lock()
> Thanks Eugen Hristev for helpful suggestion.
> ---
>  drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
> index 47c8adfdc155..9f0c41ca7770 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -449,9 +449,9 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
>  		return ret;
>  
>  	spin_lock_irqsave(&cvc->pc->lock, flags);
> -	spin_lock_irqsave(&cvc->vc.lock, flags);
> +	spin_lock(&cvc->vc.lock);
>  	vd = mtk_cqdma_find_active_desc(c, cookie);
> -	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> +	spin_unlock(&cvc->vc.lock);
>  	spin_unlock_irqrestore(&cvc->pc->lock, flags);
>  
>  	if (vd) {


