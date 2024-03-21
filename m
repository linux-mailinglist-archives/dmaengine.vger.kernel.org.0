Return-Path: <dmaengine+bounces-1466-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5390885892
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E768B1C20A05
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6495914D;
	Thu, 21 Mar 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuDJSjIn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280156B9C;
	Thu, 21 Mar 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021765; cv=none; b=IhKDlLaKYOFctUA8CCaBkG5tBACrFizhLfOqFXq/z1tql5Mh2FWODm1tPp4Iyz5JzDlZrin1VzFx4psxSE2hQFzWPtkRMaQ8RC+VRYHbITBAtkdF0XRNrhVN/zLLt0v59DVnbFbixlagtUJR0epRXPNhR2Oha4PbsHxrC2K0wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021765; c=relaxed/simple;
	bh=HcfpeOvJqco8I2k5lgqVxuAfX4+uF9kqChgarxiASdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWGkXLFomEi5aZIczehHcsSbwzWDlONHJy2UQlb3CKfOnVT1hZQnbRQjHJD9b80q512QpYJNd6PBhCcYjCF+9xTrnCrHFiAKvkoIy/7xfS6YEurH0r2EWfgP0Wy4THAlxwArxowV/f4hz1CqQKmMtUTQp/+sy/MNLeLPsgjBe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuDJSjIn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a465ddc2c09so49516666b.2;
        Thu, 21 Mar 2024 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711021762; x=1711626562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YUHpheO9nRaUReKbxqlCuhbZr+EZarmSUPdERAI3mmE=;
        b=OuDJSjInxbwExLcdpxBe9POl0BhJiFbYZxnbr1cy3Nja4IZheCvDmS7AJIFvS7l79a
         DCL1B/CRITnShvmTSUFWIoqnTNiNe6Hdy5rcXjAn8SW0CLFunAkAXE/MGhuqa9FAK924
         Kk14l7sPx/CpjJTuQ5X9N3tqaWWy+e8FMVTlPho+0ApKSZtE9cmD9RqASywXZV4Z4eu8
         30oN7VcvHPtW60kPKbBfXdBYjgg6vY7iNnHO88PnjbDYyD926gytPs8g+JaLj7yyLtck
         kFH7yLqOYVaMySl2D+j6WMRy2B7zSnsIOim1Y6ZtKcuZ6bfW857WgPDFg+b5q/ObOGjH
         uqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711021762; x=1711626562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUHpheO9nRaUReKbxqlCuhbZr+EZarmSUPdERAI3mmE=;
        b=NXCa3GblKVSOCuqPvDUVAe7tLm1r52veoRhjjXYkuIyfVtCwWErxRaYKSsm5atGCfP
         ARMsD5XFuwsZI9L8kaKmUUGQurnIIuBEukidZl7p4kmF5kAt/0cD0Ytnka0aY4Zt7dqM
         /Fr/DXXNpubZS+F2witk3GqBhYmtFXrsCrz5z28pY5njSqyEYdcsnEiSf/fuOcG8VJcV
         2z5XipCapMTY+wGKqydTjb6phukg1gMXLX7SMWY/i2lIEtXekQABV9GSm6KS8k/iZCiP
         07EUS/lgyglnGzqO2VgOr3V5Fqx47OAeXjLTXYGIdkeryv4Yzn0kJGrpJg/j6VXUV/Q0
         7AlA==
X-Forwarded-Encrypted: i=1; AJvYcCV9RSmsrL4YAyNbvAbMpQ7J5DwYeIRNXFTgpzNueNrQFtiHJES64Tha+xe0bOD0eTy7SkdHcA1p8qtqa4OFS+v7+UsMZfU4AXlSWLvnOIf5oUfGl8ey5eCHXmHtyYwJRhoJO4qaCHW4
X-Gm-Message-State: AOJu0Yy/svbesKf6uN99Ee+LuKUYiIa8W5M+4jCffa/FfOTCjXOdgYEk
	OcdQEahaKdys2VkBzdskwYv8DVOcsY3BCNXJFTas+4qxEzF9f6As
X-Google-Smtp-Source: AGHT+IEutykJ0cvDh5lsKfacRvXDwihNJK9vqKSdtI2cpCyvoGtJxdiEMwnNJBDLR1dc5rcpXybj7g==
X-Received: by 2002:a05:6402:5202:b0:56b:d1e8:60f2 with SMTP id s2-20020a056402520200b0056bd1e860f2mr399015edd.5.1711021761606;
        Thu, 21 Mar 2024 04:49:21 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b76:3a00:94ba:c61a:20e:b0e5? (dynamic-2a01-0c22-7b76-3a00-94ba-c61a-020e-b0e5.c22.pool.telefonica.de. [2a01:c22:7b76:3a00:94ba:c61a:20e:b0e5])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05640205d200b00568b6d731e1sm6659769edx.4.2024.03.21.04.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 04:49:21 -0700 (PDT)
Message-ID: <5bf33366-c376-4b9e-a280-071b98fbdad5@gmail.com>
Date: Thu, 21 Mar 2024 12:49:20 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] idma64: Don't try to serve interrupts when device
 is powered off
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
References: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.03.2024 17:32, Andy Shevchenko wrote:
> diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
> index 78a938969d7d..1b60e73d9322 100644
> --- a/drivers/dma/idma64.c
> +++ b/drivers/dma/idma64.c
> @@ -173,6 +173,10 @@ static irqreturn_t idma64_irq(int irq, void *dev)
>  
>  	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
>  
> +	/* Since IRQ may be shared, check if DMA controller is powered on */
> +	if (status == GENMASK(31, 0))
> +		return IRQ_NONE;
> +
>  	/* Check if we have any interrupt from the DMA controller */
>  	if (!status)
>  		return IRQ_NONE;
> -- 2.43.0.rc1.1.gbec44491f096

Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

