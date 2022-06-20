Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB273552844
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 01:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbiFTXWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347412AbiFTXW1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 19:22:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B622502
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655767048; x=1687303048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Iz6YFZtbcFYcwcjopjjArKVT0IuGvxeSilsHzUbATU=;
  b=cUQyC8v4SCRLlJsMvP5niOL+bbyR5ZK2Tm10SHH+4H5FN1bmd8SB+LOj
   2xfXbm18qDNFpKVUz9tBJC1I6hOgiAVwYXV8zbr+xTkP0BSN2o36UKFfa
   Z766qsot88AyKqBOE1uellK3b17SaD80vNvmK+RConfIxn0KUSwex9Kqv
   VgRGNB49trbmwpIO9vf6E7U5gGgwFvT1RMg4vgCXlmp8h42N656bebjbK
   xcN0FXIrpcXT0VwTpRaA7zZdGFQCk4aqa51DRq50RLcKbF1ewc7O0k59N
   W8LvimhkQYxo8B61HC5VAvFd3EnhCuIRyGGaXtDFkHlE1BCLIRNTagpSS
   g==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="208521890"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:17:28 +0800
IronPort-SDR: nl0a8o/z8azQPlWpSA3niCa80Q1h79ZGYSyx9Dc4A2OsMTfLj2Qv1kg7Qoye5wvNvjGGdayi2v
 yt1XE3nDHA6KzPnFN7qvhj7Qv6GyE7ct+Ra8Js21U122dRndpFxC7RQv6N2RD0m0Iesi6PgO8s
 jyQR5WkAb7l6g6WkFFNtP0CZG+mHF41ML5cBcrfr0Knb3OPQoGzFWm+h1m034mjs6kh7OMVAq4
 DQdKH/27svqgvwm34oeyuUYLmY8qUD4uEqA71ho1lbM4mYPFaw8B1HfS4SaW05a1+adQRGf4X0
 ztmQVIsjHgy7QpYO8epLLgex
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:39:59 -0700
IronPort-SDR: A/FLooiRXEH/KVDCugQdvY6/1ZU2vSVTpdroH74I2yEPrnwUrTWYTsZwxpHFa2aNCUZ/IXc73w
 RKt1COlp+Rb9pO0zPzVmABQLEwFqVwxvZ+xfPKrBGFoIPlobh0r/g/LhRMFF8MjS/1grX1/btG
 HZvZsCIIG70WZ2h49obYBgWf4oO/vxy8XkWuwRJMQu4qpyLLW6Vzc6u6Svsr/mSNYEQ/AN70/J
 28QyDRlWNysZGzE76z3B7IGTz3p5Ffyf6piU7M+q5njUR8SZkynnbdAHRyFUxWu6LBYupCW4Xb
 Kv8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:17:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRlsz5llfz1SVp3
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 16:17:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655767046; x=1658359047; bh=8Iz6YFZtbcFYcwcjopjjArKVT0IuGvxeSil
        sHzUbATU=; b=IIz0tfLvEcN1B2Jkb3lPD4RxNBWLqq4N1VPYpVwejCZ45TFDPT5
        vj9tEpsH7AJcEfcDJ1EbX0nn96+dD5U/qdQtJdQKkNkipcexJs9t1i+JMw/jjdks
        9VwH9MxppJ4DGmMbopxfjZFBsMS3fgF/h7XuMjBJTlcEzwkMGDrUX3n4FUVz1M5i
        1tmGXLYebpRmWNIB0Oypk2CW5DwRtn84Uiac2avIDW0uRos3IMbt1W2WlscT90Nc
        vRuyXi9Mk4qsQ9U+D1FWJh2ScxBzLFRPxcMNq12cFYUldKuROiFA3i+5zloQwMhV
        OzAunPB+YTz3Y4CoRBH4QfEhhgGR9hjvA6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yAFB_3NiJDB5 for <dmaengine@vger.kernel.org>;
        Mon, 20 Jun 2022 16:17:26 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRlss3Tsdz1Rvlc;
        Mon, 20 Jun 2022 16:17:21 -0700 (PDT)
Message-ID: <c272728f-f610-77df-bd9b-c9fee6b727f8@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:17:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, Conor.Dooley@microchip.com,
        fancer.lancer@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
 <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
 <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/21/22 07:49, Conor Dooley wrote:
> 
> 
> On 20/06/2022 23:46, Damien Le Moal wrote:
>> On 6/21/22 06:06, Conor.Dooley@microchip.com wrote:
>>> On 20/06/2022 21:56, Serge Semin wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
>>>>> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
>>>>> this.
>>>>>
>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>>>>>  1 file changed, 35 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> index e25d44c218f2..f2b9e3f062cd 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> @@ -135,19 +135,41 @@ properties:
>>>>>        of the designware controller, and the upper limit is also subject to
>>>>>        controller configuration.
>>>>>
>>>>> -patternProperties:
>>>>> -  "^.*@[0-9a-f]+$":
>>>>> -    type: object
>>>>> -    properties:
>>>>> -      reg:
>>>>> -        minimum: 0
>>>>> -        maximum: 3
>>>>> -
>>>>> -      spi-rx-bus-width:
>>>>> -        const: 1
>>>>> -
>>>>> -      spi-tx-bus-width:
>>>>> -        const: 1
>>>>> +if:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        const: snps,dwc-ssi-1.01a
>>>>> +
>>>>> +then:
>>>>> +  patternProperties:
>>>>> +    "^.*@[0-9a-f]+$":
>>>>> +      type: object
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minimum: 0
>>>>> +          maximum: 3
>>>>> +
>>>>> +        spi-rx-bus-width:
>>>>> +          const: 4
>>>>> +
>>>>> +        spi-tx-bus-width:
>>>>> +          const: 4
>>>>> +
>>>>> +else:
>>>>> +  patternProperties:
>>>>> +    "^.*@[0-9a-f]+$":
>>>>> +      type: object
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minimum: 0
>>>>> +          maximum: 3
>>>>> +
>>>>> +        spi-rx-bus-width:
>>>>> +          const: 1
>>>>> +
>>>>> +        spi-tx-bus-width:
>>>>> +          const: 1
>>>>
>>>> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
>>>
>>> 8 too? sure.
>>>
>>>> irrespective from the compatible string. The modern DW APB SSI
>>>> controllers of v.4.* and newer also support the enhanced SPI Modes too
>>>> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
>>>> run-time there is no way to create a DT-schema correctly constraining
>>>> the Rx/Tx SPI bus widths. So let's keep the
>>>> compatible-string-independent "patternProperties" here but just extend
>>>> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
>>>> properties values.
>>>
>>> SGTM!
>>>
>>>>
>>>> Note the DW APB SSI/AHB SSI driver currently doesn't support the
>>>> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
>>>> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
>>>> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
>>>> activated by means of the corresponding CSR. So most likely the DW AHB
>>>> SSI controllers need some specific setups too.
>>>
>>> hmm, well I'll leave that up to people that have Canaan hardware!
>>
>> I will test this series.
>>
> 
> Cool, thanks.
> I'll try to get a respin out tomorrow w/ the memory node "unfixed".

OK. I will test that then :)

> Conor.
> 
>>> Thanks,
>>> Conor.
>>>
>>>>
>>>> -Sergey
>>>>
>>>>>
>>>>>  unevaluatedProperties: false
>>>>>
>>>>> --
>>>>> 2.36.1
>>>>>
>>>
>>
>>


-- 
Damien Le Moal
Western Digital Research
