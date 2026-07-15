Return-Path: <dmaengine+bounces-12533-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uVYaIg3PVmrEBQEAu9opvQ
	(envelope-from <dmaengine+bounces-12533-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:06:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D281F75994A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 02:06:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QNL6Bna2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12533-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12533-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9147308F72E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C142BC50;
	Wed, 15 Jul 2026 00:06:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6D42BC47
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 00:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073975; cv=none; b=PmlqzYfXx8IWZZbfgj9JkS5DGCi8Mu03pYqN55Vlp23H3MLqMebBoXdWH27wJNK9rTaSv670w+BKvqrxj+/PXdUOH8naOsOQzVgdIURQxzZKcDVwsWQVKfxl6vblTmYM+Hn96S3sa5RK90QEM2ShBpR7+YwcKdWkJcRV5PtOdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073975; c=relaxed/simple;
	bh=IQroVjo5rB9aqH8dbxrBvr+9KoxOETPmQ5vGMkp8PuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpYqHjTmMsth8BBsJIiuLMmRPGbOzG/jue3WrQ6T2FHFl299K7t86wxC1X18oxvk38SLPA1Dj8tgHNVHCk2FuShtGD+c/x6LwNuyCPVjsZWOpseA9tjKpUPuzHB06PDXRNhjEhvz9SJo2FGRHseqV9UzE0q8GFnnU03VWe+Li/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNL6Bna2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B981F000E9;
	Wed, 15 Jul 2026 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073973;
	bh=uS9t9PfDADU4O2ekgBusL7Pf3oQOV8icdw5CDTWI1Fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNL6Bna2nUmszgfp+QNQhGwSUlu3ARxh6QT89tQm7ZdAgMxepRp/EW4l3De4Aj+6l
	 Z/IFBYfqb2+fjRDlnFiFlb5lAvBh/hkeO6aLE7Mg+L0DppIYx0+NZ4J/cUTHU6xChB
	 fFAf1ZRbh/D9jxjwaqBJOWSywNMnllU2mo8BIhMGqpcJbu63U2srzrEr2oEtST67qd
	 fuweGaKD1l7oDZIOSkUrvDJUTQauwL9qXM9rBQTHiFS6kBtO0kDYRWMZFw3ks9wQX0
	 4JS5X3aD/9SJACpw47DwJS/BwhUDKowe8StowaRiNamvBNJYT+I+c6mTBy5q3U1u7u
	 g4OxRf0Bm0QVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dma: fsl_raid: fix endianness of in-memory
 descriptor stores
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260714233855.870797-2-rosenp@gmail.com>
References: <20260714233855.870797-1-rosenp@gmail.com>
 <20260714233855.870797-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 00:06:12 +0000
Message-Id: <20260715000613.61B981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12533-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D281F75994A

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly fixes the endianness of `struct fsl_re_cmpnd_f=
rame` and `struct fsl_re_hw_desc` by wrapping assignments in `cpu_to_be32()=
`, but completely misses the same class of bug for `cdb32` fields in the Co=
mmand Descriptor Block structs (`fsl_re_xor_cdb`, `fsl_re_pq_cdb`, `fsl_re_=
move_cdb`).
- [High] Uninitialized kernel DMA pool memory is passed directly to the har=
dware for Command Descriptor Blocks (CDBs) and compound frames.
- [High] A DMA length of exactly 1MB (1024*1024) is allowed by `FSL_RE_MAX_=
DATA_LEN` but is truncated to 0 when bitwise-ANDed with `FSL_RE_CF_LENGTH_M=
ASK`, resulting in a silent 0-byte transfer.
--

--- Patch [1]: [PATCH 1/3] dma: fsl_raid: fix endianness of in-memory descr=
iptor stores ---
commit b79b0fb376ec1f7e303159ca0f7c486730ae5496
Author: Rosen Penev <rosenp@gmail.com>

dma: fsl_raid: fix endianness of in-memory descriptor stores

This commit updates the driver to wrap in-memory descriptor fields in
cpu_to_be32() to resolve base-type mismatches and endianness issues. It
also simplifies the final-frame bit assignment in fill_cfd_frame().

Link: https://lore.kernel.org/oe-kbuild-all/202008111749.yy85rFMD%25lkp@int=
el.com/

> diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
> index 99945845d8b5e..888f55b672a58 100644
> --- a/drivers/dma/fsl_raid.c
> +++ b/drivers/dma/fsl_raid.c
> @@ -242,9 +242,9 @@ static void fill_cfd_frame(struct fsl_re_cmpnd_frame =
*cf, u8 index,
>  	u32 efrl =3D length & FSL_RE_CF_LENGTH_MASK;

[Severity: High]
This is a pre-existing issue, but can this truncate a legitimate 1MB
transfer down to 0 bytes?

If a caller issues a DMA request of exactly FSL_RE_MAX_DATA_LEN (which
is 1024*1024, or 0x100000), it passes the bounds checks. However,
FSL_RE_CF_LENGTH_MASK is 0x000FFFFF, so the bitwise-AND operation here
would evaluate to 0.

Does this result in a silent 0-byte transfer instead of the intended
1MB transfer?

> =20
>  	efrl |=3D final << FSL_RE_CF_FINAL_SHIFT;
> -	cf[index].efrl32 =3D efrl;
> -	cf[index].addr_high =3D upper_32_bits(addr);
> -	cf[index].addr_low =3D lower_32_bits(addr);
> +	cf[index].efrl32 =3D cpu_to_be32(efrl);
> +	cf[index].addr_high =3D cpu_to_be32(upper_32_bits(addr));
> +	cf[index].addr_low =3D cpu_to_be32(lower_32_bits(addr));
>  }

[Severity: High]
This is a pre-existing issue, but does this patch also need to fix the
endianness of the cdb32 fields in the Command Descriptor Block structs?

When preparing a DMA transfer in fsl_re_prep_dma_genq(), fsl_re_prep_dma_pq=
(),
or fsl_re_prep_dma_memcpy(), the CPU-endian cdb variable is directly
assigned to the __be32 cdb32 field in the command descriptor block:

drivers/dma/fsl_raid.c:fsl_re_prep_dma_genq() {
    ...
    xor =3D desc->cdb_addr;
    xor->cdb32 =3D cdb;
    ...
}

Will the hardware receive byte-swapped opcodes and configuration flags
on little-endian platforms?

> =20
>  static struct fsl_re_desc *fsl_re_init_desc(struct fsl_re_chan *re_chan,
> @@ -256,9 +256,10 @@ static struct fsl_re_desc *fsl_re_init_desc(struct f=
sl_re_chan *re_chan,
>  	dma_async_tx_descriptor_init(&desc->async_tx, &re_chan->chan);
>  	INIT_LIST_HEAD(&desc->node);
> =20
> -	desc->hwdesc.fmt32 =3D FSL_RE_FRAME_FORMAT << FSL_RE_HWDESC_FMT_SHIFT;
> -	desc->hwdesc.lbea32 =3D upper_32_bits(paddr);
> -	desc->hwdesc.addr_low =3D lower_32_bits(paddr);
> +	desc->hwdesc.fmt32 =3D cpu_to_be32(FSL_RE_FRAME_FORMAT <<
> +					  FSL_RE_HWDESC_FMT_SHIFT);
> +	desc->hwdesc.lbea32 =3D cpu_to_be32(upper_32_bits(paddr));
> +	desc->hwdesc.addr_low =3D cpu_to_be32(lower_32_bits(paddr));
>  	desc->cf_addr =3D cf;
>  	desc->cf_paddr =3D paddr;

[Severity: High]
This is a pre-existing issue, but does the hardware receive uninitialized
memory here?

The DMA pool allocation for the compound frame and CDB buffer in
fsl_re_chan_alloc_desc() uses dma_pool_alloc() without zeroing the buffer:

drivers/dma/fsl_raid.c:fsl_re_chan_alloc_desc() {
    ...
    cf =3D dma_pool_alloc(re_chan->re_dev->cf_desc_pool, GFP_NOWAIT, &paddr=
);
    ...
}

Since functions like fill_cfd_frame() and fsl_re_init_desc() only populate
specific fields, could stale data in uninitialized fields like rbro32 or
dpi_dest_spec cause unpredictable hardware behavior when passed to the
DMA engine?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714233855.8707=
97-1-rosenp@gmail.com?part=3D1

