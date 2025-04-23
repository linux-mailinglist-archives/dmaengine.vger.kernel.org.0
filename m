Return-Path: <dmaengine+bounces-4987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E330A9883E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45FA3A4C65
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1D26B099;
	Wed, 23 Apr 2025 11:11:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D20269B12;
	Wed, 23 Apr 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406702; cv=none; b=OuzRowpMccle8RAo2iEgkOJQ4BGerHQ6cr0VpzzJYGkcUWEftz12PVJYqs/NwQXfz6KxEIHRjeIvPk5PY+2l2V7xvveQs2ADWvbP6cfRgZL9/kg0JI7y63AenkdrZMgf8m9JK9S+TIIOR9kkl5BgrLdozu2DMSSPx0Y/OFXVrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406702; c=relaxed/simple;
	bh=dcSj6/dYPAwWyrIQVz0Tr6uehjb1hHrkbiJpXO1OUYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbXEeU1MF68YljbkgCm1TFTeGbefRPQr+yr4lbiHwQM/W6QVaWmzyAlD+yMBlZx56gBqkc1nzIeflOFB7zUuweqSqBd7VLEUR1cWbvRWbOKgrNZVv2AHx6g/Gcvv1+zyFU5jNDwNILH7TzmR15nCkCxSof9IfEnvlx3152nfR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso2373344241.2;
        Wed, 23 Apr 2025 04:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745406699; x=1746011499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwFnQLNd2ElqoHSqs6HidAKq6gQZiy66/qPTuUWPN1I=;
        b=eip+q+gqhVNtp9nzmWKbo0sXM2Qa7bX0YYsGhA2zLdHpTg02XFCU1M31+KBZXgXubv
         FYmQfXKb95ezdCzG+el/yQu6LQmurNzADWo0jLx/CQWzGeorKgikSdLn5NphzeGIfdFb
         A1BCqo5fF6nJtBWebkxLcnzzi74lELVp/8ustDL6go0jEKtCIS4dik3B95oCDFIlPDbT
         Ax6P0gHaxvGEKZE+licJaIF+ZpBFLFJEr7eeBDoYtDAke044P+g9AL18xzNXM3ki9apD
         tqhr9uByS4PWhsmDxyY0TAUlXdjOFwUXpeQxLtagiVxAiSe+VPZgcIl1lvfiCWSPERZ2
         ELLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4nTgt4x8BCBH7swNHhL8BGna6exII18r+3MWe6r6lmq2HIld10bAqdPHLp7AvfVLGvKL0TkB0p4BXKnbO@vger.kernel.org, AJvYcCWLqvP686d6ZmbC8FyytLAxlbrKIV+dOBMsgC4zMTwx0+eIfk7VD2KsRp+bmpyK6hOffksRVlGBe0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEY19FB4JWv3ORS24pc8gXmPHM0CYI63gDlrt0lhpRU+IK4n9a
	P2YxtkDyBW25DByRstSlM6YOEyBarwXSZ0aeXE93I8oRPXoEmfQgnY+mJN1Twhc=
X-Gm-Gg: ASbGncuq288BHtnJXNEknVQT3yJUvpMevOen7utGdTToFpRaoj2USpxv3ZY02vPIWZI
	vQUDgR+mT60sBP+L0Wz0FStblMyB7gVMJTAjpc4n6yrHYxdARRp59nIxUp9JQFntcGBb6QUumk/
	PQ0ACxppH13Um4/X6Qu6ST60N/Hf4qoJ+T0rnavMjyf4qierrSta6RBMbudeabj2bS3okvF4NIU
	WwSc0pOYxyLxa0yPWMnO8OY9djg56hN5lujQcRyER+j2CLDt7gWOWWQAIGki7vagf7TPwwIVO/k
	WNyoq2OvPlU+fGFyOhsQTntrFiXBlsP7la1w9bVukdPeZm41PM5Bz77WCoERNuL96jqGhxpcTBD
	uMCMy+Ws=
X-Google-Smtp-Source: AGHT+IHFVFJHJ9SDuv/BVOPt7Ka59KPLvJYLCUpZudsYLLMWa5XNzDq+m2rvktzPlTFlfkRBHU28AA==
X-Received: by 2002:a05:6102:4586:b0:4c4:e414:b4eb with SMTP id ada2fe7eead31-4cb8012ef4dmr11584098137.12.1745406699065;
        Wed, 23 Apr 2025 04:11:39 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7da0e87esm2619162137.0.2025.04.23.04.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 04:11:38 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523de538206so2431093e0c.2;
        Wed, 23 Apr 2025 04:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJslNicjUlB456m5v1XTvvsH1M1xh6C/twnpWjewGk7DZJYRBaaGMJqAlDUnvjqvYODugqPoFAho+5HgQ9@vger.kernel.org, AJvYcCV+FQQJucXoe3Nk+S4mOMcihqSCTU4t0zHpXLrSH0hdIovxI70vYB2wElW1jVs3YMzPwnizBmmSFAA=@vger.kernel.org
X-Received: by 2002:a05:6122:2a13:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-529253df487mr15940732e0c.3.1745406698686; Wed, 23 Apr 2025
 04:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
 <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
In-Reply-To: <b1f19b31-3535-4bb5-bcef-6f17ad2a0ee6@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 13:11:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
X-Gm-Features: ATxdqUG3O_R-h3xFZ-VbZPzuOVx8S7u3rM-8ANr4EcMPwyY_6h0-oOYf4tSgGPw
Message-ID: <CAMuHMdVJKA8zYETKJTRAwg6=+EuTq4YqbFO32K4+py9YNsD1Gw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Wed, 23 Apr 2025 at 12:59, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2025-04-22 7:11 pm, Geert Uytterhoeven wrote:
> > The Arm DMA-350 controller is only present on Arm-based SoCs.
>
> Do you know that for sure? I certainly don't. This is a licensable,
> self-contained DMA controller IP with no relationship whatsoever to any
> particular CPU ISA - our other system IP products have turned up in the
> wild paired with non-Arm CPUs, so I don't see any reason that DMA-350
> wouldn't either.

The dependency can always be relaxed later, when the need arises.
Note that currently there are no users at all...

Unlike drivers for other AMBA devices, this driver is a plain platform
driver, not an amba driver, so it does not depend on ARM_AMBA.

> Would you propose making all the DesignWare drivers depend on ARC
> because those happen to come from the same company too? ;)

No, I am fully aware they may appear anywhere.

> >  Hence add
> > dependencies on ARM and ARM64, to prevent asking the user about this
> > driver when configuring a kernel for a non-Arm architecture.
> >
> > Fixes: 5d099706449d54b4 ("dmaengine: Add Arm DMA-350 driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >   drivers/dma/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 8109f73baf10fc3b..db87dd2a07f7606e 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -95,6 +95,7 @@ config APPLE_ADMAC
> >
> >   config ARM_DMA350
> >       tristate "Arm DMA-350 support"
> > +     depends on ARM || ARM64 || COMPILE_TEST
> >       select DMA_ENGINE
> >       select DMA_VIRTUAL_CHANNELS
> >       help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

