Return-Path: <dmaengine+bounces-5712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066AAF1191
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2ED1C25A1A
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8A253F15;
	Wed,  2 Jul 2025 10:19:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8224BCF5;
	Wed,  2 Jul 2025 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451553; cv=none; b=CYCbWGEyrUUJxglso74PYdiggwaOPYZdisJA8xPSi1thkkVDDIUezhQAU1ER5GX0G176569wN8vEVs3VLd9a9u/DXkJ1MoVq062ERQx9IjUvMn4wM3O5nn7xFq2a0IYmwsDtOy+fdkJqHT6dc5SnwILDgzc+BHEyxlXrcrBnCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451553; c=relaxed/simple;
	bh=GmPP3P7NMkynjb1/dYzzh/uEXHkmc1XZUkN/yrIBi/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKckFBt/NqfdjVol2Woc4MbzberMIN1g53IaORYVIAEX1/spIcr/A5GO81qCkxKAbFCXRn022piDSXjbk7yCVsFdZIZtL8dx7URFlE0o1xUaSXqA7cy0axg83LqowJ1iXoTkRr+PxWoorJYUTKTAE3xAbZbOfc+yMDHk3QsmEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5313ea766d8so2176605e0c.0;
        Wed, 02 Jul 2025 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451549; x=1752056349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tifjm69XZzbuybkFrvZ+2y7FSvfdb3h+AfJkHZkPX/g=;
        b=NCP7GZbo+M70CSSWhMBDQHdsdgLutIF2MTftMS0R5yVfJf7wHZvPerbG8H3OgohzNa
         aqnrt2htVBVYEWq5SzR2ZF/gUrEE4xGK/fR1L2d4w8eYlUZZKPXpk42D6LYf4yeXG1/W
         WmY9jgfU1DVhPzCi4yyHMekOCLhKRsgfNZOXjWo5KQtJbLhshh7E7s6zb5ChKTUNKeuA
         5NTd0TaicfwQ1/2AzJTd9dHDABi3rdMGWD7mk8U7FMDbM56qDZ+Z1gxCZKC3hea6Q7Vf
         S3OaZOdfE80KpuWCb8Z3A9zy/0bCk3cKacgpBs3cVgAexML+NgXVd9QIndFoUeNOVC0D
         BdmA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGCK/y/L/G+3B+LFLy+yhvelnI31ZsGHvpqy4VIUr4JX19f1ZxP8nVoTN+VLuVKqS7ZFv4T5FN1B4YATAn26K6h8=@vger.kernel.org, AJvYcCVnk5c4tvPGVmlTrH15Vh1A7jIw3WwJmvnPCsOvul+EPPLy1yjYE1ZA3jgB3UirnTqtWOEJpyiTj9EVZ6J8@vger.kernel.org, AJvYcCW+BJOQlwK11AzUbYmLouYkRqTEZGiTk8c12mXtAEe7mDb5wwW/vQmsu2HrpwryByJdqbKBfFeb7nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtBC+aC24kBV+LH42fNbt1QUTcBFAr5MQyW1bBM3XmWdJjSMV
	rLik7nGzuDx3EayHB7DNy3rmU8SpVkgq8mkDMwY442NqoN5biVOUUPfDqpxBeHmb
X-Gm-Gg: ASbGncv5KLq3q03bwqr3KIn4pk8QnXQu11/qoDT7ijROFwzLDALkhIKCxS4zXPUKHCJ
	qaL20GHWhjhoIXrgUWB/QBJqVGgU7l7KO2z5kHSEB4vWmqDI40m8CPZZLOnpprO92NkP0xxxrEP
	uepYJ+zx68X8nclMVnjnROcpFuQqC+5Y2nuNw3yXmCdnon3CjfQfKeNgjjlj12ONUdb5zVjdzNY
	FOO38hI1EaJqAck7o88wTYMlIrSJWO6UoauH/gOobEdjsOX2ihlKU7p89kGqk9H0nf6nrof3sDg
	nckbLUy4Nd6jEdH4PfQhfUiMo2xdAGRWmRbqxJ/lletGK+T4jCdvQrd8N9VoKtF/ES3u7ef0q/f
	6ZtJpY4R2dsCWNgA06zvUrlDB
X-Google-Smtp-Source: AGHT+IH6yKH2sZzfh2mezbyy0OC9i9G2+2qhTirxVg6dIG6UOYC/H0xt+/HbEpYrml5YdyZCkUllmA==
X-Received: by 2002:a05:6122:1784:b0:530:720b:abe9 with SMTP id 71dfb90a1353d-5345837dacdmr1486473e0c.7.1751451548940;
        Wed, 02 Jul 2025 03:19:08 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884ee766fe7sm1540892241.29.2025.07.02.03.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 03:19:08 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e9b26a5e45so2647538137.1;
        Wed, 02 Jul 2025 03:19:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXNJ+Ah/ps9YRxVrTj/RcSsNczxX9iHs4pt42g6LlB2F6Gp0mijtkR3bLUljkMVL5T/cdws2JxaTS51YFU@vger.kernel.org, AJvYcCWplPlPEChMxRc3SeZdly8w85cTfdB8DJFX5zJhB4bMUPfZ3oN4iWqDEu+1IhyjN5T009A+tCcvcjQ=@vger.kernel.org, AJvYcCX8aMXw1U1ex7IqqpvezpKiNazQGxNIcPa5G4qxxdABiIQ93iP1nh/D/GwZRFpdBqkwNVrBFZENLtd+pe1Gj9X8x7o=@vger.kernel.org
X-Received: by 2002:a05:6102:41ab:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-4f160f69075mr818743137.13.1751451548210; Wed, 02 Jul 2025
 03:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
In-Reply-To: <tencent_71CC9630D88A8792C2396A8844DCCD5C6D06@qq.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jul 2025 12:18:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhZqLCkLWtFTaCq67=Nb0O0_XLSWeyweMiNp25XArfKA@mail.gmail.com>
X-Gm-Features: Ac12FXxgqZ3A4cNQ8wmJ2xcMFp9VGDuQB0YEgiZ8HQzvthHYRBjWbnlsj94X_K8
Message-ID: <CAMuHMdUhZqLCkLWtFTaCq67=Nb0O0_XLSWeyweMiNp25XArfKA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix PM usage counter imbalance
To: Zhang Shurong <zhang_shurong@foxmail.com>
Cc: vkoul@kernel.org, magnus.damm@gmail.com, robin.murphy@arm.com, 
	ulf.hansson@linaro.org, kuninori.morimoto.gx@renesas.com, 
	u.kleine-koenig@baylibre.com, dmaengine@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Zhang,

On Sun, 29 Jun 2025 at 17:57, Zhang Shurong <zhang_shurong@foxmail.com> wrote:
> pm_runtime_get_sync will increment pm usage counter
> even it failed. Forgetting to putting operation will
> result in reference leak here. We fix it by replacing
> it with pm_runtime_resume_and_get to keep usage counter
> balanced.
>
> Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1068,7 +1068,7 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
>         if (ret < 0)
>                 return -ENOMEM;
>
> -       return pm_runtime_get_sync(chan->device->dev);
> +       return pm_runtime_resume_and_get(chan->device->dev);

Note that there are other issues with this function: in case of failure,
none of the memory allocated before is freed.  Probably the original
author assumed none of this can really fail.

>  }
>
>  static void rcar_dmac_free_chan_resources(struct dma_chan *chan)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

