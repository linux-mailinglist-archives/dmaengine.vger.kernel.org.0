Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3E4EDE76
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiCaQPs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiCaQPs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 12:15:48 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A319FF8;
        Thu, 31 Mar 2022 09:13:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648743234; bh=BxE8wIN6zo6oZw87Bp/sf89zaabaM2ryoJcy+5lANO8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=S4LvguHX5OQUd+3hqCus3jymE1UDI9kMSUb0WNJ8hP64BQ2FzC5y7QCNO2BK0ySIJ
         T4k1A4IfwBXRH4IKEGwSWwfXpsgEog/XCLRvbmsjie1ZIuRYukWI6RCN009VeZicjU
         MhIXhFIuYBpAoZnX/abRjc6QzzesEMFoW+LUMqZQ=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkW2OG3dU4YFYJEZ@matsya>
Date:   Thu, 31 Mar 2022 18:13:53 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B75EEC8B-FE88-47EA-8F56-0DD7EDE0DB77@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org> <YkU6yvUQ6v4VdXiJ@matsya>
 <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
 <265B2992-06E5-4E45-A971-B170A385EFD4@cutebit.org> <YkW2OG3dU4YFYJEZ@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 31. 3. 2022, at 16:10, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 31-03-22, 09:06, Martin Povi=C5=A1er wrote:
>>=20
>>> On 31. 3. 2022, at 8:50, Martin Povi=C5=A1er <povik@cutebit.org> =
wrote:
>>>>=20
>>>> On 31. 3. 2022, at 7:23, Vinod Koul <vkoul@kernel.org> wrote:
>>>>=20
>>>> On 30-03-22, 18:44, Martin Povi=C5=A1er wrote:
>>>>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store =
audio
>>>>> samples on Apple SoCs from the "Apple Silicon" family.
>>>>>=20
>>>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>>>> ---
>>>>> .../devicetree/bindings/dma/apple,admac.yaml  | 73 =
+++++++++++++++++++
>>>>> 1 file changed, 73 insertions(+)
>>>>> create mode 100644 =
Documentation/devicetree/bindings/dma/apple,admac.yaml
>>>>>=20
>>>>> diff --git =
a/Documentation/devicetree/bindings/dma/apple,admac.yaml =
b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..34f76a9a2983
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>>>=20
>>>>> +  apple,internal-irq-destination:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: Index influencing internal routing of the IRQs
>>>>> +      within the peripheral.
>>>>=20
>>>> do you have more details for this, is this for peripheral and if so
>>>> suited to be in dam-cells?
>>>=20
>>> By peripheral I meant the DMA controller itself here.=20
>=20
> Dmaengine convention is that peripheral is device which we are doing =
dma
> to/from, like audio controller/fifo here
>=20
>>> Effectively the controller has four independent IRQ outputs and the =
driver
>>> needs to know which one we are using. (It need not be the same =
output even
>>> for different ADMAC instances on one die.)
>=20
> That smells like a mux to me.. why not use dma-requests for this?

I am not sure that=E2=80=99s right. Reading the dmaengine docs, DMA =
requests seem to have
to do with the DMA-controller-to-peripheral connection, but the proposed =
property
tells us which of four independent IRQ outputs of the DMA controller we =
actually
have in the interrupts=3D property. That is, it has to do with the =
DMA-controller-to-CPU
connection.

(I took the liberty of correcting my typo in the quotation.)

>=20
> --=20
> ~Vinod

