Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FA532ADC
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiEXNHv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiEXNHv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 09:07:51 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A34C5FF01;
        Tue, 24 May 2022 06:07:46 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-f1eafa567cso18730004fac.8;
        Tue, 24 May 2022 06:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=KWecMXQ2tw1qgTwkqTd2tU0RObK6bphtHkWGGAUME7M=;
        b=luAfsIMOMNA6C5riNvvGNswCbJIGMdkD3EBZ53jqaQ1Mer4UeC9WnKnbdmNBB3MF4s
         LJ9G3UzdfCApmEVc7cZTsgp88d2OzE1ue8pIgqqGw4Dos3m3v1W/lsT6JiB1jYa1Qfx7
         EN98Pl++InqYnBgj6RUrgc7bQJbn+F98Wo8AA7ZncMH1h8xIIBzIJRZgtayK1NPljjA/
         iRn5gVWU5lQBR5mLkmmxV5No9ZBfWaNN+30tmU6Br8KbkzxgwRbIjgj30kNbRFjK3L56
         UgG+wV4SGCh7JFm2ET/YW/PK7eWd+P6t5hBbo+rF8KBlMh/sar/l1HI7MYkx1ZklOcch
         b7qg==
X-Gm-Message-State: AOAM533Lk6WsTZpM+fJeJtz1JUUFNsq0TJerPeL7y7Bqx4I7A1NZN6ZL
        Ltwxei11RYTH4qJS0WPquw==
X-Google-Smtp-Source: ABdhPJyjarnIC3le+10Y0LRQVjfSdLir1TXSseGHcLo9Gx3m0PehXCbzNgs73D+V5Z+blHKCGaKAqA==
X-Received: by 2002:a05:6870:f149:b0:dd:f3b0:986d with SMTP id l9-20020a056870f14900b000ddf3b0986dmr2460460oac.148.1653397664940;
        Tue, 24 May 2022 06:07:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mm27-20020a0568700e9b00b000f29ff7d508sm386540oab.17.2022.05.24.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 06:07:44 -0700 (PDT)
Received: (nullmailer pid 3591120 invoked by uid 1000);
        Tue, 24 May 2022 13:07:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     linux-imx@nxp.com, dmaengine@vger.kernel.org,
        kernel@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, s.hauer@pengutronix.de
In-Reply-To: <20220524080337.1322240-1-joy.zou@nxp.com>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
Subject: Re: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio' transfer
Date:   Tue, 24 May 2022 08:07:43 -0500
Message-Id: <1653397663.270345.3591119.nullmailer@robh.at.kernel.org>
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

On Tue, 24 May 2022 16:03:37 +0800, Joy Zou wrote:
> Add HDMI Audio transfer type.
> 
> convert the sdma bindings txt into yaml in v2.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since v1:
> convert the sdma bindings txt into yaml in v2.
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.yaml | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


dma-controller@20ec000: compatible:0: 'fsl,imx6sll-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

dma-controller@20ec000: compatible:1: 'fsl,imx6ul-sdma' is not one of ['fsl,imx35-sdma', 'fsl,imx8mq-sdma']
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb

