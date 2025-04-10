Return-Path: <dmaengine+bounces-4870-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4225A84D99
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 21:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A43C1BA2319
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A81C3BEB;
	Thu, 10 Apr 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5TH92xM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3D1C6BE;
	Thu, 10 Apr 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314975; cv=none; b=qqKmTYNTdqmkc1wLIMmHUi1Y7IfYIbweGgGmdJaDD9TJL6Jjsq0oOZE5lsIRhD50mLu37E+dVm5XBzR1DPrjZxHtBT+H8XAyjF1zgnCSJSPcGDy4bLeR9b4P0xlJxiSfhaZ3lv4BLZPRZsywd1vQhyjcJqcPEQ1qux2CM52mcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314975; c=relaxed/simple;
	bh=HJQr9UuqSuRZ9O9zo5/jEnTbBL8BdUhLrVD/QjKx/FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vvoouc4T1N1VTMS5G2djDxqYnd3Uirt5H9dW+5Z+X57MOxk15AYyy8txHZ3oynqVdjkGSdLXQQp6o2rJ08Vlak9GM4yzPiDf5hAyI43FV94YG3F7Xo9EAgFoJfNqRcCuA+09Q/k0KEcCZctCMoJfGcA38ZXhLpTUMVrOjjPT9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5TH92xM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so956973a12.2;
        Thu, 10 Apr 2025 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744314973; x=1744919773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2Yh3I3V1+UvtXQ+ld+riWN2eM4Q9oLOF3UAzWPac4c=;
        b=c5TH92xMZ0hpOAzva98e4QehkR/oq5gRLU859I399KIpt00rfFyEZ4R52gsTx0Hjdv
         MfrauGW57omEaIVv6g0hPbkaqspflPtAy7wojQVywUATWt72Hs9b780CJWnE+Go35Bbf
         7sHQ4fmbmcw2MzKi94iYXRlCMkdICw87MkW51FP5WQ07n6OY8ZGv7byisICs2j+DC22l
         3gdpDl/DEB5uA8FLC2XWdl5fHuAFO+j2bphBKYHTlwZ51Kaz8d6q7epgxt+FpCJHVLsU
         GTowNH48naNZS10+z4EnxnLnC0zZiPzAvN3UdzY0BODpuoiGCenX82pKLKwp6lntRQFn
         Mknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744314973; x=1744919773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2Yh3I3V1+UvtXQ+ld+riWN2eM4Q9oLOF3UAzWPac4c=;
        b=ZxvVdgPTMPHkYmU8HY+gUjamfqN3spk7vUiA3fF/pqEP+wALGoFYA5R4oBLYAV5K/i
         WtQIvEm5bQHL4NPwilBQWif4PFMoEkTy8CgJvlDaxrHGkXUuZjucIQL+bIL9zvBNdZik
         dO1dsdMesSgcZB41vYUGUyP+SpbNvGW7UetNLYXkcCD5ykfRG8CLLEH1JZmBPAIGOo44
         sBkuG8GB+RQioQNeGPA4IWunOO/SbCiZl9vhQb+tC6Icyt+mQ3fpDfn0zVo/J5X4fGVR
         e8cY/Kni3mPbR4WpDXPM7i72H6/Zt+w1HwBpYpH4nDaILEMJwE+uA3qlsNR7naobDvqt
         FqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbaXQWrdfzOWi4/sw3TzZuH+l7L8IVokNd58JjYpWdZUr7bvTGHPzEHne/2MBOdUuH3bQI4iv38PneSCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1s4UrbT9DKnLIci9uMmNsW6LxsGYlpHVhhMh0+K/BNrZxGfSf
	6gBBp0klC0BpjZvtLOLhttP7clLqPefc23bW74O8WFn8vLVlvnROuENPe8hf
X-Gm-Gg: ASbGnct8EoAjhxu+6UPGf0/oB/Lu8H6BZLFOaQGKzUgvvhaQwBynz2d84AWB7RupH9B
	6psaBP+sP39LHtSFg25fi0Avsu1ba8SDbKvxmXO7v7Ym6PnjXyNFD5aynR7vxQuQQG/wJQyp69b
	8PZPDEKODDvHaawHdLxhdbChWITyf6QTzObuqLKjxU3FcMt8v6yvguzN9WHppeTxpUTtIQ5o00o
	2xrBb6EipGTxg54bVcT6IIyeu0YYzl5vzRJ4pID+7yVciXV7vkoFG1ltq1nzJJ0cZ2SzmbuJZTt
	UpaGz2iBD5X8n7K84+lstczv2JDITWBPTrbyegHBdjDe51XxYz/LmkS5YQUPl4VjwNqXtZ63EAK
	j1KoGeK3ZIvIC8EiAcA==
X-Google-Smtp-Source: AGHT+IFoXS5kHb+znh/pUejWO4gvE81V4ILcXAP/7wl4BBqcT7H2XMG/9wnvnVkga8j6eOUawxZ+Gw==
X-Received: by 2002:a17:90b:270d:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-30823642c9amr412739a91.17.1744314973204;
        Thu, 10 Apr 2025 12:56:13 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:70f5:9c3d:61d0:62b9? ([2409:4080:204:a537:70f5:9c3d:61d0:62b9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df069e8bsm3992963a91.10.2025.04.10.12.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 12:56:12 -0700 (PDT)
Message-ID: <d39d0480-0bf6-4e8a-8bf1-b18011bc32ac@gmail.com>
Date: Fri, 11 Apr 2025 01:26:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, dave.jiang@intel.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
 <875xjb6c07.fsf@intel.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <875xjb6c07.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/25 01:10, Vinicius Costa Gomes wrote:
> Purva Yeshi <purvayeshi550@gmail.com> writes:
> 
>> Fix Smatch-detected issue:
>> drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
>> uninitialized symbol 'sva'.
>>
>> 'sva' pointer may be used uninitialized in error handling paths.
>> Specifically, if PASID support is enabled and iommu_sva_bind_device()
>> returns an error, the code jumps to the cleanup label and attempts to
>> call iommu_sva_unbind_device(sva) without ensuring that sva was
>> successfully assigned. This triggers a Smatch warning about an
>> uninitialized symbol.
>>
>> Initialize sva to NULL at declaration and add a check using
>> IS_ERR_OR_NULL() before unbinding the device. This ensures the
>> function does not use an invalid or uninitialized pointer during
>> cleanup.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/dma/idxd/cdev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index ff94ee892339..7bd031a60894 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -222,7 +222,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>>   	struct idxd_wq *wq;
>>   	struct device *dev, *fdev;
>>   	int rc = 0;
>> -	struct iommu_sva *sva;
>> +	struct iommu_sva *sva = NULL;
>>   	unsigned int pasid;
>>   	struct idxd_cdev *idxd_cdev;
>>   
>> @@ -317,7 +317,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>>   	if (device_user_pasid_enabled(idxd))
>>   		idxd_xa_pasid_remove(ctx);
>>   failed_get_pasid:
>> -	if (device_user_pasid_enabled(idxd))
>> +	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
> 
> Optional: I would change this to only checking for the validity of
> 'sva', the other condition would be true if 'sva' is valid.
> 
> But for consistency with the condition above, I am not opposed to the
> way this patch is written:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
> Cheers,

Hi Vinicius,

Thank you for the review and the Acked-by tag.
I appreciate your feedback on the conditional check.

Best regards,
Purva

