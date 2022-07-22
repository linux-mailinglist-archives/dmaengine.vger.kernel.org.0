Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3457D80A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGVBg4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVBgz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 21:36:55 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1F2BB26
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 18:36:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f9so2582572qvr.2
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eY7F7S2atZ2+Ql9EgNiFNHb7lG8NvHIt+0m/D4V0p78=;
        b=XuCqQjCGDs79QvNvVWwH64ZZwrMjYbZQvecKKSLasbTY4fCZh9pa3iS7klWDRPU3Hk
         XGbYduc9KydQHZ237qGmk48i5WflrI6Wtafrfn0M1fCfpm0mg2Sr1Ex6+rxGUsYoSmtU
         RqFradCiqk+4GkOzbOAw0ytw4EHaRqoQIG8AkBo7+g3DMYhbi1Kd5gaWTQDZa5VF58Yl
         WdoDdF8Esw9wFDpmVkglcJjXmVmKuecLoOoByeqrfchz681THjhnhyqQuqcdAqpzKYY7
         +4UK+g0dzxF0z22ZYljD209rnOWsrluBQR7VHakE8E4Dbx9p5+NRsytysgc7KH8cv1VN
         mDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eY7F7S2atZ2+Ql9EgNiFNHb7lG8NvHIt+0m/D4V0p78=;
        b=mC42oy/IoCph4UPYePDSo12FulRt4rm9o4K+Nd83gcAO02zFlkU6tbHTX067F3o3sQ
         zc4GdvVEDpOkA4MEB+QqzTrYE2ahvmTdXDWnycAqbf+0kIipcgJYmNbeAy1bijVf6HYz
         ZBLuSunIYABKWkCf0chWh07QsTKxriRBTvOz0MYvttK+cLpM4vspPN4UJrRkJWqChPRr
         ehsMBpJcG5OPQMRpTYxF/BnBu/w82jW/MaN7ruKvr795qvm8wGsUdB94wVJlCf84a8ma
         pe+EvZH7bRhyBB2WUEk2el65f9QVB5YvvLlbsEwRhxDphE/JjW0Gs6IvHhniylJq4ICa
         kp1w==
X-Gm-Message-State: AJIora+69ZRRpyXDAdzLLP93CDXGxXGk+gNf+OIJ8D+0w9yoGM8zD75R
        RBVh9yWJOpKCrQLxj6psXl47ulxB8L+oTfQmq0cqcxPd
X-Google-Smtp-Source: AGRyM1sHduTdsPcuqMQIiqEi7IsYhFDJ93BOLzXnoU5pBBN+21IF6Ds8PefEUt1xJYqoh/9m/o0jKLlxjU6ZLdhBTh4=
X-Received: by 2002:a0c:9022:0:b0:473:5be3:321 with SMTP id
 o31-20020a0c9022000000b004735be30321mr1239128qvo.79.1658453813775; Thu, 21
 Jul 2022 18:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220721204054.323602-1-u.kleine-koenig@pengutronix.de>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 22 Jul 2022 09:36:44 +0800
Message-ID: <CADBw62pM3ZXQsPEBhPYUmSXmcFzurLN2NKaxATFo4BuWh8ZbeA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Cleanup in .remove() after
 pm_runtime_get_sync() failed
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 22, 2022 at 4:41 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> It's not allowed to quit remove early without cleaning up completely.
> Otherwise this results in resource leaks that probably yield graver
> problems later. Here for example some tasklets might survive the lifetime
> of the sprd-dma device and access sdev which is freed after .remove()
> returns.
>
> As none of the device freeing requires an active device, just ignore the
> return value of pm_runtime_get_sync().
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

It makes sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/dma/sprd-dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 2138b80435ab..474d3ba8ec9f 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1237,11 +1237,8 @@ static int sprd_dma_remove(struct platform_device =
*pdev)
>  {
>         struct sprd_dma_dev *sdev =3D platform_get_drvdata(pdev);
>         struct sprd_dma_chn *c, *cn;
> -       int ret;
>
> -       ret =3D pm_runtime_get_sync(&pdev->dev);
> -       if (ret < 0)
> -               return ret;
> +       pm_runtime_get_sync(&pdev->dev);
>
>         /* explicitly free the irq */
>         if (sdev->irq > 0)
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> 2.36.1
>


--=20
Baolin Wang
