Return-Path: <dmaengine+bounces-11250-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oxAoDvdmI2pdswEAu9opvQ
	(envelope-from <dmaengine+bounces-11250-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:16:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C635464BF9C
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:16:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jszW70k/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11250-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11250-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D6B8301DCE4
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE73EA66;
	Sat,  6 Jun 2026 00:16:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B661DF751;
	Sat,  6 Jun 2026 00:16:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705013; cv=none; b=Uc1pyt7HKTou24kgNPp8QcSposLQ6OGX1H9XLVj1HMwq4TBXN9KhdXn1rQOSJE4Wc6A85we3E2c5U2KJ3gSG6Q/0g9f1WRsqC5vak5cbaq4KhyGr6C2CqTC39vjwaEbtsonwXJbT01wlgBSBm6HYwRO5z98Pj1EDH8b6CbjB7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705013; c=relaxed/simple;
	bh=n2guc/d2PswA2ntbqXqTN/zIc5bXAb/tNSyv4VYFkcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=riViWvmevaruNeoDy54dPPim4NKj/dRXl/w2qArZ1mZOCR0qBGczaVc3Huc6/SVAY+6at6db9zO6VBYN1BsyRt7/R2ZClZI1nGzCuwqVY9ejzmubZIp/kZ9pJxHXmCtHESira47EXFp62tfS78LEChb1KjV03tvyq2kZXPSMdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jszW70k/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C671F00893;
	Sat,  6 Jun 2026 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705012;
	bh=oDMMNUe21bEZNjboSU8kWleNI781Ey8Nlo1Pj5h7qyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jszW70k/ihb6YhmyVB9XNIw7yBVi8aofYWEzz4d3kzlXPdPsSIK4M561Nc58cDdrR
	 H600z/LofvKMqo3DMcYYa2mTXMe8cP2w+ykQ7sgohc6p4perSUB53WEvCyu5Vk9ouG
	 hqJVsesx3ce5SvOQd0RUqH8QJ91/52gevPwlslwWB6GWGGxwUThwhsy27lO9Tajmks
	 QPwSrnZiKUKl0w5KuSufwH0D+BtjP/XLntJcAJPs7TV9VhFnhZdp7cVHz543vS8OAN
	 XqaDG7RixX/NHhnPwQ6vBvQahvS4BUBc+FXBvNN/w6+6AcaOzQ2rFoFoBhl0iSb+EH
	 oO8U8Y4iET2Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/23] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-13-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-13-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:16:51 +0000
Message-Id: <20260606001652.14C671F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,amd.com:email];
	TAGGED_FROM(0.00)[bounces-11250-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C635464BF9C

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The KUnit test advances the reservation iterator twice per loop =
iteration, verifying only half of the reserved descriptors and evaluating u=
nsequenced arguments.
- [Medium] The `invalid` test intentionally triggers a kernel warning (`WAR=
N_ONCE`) without suppressing it, which pollutes the kernel log and causes c=
rashes in CI environments.

Pre-existing issues:
- [High] The ring reservation API updates the hardware-visible write pointe=
r before descriptors are populated, risking the device processing uninitial=
ized memory (TOCTOU) and lacking necessary memory barriers.
--

commit 4fc6ef8e997ae4fb9c2e324c9e00fd0b37015590
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add unit tests for descriptor ring reservations

Add KUnit tests for the descriptor ring reservation API, covering valid
reservations and error paths. A .kunitconfig is included ease of use. No
SDXI hardware is required to run these tests.

> diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
> new file mode 100644
> index 0000000000000..3bc7073e0c39a
> --- /dev/null
> +++ b/drivers/dma/sdxi/ring_kunit.c
> @@ -0,0 +1,105 @@
[ ... ]
> +static void valid(struct kunit *t)
> +{
[ ... ]
> +	sdxi_ring_resv_foreach(&resv, desc) {
> +		KUNIT_EXPECT_NOT_NULL_MSG(t, sdxi_ring_resv_next(&resv),
> +			"unexpected null descriptor for index %llu", resv.iter);
> +	}

[Severity: Medium]
Does this loop inadvertently consume two descriptors per iteration?

The macro sdxi_ring_resv_foreach() implicitly advances the iterator:

drivers/dma/sdxi/ring.h:
#define sdxi_ring_resv_foreach(resv_, desc_)			\
	for (sdxi_ring_resv_reset(resv_),			\
	     desc_ =3D sdxi_ring_resv_next(resv_);		\
	     desc_;						\
	     desc_ =3D sdxi_ring_resv_next(resv_))

By calling sdxi_ring_resv_next() again inside the loop body, the test
skips validation for half of the elements.

Additionally, could calling sdxi_ring_resv_next(&resv) and reading
resv.iter in the same macro expansion lead to unsequenced argument
evaluation?

> +
> +	ri =3D cpu_to_le64(1);
[ ... ]
> +static void invalid(struct kunit *t)
> +{
[ ... ]
> +	ri =3D wi =3D 0;
> +	sdxi_ring_state_init(&rs, &ri, &wi, SZ_1K, descs);
> +
> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 0, &resv), -EINVAL);

[Severity: Medium]
Will this intentionally trigger a warning that pollutes the kernel log?

The test passes invalid arguments designed to trigger a WARN_ONCE in
sdxi_ring_try_reserve():

drivers/dma/sdxi/ring.c:sdxi_ring_try_reserve()
	if (WARN_ONCE(nr < 1 || nr > rs->entries,

Since there is no framework mechanism in this test to handle or suppress
this warning, does it permanently consume the global warned state? This
could hide future issues and cause the test suite to panic if panic_on_warn=
=3D1
is set.

[Severity: High]
This is a pre-existing issue, but does the ring reservation API update the
hardware-visible write pointer before descriptors are populated?

Looking at sdxi_ring_try_reserve() in drivers/dma/sdxi/ring.c:

drivers/dma/sdxi/ring.c:sdxi_ring_try_reserve()
		if (new_widx - ridx > rs->entries)
			return -EBUSY;

		sdxi_ring_state_store_widx(rs, new_widx);

It updates rs->write_index_ptr in hardware-visible DMA memory immediately
upon reservation, before the caller populates the returned descriptor range.

If Thread A reserves and begins filling a descriptor, and Thread B reserves,
fills, and rings the doorbell, would the device read the updated write
pointer and process Thread A's uninitialized descriptor?

Could this also require a preceding dma_wmb() barrier to ensure descriptor
writes complete before the write pointer is updated?

> +	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, rs.entries + 1, &resv), -=
EINVAL);
> +
> +	ri =3D cpu_to_le64(1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D13

