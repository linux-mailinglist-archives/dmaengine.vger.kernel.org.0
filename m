Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75825B8D6C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiINQrN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINQrN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 12:47:13 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DD58DFD;
        Wed, 14 Sep 2022 09:47:12 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10721548otb.6;
        Wed, 14 Sep 2022 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=poU07QG/53Lj7mfUYNC19dIu65cPTjOwpYH+B4KRSLw=;
        b=XHtHgdf3bmEEDLgh+5VkilUuwNZD/nxWA9HGNLzOYulMlDxdk3lyT3IxHrv49WyO0t
         4w9qzVwJasaClbwQGd0aHecZQ2S/JonRD/2rjgXL06cKJ7qqN60ss/fOpCE2kiF5jiL9
         nZoEAeuOeM6m5UEws3XL7Ud4Q1E02WLcByUcfi3XcDy0K2wgfWFYz3VEaybsJo59o4oO
         +ohZLYXYz1FPLnM/3Ya3kBIx5PmMC4I+yGdbPge4Qx1/NoQbWwm4q1oUVcptYwupBZxu
         YBH84M6rF1bhRJ1922m+ga1UQLuBa8+FHU5BI9UeKUkmduX6mXgs1959LGCJ50rHWBVx
         Umog==
X-Gm-Message-State: ACgBeo3IhXSTsONVFF4AgxM748CiwSulpWOUCD4Q7mUScSwsSeSxol65
        pY/wnYOlx8YHFBI2qTAgww==
X-Google-Smtp-Source: AA6agR4I7C5kFT5FMvxklN2eeypfFZeiWJscC8unUeZBnTPBBFd8t+iWIQ9dgf+zAmtFRVtWCBm3fw==
X-Received: by 2002:a9d:4c02:0:b0:655:de94:6131 with SMTP id l2-20020a9d4c02000000b00655de946131mr6826342otf.116.1663174031817;
        Wed, 14 Sep 2022 09:47:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y27-20020a544d9b000000b00342fedaf7d9sm6622931oix.43.2022.09.14.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:47:11 -0700 (PDT)
Received: (nullmailer pid 2567032 invoked by uid 1000);
        Wed, 14 Sep 2022 16:47:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     dmaengine@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20220914140426.7609-1-ansuelsmth@gmail.com>
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Wed, 14 Sep 2022 11:47:10 -0500
Message-Id: <1663174030.707683.2567031.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 14 Sep 2022 16:04:25 +0200, Christian Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
>  2 files changed, 96 insertions(+), 61 deletions(-)
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

dma-controller@18300000: resets: [[12, 13], [12, 12], [12, 11], [12, 10], [12, 9]] is too long
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

