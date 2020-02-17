Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892401607E1
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2020 02:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBQBza (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Feb 2020 20:55:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34605 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBQBza (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Feb 2020 20:55:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so6388772qtq.1;
        Sun, 16 Feb 2020 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qDOmCXFTgruSYsln27jvW69b87aN/svbpuiBXSYyss=;
        b=fGMnmElS8wotL0yxqURfAcjh9g48StpNQichZx9J6ytEfLAWg+yn2Ps/V9HpduoOPM
         fEY7USeLncQDj4SAvHyhCrHSxuqHPM3qBHpZ2VHXYdPqPJDgsQp+NBHSJw9PsVfWzeUI
         JkHl4xnILKYj3qKt0Br6v2WHKlFWrtGrxxuC6ZfwhfPJB2N1RUPY82uCGjoAr6OAVsO7
         SGOaE02pKi57j7Rv9/FDX2vCg5pLFYYMi/4jGDiwHZywLZf3rbzUPmrs3T+wI87XNK12
         RF41cHCDGjB60WxIsWPbcRrWnETTIoM5cU0fxM/JriptNyujA6NsjUOmF/kIB6A5T2R4
         3OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qDOmCXFTgruSYsln27jvW69b87aN/svbpuiBXSYyss=;
        b=kavsNIzLC8IwyPRyH8azIAuZpcr9mUbgFXv2Yw6jyU6zi/Pryz0f/JOeS7Tbd87dWM
         wffPETGDVKygkbOcTc1IhmYdYH+CsasEUm1Mt6DTLwdRuKpgAsHiHdZpY6bMDothyfYm
         /J5q02Tx4qJ3fQkjgOLPnplJyVIq1ZqU2j6GhKD8tyO1ifRQuZ9z/L74j+EbAb/XSNCx
         u0pV68Tvs/eyUR4dPwWChBQJtbvnFJcmy92dIjtcQgiY28p2wdizSiGQnQpXRVXBObG6
         l/YBrQB2FGfZdgc2OcAYTiFKVIlDL81VhT5It0v8q43gLmk2RQK4qIsOvqSPEwkJ+6s+
         QBRw==
X-Gm-Message-State: APjAAAV+pid8DDfrWIMmjLVxqwa01Jn77u2vblq1MlvUZBY/xi1obGnX
        Yp/rCoTbzOu/q27ev35vbcaoUONqnTKun0YR5qrwKn4+
X-Google-Smtp-Source: APXvYqyv1gfJ0LbH1O5DNLLzXVZ1UT0EvQ8/jiCTwYsJeHfOHBmflFZOAM9c+S7Rcw7de1oOMCwZt+0N0BkRe6umPCk=
X-Received: by 2002:aed:2202:: with SMTP id n2mr11926482qtc.4.1581904529345;
 Sun, 16 Feb 2020 17:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20200214171536.GA24077@embeddedor>
In-Reply-To: <20200214171536.GA24077@embeddedor>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 17 Feb 2020 09:55:17 +0800
Message-ID: <CADBw62qTu2dGL+dGgC6WzsSusVfDKxUdd57f_1jn_A-Vf1-rrQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Sat, Feb 15, 2020 at 2:04 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/dma/sprd-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 9a31a315dbef..954eff32cc05 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -212,7 +212,7 @@ struct sprd_dma_dev {
>         struct clk              *ashb_clk;
>         int                     irq;
>         u32                     total_chns;
> -       struct sprd_dma_chn     channels[0];
> +       struct sprd_dma_chn     channels[];
>  };
>
>  static void sprd_dma_free_desc(struct virt_dma_desc *vd);
> --
> 2.25.0
>
