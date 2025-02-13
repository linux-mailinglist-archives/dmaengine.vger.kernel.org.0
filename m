Return-Path: <dmaengine+bounces-4459-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36FA341BD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 15:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A71680CC
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614F281360;
	Thu, 13 Feb 2025 14:19:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488DD281354;
	Thu, 13 Feb 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456391; cv=none; b=Xa4Sv229FoeffIscTM9euFw7lfNTScIdauNbP412K8elD1eH2+t+ctiX5mM4yc0yPcOotlM6ve5XAwMMYu4bhFcXcjP9AB1eXbumnYRbfvegRw072VofgOAhrE4CzoLtL2QoIGDqG0NogSw/CEh2nKY4nZH6oF6uB/hQxHabiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456391; c=relaxed/simple;
	bh=kcfzRyB7d+jkNAmbBhItOyDp+yO8awGgb309RySNuIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELpuLICSuKCqhPnEE+SJOdPdDyRBSVbrAeEAlALjnG2es/F7/uvgZlhzzAuE2MtJ7t361qT7UUQzHPmVM2yAPLXvWZgEEPgD/vqTWzbo/lFysHaGtCSZXVBLPNsGxXOG5a99cyb0BRwea3hBF1/nHq9APYGU2E7/CNy6vK5Ngjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso1878989a12.0;
        Thu, 13 Feb 2025 06:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456386; x=1740061186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2li/iFwwG857zpZZUsHmegnAlCfo3jQasy7lgqQ4O3I=;
        b=jSEqJL8w7fgnBcPpiiApZau4PSX0BSXZID9D3RGSkIy+QBiV82bGGrsLSHGltgtIzz
         MtN6x2qqfHd+nk4AXoG7ybuJIruy0AhYcU8QYNcg2dK+QbR0KSbtHJV6Lo0iimwnnfVS
         euj9KPuY/oskihtS3E78qXlwTtbmzhtVXMSrkD3xAJlESnHQOxgw8SfRWmhNEXzcAcQP
         gE3UTrdHav5DJLWANBDeI4wmLg2qwRquq3XGGBjspCqG+1/hOxOSChsBDyFYk6CE8hQ7
         SpemdCel8Z1hpXKCRxKxIuIQIwQmE9J1gynISdOjgAgeiQeKkf57OqMmUp7vAxTlPM9k
         zkiA==
X-Forwarded-Encrypted: i=1; AJvYcCUVmGuVJ4AoAjTGWx+yv080byPdkZtulhzl4AfVhipAY493JiWulztG1L2MkUJXSEeJYfrzEebXHcXZWFT+@vger.kernel.org, AJvYcCWBzncMtOiV5sg/b/7qYhF2xgG6uie2l5ojif6cPLP2ddue6Ug3foTMWJxxxIsZqrMjhIMHY45WXOELGBUymp/JYgQ=@vger.kernel.org, AJvYcCX4vkUNX3Is5eqnK3STflTi72cVNzYuYzMVVaX05tkHXHR2eA+0Jkb68ZX4MVf3ERgzupRUbzjxJo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Pmtd5sVUTbnsXHoiZs4Bs5bQ2udV2oTczfi67rpCddC+ACce
	WOu4VsIEwR3Y6AnUnu/+YE0fgresrmF9Io02rorj9lg3S6L/GrwTmhGNa5FOL40=
X-Gm-Gg: ASbGncuWIgeKr9TQbhMT9yHqH1iMfSkU6mxs8vC5dKDnW29n4Big7QrEMW4WdqHtYTJ
	zYCdvMPpGPfOyUDirXzL07/Khzi7PgRhxPJRH6EA6dBSyJFQ44AaFxfLm9zBLBIAUVTgUyJ/mRm
	RKJjSHV3Tl1aqok/GhnSuc3K9NtIwWTrI9ujn2c7GDvsqr/HiDXMuu7vQNPqh8LT9gnLNsTd0Hl
	pkRV8eEw8oMSki+aVKkbCsXZRuIfxLZx77vrpHHDKHDagxYsMPTrLgBOX75CEFEAcfOf7XH3h88
	7xmvXZm6Oyp6MTEVueOl9QpzZ2DU97Z3JKP91CSnJSms6dcoQyy5Yw==
