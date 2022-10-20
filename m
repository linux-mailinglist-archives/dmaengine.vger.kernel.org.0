Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF096065D0
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJTQbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJTQbo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 12:31:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC71A0F81
        for <dmaengine@vger.kernel.org>; Thu, 20 Oct 2022 09:31:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g16so9216731qtu.2
        for <dmaengine@vger.kernel.org>; Thu, 20 Oct 2022 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEI09DLi91fKmCAbw4cjgGkaMfuDv4RZD1BULECPvY8=;
        b=isrhw6eVwYYx+2Hi+NI1YXI+7q1QPWt0s+2F8FeRVQop05DYDdlrTWFg4QcLio9JbL
         tPnJ3V67EBpl8XyxB8G+vshiYvgGz4fXbe2bNhR4/62Zwu0QQU7C+TAMb1FXj3UfQqKB
         FhCy/hidGlWifrnr8Tf8kydO6XxoCrjre4EeAh7kqCwY6KuUflsFAD0xlHBR+8a7rDpX
         cBrDDNfsTZxQW65vr0AWMsLBd2PlpAgc8k3gUDZbVAMG4hOIte5wFtCbhicSDtuqpKnw
         20a/JJP2Lq6SIXFTi4SORyLc4bmIdohfBHKELjDrrbLwFa1ajCr/SBe4v2hPVa0l89xe
         pkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEI09DLi91fKmCAbw4cjgGkaMfuDv4RZD1BULECPvY8=;
        b=o2x8hQcI2TFSlg5oCZuzZd5INh6GFVYCBaPnn0nSqnzEItClsbppFCa4hNSCQzIoeo
         1hwQk5GyNcqvRc/3Rvh9JxEIxNn4xuAoszO80p59RwLx8MqCU+rVGCXSZZDbnMyUGD3/
         +bDl2rVxZHdCMeNCRSr1I1yaRzxRnEJWahwyDqklfOb3YTQbfZTGi/wTM81DLXe3DMyH
         HXmZazkG5cYd+jgv/co5zR+vXNVQGTO+l7oxeyNrNR1b2JiTRg7nIWcaIMtCkibyZzbg
         iFFUGShB2I/n51I0coyWwwLCjf77iotnOFs4bpYiXdan7FwQdRtia34Ex5JAdoH7yRfT
         +Ojg==
X-Gm-Message-State: ACrzQf3DCOlT8GXsp/19YDNbOm+d/U1btoaV3Lqr9XFkEB3QhCL65Hbm
        H2ZrybJcux4tREEky/VXDfp70A==
X-Google-Smtp-Source: AMsMyM4YVTimrtk2xF6RM3xXt+mPnRJQBhDGxbdwCTRCKJ4uhuq7xdMD9IJ8fG/530M69TM100Cyfw==
X-Received: by 2002:ac8:5bc9:0:b0:39a:348b:857e with SMTP id b9-20020ac85bc9000000b0039a348b857emr11805159qtb.462.1666283501208;
        Thu, 20 Oct 2022 09:31:41 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b006eec09eed39sm7360114qkg.40.2022.10.20.09.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:31:40 -0700 (PDT)
Message-ID: <caae2af7-96ea-195f-6f33-05d9e79fa518@linaro.org>
Date:   Thu, 20 Oct 2022 12:31:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221020101402.1856818-1-joy.zou@nxp.com>
 <20221020101402.1856818-2-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020101402.1856818-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20/10/2022 06:14, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 


> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
>  2 files changed, 147 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> new file mode 100644
> index 000000000000..3da65d3ea4af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,imx-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> +
> +maintainers:
> +  - Joy Zou <joy.zou@nxp.com>
> +

You need to reference dma-controller.yaml schema.

> +properties:
> +  compatible:
> +    oneOf:


(...)

> +
> +  gpr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the General Purpose Register (GPR) node
> +
> +  fsl,sdma-event-remap:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    maxItems: 2
> +    items:
> +      items:
> +        - description: GPR register offset
> +        - description: GPR register shift
> +        - description: GPR register value
> +    description: |
> +      Register bits of sdma event remap, the format is <reg shift val>.
> +      The order is <RX>, <TX>.
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +
> +  iram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the On-chip RAM (OCRAM) node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,sdma-ram-script-name
> +  - "#dma-cells"

and then this can one be dropped.

> +
> +additionalProperties: false

Best regards,
Krzysztof

