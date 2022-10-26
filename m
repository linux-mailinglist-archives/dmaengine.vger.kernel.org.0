Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5FC60E3EA
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiJZO7F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiJZO7D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 10:59:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649411DAA1
        for <dmaengine@vger.kernel.org>; Wed, 26 Oct 2022 07:59:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e15so11525533qvo.4
        for <dmaengine@vger.kernel.org>; Wed, 26 Oct 2022 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1i1FqqhTDMT/ViyoRGQtHvVYN5J6E42giRNCRA4lx4=;
        b=KUI1hfVo+/GVX7DDCCi+qpqLJPRK1tN4Qc/EZIsWOGStCjDHxiJySclNFggdVo94PE
         xUwPRlW+hiTsz4VZVi6hTlG04KxKD3No19BLgtwSssZ1d+NDa0K4yjwcTO/PTgCUgZiy
         Y5fva+fuqn8PZypd0HvfWsyU+xVbPjxXsKzXgA+PR7kSYb2Vb94ZC1COAZ1gsbxdb0LK
         QDyEE40cg73n3Plwn8jQQ8l4yglT1bm0VG0ipxCSJSDfB7JMP/7hnS13dLWYnIhf/0dU
         iYb5q/70U3KfZxjpoa+Zx8HyFg8wk5rLL55uffjQKck7ife0Ftn6ew+3AQBxsBWuqDyB
         mBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1i1FqqhTDMT/ViyoRGQtHvVYN5J6E42giRNCRA4lx4=;
        b=yuvwGJHGi7LS9rgeWHgoo6JamEoRkIPdbD/RwKF3TsfqM3Y7OLdG8r7qMjMJVEtFVK
         bmkWKy9jPY9/Imbgzh7lVclkhaEgiFn6AhiyfUAuNjCH3bPvVnlDRHtDh//F6Q+37PHP
         u4F3+UA13lumAgTwVr5oLEZHGkpY/qbewK2mbjNj013zDm2QMyjd4x1pEqQfuw1GIJw1
         dyK8+5XtilQ19W6OwWEORW8dhCJdARnwHElMNi5wXS43Aw1TkjyEFwLekhB4IauWUDOs
         c6UKtKCHtVd1/3g/jaETzqACJbI6z6f4gEnhniSeFh6f+Hnzo4FCf119PtmgpT+L/mQK
         TArw==
X-Gm-Message-State: ACrzQf1NKQ9YcSuCVbuIsSc4sV4qL5nu2c8izoH6HSmJbdOztBQVTFx0
        VryAUtW1hOpplIS9eOlAxuEMzFSECJK3Sg==
X-Google-Smtp-Source: AMsMyM4gCvptG/75Ow/xn6cQNN0P4WSbVQ225JJytPyNeolHcy1BKvjyPYbEHG2aI4PsLRDa0dEm5g==
X-Received: by 2002:ad4:5962:0:b0:4bb:6c2f:cbc2 with SMTP id eq2-20020ad45962000000b004bb6c2fcbc2mr14578666qvb.101.1666796341918;
        Wed, 26 Oct 2022 07:59:01 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id b6-20020ac812c6000000b0039ccbf75f92sm3282983qtj.11.2022.10.26.07.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:59:01 -0700 (PDT)
Message-ID: <133f27f4-d92c-ef8d-4fc9-32387518e4c0@linaro.org>
Date:   Wed, 26 Oct 2022 10:58:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
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
References: <20221025083609.2129260-1-joy.zou@nxp.com>
 <20221025083609.2129260-2-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025083609.2129260-2-joy.zou@nxp.com>
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

On 25/10/2022 04:36, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
> original binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v8:
> add the dma-controller quotes.

Why adding quotes?

> delete #dma-cells in required.
> 
> Changes in v6:
> delete tag Acked-by from commit message.
> 
> Changes in v5:
> modify the commit message fromat.
> add additionalProperties, because delete the quotes in patch v4.
> delete unevaluatedProperties due to similar to additionalProperties.
> modification fsl,sdma-event-remap items and description.
> 
> Changes in v4:
> modify the commit message.
> delete the quotes in patch.
> modify the compatible in patch.
> delete maxitems and add items for clock-names property.
> add iram property.
> 
> Changes in v3:
> modify the commit message.
> modify the filename.
> modify the maintainer.
> delete the unnecessary comment.
> modify the compatible and run dt_binding_check and dtbs_check.
> add clocks and clock-names property.
> delete the reg description and add maxItems.
> delete the interrupts description and add maxItems.
> add ref for gpr property.
> modify the fsl,sdma-event-remap ref type and add items.
> delete consumer example.
> 
> Changes in v2:
> convert imx sdma bindings to DT schema.
> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
>  2 files changed, 149 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> new file mode 100644
> index 000000000000..fe527d32cdb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -0,0 +1,149 @@
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
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:

Best regards,
Krzysztof

