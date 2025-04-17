Return-Path: <dmaengine+bounces-4906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDEA912BF
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 07:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502831901250
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFF1C84C1;
	Thu, 17 Apr 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye7w7YYE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC52DFA2F;
	Thu, 17 Apr 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868362; cv=none; b=M9dr53hx4vis/2DWuQrk2qjsJUmy4Eldrj7UXrYOEGfT2i+DErYyUsVHhFyy93OeMWMiVTE8K9gpT2D8aT1wXppr1GCjeGLPrUAFo1Gz8PelCf+w+uwphIvBvYE42pb/U7rOYQpENGg85XpXua/jC8R1ZHprH9BIXUm/plT8sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868362; c=relaxed/simple;
	bh=Rzd2yE0g4gqaFtFYIhYtHCRfy1E0nHomvZgN21JrlzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsU7ztnB6P/YF6CCtCpWCww/g2TmdXH+dMjAlZLhuH7vm309nSIK0Qfm/+MFZY685AG5ueNaAiZhx3xaG3l954tywX2611L6LGN9Yd1QZpSEB6sh2Nb87QnZrLffBHa6eRpKHSE36I/INWUMnDGfeFjmDRncz+OlErTfYwSw+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye7w7YYE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225df540edcso16549965ad.0;
        Wed, 16 Apr 2025 22:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744868358; x=1745473158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24x0GQ0PkA6+zr9zBlahx+1SY3PmBt3xsKYJkkmlKZ0=;
        b=Ye7w7YYEyPxR1TaB91AkeVoisCd2bel5Wrw8GvTSH3PJUn/yXeIkLNhRL0HMZFLbGw
         uGmn+w6woPJk6E+NAID0HYGgc6JEtDh8Ae738w6RuLIKK1MS0sIepTO5qChDgV9OaBBG
         D8AwHDAlaFwvvN7A2yyv/F79GNTt0HY9PMVHCcNd+UETp+Nwx0AZYfPZn7tnWiDWeQp6
         vZtWO0zZBtci1wtXeZMqhKwjAB+IviJnuEq/2wFa2yMwBkjWRT+Vl2QESOIWFVZCy12K
         gH23xASSOF4HBRN8eQz+D+HKqo8q+EQw0M8/Fgi/xxoIvCxZ2d0t9F/cE2zflB4V25qL
         1F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868358; x=1745473158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24x0GQ0PkA6+zr9zBlahx+1SY3PmBt3xsKYJkkmlKZ0=;
        b=DzvXHEq4SIOBymT1flpwjJ053+bkzDJFiyfLPUexmrW2IsC1u7uTxCIrbtURWytld3
         3/nS6kFdBHKkiHWgzvbmM5lkFpqaAvc23x+vK0UDuczRO1rOwAqv51zjoxr3U/K2aUu5
         liGKqTwKwQpIV3G/n9+SebCvXCO+EbSd728ivepvQR/8x7dPTN7DfDIubkIqCzAFPGeD
         qrdxLhRvHLERfNHkNNhBgQ69nXt676TQCOKK/HPnlVwLWnywlEaDY3AoIRS1VWzQ2ZTI
         Oxm1a/eoxyeCsvsQ2vAQ9sP0ZXGW9o9InSRnBdpywnQscP2FPsCXXRSWGCsDCQro1d4u
         PqyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcn9zMTa7pDoYL4GnXGY0+2wZA3EznUWxSBkBA8ZmoCvolhflF4lIfZkeeobOQOpkfZJnhZQAE2Ik75qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69h1NEOcwCn7L00CamwtPstwyc5shTf62F452xBkoIAKXsFeY
	8hUiavqb7PyH6FbiiiItbwgcBi+w/3f6oCriz20VX1pmMZizyryTImO0f8H1
X-Gm-Gg: ASbGncs8qa7LpFzqoUYavz505W+Tp4Ez0SxQ/4ObVJmnPWotmrJrQMvHp+mLuvPGSIf
	pBMYGgfWvhlMrawHlPBiY4pVi57h1yEfCsSHg42UYuGHL7IigQK6zHA5OM3MaPm2u73BPZ7rJFX
	fJRi8/1pNl4j0+egJbZLQJGfZgM/4DhhTcigFq03pj6aY/hq3quhLbRR40kljd/XfXinKL2C3Qn
	lAgCWBgSHsr2Tn84cfW1HWUPlQtUWsnvpwyYwUHiHH7rMijhTBzbw985S0SM0imcoHHG9TPHOOn
	C6X8RSO766hbcqtqdySio1Zez4cMS72cfzmKXJD7/Zpd8V+nsQ==
X-Google-Smtp-Source: AGHT+IEYI2mZ5pqppiYJEHMxeSskqOZW/A6Fj6tplgWB4OIO//BTRKIAqK+VzAW9q8NYNjUr/OKCnQ==
X-Received: by 2002:a17:902:d587:b0:223:607c:1d99 with SMTP id d9443c01a7336-22c41b65eeemr27176765ad.0.1744868358225;
        Wed, 16 Apr 2025 22:39:18 -0700 (PDT)
Received: from [192.168.0.161] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d199sm24591105ad.90.2025.04.16.22.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 22:39:17 -0700 (PDT)
Message-ID: <f0f6604f-30aa-471a-9f21-40d423285499@gmail.com>
Date: Thu, 17 Apr 2025 11:09:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
To: Dave Jiang <dave.jiang@intel.com>, vinicius.gomes@intel.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
 <23417f4a-05fe-44d3-b257-7a5991d252cb@intel.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <23417f4a-05fe-44d3-b257-7a5991d252cb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/25 02:30, Dave Jiang wrote:
> 
> 
> On 4/10/25 4:02 AM, Purva Yeshi wrote:
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
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

Thank you for the review and the Reviewed-by tag.

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
>>   		iommu_sva_unbind_device(sva);
>>   failed:
>>   	mutex_unlock(&wq->wq_lock);
> 

Best regards,
Purva

