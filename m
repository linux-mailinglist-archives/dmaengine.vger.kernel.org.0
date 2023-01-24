Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB1D6792CC
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjAXIOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 03:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAXIOw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 03:14:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE11BF0
        for <dmaengine@vger.kernel.org>; Tue, 24 Jan 2023 00:14:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12251420wmb.0
        for <dmaengine@vger.kernel.org>; Tue, 24 Jan 2023 00:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVSNIHGB8PISxIKwAljYge1nd6C8hUrlvE6VAZnPjHQ=;
        b=txIRzhryWamfe1z9Em3a0nBHIMlRv5s54CEfSUm93gszPu25ZLJ4IkPT0gsKTi4c3W
         19CCIKmTAIXurZIZ6Cy1W6SG5YGePUxXcVH+ddEUyAQ5l6rsURL1tX66fACMqBTgLeAN
         h8maayB9m1Nd0/koDmGy0gCChEjhR2WACCCEvgwCc+wz+yTBWAfV3RX91yXpgJ9g26y7
         YGcjWpQ6UbbfDiGjrrPYMIpkRjGo4z6DX1OaXRDM4MOVISLedvtVwDShRcPnAY+/Q5jo
         tgguNUJgYRZuisExE7oJ7fZuyC6GbLCz2AlCXJ6qR/J9Td6HAfkX/L+IBgYjkj+vu0F6
         ICjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVSNIHGB8PISxIKwAljYge1nd6C8hUrlvE6VAZnPjHQ=;
        b=tCp4mySPg8eMRzx5B2bf6/9uqar1XJZDzchU7v91CVf5FV8dltOm+oJO5+PpV/kW4i
         8TFJXEs+n4uojdYkexHAFlphcR8q1it0DVNSwrolIJ/j4c+7r4d9IyywiuGiGA88U5CZ
         Gxr1yBb0hEp5PwTm4cZPEZCW5580fkMb5mZXTvdvM0EL/l2soZNNKxh/53B/8OvpWvc4
         nvyHkUDky6dzp2bcH/f5R78hpdN5C9UCjQehHt9Cs8+Mips83iLZuM1lV2O6Tmw3SMKC
         hZ2wZDdrKXEUfRi7sY0bDg6NVAjjDX6BNNg8f4dFwUd1iDMKeSS+khD3ZOXu4d1/j4pp
         ipdw==
X-Gm-Message-State: AFqh2kppWL4FtEmUutnkZrRtZabZcnT9Fl41J8BdrVHLygjvzDD7BU5n
        TW/FS6MmY2FV+zbvrwZuH8hRzQ==
X-Google-Smtp-Source: AMrXdXt9KYzPZpMpoFYU6I2G9b/HtmRi0n7BFoNHmhNOvGumycgmZFNF8bAQ+/xC9kTewL+1vTLzQQ==
X-Received: by 2002:a05:600c:1c01:b0:3c6:e63e:23e9 with SMTP id j1-20020a05600c1c0100b003c6e63e23e9mr27243001wms.24.1674548089277;
        Tue, 24 Jan 2023 00:14:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003dafbd859a6sm12350698wmb.43.2023.01.24.00.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:14:48 -0800 (PST)
Message-ID: <aa6f0211-b744-7420-1e1e-fdf87832a154@linaro.org>
Date:   Tue, 24 Jan 2023 09:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: drop unneeded quotes
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Cc:     Rob Herring <robh@kernel.org>
References: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24/01/2023 09:11, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com> # mediatek
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Hector Martin <marcan@marcan.st> # apple

I forgot previous tags:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org> # Spear
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> # Renesas
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com> # Socionext


Best regards,
Krzysztof

