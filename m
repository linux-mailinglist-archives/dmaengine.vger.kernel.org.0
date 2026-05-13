Return-Path: <dmaengine+bounces-10444-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FkdNcPwBGr7QQIAu9opvQ
	(envelope-from <dmaengine+bounces-10444-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:44:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 400AD53B275
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8641A30136A1
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB493C1412;
	Wed, 13 May 2026 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8pw5ybz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1373C0634
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708672; cv=none; b=SLEe38BYbEBBhMgRzNw8gR5wHd7s3nsO/o4HPa2lvH/k5IzHmOATKMcIo6AihU9LEQfW5VhyaegNOAeK4NLISJlEfd+6yNyKGgGCtKv1A2uxN8XkhYKZUYHrEaQCdbOAqiW+nynsKqSpsvdhgARoWS7GnCC4a38D5ctZwZ/Bqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708672; c=relaxed/simple;
	bh=5QwVMKeI05U1obHYu/hxqahUr/5nuUzqhiQkAac84J8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPaNJljmbNMXn3Snj98/bWp6o4m4f+7jLhRak8kiTjXCerWYxPwfW1V7nXg/JC7N1pzZmugvMd9KSSjkpK8d5FSMkteqIBWrN+jF0PXY/n9Ex64NZe/ZcZgo4FkS2lTQHbDA81AfO5UvlMVsu71awHxiuEYE4I20wuYyq+Inegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8pw5ybz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44781C19425;
	Wed, 13 May 2026 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778708672;
	bh=5QwVMKeI05U1obHYu/hxqahUr/5nuUzqhiQkAac84J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e8pw5ybzoZnRijGIG23rV11DU1eNgKC5KcoaxwlZZPHM7drmpVgAy5o2v9bMg8JU7
	 qoro0CCZbDvFzfAnzO7mTEcjpO1WQupv91GB6VkneP7KJu+LmYU4shRt04u5Wo16UA
	 a5zSh1lyyV8wW8dixA5BXwjXoVtRk8uuiNtVWc3UiyQ4mfGP72rRatWJ9uETjAZuAv
	 411mNwsDnJ/DrviPouWHYShvXTi8geBdWo7zSbiL1nG8DXgH5THFeVfvSucDiY5OGc
	 3FGCnhL04jXy1WnDhdzz5VnY2QQiKuX3PN5cLE5kdbN9ExlARNzHXk+kffr8jgsquK
	 OFLemEQCH3XIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, wsa+renesas@sang-engineering.com, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512121219.216159-2-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 21:44:31 +0000
Message-Id: <20260513214432.44781C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 400AD53B275
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10444-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Asynchronous pm_runtime_put() used immediately before pm_runtime_d=
isable() leaves hardware in incorrect state.
- [High] Hardware is placed in reset and powered down while devm-managed in=
terrupts are still active, risking a kernel crash.
- [High] Missing tasklet_kill() during probe error and removal paths leads =
to a Use-After-Free.
--

commit db01e5ee3e302bfa4e29d74e8df1953929f696eb
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Move interrupt request after everything is set up

This patch fixes potential invalid memory access during probe by moving the
interrupt request to the end of the channel initialization, ensuring all
data structures are fully set up before the interrupt handler can run. It
also switches to dmam_alloc_coherent() to simplify the error and removal
paths.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 625ff29024de0..9f206a33dcc6b 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  static void rz_dmac_remove(struct platform_device *pdev)
>  {
>  	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
> =20
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  }

While reviewing these changes, I noticed a few pre-existing regressions that
remain after this patch.

Does calling pm_runtime_put() asynchronously right before pm_runtime_disabl=
e()
leave the hardware active?

pm_runtime_put() queues an idle request, but the subsequent
pm_runtime_disable() cancels pending async operations via
__pm_runtime_barrier(). Should this use pm_runtime_put_sync() instead to
ensure the device actually suspends and doesn't leak power resources?

Also, the hardware reset is asserted (reset_control_assert) and PM is
disabled before returning. Since the interrupts are registered with
devm_request_irq() and devm_request_threaded_irq(), they will be freed by
devres only after returning.

If a spurious or delayed interrupt fires during this window, could the IRQ
handler access hardware registers while the IP block is in reset and uncloc=
ked,
leading to a crash?

Finally, vchan_init() initializes a tasklet (channel->vc.task) for each
channel. Since the channels array is allocated with devm_kcalloc(), it is
automatically freed by devres on removal or probe failure.

However, there is no explicit tasklet_kill() during removal or probe error
handling. Although devres frees the IRQ, free_irq() only syncs the handler
and thread, not pending tasklets. If the tasklet is scheduled before the IRQ
is freed, could it remain on the system softirq queue and execute after
devres frees the channel memory, causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D1

