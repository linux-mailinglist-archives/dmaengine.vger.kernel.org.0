Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2E673E9E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjASQX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Jan 2023 11:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjASQXx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Jan 2023 11:23:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B3A8B309;
        Thu, 19 Jan 2023 08:23:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so2396718wrt.3;
        Thu, 19 Jan 2023 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PcC7y3FS+HA6LTR16Kak4eGsTRhnH7QRvBCszT9C5U=;
        b=OWsZGZ11elP4SzbvFuPicIoLtQvQgdqjQHT0EUCq9YSbAvdwb9nvSo63kZNE5WYSMb
         m3bYZzWWZkK2BFpF7AI1la1QPxmBW5+32EJ6oMNgNGbtLQuhMW2srvFFT4yNQKmcCT+a
         1WKMbYW2N3hrUWZfoPBhHCUW/l0AHVY5YVa28nF+GHGTFYlx286xt3wzPq6YYUtC0cM/
         thGP4Mgb8c19/HobPxN1HeBnO3RDu+oLrGGCnPhlkj2DXA9O2wa49uO8sf/45240GSof
         YBXM7bXnJndVD1ceuTWCkL1u5eAbfyMuhx2ZmZwlxs9cfmodBlu1zkyJnGZU1iqX3jmw
         ctqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PcC7y3FS+HA6LTR16Kak4eGsTRhnH7QRvBCszT9C5U=;
        b=K3CNF6YUjMymMrz01qDl1+zLCMkDChZP5I9/KY8m384NSgeyULWzrBhwzc3vyaZx5Q
         Bv7bvHFxEUldRg9zSRQ+0YU5X7HYp017SlyTmEWaiiszTLD8sjjguqFxEac+SaIeTxN5
         zrV7ZyD3ICtMmBoAvhRGQNBMOFIpC/bNtMD4cnOOuhk4Nw0nZ/sTZ+BRbIKNDGFEehxT
         ufKk54FL4WQYh5uKLZYouSQMgAJ+SB5zu1mLfSPzg0YSqvSFpjFlSkqyVrJt+1ObMbwe
         C23VdC2/UJ8xurRLBi3lnxsCKvgRO8gw2pVWjBszWowhjeq0PvIn+Ed4WckCCKklQrrS
         hIow==
X-Gm-Message-State: AFqh2koC7WkF6E66sCduh91bUA2LpDTupjWmdGMXrtKw15RenrsLA9ha
        q8i6xSMxaZZ39YBzV5SKJHE=
X-Google-Smtp-Source: AMrXdXtIzYjj/CzYqkow+WPiYOG8ccH53zjNKZrQ2FyPIsv67Z3n3uwh+vn0p8V5ULjrCdWWyoakDg==
X-Received: by 2002:adf:f18e:0:b0:2bd:e8bd:79ce with SMTP id h14-20020adff18e000000b002bde8bd79cemr9683654wro.20.1674145424906;
        Thu, 19 Jan 2023 08:23:44 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe64a000000b00287da7ee033sm34552910wrn.46.2023.01.19.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:23:44 -0800 (PST)
Message-ID: <b9f20fce-9091-27ab-11c3-0670835ce0e7@gmail.com>
Date:   Thu, 19 Jan 2023 17:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: dma: drop unneeded quotes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Stefan Roese <sr@denx.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Green Wan <green.wan@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        - <chuanhua.lei@intel.com>, Long Cheng <long.cheng@mediatek.com>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palmer Debbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
References: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/01/2023 19:01, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml        | 2 +-
>   .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
>   .../devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml        | 2 +-
>   Documentation/devicetree/bindings/dma/altr,msgdma.yaml          | 2 +-
>   Documentation/devicetree/bindings/dma/apple,admac.yaml          | 2 +-
>   Documentation/devicetree/bindings/dma/arm-pl08x.yaml            | 2 +-
>   Documentation/devicetree/bindings/dma/dma-controller.yaml       | 2 +-
>   Documentation/devicetree/bindings/dma/dma-router.yaml           | 2 +-
>   Documentation/devicetree/bindings/dma/fsl,edma.yaml             | 2 +-
>   Documentation/devicetree/bindings/dma/ingenic,dma.yaml          | 2 +-
>   Documentation/devicetree/bindings/dma/intel,ldma.yaml           | 2 +-
>   Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml    | 2 +-

[...]

> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> index 9ab4d81ead35..dab468a88942 100644
> --- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> @@ -14,7 +14,7 @@ description: |
>     for the UART peripheral bus.
>   
>   allOf:
> -  - $ref: "dma-controller.yaml#"
> +  - $ref: dma-controller.yaml#
>   
>   properties:
>     compatible:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