sdma@20ec000: $nodename:0: 'sdma@20ec000' does not match '^dma-controller(@.*)?$'
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw54xx.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-mamoj.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apf6dev.dtb
	arch/arm/boot/dts/imx6q-arm2.dtb
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-cm-fx6.dtb
	arch/arm/boot/dts/imx6q-cubox-i.dtb
	arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb
	arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6q-ds.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-evi.dtb
	arch/arm/boot/dts/imx6q-gk802.dtb
	arch/arm/boot/dts/imx6q-gw51xx.dtb
	arch/arm/boot/dts/imx6q-gw52xx.dtb
	arch/arm/boot/dts/imx6q-gw53xx.dtb
	arch/arm/boot/dts/imx6q-gw5400-a.dtb
	arch/arm/boot/dts/imx6q-gw54xx.dtb
	arch/arm/boot/dts/imx6q-gw551x.dtb
	arch/arm/boot/dts/imx6q-gw552x.dtb
	arch/arm/boot/dts/imx6q-gw553x.dtb
	arch/arm/boot/dts/imx6q-gw560x.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5904.dtb
	arch/arm/boot/dts/imx6q-gw5907.dtb
	arch/arm/boot/dts/imx6q-gw5910.dtb
	arch/arm/boot/dts/imx6q-gw5912.dtb
	arch/arm/boot/dts/imx6q-gw5913.dtb
	arch/arm/boot/dts/imx6q-h100.dtb
	arch/arm/boot/dts/imx6q-hummingboard2.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard.dtb
	arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6q-icore.dtb
	arch/arm/boot/dts/imx6q-icore-mipi.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap10.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap12.dtb
	arch/arm/boot/dts/imx6q-icore-rqs.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb
	arch/arm/boot/dts/imx6q-logicpd.dtb
	arch/arm/boot/dts/imx6q-marsboard.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-mccmon6.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6q-nitrogen6x.dtb
	arch/arm/boot/dts/imx6q-novena.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-prtwd3.dtb
	arch/arm/boot/dts/imx6q-prti6q.dtb
	arch/arm/boot/dts/imx6q-prtwd2.dtb
	arch/arm/boot/dts/imx6qp-sabreauto.dtb
	arch/arm/boot/dts/imx6qp-sabresd.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb
	arch/arm/boot/dts/imx6qp-vicutp.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-rex-pro.dtb
	arch/arm/boot/dts/imx6q-sabreauto.dtb
	arch/arm/boot/dts/imx6q-sabrelite.dtb
	arch/arm/boot/dts/imx6q-sabresd.dtb
	arch/arm/boot/dts/imx6q-savageboard.dtb
	arch/arm/boot/dts/imx6q-sbc6x.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dtb
	arch/arm/boot/dts/imx6q-solidsense.dtb
	arch/arm/boot/dts/imx6q-tbs2910.dtb
	arch/arm/boot/dts/imx6q-ts4900.dtb
	arch/arm/boot/dts/imx6q-ts7970.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-1110.dtb
	arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb
	arch/arm/boot/dts/imx6q-udoo.dtb
	arch/arm/boot/dts/imx6q-utilite-pro.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-vicut1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

sdma@20ec000: compatible:0: 'fsl,imx6sl-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb

sdma@20ec000: compatible:1: 'fsl,imx6q-sdma' is not one of ['fsl,imx35-sdma', 'fsl,imx8mq-sdma']
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

sdma@20ec000: compatible: ['fsl,imx6ul-sdma', 'fsl,imx6q-sdma', 'fsl,imx35-sdma'] is too long
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

sdma@20ec000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

