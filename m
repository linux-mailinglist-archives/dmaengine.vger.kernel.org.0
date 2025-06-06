Return-Path: <dmaengine+bounces-5320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C701CAD034A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 15:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57881189638A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E5288531;
	Fri,  6 Jun 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5XxhiH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0622874F9;
	Fri,  6 Jun 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216947; cv=none; b=EqgSEP87M5Xb/18bUfcbmNfpU4bDG6TFSS3CXB0zky1CsJaFV2+2w4NRQAykZDFAiLF/S6LCROSLOoPvGTwMV3wV60YH4ujwney95RQFtQe2L2/xinuOR7YQRIB9BW/W/rs18dw2WEzWd80p/cciv7u8fyc+39qU0pwCZR2fqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216947; c=relaxed/simple;
	bh=0ml/MHinxxJm56VhkaRsfFKv/4fFXloCq1LTKaQ+fVo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RAx1wTinZ5tvR/bt9WhgJh6N32uVJVD4e/60KzAWmrM+b7IP0uk83WGci+lfUpG+x5+9/l15cV+YG3HcDjE0jKPKz/a2wA/xuRaG/t7dcYmLt5Ohxis9+DSDtErKsJ/eqzU1C9x5oTGHjpu1MCZkseYYjeDEqChUoTkIUrFNUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT5XxhiH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fc7506d4so2183256b3a.0;
        Fri, 06 Jun 2025 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749216945; x=1749821745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6k/v7MmiVZncaG0gAng2Qdjjf1NhngohmIKq82nZVQ=;
        b=GT5XxhiHCoSUsdV7qar9bw1g7K85HwCbcaDD/kTLmmbup8cvpONPW69i9ml0Bxkktc
         Ilu9u0OEkpvNT6PwA+8fRJif8c2HM+3+4yT37aidA816CdkO6R1PUJNsDsT2OE2QqaVo
         yZRx/Q70AvvtGTjVv+2xg3B+48L64He5k4rpP+u4Xtmgvpx9mpeS2t9149T2kf0e55Ab
         eSoh2qumwB40okN1X+zharKzakASXA4bjNM1CXkIfcrioVcFX4wgY8knmvQ9Rz6w6XsC
         WK5kjHsNMz4bxWhbqoNZ2AY0b79EVK3wbpGWnq1rzomppMxLGS7RsN5bmaGgg173GeNJ
         9zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749216945; x=1749821745;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6k/v7MmiVZncaG0gAng2Qdjjf1NhngohmIKq82nZVQ=;
        b=pZ2OSTE4TUs0CvubQTP/y/ayogEF7WnlXV4TqsHl3jVdAnNbcZjDY4tPz6pNcoIgY+
         k8xqtoD06yoURVgWYOODIym6u2RRzm0a80yYK2X/XxBOuAs+oPQN4NFYJCDjRCF7eLub
         OO3LqG4dpRK5zq2MuM1+AjtmE+0AgfR/57l4hxUIy2QflLOLunxGZnSBRvOtpP9rI6PS
         ExWWwv62ipLJHWgD7cTAbJV2cytIADhWu9N0sV0Njz2pDFiu3yxCxuRAmWzQlD06be9C
         Bbig1vu0ccjyE/zo3+8roJzND2w1ZA/VHyGk0or8Ucs8SvPhgSBDE5xWKUqfIkYFtakl
         j+hw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfIU36+gAXxL1VPGbuZxmThF+OkRvS4bkp7non+NdohBOrYvnbHcLMihP/s30lA0RwIr1sPTpgJJuxJFrkA==@vger.kernel.org, AJvYcCW4g2YriXPn35ETz5zIl5HQV6WWZdpSQqBiACIEx6NZhJnnc4r+NgkjHhirUEO7JCEUFSflv3UEkLMvYnqz@vger.kernel.org, AJvYcCWD6NdZqHQIVkmFpPZm77mAWNJd19/xfjzl3u3eNmtPUdDFmLNsgF4PCDFnfsDe9Qqiu8HZXxDZ95U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6zatOG9cxxA3xXeVOmHnDMHbHK4dS4QVV0S3Gws0MKovvqkc
	vQ5uVjsl3xdpzoVCFr72g3ECnw2SCi6DXxnoO8gDbQii/xBoqeoffq3s
