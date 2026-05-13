Return-Path: <dmaengine+bounces-10442-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA7MM5rqBGrOQQIAu9opvQ
	(envelope-from <dmaengine+bounces-10442-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:18:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D153AED0
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B031C300B9E9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5433A9610;
	Wed, 13 May 2026 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKKLLNPr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C763A8749;
	Wed, 13 May 2026 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707096; cv=none; b=YhEto2J/v8Ftqo4Hqn9kP+QzXF/+tkynVO/CblLBhfBOlvYbEdjr1LyFwzEBkKMMzznLmy6NjpS1xsZGtE92dgshddzrtyrlgsZiVJVTq1UnUjWnCkofPq10HQjR/r9qw+asBh8kYIqnFH53pahpApvSoKU+8E4nzRga72BH+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707096; c=relaxed/simple;
	bh=6ucYjxGnrgPafSUH/kWExeUbJ7BGbVQ69Gi+lvyBYmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NqM4qY+DaVBmokwkwnF+tvFTii4G8rURcX8xBHcdhFJxbufYjSCdsX4YmzjG7hb2pIJV4o/9tCkfjCOCBM61O1RuSNb4bRaToH7gox2QGgUMclRJw19fR+VgAwq2/O+zX0PkLwB9wAhu48OXa9KVn2km1ZE+AkdqbLqbfOVWX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKKLLNPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6486C19425;
	Wed, 13 May 2026 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778707096;
	bh=6ucYjxGnrgPafSUH/kWExeUbJ7BGbVQ69Gi+lvyBYmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dKKLLNPrRBoJDcXhL+YW99iDV6d0LsdoE7dOE3pNOyj6nFxeiTLRscqs5WmzaBtuo
	 YL7xhV+aeGUnbe5yEBVeZ+rPWQd/9U4thO3zTHgejrjYjOIzejTeHWZYdm0JwNqDb2
	 PsUYUIWoOExkvcFxIpoTmC/NoCr3ProA3hIWhb1GdC9stEcWpxAD9mWyQwi6N4wiZe
	 ilUy8mW9Q8B70kNW8RUeIxJXcmCe1mtX20nLAY61EOTmL4jmJi4RALsP26l/mU5Jkh
	 mkbC45m0Orhg0Q+fMnkgnQt4nAa5rU5N8XvlNPYCZYESjf/RdjXCy7nl+hl1Sm7D0L
	 PB+WXxPfOpX8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/23] dmaengine: sdxi: Provide context start and
 stop APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260511-sdxi-base-v2-19-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-19-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:18:15 +0000
Message-Id: <20260513211815.D6486C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 771D153AED0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,amd.com:email,lists.linux.dev:replyto];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10442-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] DMA Use-After-Free due to missing hardware abort on polling ti=
meout.
- [High] Silent teardown failure in `sdxi_stop_cxt()` leads to active conte=
xt Use-After-Free.
- [Medium] Race condition in `sdxi_completion_poll()` causes false timeouts=
 due to thread preemption.
--

commit 5b80fef0d376d25e0f86622539d35c12aa0571d5
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Provide context start and stop APIs

This commit introduces high-level context start and stop APIs for SDXI clie=
nts.
It implements sdxi_start_cxt() and sdxi_stop_cxt() which operate on struct
sdxi_cxt objects to encapsulate administrative descriptor submission and wa=
it
for completion.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 56e21aa088577..28eb4ccd6c1d4 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> @@ -335,6 +337,81 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
>  }
> =20
> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
> +{

[ ... ]

> +	struct sdxi_completion *sc __free(sdxi_completion) =3D
> +		sdxi_completion_alloc(cxt->sdxi);

[ ... ]

> +	return sdxi_completion_poll(sc);
> +}

If sdxi_completion_poll() times out, it returns -ETIMEDOUT and the
cleanup runs, freeing the DMA-mapped completion memory.

Because the hardware operation is not aborted on timeout, is it possible for
the device to eventually complete the delayed operation and write to the
freed DMA address?

Also, does sdxi_completion_poll() have a race condition that could cause
false timeouts?

Looking at the implementation of sdxi_completion_poll():

	while (le64_to_cpu(READ_ONCE(sc->cst_blk->signal)) !=3D 0) {
		if (time_after(jiffies, deadline))
			return -ETIMEDOUT;
		cpu_relax();
	}

If the polling thread is preempted immediately after the READ_ONCE evaluati=
on,
time_after() might evaluate to true upon resumption. Even if the hardware
successfully updates the signal during the preemption window, wouldn't this
return -ETIMEDOUT without a final check of the signal?

> +void sdxi_stop_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm =3D to_admin_cxt(cxt);
> +	struct sdxi_desc *stop, *sync;
> +	struct sdxi_ring_resv resv;
> +	int err;
> +
> +	might_sleep();
> +
> +	struct sdxi_completion *sc __free(sdxi_completion) =3D
> +		sdxi_completion_alloc(cxt->sdxi);
> +
> +	if (!sc)
> +		return;

Since sdxi_stop_cxt() returns void, memory allocation failures here are
silently ignored.

If this happens, the caller won't know the stop command failed and might
proceed to tear down the context rings and buffers while the hardware is
still active.

Can this regression lead to the hardware accessing freed memory when it
continues fetching from the torn-down rings?

> +
> +	/* This is not how to stop the admin context. */
> +	if (WARN_ON(adm =3D=3D cxt))
> +		return;
> +
> +	err =3D sdxi_ring_reserve(adm->ring_state, 2, &resv);
> +	if (WARN_ON_ONCE(err))
> +		return;

Similarly, if sdxi_ring_reserve() fails, the function returns without
stopping the hardware context, which may also cause the caller to free
resources that the active hardware might still access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D19

