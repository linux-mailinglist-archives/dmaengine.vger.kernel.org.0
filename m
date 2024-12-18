Return-Path: <dmaengine+bounces-4016-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05739F5C28
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 02:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B43167089
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87ED17C91;
	Wed, 18 Dec 2024 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="eLp2ARzs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CE3597B
	for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484620; cv=none; b=NMTLVlP2Wtf1VKXfFNYAesN/vYrU+n5Ure5qpST5Ju29uFjffCXnki9HQwCHUcLu30i8kUdxsgd2CjQep9bItqvdDRg/sJ06J6mbm9bt+88jX2EUjdqWYvocVeMvmkMoKl0ZgDI8ETteRi1/HG1MZ/w6L2aKOyUSqtnQ+bZl6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484620; c=relaxed/simple;
	bh=mOS9k3enzGAADh/vjN7NhoZ4lyfy7xhQa5V4lYgEXcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozCyJwh23Qhl7lDZPlpwpcj8oNyIKULITvqrZT/B7qL9QGHk/iMqlsNeRuRZ95jTcBGtF4qznJHzFI7h/N2kwEDaCjts68aACVAKdCHRoxnbqRX/Y5nld2q1N3EGgg3vGCRvAU7ZjVzlh3WQi47MYnWmAkmy8YTZkekQYWtXLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=eLp2ARzs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728eedfca37so6084090b3a.2
        for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 17:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734484618; x=1735089418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eX7VLFdOomqicgjMQQpIaDw8Aia9pB5zyLESZil857Q=;
        b=eLp2ARzs0OTo6hTaFXE7Rc3zdeTGftaHu+7e7fqDpztjeDAr2FHzxa5bEMsbR5O8y/
         9FfEts+udu6LxD1sYcnTxNAaxr5NUrLJzbT3OpiliR/7Ia+w6ksaw/zdxxQEAY2UVKtj
         v20wXQDONF2hu30wCqOPd6QAikYjqXtjoL5XZv739W+Dy+tMYn/fVhfrhV8kDvuFgNkv
         rjCwWM29N0nWkbSQS53slcqV9ipu+c/2KmqjTwfR53/9472cVI/IAjUMbDgjQamJOP3G
         J60acxEpkVN+c6mYiVuH1Ee2bw/rrUfwElNwnTCtEPO+kvd0hZL2Gq6+YV2yAij110BK
         s3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734484618; x=1735089418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7VLFdOomqicgjMQQpIaDw8Aia9pB5zyLESZil857Q=;
        b=HXqF08M+UjPGD018Bx8jigK68okD9wYTeUT6L4q1px7VwRtH+IOB4dQ3iolWYZSN4z
         aqjhYnOEDCPuPtEp5F8/53Oe6sgYXIxau41x+d3X4OoM8JS0i/JR/+ssxQKLhCUVdTwr
         /FpUknKjfXVM5nNxx/sd2fMmkKs3j8cbPbwBsCkkZI1h+J8kMz/US+1wDsQgXPgCk9kb
         SL3l9ydLJtylYBcaoCaMFpZVczAjJY1WTqbpDoWacfesE+U3ReNJQEXk3Iz3QxZyzPxX
         WRAWidvweBaakkJzzO6mabaj3wg7chVwRV8dYgFTMldwldfEapkNFc166AglL2f82GEA
         03AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMkPyyb9M4rJBLsJIQ9y6DsBhLCBJOnawzcgT4F9AWyoYvFJGn0O8eKnDCflMkeQSLJX4U584uAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYw/lrPrBf42Gkg/DmpmRkj7ahniqIN4mY87uxaQCL7SfHvWTf
	R11fslpH2Su23FBj7Q0Y+NYR7FL9nbP3y+0KHfUMyzeXc7dg2IrgsoRz4M8IcD4=
X-Gm-Gg: ASbGncvuCpxlr6Muz3jjakVewBJqwGANMVj8FAoiHVp4l8dFSFOWFXwerhpYdYh+2rA
	PXtI3PhybkyveK/nD2lAExXIDH2M8PHKiCchAQESyeYbu2OVi0lCfAATYBmLIq425K06VOgKIkW
	vpnqG1n0o3SIzw85U4oWG7UsmI6UeqGHfqMvBl+i4yXpcKay3SdP83NLopuudPhK29BgQ2KqvqZ
	NiPeeCPvh7Ia6lYiMl8K8pi2Nq9wp6aMQbMQJoh7nTjhT0J2JSv2RGti0J3ivpDyY25Bk4ZLuuK
	Ir0X2RzLuZkj7rYnQ2jmCLFcnZ+CyWB32w==
X-Google-Smtp-Source: AGHT+IE8+kMctC95yKfWjuTi50qIN7Us4dLfZRXFYNZbTb3dp4cZMpLTjNqph5i7GaSHEhlva0DoKA==
X-Received: by 2002:a05:6a20:e68b:b0:1e1:af9e:2779 with SMTP id adf61e73a8af0-1e5b481b36emr2057560637.22.1734484618016;
        Tue, 17 Dec 2024 17:16:58 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0fe68sm6376607a12.62.2024.12.17.17.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:16:57 -0800 (PST)
Message-ID: <ac68dd2a-9489-4974-9837-915c79ac12ca@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 10:16:55 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: edma: fix OF node reference leaks in
 edma_driver
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org
References: <20241216102609.760571-1-joe@pf.is.s.u-tokyo.ac.jp>
 <5e126db0-00b8-4989-ac5a-b79561f2c6e8@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <5e126db0-00b8-4989-ac5a-b79561f2c6e8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/24 23:21, Dan Carpenter wrote:
> On Mon, Dec 16, 2024 at 07:26:09PM +0900, Joe Hattori wrote:
>> The .probe() of edma_driver calls of_parse_phandle_with_fixed_args() but
>> does not release the obtained OF nodes. Thus implement
>> edma_cleanup_tc_list(), which releases those OF nodes, and call it in
>> the error path of .probe() and in .remove().
>>
>> This bug was found by an experimental static analysis tool that I am
>> developing.
>>
>> Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   drivers/dma/ti/edma.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
>> index 343e986e66e7..e6eee6cfa94a 100644
>> --- a/drivers/dma/ti/edma.c
>> +++ b/drivers/dma/ti/edma.c
>> @@ -2279,6 +2279,18 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
>>   
>>   static bool edma_filter_fn(struct dma_chan *chan, void *param);
>>   
>> +static void edma_cleanup_tc_list(struct edma_cc *ecc)
>> +{
>> +	int i;
>> +
>> +	if (!ecc->tc_list)
>> +		return;
>> +	for (i = 0; i < ecc->num_tc; i++) {
>> +		if (ecc->tc_list[i].node)
>> +			of_node_put(ecc->tc_list[i].node);
> 
> No need for this NULL check.
> 
> In a way, it would be cleanest to just get rid of the .node struct
> member.  We never use it.  We could just save the .id and call
> of_node_put() right away in probe.  That's really how it's normally
> done.

Thank you for your review. Yes, makes sense. Fixed in the v2 patch, so 
please take a look at it.

> 
> regards,
> dan carpenter
> 

Best,
Joe

