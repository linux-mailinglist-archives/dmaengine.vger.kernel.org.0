Return-Path: <dmaengine+bounces-7466-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21EC9B69B
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 13:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF651347B97
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592A285CAA;
	Tue,  2 Dec 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhBJergK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44851C84D0
	for <dmaengine@vger.kernel.org>; Tue,  2 Dec 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676920; cv=none; b=lbjrMZxER4AXpYBnDmPsekUSMTJyXaaW7gncCBSfHOwmKiOpurNJv6PyW/dd9eyr+XephLeESUjR6I1os/scVurnBQzef8U2YjehnuLqN018YZizo0cHbiSVLlYV4mGGjOHtbSXTZbkVtFTzSzbauM0Sm4x/0T/RMCuIHwADiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676920; c=relaxed/simple;
	bh=7K9mUWAwEL2WcGDkUZv5F7uNiXkKQLBXx4jkyHnbFTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mkqxq5kPecIPys0jfgKMrNtZaiNZdEptvvQ85aAH9mR53YKK4oYpPdeOqgg7pOi7vNSjBSJr8TZL2rARck5xu/uHFHaQhnzIzcaiKf85t2VWKHLR1BldHS9QqxBU8c8fy+YkYLJw0bnbT1wmR418RkWzpLKjijrgPeqJH2+3tqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhBJergK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47789cd2083so31550895e9.2
        for <dmaengine@vger.kernel.org>; Tue, 02 Dec 2025 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764676917; x=1765281717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6id7bBwtKWfp+iW0Yj4nXKFNWSuqfCTlCcCWbRL2xcE=;
        b=LhBJergKvcTFGD5CGfe3XYjLOhMeS8m4Xikbvo85m+apzO7e0yeGlqXFhVLgP2R8HN
         ebt0dhH240lIhOojdfHzpvrDNVHMsM5hubvdPFikxlYPpz5wl2uvWq+4oZMkEpWC+ccx
         8M+ZguSkgSOE1qPFhd17W1o6Ciag5gInJKL2HhcZJ3cLrWAN5TU44PS8hj+TD+Ut4BTY
         uB6jqkLUIXJHmmKAo86qioVBY2u5PXk/i8dmy+E9mFhS/rbegPM5wJUIoocheDMVRh8s
         8+2DCwnQ/225GktFmAc1jRlOkJFWekJH+l++PKetd1DkEj9prhw2CiM8JCNITvUT5lMj
         NC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676917; x=1765281717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6id7bBwtKWfp+iW0Yj4nXKFNWSuqfCTlCcCWbRL2xcE=;
        b=Y7lXiD3YeJfBlwIFi0iyIiOYdnG6knQHp95a75Lwsn0XNsv2x1RzndEMMjvg1CxtDP
         Cgii32Ybw9eDZY5LxIjevJZpxiB07GTMIwZBZi0kHsglKHFpNelSnsVH+weCtBSJlLf0
         WtvXacj+Pq3KznITnDAItx6Ic093SoAekp67v6kYrCgeP+2zRRh7PJufMtqVPJT1Ivo1
         IKN94xaFacnl3wga+VxSpF6wR209fyfAvc99jGmYVed4TlQUHEZCyGJJvuf3x287tn+r
         OEM0zg1K7FELluSZMnQW6h2BWTmrHC/ud/P1Hh7rj0rgYI6gz+aI55xQFFhxyUeS7gSI
         zamw==
X-Forwarded-Encrypted: i=1; AJvYcCVfS2QOvfVQQaEtnd+/49ebwRDZ3hxqEqf70X5TBrJQ2mzmz7ZqgZJiJ/HzzGoCucn0BSXJa9P38+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPDThWtChBxrvLHj5lY6UELenA4jEjHbPT/fskxDS1F4NI1ha
	i76BFR3hftr7082niNbe0Rlk1tlLBUrurU7TvQcgwVjsxzIOeWyZk+LNpZ+l+xaTTfQ=
X-Gm-Gg: ASbGncvy3M/7z3Y/hziYjnEdLUIs4VDzJjhBe4HDhbE/WgU0Cu31nttZaV7xOeh8S+C
	AcXXBBGm+vLzDqanjXXHPYGOlAZ4BHIuRatcaAXBzqUgmVCCaDBowaSJyIGT4y1g4qy37IyvIfd
	w+4jJk9KYtatLMt9qOfoUlMBNjljb5s7Eoz5TSHRvseTljHGlLwdfBPdtiVXoqGtLKf45jgXEiu
	d2QK6Q9SJa7K+6TFi++G0Sy4RzDJJF9BUI/jrVDxx9/qepuZpur31UP21XsXEK7ETJIHYXc9vwo
	xKyh7mhuzWWum1jqe7nMHewpw2BfQewesLyvdgDdfM6VOSzkAeicvUMUTLffJJc+XMltoGthUfz
	PktEikgsb7UFBMcldXKZ49eRr+c5xdDnfyjhxeGC2qHuAmsbVtyZ8Vd36xpmYSqWDiT5rsCAA0Q
	vclx1yP6dAxP7ug2UlxnXaXWDtY0o=
