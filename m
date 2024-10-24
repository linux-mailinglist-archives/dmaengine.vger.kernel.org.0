Return-Path: <dmaengine+bounces-3464-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EC9AE17E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756651F2113D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63661B3939;
	Thu, 24 Oct 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHKiZjLg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A91AC8B9;
	Thu, 24 Oct 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763659; cv=none; b=D6ctiiZme0fCpDFbnZIjOEsqd2R0qIWv/73EwffrwvF74A7BqzEkLNUcL1I0Y7tcD+uOa8SZSNIC5RvR+bnLWnqis+dZ6psIHGH3B8nm9Frc1w5AHNehJxGO+scCyfRTK4yejCL+jjQ03FbqSfrZCJ+vm4Zb6mIvzpcL9BbJC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763659; c=relaxed/simple;
	bh=FKxWNgpm5Kd3t6VYzCpTSntmFd4Q0I0hT0G3IkO8d/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPKOivUXv2Hv92rM6fvwzWvz1FfQi/IyZlDa51E164YZLou0sQNuP3bH7nWz/q91sX9/ObddMnqP6OMSljVJ7lt7YN1MPM7MMiVGTCgxwZ7V4ByiQGMM4VzOM6OWJNDrbIDs7faqPX6hwAVRnYUnlnniwIkabk26a2GUudiLSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHKiZjLg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fe76e802so857413e87.1;
        Thu, 24 Oct 2024 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729763655; x=1730368455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWFrbyngtx/okFnAnXziGIwpshdD52HD2rAoJDGqVCM=;
        b=mHKiZjLg72cPQkRNKT3vrbt6usW+O+wb3Ec+E/+xe+/rKirbTediOVLWfcAI9XSB0K
         Zn/p9gzyi/GL5MafzAU+kU+IPgTkffhFjIEIMHUKAXcMNWE6wR174zH9RN+gJBRuI9zW
         sK16P3/vYRiSnp8hC9Elyx6NrfsZk60t6N7jeobN9xIQnnhYgrQHpDwCogzW6kHX5bWs
         tuc/9f+tAiioJOhi8dGNyjhoQdIQg5vCA1OtzUf+vy7L+ejevIVAy6HSUrwzPLtN1aU3
         9kuzvZ6KeR+UbEyXFA59+8kikuLNiJLEoDr16A1eUc03OxQsBq2joVU0iCOTNfFiSLQM
         2tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763655; x=1730368455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWFrbyngtx/okFnAnXziGIwpshdD52HD2rAoJDGqVCM=;
        b=gQ99bSPJDyWNGvIHXaO/HiQEzK+tt9eRsz629P5FO61uLy3WknvmAwyzeo6YyQF/+d
         4zn4yS6BOUw2fJ340hjD8JFawh6DEY/6Abx4mo8WHl6ab+jWG4PeisH31UlsiEIHCNM6
         6pQv+tGRkPUBo4FpC23hCb8RM61B73TtWTgE1vntoSXYf4dFuU6Qw5yeVFIdPp9/HF9q
         h4NU6Iev81SB+nNO5eRQxXCL5DRpdJ439VIDKD33+h83A/GXj2OLKvkLZmrNbUFXtZoY
         OXPqqml+cZTpH+Ucpym7iimqwhXWrtI9/XwN5QHZ9HU8p1g65GtnSAqZyFOsSpQIuDtZ
         Dj6w==
