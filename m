Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC55019F8
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbiDNR0L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 13:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbiDNR0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 13:26:11 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690EBC86D;
        Thu, 14 Apr 2022 10:23:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1649957019; bh=K/5Wq1Coy5UPF41OrOzi6vwncUsz5ByKlFemTpBp7mY=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=hHDv4/Ynbqnqn0H/mQ1PdwX3ZHXaSri9w1/fC7gnILTEIs2KrwouTQnFXGDfmVetG
         q9E/sLo550tFhbSI98Qpj7/kwq4FuU4xgcqhXAx5RukKiTbL3Z0BS/8opuXBG8uiJU
         BX5rZcrhJOCWRDZchqFZAqlnh9URYk9oFjaqn0A0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: Add Apple ADMAC
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YlhBLJQVYvTGlx4o@robh.at.kernel.org>
Date:   Thu, 14 Apr 2022 19:23:38 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85DF53F6-74BA-4D8D-8E8E-DFD67B24DA19@cutebit.org>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
 <20220411222204.96860-2-povik+lin@cutebit.org>
 <YlhBLJQVYvTGlx4o@robh.at.kernel.org>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 14. 4. 2022, at 17:43, Rob Herring <robh@kernel.org> wrote:
>=20
> On Tue, Apr 12, 2022 at 12:22:03AM +0200, Martin Povi=C5=A1er wrote:
>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
>> samples on SoCs from the "Apple Silicon" family.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>>=20
>> After the v1 discussion, I dropped the apple,internal-irq-destination
>> property and instead the index of the usable interrupt is now =
signified
>> by prepending -1 entries to the interrupts=3D list. This works when I =
do
>> it like this:
>>=20
>>  interrupt-parent =3D <&aic>;
>>  interrupts =3D <AIC_IRQ 0xffffffff 0>,
>>               <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
>=20
>=20
> BTW, just use '-1'. dtc takes negative values (and other expressions).

Ha! <-1> didn=E2=80=99t work for me but <(-1)> does.

>=20
>>=20
>> I would find it neat to do it like this:
>>=20
>>  interrupts-extended =3D <0xffffffff>,
>>                        <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
>>=20
>> but unfortunately the kernel doesn't pick up on it:
>>=20
>> [    0.767964] apple-admac 238200000.dma-controller: error -6: IRQ =
index 0 not found
>> [    0.773943] apple-admac 238200000.dma-controller: error -6: IRQ =
index 1 not found
>> [    0.780154] apple-admac 238200000.dma-controller: error -6: IRQ =
index 2 not found
>> [    0.786367] apple-admac 238200000.dma-controller: error -6: IRQ =
index 3 not found
>> [    0.788592] apple-admac 238200000.dma-controller: error -6: no =
usable interrupt
>=20
> We should make this case work. It is less fragile IMO as it doesn't=20
> depend on the provider's translation of cells.

Then I may send some patch to that end.

>>=20
>> .../devicetree/bindings/dma/apple,admac.yaml  | 68 =
+++++++++++++++++++
>> 1 file changed, 68 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/dma/apple,admac.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml =
b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>> new file mode 100644
>> index 000000000000..bbd5eaf5f709
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple Audio DMA Controller (ADMAC)
>> +
>> +description: |
>> +  Apple's Audio DMA Controller (ADMAC) is used to fetch and store =
audio samples
>> +  on SoCs from the "Apple Silicon" family.
>> +
>> +  The controller has been seen with up to 24 channels. Even-numbered =
channels
>> +  are TX-only, odd-numbered are RX-only. Individual channels are =
coupled to
>> +  fixed device endpoints.
>> +
>> +maintainers:
>> +  - Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> +
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t6000-admac
>> +          - apple,t8103-admac
>> +      - const: apple,admac
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#dma-cells':
>> +    const: 1
>> +    description:
>> +      Clients specify single cell with channel number.
>> +
>> +  dma-channels:
>> +    maximum: 24
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 4
>=20
> I'm now confused why this is variable. Put -1 entries on the end if=20
> that's why it is variable.

That=E2=80=99s why. Fixed length it is then.

>=20
> This needs some description about there being 1 of 4 outputs being=20
> connected.

OK. Description there will be.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#dma-cells'
>> +  - dma-channels
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    admac: dma-controller@238200000 {
>> +      compatible =3D "apple,t8103-admac", "apple,admac";
>> +      reg =3D <0x38200000 0x34000>;
>> +      dma-channels =3D <24>;
>> +      interrupt-parent =3D <&aic>;
>> +      interrupts =3D <AIC_IRQ 0xffffffff 0>,
>> +                   <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
>> +      #dma-cells =3D <1>;
>> +    };
>> --=20
>> 2.33.0
>>=20
>>=20

Martin

