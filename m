Return-Path: <dmaengine+bounces-5749-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D6AFCB67
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 15:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEE81755B1
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B701F4CB2;
	Tue,  8 Jul 2025 13:07:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF6482EB;
	Tue,  8 Jul 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980073; cv=none; b=deq07VbM6+CrRteSEDmEBUUg2FkBx+azEjDfO+hixB512FAidfOXru1bteCalDFVSA/Zn8T/B/vboIehKP98BMh7va9q8hgrsOKBpUEo0ZHa2UqDF6qpNyXRsdoKvyQzBwqz9lDriP1D+lzTnMcREiEbnCd0oVm9CJQ547BSDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980073; c=relaxed/simple;
	bh=9W7qqefQpClCYAe+CNqL+Vje4qUSx79iKdzEQLybd74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0zjCIcYmN/czuHQJtKzwaTzDphMnWpkuNVHCCqiGwn8mffQFr2isENkeGTBCcZ+AHDRl7Kd+gHDFO732XO/lKzyT+3HMtqAaFEeEWZcOuXR1z92xbeIfgsdk/wbDThnxMExmBtEviSZ4ojwb/WXn5WqPDMa5FnkFsvwJG++jCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40669fd81b5so2602185b6e.1;
        Tue, 08 Jul 2025 06:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980070; x=1752584870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHA6gEHX9MZ7s4PrlO2orh8wTUytyNLu+VlwMAwqKLs=;
        b=t8x99avWtJfFrmwvgabMRR5514l4ER9IJMIB2eBsyqzIt39XWLlSv1P6VwBMBdiepV
         sorQgNB6UaQArIjAt58Z04ekn9VE99BEFeqLtj9fF6AxbUdhmY0sjjfGpF7TUgL7Za7s
         QduSCA3NAOTWT3qLnTYEtZ8WrG/laRqH4R4hdHayeqJtRg3CnfA6TNeaL0RlPVo7dkLR
         yfDm0uwqrw6rJ1qzO2UoR26B19dvDo5kbD9Ff+lwfz3bUwFqouwvHA/JVSSNuiqqKPi5
         0Zj54wbM9X/vy866iO5SDJiWncaccuC49RZjus11bYlPCryhakCIN+mMeOiW4p/gWBzg
         79Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Z4z3wVfDe38Ym02G2rBDoC58mOwcYfhFFOxdW0BZzhhcqI0NqaMmM7dQS4z/8NdCbcSTe3O/BrYFdhBm@vger.kernel.org, AJvYcCVN1npCOtWwoHN7+BiNCE+LONLQwinUq3HFqhSfZWdOOi/p8oB/mpY+PLYO+6f9rHuLvRppBFtVTUc=@vger.kernel.org, AJvYcCX3cZijt9cDwBJZQmNiQ7+0JL0Bj7dfeYenO57BuVwrWFxWoSWKoERIy692J99heFFEBugf0vO0LvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq3VzLEOJj0bACTeC1st4hZ7gON2yQKRX8g0uQTRjuSULE3rp
	B9DhW4ViUKExXHMx0J3KoVtqwEAf0s7cOgf428e2ZIOyZbgutNTSzRFdNNux7mtq
X-Gm-Gg: ASbGncsDe0XajQwciALwCsx3b5nnjubz0JgqPLy+Ia5FUgWjjW6skcH7YaUl71xF0VY
	vykjLcuX1q4+eBA0HxOau9CNMEx0hxO92g834G6VcjQCQcmCwIHnNa0aHr0BdAIQnxBEuyNxKkQ
	YfHk84Q+0WYdxs1mm1unBtlmKafAEXeIaECD1froKXdM+/z/QjdRhhPMi8Rk8effukh0GiiLJth
	Uor4cJZy7KsGoN5r527/exgzufDlNz+DLCuylZhi1DMuAXr6g6Z/wkEePxFcu2epk5rAZnl0tqP
	CIkLjsRt6tLegnwx+N0Sgu/K9gTJKxDMt3boVyV7BRwEFwGHl6K/6dtskw4Utzna7ia/gGEXXBX
	lx8ALM9qHRQ5/6vFnlcjIr64liJglFL0STm/rL0g=
X-Google-Smtp-Source: AGHT+IGzOm4F12WKyZyhYSva1PlcU9gg0OaESdzqG7slaO6MzKoFZKwa4gvt3PvPvKuVHl6Mcxf7QQ==
X-Received: by 2002:a05:6808:4f11:b0:40b:3bdd:ba22 with SMTP id 5614622812f47-40d073cce09mr10668022b6e.24.1751980066586;
        Tue, 08 Jul 2025 06:07:46 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02a442d3sm1666412b6e.13.2025.07.08.06.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:07:46 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40669fd81b5so2602103b6e.1;
        Tue, 08 Jul 2025 06:07:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC/JEkl5IhVGA+jeuExUCHBdt0Y4VDhfXsD12xJz6f2PPmdpaiH73tDOtojgziUL3WIYEDw2wUcQo=@vger.kernel.org, AJvYcCWwrlZ9Z5XgcFcK32kWMCw/8QsizYCoEeEeNNmp3UBo/kbKesDhq7gtQWGr8wQbmdW+A0MRH4ERdqQ=@vger.kernel.org, AJvYcCXGUmbEy+HVYgexhSKg8OvPWJmBjKmX+wb05ejJp057Z5uZoPUheA1TOFQwZFT0gzOjbuMODC+et92ZkVk2@vger.kernel.org
X-Received: by 2002:a05:6808:211f:b0:40c:5b58:c9f9 with SMTP id
 5614622812f47-40d073ccd23mr11010099b6e.22.1751980065545; Tue, 08 Jul 2025
 06:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jul 2025 15:07:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUn=qOoKp+tNNCepb1eBXpnikJxg8w6aRR50QK562tE1w@mail.gmail.com>
X-Gm-Features: Ac12FXwubtqCI7AQOEbn8rPLHwCHn9Lj_ZNicF63P3NXB5Z4ojYkRq3WlQv2Kds
Message-ID: <CAMuHMdUn=qOoKp+tNNCepb1eBXpnikJxg8w6aRR50QK562tE1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default
 during compile testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

CC linux-sh

Hi Krzysztof,

On Fri, 4 Apr 2025 at 14:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch, which is now commit 587dd30449fb1012
("dmaengine: sh: Do not enable SH_DMAE_BASE by default during
compile testing") in dmaengine/next.

> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -16,7 +16,7 @@ config SH_DMAE_BASE
>         depends on SUPERH || COMPILE_TEST
>         depends on !SUPERH || SH_DMA
>         depends on !SH_DMA_API
> -       default y
> +       default SUPERH || SH_DMA

I think the check for SUPERH is superfluous, due to the dependency on
"!SUPERH || SH_DMA" above.

>         select RENESAS_DMA
>         help
>           Enable support for the Renesas SuperH DMA controllers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