X-Forwarded-Encrypted: i=1; AJvYcCUO2SqY8pCCDtEuM3MQhSh5BxPaXrgVJLyGD5xJ9Cb3MC6Rpe9oQq2ZemCwsdI6eqG8OIjKZ4uaMJBJT8Y=@vger.kernel.org, AJvYcCUXTka7NZeabZ71I5DO05qmitf8fC0otSVqtujeq+b+kXZkkYoMZQqiAuqFvbAyrTkpbKb+4tQsY/Mqsg==@vger.kernel.org, AJvYcCUaBBpSyiIqZxmPR/h+3+VFgU0/3MlxICfSwkGvn2dIVE8/SkV6BIoMVjOtid4w7eDcPNMD5ulFCTXLfxS+Ox0jghU=@vger.kernel.org, AJvYcCVSGw/mIua7EK/UvhLig4u5yKomjcuNlZMe1gCD2LjzaLOLhHG1JJLrLKazi/YAfRMUDKZoVCZy5tsM50A=@vger.kernel.org, AJvYcCVSbXKWYc6vqR4UyvfuoDogPuLwMwlv0Wazd1NXzSV3lzIzroM0hKVY4OVJDlYP0bYeVfamw4BLLR46i1Y=@vger.kernel.org, AJvYcCW0017L0Xcdr3LLSNY9psuMPBy5Ts2m0dF3LAiUPHRnYm1EhveRbv+PS/P1gSINJ87Y7SG6BoXJPPVJ@vger.kernel.org, AJvYcCWbLeWXgvBZLsC8DaSVyD4NcB66wS2I9X+gsriVbaRPZNmOEcHcO05ZF6PJoMqflodqQvp+fJAmZ+thHA==@vger.kernel.org, AJvYcCWyROLnR4eju7J8uFDskP4Rc0rplMxBTltFQgDlKgeD04i50J2uAOxAaqChGFMiYO6R0B/vYshh1y234Q==@vger.kernel.org, AJvYcCX3ep4/d8pn4PUAmCKXe/9uTRFF3b2KfTytzemVHVUDkjMdTyNGQw8pyLt1v77rjnJcJ+fGCtcu71U=@vger.kernel.org, AJvYcCXYonwE5bWS
 lsJQI9K4CaeeaS24s0jjeqASNtPIvx4XTspyrqRFV8KYw6ojApe5TWCKMm9P1RVmiQQP@vger.kernel.org, AJvYcCXrHAzcets9h5AqfcMOjxg83GPsA6zUv/Q+QnRcZgs1oyPO4EmiFuwn8nT9uc/8Ia6PbIaZku6bSA+U@vger.kernel.org, AJvYcCXyNYiYJ7WUidwUqKHoQiiELMBUdlSGmZoJ2RuoODW2zCKwJBF5bpRvJjEPaE7roHLJPa9ezVCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOboEqf5dDveryMIPOtBJR7l6jlTdMo4Zvih9IDiPpYahEGMF
	RSBK4qTOpM/di1eIuMNS+5LQAuP9b8ZuQ4KxDCc6dijK/22rv+t/
X-Google-Smtp-Source: AGHT+IESS/b985DjGqxcVR4TpFmyKByLbgcGL5xpKJP8FcedH7Cq7mq7giZwGEwbp0hOURP0H6AUbw==
X-Received: by 2002:a05:6512:1583:b0:52e:9762:2ba4 with SMTP id 2adb3069b0e04-53b1a315eeemr2629947e87.25.1729763655208;
        Thu, 24 Oct 2024 02:54:15 -0700 (PDT)
Received: from [10.110.248.100] ([79.110.251.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1ade1875sm455020e87.18.2024.10.24.02.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:54:11 -0700 (PDT)
Message-ID: <3448a096-849a-4f61-8017-c03a83e22c38@gmail.com>
Date: Thu, 24 Oct 2024 14:54:04 +0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru,
 conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org,
 s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Language: ru
From: B4D_US3R <producerkgb@gmail.com>
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Grandpa, take the pills or you'll get your ass kicked.



Дед, пей таблетки, а не то получишь по жопе

23.10.2024 22:45, Linus Torvalds пишет:
> Ok, lots of Russian trolls out and about.
>
> It's entirely clear why the change was done, it's not getting
> reverted, and using multiple random anonymous accounts to try to
> "grass root" it by Russian troll factories isn't going to change
> anything.
>
> And FYI for the actual innocent bystanders who aren't troll farm
> accounts - the "various compliance requirements" are not just a US
> thing.
>
> If you haven't heard of Russian sanctions yet, you should try to read
> the news some day.  And by "news", I don't mean Russian
> state-sponsored spam.
>
> As to sending me a revert patch - please use whatever mush you call
> brains. I'm Finnish. Did you think I'd be *supporting* Russian
> aggression? Apparently it's not just lack of real news, it's lack of
> history knowledge too.
>
>                        Linus
>