X-Google-Smtp-Source: AGHT+IEh/NLlOuvtojaeo8HI9XO7bfRFqhGXmwfYsgYpNIBUYckNTYbpdBcFb7hIJh2Hs0BfENzYzw==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr578484785e9.24.1764676916831;
        Tue, 02 Dec 2025 04:01:56 -0800 (PST)
Received: from [192.168.1.221] ([5.31.29.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791165b1fesm294627815e9.15.2025.12.02.04.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:01:55 -0800 (PST)
Message-ID: <cf5e2672-0aa4-43e9-a2d0-73010b81024a@linaro.org>
Date: Tue, 2 Dec 2025 14:01:52 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] shdmac: Remove misleading TODO comment in dmae_set_chcr
To: Amin <amin.gattout@gmail.com>
Cc: vkoul@kernel.org, thomasandreatta2000@gmail.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251128152947.304976-2-amin.gattout@gmail.com>
 <c1983852-b6ae-484b-989b-56fe0d00a679@linaro.org>
 <CAHfa7xVxG48_qBXE8JcSNJgO1SG=Ge9qAyaCk2WLTvrKoH3NbQ@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAHfa7xVxG48_qBXE8JcSNJgO1SG=Ge9qAyaCk2WLTvrKoH3NbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/2/25 13:54, Amin wrote:
> Thanks Eugen,
> 
> I could not reproduce any concrete issue, and after re-reading the
> flow I think your assessment is correct:
> If the channel is busy, CHCR is indeed never written, so in that sense
> the TODO comment was accurate.
> 
> Given this, removing the busy check seems more consistent than
> removing the comment...
> My patch was therefore not addressing the real problem, sorry for the noise.
> 
> If you agree, I can prepare a follow-up patch that removes
> the`dmae_is_busy()` check, or leave things as they are if that is
> preferred.

I am not sure whether any of the solutions is right. The commit that
introduced the comment is pretty old (2011) so it would be difficult to
understand the reasoning.

Maybe someone else who is more involved in working with this driver
could give more insight.

Eugen

> 
> Amin
> 
> 
> Le mar. 2 déc. 2025 à 11:12, Eugen Hristev <eugen.hristev@linaro.org> a écrit :
>>
>>
>>
>> On 11/28/25 17:29, Amin GATTOUT wrote:
>>> The comment suggested that the dmae_is_busy() check in dmae_set_chcr()
>>> is superfluous and could be removed. However, this check serves as an
>>> important safety net to prevent configuration of a DMA channel while
>>
>> I find this a bit odd overall, because apparently nobody checks the
>> result of dmae_set_chcr() .
>> So if it is such an important safety check, why is the result never
>> checked ?
>> As it looks, the caller doesn't care and continue as usual. The
>> difference would be that chcr is never actually written if the channel
>> is busy. Which looks strange. And "unexpected hardware behavior in edge
>> cases" is quite vague. Do you have a scenario when an issue would happen ?
>> dmae_set_chcr() gets called on resume() and setup_xfer(). Is it possible
>> that in fact dmae_set_chcr() is not called correctly then ? Maybe this
>> chcr should be written at a different time when we are sure the dma is
>> not busy ?
>> Or why is it even possible to have the dma busy when calling it ?
>>
>> Eugen
>>
>>> it is active. Keeping it helps ensure transfer integrity and avoids
>>> unexpected hardware behavior in edge cases.
>>>
>>> Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
>>> ---
>>>  drivers/dma/sh/shdmac.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
>>> index 603e15102e45..d0e0437ad916 100644
>>> --- a/drivers/dma/sh/shdmac.c
>>> +++ b/drivers/dma/sh/shdmac.c
>>> @@ -243,7 +243,6 @@ static void dmae_init(struct sh_dmae_chan *sh_chan)
>>>
>>>  static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
>>>  {
>>> -     /* If DMA is active, cannot set CHCR. TODO: remove this superfluous check */
>>>       if (dmae_is_busy(sh_chan))
>>>               return -EBUSY;
>>>
>>


