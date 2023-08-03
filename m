Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977DA76E337
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjHCIfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjHCIff (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 04:35:35 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75544B8;
        Thu,  3 Aug 2023 01:32:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1691051547; bh=I8UUkfnxct2qea8lWvMBTo7oncRQH0XhAYf9TPDGgYI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Z85MqlFGF/LBBt4moBDmsSdf7NH8QQQ2wwDAld9L3Cpb19uA2fYHtkhVEdrClATcp
         XL2IgVo0Wf7Sn1TibSIFk3wEFfByuUDi6Lkz18oi2r7XoFgmo7LSYJ8zkyviC/Bjwj
         EW585564lKGaIx7pLytd/gYu9RnvO+EcqcTHIJi0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
Date:   Thu, 3 Aug 2023 10:32:25 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <38B71067-7D67-41B7-BF49-87511BAA06CF@cutebit.org>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org> <ZMlLjg9UBi3QO/qV@matsya>
 <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 1. 8. 2023, at 23:55, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> Hi Vinod!
>=20
>> On 1. 8. 2023, at 20:14, Vinod Koul <vkoul@kernel.org> wrote:
>>=20
>> On 12-07-23, 15:38, Martin Povi=C5=A1er wrote:
>>=20
>>> +struct sio_chan {
>>> +	unsigned int no;
>>> +	struct sio_data *host;
>>> +	struct dma_chan chan;
>>> +	struct tasklet_struct tasklet;
>>> +	struct work_struct terminate_wq;
>>> +
>>> +	spinlock_t lock;
>>> +	struct sio_tx *current_tx;
>>> +	/*
>>> +	 * 'tx_cookie' is used for distinguishing between transactions =
from
>>> +	 * within tag ack/nack callbacks. Without it, we would have no =
way
>>> +	 * of knowing if the current transaction is the one the callback =
handler
>>> +	 * was installed for.
>>=20
>> not sure what you mean by here.. I dont see why you would need to =
store
>> cookie here, care to explain?
>=20
> I could have clarified this is not meant to be the dmaengine cookie, =
just
> a driver-level cookie to address a race between
>=20
> 	a dmaengine user calling terminate_all to terminate a running
> 	cyclic transaction, then issuing a new one
>=20
> on one hand, and
>=20
> 	the coprocessor acking the issuing of one of the coprocessor
> 	transactions that correspond to the first dmaengine transaction
>=20
> on the other hand. With the cookie the driver should not get confused
> about which dmaengine transaction the ACK belongs to, since if =
`current_tx`
> changed in the meantime the cookie won=E2=80=99t match.
>=20
> But now that I look at it... huh, I never increment that `tx_cookie` =
field!
> I don=E2=80=99t know if I have considered using the dmaengine cookie =
to the same
> effect. Maybe we can do that, I see how that would be much desirable.

Indeed nothing is stopping us from matching on the dmaengine cookie to
address the race, so I will be dropping this `tx_cookie` field in v2.

>>> +static int sio_alloc_tag(struct sio_data *sio)
>>> +{
>>> +	struct sio_tagdata *tags =3D &sio->tags;
>>> +	int tag, i;
>>> +
>>> +	/*
>>> +	 * Because tag number 0 is special, the usable tag range
>>> +	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
>>> +	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
>>> +	 */
>>> +
>>> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
>>> +	tag =3D (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
>>> +
>>> +	for (i =3D 0; i < SIO_USABLE_TAGS; i++) {
>>> +		if (!test_and_set_bit(tag, &tags->allocated))
>>> +			break;
>>> +
>>> +		tag =3D (tag % SIO_USABLE_TAGS) + 1;
>>> +	}
>>> +
>>> +	WRITE_ONCE(tags->last_tag, tag);
>>> +
>>> +	if (i < SIO_USABLE_TAGS)
>>> +		return tag;
>>> +	else
>>> +		return -EBUSY;
>>> +#undef SIO_USABLE_TAGS
>>> +}
>>=20
>> can you use kernel mechanisms like ida to alloc and free the tags...
>=20
> I can look into that.

Documentation says IDA is deprecated in favour of Xarray, both look
like they serve to associate a pointer with an ID. I think neither
structure beats a simple bitfield and a static array for the per-tag
data. Agree?

Martin

