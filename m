Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1087A5706
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjISBhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Sep 2023 21:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISBhe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Sep 2023 21:37:34 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF094;
        Mon, 18 Sep 2023 18:37:28 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a29ef55d5fso1890288241.3;
        Mon, 18 Sep 2023 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695087448; x=1695692248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lh6VfMBqUnaXj5jke7hAbx8fy9jRAau4NPtcb8fNv3c=;
        b=BWIBB2KPEn+Vx3r2kqVBNetu/1yMtfOieIiic4A9Xxm9gmV+OwXxIJ+Dh+fEJyMNTz
         bpw/k4i9MHW5/Q31HzgYXINAllpuG3/OakWj7AvbE/q5r+X3ocPKarrsKDmc3C3Pz0nY
         AY4x4tVKDrvn1/Ob7OsWw/FToTUAaUQwJGeu9vrO+8H2W7jZahRNF1v2d6L1LcsYqvdf
         RuMJGti3cTqIn6y+FElEnpOwvG4B8EcvGVf7uodtfqjRQw08GTGD/iq3RUL5GMknRJSj
         Yaxj4aQeLfzcAbhjCtiZS8U9B2fwra1TF5oXH9GnzGyvNTT3C1qU73O30tytceu1DtTi
         Kbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695087448; x=1695692248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lh6VfMBqUnaXj5jke7hAbx8fy9jRAau4NPtcb8fNv3c=;
        b=TyF/AY9xl9HBHDFy1Y8FX7jV/6yqZnSfyvoCDftGh2ynXu2E5ch7+WhzgYD6IO9L0t
         gCPx7tbgFCGjpRCuhhFnWgibTyNGGF3lToSUFOiQ+h6f/wgUV0pdXlsT1DVmjV8u4co2
         ZlpZ+t3fJBymiEqBNM5MtWsOaE3p6eqplH1oNS5EaJNqyrG2yyzJJGBJMLX7o/o2+cgX
         cxQaZQ3JvSkOunJ3qooY3mIztGzTs4W4OuHim0oqZSabce5+D3Cz3zGecn6zIa7IEhhO
         X5U+zXlr+RIPl+WW+xUQlUapJV0Sl76pmJW/gPRL6oh/PhF56HBxN6fINZf716+2SGaH
         BiEg==
X-Gm-Message-State: AOJu0YwhOUHXALRBWeCupBxrpEomEn5E85eKCGIv4EOxbL0oh1pVtQ3f
        aw+UcQE+LAuAmZh1IS6lT4HHmyHLYvjq5jXupDxWBTz0
X-Google-Smtp-Source: AGHT+IFA8a4bUb0a/Ev2Rd8/OJ6VuKASJ3Xxp5azqktXFi1NK5wsvnGDUvguIT8plu0tAFPpLbbLiUiswwJiTOfIFAs=
X-Received: by 2002:a05:6102:73c:b0:452:829e:ac90 with SMTP id
 u28-20020a056102073c00b00452829eac90mr1843839vsg.28.1695087447853; Mon, 18
 Sep 2023 18:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230918120238.13132-1-kaiwei.liu@unisoc.com>
In-Reply-To: <20230918120238.13132-1-kaiwei.liu@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 19 Sep 2023 09:36:51 +0800
Message-ID: <CAAfSe-uAPTx2RJgvvVx=ORVHW8GjT9YCprgbsJ28bgT5-gkh0w@mail.gmail.com>
Subject: Re: [PATCH V2] dmaengine: sprd: delect redundant parameter for dma
 driver function
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 18 Sept 2023 at 20:03, Kaiwei Liu <kaiwei.liu@unisoc.com> wrote:
>
> The parameter *sdesc in function sprd_dma_check_trans_done is not
> used, so here delect redundant parameter.

There's a typo here, should be "delete"

>
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Change in V2:
> -Change subject line.
> ---
>  drivers/dma/sprd-dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 2b639adb48ba..20c3cb1ef2f5 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -572,8 +572,7 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
>         schan->cur_desc = NULL;
>  }
>
> -static bool sprd_dma_check_trans_done(struct sprd_dma_desc *sdesc,
> -                                     enum sprd_dma_int_type int_type,
> +static bool sprd_dma_check_trans_done(enum sprd_dma_int_type int_type,
>                                       enum sprd_dma_req_mode req_mode)
>  {
>         if (int_type == SPRD_DMA_NO_INT)
> @@ -619,8 +618,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
>                         vchan_cyclic_callback(&sdesc->vd);
>                 } else {
>                         /* Check if the dma request descriptor is done. */
> -                       trans_done = sprd_dma_check_trans_done(sdesc, int_type,
> -                                                              req_type);
> +                       trans_done = sprd_dma_check_trans_done(int_type, req_type);
>                         if (trans_done == true) {
>                                 vchan_cookie_complete(&sdesc->vd);
>                                 schan->cur_desc = NULL;
> --
> 2.17.1
>
