Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE67B5B0294
	for <lists+dmaengine@lfdr.de>; Wed,  7 Sep 2022 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIGLMK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Sep 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIGLMJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Sep 2022 07:12:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E432D97
        for <dmaengine@vger.kernel.org>; Wed,  7 Sep 2022 04:12:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so7264496lfm.4
        for <dmaengine@vger.kernel.org>; Wed, 07 Sep 2022 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iNtTUzrINFwbBnczQ174C3FOkzJAMusR7Z8JNRLKG5w=;
        b=Y3bBGyrZSPbapcNXgU7fcTKdOluEiEpZL1JmiSo9MyZa+G7UaLb030rImpHPAfiGj/
         zekNi9EFUdPw7sRiybRKv/jC7WfackMTWjGiskG8HO2/HwNszum8Fh5a1+RomPsjHv3V
         Ooe6X1p8GY9HpkvEGg64KJhOlPioLgz10dBX5lIHnk9S9MxJxtbb+cGzjbCId12Szczt
         WVKeYFiOrkNQ5nvSRAjxoJ5G09BxX1fXf0HnUnyosLgDCx+wVzB1rCNtBux6E1IqO1cF
         A0XYU3+S7SL7DBNe72+Ik99VScAoD9o/S88y/lkiH0+5paQPWRc/cQQ/vs1op/rHuhG9
         M6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iNtTUzrINFwbBnczQ174C3FOkzJAMusR7Z8JNRLKG5w=;
        b=uifw2YUKVfLMV23hjV6tBAh6T7CgDZPhC1C2bsLN9RlO3rf8oPndDwX1dl6U//x+jz
         AiWL29SlgiSGji2CkDMQMPKok7EUL/3/FBpf54OeGW2qelLerFIUnVcPFHH7H7CqQx0H
         fT+ac/WFI9Xlg9zLPB4swbdKEC7tzzMz2++YUN3k7sTFv0Xjhe8b/YBhAKwl+mFEh47H
         yw1I2m/g41tIVsHeE2+ytFXFqEXTldu6Lnys+XedWM+Jts5pP5cImyon8B2i+Bk8LMne
         mMmfsrsPGmCdr8PwJVaSTNe1V4KDM5ZNdcjrljFZ5bJUXpWIAXfF0Ezrt88ZK/rDF1yi
         gVxw==
X-Gm-Message-State: ACgBeo1/+NsZKd18d4Xnt33H0nUTHY7ohybKQXJAp43LGETyL064n9WA
        tppYIe8TN3KwZAh9HSISMb4Nlw==
X-Google-Smtp-Source: AA6agR5MbQCiwj9hCVB+jNJ5dBWEB4I/qGqoo+1hBwisRmmXG6PN3TniGyeM6KdC/9Fzv3UWU1508A==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr919269lfr.339.1662549122828;
        Wed, 07 Sep 2022 04:12:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512202b00b0048ae518364dsm1410665lfs.148.2022.09.07.04.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:12:02 -0700 (PDT)
Message-ID: <a0866b02-3fa3-96cc-3775-477ee40f09af@linaro.org>
Date:   Wed, 7 Sep 2022 13:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Joy Zou <joy.zou@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        peng.fan@nxp.com, david@ixit.cz, aford173@gmail.com,
        hongxing.zhu@nxp.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220906094256.3787384-1-joy.zou@nxp.com>
 <20220906094256.3787384-2-joy.zou@nxp.com> <4743969.GXAFRqVoOG@steina-w>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4743969.GXAFRqVoOG@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/09/2022 12:55, Alexander Stein wrote:
> Hi,
> 
> thanks for the YAML conversion patch.
> 
> Am Dienstag, 6. September 2022, 11:42:53 CEST schrieb Joy Zou:
>> Convert the i.MX SDMA binding to DT schema format using json-schema.
>>
>> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
>> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
>> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
>> original binding don't list all compatible used.
>>
>> In addition, add new peripheral types HDMI Audio.
>>
>> Signed-off-by: Joy Zou <joy.zou@nxp.com>
>> ---
>> Changes in v6:
>> delete tag Acked-by from commit message.
>>
>> Changes in v5:
>> modify the commit message fromat.
>> add additionalProperties, because delete the quotes in patch v4.
>> delete unevaluatedProperties due to similar to additionalProperties.
>> modification fsl,sdma-event-remap items and description.
>>
>> Changes in v4:
>> modify the commit message.
>> delete the quotes in patch.
>> modify the compatible in patch.
>> delete maxitems and add items for clock-names property.
>> add iram property.
>>
>> Changes in v3:
>> modify the commit message.
>> modify the filename.
>> modify the maintainer.
>> delete the unnecessary comment.
>> modify the compatible and run dt_binding_check and dtbs_check.
>> add clocks and clock-names property.
>> delete the reg description and add maxItems.
>> delete the interrupts description and add maxItems.
>> add ref for gpr property.
>> modify the fsl,sdma-event-remap ref type and add items.
>> delete consumer example.
>>
>> Changes in v2:
>> convert imx sdma bindings to DT schema.
>> ---
>>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
>>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
>>  2 files changed, 147 insertions(+), 118 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>> b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml new file mode
>> 100644
>> index 000000000000..3da65d3ea4af
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>> @@ -0,0 +1,147 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/fsl,imx-sdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
>> +
>> +maintainers:
>> +  - Joy Zou <joy.zou@nxp.com>
>> +
>> +properties:
> 
> Is it sensible to add something like this?
> 
>   $nodename:
>     pattern: "^dma-controller(@.*)?$"
> 
> You are changing the node names in patch 3 anyway.
> 

No, the device schemas do not need to enforce the name. The
dma-controller schema enforces it, so what is missing here is to
reference it.


Best regards,
Krzysztof
