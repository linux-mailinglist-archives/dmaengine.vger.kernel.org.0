Return-Path: <dmaengine+bounces-10400-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMqyCB/VA2ol/AEAu9opvQ
	(envelope-from <dmaengine+bounces-10400-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:34:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACA52BEF9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F45A30861DE
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE935F167;
	Wed, 13 May 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1BjsiFw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33203655CA;
	Wed, 13 May 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635854; cv=none; b=N3GhrHOnubh70rS+AEE4PFqR6xHKdpatkBVlGp/3csm38CqMajYIO24pIQ+gvKbvpM0CfCKLWQRSgM7OtLXhTLRigCLBAW5P8S2GQS7wkWzRqw+AdS73Cl8K4fYYEaiyqpseQXx074l6ebKTsoNZrRJRIRdqD7Dq7ZNvfoNdCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635854; c=relaxed/simple;
	bh=7bmpD6gDc4t9B/heqdJxWc6tIfs6wv3SPPI3aOtYeKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lp7E3JmTzIiBOQnDEkFQ0huzoo//aFwFEBy/W+xTMxtO/wo8GJq5zmiSSaFKb6fgyTbg9zTYisRwzJDjPPoOGPlGF1CpNoTsXiN4e1FC17V5cz1cVp8haoIHCAw/uqIcAKPyPOUPaJ/zh3WYwDZjKFq3MWZoFEZvcBYc6yILPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1BjsiFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1E1C2BCB0;
	Wed, 13 May 2026 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635853;
	bh=7bmpD6gDc4t9B/heqdJxWc6tIfs6wv3SPPI3aOtYeKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I1BjsiFwn3sVJBAV+FN9+eyddwKJoymbihsHf5XH9YkhUjmjNLjPwmvlFcyH97eSi
	 pi4v6YZuu+KamCsB6145vA5Lq5t3xeEVzb88R7bKVVZTqYU8a8Xvduew2DDoI2rF2E
	 tVM2Fupq15bPbP8Nh3gThkkDxGSOix28a67mXrPZPntGM3rbnl4MscJDshnHOFhY0x
	 owQpniU9+vkEtkXaOTGtFr4aAK6MVp20oCJrS8LnlUZRPcfWyXr63hUgsJUvqTIe5b
	 FMIs9u2U7sGtLrqp+ovdENhrouf216pDAArWTebohYbKpG15JRbuZQ1xKTP9nH96EC
	 DxwSitWHRfJrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/23] dmaengine: sdxi: Allocate DMA pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-6-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-6-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:30:52 +0000
Message-Id: <20260513013053.5F1E1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 74ACA52BEF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10400-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unnecessary use of `__packed` attribute on naturally aligned DMA s=
tructures reduces their assumed alignment to 1 byte, risking torn reads/wri=
tes.
- [Medium] `cxt_ctl_pool` has a hardcoded alignment of 64 bytes instead of =
`max(size, SMP_CACHE_BYTES)`, leading to potential cacheline sharing.
--

commit 12aa7b8ec291c34d27a87b91722b70b67d211aa3
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Allocate DMA pools

This commit introduces C structures for SDXI context control, context statu=
s,
and completion status blocks. It also creates a DMA pool for each of these
objects as well as write indexes, aiming to align them to avoid cacheline
sharing.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 6a2204ff7fdee..851e73597c22b 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c

[ ... ]

> @@ -211,6 +214,43 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	return 0;
>  }
> =20
> +static int sdxi_device_init(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev =3D sdxi->dev;
> +	size_t size, align;
> +	int err;
> +
> +	size =3D sizeof(__le64);
> +	align =3D max(size, SMP_CACHE_BYTES);
> +	sdxi->write_index_pool =3D dmam_pool_create("Write_Index", dev, size,
> +						  align, 0);
> +	if (!sdxi->write_index_pool)
> +		return -ENOMEM;
> +
> +	size =3D sizeof(struct sdxi_cxt_sts);
> +	align =3D max(size, SMP_CACHE_BYTES);
> +	sdxi->cxt_sts_pool =3D dmam_pool_create("CXT_STS", dev, size, align, 0);
> +	if (!sdxi->cxt_sts_pool)
> +		return -ENOMEM;
> +
> +	size =3D align =3D sizeof(struct sdxi_cxt_ctl);
> +	sdxi->cxt_ctl_pool =3D dmam_pool_create("CXT_CTL", dev, size, align, 0);

The commit message states that frequently-updated objects are aligned to av=
oid
cacheline sharing. Does hardcoding the alignment to sizeof(struct sdxi_cxt_=
ctl)
risk cacheline sharing on architectures where SMP_CACHE_BYTES is 128?

Should this use max(size, SMP_CACHE_BYTES) like the other pools?

> +	if (!sdxi->cxt_ctl_pool)
> +		return -ENOMEM;

[ ... ]

> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index df520ca7792bf..846c671c423f5 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h

[ ... ]

> +/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
> +struct sdxi_cxt_ctl {
> +	__le64 ds_ring_ptr;
> +	__le32 ds_ring_sz;
> +	__u8 rsvd_0[4];
> +	__le64 cxt_sts_ptr;
> +	__le64 write_index_ptr;
> +	__u8 rsvd_1[32];
> +} __packed;

These structures appear to be naturally aligned and padded properly. Does
applying the __packed attribute without an explicit __aligned() attribute
force the compiler to assume 1-byte alignment?

Could this lead to the compiler synthesizing multiple byte-wise or narrower
memory accesses for 32-bit or 64-bit fields when they are read or written,
potentially causing torn reads or writes if the hardware lacks native
unaligned access support?

> +static_assert(sizeof(struct sdxi_cxt_ctl) =3D=3D 64);
> +
> +/* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
> +struct sdxi_cxt_sts {
> +	__u8 state;
> +	__u8 misc0;
> +	__u8 rsvd_0[6];
> +	__le64 read_index;
> +} __packed;
> +static_assert(sizeof(struct sdxi_cxt_sts) =3D=3D 16);
> +
> +/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
> +struct sdxi_cst_blk {
> +	__le64 signal;
> +	__le32 flags;
> +	__u8 rsvd_0[20];
> +} __packed;
> +static_assert(sizeof(struct sdxi_cst_blk) =3D=3D 32);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D6

