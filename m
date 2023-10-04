Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425677B812D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjJDNly (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJDNly (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 09:41:54 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 06:41:47 PDT
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF89B;
        Wed,  4 Oct 2023 06:41:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1696426905; bh=sU/d24Q9y2TCzdvOpiUL9hCru3TADvlA0JRFhZXYqr4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ZND2d/K2BraU0o69mMKc565+4XuYVzNaDsTGyFxT/ohiJmYe/OX7CY9nTEMyU8bgL
         5xaksDcCQc3gFlnLgJhRq6aMUJRZxpdOe3Zhvn6qzqWOP1YlC3MmoajmP+x/Db2r45
         LNSnbPU/7JlhOuwJN4Cr44TEk6FTjggblYAbYaFU=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <06444557-414A-4710-88A0-620975BB258A@cutebit.org>
Date:   Wed, 4 Oct 2023 15:41:35 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E0D0316-5AE4-49D1-B687-E72BDC203245@cutebit.org>
References: <20230828170013.75820-1-povik+lin@cutebit.org>
 <20230828170013.75820-3-povik+lin@cutebit.org> <ZR1kz7Sil8onc1uC@matsya>
 <06444557-414A-4710-88A0-620975BB258A@cutebit.org>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> On 4. 10. 2023, at 15:32, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
>=20
> Hello Vinod,
>=20
> some of those things we have discussed on v1 already, let me link
> that here:
> =
https://lore.kernel.org/asahi/20230712133806.4450-1-povik+lin@cutebit.org/=
T/#t
>=20
> Anyway find my replies below.
>=20
> Best regards, Martin
>=20
>> On 4. 10. 2023, at 15:12, Vinod Koul <vkoul@kernel.org> wrote:
>>=20
>> On 28-08-23, 19:00, Martin Povi=C5=A1er wrote:
>>> Add a dmaengine driver for the Apple SIO coprocessor found on Apple
>>> SoCs where it provides DMA services. Have the driver support cyclic
>>> transactions so that ALSA drivers can rely on it in audio output to
>>> HDMI and DisplayPort.
>>>=20
>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>> ---
>>> MAINTAINERS             |   2 +
>>> drivers/dma/Kconfig     |  11 +
>>> drivers/dma/Makefile    |   1 +
>>> drivers/dma/apple-sio.c | 868 =
++++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 882 insertions(+)
>>> create mode 100644 drivers/dma/apple-sio.c

...

>>> +/*
>>> + * There are two kinds of 'transaction descriptors' in play here.
>>> + *
>>> + * There's the struct sio_tx, and the struct =
dma_async_tx_descriptor embedded
>>> + * inside, which jointly represent a transaction to the dmaengine =
subsystem.
>>> + * At this time we only support those transactions to be cyclic.
>>> + *
>>> + * Then there are the coprocessor descriptors, which is what the =
coprocessor
>>> + * knows and understands. These don't seem to have a cyclic regime, =
so we can't
>>> + * map the dmaengine transaction on an exact coprocessor =
counterpart. Instead
>>> + * we continually queue up many coprocessor descriptors to =
implement a cyclic
>>> + * transaction.
>>> + *
>>> + * The number below is the maximum of how far ahead (how many) =
coprocessor
>>> + * descriptors we should be queuing up, per channel, for a cyclic =
transaction.
>>> + * Basically it's a made-up number.
>>> + */
>>> +#define SIO_MAX_NINFLIGHT 4
>>=20
>> you meant SIO_MAX_INFLIGHT if not what is NINFLIGHT?
>=20
> I mean the number is arbitrary, it doesn=E2=80=99t reflect any =
coprocessor limit since
> I haven=E2=80=99t run the tests to figure one out. It's supposed to be =
a small reasonable
> number.

Ah I didn=E2=80=99t get what you were commenting on at first. Sure, =
INFLIGHT, NINFLIGHT,
it=E2=80=99s the same thing to me. I have a tendency to put in the N to =
signify it=E2=80=99s
the =E2=80=9Cnumber of=E2=80=9D.

Best,
Martin

