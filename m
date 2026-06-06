Return-Path: <dmaengine+bounces-11251-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 77H+OqZnI2rhswEAu9opvQ
	(envelope-from <dmaengine+bounces-11251-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:19:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684AC64BFDC
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:19:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K0IUB9Ht;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11251-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11251-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBBD330073D2
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0483BB4A;
	Sat,  6 Jun 2026 00:19:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987917A30A;
	Sat,  6 Jun 2026 00:19:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705176; cv=none; b=uTVUkHiqs6cMboelQMMVz6vvsZ8khtCmgYOnXmoBG7R3NUbuD3ER0yhk+tlhFW7o/Ojr2xJVWR4et6oSUjC/6edBVRvORUdaFDpt2zoudjviHwzWgwLrxaTHnkmXyrtFno3g8Yozgv4QWPDsHLTYpub2VPMCI+5pJV/3GSZDp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705176; c=relaxed/simple;
	bh=fGfTm9cUsF1gzMbkPPS7g7Uy455f1rJ5JwTAjdtAD2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7CGDKtTCVRMa+ME+C5N0kbQgupzCiXYiaw0uLBTu76YeBs6HoSNKhm7hkX/jzgH/62a7oYen82M0b8qzODxLCjgeHF2PDi/MsNyBPQex30RWUIER8WF37kjphQE7/RALRe+eGdyJpw085MZDg1zm9bchr2roExLH899z+9fi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0IUB9Ht; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B061F00893;
	Sat,  6 Jun 2026 00:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705175;
	bh=QTI3HgrgMh+aaucKaBjfFC1iJwvQ8N+OzVcIS5KHRRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0IUB9HtNPMo4HMDwrCL09R5mn1XmyPILsduDPlNe/drVbEvd7wCtjOuoeMWcjYjI
	 y+EqlZg4jN8ppy06+Yl6AH5F6LKzabrAQmI6FedxzsV07sXpELm64lW1inYLMWgsDH
	 HfyHpjs2dIsAqVIABjc0CTmDrOmUuNMWT2SV5p8hFJnvaVNwNLBtm9FQammzmPdDu8
	 gi5uX8AM/P5xoaV2t/v94sDXaC8+6Bu0AgBK8WhZObXV6l41ZXav/M4jkJ+CrWvqsU
	 b9WExD9+mty9gmdg+IZw092emoEIo/hSFXY+9irl//MfrAgoYRrW6E1SLsnb6YusBt
	 7w2We0TvYHhfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/23] dmaengine: sdxi: Add descriptor ring
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-12-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-12-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:19:34 +0000
Message-Id: <20260606001935.18B061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,amd.com:email,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11251-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 684AC64BFDC

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Premature hardware index update causes a race condition (Hardw=
are TOCTOU) allowing the hardware to execute uninitialized or stale descrip=
tors.
- [Medium] Expensive 64-bit software division in the descriptor ring iterat=
or.
- [Low] The `sdxi_ring_resv_foreach` macro evaluates its `resv_` argument m=
ultiple times, creating side-effect hazards.
--

commit 6a855f532756bc29a5250d62a29d1775d0ef6013
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add descriptor ring management

Introduce a library for managing SDXI descriptor ring state. It
encapsulates determining the next free space in the ring to deposit
descriptors and performing the update of the write index correctly, as
well as iterating over slices (reservations) of the ring without
dealing directly with ring offsets/indexes.

> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 0000000000000..91b28c7afbbf9
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
[ ... ]
> +static void sdxi_ring_state_store_widx(struct sdxi_ring_state *rs, u64 n=
ew_widx)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	rs->write_index =3D new_widx;
> +	WRITE_ONCE(*rs->write_index_ptr, cpu_to_le64(new_widx));
> +}

[Severity: Critical]
Is it safe to update the hardware-visible write index here before the
descriptors are actually populated?

In sdxi_ring_try_reserve(), this computes the new write index and immediate=
ly
writes it to the DMA memory visible to the hardware. The lock is then dropp=
ed,
and the caller populates descriptors out-of-order.

If the ring has wrapped around, the old descriptor in a reserved slot might
still have its Validity (V) bit set to 1 from the previous pass (since the
driver does not zero out descriptors upon reclamation).

If another thread concurrently reserves slots, populates them, and rings the
doorbell with its advanced index, the hardware could process all slots up to
that doorbell value. The hardware would then check the V bit on this
preempted thread's slot, find it still set to 1, and erroneously execute the
stale descriptor again, leading to memory corruption.

Can the driver decouple the reservation index from the hardware-visible
index, or clear the V bit inside the reservation lock to prevent this?

[ ... ]
> +static struct sdxi_desc *
> +sdxi_desc_ring_entry(const struct sdxi_ring_state *rs, u64 index)
> +{
> +	return &rs->entry[do_div(index, rs->entries)];
> +}

[Severity: Medium]
Does this cause performance issues on 32-bit architectures?

Using do_div() here means performing a 64-by-32-bit division on every
descriptor access, which compiles to an expensive function call (__do_div64)
on 32-bit systems.

Since descriptor rings are typically sized as powers of 2 (e.g., SZ_1K),
could a bitwise AND (index & (rs->entries - 1)) be used instead?
Alternatively, the iterator could maintain a 32-bit wrapping array index
instead of repeatedly dividing the absolute 64-bit iteration counter.

[ ... ]
> diff --git a/drivers/dma/sdxi/ring.h b/drivers/dma/sdxi/ring.h
> new file mode 100644
> index 0000000000000..d5682687c05cd
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.h
[ ... ]
> +#define sdxi_ring_resv_foreach(resv_, desc_)			\
> +	for (sdxi_ring_resv_reset(resv_),			\
> +	     desc_ =3D sdxi_ring_resv_next(resv_);		\
> +	     desc_;						\
> +	     desc_ =3D sdxi_ring_resv_next(resv_))

[Severity: Low]
Can this macro cause side-effect hazards by evaluating its resv_ argument
multiple times?

The macro passes resv_ into sdxi_ring_resv_reset() once and into
sdxi_ring_resv_next() twice during loop execution. If a caller invokes this
macro with an expression that has side effects (e.g.,
sdxi_ring_resv_foreach(&reservations[i++], desc)), the side effect will be
evaluated multiple times per loop iteration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D12

