Return-Path: <dmaengine+bounces-10399-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLO3JfzPA2qz+wEAu9opvQ
	(envelope-from <dmaengine+bounces-10399-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:12:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E594F52BC0E
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02C7E300517B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75963537FE;
	Wed, 13 May 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPqSxkPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430B3563E8;
	Wed, 13 May 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634741; cv=none; b=NIotdYWVnodWCoDyUVSDNL/ejn3UXyznIr71LIAjYitxUCn3gA9EGVNvRbW/VcTCJw7P3tlCjgGBmHguBk7oE1yF590A90HXZQWxgKTVhvyYuUM6GPB+1bl/hdVCEMdeMjSd3TPO0SwDIVkgxAH13ziH9E4oLWq8Y0KNuCNyp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634741; c=relaxed/simple;
	bh=JRkhTPJfazXTilVG46AyZFx0772R7+RBOW/1IZzEWhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kqHSgyRUQ8/z/XyRXzUrpN2BDqsD+XCY9c/PCzQoYjXD+/RMQbVCdPjq9UM1GKURKL7U9mNzurd7Z1Up/nSWrZ7fp4Dn85gPYab+4oJs+yKTxVXoiQrumOetF+0DHSJKu7ZL+ic7cKDMvBnJ/meMaWoTMclftvXe/y7FVwrQB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPqSxkPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC94C2BCB0;
	Wed, 13 May 2026 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634741;
	bh=JRkhTPJfazXTilVG46AyZFx0772R7+RBOW/1IZzEWhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NPqSxkPyBeb01vtBM8tdhykTutEPDgZzS3c3Vwd+KC2E7U0R1S3v2KvrLWKJEQVOI
	 /AR1lT8Xf64bo/j1pYuSsdWwRMFKBHx8vo3qNEQcv/A0/IFaIjH1PrqZQYIS5vLf9G
	 DDJE/kf67nkPXim31OcJNgBZxs3IKJc8+Gh7yKpXL9/2uC6slKW9dAqYfGy+1EHbSe
	 FBhUosYHAbjb0OlKTfJwyu7Dd1DP99MiiTPVpO5lGh/t88cswggov2Jcqnn2TzQRf1
	 22np0ngAp4/Uq7xO64qGW+9wUX2U5Bm27v7enXkIKWW+LcbX9uWVPyJJlzI/B+ZSZj
	 R7HHHR/mdsFFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/23] dmaengine: sdxi: Configure context tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-5-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-5-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:12:19 +0000
Message-Id: <20260513011220.DFC94C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E594F52BC0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,amd.com:email,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10399-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Premature programming of the L2 table base address in the hardwa=
re register, leading to a dangling DMA pointer on error paths.
- [Medium] Unnecessary and potentially harmful `__packed` attribute on natu=
rally aligned DMA structures.
--

commit 0a4d9e9c9ca24875b4f7b4512a3bf669c25c0595
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Configure context tables

This commit allocates and configures the two-level context tracking tables =
(L1
and L2) for the SDXI driver. It allocates enough space for context IDs 0-127
and caps the maximum contexts accordingly, using devres-managed allocations=
 to
simplify cleanup.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c

[ ... ]

> @@ -172,6 +182,32 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
>  	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
> =20
> +	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
> +	sdxi->L2_table =3D dmam_alloc_coherent(sdxi->dev,
> +					     sizeof(*sdxi->L2_table),
> +					     &sdxi->L2_dma, GFP_KERNEL);
> +	if (!sdxi->L2_table)
> +		return -ENOMEM;
> +
> +	cxt_l2 =3D FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K=
));
> +	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
> +
> +	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
> +	sdxi->L1_table =3D dmam_alloc_coherent(sdxi->dev,
> +					     sizeof(*sdxi->L1_table),
> +					     &sdxi->L1_dma, GFP_KERNEL);
> +	if (!sdxi->L1_table)
> +		return -ENOMEM;

If dmam_alloc_coherent() fails for L1_table, we return -ENOMEM. The devres
framework will then free L2_table, but does this leave a dangling physical
pointer in the hardware SDXI_MMIO_CXT_L2 register?

Could this lead to a DMA use-after-free regression if the hardware incorrec=
tly
resumes or is later manipulated? Should we defer writing to SDXI_MMIO_CXT_L2
until both tables are fully allocated and linked?

> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> --- /dev/null
> +++ b/drivers/dma/sdxi/hw.h

[ ... ]

> +/* SDXI 1.0 Table 3-2: Context Level 2 Table Entry (CXT_L2_ENT) */
> +struct sdxi_cxt_L2_ent {
> +	__le64 lv01_ptr;
> +#define SDXI_CXT_L2_ENT_VL       BIT_ULL(0)
> +#define SDXI_CXT_L2_ENT_LV01_PTR GENMASK_ULL(63, 12)
> +} __packed;

Are the __packed attributes necessary here? Since these structures contain
naturally aligned fields and their sizes are multiples of their largest
members, they shouldn't require compiler padding.

Could packing them cause the compiler to assume pointers are unaligned and
generate byte-by-byte accesses instead of native loads and stores?

For structures in DMA-coherent memory, this might break hardware atomicity
or trigger architectural alignment faults on some platforms.

[ ... ]

> +/* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
> +struct sdxi_cxt_L1_ent {
> +	__le64 cxt_ctl_ptr;
> +	__le64 akey_ptr;
> +	__le32 misc0;
> +	__le32 opb_000_enb;
> +	__u8 rsvd_0[8];
> +} __packed;

Does this struct have the same __packed regression as sdxi_cxt_L2_ent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D5

