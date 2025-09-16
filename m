Return-Path: <dmaengine+bounces-6539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54292B59B0C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E9188614C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051232ED28;
	Tue, 16 Sep 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="obZ4N0j+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AD31B110
	for <dmaengine@vger.kernel.org>; Tue, 16 Sep 2025 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034520; cv=none; b=DLu9XP0Q+BwAW9MlkLa54FtSx6XCW+201xgVkhpKuZxyyKw90yyGayoorIRmqyBG3UHCHuJb3FrRzEUZvwoJYZYsM2R6yPVsrhKg0x/WF99HTM9F/FmdeybTBwgW43euRitNI4untmlRz4cbqgVUtKrbHkjGnSo69UHS+rhBa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034520; c=relaxed/simple;
	bh=tm0kA5/U/7lPdDiVcC4zEEqOIVnKxf9PeM+eT4gS4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/3viGc3TSIv77H48Hk0JCPbLeerozqblccfPmwRWkB+C3v5NQ0GUI+QFg7XUYgbYFthh76rfjCJDTS2MPnpb6v0EcC1vTOlQKgXlE0nR1XCQ3weuIt5cx0lRhJZtNSiTNMkUWbJeyOr5aEdioNrH/NM8SXvffcK4jzN8X9Stxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=obZ4N0j+; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-33158d9dfc6so2382635fac.3
        for <dmaengine@vger.kernel.org>; Tue, 16 Sep 2025 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758034515; x=1758639315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5iIq7+KHCywK04RSDS9es8l3U4mIawqQHyrRZJkTg8=;
        b=obZ4N0j+eWHDyjwoNB8DM51ouON16EJd6CsPNyA1WIjfhnr1hkFuHxYKr7caIYqFzc
         w5MQvEudlutDfIHU0rk1jWT++LF7ynasoY4mJmEfy9k+zL0O2DkKCGgTHetyU92BzJK+
         zAqcPMC8pP8PQhzpEWq7koMrjpECa+KRpDtPrGXhInFDdBgDR8jQ1VdNEADeroeMRXb1
         0e2aL2sanjC4hHaTLGvXWUHJl8KHv77n30R9XXGVgNzGqciGBPPHpyfI0VZR0dhUu+aB
         uN77UjvJPFd+ZTWNN9P1ue23IB7ldgGpdciSlR3H1Eu06fsc/Ep1wahJKTC75yrhfO9r
         YdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034515; x=1758639315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5iIq7+KHCywK04RSDS9es8l3U4mIawqQHyrRZJkTg8=;
        b=tkFkxBPGXvsmf0DgRwJgl7e1xRe+ZCOukN1o9+nyUrF+s7DPxzFJu6zGeEqfAe2cfh
         v32m287hM2QHn08W9g0vpG9VRVYcb6RhEs9fZsY+4Pn2h68NHKSUCgmTAZgWV8f5UzxK
         he2UenZkrwc/rlfAXB/JwlGrBp/yfM4vzreL3G+p/dv6ufWvWybmXpZq48190ayqvghp
         jTu2d883hTqfzg1lKE+frTHsfDM/V9EGaiFhV1O47wI1orsnsURnqie9GrpZJlVYp8GX
         lt2lPIk/lkMswnnX6t3gnUh0j2/TD/MWRZpG1/axr+UPNUWix5PtpptHrnwhebyXyySR
         ZrLA==
X-Forwarded-Encrypted: i=1; AJvYcCW9/nigERlNxljwgoUQxh2I+lT3CK+v6ichkYbeC/4/pBaGYAWv3xj/JcQp0aQEfLmtxXvjSDNM80s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzd8EioVHcb5QAzhCyh/tqMOiD96pOJNQX9gBeH2Gh+oiF/tPZ
	3v2yn2Hdlf8Kxe64FY78m0wpx3FTWOyOGtnuuENVyN8ugxkhoqYVOMpv0Dle2UsSv4g=
X-Gm-Gg: ASbGnctCC4Aus431RMI+o0HIoR+0GzIsEN3WTLYICkE5o1RQHSB/GUp4sS9PpnQUfpy
	uSg/S0cZ3BAEHbd0kxLG600aatIsZuVTwTcGipHBSzC+HcDL1AnCOvQkBYJg4wYVznEAN4ANoZH
	EO8YV3nCP1WexVA9mDIJPlsGxX5s1ob0ENXnwqVXoRySFWmpsziuvzHXmAVh+E3GKwsrbScUu+B
	dShxHLdTI+DOK5fUHTcVnYqqnw+/LVqWJjnU/n0OTyea2kE65LaH7Dc9zGLZObSObE5opcw06QF
	g5ohgbvcpYrLhY1hyVtq5GciDUR6GOK2G6TJsYSTcCqybScrRgonkdtLoGFEIpCvnaMtQ/s095o
	brptPq/OzuG2XIJio2C+84O/5puXTzHkciURWb7/FUyHJtYTMdQnjNd+Yi2XuBexQdyWR8AQt9Y
	Q=
X-Google-Smtp-Source: AGHT+IG2j6o5ZiECUky0T/Yvf86ZO9qsIYrDXwjsYiIUbY9fkQXrpUngcoYlXLsDg0lSeAlhfx8Log==
X-Received: by 2002:a05:6870:de12:b0:31d:6e43:8d3a with SMTP id 586e51a60fabf-32e54e80af9mr7157585fac.18.1758034515240;
        Tue, 16 Sep 2025 07:55:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-33204689b2fsm2368205fac.6.2025.09.16.07.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:55:14 -0700 (PDT)
Message-ID: <711b5e34-3534-440c-8914-ddb41987ee8d@baylibre.com>
Date: Tue, 16 Sep 2025 09:55:13 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1_via_B4_Relay?=
 <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
 <175133153648.4372.1727886846407026331@lazor>
 <202509161304166bf210e2@mail.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <202509161304166bf210e2@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 8:04 AM, Alexandre Belloni wrote:
> Hi Stephen,
> 
> On 30/06/2025 17:58:56-0700, Stephen Boyd wrote:
>> Quoting Nuno Sá via B4 Relay (2025-05-19 08:41:08)
>>> From: Nuno Sá <nuno.sa@analog.com>
>>>
>>> The adi-axi-common.h header has some common defines used in various ADI
>>> IPs. However they are not specific for any fpga manager so it's
>>> questionable for the header to live under include/linux/fpga. Hence
>>> let's just move one directory up and update all users.
>>>
>>> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Acked-by: Xu Yilun <yilun.xu@intel.com>
>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>
>> Applied to clk-next
> 
> Do you mind providing an immutable branch for this as my i3c tree is
> introducing a new driver using this header and so it is going to depend
> on your branch.
> 
> Thanks!
> 

This was merged into mainline in v6.17-rc1, so I don't think we should
need an immutable branch at this point.

If you are modifying the include/linux/adi-axi-common.h file in the I3C
tree, FYI there are some changes in the SPI tree that just got applied [1].
But if you just need the header in the new location, it should already
be there since v6.17-rc1.


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=67a529b7d3c50a56c162476509361f4fe11350dd


