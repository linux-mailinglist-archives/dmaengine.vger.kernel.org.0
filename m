Return-Path: <dmaengine+bounces-5074-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94527AAC1AB
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72DA1BC8686
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972D23D28F;
	Tue,  6 May 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXsYLiGd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC4145348;
	Tue,  6 May 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746528373; cv=none; b=lpaOJk9l37J8juS/uGfhv5/G9YcpzozYqd2T9/DgXAUPvvSxDh9m/7w7CZz2vwsk6tKW8rAQsGYsGAe8ugxhNDKADbJ1XDhLoNu/skx7TWvjx3m9fIknQ6LZ7uBUeV762dS2MviLuz2sdKXTX4o2s7rn7JyTdgKCgOnfqMZLDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746528373; c=relaxed/simple;
	bh=93Y8Saet5swanjHpMJ/EvjJKe8b8M/Usop2eTKFKiVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuN6dqy78AVwmnC4LSHX5UgIYkaSmSHcLcEh4dSdaRQcQefiZsWHBGOeXQpP/c+8EHe0PR4ZeVGfhry2+CJisAQzPmV0cHS7XD1G9jZzfsVk4ANkbS91z7iwfS+bvjnWABo52CgLxvoSwFKbbrf1Pub8OTra4pLpz6V83URwe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXsYLiGd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c3407a87aso80819065ad.3;
        Tue, 06 May 2025 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746528369; x=1747133169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDxvPu0q0ye4Kx0FRPYzt58DlPLsXKD2FRRnq7YD7OA=;
        b=RXsYLiGdUVObSHRQEkftJqBwLReakULk5C3AHPA2s6zVGs63SHCVRmUPHBDmRuq8yh
         Ln73aFJMkbtqFcM+iOQOCvGS3KusFHJWpdbQEeJP8DixUUZTWS0GJCur3joqYdmRe8Eq
         YhMrIOqc21UBuk4qrqkK2cwlssaNiFPsfQLBXEpS77/Lx6Tg4+IJz9a4lpuZscwbC2oI
         qseX9+Az015ZIsCHOUWealhHPwrRlJvTibt0CrvlGspf7XsHE9P39rEHImrQuySP97Ac
         H7cDt9ORt49YgDlzCtRUwrkZpcJOEOWnYUwt3T5AAv1EyPSoR0peb2+Xvwqt6K+FDR3+
         75wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746528369; x=1747133169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDxvPu0q0ye4Kx0FRPYzt58DlPLsXKD2FRRnq7YD7OA=;
        b=LfH+9tFxAruaHgusXb6ky7iEo/tEU6vVPdNwCTCSi56wqqoMDnYMlPvtieGPblVwmv
         PEkhky+QI/kh2SZyBIkUK7Vw/9VCiEIu+99FywuDqETjyix/1IAlVyisL/+NNFaZGZHW
         S+QVDAVzLqeqCqvVk/diNqBUzgs8hlr4pFhzfzUYhOQPUMypK2qFoJDzUYhsTAPUEoYs
         aPYMr8Hg+tVu7gSxFABrqWeqra2TukkQOkQ6Um20TqpLUzxYBfl/4H5AKBgJLJBxrKlG
         iA7Hkm49GY4SwYcZwaE0g8ihPbCXMhAu524kf4t+Y0P9SviPcp5IAOzHu5F4ticui22t
         MKhg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ina4tshXF/ftqOsgnWh2wansMFN6VkhpgkJy/15JEtNZ+LFQqgtQYDilIx/kLiq1ltfuSDrmBRYG@vger.kernel.org, AJvYcCWuOizNY0bWhL8LdNEJqtOp+N3qOThlaKnClQH0Q+wWtTrx5Ua5fTVlsK8joeI9ZQc9MDtMALcujYG+fBhT@vger.kernel.org, AJvYcCXGKJnRKu3AhnYzNAMo8qhSlDer4KptX+wQ06GtIrp1uCGRZFYZIFUw1SvDVOVnMzAp8Dl94/W2E23cGMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFkRxSrbgRKGRDFD1hWecBEGaSZvsAiJmTlvrAOYx0R0KYB2y
	QxZ5Z9M/ozCbKW90NhoIyZX1xmkximcrr6tkM15wZoD+F71tInaC
