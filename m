Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC86642D00
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiLEQhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 11:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiLEQgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 11:36:46 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC12126F;
        Mon,  5 Dec 2022 08:35:00 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id t62so13628046oib.12;
        Mon, 05 Dec 2022 08:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LmueXUXyGNVa79/vNF3eg0gla6XRQeVcGtQ/SX2HD4=;
        b=ck82cPaf9J+Khv3IcJpj7vnCJTA1CdFnMQrGyaSxCGp1D9a5SKJQ+9qXnETjfmPbDS
         fYBsnL1xQ3QTa9JMvwLhvQ55MR1hwuwEZsPia2trROTqypBh6dS2pBbMFFnawbyaD0he
         2v/Tq50sq6vE0cMtgf26lbnu8ABgmZ8X1/wEryrJ38U87cQzCoEWtNSoluG9mo9jwdgB
         F7BBoUxwcGVlp26Q53s1ISiF6w9ogJx2DE8Y8XZWeE5Ola2Sk7NzWpi1NyWtYSiWwTH7
         qAzLBlFoTiqjAELH7Mo3tlrNPr6gxqbhxOWxuI8hCmuIVCicfg5rtUZSIScNNXn+dNiF
         Ustg==
X-Gm-Message-State: ANoB5pk8cqsH+mEn4XYhyelBml7wqISGtlj4KqE22wX/n22gHmv8t2KX
        RjrWGJNE7fWsWwpwKxAXMw==
X-Google-Smtp-Source: AA0mqf6CoNtePO5bj+mi2MYlTeJfbtyVVhhECDsbwer0VjrJUMrf9hVTNLDwy5cYNa3POnSH40rVuA==
X-Received: by 2002:a54:4407:0:b0:34f:9f93:1f17 with SMTP id k7-20020a544407000000b0034f9f931f17mr38439368oiw.203.1670258094210;
        Mon, 05 Dec 2022 08:34:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 18-20020aca1112000000b00354d9b9f6b4sm4152761oir.27.2022.12.05.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:34:53 -0800 (PST)
Received: (nullmailer pid 2036863 invoked by uid 1000);
        Mon, 05 Dec 2022 16:34:53 -0000
Date:   Mon, 5 Dec 2022 10:34:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] dt-bindings: Drop Jee Heng Sia
Message-ID: <20221205163453.GA2034441-robh@kernel.org>
References: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Dec 03, 2022 at 05:21:43PM +0100, Krzysztof Kozlowski wrote:
> Emails to Jee Heng Sia bounce ("550 #5.1.0 Address rejected.").  Add
> Keembay platform maintainers as Keembay I2S maintainers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml    | 1 -
>  Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 67aa7bb6d36a..ad107a4d3b33 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -8,7 +8,6 @@ title: Synopsys DesignWare AXI DMA Controller
>  
>  maintainers:
>    - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> -  - Jee Heng Sia <jee.heng.sia@intel.com>
>  
>  description:
>    Synopsys DesignWare AXI DMA Controller DT Binding
> diff --git a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
> index 2ac0a4b3cd18..33ab0be036a1 100644
> --- a/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Intel KeemBay I2S
>  
>  maintainers:
> -  - Sia, Jee Heng <jee.heng.sia@intel.com>
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +  - Paul J. Murphy <paul.j.murphy@intel.com

Missing '>'

>  
>  description: |
>   Intel KeemBay I2S
> -- 
> 2.34.1
> 
> 
