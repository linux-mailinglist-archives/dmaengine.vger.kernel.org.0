Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2734ED429
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiCaGwo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiCaGwn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 02:52:43 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C24E399;
        Wed, 30 Mar 2022 23:50:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648709449; bh=tbTLjhDtA27Ei4tnqxDxsAxJnPR7aMZnIG1OFwICCmM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Jvz6KZ18Rl5LMvyEw4xhUWabaSxNNSTSIwayr2upFtq1bQMqyGaWUb4N5Uq/SD3aS
         S2hNghUDl8ossPitQ7vNp5tYI9s7WoQSiTnjKqL9YH956/rnyoWCeKR9L2OLBoFDOD
         htD+K9shQEAaI3lK3+IUayjYsqL0tkZhK4pHiTa4=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkU6yvUQ6v4VdXiJ@matsya>
Date:   Thu, 31 Mar 2022 08:50:48 +0200
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
Message-Id: <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org> <YkU6yvUQ6v4VdXiJ@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 31. 3. 2022, at 7:23, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 30-03-22, 18:44, Martin Povi=C5=A1er wrote:
>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
>> samples on Apple SoCs from the "Apple Silicon" family.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> .../devicetree/bindings/dma/apple,admac.yaml  | 73 =
+++++++++++++++++++
>> 1 file changed, 73 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/dma/apple,admac.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml =
b/Documentation/devicetree/bindings/dma/apple,admac.yaml
>> new file mode 100644
>> index 000000000000..34f76a9a2983
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml

>> +  apple,internal-irq-destination:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Index influencing internal routing of the IRQs
>> +      within the peripheral.
>=20
> do you have more details for this, is this for peripheral and if so
> suited to be in dam-cells?

By peripheral I meant the DMA controller itself here.=20

Effectively the controller has four independent IRQ outputs and the =
driver
needs to know which one we are using. (It need to be the same output =
even
for different ADMAC instances on one die.)

