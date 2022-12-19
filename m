Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385546508B5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLSIqx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiLSIqv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 03:46:51 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A9630C;
        Mon, 19 Dec 2022 00:46:49 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4FC2A84D85;
        Mon, 19 Dec 2022 09:46:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671439608;
        bh=vMYrDL4dE2Tp/J1nv81+QRYLMaZ1Hfmlmj0LzuSRVeo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hN5i+c/0plzbwB5Jk3qtJW+gsdrhlizLzAQoWFfJvjVMzEqtQIIxEMsQj7LJtpQVW
         qNMcjOCs0utCEQa+kuBlMDzrV6fyM3dwpucRHyu28INczOTq1rgCXN2VW2lOVCtCEG
         Cbvsm/9sNOHUymIGnVy9PiN1dybtp15DEkchn99wNE82fHFKI6afkatWA6avakYwqW
         4Zd/Ov/jtRS3aDbEdJ93oYe+H36YMvzHeRx7daSeGwdT1iSz32qsjx7PiN8+xCJD3m
         ZX+oZf8OOAu7QTgwCXFoB12bhxOFv9v3Iq7rGWCmasPT+bd5DkmhUkTakupdMq+958
         JfA8RaTsPr/Ww==
Message-ID: <9f2a068b-9275-659f-b1ae-0b6046fea18b@denx.de>
Date:   Mon, 19 Dec 2022 09:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221217010724.632088-1-marex@denx.de>
 <b74776b4-0885-f519-8ef7-e01048a8be15@linaro.org>
 <ba05612d-fd3b-3e49-4ada-21f3b3c74e23@denx.de>
 <a5bb28a7-c7d3-be98-9621-996d38656d98@linaro.org>
 <58b96f52-30ae-c868-8434-a0ca9e996bcd@denx.de>
 <40956c61-ed9e-2ca3-868b-445510ea1c05@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <40956c61-ed9e-2ca3-868b-445510ea1c05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/19/22 09:36, Krzysztof Kozlowski wrote:
> On 18/12/2022 20:06, Marek Vasut wrote:
>> On 12/18/22 19:46, Krzysztof Kozlowski wrote:
>>> On 18/12/2022 00:12, Marek Vasut wrote:
>>>> On 12/17/22 12:05, Krzysztof Kozlowski wrote:
>>>>
>>>> [...]
>>>>
>>>>>> +allOf:
>>>>>> +  - $ref: dma-controller.yaml#
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          not:
>>>>>
>>>>> I think "not:" goes just after "if:". Please double check that it's correct.
>>>>>
>>>>> Anyway it is easier to have this without negation and you already
>>>>> enumerate all variants (here and below).
>>>>
>>>> About this part, I don't think that works. See this:
>>>>
>>>> $ git grep -A 15 'imx2[38]-dma-apb[hx]' arch/ | grep
>>>> '\(imx2[38]-dma-apb[hx]\|dma-channels\)'
>>>> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbh";
>>>> arch/arm/boot/dts/imx23.dtsi- dma-channels = <8>;
>>>> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbx";
>>>> arch/arm/boot/dts/imx23.dtsi- dma-channels = <16>;
>>>> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbh";
>>>> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
>>>> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbx";
>>>> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
>>>> arch/arm/boot/dts/imx6qdl.dtsi: compatible = "fsl,imx6q-dma-apbh",
>>>> "fsl,imx28-dma-apbh";
>>>> arch/arm/boot/dts/imx6qdl.dtsi- dma-channels = <4>;
>>>> arch/arm/boot/dts/imx6sx.dtsi: compatible = "fsl,imx6sx-dma-apbh",
>>>> "fsl,imx28-dma-apbh";
>>>> arch/arm/boot/dts/imx6sx.dtsi- dma-channels = <4>;
>>>> arch/arm/boot/dts/imx6ul.dtsi: compatible = "fsl,imx6q-dma-apbh",
>>>> "fsl,imx28-dma-apbh";
>>>> arch/arm/boot/dts/imx6ul.dtsi- dma-channels = <4>;
>>>> arch/arm/boot/dts/imx7s.dtsi: compatible = "fsl,imx7d-dma-apbh",
>>>> "fsl,imx28-dma-apbh";
>>>> arch/arm/boot/dts/imx7s.dtsi- dma-channels = <4>;
>>>> arch/arm64/boot/dts/freescale/imx8mm.dtsi: compatible =
>>>> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
>>>> arch/arm64/boot/dts/freescale/imx8mm.dtsi- dma-channels = <4>;
>>>> arch/arm64/boot/dts/freescale/imx8mn.dtsi: compatible =
>>>> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
>>>> arch/arm64/boot/dts/freescale/imx8mn.dtsi- dma-channels = <4>;
>>>>
>>>> So I think what we have to do to validate that, is, say
>>>>
>>>> default: 4
>>>>
>>>> if does not match on 6q/6sx/7d/23-apbx/28-abbh/28-apbx then 8
>>>>
>>>> if does not match on 6q/6sx/7d/23-apbh then 16
>>>>
>>>> But if there is a better way to validate the above, please do tell.
>>>
>>> Then your existing if:then: is also not correct because you require for
>>> fsl,imx28-dma-apbh (as it is not in second if:then:) const:16. Just
>>> don't require it.
>>
>> So, shall I just drop the entire allOf: section ?
> 
> No, what about the interrupts?

The interrupts and dma-channels are matched 1:1 for this controller, 1 
DMA channel, 1 interrupt. 16 dma channels means 16 interrupts .
