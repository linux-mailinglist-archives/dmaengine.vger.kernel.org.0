Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266476BF95
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHAVzP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHAVzO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 17:55:14 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696F103;
        Tue,  1 Aug 2023 14:55:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1690926903; bh=5cd3+VNLF8xZ6lJKYpj4LYc+fiVvPNDsifiAF5qrQSg=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=T4uYuXHSUmW78IqK7Nz0bGZ6cpWR+xquQKx8AsPI3POjrw0muX8ooGGSHs1hK913n
         pozvZBiD0yS86wekdqQp3PVz6FQqKJ8O49TPnhalDxcVxrdN1zrxpS80mf2q93PR+j
         MEJnFM6i5RJAScbP3+HgwceG5+2hZC1QcinwUp30=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <ZMlLjg9UBi3QO/qV@matsya>
Date:   Tue, 1 Aug 2023 23:55:02 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org> <ZMlLjg9UBi3QO/qV@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod!

> On 1. 8. 2023, at 20:14, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 12-07-23, 15:38, Martin Povi=C5=A1er wrote:
>=20
>> +struct sio_chan {
>> +	unsigned int no;
>> +	struct sio_data *host;
>> +	struct dma_chan chan;
>> +	struct tasklet_struct tasklet;
>> +	struct work_struct terminate_wq;
>> +
>> +	spinlock_t lock;
>> +	struct sio_tx *current_tx;
>> +	/*
>> +	 * 'tx_cookie' is used for distinguishing between transactions =
from
>> +	 * within tag ack/nack callbacks. Without it, we would have no =
way
>> +	 * of knowing if the current transaction is the one the callback =
handler
>> +	 * was installed for.
>=20
> not sure what you mean by here.. I dont see why you would need to =
store
> cookie here, care to explain?

I could have clarified this is not meant to be the dmaengine cookie, =
just
a driver-level cookie to address a race between

	a dmaengine user calling terminate_all to terminate a running
	cyclic transaction, then issuing a new one

on one hand, and

	the coprocessor acking the issuing of one of the coprocessor
	transactions that correspond to the first dmaengine transaction

on the other hand. With the cookie the driver should not get confused
about which dmaengine transaction the ACK belongs to, since if =
`current_tx`
changed in the meantime the cookie won=E2=80=99t match.

But now that I look at it... huh, I never increment that `tx_cookie` =
field!
I don=E2=80=99t know if I have considered using the dmaengine cookie to =
the same
effect. Maybe we can do that, I see how that would be much desirable.

>> +	 */
>> +	unsigned long tx_cookie;
>> +	int nperiod_acks;
>> +
>> +	/*
>> +	 * We maintain a 'submitted' and 'issued' list mainly for =
interface
>> +	 * correctness. Typical use of the driver (per channel) will be
>> +	 * prepping, submitting and issuing a single cyclic transaction =
which
>> +	 * will stay current until terminate_all is called.
>> +	 */
>> +	struct list_head submitted;
>> +	struct list_head issued;
>> +
>> +	struct list_head to_free;
>=20
> can you use virt_dma_chan, that should simplify list handling etc

I looked into that when I wrote the sister driver apple-admac.c, I =
don=E2=80=99t
remember anymore why I decided against it, and I don=E2=80=99t think it =
came up
during review. Now that this driver is done, I hope we can take it as =
is.

There=E2=80=99s some benefit from the drivers having a similar =
structure, I sent
one or two fixes to apple-admac for things I found out because I was
writing this other driver.

>> +};
>> +
>> +#define SIO_NTAGS		16
>> +
>> +typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);
>=20
> any reason not to use dmaengine callbacks?

Not sure what dmaengine callback you mean here. This callback means
the coprocessor acked a tag, not sure how we can fit something dmaengine
onto it.

>> +static int sio_alloc_tag(struct sio_data *sio)
>> +{
>> +	struct sio_tagdata *tags =3D &sio->tags;
>> +	int tag, i;
>> +
>> +	/*
>> +	 * Because tag number 0 is special, the usable tag range
>> +	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
>> +	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
>> +	 */
>> +
>> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
>> +	tag =3D (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
>> +
>> +	for (i =3D 0; i < SIO_USABLE_TAGS; i++) {
>> +		if (!test_and_set_bit(tag, &tags->allocated))
>> +			break;
>> +
>> +		tag =3D (tag % SIO_USABLE_TAGS) + 1;
>> +	}
>> +
>> +	WRITE_ONCE(tags->last_tag, tag);
>> +
>> +	if (i < SIO_USABLE_TAGS)
>> +		return tag;
>> +	else
>> +		return -EBUSY;
>> +#undef SIO_USABLE_TAGS
>> +}
>=20
> can you use kernel mechanisms like ida to alloc and free the tags...

I can look into that.

>> +static struct dma_async_tx_descriptor *sio_prep_dma_cyclic(
>> +		struct dma_chan *chan, dma_addr_t buf_addr, size_t =
buf_len,
>> +		size_t period_len, enum dma_transfer_direction =
direction,
>> +		unsigned long flags)
>> +{
>> +	struct sio_chan *siochan =3D to_sio_chan(chan);
>> +	struct sio_tx *siotx =3D NULL;
>> +	int i, nperiods =3D buf_len / period_len;
>> +
>> +	if (direction !=3D sio_chan_direction(siochan->no))
>> +		return NULL;
>> +
>> +	siotx =3D kzalloc(struct_size(siotx, siodesc, nperiods), =
GFP_NOWAIT);
>> +	if (!siotx)
>> +		return NULL;
>> +
>> +	init_completion(&siotx->done);
>> +	dma_async_tx_descriptor_init(&siotx->tx, chan);
>> +	siotx->period_len =3D period_len;
>> +	siotx->nperiods =3D nperiods;
>> +
>> +	for (i =3D 0; i < nperiods; i++) {
>> +		struct sio_coproc_desc *d;
>> +
>> +		siotx->siodesc[i] =3D d =3D =
sio_alloc_desc(siochan->host);
>> +		if (!d) {
>> +			sio_tx_free(&siotx->tx);
>> +			return NULL;
>> +		}
>> +
>> +		d->flag =3D 1; // not sure what's up with this
>> +		d->iova =3D buf_addr + period_len * i;
>> +		d->size =3D period_len;
>> +	}
>> +	dma_wmb();
>=20
> why use barrier here? and to what purpose..

Few lines above we are modifying a shared memory buffer that=E2=80=99s =
mapped into
the coprocessor=E2=80=99s address space (it=E2=80=99s what `d` points =
to).

> --=20
> ~Vinod
>=20

Best regards, Martin