sdma@20ec000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
	arch/arm/boot/dts/imx6dl-alti6p.dtb
	arch/arm/boot/dts/imx6dl-apf6dev.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_4.dtb
	arch/arm/boot/dts/imx6dl-aristainetos_7.dtb
	arch/arm/boot/dts/imx6dl-b105pv2.dtb
	arch/arm/boot/dts/imx6dl-b105v2.dtb
	arch/arm/boot/dts/imx6dl-b125pv2.dtb
	arch/arm/boot/dts/imx6dl-b125v2.dtb
	arch/arm/boot/dts/imx6dl-b155v2.dtb
	arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dtb
	arch/arm/boot/dts/imx6dl-cubox-i.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6dl-dhcom-picoitx.dtb
	arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dtb
	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
	arch/arm/boot/dts/imx6dl-gw51xx.dtb
	arch/arm/boot/dts/imx6dl-gw52xx.dtb
	arch/arm/boot/dts/imx6dl-gw53xx.dtb
	arch/arm/boot/dts/imx6dl-gw54xx.dtb
	arch/arm/boot/dts/imx6dl-gw551x.dtb
	arch/arm/boot/dts/imx6dl-gw552x.dtb
	arch/arm/boot/dts/imx6dl-gw553x.dtb
	arch/arm/boot/dts/imx6dl-gw560x.dtb
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6dl-gw5904.dtb
	arch/arm/boot/dts/imx6dl-gw5907.dtb
	arch/arm/boot/dts/imx6dl-gw5910.dtb
	arch/arm/boot/dts/imx6dl-gw5912.dtb
	arch/arm/boot/dts/imx6dl-gw5913.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6dl-icore.dtb
	arch/arm/boot/dts/imx6dl-icore-mipi.dtb
	arch/arm/boot/dts/imx6dl-icore-rqs.dtb
	arch/arm/boot/dts/imx6dl-lanmcu.dtb
	arch/arm/boot/dts/imx6dl-mamoj.dtb
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-nit6xlite.dtb
	arch/arm/boot/dts/imx6dl-nitrogen6x.dtb
	arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6dl-pico-dwarf.dtb
	arch/arm/boot/dts/imx6dl-pico-hobbit.dtb
	arch/arm/boot/dts/imx6dl-pico-nymph.dtb
	arch/arm/boot/dts/imx6dl-pico-pi.dtb
	arch/arm/boot/dts/imx6dl-plybas.dtb
	arch/arm/boot/dts/imx6dl-plym2m.dtb
	arch/arm/boot/dts/imx6dl-prtmvt.dtb
	arch/arm/boot/dts/imx6dl-prtrvt.dtb
	arch/arm/boot/dts/imx6dl-prtvt7.dtb
	arch/arm/boot/dts/imx6dl-rex-basic.dtb
	arch/arm/boot/dts/imx6dl-riotboard.dtb
	arch/arm/boot/dts/imx6dl-sabreauto.dtb
	arch/arm/boot/dts/imx6dl-sabrelite.dtb
	arch/arm/boot/dts/imx6dl-sabresd.dtb
	arch/arm/boot/dts/imx6dl-savageboard.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6dl-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6dl-solidsense.dtb
	arch/arm/boot/dts/imx6dl-ts4900.dtb
	arch/arm/boot/dts/imx6dl-ts7970.dtb
	arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035.dtb
	arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-801x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033.dtb
	arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-tx6u-811x.dtb
	arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb
	arch/arm/boot/dts/imx6dl-udoo.dtb
	arch/arm/boot/dts/imx6dl-victgo.dtb
	arch/arm/boot/dts/imx6dl-vicut1.dtb
	arch/arm/boot/dts/imx6dl-wandboard.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6dl-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-apalis-eval.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora.dtb
	arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dtb
	arch/arm/boot/dts/imx6q-apf6dev.dtb
	arch/arm/boot/dts/imx6q-arm2.dtb
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-cm-fx6.dtb
	arch/arm/boot/dts/imx6q-cubox-i.dtb
	arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-cubox-i-som-v15.dtb
	arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb
	arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb
	arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb
	arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6q-ds.dtb
	arch/arm/boot/dts/imx6q-emcon-avari.dtb
	arch/arm/boot/dts/imx6q-evi.dtb
	arch/arm/boot/dts/imx6q-gk802.dtb
	arch/arm/boot/dts/imx6q-gw51xx.dtb
	arch/arm/boot/dts/imx6q-gw52xx.dtb
	arch/arm/boot/dts/imx6q-gw53xx.dtb
	arch/arm/boot/dts/imx6q-gw5400-a.dtb
	arch/arm/boot/dts/imx6q-gw54xx.dtb
	arch/arm/boot/dts/imx6q-gw551x.dtb
	arch/arm/boot/dts/imx6q-gw552x.dtb
	arch/arm/boot/dts/imx6q-gw553x.dtb
	arch/arm/boot/dts/imx6q-gw560x.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5904.dtb
	arch/arm/boot/dts/imx6q-gw5907.dtb
	arch/arm/boot/dts/imx6q-gw5910.dtb
	arch/arm/boot/dts/imx6q-gw5912.dtb
	arch/arm/boot/dts/imx6q-gw5913.dtb
	arch/arm/boot/dts/imx6q-h100.dtb
	arch/arm/boot/dts/imx6q-hummingboard2.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard.dtb
	arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dtb
	arch/arm/boot/dts/imx6q-hummingboard-som-v15.dtb
	arch/arm/boot/dts/imx6q-icore.dtb
	arch/arm/boot/dts/imx6q-icore-mipi.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap10.dtb
	arch/arm/boot/dts/imx6q-icore-ofcap12.dtb
	arch/arm/boot/dts/imx6q-icore-rqs.dtb
	arch/arm/boot/dts/imx6q-kp-tpc.dtb
	arch/arm/boot/dts/imx6q-logicpd.dtb
	arch/arm/boot/dts/imx6q-marsboard.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-mccmon6.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6q-nitrogen6x.dtb
	arch/arm/boot/dts/imx6q-novena.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb
	arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6q-phytec-pbab01.dtb
	arch/arm/boot/dts/imx6q-pico-dwarf.dtb
	arch/arm/boot/dts/imx6q-pico-hobbit.dtb
	arch/arm/boot/dts/imx6q-pico-nymph.dtb
	arch/arm/boot/dts/imx6q-pico-pi.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb
	arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb
	arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb
	arch/arm/boot/dts/imx6qp-prtwd3.dtb
	arch/arm/boot/dts/imx6q-prti6q.dtb
	arch/arm/boot/dts/imx6q-prtwd2.dtb
	arch/arm/boot/dts/imx6qp-sabreauto.dtb
	arch/arm/boot/dts/imx6qp-sabresd.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb
	arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb
	arch/arm/boot/dts/imx6qp-vicutp.dtb
	arch/arm/boot/dts/imx6qp-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-rex-pro.dtb
	arch/arm/boot/dts/imx6q-sabreauto.dtb
	arch/arm/boot/dts/imx6q-sabrelite.dtb
	arch/arm/boot/dts/imx6q-sabresd.dtb
	arch/arm/boot/dts/imx6q-savageboard.dtb
	arch/arm/boot/dts/imx6q-sbc6x.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt2.dtb
	arch/arm/boot/dts/imx6q-skov-revc-lt6.dtb
	arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dtb
	arch/arm/boot/dts/imx6q-solidsense.dtb
	arch/arm/boot/dts/imx6q-tbs2910.dtb
	arch/arm/boot/dts/imx6q-ts4900.dtb
	arch/arm/boot/dts/imx6q-ts7970.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1010.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb
	arch/arm/boot/dts/imx6q-tx6q-1020.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036.dtb
	arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb
	arch/arm/boot/dts/imx6q-tx6q-1110.dtb
	arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb
	arch/arm/boot/dts/imx6q-udoo.dtb
	arch/arm/boot/dts/imx6q-utilite-pro.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-vicut1.dtb
	arch/arm/boot/dts/imx6q-wandboard.dtb
	arch/arm/boot/dts/imx6q-wandboard-revb1.dtb
	arch/arm/boot/dts/imx6q-wandboard-revd1.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb
	arch/arm/boot/dts/imx6s-dhcom-drc02.dtb

