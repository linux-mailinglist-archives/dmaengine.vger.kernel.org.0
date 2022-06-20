Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E6552716
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 00:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiFTWql (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 18:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiFTWqj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 18:46:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887114022
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655765196; x=1687301196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HsNQYoVzbJStzX4az+4aldPwMmRKXzHlpXTfHEicD2Q=;
  b=ifPVyqCjbAJZHA5tBYWoFj3gNxXigUYZVsKuStjfTgKS77l7Ec8N1cjG
   Rk/E6LTFpKIWBTlbbBOd66R1F9oQcg+tkvq5TYIZKC1GeCDhWaW8zKkTt
   qXH3RG0HZrH+FYi+hDnES0fBlZEVGK5da2LuhCG3+0BB2trmxS28Cki21
   fiFG2oEi40juDom8bEw63EZeujZefAOWQyApgUUFe6rxEExzUed85K+Bh
   dHRSl1ylWqmMJFXHSDtyctLwhfp3TB0cANRxNQWFPC5hkRNV6M4C+kJSP
   EUN0l+wBUXEYHKtXDt5AjOf/SRhj1qN9aYyzNLdMC16VfYXM5RnNwNboK
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="208520272"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 06:46:36 +0800
IronPort-SDR: 0FlIf2lGbyCR7bYYAcaconhfPJ49Z2rzzPgXT97nlALmugF9RO4v0Paufv/tsUBdClyWCzmUsL
 CIvE+rdl96Q/Nm2wMm/X7CfoWG6nOiWCBrfije2k4kvMtuFZvSkgoo6kNYorvnbrFjLek3c8xi
 Gaa7ST7fXl2c3YHz4fIrbxVUqyJBF4L42NTyV9aUj9m6x+/p7Y8znq7t+Uav5Tz9OJ6Rkhwf3A
 WcyJtpWZjP5uMGIEolAdtvgEuMxycyWczhLfx9g284m/XZMCVjXMdFzaFVqR3O/AUG8O/QpAoH
 eUIeXV7w3ZwwzVfkRA7iRUR6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:09:08 -0700
IronPort-SDR: V/zDqAXtVxBAR9giEm6anzmRDcWGwIFqxl9ovKUYog/bEyFW5553kWlV87vEMm8hO4smRsJOvo
 28TJk8LWEwddWQ21rRtJt2l3o0Nqz/iVt8WIqxyBWOKv7BdatvxFtq/aaB9iJU6VHtz9ZPWwsM
 8Y+7cAGuSfvXWqxlWaFv0atkaO064cfaw41s9/0WCXOMlOreoCCMSOvpxTV/0eaH6ZV7urfWmV
 cNbP9Z0a59FL9C/rRjTuW/MAP6zqxYKTlEMEb6l0GcIXJq6n8Txj3Y/9v2L+uXI1tuSBjPxcKj
 pro=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:46:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRlBN397Zz1SVp2
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 15:46:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655765195; x=1658357196; bh=HsNQYoVzbJStzX4az+4aldPwMmRKXzHlpXT
        fHEicD2Q=; b=CgMTv5HEF2LWLR/xmzK6unobrKr7GS8iPYQabCr0jCxQs77QUb1
        gsOBb35y7MvK90lgWg+KX+ocwtj26q6vzQos7i/zs7VrFDkaAd+JcmIqQnKthG76
        zQkkLU1e3wFURfaTgRqrJvDcjb5CSUTrD8EU4VgeJiiQaZOcXmvZhKtRoqJWrYh+
        LaUp33TVh85pu9m7tO98VPke//r5Q9RLQ7TsUl49cnDof1SgI4qDdxsnqM+6hnAQ
        ZjUqRHU/iFVXCuz/5UhJ+kMWfYQudqCTL2Rgu+paQ5hpuyZuXqd011jjDhfR1vUS
        UKpjx+Cjfhcn4Bjd5xIXGSYSIeppWxdR56w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HLnVu9HLxvkb for <dmaengine@vger.kernel.org>;
        Mon, 20 Jun 2022 15:46:35 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRlBG25pSz1Rvlc;
        Mon, 20 Jun 2022 15:46:30 -0700 (PDT)
Message-ID: <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 07:46:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Content-Language: en-US
To:     Conor.Dooley@microchip.com, fancer.lancer@gmail.com,
        mail@conchuod.ie
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
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

On 6/21/22 06:06, Conor.Dooley@microchip.com wrote:
> On 20/06/2022 21:56, Serge Semin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
>>> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
>>> this.
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>>>  1 file changed, 35 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> index e25d44c218f2..f2b9e3f062cd 100644
>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> @@ -135,19 +135,41 @@ properties:
>>>        of the designware controller, and the upper limit is also subject to
>>>        controller configuration.
>>>
>>> -patternProperties:
>>> -  "^.*@[0-9a-f]+$":
>>> -    type: object
>>> -    properties:
>>> -      reg:
>>> -        minimum: 0
>>> -        maximum: 3
>>> -
>>> -      spi-rx-bus-width:
>>> -        const: 1
>>> -
>>> -      spi-tx-bus-width:
>>> -        const: 1
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: snps,dwc-ssi-1.01a
>>> +
>>> +then:
>>> +  patternProperties:
>>> +    "^.*@[0-9a-f]+$":
>>> +      type: object
>>> +      properties:
>>> +        reg:
>>> +          minimum: 0
>>> +          maximum: 3
>>> +
>>> +        spi-rx-bus-width:
>>> +          const: 4
>>> +
>>> +        spi-tx-bus-width:
>>> +          const: 4
>>> +
>>> +else:
>>> +  patternProperties:
>>> +    "^.*@[0-9a-f]+$":
>>> +      type: object
>>> +      properties:
>>> +        reg:
>>> +          minimum: 0
>>> +          maximum: 3
>>> +
>>> +        spi-rx-bus-width:
>>> +          const: 1
>>> +
>>> +        spi-tx-bus-width:
>>> +          const: 1
>>
>> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> 
> 8 too? sure.
> 
>> irrespective from the compatible string. The modern DW APB SSI
>> controllers of v.4.* and newer also support the enhanced SPI Modes too
>> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
>> run-time there is no way to create a DT-schema correctly constraining
>> the Rx/Tx SPI bus widths. So let's keep the
>> compatible-string-independent "patternProperties" here but just extend
>> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
>> properties values.
> 
> SGTM!
> 
>>
>> Note the DW APB SSI/AHB SSI driver currently doesn't support the
>> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
>> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
>> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
>> activated by means of the corresponding CSR. So most likely the DW AHB
>> SSI controllers need some specific setups too.
> 
> hmm, well I'll leave that up to people that have Canaan hardware!

I will test this series.

> Thanks,
> Conor.
> 
>>
>> -Sergey
>>
>>>
>>>  unevaluatedProperties: false
>>>
>>> --
>>> 2.36.1
>>>
> 


-- 
Damien Le Moal
Western Digital Research
