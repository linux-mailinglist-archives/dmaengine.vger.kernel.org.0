Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F284617E70
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKCNxx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 09:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCNxw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 09:53:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884AC767
        for <dmaengine@vger.kernel.org>; Thu,  3 Nov 2022 06:53:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o8so1133688qvw.5
        for <dmaengine@vger.kernel.org>; Thu, 03 Nov 2022 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOnq3Q7cbBeOTNlE0Pk9c0a++XuWD6tqMEfNSX20zFE=;
        b=P4KAzYIKuFAX55nKGJB3Fq+iRQhlrik/s59/DNPfH48Vupwss5dy586W9qL+8E5+pD
         NBiY6bNORsMg1h8mSwpuGHLYX46j1f8yU7+CLpiI3mafoJ5Bbgz4eyGJCi6wyt3kpBwU
         0HZzDKJl5q6SsE0vdbFIFmDa1gk+zESwIta6TF7RybBq+aEx1xNMHbTUw1xvTfjEqfKe
         I7FhCng/91v8nAgDx1yrOfd2SeNpw732SstdrXMlH9ZoC9O9qZn+N/1Xeoi30+7tRws3
         QvFUppU8F2QvHGynpiw+Thh34/c+H7mVil2C7SnNOf2TbGVkdt3dwDWQ0N7cE078RirM
         BAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOnq3Q7cbBeOTNlE0Pk9c0a++XuWD6tqMEfNSX20zFE=;
        b=QJDFGoiJCAr/ELiS1rn9sE+uAPidPdPXdFRxFzjhDmKyKMUNaTYw8uFUbz3PZzzghZ
         CayTtJ8YcgwuskkfJo8SazOCpKoxT3J7+N5G/T37fWs2jnJPeg5ekcmK2e6AnBbAl9ME
         IPrH3oELEPoF1dsTVdER6bkuXIS1H7I8HjvTL5rBZRK+WzVQPSVkfHBljzoD5glcDrI6
         RBtk0Q7v++hudQw8rVJ8ZpkN+wYBYHDAT7oGKLTVhPz28x3Tv1e2QVej02h3wb+YI6FS
         jIDPo7MLnP8L1P+kEBSCBkZJshiXJdvCe2dqicmW9EpuzpW1feWMfYpqUW0dEAuYatw+
         U7SQ==
X-Gm-Message-State: ACrzQf0xYxvinlqC8OoxpR5jkXPMXTai9EvanCgHiGDDTS0YJfHl4UOK
        A6wH+LWGyyGHMqMHqWnTA2/mBQ==
X-Google-Smtp-Source: AMsMyM5skPuWzCFccIM23T9uUZq3VbVuLp+5LeS6JiEfsRkrXTqIzSMyVYOtF/zFvUzQlWHeyQX11A==
X-Received: by 2002:a0c:90a2:0:b0:47b:6b36:f94a with SMTP id p31-20020a0c90a2000000b0047b6b36f94amr27057499qvp.26.1667483630525;
        Thu, 03 Nov 2022 06:53:50 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id bv7-20020a05622a0a0700b003a5092ed8cdsm575356qtb.9.2022.11.03.06.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:53:49 -0700 (PDT)
Message-ID: <a73e76b9-f186-a818-713b-3c14033f27cb@linaro.org>
Date:   Thu, 3 Nov 2022 09:53:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
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
References: <20221031105028.598502-1-joy.zou@nxp.com>
 <20221031105028.598502-2-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221031105028.598502-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/10/2022 06:50, Joy Zou wrote:
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
> Changes in v9:
> add the dma-common quotes.
> delete the dma-controller quotes.

I have no clue what you are doing here... Do you know what are "quotes"?
I linked last time explanation of "quotes", so did you read it?


> 
> Changes in v8:
> add the dma-controller quotes.
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
> index 000000000000..95d0391a1f39
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
> +  - $ref: dma-common.yaml#

That's wrong. This should be dma-controller. Why this was changed?



Best regards,
Krzysztof

