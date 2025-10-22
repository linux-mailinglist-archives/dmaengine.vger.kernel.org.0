Return-Path: <dmaengine+bounces-6923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D5BFB208
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C50426D14
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF63112C0;
	Wed, 22 Oct 2025 09:20:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390F2F99AA
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124811; cv=none; b=DbJ1MjLv77kN2fySyY/DVP20oWns6IKQC38eJPe3eeGDLRvaa6WGAQtMbbd8zzXKGCjOjewhW9qneQqzvEXL7WD3/dDRyLtKjAg6KjT0OTbvWMvcVnJH7JfLIIeBcSzjEtIfkf9uBpizJUnbNn7lkW+YeHO5PoPaaNBXVPP3nag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124811; c=relaxed/simple;
	bh=G1iH8NrfXxiIzi56l5MFL/KIcTZCh+2ywldp0HMaEXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6a2itcQrlZXi0QjQGsmrcYS8E7D0zIbC9+QOgZo2ZPl7u0ILVqy+U8fGgxZLjUGP7V7y7Tc4SeVKaShmwxlI95im7ljtHDPAKb+olbVdL2MNRbUgTTp/1sGlCwdAKUAfMZDsaH8MNhYwHz0K99Gk0O0yf3RPhhssGe1WWVwbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d967a34203so748204137.1
        for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124809; x=1761729609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzTfM6hHw1WxEGlErp6V2knAaHaB2xPtuGLl169CGwA=;
        b=kbwjXlSc/i4gUc23J3tygQAt/jk2MJEBYPxeNeDNl6HPsfDWrsHPfMcVMiS68MkqFG
         1YcHiDtgUmnMP/XYuZoQrjZ1HlbTX7byx0EJ1jSsTpBK1BBOisZRb0hTJDquP+/XQNIz
         UvNUqZYZGdSIK02qtTff1aFe5aMUWVjIBY8x58SbmE9b4NJu1g7XgIok7IkINs1crIfv
         l4Ypigu+FMRI8KS3ee2qGKiykkhEpr84WSkE5IDycp0E7ZWjodR99RFg+f+Jp3LMBciu
         VIrTYxrAQarSb3xaQ0YGX2yCeiNncKz8FMqjCZOOmok4kRhdWWg26cJGXHEVWNfiXt2w
         MawQ==
X-Forwarded-Encrypted: i=1; AJvYcCXViMbBrBDCwB58E5kAc4QFyzbn+e8ox5+Ey1vRWsDsAaW9Wsw7TdhSssUib+yG3oilw8NYabcvMW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydahgwMMwf4xxAs0i9RrkY5oEPL4/wAHSKBFaVFV5MZqdT2+/e
	0LDyPU7mktklsMaqSuYvUbVPAg7F/E5D7VKTZKB69CLNknfQP/M7L8pSCN4Fa26H
X-Gm-Gg: ASbGncvsS2glQytgb6KmFanTRwbYRfdnlNSyq1G7Kjt23zJkOwpO8uA9B9QbGdwEXDP
	7ERY0CbgQZ1fCldPRzMSZqJ05wJjRGzW20J/xR+T5ItUUEmVsIW9U6WiYY4jiRb+ESgvJD4u4Et
	rG5SYssJlXBeh6Lygz6X9nYkd9aXPMfqJSLm0ANL7xDlXmh8GUb+l67iJBgJVd6zo7rfNtpBYck
	kz8U+uWLrz6z94dBuFjb24f1uZddVBDcDimGRnwgoiRhHB+vuiGWcfMfaUrMDkEb2addNKInuo7
	C2QkcIAI29j6k0GZ65SXLd+qveGUB2Un3rVeHBZBCkN5FW8roDezzEq1zUSOp5zXD82rEcvM81/
	Evr4YyCUviXVN/rqAJeSFlHA3Ld0fZjDhxXFeRmjFoZjFHS1vUWEnHjkkPMhkmoMopKHf4LVTdf
	Pw81ksHyZOiat4moNLm4RmStEh3xx7gAtwsvb57uyZKutyVkXD
X-Google-Smtp-Source: AGHT+IEyFW9brZC1uf20RPfw/DE1nESvoQC6N/aBQ6D1wtYWnRLQGtYABxpPAFNL7nRvYzBMOi9+jA==
X-Received: by 2002:a05:6102:53cf:b0:5d6:8de:2ed8 with SMTP id ada2fe7eead31-5db2384a859mr180329137.12.1761124808955;
        Wed, 22 Oct 2025 02:20:08 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3cd56d4sm4474360241.0.2025.10.22.02.20.08
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:20:08 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d96756a292so887275137.0
        for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 02:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULtMrTdKwxcOvCGzAFH3bnMn4Fjd1PT7gcwndxB/FEklPuRKjqXQ+SG5pQROn944qIWExh8a7z9A0=@vger.kernel.org
X-Received: by 2002:a05:6102:81c6:b0:5d5:f6ae:3902 with SMTP id
 ada2fe7eead31-5db23866f45mr206045137.19.1761124808623; Wed, 22 Oct 2025
 02:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 11:19:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
X-Gm-Features: AS18NWAO1T4xKgR0pZBbqyleSonlF8IGxjXfESnWqWSdqh6DHcID-GTrRDaxhws
Message-ID: <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz_dmac: remove braces around single
 statement if block
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 22 Oct 2025 at 09:39, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Braces around single statement if blocks are unnecessary, remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -336,13 +336,12 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>         lmdesc->chext = 0;
>         lmdesc->header = HEADER_LV;
>
> -       if (dmac->has_icu) {
> +       if (dmac->has_icu)
>                 rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
>                                            channel->index,
>                                            RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> -       } else {
> +       else
>                 rz_dmac_set_dmars_register(dmac, channel->index, 0);
> -       }

Seeing this same construct being repeated three times, I think it
would be good to introduce a helper (in a separate patch, of course).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

