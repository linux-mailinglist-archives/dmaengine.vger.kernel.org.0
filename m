Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2263787413
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjHXP0H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbjHXPZt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 11:25:49 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D219B7;
        Thu, 24 Aug 2023 08:25:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1692890743; bh=19CkIfvlAl+YSMEuVQTfws4iElND6kxTEoiR5RaC2Xg=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=NKd7o6qaEKUtlt5GVLO8Z2r/oFM7RxV0FJywpSnr6OiEyKobQ9KeuvXCSpoJIEy11
         zqX6BC6hbyiTImS0q3TYRg2tj223AR1ZPJtUlfygaMpDYahS7w0wBGu/YNQb70UBeI
         QX7mZosai947/6+yuBwQ1scIm9fDTkNtZmw13kus=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <ZMuQvhIg0AHH2e7V@matsya>
Date:   Thu, 24 Aug 2023 17:25:41 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <831F5957-18B4-4EB9-A755-0E5FE58A83E5@cutebit.org>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org> <ZMlLjg9UBi3QO/qV@matsya>
 <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
 <38B71067-7D67-41B7-BF49-87511BAA06CF@cutebit.org> <ZMuQvhIg0AHH2e7V@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 3. 8. 2023, at 13:34, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 03-08-23, 10:32, Martin Povi=C5=A1er wrote:
>=20
>>>>> +static int sio_alloc_tag(struct sio_data *sio)
>>>>> +{
>>>>> +	struct sio_tagdata *tags =3D &sio->tags;
>>>>> +	int tag, i;
>>>>> +
>>>>> +	/*
>>>>> +	 * Because tag number 0 is special, the usable tag range
>>>>> +	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
>>>>> +	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
>>>>> +	 */
>>>>> +
>>>>> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
>>>>> +	tag =3D (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
>>>>> +
>>>>> +	for (i =3D 0; i < SIO_USABLE_TAGS; i++) {
>>>>> +		if (!test_and_set_bit(tag, &tags->allocated))
>>>>> +			break;
>>>>> +
>>>>> +		tag =3D (tag % SIO_USABLE_TAGS) + 1;
>>>>> +	}
>>>>> +
>>>>> +	WRITE_ONCE(tags->last_tag, tag);
>>>>> +
>>>>> +	if (i < SIO_USABLE_TAGS)
>>>>> +		return tag;
>>>>> +	else
>>>>> +		return -EBUSY;
>>>>> +#undef SIO_USABLE_TAGS
>>>>> +}
>>>>=20
>>>> can you use kernel mechanisms like ida to alloc and free the =
tags...
>>>=20
>>> I can look into that.
>>=20
>> Documentation says IDA is deprecated in favour of Xarray, both look
>> like they serve to associate a pointer with an ID. I think neither
>> structure beats a simple bitfield and a static array for the per-tag
>> data. Agree?
>=20
> yeah xarray am not too sure. I would still go with ida, we will see =
when
> it is relly removed.

Sorry for letting this sleep for a while.

I don=E2=80=99t like the idea of submitting a new driver to use a =
deprecated
interface. For all I know someone can come along later and mark the =
driver
as broken in the process of finally removing IDA, with good excuse to do =
so.

> If you need a bitfield why not use bitmap apis.
> I dont like drivers implementing the basic logic which kernel provides

I think one improvement to take up is to use the DECLARE_BITMAP macro =
for
the `allocated` bitmap. Other than that this already uses the bitmap.h/
bitops.h functions to the degree it can if the goal is to

 (1) allocate and free the tags reliably under SMP with atomic ops

 (2) in best-effort manner (but without locking of the counter) make
     the tag numbers consecutive

The latter behaviour is there to make traces easier to read.

Martin

> --=20
> ~Vinod

