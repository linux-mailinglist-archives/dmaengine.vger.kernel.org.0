Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06651610792
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 04:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiJ1CBL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiJ1CBK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 22:01:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50249537FF
        for <dmaengine@vger.kernel.org>; Thu, 27 Oct 2022 19:01:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id l9so2607696qkk.11
        for <dmaengine@vger.kernel.org>; Thu, 27 Oct 2022 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcEbkQyKWb0L/Kg+ZX5HS6lAAi/DowSIXYc8QAB2Kvg=;
        b=ewKFgj2VXv+7hOe1fSACo9aaYnFrC2eObv3KKRwT6XZ2Y8AxykC0UNMzi9vkpu9asf
         PeFG2R+MOYlyOHZ9so4lnwzQydIOI6jDJpLHlnXtGB1aUrnWoyrSl/Z5ISJjA4JsJ3/W
         VqFv7fAXe1zS7aQudC4D3J/ScT/8shcfjDZ6Y9RKQmz6Jl7u6eXiTujTuUzm0b4hLPL+
         BB1dVtEU2LVYc70hHo4KZgzmMCgvyX0qIuTbhHcZVRoDbfnxbd8htJ6HoqxBIRMVUTL1
         YSv2LSD8Pd8P90+54refqhPmqqpPjKR/2EYMWhjMXI6HitC6/GWmMrr3m2oxYqUBX4bW
         v1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcEbkQyKWb0L/Kg+ZX5HS6lAAi/DowSIXYc8QAB2Kvg=;
        b=KgSrFwtgJo226jLBTyDXsk9qt28u6HHBPnFuGsxeGX7p0U5tR/83dWsZ7BNA7r7z75
         g6yhw3LmLwI+JK6A8VorjRehlVjipTatjKw4umr2xwYo6b9Rh3zKne5tWRqqagRARNm0
         DEe0YLry2zpYgJ4YHvjjGZ5/WTbMC+norVDOWHuQ4wUiByKeHEMCTIfcTsC6GptKu5Il
         cZSSpZ5v5URmaHSwTXFkGmLXE4ICDJF92e/0D+gKImZPlABVg9SRKKECbd5QxQVUwnRg
         lG71+Z8VLsZgho33Hx2Bto2IQVI1VA2i8rVct4PBZB6spN96glSO/nf7WUYln8BU7wB2
         UD0w==
X-Gm-Message-State: ACrzQf1VouykcgNBIZzvrVpxiV74UmxbSXL/TZYCpbV6FwZKcB/NFB/5
        koZoEXNflPW+FXCok0oKjObRVw==
X-Google-Smtp-Source: AMsMyM4d/n9swMkcWtvrJM2VCoFzwdy2vtmRKr+nsDpZ0zGmNvHHxuJUhYkQKjPr828IJ5kn0OOVMQ==
X-Received: by 2002:a05:620a:254e:b0:6c9:cc85:c41a with SMTP id s14-20020a05620a254e00b006c9cc85c41amr37259351qko.260.1666922468461;
        Thu, 27 Oct 2022 19:01:08 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id r22-20020ac84256000000b0039467aadeb8sm1449703qtm.13.2022.10.27.19.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 19:01:07 -0700 (PDT)
Message-ID: <49f504a1-e7c3-ade7-b4b4-e7571125b992@linaro.org>
Date:   Thu, 27 Oct 2022 22:01:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [EXT] Re: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx
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
References: <20221025083609.2129260-1-joy.zou@nxp.com>
 <20221025083609.2129260-2-joy.zou@nxp.com>
 <133f27f4-d92c-ef8d-4fc9-32387518e4c0@linaro.org>
 <AM6PR04MB5925157A3A6F8ADB80371082E1339@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AM6PR04MB5925157A3A6F8ADB80371082E1339@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/10/2022 23:01, Joy Zou wrote:
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年10月26日 22:59
>> To: Joy Zou <joy.zou@nxp.com>; vkoul@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com
>> Cc: S.J. Wang <shengjiu.wang@nxp.com>; martink@posteo.de;
>> dev@lynxeye.de; alexander.stein@ew.tq-group.com; Peng Fan
>> <peng.fan@nxp.com>; david@ixit.cz; aford173@gmail.com; Hongxing Zhu
>> <hongxing.zhu@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] Re: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma
>> to DT schema
>>
>> Caution: EXT Email
>>
>> On 25/10/2022 04:36, Joy Zou wrote:
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
>>> Changes in v8:
>>> add the dma-controller quotes.
>>
>> Why adding quotes?
> I refer to your comments in patch v7/1. The comment as follow:
> +maintainers:
> +  - Joy Zou <joy.zou@nxp.com>
> +
> You need to reference dma-controller.yaml schema.

Yes, you need to reference dma-controller.yaml. Nothing about quotes.
Reference is "$ref: .....yaml"


> +properties:
> +  compatible:
> +    one of:
> I misunderstand that add the dma-controller.yaml quotes. 

There was nothing about quotes - ".

> So I am a little confused. Now, I see.
> should I add dma-common.yaml quotes but not the dma-controller?

Just drop "

https://en.wikipedia.org/wiki/Quotation_mark

Best regards,
Krzysztof

