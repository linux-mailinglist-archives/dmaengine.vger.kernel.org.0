Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD7771CA6
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHGIyv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjHGIyg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 04:54:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A8172D;
        Mon,  7 Aug 2023 01:54:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so5566005a12.1;
        Mon, 07 Aug 2023 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691398473; x=1692003273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKC5pozmNbi7bRXDlqmnN9fGngspiSZKCCOkhVp+rsg=;
        b=XxHQ/9lo76FtrGWDCOBAx/6x9lgdMCI9lHF7JOW+A52xiK7gPxym0xUakREdraq1s5
         Lw5JK/Rr+GLP5ij4IAGE0Aiv+84tGQ1PyMiYy43kSsgDWbWjmSHGnstYvJ0MFWmJ0pTu
         VP5rtQP4zcZ3zSWY2xPzjcPYYE+u4VKjg1YafZLtDG+q3jlysaznaU7bZKftHUl4PzZB
         FGzDGjZnSUiDYi8tjemvSyt3rwzYAfAiPMNEaN0AOV2/Bizu7LRDqqTzGIbpN/KGEfq4
         2SNMi37WPpvOakljmBhHGsExCTL0cVA4hPBDm79hVqsktUjInBM0CY8tCTRjMOsTpJRr
         vwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398473; x=1692003273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKC5pozmNbi7bRXDlqmnN9fGngspiSZKCCOkhVp+rsg=;
        b=M/oA9+yaxMn5LAs1vpyZ3Mf9v2Jssc/qoHZAWQ8iQgu7e3k6ysz1bPpLq666/umYFn
         ESEEOM5NyO/5Q5XXTqsyevKYWCY6FBuQtFOvd7JzkKRArFMoBpkk59vwhIBgFGtIrq4k
         ZzYgi/YA2NEskEjxK0YkN+sthfsHSULA18gHtZFYlbqq0fw6tZUT2o+jU6Q0qh67NiJp
         3gnCiqhyaunR4EyHgw1Hu9oEk3wskYUjz3/dvz7RSouQpQogW4m6ceNXEplnjmLcLZf7
         fRrwwyQN3niWxrwAeSjB69Aqrc34os3fK0FlI/KPnZeY67bPcl9ARC7dRWLRIOYvjEn/
         Bo5w==
X-Gm-Message-State: AOJu0YyIgxZn7iXvZyMocXqT1r7+ObLodhstHFxoh5l1ttQHbdKgz9TS
        V27/dtwa/yEtVI5LCJ6BvhSNDtSZvK3huyCzbP0=
X-Google-Smtp-Source: AGHT+IEjFCFKrTRpAtdiqwrFe/ziaRlFKyptgXp1jm78OQ2pEN6f4xjVsBjGOSBwnGYslaul0NHKrC939QlLUwFfB0M=
X-Received: by 2002:aa7:d7c7:0:b0:523:2df6:395e with SMTP id
 e7-20020aa7d7c7000000b005232df6395emr3319157eds.31.1691398472945; Mon, 07 Aug
 2023 01:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230807051907.2713-1-kaiwei.liu@unisoc.com>
In-Reply-To: <20230807051907.2713-1-kaiwei.liu@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 7 Aug 2023 16:53:55 +0800
Message-ID: <CAAfSe-vDVCUK_OGkiwsvOJcrtvr-TVu6aLYvdoYHxjGu11n0-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] dma: delect redundant parameter for dma driver function
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 7 Aug 2023 at 13:19, Kaiwei Liu <kaiwei.liu@unisoc.com> wrote:
>
> The parameter *sdesc in function sprd_dma_check_trans_done is not
> used, so here delect redundant parameter.

Please fix the typo, also in the subject.

>
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
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
