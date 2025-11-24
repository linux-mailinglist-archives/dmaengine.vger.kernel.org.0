Return-Path: <dmaengine+bounces-7329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF16C80A70
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4CB9344B73
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F36303CA3;
	Mon, 24 Nov 2025 13:05:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BB26F467
	for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989533; cv=none; b=f5ddPqz1mB49KSoPk5iREwJo6PH8DCB2vH89cQoG+tklN0PmpXXR+rTGHdS2EUXJx9gH1dJVN13BdsreJ7iAZLE7xvYCxkYupm2gaRtVW758S6g+EB1uCJjUEyT+4D5o0fdG9fVMzyB6gyo2EmzsdzryEqUqjUi0ALFNV2rBM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989533; c=relaxed/simple;
	bh=rvffBPeDVxbQoo+Q7lx63a7eZIjGM7ukQNoAugTkn9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXv+g488H0ef4IOPMRGUFGfvIaKFykjXZbLpFa1Fmc3+QPTWJK4GBquftALsmhO3/GAY5XL0Qes51kExR6UTQ40oa6yIjrSB6a7nU6yoaw8EyNhf5/QUgDA810JbC50pH3AUTEPvsTQwha91Ec8cnsYYl1d1Fsr3sRQSVXga8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5de0c1fa660so1388438137.1
        for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 05:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989531; x=1764594331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRA7IiXm/R9YyxGpbeRsKjwk7bFwEo0rtrEj2XwEZxU=;
        b=lFCuiI8+lI+iMIUzhwEEi5c6XpUg19sj7BhpnmTte9dTMpLGUmw9G/DvAC9zg0ObGH
         ZmGlNHp8G92eWXam5eeEzoTibSDBEpJAWtAM0sr2lq70DqQLfXlQz+dsWePI+QC6ejXE
         M7V34e62HAh14YZwVk4lj778pVxanduAHS3Bo8h+HT+78gg/Frow+wOaa6obv5LxRqyg
         jSrUBJ4iOQHjS9c+mym7n/6jgIEEZyJk1I6o3dXW/AQG4B4KXwOlm9imB05jCOWqvoTC
         cSyoL1I2q2WXJzAwhYvDwoPBAy1Ecer7sen/MmMEtIbQi7FPrFM+RChZcJ3vmiSp6QNa
         EQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUOY1WMEOOm82fsBeMeYiUMEXwTeGkdbhyh9/A5siZfR8ipknT2ypSSh94FyiOuuJL9cVw+9PNMTTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAFIyYw/+L5i1xEYC/+y3SqLqwT4cQzVyHuDt6godO+NGbz5c
	VBOjppOO55WTcKuwDgHGiZ3LUcqGg0mCYCY4aeYKu3rWGgL+emUVBa67wB3Rm/za
X-Gm-Gg: ASbGncv5Jv2WrDbfHDmwvz+i8vaAWCKfDHK5oNhDTWMy9PKhMPfyTkM/xPiBiPll+C8
	1e3Rg9c7qZRPfiwrzBm1H5DCaN8i75moPYqY0t9nKId0Z/lXA1bDrSn5rVaQ5mdqrL3L1tJy/JW
	Byrbygi7b4wDDK8XxOfbReqdWYsYer1+aL2EgQkArOPLicPxCHP0FSEm0HkjP93jqs2VkZG6fsG
	U4minjFbLG1x1pnIFC0p76ZKG4OR0updi6VaqP2YQ5VSZAOfzNIgTYcrk34IiHJXDKnJT0wOFZY
	pXhL7D+/miMUgufchcKMOw96ljyLtlIBT9sHiy/5+LXXQw1fZR8Sr5PkKijWbi3Sh/i7Y1VdtmX
	mdVdydYkgs5ntNOQf7l2FovazItKVNR/d33Ly+z+gHI69FzKV705MVhgjPu+f9rEejePgneS5W5
	Wb50v/wkDbcdh+uxtpE8WbMW4cRvMgSy0Z3lrBiZZcZzBOBhVhBRpVU9axUOE=
