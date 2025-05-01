Return-Path: <dmaengine+bounces-5044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F69AA5D3B
	for <lists+dmaengine@lfdr.de>; Thu,  1 May 2025 12:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6149C435C
	for <lists+dmaengine@lfdr.de>; Thu,  1 May 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F41216E1B;
	Thu,  1 May 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXrksFjF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200421D3DD;
	Thu,  1 May 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095409; cv=none; b=lrZB4C/n1z7Pp4GhoxnrG2Cs9GIqHAoqtxiGyxzhAWjrTm3ZFNwFUh42syT/yfPV56/VjWA9LmDlqeyv4KVWJ4uqgoJQhfDouYS0eII6LmFnyr6jEV8pN6Q9Omb0YCUlq72zXfL3PQus1zB5oZj69BDZPHBMufHAuf1nSP9xKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095409; c=relaxed/simple;
	bh=rPLhVIXUKVkEtFspB+nrh99HZbnrSQo5uwoHj6X6gOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN62mV3/nztvBJCXZcW/pWvHLEJ2BPZVBaNbU3octcpwqHffz6g5hCkJjd0FHO86C5CUxGaa/h7PhFtSjTwT1hEA6ByetHqHSoDTJJGkcnT6vNvI7wp/6dlUNFtqgZA5XvEMqUWSrogHQdEAjvGPK7qZ9BTKNc+noADqe8iR3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXrksFjF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so948458e87.1;
        Thu, 01 May 2025 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746095406; x=1746700206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4JpNFKBrhRnQXThSam216PXFcAPD5WEcbTWzAFVX7U=;
        b=KXrksFjFqcUFirm+ZnqLzK0X2v+B3brRCmQ5pT7CwcwnNHRArOusr5y8oaa0oB2VyZ
         IP4G8sLYBaAyrIUVSdYc59G5VLUsY8vbf/VCdMgxgIlxLeCabUM2b1Ruzt76TPEPLl2l
         4es6EKlSHCBMolrnbjZxuO7ypK1+TzGGM2XkDk3/EMng61+8vxJ4QX6itUu7w+gxlsHu
         73rQO5I19V4p8ZXuxKujS7HajwHapnu2hZ9Mq0buPtWu0MFTdIN81iG7UJ1tAC1fLYS5
         gWu+wJCrjqOVkzFCRaDqKlO0wsrfvUM0E+2zuDvMjUY032x/hXztw8M/NbRdleh/Ffbc
         c0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746095406; x=1746700206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4JpNFKBrhRnQXThSam216PXFcAPD5WEcbTWzAFVX7U=;
        b=nZ1V019DbSBjtBUYb2Jzw3faSr33Otyh6+ekqWJnwKFfULfOcz/6f88gViIWSrPrhf
         iBbyniwypdQMOIqpEinug+z/n02exb7d4GS+ZwsfuCPtyDw8kRwtgHjXStnwM4oTwQ4a
         LF2597x7AQGU11SsLn+8Pr+WAkDoUpxo3NY+1yGeZIOnNKy1Ww44XULjkHCqty3QcpeL
         IY0DAJtPKJQ+wKzsz+JtD/pHWMGeVv/uNa/gSjVGzL2cxuj+5iyvsMiZCLiStAXOHVZU
         G0K5rIRDdAIACar0Rfmvw3vg/D6ZFw1kyFjzb9GMSkS25QVTmpqFnB+yI+RQu7WkiPVb
         IJdg==
X-Forwarded-Encrypted: i=1; AJvYcCVP4Xz5Y6+gTVl1miwnL5MFjBdUuNUF3V/XjB0pgzcGTQoPLIY+3suzWHygoAJG80DjxTTAoQOmPcgpgdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRGMwppKwIQXfJ2KORJ2jP1uGUW5X27Bh2BNZH/dDE3ny3D9n
	dpYmqiaO0maCuZ3OFSjtno3tPJfmpMnBhTpvEa8ixdUV6RPr2g3RZeTibU4y
X-Gm-Gg: ASbGncvlkW5NIyPljnApCUZjemiIHES0z0eXAK40Pmm/v0MrCMvXVNxA4SJnj+W01qy
	LJFU3gzhnncnQPE0chgE9V5k7TmTgfOxT4hZIsB9lfIsZBUcjYt8gsgiRhonMcE0svPPxyNnDzy
	FLt0yoF5rwEwx8awkzTOshMKlyRLybAEW7piDeihwkguswzRi+gBFardGI6iwd/m8CE1lhftzTa
	WamFcZpmADqsDoCoTHIiiRkfws25wXKVqx4QIoQdEpO17iK42+Ff3hgUaA4T2Y2tCNAkTfDgOkt
	JYiGFWk5Sk1B2vpl8M3r+ch4dDx9ONCpSJWiAmgLKk61GZNURno5xWZeQY9RnRERAGzVazD6Je4
	z478GDy6Xh24=
X-Google-Smtp-Source: AGHT+IFklHfXe5tL5zxv0TVQJ8TGz7/A6J2l1t4Zbg92lJo9KEOzbetZGOqClTPH/L1RnmR+PgiBrw==
X-Received: by 2002:a05:6512:114b:b0:54e:8dd6:c775 with SMTP id 2adb3069b0e04-54ea7a2b78emr554223e87.16.1746095405612;
        Thu, 01 May 2025 03:30:05 -0700 (PDT)
Received: from [10.0.0.42] (host-185-69-73-15.kaisa-laajakaista.fi. [185.69.73.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f6d3csm57512e87.251.2025.05.01.03.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 03:30:05 -0700 (PDT)
Message-ID: <3452e5b6-a2f0-43a1-9f9b-a9c4ac083571@gmail.com>
Date: Thu, 1 May 2025 13:37:48 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: ti: Add NULL check in udma_probe()
To: henry martin <bsdhenrymartin@gmail.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 nathan.lynch@amd.com
References: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
 <CAEnQdOrR19H84EooKsFTMCPypeEZwR3GD7FA-sj=toxQP-Xoyg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <CAEnQdOrR19H84EooKsFTMCPypeEZwR3GD7FA-sj=toxQP-Xoyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/24/25 6:10 AM, henry martin wrote:
> Hi Peter, Vinod,
> 
> I hope this email finds you well. I wanted to follow up on my previous patch
> submission to check if there are any additional feedback or changes you'd like
> me to address. If so, I’d be happy to incorporate them and send a v2.

For some reason I don't have the original patch in my mailbox, but looks
good, thank you.

> Please let me know your thoughts. Thanks for your time and review!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Best regards,
> Henry
> 
> Henry Martin <bsdhenrymartin@gmail.com> 于2025年4月2日周三 10:39写道：
>>
>> devm_kasprintf() returns NULL when memory allocation fails. Currently,
>> udma_probe() does not check for this case, which results in a NULL
>> pointer dereference.
>>
>> Add NULL check after devm_kasprintf() to prevent this issue.
>>
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 7ed1956b4642..f1c2f8170730 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -5582,7 +5582,8 @@ static int udma_probe(struct platform_device *pdev)
>>                 uc->config.dir = DMA_MEM_TO_MEM;
>>                 uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
>>                                           dev_name(dev), i);
>> -
>> +               if (!uc->name)
>> +                       return -ENOMEM;
>>                 vchan_init(&uc->vc, &ud->ddev);
>>                 /* Use custom vchan completion handling */
>>                 tasklet_setup(&uc->vc.task, udma_vchan_complete);
>> --
>> 2.34.1
>>

-- 
Péter


