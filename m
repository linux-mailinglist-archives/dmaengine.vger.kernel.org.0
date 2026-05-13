Return-Path: <dmaengine+bounces-10402-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I2hMDvtA2pZAwIAu9opvQ
	(envelope-from <dmaengine+bounces-10402-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:17:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24052CB4F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAB83300E614
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDDF363081;
	Wed, 13 May 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rARrtI9q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2872DC783;
	Wed, 13 May 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642232; cv=none; b=kjSWgwBw6krwpJppAZik7ui4/3Yhp8/QL7D6tLwBLrmgtB9MzEUdbddRBQeS4AntQ2yXh8PIcPbpE9s3Rk/AxHzKkhA2QSj0aMLAPTLEQVl2ptiPNjonvVDz6KTJJenFgL2cvmQbtpPF+DXhI/73LDoLtjmgS6dlraY+Fhis3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642232; c=relaxed/simple;
	bh=261QrCzm5wQlkATed6WV5DebKEWtyQ4gJAg0Mh3ASTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHu97CimdRN65b6ecwYDb6wGnBbc57Rc55oTfhVNUAKhTHFvQa+AvuJpDEsGIznxGvLvDhBDhvaWcpwPrGSt4NHJYm39JOoxl1JiztEQzda1m2coCNksnz99xKiyTUU2Mbvj1Tjg67WzI/mh1el9y+557+1cSti9zQA1efqgH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rARrtI9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8EDC2BCB0;
	Wed, 13 May 2026 03:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778642232;
	bh=261QrCzm5wQlkATed6WV5DebKEWtyQ4gJAg0Mh3ASTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rARrtI9qawKFlel7AoFRytTdOd3x7gEzddWIZHYA2aV6x3kagMycmDynGWRI/1P8C
	 BxcWHvcjYUzhyxp2iomWwHtlXgy4xAkqT+AiMCd4SlhvYXBsOlszx3sVWT1VNFi/r8
	 14Oc5JXWf9mMzxfgO5U0/oIUI+GXgEC4egidEHVIaLKpvgAMOmpvThag0mFzIwoBg8
	 I3Av3VvcE5JZhJ12j0ASTTwYs1FYKNF55un8M3S+FWsC9PLYYO/wP6ZW2+jJj9l9Kp
	 cjVzKnA3dgXpN2JjzH97Jx6qMEO7maS/ITJR5rTszmgkR8o0J3DV3kPUUEQgd62RK/
	 9P/Y6PqCYUXNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/23] dmaengine: sdxi: Install administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-8-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-8-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:17:11 +0000
Message-Id: <20260513031712.0C8EDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3D24052CB4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,amd.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10402-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Hardware Use-After-Free due to missing admin context teardown
- [High] Torn writes on 32-bit platforms exposing incomplete addresses to h=
ardware
- [Medium] Incorrect error check for `dma_pool_zalloc()` using the DMA hand=
le instead of the virtual pointer
--

commit 794d6cb84f7ad6a7699311744a5e9c87b9d20316
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Install administrative context

This commit serializes the context control block, akey table, and L1 entry =
for
the admin context. It makes the descriptor ring, write index, and context
status block visible to the SDXI implementation once activated.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 27821cfaf0311..c0b55c945cc4e 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> @@ -106,6 +112,152 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_=
dev *sdxi)

[ ... ]

> +static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi=
_cxt_ctl_cfg *cfg)
> +{
> +	u64 ds_ring_ptr, cxt_sts_ptr, write_index_ptr;

[ ... ]

> +	ds_ring_ptr =3D FIELD_PREP(SDXI_CXT_CTL_VL, 1) |
> +		      FIELD_PREP(SDXI_CXT_CTL_QOS, cfg->qos) |
> +		      FIELD_PREP(SDXI_CXT_CTL_SE, cfg->se) |
> +		      FIELD_PREP(SDXI_CXT_CTL_CSA, cfg->csa) |
> +		      FIELD_PREP(SDXI_CXT_CTL_DS_RING_PTR,
> +				 cfg->ds_ring_ptr >> DESC_RING_BASE_PTR_SHIFT);
> +	/* Ensure other fields are visible before hw sees vl=3D1. */
> +	dma_wmb();
> +	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));

Can this introduce a regression with torn writes on 32-bit platforms?

Since the driver does not strictly depend on 64BIT in Kconfig, writing a
64-bit structure pointer that also contains the valid bit (VL=3D1 at bit 0)
via WRITE_ONCE() translates to two separate 32-bit stores.

If the compiler orders the lower 32-bit store before the upper 32-bit store,
could the hardware concurrently read the descriptor and fetch from an
incomplete, torn physical address?

> +
> +	return 0;
> +}
> +
> +/*
> + * Logical representation of CXT_L1_ENT subfields.
> + */

[ ... ]

> +static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
> +			      const struct sdxi_cxt_L1_cfg *cfg)
> +{

[ ... ]

> +	cxt_ctl_ptr =3D FIELD_PREP(SDXI_CXT_L1_ENT_VL, 1) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_KA, cfg->ka) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_PV, cfg->pv) |
> +		      FIELD_PREP(SDXI_CXT_L1_ENT_CXT_CTL_PTR,
> +				 cfg->cxt_ctl_ptr >> L1_CXT_CTRL_PTR_SHIFT);
> +	/* Ensure other fields are visible before hw sees vl=3D1. */
> +	dma_wmb();
> +	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));

Similarly, could this 64-bit WRITE_ONCE() cause torn writes on 32-bit
platforms, exposing an incomplete physical address to the hardware?

> +
> +	return 0;
> +}
> +

[ ... ]

> +static void free_admin_cxt(void *ptr)
> +{
> +	struct sdxi_dev *sdxi =3D ptr;
> +
> +	sdxi_free_cxt(sdxi->admin_cxt);
> +}

Does this sequence cause a use-after-free regression?

In sdxi_publish_cxt(), the admin context is published to the hardware by
setting the valid bit (VL=3D1) in the L1_table.

When the context is torn down via the devres cleanup action free_admin_cxt(=
),
it directly invokes sdxi_free_cxt(), which frees the DMA memory for the
context control block, descriptor ring, and akey table.

However, the VL bit in the hardware's L1 table entry is never cleared. Could
this leave the hardware actively fetching from freed physical addresses?

Additionally, looking at the sdxi_alloc_cxt() implementation, the return va=
lue
of dma_pool_zalloc() is checked via the DMA address instead of the virtual
pointer:

	cxt->cxt_ctl =3D dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
				       &cxt->cxt_ctl_dma);
	if (!cxt->cxt_ctl_dma)
		return NULL;

Since physical address 0 is a valid DMA address on many architectures and I=
OMMU
configurations, could this regression incorrectly abort initialization if a
successful allocation returns DMA address 0? Should this code check the
returned virtual pointer (!cxt->cxt_ctl) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D8

