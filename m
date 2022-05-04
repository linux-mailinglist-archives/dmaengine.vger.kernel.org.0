Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83751957C
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 04:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiEDCcV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 22:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiEDCcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 22:32:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF809205DC;
        Tue,  3 May 2022 19:28:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x9so1165qts.6;
        Tue, 03 May 2022 19:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64XUAujBw0xWDJ5J63qd30wK+8v4SC6Y43Drr8epJ+A=;
        b=XjusNOJjaMWaY1KuhIyYMx30Hw/etlmugyDlJtfUmq6vexYS0dCt95uYf7R8o+o56q
         pg3WBWI2/DIhgbBelfP+ibIMJoS6xtnOTvPss0DO+dFgNbMB6Ej2Ensetw9ckciXkmez
         NJ48i3n+6PEldXEtfB2HiIXiFxZLCK85st5rRQgxHZPbW4lVC1wraRRdg83j5oZyjUpd
         uPWD8A7XqdTdM2KS4UgDKSQaLHcOe01VMMFHDXyPbmA5oegvqj30Wb25piDHr3jfAKqI
         EKrrDwiXkJnZkLFVaUXLoLTYjOUHWrHfkyysFdaajjNClr4YD9wj5GSPZwJdl4qy8wls
         R1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64XUAujBw0xWDJ5J63qd30wK+8v4SC6Y43Drr8epJ+A=;
        b=ZQwjjMq4XoClRXx8HM9odc8m/xM3ygLsyxT1k8tTObqtf8Hc5Z5o7kC0nE/wakelvc
         TjeM/OQp241HfyD9ssJhcn5OGBw/HItt/yjKId8Y/sKbPWTLuk9w8koiwZBhK1Ac59gJ
         DA+zYQFQWQjgjqBRMACYeOkeEbk4/yaGgvni/RU4TWOZpxltiOVlSTzrv8zjArxht78z
         cdhH+JtEujykQCshEUvd3t9DAmiJOFYZSp3GzsuW4o+WMCF5xcEew2m+LuZq9EXYEjsI
         j7++5JjfBkONX18GuLR6JCp59iZC/92l+c+X1+ht1wetRTlklPnBkilF6ZlZ+x1YzHac
         tzRg==
X-Gm-Message-State: AOAM532eflqYA8eKdZUUUSn/7i52cUZKzwKbGbgGK+O6FJTFISHIMI/i
        cnFZo65Nuxc6GbcXH3emaKC211/4UKtQrfGCfSs=
X-Google-Smtp-Source: ABdhPJxn4HZkwXTislHzHTz1XSM82CXG9JNydy/rPwWoUv9M6qaVCB10mHHDG3a20AotR1yLrq6IE1h1yl+/66kYc5I=
X-Received: by 2002:a05:622a:1894:b0:2f3:93ac:5945 with SMTP id
 v20-20020a05622a189400b002f393ac5945mr17369305qtc.272.1651631326202; Tue, 03
 May 2022 19:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org> <20220503065147.51728-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503065147.51728-4-krzysztof.kozlowski@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 4 May 2022 10:29:20 +0800
Message-ID: <CADBw62oQbc4a9HxFFmO0E-bDvVvPnUo=raVOaSXZpLkKsNo-tQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: sprd: use new 'dma-channels' property
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
> The '#dma-channels' property was deprecated in favor of one defined by
> generic dma-common DT bindings.  Add new property while keeping old one
> for backwards compatibility.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  arch/arm64/boot/dts/sprd/whale2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
> index 79b9591c37aa..89d91abbd5d1 100644
> --- a/arch/arm64/boot/dts/sprd/whale2.dtsi
> +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
> @@ -126,7 +126,9 @@ ap_dma: dma-controller@20100000 {
>                                 reg = <0 0x20100000 0 0x4000>;
>                                 interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>                                 #dma-cells = <1>;
> +                               /* For backwards compatibility: */
>                                 #dma-channels = <32>;
> +                               dma-channels = <32>;
>                                 clock-names = "enable";
>                                 clocks = <&apahb_gate CLK_DMA_EB>;
>                         };
> @@ -272,7 +274,9 @@ agcp_dma: dma-controller@41580000 {
>                                 compatible = "sprd,sc9860-dma";
>                                 reg = <0 0x41580000 0 0x4000>;
>                                 #dma-cells = <1>;
> +                               /* For backwards compatibility: */
>                                 #dma-channels = <32>;
> +                               dma-channels = <32>;
>                                 clock-names = "enable", "ashb_eb";
>                                 clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
>                                        <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
> --
> 2.32.0
>


-- 
Baolin Wang
