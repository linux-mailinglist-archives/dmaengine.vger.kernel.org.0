Return-Path: <dmaengine+bounces-10441-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFb+Mp3hBGqAQAIAu9opvQ
	(envelope-from <dmaengine+bounces-10441-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:39:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA953A915
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47F7F3008506
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED99375AB5;
	Wed, 13 May 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXnFDbC9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4DD37472A;
	Wed, 13 May 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704710; cv=none; b=P58N+TsHgc6uGtPOq0Wm0zdVIByeyi9QRuZBDIrUa7P2+D+6PXPQz3mPsCl1qfqtQIq05JFK7lALw5e0BIf5X82XVPrdtjkLlo2blGJBwpzn4Fj7GXPlLAUczj+uiccQ+dKSWFIZqWel7H1VDsQuivRBYufPNxNV6VCifiVees8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704710; c=relaxed/simple;
	bh=6BEGjjzP5b/WKrqic3Bz65bOTfbiEJ398jSokxM4d64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZgrdtbXxLdlJIUMEbKEndtIvLCjQ40mmhCFcu58JP8GGfO+e9W9OOkrLWVNgO+qVywIwojynVEP+X6Fwfy1IHVqrmaDwwBpadyHfuNdX9bDoRUwQaRiGBsGh8VX/W5CNu7BvxU+KETQH9F8vr3djiEnHpgixFGDtv8xN9h+Gcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXnFDbC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F757C19425;
	Wed, 13 May 2026 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704710;
	bh=6BEGjjzP5b/WKrqic3Bz65bOTfbiEJ398jSokxM4d64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kXnFDbC95AsKoTEND1pTZaKSVyupTDc7cF3Gtyn6Z4rf17HXJjgG3JD9F8dIsAj50
	 XiryYddN3Rxyh0iF2y/LacHVfN7P6LCPbH8jKpztZhyDYsL7luqpxmX/EbDCaH6ZT3
	 Du+XMkiECr2SzBbRH+upOglxyvq3hTWJ+dy5FrqwkBskAqHKBrQF0U0mmPSz+9cVZm
	 yEmOHNMe01M6EMeBaBcIZhvBYZ0zaIapsx+gg0tlStn9Is8gNhlmKMa7SpzmlPxCaA
	 SF/ddLywOHnj1WpLfEv/AG/5dBZtYRDcJOLW6DcZ5ENXiaMYxK5hH4liX8p08cNSVy
	 1D8dYwmE72bTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/23] dmaengine: sdxi: Add completion status block
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-17-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-17-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:38:29 +0000
Message-Id: <20260513203830.2F757C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4BEA953A915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10441-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Misplaced memory barrier in `sdxi_completion_signaled()` allows sp=
eculative stale reads.
- [High] Unsafe use of `jiffies` for an excessive 1-second busy-wait loop i=
n potentially atomic contexts.
- [Medium] False timeout failure in `sdxi_completion_poll()` due to missing=
 final check (TOCTOU race).
--

commit 06424605658df30b37e1f10fa36bddfa9f3b20e8
Author: Nathan Lynch <nathan.lynch@amd.com>

    dmaengine: sdxi: Add completion status block API

This commit introduces an API for managing DMA-coherent completion status
blocks for SDXI descriptors. It includes functions for allocating, polling,
and querying the status of these completion blocks.

> diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
> new file mode 100644
> index 0000000000000..7ffd034b129b8
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.c
[ ... ]
> +int sdxi_completion_poll(const struct sdxi_completion *sc)
> +{
> +	unsigned long deadline =3D jiffies + msecs_to_jiffies(1000);
> +
> +	while (le64_to_cpu(READ_ONCE(sc->cst_blk->signal)) !=3D 0) {
> +		if (time_after(jiffies, deadline))
> +			return -ETIMEDOUT;

Could this cause a spurious timeout if the thread is preempted or delayed
between the signal check and the timeout check? If the hardware completes t=
he
DMA request during the delay, jiffies will have advanced past the deadline
when the thread resumes, causing the function to incorrectly return
-ETIMEDOUT. A final read of the signal field after the timeout condition
might prevent this race.

Also, is it safe to busy-wait using jiffies for up to 1 second here? The
use of GFP_NOWAIT in sdxi_completion_alloc() suggests this API might be
called from atomic or interrupt-disabled contexts. Busy-waiting for 1 second
could cause severe latency or soft lockups. Furthermore, if interrupts are
disabled on the CPU responsible for the timer tick, jiffies will not
increment, potentially resulting in an infinite loop.

> +		cpu_relax();
> +	}
> +
> +	return sdxi_completion_errored(sc) ? -EIO : 0;
> +}
> +
> +bool sdxi_completion_signaled(const struct sdxi_completion *sc)
> +{
> +	dma_rmb();
> +	return (sc->cst_blk->signal =3D=3D 0);

Does this read memory barrier need to be executed after checking the signal
field instead of before? Placing dma_rmb() before evaluating the
DMA-coherent signal allows the CPU to speculatively fetch payload data
before confirming the device has actually signaled completion. Moving the
barrier after a successful check (and using READ_ONCE) would ensure the
payload reads are properly ordered.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D17

