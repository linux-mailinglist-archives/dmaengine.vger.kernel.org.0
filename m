Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63171DE6F8
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEVMeJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVMeJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 May 2020 08:34:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731FBC061A0E;
        Fri, 22 May 2020 05:34:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so12471132ljo.0;
        Fri, 22 May 2020 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eL8Nvkl6Jqd505Lrrd1U/0zX/XLAbGUHnr3EvdpPX9Y=;
        b=KM9eNhY7gC7xlUELLqQ8ozhDetqCIUE0C9ZTdvsHPEn2bL0AQYYOSP//1eWA0U3ouo
         A/NHKeKen202i2uIlPczj6xfOAi8lCAgqLrSBf05C7Do4TNDgc9usZGxAEKfI28OpetR
         Xt/jjYyyDD7PTXna4AekrLyo++xfXRo6Qp40PNujlxU7ik4g3f8TIP5yq/lKCmWeqjB4
         5toL8Q8jsmubnl5SE2yiioU7rom71w+yuMEx7Z7HkZCjskYgG6ogkk4Wtu7WVb35MynS
         0QGpLErRTWZZE4zY0nITVocl2QQSCA7YvWKe6d/UkBJpMme/U6q26HRfL174QF2s6Bo0
         8Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eL8Nvkl6Jqd505Lrrd1U/0zX/XLAbGUHnr3EvdpPX9Y=;
        b=P02et84XkQOyyYO3c85QvOtjmTIL0Tyyw9J6u30zhIK6WZ1T8uh+MBjI72pbCdbPf6
         LCjCrJhVJtq19CEExUSIRyaPdY+xR8ndyc9eLdBMgcIqm3ryi9CMfAl0Z2F3h+nYjJVB
         FsuIhOK9phxMdnXOHhFIUfjPnc3QsHArKS+gBCmYf19D3puCEawskMEIBqvIP/tbHbf5
         ++vNIu0FO3lktZ205GfKQn4sCa0xyq0s44Zs1IdXKvec/OWv7RC96FlMQ8J7WQBpLIc7
         OnP0Ci3M33OfyR6famj3/6pAko64+ZsTYJ4sATt31bCiQXwBPlAWNNWphcpD12e7wdgC
         vMLQ==
X-Gm-Message-State: AOAM5308ocn7tGfsKUDrX5MDR3SncyQVNhphnpla9FDffCC3cVb0iQjS
        5Ake3RY+XUFMaaOU+jTPPs6EHWjY7ilrj+nsw4w=
X-Google-Smtp-Source: ABdhPJy0qbrKFhq2DTmr289nXFw7VgMAGyKyRIGU7V2kjdEOSEEAVwYnGjNg8RSoz66oTuirsQTEuDWTLA3AZQJEjrk=
X-Received: by 2002:a2e:8347:: with SMTP id l7mr7457609ljh.243.1590150846890;
 Fri, 22 May 2020 05:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200522065243.19590-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200522065243.19590-1-dinghao.liu@zju.edu.cn>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 22 May 2020 20:33:50 +0800
Message-ID: <CADBw62oUW7-f05nHX1-cQM+tqyAVVt-knihmiPvekU93L=bLjA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 22, 2020 at 2:53 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
>
> Also, call pm_runtime_disable() when pm_runtime_get_sync() returns
> an error code.

Good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/dma/sprd-dma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 0ef5ca81ba4d..275d83768d0d 100644
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
> --
> 2.17.1
>


-- 
Baolin Wang
