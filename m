Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF15878063F
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 09:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358139AbjHRHTk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbjHRHTh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 03:19:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426621BF9;
        Fri, 18 Aug 2023 00:19:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so818675e87.3;
        Fri, 18 Aug 2023 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692343174; x=1692947974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3WLOotOOz6Whg1Mj8YD4tZ6eErSJfZzqhK5ewDoU7mk=;
        b=IajLjVccbpcsXfF6OU5/ko/nIqNPbKcFd6e2aT5W9pBlW3XQUm0m8EFelVlZe6qRYL
         hWfKGC6zkHirHD0Vk6UA4I7/2OUev/lpIE9w4wAGxOAcRDp9fy8tvwY3PaRb713hq5Gl
         Ys5PXLIU5EDvX9oI3MBIkzEaQc7cILrdOSuLwl1tEdn8tlxG3g2fibsJ/q6uhZAu2ku7
         aE18AjUnFuVL9CSUtFtOHehtPsngPwBUaJYyEiaOqsSEZyqN18nC2K89Z4vNHRSAU4rp
         RAR3IFqyKlGJRvP7D4qX+wkF2V7I7PY6OmNwO+F3SO9HC6Tuim6u5wHSzb3xNeRTA52I
         RWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692343174; x=1692947974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WLOotOOz6Whg1Mj8YD4tZ6eErSJfZzqhK5ewDoU7mk=;
        b=atEptMD3iwNBsrwlSX/EiG38Bz+/iVDYjlCylTkOoeM3OQxgn1tSHsJ/HStdU2gatp
         7GTyOSpNe7NhiaumNgc29HJ2/6lQmtepNH8O9dzdK2eVZeEwlj0Y/LQqemnpq6gng32t
         QqOtFjlXSN50qi2HbIJ6gYOUkGSxDfVU+71PrnN211RpGr6KVLH9h+RAICOEtm8gLA9d
         oaN85U5YFHwjLZkC9XiTIRzzb5y4y7GS6IsAX0KnSeGc3aC+F/WplqbjzFGAKbHH8W29
         7sH8Ln5GuNcbI9Utm0piWuR2FU81JHKiP5xSAopCeRD/HgRtLPx/bTR/A+3FEApcr1BU
         R9gA==
X-Gm-Message-State: AOJu0YxV6lWjoEMFJKKWneMlZmXIloqao0TR3DmzioNYKcDKRNo4z9YH
        PqClBnowwzdOJsjD4Ys5E04JLokt56a/OgV6Jic=
X-Google-Smtp-Source: AGHT+IEH6Jq48dkRZ4ezmCDNiEhdIsVUoXZNVTgzFF8vUlSHsXfot+cfT4CogWsvKA/tHn7Z/98bxJ7Qo34oYIi4M4s=
X-Received: by 2002:a05:6512:2202:b0:4fe:ef9:c8d0 with SMTP id
 h2-20020a056512220200b004fe0ef9c8d0mr1268562lfu.35.1692343174179; Fri, 18 Aug
 2023 00:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230817235428.never.111-kees@kernel.org> <20230817235859.49846-10-keescook@chromium.org>
In-Reply-To: <20230817235859.49846-10-keescook@chromium.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 18 Aug 2023 15:18:57 +0800
Message-ID: <CAAfSe-s_XMzqMLsGpvZoeDBm8+ugJwTYoCDC7g0Yx4dJgsJ6wA@mail.gmail.com>
Subject: Re: [PATCH 10/21] dmaengine: sprd: Annotate struct sprd_dma_dev with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
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

On Fri, 18 Aug 2023 at 07:59, Kees Cook <keescook@chromium.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct sprd_dma_dev.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/dma/sprd-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 168aa0bd73a0..07871dcc4593 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -212,7 +212,7 @@ struct sprd_dma_dev {
>         struct clk              *ashb_clk;
>         int                     irq;
>         u32                     total_chns;
> -       struct sprd_dma_chn     channels[];
> +       struct sprd_dma_chn     channels[] __counted_by(total_chns);
>  };
>
>  static void sprd_dma_free_desc(struct virt_dma_desc *vd);
> --
> 2.34.1
>
