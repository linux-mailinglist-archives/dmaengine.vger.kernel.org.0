Return-Path: <dmaengine+bounces-3479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD29AEBA1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2847B23CA5
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEB1EF085;
	Thu, 24 Oct 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1UGQF3y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7C1B0F16;
	Thu, 24 Oct 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786536; cv=none; b=ggPBGZygsl9tYnbDhyokeeDyd35dbRig1i8RXCiWvwcyqcu5gvpZl2JtSYC3PdXNvR/dDCRsqtzjjlgKlHjrCPMmOleMjbvsGhHDY3WxuDAr6pPlf2qQou29fBaqOJRLZqCih3MKyf6WmJiRFBHssZN0No6i1721oOZCikW2Bt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786536; c=relaxed/simple;
	bh=7oWDYwb4uUWi5/gtvvA228E0GGepNIyw9Uc0+1GrI28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKwOamaqFWfapB3u3m03tyTZg1DWb4jKjLG0IdaNosIa7rvkO/oHMJGSOLttxwetXkcBhyW63biC43e5mwshhdHa8hR3ydSyuYFWhHiY9XKYvsFpcKB6fgnFIDyLUnENF/OZBvBizo9KlTmAPAmqPNgKeMUYhmvbwUMoGgN9SCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1UGQF3y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cf6eea3c0so8843655ad.0;
        Thu, 24 Oct 2024 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786534; x=1730391334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DkOz8Jxgm0wsoBoSFzJGcolz7R2ukckRTZ05Koqm5kU=;
        b=k1UGQF3yleCbYvksB8wLnaLjWNIl66NP2J/I3QANGlqaKyjjVIUF941xd5bJTNZmfa
         /vqHoIiFSbzHXOcHYr87PmWeIGWZ80yNvsbHehTaRBjDrY6H1re1pNRxxx3G12AZRSer
         abPWTT2MJfsOJHTL7MCNYi1ihjZ1WADzY1Bv4QXlfqlLAPB5sBLBeC/fbqIVD32tbtXf
         SLj0RhC3zF99hhmlJw5z9YthcpfaRG7jCm7iv0ixAGo8SmloJ3C54eR6iqok/FQAUGPr
         hDUWTqB6RZtxcFirNCFYRQPxQHuens56YSZ1nOPdF8p2kMyqeLtLGCTpGHse6M++fGiL
         wPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786534; x=1730391334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkOz8Jxgm0wsoBoSFzJGcolz7R2ukckRTZ05Koqm5kU=;
        b=aGxMtHhYxzUmw/7TaBJi18MFMD2SPUoMSYSBSHOypgGVFgluv2zc7f7GBgl9+ilJWB
         f9dmzLB5IgeMy8rVu0IZ3tCYwAR340mQwMz0cPleVSegvv+C6T6dZPzDniNpF34Bb53+
         mA4bdm1k99gv3xVZSNVTFayDyxvmgRkyZ4q8jaWSMhQX9/TEi/aQysk06gtiEXqYfefQ
         /jtpw8Nml5QIB4yOvV4BN3alPDsRGl31ow+8LgdoZdjyJu7XOzUtv+MCPKNdeAweS5KK
         FdMpvRIjELYX1iprfi4n61GM2EONDgD1SSH8/RPmEjRj2clo5IO0CutjtvWqZze9QJQ+
         C0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUIUBOnr5G1/iNhCwxlEwWP6nzmz33s3zBc2f/jhvY/C/TbrP4j+pMdTWyqtG9M9DUZRt2A8t97EKHc6A==@vger.kernel.org, AJvYcCUPy30k20QzZMbo2wHthOx2VGt5MwvZ6AajAmGUcivNQ8wAl6AC4bN5Tpdtpwo1oorH6chcCHPq7dg=@vger.kernel.org, AJvYcCUgI/tNULD/dhsuw4O3y89pxMzBg7PJUcimeC1mMzDZQyYoT9Dp25wsYRparcjdVRpQj0CNZU/czO7IfRM=@vger.kernel.org, AJvYcCUmhpNHJBoZMpfHlGFNESzg0RVTlOzXuRSln6Nq5+/uAqkZidOkJO7TSJt0h4CLAs3by98M1JQQtbZQ@vger.kernel.org, AJvYcCVAxV/e3VKgYIxszMqzIQlDEAn53AsCqXBVqhoX7McJ6xK+/rcJmml2SN2vc0ynsUZJVgbTk99IzqMh@vger.kernel.org, AJvYcCVm9c2SDoOamWvkjiIBkdrtHPpB2mub5pyXqNhYk74qMuelluUjHRMWTHAqlseQYct95GE6D+il9cI+8UupTQ0TVR8=@vger.kernel.org, AJvYcCW053Y052HgQAwRhoIjqxdq4SAte1+Rd5IcfEfEF64vCkxSrZKlFoHM4Dkcd2UOC+eeCQ6TK+L7@vger.kernel.org, AJvYcCW2NjomPzOL9Q4sN2sv7MD+Mk1rDwnRiZuWppTLFuTX1zzcbkqoZsdAqTmX1tIW1lGRv0RizVC4QqSIVQ==@vger.kernel.org, AJvYcCWA3R+uH+KFcWy8LlDxgBocFqPUKPm/EHdJAwh8LY4+EL6qs0A1Zlh2bm1SDWDaHSz8Gf8S8B8MZOckW/w=@vger.kernel.org, AJvYcCWSPAVkzLGHa7OXt3ygWiT0
 L31i9AzY/V+kGf93IcYkX4pb8gREJ+2wcwW30m2bNQ7El+rcI4oAhMqA@vger.kernel.org, AJvYcCX8C5to8Mxzmg3hLSAjV1rw5Q3Ib8C5GKJEYGEq+Np+CnvWwQO8MVisordd2NzCVb9DbNgMey/s6+uRgg==@vger.kernel.org, AJvYcCXTb5dyV40EN8m6Q7lB79uv4jvmV3HNZXM+C3gejIWohD+YswkxQoe6USwNeYClLx7Pe/fSO43iML3tht8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uYTPtjxxsj9S4x3ekn+tP17w8ukbisESTIVlQZGdySp2rljg
	tEBkEJQiJMJ+OMFdzyH+1aDh09nzW+O/Jn+TatKs48OnKtuc1iRj
