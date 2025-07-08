Return-Path: <dmaengine+bounces-5751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D9AFCC41
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675094203CE
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jul 2025 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7342DECB7;
	Tue,  8 Jul 2025 13:32:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F089EEA8;
	Tue,  8 Jul 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981520; cv=none; b=NMYDi44Fpqy9x9fXRGnSRzuGGxNXQelrsnQXtpjrGLCeuNU4ICfnXCaTICVv917LrL2sbrlSktrobqlZfiAIYR26vSrJeAxDc5Ww0UXyfmN+A+ycW0u3bKsO3SDQ+xihSaxaeTyj67sRT3l+7P8QqQ+tin89M3OKVAlBKqZmotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981520; c=relaxed/simple;
	bh=g9yFXkB8Qe9fQYPOMXlv3LTCqj74YDJQiyagwz2sdJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1pjMpLjAEuK7d8dBV4TZKN3p0XV81jpb9CKqseOKw28vab3V2LnV7Bu0zVjaHwmKz9Vc8FWZ9M4AvxTsQ4W8UO05YLVStpgicCQpeg2NLGJYZUsMmOog1v2sCpj9jYsyZ8nbOjxyfc7rtI18O+HIkNJ9v/KcFsBGJlcMGXFjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5094491b3a.2;
        Tue, 08 Jul 2025 06:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981517; x=1752586317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxhuRDHiukzLToUdkGAkho9cpYP0RcWZ4Jmct4r6kbk=;
        b=Vz/2Orz4LHAxCTMMeyGmJp2vW1BQUS0taksW+HR8XsJiCHYPD4KlBO/WyBzSGqLktT
         PPv98bq1RR9DxQQymLU5w7w4sPccKyrDLm9l1hWfFAWde3lOoBH44Wum1dFkM26i3t2E
         zmmjVvD6zXfl2aF1NEVZARYlZwI/W5oKX/v7+S9RFKKPeqnOpwcmg09lwKpSotudULzs
         ZFS5OYTAwg6K/DLtxgkljYb+Tl+TVchahNZ0Lx62POckRyzpkIsEwAFHoT/qDnUNMcvE
         ldx6Gi6AcnY2zMrNJW8DOv2uLL4OTT7CobKP5QE9VatoQz/sDnghwgWDMywP3LrgQMQV
         F1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUEpfEYXbFe4EJWYOWx6t8/Nbkl4TCOrsrDPDbZ0qjYQ36Agu4wD9QWMwEYKup8bgBX9AURSwvndNY=@vger.kernel.org, AJvYcCV5z8NFpnFhAYCgA/KIl7QyQ07Kpq80D94iSc8R4cGONF94w7CFyh8iGqefJcRy6tV41HiTA8Swa9lif4mO@vger.kernel.org, AJvYcCXPj7QjhFgjbnlbuRN1Lnaqhd8EK1xvwmc41rTrG30Z7M66MR77TB9WKB7EcbvHqe8aZs1Gh4gpcnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKZzxLK4pi6v2Di3nV/+xlc38KP5BTy3EHVuyDCeC8HbT+tpr
	QnIbOne7RBJnkcSRZJN743o61xVlw6WGRTtJe1aQEMlB/f8jd2mDo4177xXX3/z9
X-Gm-Gg: ASbGncv22xriW/4m009WcJmst7lWqJ9HCekKJ3pznsIyQh7J9nFBJkcxcIa1HubJ4I1
	lYjC0MOLWvc3bHpdCt1D/n9UMEWTYdSS3nnOeLW5jxGbHvDFrAsJ337ytfu2XHg1/D2ODFrYHaF
	1VkSZuU8uieWjCSdSTj9SUVkBWymKZyrtxhYnD/aLO/wegKJzzQsLgStGgKU5IVq0NNzB2wffiP
	FFDryeRY8AGanvsea1TgQblnjvp2tbUjgQluVn+c6A2TmLsSK6cJc5nOBwdjG1+y2gmqoDM7ysH
	7bnVlhxIVevHNpD/Hp0Vamkf8LyNzuKdXMbBYCiE65t9eFO/4pJfJg+aREIxr56vpVKAccQWlEJ
	yzln02xS3jFRGrdV3E+HrnS2lUm0CzSpRpmzz7I8=
