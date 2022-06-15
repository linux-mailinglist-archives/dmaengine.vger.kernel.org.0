Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AAC54D471
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbiFOWPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 18:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiFOWPx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 18:15:53 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6545638B;
        Wed, 15 Jun 2022 15:15:52 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id p128so14170314iof.1;
        Wed, 15 Jun 2022 15:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rFQupfevfAD0SGiomMUJ6dJueSNgsuECIsu7rzoLymM=;
        b=67A6OrdsLOmEaLULv/+Q9ntqq2dPbGXoJvAYLrWtOEj392674Xsf75Y+jTea5fcWty
         ItXSMHuBRR5DqBLq0BYjk/ViFQYKi3Vw9JTtfyOQES4aOm4yNqJsm/vNcTJU9SW0P8oU
         ebrgK51NZd2x/RdKN2yvsLP0HlRjRS2lPuAlmynT9NKmfqhYuAXsZft19WDoXi/0jxjy
         6QdpZfsxMgnNdGWBsWgs4MuhXzaxmratv8hYbQnJLlEgqZ/9qkDXm5AcDe9rkarkr9+5
         aIOvRL1MgS8OxWwRi42/HuAxf+KfxpW+JR5XQZ+cZH82HxMax/JeGNp+so2t0gPuifs6
         aqvg==
X-Gm-Message-State: AJIora/rCE6Hbb2SmCGtrnRM43gt7mb8PfW+MX4qfj7ejDo6EzNTvjiC
        7njQEyc/A1kavhyVp1eIRDeBcZNmaQ==
X-Google-Smtp-Source: AGRyM1s1B2FsBfRxwDUnxFfjK7iaLYluxFJ3mp4Tqro156LZpEo84zIfiu7kV12xz1Zj9q0/4yW/oA==
X-Received: by 2002:a05:6638:2487:b0:331:faca:e317 with SMTP id x7-20020a056638248700b00331facae317mr1137123jat.300.1655331351463;
        Wed, 15 Jun 2022 15:15:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q15-20020a056e0220ef00b002d1bc2eb604sm124631ilv.58.2022.06.15.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:15:51 -0700 (PDT)
Received: (nullmailer pid 1930255 invoked by uid 1000);
        Wed, 15 Jun 2022 22:15:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220615175043.20166-1-ansuelsmth@gmail.com>
References: <20220615175043.20166-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Wed, 15 Jun 2022 16:15:49 -0600
Message-Id: <1655331349.359650.1930254.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 15 Jun 2022 19:50:43 +0200, Christian 'Ansuel' Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.
> 
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/dma/qcom,adm.yaml     | 95 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
>  2 files changed, 95 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


dma-controller@18300000: reset-names:1: 'c0' was expected
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dma-controller@18300000: reset-names:2: 'c1' was expected
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dma-controller@18300000: reset-names:3: 'c2' was expected
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dma-controller@18300000: reset-names: ['clk', 'pbus', 'c0', 'c1', 'c2'] is too long
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dma-controller@18300000: resets: [[11, 13], [11, 12], [11, 11], [11, 10], [11, 9]] is too long
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

