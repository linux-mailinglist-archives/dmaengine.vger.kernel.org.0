Return-Path: <dmaengine+bounces-10406-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IkMHWoKBGqKCgIAu9opvQ
	(envelope-from <dmaengine+bounces-10406-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 07:21:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6352D82B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 07:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CEDC3020BFD
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05073A450F;
	Wed, 13 May 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oytO2Ddn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AE3A4509;
	Wed, 13 May 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649697; cv=none; b=sO/K5kFQUMSTntu4VcCLpx1ZYfZaF/Z28k5Fr8qUmf9ILxrt5tbblt1mwRuHWMAhxyeYX9D4LdVnB6TfFnWaCbZYIun+Ui2K08r+QXI6q6t8V1th3EeK0GpNyRN1ZOydBAH4gko4/tXiDNz48BX/J4Zq6TvBXKpo7ow+CAQveAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649697; c=relaxed/simple;
	bh=LvrOMRiTy1xiaYbaN6mRTkorUA/sQQV3b5cPoBYx5g4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfiySKEM2vonwwmWaOv1+mnMArrw+erD9YquGrNq2klcrm4vZpVIgvyeGQV9JkC8qCH1GfULfhTgA5q4K40Qtnid9BGs8N8sz4NagFvkBCrDYG66v17iN/PoAacKdsWtk2QV/GJOxIfDj1Uvkwt2Kr+pUkhTYRXi5sPT09LiSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oytO2Ddn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14261C4AF0B;
	Wed, 13 May 2026 05:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778649697;
	bh=LvrOMRiTy1xiaYbaN6mRTkorUA/sQQV3b5cPoBYx5g4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oytO2DdnzOuHajReHF+Q0sBveCnaKZSoqxds+KcANs3CB/NUJ8FTz9zqrgaUp60so
	 qjo9XdGWmNfm8q4D1CeD1XU3Ke8HZsZ/YYbA3A9hZFBDnCHbxDHkrUkw+ZAMkbVweG
	 07ItZ9+vi8Pp0PlMt5vO6TLGPbBarCYzQqx01xe6DmzKhGpEFaIV7wREsbYh2EJykb
	 cikYVipdwWCegue1qQ/zMu7o0Yg1YFYAXUii50oCORVci9mHkw+jLly+KK0S0aEMVE
	 MSq0LSAy15bRobrRyxev4J+z3o7uEKo5QgK5M3ftnZCV373hdkhj5//OqdAeneIYMD
	 tYRHdCP6FW5+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/23] dmaengine: sdxi: Add descriptor ring
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-12-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-12-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:21:36 +0000
Message-Id: <20260513052137.14261C4AF0B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BBA6352D82B
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,amd.com:email,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10406-lists,dmaengine=lfdr.de];
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unkillable task hang and Use-After-Free in ring reservation during=
 device removal or hardware wedge.
- [High] Potential torn reads of the shared 64-bit read index on 32-bit arc=
hitectures permanently wedge the ring.
- [Low] Macro `sdxi_ring_resv_foreach` evaluates the `resv_` argument multi=
ple times.
--

commit fb903a32d5204efe5e95d75203c430ca1c4e7e8d
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add descriptor ring management

This commit introduces a library for managing SDXI descriptor ring state,
encapsulating free space checks, write index updates, and reservation
iteration. It provides blocking and non-blocking reservation APIs and
mechanisms to iterate over descriptors within a reservation.

> diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
> new file mode 100644
> index 0000000000000..91b28c7afbbf9
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring.c
[ ... ]
> +static u64 sdxi_ring_state_load_ridx(struct sdxi_ring_state *rs)
> +{
> +	lockdep_assert_held(&rs->lock);
> +	return le64_to_cpu(READ_ONCE(*rs->read_index_ptr));
> +}

Can this result in a torn read on 32-bit architectures? READ_ONCE() on a
64-bit variable expands to two 32-bit load instructions on 32-bit systems.

Since the SDXI hardware updates this memory location concurrently via DMA,
the CPU might observe a torn value if the read occurs while the index
crosses a 32-bit boundary. This could produce a massively inflated read
index, causing the subsequent check in sdxi_ring_try_reserve() to
permanently return -EIO.

[ ... ]
> +/* Blocking ring reservation. Retries until success or non-transient err=
or. */
> +int sdxi_ring_reserve(struct sdxi_ring_state *rs, size_t nr,
> +		      struct sdxi_ring_resv *resv)
> +{
> +	int ret;
> +
> +	wait_event(rs->wqh,
> +		   (ret =3D sdxi_ring_try_reserve(rs, nr, resv)) !=3D -EBUSY);
> +
> +	return ret;
> +}

Does this wait_event() need to handle timeouts or signals? If the hardware
wedges or the device is hot-unplugged, the read index will never advance,
leaving tasks permanently hung in TASK_UNINTERRUPTIBLE sleep.

Furthermore, if the driver is unbound and destroys the wait queue while
tasks are still waiting here, could this result in a use-after-free and
subsequent kernel panic when the scheduler interacts with the freed wait
queue?

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

This isn't a bug, but this macro evaluates the resv_ argument multiple time=
s.
If a caller passes an expression with side effects, it could cause unintend=
ed
behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D12