X-Gm-Gg: ASbGncsXaSKr/lI8WynXr9nEDfKEVTjfjibiiy1Q1rl70s0Ycb4XaMOzTwFZ/FxexV1
	7mZpexQ+zpArzGqQ1c1si6YstN/2KCjQoVXDzaVuko1pS3ItSvOtJBndLw3tje1zzGM+AFBwlg1
	DVvE9KpK+gmrtKV7gehwFLK1Q0kAWccQYDYy2S6Ax0pg8Ssqw4XiQHcnBR07qJdXZrQNuAeLsZr
	PpkoTYdC+3FwPIPjzezybyTz6yzmXU8SYLzMZRzljoXHX9N8OJ4XNQTi0QS975qqXdXxjUX6F0j
	YY3jNfxUrUMc9yOpg7qsX7aXQfpX9R+UoDaNEk8BYu9rvudApfUemAbm4biF/Mlxfg==
X-Google-Smtp-Source: AGHT+IFyNLYbtacoU/dUxTCOlVGuZ/PEDuNxNnKTPJ9gfrdUAXvpdOQYnRRHx5wt+jrMYhveUPcKBA==
X-Received: by 2002:a17:903:22cc:b0:22d:b2c9:7fd7 with SMTP id d9443c01a7336-22e1ea56fa1mr165054365ad.21.1746528368961;
        Tue, 06 May 2025 03:46:08 -0700 (PDT)
Received: from [192.168.1.5] ([122.174.61.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dc768dsm8535457b3a.72.2025.05.06.03.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:46:08 -0700 (PDT)
Message-ID: <a9729fd4-1fed-459a-b242-eabc71503954@gmail.com>
Date: Tue, 6 May 2025 16:16:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: nvidia,tegra20-apbdma: convert
 text based binding to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506-nvidea-dma-v2-0-2427159c4c4b@gmail.com>
 <20250506-nvidea-dma-v2-2-2427159c4c4b@gmail.com>
 <28afd932-1d63-4bc7-8ed2-33bf838a858d@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <28afd932-1d63-4bc7-8ed2-33bf838a858d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06-05-2025 13:00, Krzysztof Kozlowski wrote:
> On 06/05/2025 09:07, Charan Pedumuru wrote:
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
> 
> Why is this a irq.h now?
> 
>> +    #include <dt-bindings/reset/tegra186-reset.h>
>> +    dma-controller@6000a000 {
>> +        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
>> +        reg = <0x6000a000 0x1200>;
>> +        interrupts = <0 136 0x04>,
>> +                     <0 137 0x04>,
>> +                     <0 138 0x04>,
>> +                     <0 139 0x04>,
>> +                     <0 140 0x04>,
>> +                     <0 141 0x04>,
>> +                     <0 142 0x04>,
>> +                     <0 143 0x04>,
>> +                     <0 144 0x04>,
>> +                     <0 145 0x04>,
>> +                     <0 146 0x04>,
>> +                     <0 147 0x04>,
>> +                     <0 148 0x04>,
>> +                     <0 149 0x04>,
>> +                     <0 150 0x04>,
>> +                     <0 151 0x04>;
> 
> 
> Again, quoting:
> 
> You included this...
> ... so use it.
> 
> Otherwise what would be the point of including the header?


Yes, I understood it now, will remove the header.


> 
>> +        clocks = <&tegra_car 34>;
>> +        resets = <&tegra_car 34>;
>> +        reset-names = "dma";
>> +        #dma-cells = <1>;
>> +    };
>> +...
>>
> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.


