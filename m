Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5DB6196C5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 14:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKDNC3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKDNC2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 09:02:28 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABDF2E6BB
        for <dmaengine@vger.kernel.org>; Fri,  4 Nov 2022 06:02:27 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s4so2951105qtx.6
        for <dmaengine@vger.kernel.org>; Fri, 04 Nov 2022 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/++0ZayQKL3UffEUz5WYVbHFL3chrZbsRBzuyMtNns=;
        b=FIOWp60zDFULn87/JG2Lu/+xxnMdksO+gpByn+IEGJmcCxff7gfexRBqr1S9cNfT0+
         tfW9koljj39OpUDA9Oh/dF21a6gS6nvl2ary/uJ61q2bgYBCnERBs71yfnz8bK+EuI1d
         Nrpxe0W8L4xBlVyuFjt2Vq6uT7MT4U9t2WfGqdmgqv4VkRVSPXglb4UVZJqmrNT3ptwy
         4RXFUZZFQGHQkbo4j8cX9k8LG0xPLurC0OXF60PoCxj0eS5Pifl8sYBSJQ+WF9QMGQ3T
         9vsdnei/Sdw0U/feWeEUxPk9gURBiXsuCxsYCC31DS12SML25LBS5p3Qw+6+PmhIRb6n
         Krgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/++0ZayQKL3UffEUz5WYVbHFL3chrZbsRBzuyMtNns=;
        b=0Zvc1rDJ/bOqitMY4ywAkk3J1SOqKvKovi3RA59f/+f1nskmO6JXJ5FEQ5qokRoejs
         1ZR8tdpWaHomWclUBzNC6qn0czh7pNF2eJLmVsgsIHjAllgYUtowQ+pWyRNNgW8/WXQE
         FYutPPNEPwmggQt7jhs4bfjW1l1IaKF8DGOQororEDWl1+H41cjwKkRc030tiPz78/cM
         QSm0Lbdl3RdyQlur08FjcJMvfPWmboEd6RVfHzyRfW4wgGlR/MKXrutWZEdIGLcBSU0J
         gKOo8vXiQbbJXci201wgSj4VfFCJz4N9DdjQhG8fqYW50ps62AL5SfLYd69sVhzud745
         Ioxg==
X-Gm-Message-State: ACrzQf0RWvvCEI+2LEk7eEoU92wwwOV/5dRMU85sZHk0pWpoB0rakF38
        /kjLxfyZgjyX9SYi8j9Ok7Y61A==
X-Google-Smtp-Source: AMsMyM6eZt4kTIoc7uzby1Mq1irJK0fUe5UXWvhwKMpqlGTmAjvjVlHq7ZGwotSylQNtq0Q7FfPlxQ==
X-Received: by 2002:ac8:7651:0:b0:3a5:528c:f326 with SMTP id i17-20020ac87651000000b003a5528cf326mr6558034qtr.586.1667566946709;
        Fri, 04 Nov 2022 06:02:26 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a455000b006fa313bf185sm2929193qkp.8.2022.11.04.06.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:02:26 -0700 (PDT)
Message-ID: <ff608343-be86-b722-b1f1-ed56c5e1cae0@linaro.org>
Date:   Fri, 4 Nov 2022 09:02:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXT] Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221031105028.598502-1-joy.zou@nxp.com>
 <20221031105028.598502-2-joy.zou@nxp.com>
 <a73e76b9-f186-a818-713b-3c14033f27cb@linaro.org>
 <AM6PR04MB5925DADA3EB1F118680698C5E13B9@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB5925DADA3EB1F118680698C5E13B9@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04/11/2022 01:10, Joy Zou wrote:
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年11月3日 21:54
>> To: Joy Zou <joy.zou@nxp.com>; vkoul@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com
>> Cc: S.J. Wang <shengjiu.wang@nxp.com>; martink@posteo.de;
>> dev@lynxeye.de; alexander.stein@ew.tq-group.com; Peng Fan
>> <peng.fan@nxp.com>; david@ixit.cz; aford173@gmail.com; Hongxing Zhu
>> <hongxing.zhu@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma
>> to DT schema
>>
>> Caution: EXT Email
>>
>> On 31/10/2022 06:50, Joy Zou wrote:
>>> Convert the i.MX SDMA binding to DT schema format using json-schema.
>>>
>>> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma,
>>> fsl,imx35-to1-sdma and fsl,imx35-to2-sdma are not used. So need to
>>> delete it. The compatibles fsl,imx50-sdma, fsl,imx6sll-sdma and
>>> fsl,imx6sl-sdma are added. The original binding don't list all compatible used.
>>>
>>> In addition, add new peripheral types HDMI Audio.
>>>
>>> Signed-off-by: Joy Zou <joy.zou@nxp.com>
>>> ---
>>> Changes in v9:
>>> add the dma-common quotes.
>>> delete the dma-controller quotes.
>>
>> I have no clue what you are doing here... Do you know what are "quotes"?
>> I linked last time explanation of "quotes", so did you read it?
> Thank you very much for your comments.
> I confused quote and quotes. Could I confirm my understand？
> The quote means $ref: ?