X-Google-Smtp-Source: AGHT+IHnFxHA7bjYX+noPZOyk4QTYB/oeL0hXbi7bcXVxw1/NrJB55WVWYNGTKjNDfMg6OTyrfCLFQ==
X-Received: by 2002:a05:6102:50a1:b0:5d7:bd67:eaf with SMTP id ada2fe7eead31-5e1de1f88c7mr3052132137.18.1763989531088;
        Mon, 24 Nov 2025 05:05:31 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c564c8261sm5682957241.10.2025.11.24.05.05.29
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:05:29 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9352980a4f2so1211903241.2
        for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 05:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+AEncAIiTaRYmt1aYfWW7E8yhtsMRDTZGnDimLR18IZjfaVJAOWnD74NVhAvsaQHSDg6gPs0MiDg=@vger.kernel.org
X-Received: by 2002:a05:6102:5113:b0:5db:18fe:7520 with SMTP id
 ada2fe7eead31-5e1de3bf69dmr2992625137.22.1763989529183; Mon, 24 Nov 2025
 05:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org> <20251124-dma-coldfire-v1-3-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-3-dc8f93185464@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2025 14:05:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWDryHHdrsBzsUF4BRhNoDXm4+3FVQ4FV2acGT6reeYhw@mail.gmail.com>
X-Gm-Features: AWmQ_bleU8rfcOoPzR7hq6Rm0AD1QUkBfKzAzzAbdXJa_V1TGP9TwrSr0BINHw4
Message-ID: <CAMuHMdWDryHHdrsBzsUF4BRhNoDXm4+3FVQ4FV2acGT6reeYhw@mail.gmail.com>
Subject: Re: [PATCH 3/7] dma: mcf-edma: Add per-channel IRQ naming for debugging
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, dmaengine@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jean-Michel,

On Mon, 24 Nov 2025 at 13:52, Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> Add dynamic per-channel IRQ naming to make DMA interrupt identification
> easier in /proc/interrupts and debugging tools.
>
> Instead of all channels showing "eDMA", they now show:
> - "eDMA-0" through "eDMA-15" for channels 0-15
> - "eDMA-16" through "eDMA-55" for channels 16-55
> - "eDMA-tx-56" for the shared channel 56-63 interrupt
> - "eDMA-err" for the error interrupt
>
> This aids debugging DMA issues by making it clear which channel's
> interrupt is being serviced.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Thanks for your patch!

> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -81,8 +81,12 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>         if (!res)
>                 return -1;
>
> -       for (ret = 0, i = res->start; i <= res->end; ++i)
> -               ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> +       for (ret = 0, i = res->start; i <= res->end; ++i) {
> +               char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                               "eDMA-%d", i - res->start);

Can return NULL, so needs error handling.

> +
> +               ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> +       }
>         if (ret)
>                 return ret;
>
> @@ -91,15 +95,19 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>         if (!res)
>                 return -1;
>
> -       for (ret = 0, i = res->start; i <= res->end; ++i)
> -               ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
> +       for (ret = 0, i = res->start; i <= res->end; ++i) {
> +               char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +                                               "eDMA-%d", 16 + i - res->start);

Likewise

> +
> +               ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
> +       }
>         if (ret)
>                 return ret;
>
>         ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
>         if (ret != -ENXIO) {
>                 ret = request_irq(ret, mcf_edma_tx_handler,
> -                                 0, "eDMA", mcf_edma);
> +                                 0, "eDMA-tx-56", mcf_edma);

Fits on a single line.

>                 if (ret)
>                         return ret;
>         }
> @@ -107,7 +115,7 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
>         ret = platform_get_irq_byname(pdev, "edma-err");
>         if (ret != -ENXIO) {
>                 ret = request_irq(ret, mcf_edma_err_handler,
> -                                 0, "eDMA", mcf_edma);
> +                                 0, "eDMA-err", mcf_edma);

Likewise.

>                 if (ret)
>                         return ret;
>         }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