sdma@302c0000: $nodename:0: 'sdma@302c0000' does not match '^dma-controller(@.*)?$'
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@302c0000: compatible:0: 'fsl,imx8mq-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@302c0000: compatible:1: 'fsl,imx7d-sdma' is not one of ['fsl,imx35-sdma', 'fsl,imx8mq-sdma']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@302c0000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@30bd0000: $nodename:0: 'sdma@30bd0000' does not match '^dma-controller(@.*)?$'
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

sdma@30bd0000: compatible:0: 'fsl,imx8mq-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@30bd0000: compatible:1: 'fsl,imx7d-sdma' is not one of ['fsl,imx35-sdma', 'fsl,imx8mq-sdma']
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@30bd0000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb

sdma@30bd0000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
	arch/arm/boot/dts/imx7d-cl-som-imx7.dtb
	arch/arm/boot/dts/imx7d-colibri-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7d-meerkat96.dtb
	arch/arm/boot/dts/imx7d-nitrogen7.dtb
	arch/arm/boot/dts/imx7d-pico-dwarf.dtb
	arch/arm/boot/dts/imx7d-pico-hobbit.dtb
	arch/arm/boot/dts/imx7d-pico-nymph.dtb
	arch/arm/boot/dts/imx7d-pico-pi.dtb
	arch/arm/boot/dts/imx7d-remarkable2.dtb
	arch/arm/boot/dts/imx7d-sbc-imx7.dtb
	arch/arm/boot/dts/imx7d-sdb.dtb
	arch/arm/boot/dts/imx7d-sdb-reva.dtb
	arch/arm/boot/dts/imx7d-sdb-sht11.dtb
	arch/arm/boot/dts/imx7d-zii-rmu2.dtb
	arch/arm/boot/dts/imx7d-zii-rpu2.dtb
	arch/arm/boot/dts/imx7s-colibri-aster.dtb
	arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb
	arch/arm/boot/dts/imx7s-warp.dtb

