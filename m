Return-Path: <dmaengine+bounces-5319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4568ACFFEA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27A01759CF
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405F2868A9;
	Fri,  6 Jun 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/iDplID"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575882857EC
	for <dmaengine@vger.kernel.org>; Fri,  6 Jun 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204024; cv=none; b=RQmApePZLzTw5+uH4juZLT64NhXc3SFb2/T977ahZw2Jx7r0lnsEk49CpKEvHDsaHmY61+S38QEDgsWw2M96vy8J5DSBz2ZHtcrHvaI6oNry42pVNlPnnQFdwz5b9XhOqQeDrG7+LJaxxBraW0JD60EKPZX0XLUNH+1sRoQb8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204024; c=relaxed/simple;
	bh=3a+WQLGp4elFYZvrRecz8JZgfyQKKlirEzi3m1GN03Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taiQwoH5fvbUhJb0teC2TCHyc4mlVkK9zpxBQq8S2CF89Kn9o1ZRtpkR6zN8cPWwXDO9W996R4UPYssEXFJsxf8Onv3jwIzlVQ8ReWXdpR+4mMOZn9aTLg2KI8VxRTRFg7hobjTamG3GQDcBBwjmKPMjVT/5OJGEbb9wFdJRC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/iDplID; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-452f9735424so1196605e9.3
        for <dmaengine@vger.kernel.org>; Fri, 06 Jun 2025 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749204020; x=1749808820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Wm5Ysxp6GbjttnpPxWFZX/i14ZJHHqOtrosH3lsbGA=;
        b=o/iDplIDx5jpp9nUY2jflHw+xk5xcd4ILsUh9OwOBhQIfOtjZsVTBUBYuJNnaNfcg2
         06Asjz7Ndy39AphhmVt1np1DmZWrr2jXcgHeE7WTJgYuTl1bqdZAGqp4frdiG+DAP9YF
         aKhckTHYjKjt6h+kX2xeHNIP6grjHdSj+APQMCikU7wOWHAoEWE7bWVHcD7KR+fm9Ox8
         bSxsTXZrETAtNQGEE6gq+6YX4cmxNKMRwtG+NNsMMD9NVtclnswI+tnv2UnboQaZIplJ
         iE3ag+NBvbrzR5vOOp0pVUJ0+ES6BigyPtNAM8dU3SrNhM28KzjyViIdT1IGYOipxVe+
         5Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749204020; x=1749808820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wm5Ysxp6GbjttnpPxWFZX/i14ZJHHqOtrosH3lsbGA=;
        b=D8DXjZE+08f9jLjCwB11E8A52e1x7//rCw307hVTq1+K7fj8+UdBjdlCR2+Js+aDkL
         VG7l9ojRmnyOU0izBPLl5uyyP1+EbaqA0MyKVtthQTgtTlZ4zSF44vbq6XlIw5Zxk3kj
         HDRnfIC5Uv2HZBr3UsTjW0BHS21IUBge0YTZBkEK6QwE2rJZJXxtZHViCInaOBKWvgF7
         hTUyTKfp8rDrVij7ay8s9wWgfi2LirYrHuwxfXi80Rn4oGf2gtAyzMitKSCiqX7zxs82
         JL2/K7kT0fkERbqdbvVRZYtzzgzVSkcVVifliKE6x0nfhjFkFUyspzcfCAMeT8SbNsQb
         52mA==
X-Forwarded-Encrypted: i=1; AJvYcCVGjRLef6hP/6vQ56UMmbHbly8/uI4QOO6svt4eYomoEt6Fn6NFgzePw2kWeVu5dOS8nRvIW7OEwMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0yqLBiz9pJQ1W/fHTX5/C8zvMrbYs0WPZw6Jv7BwmGOEPoDj
	LxCfv6oEI2HzuN110tcgfoPatwjCXWKsFBBj3DOVE2lu22ItI3DS0QWprdxpZBGBFXU=
X-Gm-Gg: ASbGncsYGZZCN8tW5avOy+3QS2D1WutkOaGOXXyKWYJSx3KmL4Shsbf09FW3+j4BsfE
	NZaZM4fSj1Y65R8RxDx/N+Em4mYXn45wsDk0iScx0u/toa3C9UQuFte+eRJiboC4zvoQpS+IWIq
	NGL3i26MEIi811azmNXyJG9BovL2jV32FhVo7jFQsCmAR0/KnLjak4BHW3QnuoIpqNTBpzXIOGj
	lR40GF9Q16JWPIbOS4p/AxZg6CJqEHA068V1anMsSMaHcAU5hqW0NTWrftpBhLTfAZ5BzpgbRNv
	GZvX8EHT6pAqpNeEY0dzfYslyyujiNqcsqwhBphpELrEo3ib68KU7YdTUxat5tclOpzZcw==
X-Google-Smtp-Source: AGHT+IHtw37a7aLpgY1NgIlSmAhbyHbRMRvllHSnmnalrMLkUdNldLsfg2cqEgFo08aK/ax73zNvkw==
X-Received: by 2002:a05:6000:25c5:b0:3a4:df80:7284 with SMTP id ffacd0b85a97d-3a53188a553mr2530102f8f.1.1749204020520;
        Fri, 06 Jun 2025 03:00:20 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324621a4sm1347436f8f.88.2025.06.06.03.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 03:00:18 -0700 (PDT)
Message-ID: <ca3ce8df-aa4f-4422-8455-29db2440d8d5@linaro.org>
Date: Fri, 6 Jun 2025 13:00:14 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: mediatek: Fix a flag reuse error in
 mtk_cqdma_tx_status()
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250606071709.4738-1-chenqiuji666@gmail.com>
 <ff77f70e-344d-4b8a-a27f-c8287d49339c@linaro.org>
 <CANgpojXWk1zvu32bMuGgkVGVNvPw+0NWmSUC62Sbc3WcUXAd3A@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CANgpojXWk1zvu32bMuGgkVGVNvPw+0NWmSUC62Sbc3WcUXAd3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 12:14, Qiu-ji Chen wrote:
>> On 6/6/25 10:17, Qiu-ji Chen wrote:
>>> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
>> If the first spin_lock_irqsave already saved the irq flags and disabled
>> them, would it be meaningful to actually use a simple spin_lock for the
>> second lock ? Or rather spin_lock_nested since there is a second nested
>> lock taken ?
>>
>> Eugen
>>
> 
> Hello Eugen,
> 
> Thanks for helpful suggestion. The modification has been submitted in
> patch v2 as discussed.
> 
> Best regards,
> Qiu-ji Chen

You are welcome, but in fact I suggested two alternatives. Any reason
you picked this one instead of the other ?

