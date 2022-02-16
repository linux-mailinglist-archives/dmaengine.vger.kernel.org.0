Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4F4B8A09
	for <lists+dmaengine@lfdr.de>; Wed, 16 Feb 2022 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiBPNaj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Feb 2022 08:30:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiBPNaj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Feb 2022 08:30:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503E166E1C;
        Wed, 16 Feb 2022 05:30:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 09C711F44F25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645018225;
        bh=6TNpGK8zWpLJR4SWBSz6HDHFqS/9HoJTweDutJs2r+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bZl6VkU23kDApqPl22M6OdeZgLwPmwnZVWnPYDYSAXq/kV+2erzIBtg5HL7q+IKjg
         qxKUosxylyJq+GQ6Db5nOCIY2FVkNc4TWtE4potHevzKGSgNhLatcZPuDecltJ7Idt
         ciTgiKKJ3+EYoVWBvo+5OSCxjbGoOwUboicbdkByV+52jS9nOo9D8BpHTsvwqANvJq
         TSTnx60JX+pj/eBInRC4GGcSJApV7S03hBhO6J1jLIxvBswHXU8mUMWWMyYdqTGf9Z
         14nmrQjpa32BO5MV6D4cwwAMaZl5EmJ0cNGhQZFPtGAUaqrG9vTEoqANLdLo1ODqEL
         EFB3E368NyWNQ==
Message-ID: <dc523c4f-e625-7651-2621-fe1aab574a5f@collabora.com>
Date:   Wed, 16 Feb 2022 14:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        vkoul@kernel.org
Cc:     robh+dt@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220216114054.269656-1-angelogioacchino.delregno@collabora.com>
 <79a47f67-bb66-bad4-b6bc-c6a8c0ef25dc@canonical.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <79a47f67-bb66-bad4-b6bc-c6a8c0ef25dc@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Il 16/02/22 14:26, Krzysztof Kozlowski ha scritto:
> On 16/02/2022 12:40, AngeloGioacchino Del Regno wrote:
>> Convert the MediaTek UART APDMA Controller binding to DT schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/dma/mediatek,uart-dma.yaml       | 112 ++++++++++++++++++
>>   .../bindings/dma/mtk-uart-apdma.txt           |  56 ---------
>>   2 files changed, 112 insertions(+), 56 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>> new file mode 100644
>> index 000000000000..4583c8f535b2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>> @@ -0,0 +1,112 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/mediatek,uart-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek UART APDMA controller
>> +
>> +maintainers:
>> +  - Long Cheng <long.cheng@mediatek.com>
>> +
>> +description: |
>> +  The MediaTek UART APDMA controller provides DMA capabilities
>> +  for the UART peripheral bus.
>> +
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt2712-uart-dma
>> +              - mediatek,mt8516-uart-dma
>> +          - const: mediatek,mt6577-uart-dma
>> +      - enum:
>> +          - mediatek,mt6577-uart-dma
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 16
>> +
>> +  interrupts:
>> +    description: |
>> +      TX, RX interrupt lines for each UART APDMA channel
>> +    minItems: 1
> 
> It would be useful to have an "if:" block constraining the interrupts
> (and reg array?), if the dma-requests is missing. If you need an
> example, see length of "max8997,pmic-buck1-dvs-voltage" array in
> relation to presence of max8997,pmic-buck1-uses-gpio-dvs.
> https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml#L259
> 
> The best would be to restrict number of interrupts to number of
> requests, but I think dtschema cannot express this.
> 

Thank you for the very much appreciated example!

I don't think that dtschema can express that without an if block... so, I'll
use that.

>> +    maxItems: 32
>> +
>> +  clocks:
>> +    description: Must contain one entry for the APDMA main clock
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: apdma
>> +
>> +  "#dma-cells":
>> +    const: 1
>> +    description: |
>> +      The first cell specifies the UART APDMA channel number
>> +
>> +  dma-requests:
>> +    description: |
>> +      Number of virtual channels of the UART APDMA controller
>> +    maximum: 16
>> +
>> +  mediatek,dma-33bits:
>> +    type: boolean
>> +    description: Enable 33-bits UART APDMA support
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - "#dma-cells"
> 
> No need for requiring dma-cells. It is coming from dma-common.yaml.

Right. Forgot about that, will fix!

> 
>> +
> 
> Best regards,
> Krzysztof