No. Quote is:

https://en.wikipedia.org/wiki/Quote

> The quotes means a symbol "?

Yes.

>>
>>
>>>
>>> Changes in v8:
>>> add the dma-controller quotes.
>>> delete #dma-cells in required.
>>>
>>> Changes in v6:
>>> delete tag Acked-by from commit message.
>>>
>>> Changes in v5:
>>> modify the commit message fromat.
>>> add additionalProperties, because delete the quotes in patch v4.
>>> delete unevaluatedProperties due to similar to additionalProperties.
>>> modification fsl,sdma-event-remap items and description.
>>>
>>> Changes in v4:
>>> modify the commit message.
>>> delete the quotes in patch.
>>> modify the compatible in patch.
>>> delete maxitems and add items for clock-names property.
>>> add iram property.
>>>
>>> Changes in v3:
>>> modify the commit message.
>>> modify the filename.
>>> modify the maintainer.
>>> delete the unnecessary comment.
>>> modify the compatible and run dt_binding_check and dtbs_check.
>>> add clocks and clock-names property.
>>> delete the reg description and add maxItems.
>>> delete the interrupts description and add maxItems.
>>> add ref for gpr property.
>>> modify the fsl,sdma-event-remap ref type and add items.
>>> delete consumer example.
>>>
>>> Changes in v2:
>>> convert imx sdma bindings to DT schema.
>>> ---
>>>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149
>>> ++++++++++++++++++  .../devicetree/bindings/dma/fsl-imx-sdma.txt  |
>>> 118 --------------
>>>  2 files changed, 149 insertions(+), 118 deletions(-)  create mode
>>> 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>>>  delete mode 100644
>>> Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>>> b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>>> new file mode 100644
>>> index 000000000000..95d0391a1f39
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>>> @@ -0,0 +1,149 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>>> +---
>>> +$id:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>>
>> +cetree.org%2Fschemas%2Fdma%2Ffsl%2Cimx-sdma.yaml%23&amp;data=05
>> %7C01%
>>>
>> +7Cjoy.zou%40nxp.com%7Cd8f785d11ac042ebd7d908dabda2d753%7C686ea
>> 1d3bc2b
>>>
>> +4c6fa92cd99c5c301635%7C0%7C0%7C638030804342124191%7CUnknown
>> %7CTWFpbGZ
>>>
>> +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
>> n0%
>>>
>> +3D%7C3000%7C%7C%7C&amp;sdata=3XpKUGv751na%2BV4OYDQEvGQxeeT
>> 4UbW0wizQkM
>>> +yfx4k%3D&amp;reserved=0
>>> +$schema:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>>
>> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cjoy.z
>> ou%4
>>>
>> +0nxp.com%7Cd8f785d11ac042ebd7d908dabda2d753%7C686ea1d3bc2b4c6
>> fa92cd99
>>>
>> +c5c301635%7C0%7C0%7C638030804342124191%7CUnknown%7CTWFpbG
>> Zsb3d8eyJWIj
>>>
>> +oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> 000%7
>>>
>> +C%7C%7C&amp;sdata=nnBXK4c%2FiA1ncohiak4CXEQGbp5uhDq835RK9%2B
>> BYdJw%3D&
>>> +amp;reserved=0
>>> +
>>> +title: Freescale Smart Direct Memory Access (SDMA) Controller for
>>> +i.MX
>>> +
>>> +maintainers:
>>> +  - Joy Zou <joy.zou@nxp.com>
>>> +
>>> +allOf:
>>> +  - $ref: dma-common.yaml#
>>
>> That's wrong. This should be dma-controller. Why this was changed?
> Thank you very much for your comments.
> I remember your comments in patch v6.
> "The device schemas do not need to enforce the name. The dma-controller schema enforces it, so what is missing here is to reference it."
> So I change it.
> Should I use dma-controller?

Yes, like all other bindings.

Best regards,
Krzysztof