X-Gm-Gg: ASbGnctI7PKCGMQ/G5PGYrD0WKyrQeCUmwZ+Z3AjecIdAqItAseLxAlrAGp5UN3c2Vk
	QLHA5ZPkTXdhaUqnzvRwZnz/6lsEmF4SYgweX6kC6kMCvHP3LjQTQ+PN68KmcJyc4AKxuQjO11L
	kqkt9uKrBmcvduVT8BqOBEJ39lLrDGlHWYBh+xue2Gn1OZixdBYkA3oRxxizhIP9bUKarKhnAwe
	vue+zenkrlGMhas5Kc5mgNPAJYAX+cLeZnB0dR1xhzwudmRF8hFPwyvWRAtd0K/Dp7YqGSk3xiP
	fLmJqp1rc6pVkqsvk/J9xpCEIfzMkBBUIcwREokrSgZit/OZB+gCPlQ=
X-Google-Smtp-Source: AGHT+IGVAVfaCO3WJmW8EZtwdSKaSpA2gT2x6UkvCUzMZbUmgdcLsdnbM0vABNk8ZcknIZtO7DrmhA==
X-Received: by 2002:a05:6a00:188e:b0:742:da7c:3f28 with SMTP id d2e1a72fcca58-74827f37c17mr4990489b3a.21.1749216945558;
        Fri, 06 Jun 2025 06:35:45 -0700 (PDT)
Received: from [10.0.2.172] ([70.37.26.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842d3sm1299017b3a.98.2025.06.06.06.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:35:45 -0700 (PDT)
Sender: Sinan Kaya <franksinankaya@gmail.com>
From: Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Message-ID: <7649f016-87f1-475d-8ff7-7608b14c5654@kernel.org>
Date: Fri, 6 Jun 2025 09:35:44 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: fix handoff FIFO memory leak
 on driver removal
To: Eugen Hristev <eugen.hristev@linaro.org>, Qasim Ijaz
 <qasdev00@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-3-qasdev00@gmail.com>
 <3c6513fe-83b3-4117-8df6-6f8c7eb07303@linaro.org>
Content-Language: en-US
In-Reply-To: <3c6513fe-83b3-4117-8df6-6f8c7eb07303@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/2025 9:04 AM, Eugen Hristev wrote:
>> diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
>> index fee448499777..0c2bae46746c 100644
>> --- a/drivers/dma/qcom/hidma_ll.c
>> +++ b/drivers/dma/qcom/hidma_ll.c
>> @@ -816,6 +816,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
>>   
>>   	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
>>   	tasklet_kill(&lldev->task);
>> +	kfifo_free(&lldev->handoff_fifo);
>>   	memset(lldev->trepool, 0, required_bytes);
>>   	lldev->trepool = NULL;
>>   	atomic_set(&lldev->pending_tre_count, 0);
> Is it possible that the handoff_fifo is freed, then we could observe
> reset complete interrupts before they are being cleared in
> hidma_ll_uninit later on, which would lead to the following call chain
>
>   hidma_ll_inthandler - hidma_ll_int_handler_internal -
> hidma_handle_tre_completion - hidma_post_completed -
> tasklet_schedule(&lldev->task); - hidma_ll_tre_complete - kfifo_out

According to the documentation, the way to guarantee this from not happening

is to call tasklet_disable() to ensure that tasklet completes execution. 
Only after that

data structures used by the tasklet can be freed.

I think proper order is:

1. tasklet_disable

2. tasklet_kill

3. kfifo_free




