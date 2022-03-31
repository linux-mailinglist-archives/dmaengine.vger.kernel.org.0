Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5124ED45E
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiCaHIg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiCaHIf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 03:08:35 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64AB1AAA5C;
        Thu, 31 Mar 2022 00:06:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648710406; bh=E9Fz8PhIkj82LsVwjeRSlBVyoUrMc8J6qZRK95jJdng=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=IOl3Zwaqj93GibGB1CZjPC/RquumLOvc2LqMggtgCMV377UKKoSGfLkLB3D05BXGW
         uPgTa3v3Z0XfE8ui4CXmOB4OhUH+35j745lEEvDqfDWSDal8wm9Pv82T5eWjfwz+oI
         029ZjKd3blm2zAPmMd4jcsNtPc48GEmDWEJHU3w4=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
Date:   Thu, 31 Mar 2022 09:06:46 +0200
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
Message-Id: <265B2992-06E5-4E45-A971-B170A385EFD4@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org> <YkU6yvUQ6v4VdXiJ@matsya>
 <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 31. 3. 2022, at 8:50, Martin Povi=C5=A1er <povik@cutebit.org> =
wrote:
>=20
>>=20
>> On 31. 3. 2022, at 7:23, Vinod Koul <vkoul@kernel.org> wrote:
>>=20
>> On 30-03-22, 18:44, Martin Povi=C5=A1er wrote:
>>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store =
audio
>>> samples on Apple SoCs from the "Apple Silicon" family.
>>>=20
>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>> ---
>>> .../devicetree/bindings/dma/apple,admac.yaml  | 73 =
+++++++++++++++++++
>>> 1 file changed, 73 insertions(+)
>>> create mode 100644 =
Documentation/devicetree/bindings/dma/apple,admac.yaml
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml =
b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>>> new file mode 100644
>>> index 000000000000..34f76a9a2983
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>=20
>>> +  apple,internal-irq-destination:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Index influencing internal routing of the IRQs
>>> +      within the peripheral.
>>=20
>> do you have more details for this, is this for peripheral and if so
>> suited to be in dam-cells?
>=20
> By peripheral I meant the DMA controller itself here.=20
>=20
> Effectively the controller has four independent IRQ outputs and the =
driver
> needs to know which one we are using. (It need to be the same output =
even
> for different ADMAC instances on one die.)

Pardon, got an evil typo there: It need *not* be the same output... (And =
pardon
the other rich non-plaintext reply...)

