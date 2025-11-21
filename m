Return-Path: <dmaengine+bounces-7276-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BCC77FFC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C5CB34D880
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470413777E;
	Fri, 21 Nov 2025 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RE/7bUWj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213491A238C
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715159; cv=none; b=uoyeMsoJEemjdx/07NWv6daYNTfNcAy2JBForUDhj9XU7EFJRY4J4TCBFBvkOnLpPQci6nZ0CLYbp9wq2mcNXO89mkQ1YAkeQJFNyymDBHPBxUDJ3R4/Diwso/Co/JspYVmdq00QoE06sCNs1kcsSge1LGLG5f8zUtjnD3q9dWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715159; c=relaxed/simple;
	bh=Loin32MHEc8zOgv3AhAhv54lMYJua0SWd3Mu62ufLL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKErCAuwd7sgYEZhxTzO3jPCERdRQB87xvho+03Rm4ew5ux6lzwlGwtkX9s3vICxmjf2EiloQQJxxL6J3kf4CvCl3RiEzEuza+St1Kpe91fsIaBM50HTTMHioK7wAk8DJ0XJ0nFHdFfWT3m3Cq8dleogzvE45uwG4cjpt22aYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RE/7bUWj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so11390995e9.0
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763715155; x=1764319955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=009Kp7JLW19gzy0Kbdi9X3BDysqs7Ujtagl/qk1DBvg=;
        b=RE/7bUWjKFc0e6bjyq8efl6qdayIxUmPVlPJ7laFsO3bu4phCs+S+npGkP33tHnPCH
         SwVpiPvxz7DcTMiyw6Opg5BivvIProE+feFJ94sx1d8n3DZLnt2A/Txn/oFnrS2ruwhn
         GP4hXicV2XdVs3V4QZ/+6FqmK/gYxV9vg9ZyD6AuA6Waiudb1WpCX9JvxwXXRGfUEwno
         hNa55bdhkZIxNLu7wDp3WE3c/EN/LvZ559h/gAV3SNMvg+pM2bNUYGChuK7G0pkYQgR3
         gJPO/ClrnSFd+azm1YY6TrjKs866mgQBFNPGnAWL9vrywhDrV9rZq8RgHxydeNe41avW
         cubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763715155; x=1764319955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=009Kp7JLW19gzy0Kbdi9X3BDysqs7Ujtagl/qk1DBvg=;
        b=EtwF5x9yPuy/S7Gw9XqTna64s22PxG9BiIX+qswr/IaVaop6UmDsTBw2XeYdCAbyiC
         dhPMyImNpZ4eiD7VXJ2X+2kPZr4+Ltwk7s5QGDthXKPbt82VLRk+7op/F7ff8WL1QMME
         SGdir1sc1KUAGK6iEonU63E+Qtq6brTgcx1Km86oq6vkWPn3ervRieS2gfY4tR35k2Ih
         j9XP8dRyYn77nsCkThpm5tqUDLwkc9f+do9fnUmq3DDC4munA8ysc4XOQWWlHzKq1sBv
         m7l0YewaxCfJwnKnry/GtnGbLW07sSFmNy/P06HnngRCdI+rc2WvARZigvaKOpPeWpNU
         IHng==
X-Forwarded-Encrypted: i=1; AJvYcCX2kueAVaW35qS+tqHMOui1JcFDWF96EQZ4G995HwGX8+HHGyXXzFh/NN/n7D52zMNTKWCeVIKqtic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmjWbphOHnooKHbbX0DWunkAYuaIh7zSfeqmCBFc6unfTSSTg
	tj09MRdZMogJ41mTpf8nx7jp5eo2IyRiAMJGkCKrihH3lK44dIMjwomwzcqC7TpC1lc=
X-Gm-Gg: ASbGncuYFtb5jWDHRPKz3No5QPkJBSBhezyJfTNw2m+Yt0QR84PQlquSVxPq7aFiwpg
	U4A9jroyxyvlg94ImpW+c0YYral7fQ25zsvuESkMBWvYBYw9DTcGoaiu23THrIDDThHIoNsIUOQ
	yi2kBgvKKeJvL38BeRNUEecz7CglW7RKQhRekkZF+aSBJ6REOhaRyWRDkZfvRhffCOTb8bClkPd
	Ry1Ika7TTCuQdcMaJ1ofjRMA0tRnGx/dnOUUbQ4ej3uoCOCRzofEIKJqLQNszlfVnxXTkSUAOV+
	4wIzHUVwIy9Bo+mYSTXlA9U89l9M394mEVPYHIev0ZjJiPHmC3zO5OogaXBXM8bsLmE2sxThKdu
	4CCApDk+X/wYiCbhZ3iFPt75/bBvyh7rDf6kOZJIlPIoNk82IjQCyEu08kiN/wYg5m7hSAiFkR2
	sjUdoVH/Ph24objF03aA==
X-Google-Smtp-Source: AGHT+IHHUafu+OUkKK50Le8mjsvU0/uci6SliRNf6HLCwNtTf8n2cBp38PJX5FeIrDkrXNgKHP3y7g==
X-Received: by 2002:a05:600c:3146:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-477c01b2211mr15198445e9.18.1763715155168;
        Fri, 21 Nov 2025 00:52:35 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm9388669f8f.42.2025.11.21.00.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 00:52:34 -0800 (PST)
Message-ID: <a837deb0-b353-4647-81ec-5f50aea5a0e3@linaro.org>
Date: Fri, 21 Nov 2025 10:52:33 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dmaengine 2/2] dmaengine: at_hdmac: add COMPILE_TEST
 support
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:MICROCHIP AT91 DMA DRIVERS"
 <linux-arm-kernel@lists.infradead.org>
References: <20251106022405.85604-1-rosenp@gmail.com>
 <20251106022405.85604-3-rosenp@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106022405.85604-3-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 04:24, Rosen Penev wrote:
> Allows the buildbot to detect potential issues with the code on various
> platforms.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 8cb36305be6d..243d3959ba79 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -102,7 +102,7 @@ config ARM_DMA350
>  
>  config AT_HDMAC
>  	tristate "Atmel AHB DMA support"
> -	depends on ARCH_AT91
> +	depends on ARCH_AT91 || COMPILE_TEST
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help