X-Google-Smtp-Source: AGHT+IFheouIyfOd1dj6PbeUjc9r7YCvmEYlqOWLvj8MFqWN9hKdgbbc84zpm/qdNBMTt9Oi9KJuyg==
X-Received: by 2002:a17:903:18b:b0:20c:7a0b:74a5 with SMTP id d9443c01a7336-20fb9aa1f88mr25585195ad.39.1729786532844;
        Thu, 24 Oct 2024 09:15:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62c2sm74239025ad.20.2024.10.24.09.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:15:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
Date: Thu, 24 Oct 2024 09:15:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ivan Epifanov <isage.dna@gmail.com>
Cc: torvalds@linux-foundation.org, aospan@netup.ru,
 conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, gregkh@linuxfoundation.org,
 hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, jeffbai@aosc.io,
 kexybiscuit@aosc.io, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, mattst88@gmail.com,
 netdev@vger.kernel.org, nikita@trvn.ru, ntb@lists.linux.dev,
 patches@lists.linux.dev, richard.henderson@linaro.org, s.shtylyov@omp.ru,
 serjk@netup.ru, shc_work@mail.ru, torvic9@mailbox.org,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <20241024095708.189649-1-isage.dna@gmail.com>
 <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zxpqnf1M8rPTB4DN@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 08:41, Andy Shevchenko wrote:
> On Thu, Oct 24, 2024 at 12:57:08PM +0300, Ivan Epifanov wrote:
>>
>>> I'm Finnish. Did you think I'd be *supporting* Russian
>>> aggression? Apparently it's not just lack of real news, it's lack of
>>> history knowledge too.
>>
>> As an avid history lover, you've seem to forgot, that Finland fought on Nazi side.
>> So yeah, we're well aware you don't like Russians, unless they're in concentration camps.
>> Which is exactly what you do now: segragate, based on nationality. Strip of credits and names.
>> Once a nazi - always a nazi. So, fuck you.
> 
> $ git log --author="isage.dna@gmail.com"
> (no results given)
> 

I really don't want to get involved, but this misinformation really goes too far.

https://en.wikipedia.org/wiki/Finland_in_World_War_II

provides context. And it does sound familiar. Turns out the Finnish defended
themselves against invasion from the Soviet Union. Sounds familiar ? Guess it's
the same as those alleged Nazis in Ukraine nowadays.

Guenter


