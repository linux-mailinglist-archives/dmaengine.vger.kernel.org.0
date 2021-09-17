Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B740FFAC
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhIQTOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIQTOl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Sep 2021 15:14:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74072C061574;
        Fri, 17 Sep 2021 12:13:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t6so33703882edi.9;
        Fri, 17 Sep 2021 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sAOASI2zHnMWQ6iN/cB/o9SsDokLlL5xajx85WFV1c=;
        b=OxYHOsnmPhV6lwgY0B6aYj3Z1JbIGmruoikWkx5mmZsPhacCk9DJMA9OUFSf/2pMwV
         xHMIXYLTJZGbemV2o1SjfhFj23jd5w24mB2Qyt2J+GAd+Fw4hqevYLQiAo1oIr9skMzt
         NXz8pwLxAMvbuXihkYEslBfdRBrX1DAXZK2f7R0Ucg8vPR28BBZP5oyazZgzUMwVMzNe
         /wYNxPWeOV2Elu2r3zmq5oK1ouKB/5jDN1Y4B/aGgnUEfqbymQ3FQ6mPdcyneCxAdDLD
         FM41tKo5Srqz6ju8iT0SdSh9jwsWKL/B5zFjYLHT8tROfIvg3CtGugMmqYH3v2j+CMYR
         M82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sAOASI2zHnMWQ6iN/cB/o9SsDokLlL5xajx85WFV1c=;
        b=BV7lpt9Iy5zdWgpKYGGbz0l71wfTwtvXaBJopni4qXeCMFjd6NSzlYZQGKQjwn+fVk
         SpMazUoHLpuEHTlpp57bnJH8lnuDZ//L6I17yX9GLQHOaYxVQxbRQZla7DDrUHTmmFiI
         7QZ3l215+9nil98zug1xHXm+xpFen6ZKbJSJgZsondAkC6sM4bNJTzmGv9Vzw34SjMEn
         8g8za1pv+hm2OFDMjWE8so0+T5xIA8RRlSVOXK9Hb18mPmhJu11XzCAoCwq1FN1BQL3h
         v1o0QpJsIU8sPdbPe5fXVfq6A/YKhYqwfQQ9wnHLKdBpEOJ9H80wlinEeVFLFOFAP43p
         BbdA==
X-Gm-Message-State: AOAM530mvHLdxj+HYaeB9K/dKXXbE/Bpmz37KNQeEK7KIYd0/nRwe+Nj
        bw2KTUzAMKSjEWtVsADvi0jFRCHY5KIIQ/6ZL6I=
X-Google-Smtp-Source: ABdhPJxSMqk/1+/x1KkRPd369122/U4ibfC2txOno0TIxA7VLymUniHB0ltGmBQnBZbD3mD2pMiB2MMS2cSOP4++PtM=
X-Received: by 2002:a05:6402:1395:: with SMTP id b21mr14596400edv.119.1631905996953;
 Fri, 17 Sep 2021 12:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <1631863065-10181-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1631863065-10181-1-git-send-email-wangqing@vivo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Sep 2021 22:12:39 +0300
Message-ID: <CAHp75VeetMDBur6tcf-=VXuxch1NEXV11y_qEcqSuBz=OZJL_Q@mail.gmail.com>
Subject: Re: [PATCH] dma: dw: switch from 'pci_' to 'dma_' API
To:     Qing Wang <wangqing@vivo.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 17, 2021 at 7:37 PM Qing Wang <wangqing@vivo.com> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below.

> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)

No need to cite the script.
With this addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> updated to a much less verbose 'dma_set_mask_and_coherent()'.
>
> This type of patches has been going on for a long time, I plan to
> clean it up in the near future. If needed, see post from
> Christoph Hellwig on the kernel-janitors ML:
> https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
>
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/dma/dw/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index 1142aa6..1dec1ae
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -32,11 +32,7 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
>         pci_set_master(pdev);
>         pci_try_set_mwi(pdev);
>
> -       ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> -       if (ret)
> -               return ret;
> -
> -       ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
