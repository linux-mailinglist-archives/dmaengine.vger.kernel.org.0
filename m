Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEB54E2E0
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377499AbiFPOFH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377498AbiFPOFG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:05:06 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E139825;
        Thu, 16 Jun 2022 07:05:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y79so1578045iof.2;
        Thu, 16 Jun 2022 07:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HBau3VRzdZhTfclTyBibLg9xFVR5jMynJXtllb1vDUo=;
        b=rZKJL16v/5+VbUL7F+VIncxIJlDqjPihG3CPpreK2kmlHFebVil6SEvRfi10OvuPim
         cqc7ynl1SCmXrN0tIFutY/hvFLXzEy1Ua17+8LKQlPBBMaxU/JbwU3Uq1/L3EdyYrOyO
         q91lbPwMPqsAnb5SZ2hFIotYoyN5PM7JkvX0DdxXTFY6CHjsfSERWFzhA5ZHdID7o00/
         1ojOUMj69XKDHR1mifgkPglqOiuoMaWvq780kwITJO/sF6jjerByW6CP58qmkUHMJh9p
         j21U36GklvfszHBV+Ws4NWoTMrZuVcJw+XT7Oo8ygk0SBAp1Z4pY+NRQIWCFXofQpfoG
         slWA==
X-Gm-Message-State: AJIora/MwYX1NKAZd1imTpCj0nGASyaO2+LVeMfwgO4XBgfC61xmQkaV
        WALMVC80Ego+xM3GSBI2Lw==
X-Google-Smtp-Source: AGRyM1tOnixooJOH4Sxqu1VRF06xA/edeQ5bII29Z4i9C2fE+igWgZDtX/wd2w6p11/kf8obcYbEeg==
X-Received: by 2002:a05:6638:1b5:b0:331:acf2:1111 with SMTP id b21-20020a05663801b500b00331acf21111mr2817467jaq.115.1655388305114;
        Thu, 16 Jun 2022 07:05:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n41-20020a027169000000b00331a3909e46sm910313jaf.68.2022.06.16.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:05:04 -0700 (PDT)
Received: (nullmailer pid 3391581 invoked by uid 1000);
        Thu, 16 Jun 2022 14:05:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220615235404.3457-1-ansuelsmth@gmail.com>
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: rework qcom,adm Documentation to yaml schema
Date:   Thu, 16 Jun 2022 08:05:01 -0600
Message-Id: <1655388301.055791.3391580.nullmailer@robh.at.kernel.org>
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

On Thu, 16 Jun 2022 01:54:03 +0200, Christian Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v2:
> - Change Sob to Christian Marangi
> - Add Bjorn in the maintainers list
> 
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

dma-controller@18300000: resets: [[11, 13], [11, 12], [11, 11], [11, 10], [11, 9]] is too long
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