sdma@53fd4000: $nodename:0: 'sdma@53fd4000' does not match '^dma-controller(@.*)?$'
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb
	arch/arm/boot/dts/imx31-bug.dtb
	arch/arm/boot/dts/imx31-lite.dtb
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

sdma@53fd4000: compatible:0: 'fsl,imx35-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

sdma@53fd4000: compatible: ['fsl,imx25-sdma'] is too short
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

sdma@53fd4000: compatible: ['fsl,imx31-sdma'] is too short
	arch/arm/boot/dts/imx31-bug.dtb
	arch/arm/boot/dts/imx31-lite.dtb

sdma@53fd4000: compatible: ['fsl,imx35-sdma'] is too short
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

sdma@53fd4000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb
	arch/arm/boot/dts/imx31-bug.dtb
	arch/arm/boot/dts/imx31-lite.dtb
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

sdma@63fb0000: $nodename:0: 'sdma@63fb0000' does not match '^dma-controller(@.*)?$'
	arch/arm/boot/dts/imx50-evk.dtb
	arch/arm/boot/dts/imx50-kobo-aura.dtb
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

sdma@63fb0000: compatible:0: 'fsl,imx50-sdma' is not one of ['fsl,imx25-sdma', 'fsl,imx31-sdma', 'fsl,imx31-to1-sdma', 'fsl,imx31-to2-sdma', 'fsl,imx35-to1-sdma', 'fsl,imx35-to2-sdma', 'fsl,imx51-sdma', 'fsl,imx53-sdma', 'fsl,imx6q-sdma', 'fsl,imx7d-sdma', 'fsl,imx6sx-sdma', 'fsl,imx6ul-sdma', 'fsl,imx8mm-sdma', 'fsl,imx8mn-sdma', 'fsl,imx8mp-sdma']
	arch/arm/boot/dts/imx50-evk.dtb
	arch/arm/boot/dts/imx50-kobo-aura.dtb

sdma@63fb0000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	arch/arm/boot/dts/imx50-evk.dtb
	arch/arm/boot/dts/imx50-kobo-aura.dtb

sdma@63fb0000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

sdma@83fb0000: $nodename:0: 'sdma@83fb0000' does not match '^dma-controller(@.*)?$'
	arch/arm/boot/dts/imx51-apf51dev.dtb
	arch/arm/boot/dts/imx51-apf51.dtb
	arch/arm/boot/dts/imx51-babbage.dtb
	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
	arch/arm/boot/dts/imx51-ts4800.dtb
	arch/arm/boot/dts/imx51-zii-rdu1.dtb
	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb

sdma@83fb0000: Unevaluated properties are not allowed ('clock-names', 'clocks' were unexpected)
	arch/arm/boot/dts/imx51-apf51dev.dtb
	arch/arm/boot/dts/imx51-apf51.dtb
	arch/arm/boot/dts/imx51-babbage.dtb
	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
	arch/arm/boot/dts/imx51-ts4800.dtb
	arch/arm/boot/dts/imx51-zii-rdu1.dtb
	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb

