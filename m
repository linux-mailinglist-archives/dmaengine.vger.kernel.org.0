Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927AD46B070
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 03:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhLGCKf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 21:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhLGCKf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 21:10:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC93BC061746;
        Mon,  6 Dec 2021 18:07:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t5so50690802edd.0;
        Mon, 06 Dec 2021 18:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xh3jbz1H5oyvdrVY4iMt8Ki42g+iYpXie4VFb+QH4Gg=;
        b=cDFpvNLehRCIjKJjQDZ9K1BhWxYfF38JwgPlH4Go0etmnyubIMWOpQUULkzxMdIDmw
         URTE71EjO0sDuu0Z/vx1LD1pzaWlnU2fhr9YlFrWUyiXlNTMa/dl4tMztryT5N6CdQ2J
         IWuHxPLZY8el70eSfua/uwnPtP2M9bGWgP05ZGd7pMV+i/QZ8yTDBEt2/+cmjEpmcy5a
         JlFDEwYExb8nitAEhytZra2ssuFjKjMNYGtHkgRrqESQ7g3pQvMQfLLbQC/5DK9I8Oy4
         P3lXlYtgf6RrldvEPLGDVF/t57lnrMEHII8mqrsYDnPQdOdFgj68gw5XHoY5Y2Mam1pk
         2WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh3jbz1H5oyvdrVY4iMt8Ki42g+iYpXie4VFb+QH4Gg=;
        b=ee3HGY6TGbuXxIK3xtyT3sAS6FrXLrOH7jd/hBS8ZKaNXhpoq9KALzIgZdARbmh2fh
         cF3S84pZ+LPJOkvdcTGutlP5UcDrgUQHI7kXsmHV7+W8iKHhwBrhwK8hdFLPaIBxxsd1
         fj76MY4F+W76lnYis8UBLS3ybQn06bby+tY1S7wvb51CYGl9lHEr9zxoc4qHRJbxhluM
         FIW7TsjhNUsQvEhuqyhvqrUWj9WZK1XRyMDgyIBsXVjx2HjGTtt4uuW8L3H6K2UvzEjy
         m/iJ/RCoo58X3mOejBg60GS2mzgwAW8Iee3iJ/vckkdCprqQ5SUiskpq2ohVlu1zvkOm
         X9Bg==
X-Gm-Message-State: AOAM532IoN3SVC+rL2obBMT6l2SVaQbOqu9YtnBnBw/nQV6COF3q4IGR
        EJ0N3S0qr1I/Hwco036lo+PlWYiYgu7QV0fOhvZW+JeFYaJa1aki
X-Google-Smtp-Source: ABdhPJwNkpwjPH7wJQrwZQ2Sh2JsnuFbohsjM04gBk5AkIftwEJsgDzTgw43j5xFY1ueZrDE1ZlvEGTVjGHTVwdAtpk=
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr4332389edc.373.1638842824139;
 Mon, 06 Dec 2021 18:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20211206113437.2820889-1-mudongliangabcd@gmail.com> <CADBw62pSJ=rHjwTocxeeuCgtadLKqz-U7gAQek5Eo_bBQSzBzQ@mail.gmail.com>
In-Reply-To: <CADBw62pSJ=rHjwTocxeeuCgtadLKqz-U7gAQek5Eo_bBQSzBzQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 7 Dec 2021 10:06:38 +0800
Message-ID: <CAD-N9QUsOvumgVMJmjHF6vx92VGx8_KpAuqROkMrDYrqMyNfuA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: move pm_runtime_disable to err_rpm
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 7, 2021 at 9:38 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Dongliang,
>
> On Mon, Dec 6, 2021 at 7:34 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > When pm_runtime_get_sync fails, it forgets to invoke pm_runtime_disable
> > in the label err_rpm.
> >
> > Fix this by moving pm_runtime_disable to label err_rpm.
> >
> > Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
>
> Thanks for your patch, but looking at the code in detail, I think we
> also should decrease the rpm counter when failing to call the
> pm_runtime_get_sync().

Thanks for your reply. There are many different pm_runtime_* API.
After I double check the usage of pm_runtime_get_sync, there are two
kinds of error handling code:

1. When pm_runtime_get_sync fails, call pm_runtime_put_sync and
pm_runtime_disable [1]

2. When pm_runtime_get_sync fails, only call pm_runtime_disable [2]

[1] https://elixir.bootlin.com/linux/latest/source/drivers/dma/ti/edma.c#L2402
[2] https://elixir.bootlin.com/linux/latest/source/drivers/dma/ti/cppi41.c#L1098

BTW, is there any standard error handling code of pm runtime API? Or
the majority wins?

>
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1210,7 +1210,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
>         ret = dma_async_device_register(&sdev->dma_dev);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
> -               goto err_register;
> +               goto err_rpm;
>         }
>
>         sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
> @@ -1224,10 +1224,9 @@ static int sprd_dma_probe(struct platform_device *pdev)
>
>  err_of_register:
>         dma_async_device_unregister(&sdev->dma_dev);
> -err_register:
> +err_rpm:
>         pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> -err_rpm:
>         sprd_dma_disable(sdev);
>         return ret;
>  }
>
> --
> Baolin Wang
