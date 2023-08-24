Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9208787458
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjHXPfq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbjHXPfU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 11:35:20 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDBB1BF8;
        Thu, 24 Aug 2023 08:34:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1692891289; bh=GwsgEUYaQb7+bVesJDUFzEJB/MJBATC71jeWdqAmb7g=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=KYOuD+79PobS0zc7xAahjmoTeI590qhuoXbsZ5P+bo8qXpka0aMYQI2AoOcYId/dp
         O5eVQfEVc7PNgvZmC+RhMp8jeJpMDktmxm46QWBlW9EjsAlS2aZTAHtF1d+MGeKsgV
         IDiwH57q9aK5KZm1sVQq4LTB6B31x0nEsp8V3Yl8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <ZMuOt2THchrNDjDH@matsya>
Date:   Thu, 24 Aug 2023 17:34:49 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18F85C87-4ED4-446C-8F63-901D85A9D474@cutebit.org>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org> <ZMlLjg9UBi3QO/qV@matsya>
 <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org> <ZMuOt2THchrNDjDH@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sorry I missed this message before.

> On 3. 8. 2023, at 13:25, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 01-08-23, 23:55, Martin Povi=C5=A1er wrote:
>=20
>>> can you use virt_dma_chan, that should simplify list handling etc
>>=20
>> I looked into that when I wrote the sister driver apple-admac.c, I =
don=E2=80=99t
>> remember anymore why I decided against it, and I don=E2=80=99t think =
it came up
>> during review. Now that this driver is done, I hope we can take it as =
is.
>>=20
>> There=E2=80=99s some benefit from the drivers having a similar =
structure, I sent
>> one or two fixes to apple-admac for things I found out because I was
>> writing this other driver.
>=20
> And this would be a chance to covert the other one and get rid of list
> handling code in that driver as well

I guess...

>>>> +};
>>>> +
>>>> +#define SIO_NTAGS		16
>>>> +
>>>> +typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);
>>>=20
>>> any reason not to use dmaengine callbacks?
>>=20
>> Not sure what dmaengine callback you mean here. This callback means
>> the coprocessor acked a tag, not sure how we can fit something =
dmaengine
>> onto it.
>=20
> Okay lets understand, how is this one used

This one is used to signal completion of IPC calls to the coprocessor =
when
that call is made from atomic context. Only user (currently) is issuing =
of
coproc descriptors. I can provide more detail but not sure in what
direction.

Martin

> --=20
> ~Vinod
>=20

