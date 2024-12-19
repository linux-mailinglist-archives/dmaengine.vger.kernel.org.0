Return-Path: <dmaengine+bounces-4028-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8B9F7279
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 03:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B77188549E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5141C7F;
	Thu, 19 Dec 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="BHakCfjE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13833594F
	for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574044; cv=none; b=QylcSzNLiG58JAp7VaVtRLbGBwYMzu12zmKG9MOVNRzeve90gJsV8zxoSBHrFDqcH2aitSLhYVohSf88ceUxZSvmPvzr3NqHJdkDrbRs+RgDrGiyyyV0ljJW9X/zt3KWzMz0WIw504kVgQuNh5dB3lihExa7jt2ePDpj9ZiaWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574044; c=relaxed/simple;
	bh=eZtVSAEpg3T4JNIOcFV/kMZfZgVrGycsbkQpZDuk584=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTDKHMT4Pod2OxydnWaaiLt7Q4fzekJkuZ8eZS2Z7Gdd4mmp8TnDKxAc89Sr/TAdyZUPgDGTAtrYufSIaWGTHAUZ6YJAQHAymlHx/omENpOEzPhEsqS6fPSl4TrPDGU3fxr8XNcHuSsUH6/PwaDw5SgxWPqdXHfCgOww2Wq7dIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=BHakCfjE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so3457675ad.1
        for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 18:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734574042; x=1735178842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNNhlIXwXvEvgZgifD5HFUy1GYTiZfnQdNN+Qr0NGek=;
        b=BHakCfjEl7E1mV3yrKFLmGSwsMRBwYltPnIHYU9acnRYlfyP9aTX6p78N88NW41+uJ
         B9XLfR4gJZ1V17fHtvrBhrwelU+4zKD9NGZarD5Wnw2R7Ta4IqXxrmRRDjQTh/bSSe3X
         TjEk7aDaqLBuFgVWo6R1uLQJRCKt4UP+miYR9tFzZjCSY14FtF9l5yiFWCBzFgD/ug4x
         Wf1LnXuLPm4BTBzKxgnXbSXucNtb17UHt1WnFzgz5qfjICaeyqw/2UjnUvNKOtM5c6Od
         0vN3qbSKiX3wSoSYyHKStziqm93Vwt1Kdq7AttkHcHrJ5yHEk06UYRkKcpke32GIgyyo
         dG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734574042; x=1735178842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNNhlIXwXvEvgZgifD5HFUy1GYTiZfnQdNN+Qr0NGek=;
        b=anILq3hkLxJebH16xUYt5CeuWOUbLLcZvR4v8IJRAYo9vIqyUjb7A7kgbztvn30Hx+
         LvSP+S7z/rL3nXnrugRUBQ/LVjBU6etZfU3R/44lfRpTHy7m4eXzEJhjAE7/85vrLMbp
         Owyrmwjb13YZ7Jsc7bxLloQ2uM1w9U+JDtsvBj2eFdToKEuctC62GQL9N3oP9ABatJzA
         McGUaIF2Tj5wCl17qUbS0RspRSOaMzJrfSczOzVTdJBEuAM3VmQjK7ixvHo5lHYZ8FH2
         AAF7bCN3FVM0m5vlDndR3k+Pd4dBLQnRBOfSWOkQDReZu+9S3Zt/FWec/9IC479j5BoG
         NOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF7Y9OFo8XKMdRHnZ/TvAJaJYMkX7P4YQlqRvxbL0ZfXIXIdyT47XBvqRyBlnB+EAdaQBC9BeuxT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OT4G/YlX+z15glZCkS6zV70I2WhvrkcPftG/MppQtMwMBPXN
	tWyJorP31yaS8o+1Lh1Z2VzURSdACwhobJMtM/J7EPuk3CDbaEgWh4FwPyP3QTU=
X-Gm-Gg: ASbGnctM3x9e3trKTzEHnn2Pb0DsMP8jmJDZ9GTAmbtnDSU5PfxTuTUsmu3d3J1keOC
	gBWT5dxoDNn/yRwfBAenIkxJBUSEfG+ZFid2kCa0VZ+fbivoOEB43URHcUFygEHxP9EyT9oYpE5
	J2t5y4L/JxuzXHCARpihmztUz8h034UB6Q2mXeH2z2eawSHokgCivMeQhuw7QPJ9E5gwNvIN8Rp
	W3vYPkpkfp1AnjZo7x9tMV0AW178segFvMrnID9mdo1vZ8KBq7ZY4zKrVP3tAUa6MT59RgmIvn6
	FDVeV5pJqdeyoRwf/RnfwOLJLESQ1gXDHg==
X-Google-Smtp-Source: AGHT+IHTLJfCqQcXsm/KtW5M+6n9wAoH+vwHEvOW1tzPwN8Hga/fwWdTfS8J9Hb857TUg80HGbr2Pg==
X-Received: by 2002:a17:903:2b08:b0:215:a412:4f12 with SMTP id d9443c01a7336-219d968d422mr29956205ad.33.1734574042061;
        Wed, 18 Dec 2024 18:07:22 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdea0sm1982945ad.155.2024.12.18.18.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 18:07:21 -0800 (PST)
Message-ID: <db51b52d-cd56-4021-aaf7-67bf5586ee7f@pf.is.s.u-tokyo.ac.jp>
Date: Thu, 19 Dec 2024 11:07:19 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: ti: edma: fix OF node reference leaks in
 edma_driver
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20241218011520.2579828-1-joe@pf.is.s.u-tokyo.ac.jp>
 <b9662dbc-1503-433c-ad85-35c2c765787a@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <b9662dbc-1503-433c-ad85-35c2c765787a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/18/24 18:09, Dan Carpenter wrote:
> On Wed, Dec 18, 2024 at 10:15:20AM +0900, Joe Hattori wrote:
>>   drivers/dma/ti/edma.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
>> index 343e986e66e7..4ece125b2ae7 100644
>> --- a/drivers/dma/ti/edma.c
>> +++ b/drivers/dma/ti/edma.c
>> @@ -208,7 +208,6 @@ struct edma_desc {
>>   struct edma_cc;
>>   
>>   struct edma_tc {
>> -	struct device_node		*node;
>>   	u16				id;
>>   };
>>   
>> @@ -2460,19 +2459,19 @@ static int edma_probe(struct platform_device *pdev)
>>   			goto err_reg1;
>>   		}
>>   
>> -		for (i = 0;; i++) {
>> +		for (i = 0; i < ecc->num_tc; i++) {
>>   			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
>>   							       1, i, &tc_args);
>> -			if (ret || i == ecc->num_tc)
> 
> I feel bad for not saying this earlier, but probably this
> "i < ecc->num_tc" change should be done as patch 1/2?  It's sort of
> related because if we didn't do this then we'd have to do this we'd
> have to re-write it to for the i == ecc->num_tc to add another
> of_node_put(tc_args.np).  But really it needs to be reviewed
> separately.  It's such a weird thing, that I have to think that it
> was done deliberately for some reason although I can't figure out why.

Totally. Separated the loop condition change as 1/2 and the rest as 2/2 
in the v3 patch.

> 
> The rest of the patch is nice.  So much simpler than v1.

Thanks :)

> 
> regards,
> dan carpenter
> 

Best,
Joe

