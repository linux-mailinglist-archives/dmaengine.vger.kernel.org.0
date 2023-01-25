Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07BB67BBA1
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jan 2023 21:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjAYUED (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Jan 2023 15:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjAYUEC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Jan 2023 15:04:02 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1FA27D5F;
        Wed, 25 Jan 2023 12:04:01 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id s124so17286463oif.1;
        Wed, 25 Jan 2023 12:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Gkcdkob2Y6ObYYrpnf1Losk1qJrdTh8H2I4YXgC+Dk=;
        b=XtIyImpax2ZxYf7X/jqiGHzpwUFOwg+ALUk7l6pjePHUWXMB22O6me9NbQVDUTpUMz
         XI1HXVJqFcbOWSieti/6fAu107pq8OeMCUxt7BxOfeZQLs8sCYGWMHI0V9m62RwNMpTF
         7iBGTjZdAp1FrDFYyrMaZAs2gnY80vgB/92dnlclu1f2CNWwdLo0FjJaQ0TJA/NRXryG
         5E2dEP09iXuq7386RGMPbqNp9J3ZFd9/5pHHS31AsyxfyfPmPvFPorGLl68FMvCY1w28
         Jo+TN5lRtBdz2GAvI3kp91eujYL8MMHuurWcWZOOZrzD1K/X4nkQmWtvV0UuAu1sXZ5y
         MZ6w==
X-Gm-Message-State: AFqh2krxi3CYuJmWzBVAxOeDRfZ7w++m4kSoXzpPiTIFmwP/7rkwNy50
        6PDU77nNm07xieE4mYGJkQ==
X-Google-Smtp-Source: AMrXdXvFtWE+6e2FsDqQXpT3BBXJS/1t8Fhvmq3xKkeGeQdttgRtxg5rjf30XlBDjQNS36QwjR+NjQ==
X-Received: by 2002:aca:1012:0:b0:364:cacc:515b with SMTP id 18-20020aca1012000000b00364cacc515bmr13031084oiq.52.1674677040479;
        Wed, 25 Jan 2023 12:04:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q64-20020acac043000000b0035e7ed5daa1sm2599650oif.26.2023.01.25.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:04:00 -0800 (PST)
Received: (nullmailer pid 2761036 invoked by uid 1000);
        Wed, 25 Jan 2023 20:03:58 -0000
Date:   Wed, 25 Jan 2023 14:03:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Viresh Kumar <vireshk@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andy Gross <agross@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Long Cheng <long.cheng@mediatek.com>,
        Stefan Roese <sr@denx.de>, Palmer Debbelt <palmer@sifive.com>,
        Peng Fan <peng.fan@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        devicetree@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-riscv@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        - <chuanhua.lei@intel.com>, Sven Peter <sven@svenpeter.dev>,
        asahi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        dmaengine@vger.kernel.org, Green Wan <green.wan@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-actions@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: cleanup examples - indentation,
 lowercase hex
Message-ID: <167467703767.2760981.10110618536644439258.robh@kernel.org>
References: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
 <20230124081117.31186-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124081117.31186-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 24 Jan 2023 09:11:17 +0100, Krzysztof Kozlowski wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - use lowercase hex,
>  - drop unused node's label.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Drop unused label, correct indentation.
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 36 +++++++++----------
>  .../bindings/dma/stericsson,dma40.yaml        | 16 ++++-----
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
