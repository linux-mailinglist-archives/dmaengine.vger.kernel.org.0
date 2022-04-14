Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D594501A8A
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiDNRzG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbiDNRzG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 13:55:06 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C6EA75C;
        Thu, 14 Apr 2022 10:52:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1649958757; bh=6C6PdBrdjpVD+lDLvCPNyZNWgXILs8pi8aPP0Tgp7b4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=fK6IYtcazQmhRt8qRgxHB5m3SJz42BhC54qK2Y6vVu0LIsJH5deQAcZlPl45WMt+X
         Is1cuRiFSq/6NpORZ26A5ao+ymQfWM6WXdUSxz4opAgk3skNIzNcf/eFbSeTBDIOz3
         hD+abQvC3nKril/fb+Y0rUta35cg2lhEfq1zAZxs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: Add Apple ADMAC
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <85DF53F6-74BA-4D8D-8E8E-DFD67B24DA19@cutebit.org>
Date:   Thu, 14 Apr 2022 19:52:36 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9849767-1A50-4C57-AE40-3DD7FB475130@cutebit.org>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
 <20220411222204.96860-2-povik+lin@cutebit.org>
 <YlhBLJQVYvTGlx4o@robh.at.kernel.org>
 <85DF53F6-74BA-4D8D-8E8E-DFD67B24DA19@cutebit.org>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 14. 4. 2022, at 19:23, Martin Povi=C5=A1er <povik@cutebit.org> =
wrote:
>=20
>>=20
>> On 14. 4. 2022, at 17:43, Rob Herring <robh@kernel.org> wrote:
>>=20
>> On Tue, Apr 12, 2022 at 12:22:03AM +0200, Martin Povi=C5=A1er wrote:
>>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store =
audio
>>> samples on SoCs from the "Apple Silicon" family.
>>>=20
>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>> ---
>>>=20
>>> After the v1 discussion, I dropped the =
apple,internal-irq-destination
>>> property and instead the index of the usable interrupt is now =
signified
>>> by prepending -1 entries to the interrupts=3D list. This works when =
I do
>>> it like this:
>>>=20
>>> interrupt-parent =3D <&aic>;
>>> interrupts =3D <AIC_IRQ 0xffffffff 0>,
>>> <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
>>=20
>>=20
>> BTW, just use '-1'. dtc takes negative values (and other =
expressions).
>=20
> Ha! <-1> didn=E2=80=99t work for me but <(-1)> does.
>=20
>>=20
>>>=20
>>> I would find it neat to do it like this:
>>>=20
>>> interrupts-extended =3D <0xffffffff>,
>>> <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
>>>=20
>>> but unfortunately the kernel doesn't pick up on it:
>>>=20
>>> [ 0.767964] apple-admac 238200000.dma-controller: error -6: IRQ =
index 0 not found
>>> [ 0.773943] apple-admac 238200000.dma-controller: error -6: IRQ =
index 1 not found
>>> [ 0.780154] apple-admac 238200000.dma-controller: error -6: IRQ =
index 2 not found
>>> [ 0.786367] apple-admac 238200000.dma-controller: error -6: IRQ =
index 3 not found
>>> [ 0.788592] apple-admac 238200000.dma-controller: error -6: no =
usable interrupt
>>=20
>> We should make this case work. It is less fragile IMO as it doesn't=20=

>> depend on the provider's translation of cells.
>=20
> Then I may send some patch to that end.

Turns out there=E2=80=99s no need. Passing in <0> in place of a phandle =
reference
looks like what we want:
=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/of/base.c?h=3Dv5.18-rc2#n1334

(Confirmed by testing to do the right thing with the IRQs.)

Martin=
