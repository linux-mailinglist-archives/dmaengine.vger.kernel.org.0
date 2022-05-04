Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FF519579
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 04:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiEDCbH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiEDCbH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 22:31:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A61FA78;
        Tue,  3 May 2022 19:27:32 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y3so14965036qtn.8;
        Tue, 03 May 2022 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TMFrmQFkZzJXs0cwG3llRYO40gersRxAHuIdeVczKw=;
        b=MPYQStz3F7gs+NS+obBky+v3a116Nqhgfu8vd/ba8VvZDeJEkw0dP321EaRLi3LJSS
         wl0hYBT32qL97fFDvbbK2Yu2pgL/18IG2lmJt4mCEva8dduro00UIhdn0H/BbdSTIxVB
         qRIuCXjxxjMwGkkAP3k8yNa6gICjnZMi7qIhD4XEF16VJCqSjUd59vW6SVhKpbGbrs+T
         hvmBvRI4ausbnwNypDW7Qni3MLdS9rGBxJzJ4D53zx9H//lNF/HSXL/Zk39c/2e9r+R0
         hJdUAMzoTfAJYQ93jGOaDPMXbZjHcj6UwSf5i6U5GLcUgELFInTgYASgYmQVNjWtDJQU
         JdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TMFrmQFkZzJXs0cwG3llRYO40gersRxAHuIdeVczKw=;
        b=6+VK2RJcqIFJH9UGp9ZuRcYA7W3vbWzimzyiTxfWxAEXW/37ce34p+oujouWbExraX
         eyIntoVdSEOkLIqhgsEiyi1w9gqBVFKAj2Smsw569/sPokECn6twjooveTgGioVnUUak
         /a0oFwwHRLsm9w+ShhmncVE5vNQPxHIZk2XHyReqbIhsmYy4wVOYQNgvGJhq+dFXXAbz
         Nmn595+iNHuliN6JrtzeidvcAPJXJcSJudKJl3pyPdMwADasihVNeVeZCB403HOyP1bV
         T4ROpuYjPlO3qcrSxT3lXZyCjXTjlqmEOM8hZTa1AtfzO1nY5e+hwzGNqxzJAg/QfZIG
         b5ug==
X-Gm-Message-State: AOAM532kGjEB7ipQsdxT6mSCYpviFxSnPAVZ/rv1JidrDWpoD78PDMi3
        V9Clsd+riVDZxYiDjlgCsghjFbeMYkHvQuiFqN4=
X-Google-Smtp-Source: ABdhPJzBGK4J+bTC0b95CQcgSrcyGH0M/ZoLDp3IE7JPHslKf+WtIo7YhlaXDcg3/fR1h7wKWEHE+y7VXkn0cDb1k4k=
X-Received: by 2002:a05:622a:304:b0:2f3:861d:5df3 with SMTP id
 q4-20020a05622a030400b002f3861d5df3mr17301958qtw.311.1651631251840; Tue, 03
 May 2022 19:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org> <20220503065147.51728-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503065147.51728-3-krzysztof.kozlowski@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 4 May 2022 10:28:05 +0800
Message-ID: <CADBw62pJfLH4ZfgXKoce_OwUrFKJL_e1aVVmJWK8TGaJhmA=4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dmaengine: sprd: deprecate '#dma-channels'
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 3, 2022 at 2:51 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The generic property, used in most of the drivers and defined in generic
> dma-common DT bindings, is 'dma-channels'.  Switch to new property while
> keeping backward compatibility.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/dma/sprd-dma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 7f158ef5672d..2138b80435ab 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1117,7 +1117,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
>         u32 chn_count;
>         int ret, i;
>
> -       ret = device_property_read_u32(&pdev->dev, "#dma-channels", &chn_count);
> +       /* Parse new and deprecated dma-channels properties */
> +       ret = device_property_read_u32(&pdev->dev, "dma-channels", &chn_count);
> +       if (ret)
> +               ret = device_property_read_u32(&pdev->dev, "#dma-channels",
> +                                              &chn_count);
>         if (ret) {
>                 dev_err(&pdev->dev, "get dma channels count failed\n");
>                 return ret;
> --
> 2.32.0
>


-- 
Baolin Wang