X-Google-Smtp-Source: AGHT+IEVT3LjxXUFhWsEPlrgno9TZwtMPT0tDlhnND+692wauEZfcGttEPz/JnBEwIKfNVeueBGgCQ==
X-Received: by 2002:a05:6402:274d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5deb08813d5mr6103364a12.12.1739456386063;
        Thu, 13 Feb 2025 06:19:46 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4ec1sm1250236a12.7.2025.02.13.06.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:19:45 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so1651218a12.1;
        Thu, 13 Feb 2025 06:19:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi+g/i8K26bPdgMbs12Rxr3lUAiorF+NE4ecCX4oaDp7IaGuTcR2Ib9KMrXXNJkOqVJcMDYfoakTj4SMIh@vger.kernel.org, AJvYcCUwqqzUylEXPLUuxXiFNkOlBw31i/JksodDYQPQ+HzBH/4iu/9kPqAF2zrKz55yxnxwN5f8UNbzpPU=@vger.kernel.org, AJvYcCVQ1nB7WA7z14QZku4PLtGk9UUQ/8inpng8bgMIA4v2L5eTJ0e9IcpyDAXGpNM+Ow6BOjsY+PzHfzMZgmorW7FnE04=@vger.kernel.org
X-Received: by 2002:a05:6402:50cc:b0:5dc:7464:2228 with SMTP id
 4fb4d7f45d1cf-5deb086a58bmr6219048a12.2.1739456384491; Thu, 13 Feb 2025
 06:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com> <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Feb 2025 15:19:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
X-Gm-Features: AWEUYZkEZGs6z_0p9QMunNUP33hwAG9o5TLc2_GeHDZzynQyJ6NGt8iGLYSY0kM
Message-ID: <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Wed, 12 Feb 2025 at 23:13, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v1->v2:
> * Switched to new macros for minimum values.

Thanks for the update!

> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -53,6 +53,7 @@ config RZ_DMAC
>         depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
>         select RENESAS_DMA
>         select DMA_VIRTUAL_CHANNELS
> +       select RENESAS_RZV2H_ICU

This enables RENESAS_RZV2H_ICU unconditionally, while it is only
really needed on RZ/V2H, and not on other arm64 SoCs, or on arm32
or riscv SoCs.

>         help
>           This driver supports the general purpose DMA controller typically
>           found in the Renesas RZ SoC variants.
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d7a4ce28040b..24a8c6a337d5 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqchip/irq-renesas-rzv2h.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -28,6 +29,11 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>
> +enum rz_dmac_type {
> +       RZ_DMAC_RZG2L,
> +       RZ_DMAC_RZV2H,

So basically these mean !has_icu respectively has_icu (more below)...

> +};
> +
>  enum  rz_dmac_prep_type {
>         RZ_DMAC_DESC_MEMCPY,
>         RZ_DMAC_DESC_SLAVE_SG,
> @@ -85,20 +91,32 @@ struct rz_dmac_chan {
>                 struct rz_lmdesc *tail;
>                 dma_addr_t base_dma;
>         } lmdesc;
> +
> +       /* RZ/V2H ICU related signals */
> +       u16 req_no;
> +       u8 ack_no;

This could be an anonymous union with mid_rid, as mid_rid is
mutually-exclusive with req_no and ack_no.

>  };

> @@ -824,6 +907,40 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         return 0;
>  }
>
> +static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
> +{
> +       struct device_node *icu_np, *np = dev->of_node;
> +       struct of_phandle_args args;
> +       uint32_t dmac_index;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
> +       if (ret)
> +               return ret;
> +
> +       icu_np = args.np;
> +       dmac_index = args.args[0];
> +
> +       if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
> +               dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> +               ret = -EINVAL;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.pdev = of_find_device_by_node(icu_np);

What if the DMAC is probed before the ICU?
Is the returned pdev valid?
Will rzv2h_icu_register_dma_req_ack() crash when dereferencing priv?

> +       if (!dmac->icu.pdev) {
> +               ret = -ENODEV;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.dmac_index = dmac_index;
> +
> +free_icu_np:
> +       of_node_put(icu_np);
> +
> +       return ret;
> +}
> +
>  static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>  {
>         struct device_node *np = dev->of_node;
> @@ -859,6 +976,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>
>         dmac->dev = &pdev->dev;
>         platform_set_drvdata(pdev, dmac);
> +       dmac->type = (enum rz_dmac_type)of_device_get_match_data(dmac->dev);

(uintptr_t)

But as "renesas,icu" is a required property for RZ/V2H, perhaps you
can devise the has_icu flag at runtime?

>
>         ret = rz_dmac_parse_of(&pdev->dev, dmac);
>         if (ret < 0)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

