Return-Path: <dmaengine+bounces-5075-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14527AAC1AF
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF14C7525
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914A270563;
	Tue,  6 May 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBhd1koQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807720C028;
	Tue,  6 May 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746528425; cv=none; b=W9VRtizZj2lLrK2EKjp4zKDsWzANzMU7A9q/vU56P3FofGRxOfLmcHxue5Q22W2eJO//s3tRE5qq4gExhOcua95JWQGmLOvbMmFYWIKwItkxoQHxPp+/RwrDbrB+FMTj6xb+rDDHh8opL+r+gSuf163COIqfGGgyyN2YW57qDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746528425; c=relaxed/simple;
	bh=8PGhNQKYFC2qNfZV19fOkjs3PI4c1fT7ZPN0B1oTOEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeXf/KFVRwNcQqXqFVYoe8ZZ3HdFK0tG0Y/2WF4O2T8qRW3DCQrbBtDKwbt+AXDEwh1Y8SUEKul3JBNr0ySpyLucrza4AlsYJzMLRMQ+eT6PnrkbABJJrCwoR6IB8E5ot4KanEfKkfYs5DS3l0TdQfxgEm7OwR18oxmYA+Gkp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBhd1koQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4427038b3a.3;
        Tue, 06 May 2025 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746528423; x=1747133223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r82pBohwAXYhfoKoarrYE2A3rf8/DggNGYQF/+aSFDs=;
        b=CBhd1koQf9SM56nmd25q9DlA/Ocv5tdccl37Z3ucLQrdR2ZDL48Wjby06Xffyolqv5
         bdbxKtytrE/LBCOv1/Bt6hIUJezVwjwSl/OC19RDvbxqn5YW8NQuPx7RPmfZTPn80YAZ
         XbC+tuqCTRR4aI7MFF9/pzDNVtyezq6zJgni+T3vpMWxgMWEfMYXNTSQvAQj+MsnFKoF
         na5lnzHx8U4gtLxPVwWgCQ1SkwWTrSSwSOQ+JNnPuYW1ITv4BsBI6ZNTFLyRtEoIxsAC
         N7SPiS0FaVhNHf7Dcu6m2MgxWmbhYt2F1i6lzlK+3FTwgbL0sE6gknITqDUABsiPEw2Q
         4mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746528423; x=1747133223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r82pBohwAXYhfoKoarrYE2A3rf8/DggNGYQF/+aSFDs=;
        b=b3jPnJb5mIdPswRGtMlhcEq/eFhbFlc0TUpdZtZeHTL28U9uBHAGX83ZfCxbndGoxZ
         j19Cky3hsPEsczBl9WoIGBc+iTNru0psz4FlTESWB/1SfoFX/XUOZ3is8+0eWkHhrb0I
         FwQN0kgZml0jepLIjjnJuJgAwQGGkLYEV0OwtiY0VifAZKwcGFYhU5uOqM7hl3eUe+Vm
         yiU5ZFcfmb7GzQV7fmHdrr41cS6isR53JYdz/jMOa7K8IzQ8+P32cO4ulyuHqLrHHgnT
         s4YsgmmrB9hzuZiXjAlh6aB1lTcU7YetagMAkHSlsZx5JlKXnwWc6+m2Bv/+3Q1LYboZ
         FvBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXh6HH5/l5WkXj+tNW0iza6X2kVr39EwA+OQmVjyMJ3WXzlLQr0hiII3dUG1jxAzd/EQvPfqFtvvm2jQD7@vger.kernel.org, AJvYcCXFlbdWmUXNnwYMxmv7HI4HhXc+qi9pV3+XeXrt1902CEm5x1EoUU3go18+UqcLEWPPucofLMUmHstxsJQ=@vger.kernel.org, AJvYcCXbdjICmDDwu8Vg05Xd4Huy3qL10Xi6CbZXmKDnzEHlF6EGpeav3WITnHvtdupd+ONn+Ne1YP80Vh9I@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhaI7DvdW2RRMVzhowQsBKWmvGqxzNVJxl+7iqpuhcowu1g0Z
	9eDT4Al+DuBqniTeHUPz5PrM8wQO2pPzJjHIIiktRFDoqTl7Wfe3qRlZHMAM
X-Gm-Gg: ASbGncv8I/+9NfWOVS3bvajzXm0re/M7X/c7ValuBQHkIGVzbj0ue3Rkc3K14BkLlRF
	aFEINhDotKnh7PJE0sQfVH1NotAWYvOmSK9Rcb3l6K6wBSay9qnI+j6dxnFTvPR8YB9eRVP448Q
	bcAABuBW1nw6YruvKGz1I1rY2ub58AGSLoLBqvceQiH9X295eXnIZbM1zHKqnf512Ae0m54w7Bq
	3nS8y4ybYp94cmWcbch+imbhOxx3SuPEBff+4HTL5ySJfAqsSZ9/c2w/PwIzeJRzeISEEdBzBeP
	z4OwQef0PIyw42miQWVgWVTVLPheEsqJeBCYkEuq06ubgUnkz05v39lE19uyFn0pxA==
X-Google-Smtp-Source: AGHT+IGwosyOSouUHDmC/4DK4n/DHmlWW2JC90/8fUswpFoIyC8OqqmPRi9sUtZm89HdmrCa2wMRZQ==
X-Received: by 2002:a05:6a00:e12:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-74091b00f3bmr3681042b3a.20.1746528423342;
        Tue, 06 May 2025 03:47:03 -0700 (PDT)
Received: from [192.168.1.5] ([122.174.61.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020da0sm8816253b3a.108.2025.05.06.03.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:47:03 -0700 (PDT)
Message-ID: <f942ba1c-903c-47d6-a90c-5f5ab3605fac@gmail.com>
Date: Tue, 6 May 2025 16:16:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arch: arm: dts: nvidia: tegra20,30: Rename the
 apbdma nodename to match with common dma-controller binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
 <20250506-nvidea-dma-v2-1-2427159c4c4b@gmail.com>
 <a9ed7728-6600-4efe-afed-f058357eabe4@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <a9ed7728-6600-4efe-afed-f058357eabe4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06-05-2025 12:57, Krzysztof Kozlowski wrote:
> On 06/05/2025 09:07, Charan Pedumuru wrote:
>> Rename the apbdma nodename from "dma@" to "dma-controller@" to align with
>> linux common dma-controller binding.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> if there is going to be resend, then subject: drop arch

Sure.

> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.


