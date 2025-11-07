Return-Path: <dmaengine+bounces-7092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389EC3DF7B
	for <lists+dmaengine@lfdr.de>; Fri, 07 Nov 2025 01:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155983B1D9F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Nov 2025 00:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53722773CB;
	Fri,  7 Nov 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T17NiJgt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25E25D528
	for <dmaengine@vger.kernel.org>; Fri,  7 Nov 2025 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475089; cv=none; b=L+Pd5pBurVGD37EZU/QVV4cVzRP2+f9ZbZGnLQG90PrOfiRxV4XIfYs5A3f8239+9DkdRlu6NO7+Cm8XSlJ0Od+SIzJC+yAWeMQfrL6s7vHp9EqtkiSg1hPZcYwl2Amxm9KBd1ufsu+xgYVqQlGOkM5BeuS1pckS/Evb2jgZj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475089; c=relaxed/simple;
	bh=XLWrFmYgf6F7bc1tZSN8JYD8e8DrgBT0ubR8anh20os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YL5IimySMUOzXuTtgPdQ32SppTGKpk1RCKKl3vxw85kaU2FR9KG6sNP+2UctPUF91TBlSSgrMmbSq0RlSwPk2qP9TeWWIEEa5BYuQLo30PGp15id9OL1wyjBq7RQYiEHWV2dgfLw8w7j3s1G/kIWtM2bD8ongo2umTMzXD0trOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T17NiJgt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4335726d0f2so824505ab.1
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 16:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762475087; x=1763079887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3Pf8rkEr6SoORFVa8JIykJJgQV3sWej0HFDn8C7mOI=;
        b=T17NiJgtQaJWtsaUddS2jcfHHb+C/j7kecEYm3ceFgxFNSB5ydVtiYcp7bBxu+gCOw
         uINVLIDwRAazsuvxJGyJOj6GAylrH8nw6tUTFYdEF6rx3gK+M/9R79nP5Pma5IocqdHU
         88K4ruzbvHdmm5eu/LoCxnKZfoQ7ovZCQvyyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475087; x=1763079887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3Pf8rkEr6SoORFVa8JIykJJgQV3sWej0HFDn8C7mOI=;
        b=T/diou37AP4viUUiXEVxF9n8yfpArXSH9VfxhFzZhLfaJo56LhKMu4dBWRXk2LTSi3
         7Tp6tJekwPU98NI7Z82kBu/SUiYCo1g/djtmvC/g7YFJEzG3wsBFBvkYYg25fWFhQUzI
         wHXnn3G4XjuRmGp6iuQV42b5qo1df+1fmBt+8GWAtNNwl1qxFDs11PlmRG6DGcAhM7qS
         pNlTknNC8rS6V1oQqPl/vZZCLZN1biwfFpkgOyzcWCwTJEfBaedV+g35lPOjQrNzo9cL
         +ANE4ezUVWogTWFSuLpqJyoKqjrH973oIwVnztw49Vo7KQ5mI5gnwTxkBJsmmAJLurHb
         ggxw==
X-Gm-Message-State: AOJu0YzrtG5shz3PcvGoho199Di/lSJh6KIPwhssUMxi0khCuod5oWSy
	z97xWv3KICZfY2mdIhJ3oilA5bSKKY7DB8/UDiloj0IlIffo/o+kcSGLF6dTWjtgzJJegVzxo/f
	lIfSO
X-Gm-Gg: ASbGncsmjzHX4Et+RiRjhhFpRQe/rmDsDdvXq+gYehvzz/Gfclj5GmqckvCw3nPwALp
	XrRWr0WXKpsRQQyKTNand7RPq3myJe3dJX9mMsxBFoy0SJzSr/VBdDgeId2QRS9ngjrTI+i8SAI
	QMIO+3eetFp1yTD7yx0ZwoqOFHcnfKNycsLjqryGYHBgcQ5Mne/XQL7eodrxsoySQfSwWwIjk0x
	+KsWbNqaIJKssDeaYuClnCuC/u/4fBzTUrK6lS1kgqApFxn8IdpdshVpmqSo5rqTJx5XVwn69ax
	3W07EPSRocbGFarP3EQEZrr7h9dl5cTKAGQjdXtdZxAHzt+axxlASfJMSkUCEMO5smpvB1FfiCE
	7LXeTHaxhAk44yV2RM5eyeIOZMTnaODlhpYr4Amxq1X7Y/hUQacJ21Xrm0mp2hU3wsiiWsWZeNd
	YPQdKlDyI6qWatBeBAAeOEwr8=
X-Google-Smtp-Source: AGHT+IESdNVTthD8LhJvh07byEKJ/B5pSJJsTsGTK9uvLAxX+Fv/PmXAeTZAJeM3pQ4++Nl3hlozjQ==
X-Received: by 2002:a05:6e02:310b:b0:433:3102:b0f5 with SMTP id e9e14a558f8ab-4335f4a7b53mr19451525ab.30.1762475086940;
        Thu, 06 Nov 2025 16:24:46 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695ed6dsm1374158173.52.2025.11.06.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:24:46 -0800 (PST)
Message-ID: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
Date: Thu, 6 Nov 2025 17:24:45 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: fix invalid array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251106033056.1926-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251106033056.1926-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 20:30, Zhang Chujun wrote:
> The printf statement attempts to print the DMA direction string using
> the syntax 'dir[directions]', which is an invalid array access. The
> variable 'dir' is an integer, and 'directions' is a char pointer array.
> This incorrect syntax should be 'directions[dir]', using 'dir' as the
> index into the 'directions' array. Fix this by correcting the array
> access from 'dir[directions]' to 'directions[dir]'.
> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..b925756373ce 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
> -			threads, seconds, node, dir[directions], granule);
> +			threads, seconds, node, directions[dir], granule);
>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

Looks like you sent the same patch again. I replied to your previous
patch asking you how you found this problem. It looks like a needed
change. Compiler doesn't complain about it which is strange.

thanks,
-- Shuah

