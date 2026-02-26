Return-Path: <dmaengine+bounces-9130-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJkPGuEVoGlifgQAu9opvQ
	(envelope-from <dmaengine+bounces-9130-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 10:44:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D36491A3A59
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6DE303130B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B144313273;
	Thu, 26 Feb 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0T93N4M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBE31196F
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098507; cv=none; b=PZ0PcJVjtMf510t7mSciBq5TrBa1nwRW9MmXp5kv50eDGtz8KQfTQ7hkl/W8pGrNM2v9rPLQW8I2uKQsk2p4VUbvUQIn6r42ViiJ1kmVwWLEYXgrwevl2pe+KFi1+mZS+DMeBry6CR3o9a6H07L0hdVHqPw0uJlcxr8jnHd3MSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098507; c=relaxed/simple;
	bh=vo1dXKAu56lemSybSMhLg9+T4r9TIGY+n1ohT2dDBNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nW0C5dcnAQzryk6cHzkusaJ0jvaxsQrWdr1YZhUrtfQweCtJ2fmwJ+UhOLhIrN3TwPto0YIWqQPpCjup+WFCmdB5/kFz+abK5RK/6aElgOosVN0hJRSYLy7Ad58/kgW5SJv8xmlhDhlP4mKQ19BLR1S5fj9GThdNVgWhyC3SJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0T93N4M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48379a42f76so5257715e9.0
        for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 01:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098500; x=1772703300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/eOLrHxjayl5fdWpNN3A/mU7tsWhEYQqdenYnUebLxs=;
        b=F0T93N4MooLL9PoFSqW/V34lVBsjRq6hn2yh6IA4LmG6CzvrmL/xpiarHJG2riSgf9
         Ez3P5+yJIQCfU49lno63PRyREtd6/+4X7EkapnqoQ8gKV4ynFDb23le5/YIgygu7h9pe
         XS1jsLwjQGBF4m1docq2Fx0kkLt7QxtbcBKqVO384W9lcen0lT8EsNcwX1JiWUbZuMqp
         1chsi+VE8Y3p/CAEr4qY9J0K5o+tuVHhPtBgvBd2wY1r0eO3NBapD+M7GNFQLziH+yee
         AK3eB32yFG1iBpAi312YRglz3cdMFliqmnymymPvjAzZRFvW0Gj00Ui2ejaoDNNCI0wt
         2kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098500; x=1772703300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eOLrHxjayl5fdWpNN3A/mU7tsWhEYQqdenYnUebLxs=;
        b=qFgmNJQZRwuO08PA7PouZjhee9BrBF8rXsAjkVGK/qsxkQBJpm5XNBvgZkftQjIJJw
         E9/9KMEQs5NZik+Xmld8RZOMV10QvsGyX4bhrL9nGw4cF2wKBTi171Obr+8ffhQ3BzcD
         mTQKsJrTdK1R+OS4A9PoNvP7DgdpSbSIZVP+PWr03l4m3ptMLOHyZzrYobxZ7f0Qjs6N
         rC/e85GJ4s5gMkRwGHEHatLDe03RKXWhrGP2UzHaPK5o1TTW2Uegm8RaujNigYSjXRCz
         bJRHSeJaWBz3MmP/jXTFJLYOA+YcWlKl0YLw0G0wzqWoLXNWZRE3Cto6/r43lES/tRB4
         bI+Q==
X-Gm-Message-State: AOJu0YyrQil17XC52BSa0XvTcvl3wSwUHcN70Ykf9OE61o8e8hupshwB
	1dTefxgDBIuz/ZAQawNHmW/WGNoFL4l2Qein15Uv4KIVM9NryIYWaY5b
X-Gm-Gg: ATEYQzz4ipgVLFLKsS8w+wJklEAz+eDzbW5GDKbZYdIHXwfonczD0pLCTNUYsuFVMDQ
	2HxDg1w/0S2dMKOWMQxt3zfdrP65jggzdTvgwadFwDwXoEsBQiwMMuZUM3Qw4GQriZwYySazRTT
	rOYeoIJrCJ9hA9Mwq2/k1EjL1zT24rK6m0VoUaM+leycD/f+Ci2PA2AFu8irAK58rmXMCEWVLNU
	8n3wD2lQow0CgXrj3IwSFPBoMV7P2eMBoUukAr4N46YPrLMtOHEd9jeyzTxrRGuoHWA3gumMuRF
	XFnUUphYC5qIn7MeMlmJczVgkXmXPSw+4os6p8+ShnfyEhzBAjtWSJrLpnokPy7jutgTMHTF0yM
	5DsgBffvTJ4WhAKtuJLpC5hGdMb41a/sluuEuEE5YBOCGrQ/HnO8FatF5DZAOwr8J0qA3DvZc+V
	RbXIxgITsvoPXB5ibaGYPeSrhv1HFk5jU=
X-Received: by 2002:a05:600c:1f06:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-483c21764e8mr49621095e9.11.1772098500180;
        Thu, 26 Feb 2026 01:35:00 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84139sm37277175e9.14.2026.02.26.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:34:59 -0800 (PST)
Message-ID: <5e8613fca7c3909df35193553c84d78dc1b03a6d.camel@gmail.com>
Subject: Re: [PATCH 4/5] dma: dma-axi-dmac: Gracefully terminate SW cyclic
 transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod
 Koul	 <vkoul@kernel.org>
Date: Thu, 26 Feb 2026 09:35:43 +0000
In-Reply-To: <aZ8qC9oB1kw4xauR@lizhi-Precision-Tower-5810>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
	 <20260127-axi-dac-cyclic-support-v1-4-b32daca4b3c7@analog.com>
	 <aZ8qC9oB1kw4xauR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9130-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: D36491A3A59
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 11:57 -0500, Frank Li wrote:
> On Tue, Jan 27, 2026 at 02:28:25PM +0000, Nuno S=C3=A1 wrote:
> > As of now, to terminate a cyclic transfer, one pretty much needs to use
> > brute force and terminate all transfers with .device_terminate_all().
> > With this change, when a cyclic transfer terminates we look and see if
> > we have any pending transfer with the DMA_PREP_LOAD_EOT flag set. If
> > we do, we terminate the cyclic transfer and prepare to start the next
> > one. If we don't see the flag we'll ignore that transfer.
>=20
> Can you rephrase it to avoid use "we".
>=20

Sure!

Thanks for looking at this.

- Nuno S=C3=A1

> for example,
>=20
> Ignore that transfer if flag not set.
>=20
> Frank
>=20
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/dma/dma-axi-dmac.c | 34 +++++++++++++++++++++++++++++++++=
-
> > =C2=A01 file changed, 33 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index 3984236717a6..638625647152 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -233,6 +233,11 @@ static struct axi_dmac_desc *axi_dmac_get_next_des=
c(struct axi_dmac *dmac,
> > =C2=A0	struct virt_dma_desc *vdesc;
> > =C2=A0	struct axi_dmac_desc *desc;
> >=20
> > +	/*
> > +	 * It means a SW cyclic transfer is in place so we should just return
> > +	 * the same descriptor. SW cyclic transfer termination is handled
> > +	 * in axi_dmac_transfer_done().
> > +	 */
> > =C2=A0	if (chan->next_desc)
> > =C2=A0		return chan->next_desc;
> >=20
> > @@ -411,6 +416,32 @@ static void axi_dmac_compute_residue(struct axi_dm=
ac_chan *chan,
> > =C2=A0	}
> > =C2=A0}
> >=20
> > +static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct axi_dmac_desc *active)
> > +{
> > +	struct device *dev =3D chan_to_axi_dmac(chan)->dma_dev.dev;
> > +	struct virt_dma_desc *vdesc;
> > +
> > +	/* wrap around */
> > +	active->num_completed =3D 0;
> > +
> > +	vdesc =3D vchan_next_desc(&chan->vchan);
> > +	if (!vdesc)
> > +		return false;
> > +	if (!(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
> > +		dev_warn(dev, "Discarding non EOT transfer after cyclic\n");
> > +		list_del(&vdesc->node);
> > +		return false;
> > +	}
> > +
> > +	/* then let's end the cyclic transfer */
> > +	chan->next_desc =3D NULL;
> > +	list_del(&active->vdesc.node);
> > +	vchan_cookie_complete(&active->vdesc);
> > +
> > +	return true;
> > +}
> > +
> > =C2=A0static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
> > =C2=A0	unsigned int completed_transfers)
> > =C2=A0{
> > @@ -458,7 +489,8 @@ static bool axi_dmac_transfer_done(struct axi_dmac_=
chan *chan,
> > =C2=A0			if (active->num_completed =3D=3D active->num_sgs ||
> > =C2=A0			=C2=A0=C2=A0=C2=A0 sg->partial_len) {
> > =C2=A0				if (active->cyclic) {
> > -					active->num_completed =3D 0; /* wrap around */
> > +					/* keep start_next as is, if already true... */
> > +					start_next |=3D axi_dmac_handle_cyclic_eot(chan, active);
> > =C2=A0				} else {
> > =C2=A0					list_del(&active->vdesc.node);
> > =C2=A0					vchan_cookie_complete(&active->vdesc);
> >=20
> > --
> > 2.52.0
> >=20

