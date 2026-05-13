Return-Path: <dmaengine+bounces-10407-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNtVBqsQBGoMDAIAu9opvQ
	(envelope-from <dmaengine+bounces-10407-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 07:48:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADD52DBC6
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8515C303E252
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8213A9DB3;
	Wed, 13 May 2026 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsGB1zth"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C33A71B8;
	Wed, 13 May 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651300; cv=none; b=i7ztI1LYe3wXpdhyYdyr/O1Doihs+e8ypwOEjC3gOzFgHHL4vVdEwVr+i9ljD2xqtxP/g+kWq2LWGoMiFbMCoYjhabf972WSwZ8DefWO1tSad8aDhw4p9acOikeEqid45p4OMg9tLDk1zS0WVnWtHWsijegh+UVLBYBvUPbE4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651300; c=relaxed/simple;
	bh=3Wkm0ngZUbNKuDF21VSGvej0CaJ2Mz0hkkTQOCXZzO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYKPOWMT0Xgqw1urOwQZcl+oqA98j0FSuMynpvH9q5zuKMOPntOc7HDGCoWZRAsglypHthpv7a2e3/YSCHXJCvqTHNJM4LpVmciWNiHeAUr2cP4+H28iZFEpNLaA9IBUyAFY3BpnYTTpRGQrTjNlyKG6/6l2SPNtPIhis0wxE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsGB1zth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AD5C2BCB7;
	Wed, 13 May 2026 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778651300;
	bh=3Wkm0ngZUbNKuDF21VSGvej0CaJ2Mz0hkkTQOCXZzO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NsGB1zthK4OvMg3oVnnQr8YMv7+qgYipTAZAWGyacINEPLXNn449VEHGXQiJtY1V9
	 Xwi02zXjJvbexn7lrBXrODCrr2rNfUZ0GVEN5O4R/jaAtSc78eSGmdmBb66mfHAE/v
	 cPVae+RRLOfY/ldE63GidfkD1C0sTnrSVgPrOp+N9rCimZDZyig/ei5t8pftZxTxJZ
	 dUyc+IO7G9pnK9aQGffx1d8MwF6PC+T0zzxFBTjKKS1Ptgtyc0nki3fdngjT/lp5cs
	 zzYmUOc9PR8mOPKeKRNhuQhDXDOTEqzaOOjh4HKofL1D0wnvb4b265WVn2dE5N3M6Z
	 OmlhodKk6N4fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/23] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-13-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-13-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:48:19 +0000
Message-Id: <20260513054819.E0AD5C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9FADD52DBC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10407-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `sdxi_ring_resv_foreach` loop double-advances the iterator, =
silently skipping half of the descriptors.
- [Medium] The `invalid` test intentionally triggers a `WARN_ONCE`, which w=
ill crash CI systems running with `panic_on_warn`.
- [Low] The mock device allocated in the test suite's init function is comp=
letely unused.
--

commit 810cd03f2a72b539ae4d775dcbc2ceb2fa73ee06
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add unit tests for descriptor ring reservations

This commit adds KUnit tests for the SDXI descriptor ring reservation
API. It covers valid reservations as well as error paths, and does not
require hardware to execute.

> diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
> new file mode 100644
> index 0000000000000..3bc7073e0c39a
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring_kunit.c

[ ... ]

> +static void valid(struct kunit *t)
> +{
> +	__le64 wi, ri;
> +	struct sdxi_ring_state r;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_desc *descs, *desc;
> +
> +
> +	descs =3D kunit_kmalloc_array(t, SZ_1K, sizeof(descs[0]),
> +				    GFP_KERNEL | __GFP_ZERO);
> +	KUNIT_ASSERT_NOT_NULL(t, descs);
> +
> +	ri =3D wi =3D 0;
> +	sdxi_ring_state_init(&r, &ri, &wi, SZ_1K, descs);
> +
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, r.entries, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, resv.range.start, 0);
> +	KUNIT_EXPECT_EQ(t, resv.range.end, r.entries - 1);
> +	KUNIT_EXPECT_EQ(t, le64_to_cpu(wi), r.entries);
> +	sdxi_ring_resv_foreach(&resv, desc) {
> +		KUNIT_EXPECT_NOT_NULL_MSG(t, sdxi_ring_resv_next(&resv),
> +			"unexpected null descriptor for index %llu", resv.iter);
> +	}

Does this loop double-advance the iterator? The sdxi_ring_resv_foreach
macro already calls sdxi_ring_resv_next() on each iteration to populate
the desc variable. Calling sdxi_ring_resv_next() again inside the loop
body means we silently skip half of the descriptors in the ring. Should
this assert directly on the desc variable instead?

> +
> +	ri =3D cpu_to_le64(1);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, 1, &resv), 0);
> +	KUNIT_EXPECT_EQ(t, le64_to_cpu(wi), r.entries + 1);
> +	KUNIT_EXPECT_NOT_NULL(t, sdxi_ring_resv_next(&resv));
> +}
> +
> +static void invalid(struct kunit *t)
> +{
> +	__le64 wi, ri;
> +	struct sdxi_ring_state rs;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_desc *descs;
> +
> +	descs =3D kunit_kmalloc_array(t, SZ_1K, sizeof(descs[0]),
> +				    GFP_KERNEL | __GFP_ZERO);
> +	KUNIT_ASSERT_NOT_NULL(t, descs);
> +
> +	ri =3D wi =3D 0;
> +	sdxi_ring_state_init(&rs, &ri, &wi, SZ_1K, descs);
> +
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 0, &resv), -EINVAL);
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, rs.entries + 1, &resv), -=
EINVAL);

Will these tests trigger the WARN_ONCE in sdxi_ring_try_reserve() when
given an invalid size? Unconditionally hitting a WARN path in a KUnit
test will cause kernel panics on CI systems configured with panic_on_warn.

> +
> +	ri =3D cpu_to_le64(1);

[ ... ]

> +static int setup_device(struct kunit *t)
> +{
> +	struct device *dev =3D kunit_device_register(t, "sdxi-mock-device");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
> +	t->priv =3D dev;
> +	return 0;
> +}

This isn't a bug, but is this mock device setup needed? Neither the valid
nor invalid test cases appear to access t->priv or require a device pointer
for the ring APIs being tested.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D13