X-Google-Smtp-Source: AGHT+IEysCHVUtKRTrt64N2f6FKBX5ZwE4vgbFd7q8GPNtkqQJMq1aESpxzZOiFktQKqFN0eWhutZQ==
X-Received: by 2002:a05:6a00:14c9:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ce6669b0emr20723005b3a.13.1751981516595;
        Tue, 08 Jul 2025 06:31:56 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42cefadsm11835787b3a.151.2025.07.08.06.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:31:56 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23508d30142so52390835ad.0;
        Tue, 08 Jul 2025 06:31:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/r049bN+/o8nqDNsDeEDTIfy1C8UL8Dw5FSU29GU/dFX7TJQ2MBgGIK1I5Uye5fMxOcem5G9q5g0=@vger.kernel.org, AJvYcCUPvJXJuJliwV5UorTVfxL45gRag05AzBWChgMMgTLTdYLcULtyszTvpqxh1c5ZHiNOTkFf3l1yX4z3o9Au@vger.kernel.org, AJvYcCWbSvrc5H10d+KZHjwIeie02aIW5TjJSBnsHczgmrKI7l6D8mm4Pn2OjoHdxpiZDWaNyNghLYo8dB8=@vger.kernel.org
X-Received: by 2002:a17:902:f686:b0:235:a9b:21e0 with SMTP id
 d9443c01a7336-23c85cb3bd8mr241105105ad.0.1751981515563; Tue, 08 Jul 2025
 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdUn=qOoKp+tNNCepb1eBXpnikJxg8w6aRR50QK562tE1w@mail.gmail.com> <99ca93ef-ab26-4d6b-bc7b-fd2f98aecabe@linaro.org>
In-Reply-To: <99ca93ef-ab26-4d6b-bc7b-fd2f98aecabe@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jul 2025 15:31:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSudUvm-ZhTBMtYn814+My2On3_nag60AHNOfX9eGEcw@mail.gmail.com>
X-Gm-Features: Ac12FXxs-6JOzLBYbGJZr_Ju2YGiG9r7OtCO8RqDkOV1Do5ThXuxslQiGqbF7wU
Message-ID: <CAMuHMdUSudUvm-ZhTBMtYn814+My2On3_nag60AHNOfX9eGEcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default
 during compile testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 8 Jul 2025 at 15:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 08/07/2025 15:07, Geert Uytterhoeven wrote:
> > On Fri, 4 Apr 2025 at 14:22, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> Enabling the compile test should not cause automatic enabling of all
> >> drivers.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Thanks for your patch, which is now commit 587dd30449fb1012
> > ("dmaengine: sh: Do not enable SH_DMAE_BASE by default during
> > compile testing") in dmaengine/next.
> >
> >> --- a/drivers/dma/sh/Kconfig
> >> +++ b/drivers/dma/sh/Kconfig
> >> @@ -16,7 +16,7 @@ config SH_DMAE_BASE
> >>         depends on SUPERH || COMPILE_TEST
> >>         depends on !SUPERH || SH_DMA
> >>         depends on !SH_DMA_API
> >> -       default y
> >> +       default SUPERH || SH_DMA
> >
> > I think the check for SUPERH is superfluous, due to the dependency on
> > "!SUPERH || SH_DMA" above.
>
> Indeed it might be, but I must admit I don't understand the dependencies
> here at all. I think commit 9f2c2bb31258 ("dmaengine: sh: Rework Kconfig
> and Makefile") from Laurent made it confusing and this later just grew
> to even more confusing.
>
> What is the intention for "depends on"? This should be enabled when
> SUPERH AND SH_DMA are enabled?
>
> SH_DMA cannot be enabled without SUPERH (no compile test), right? But
> this "depends on !SUPERH || SH_DMA" suggests it could be. This should be
> read for humans as "if not SUPERH, then require at least SH_DMA".
> Otherwise what is the meaning for humans? This driver will work fine
> without SUERPH?
>
> My change for default could be rewritten but I don't understand the goal
> behind current depends, so not sure how should I rewrite it.

I think the original plan was to use the SH DMA drivers on ARM SH-Mobile
SoCs, too.  But enabling SH_DMA on ARM SH-Mobile was never integrated
upstream, and the focus shifted to ARM R-Car SoCs, for which the shiny new
R-Car DMA driver was written...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

