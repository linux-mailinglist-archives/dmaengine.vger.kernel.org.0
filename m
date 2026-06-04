Return-Path: <dmaengine+bounces-11156-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jc6wEh5IIWrvCQEAu9opvQ
	(envelope-from <dmaengine+bounces-11156-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 11:40:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189C63E9E6
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 11:40:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=obROYO1k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11156-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11156-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0CD3002FB5
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD42D63F8;
	Thu,  4 Jun 2026 09:34:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2631D7E41
	for <dmaengine@vger.kernel.org>; Thu,  4 Jun 2026 09:34:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565677; cv=none; b=PThzLhNOIVIgHcxgaeuhLQzVP19DbZUnoFrOEmkOfmOCOdieGBSyItkFgBd6yrmV9fO3tJBptjDGB2/aIPPJ1OQG74QAoqyycU7KF68xXHhzuJjNnoKFP9xbxYN0zDqpPe/3y8zKV7S35ZAM1GjWskx3xJBjbgkv+QVM5g7I3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565677; c=relaxed/simple;
	bh=y5US1Q8HmFZ0VkoLAl82t7826wviRa6op/Lum74SZpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMLfP/IR9BTwV7Sxa7RBAU0nlW2mDbCldzMrfq+NzDxPE3MAn2d9zj4//GpwPZ3I9rhckI/aWkIqme4uDV0C53Lg6M0+ZI/3zhTLHeFZoquigXORpSw1aL+BH+i8DYhSRlNHJLDjQcGmqmcXwGjkYHt+lmW6JdkGWkwq/6kNBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obROYO1k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45911F00893;
	Thu,  4 Jun 2026 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565676;
	bh=rnzB8itEhBpwLD08Z565IJtCG/rHZZPH9HMk4jBRHxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=obROYO1kLzcWwOCpumC7fKiD9F671KJy3qLiRuV1dU07utcnHGaZu2JoiA1QyWdtv
	 RcgbF7zAUJMkxAYG4OhGqueoWPhGmLObT0hCLYQZXE92ZwnrnhL/BTwbPN5PHHQwVB
	 4I7arrvLWBxHudJMELB6AaaCxUQeHPZiemuLAgAimz4ZWBdIdMF9hCEQhk8Br6MJrN
	 j2ozbr/ZjK0kh1Q9aXvzMXvHnqe/0Kn2d9LNAJZEhCoianhwbNf62xJdQYHrQsoNir
	 hn1uYwGs+JgidxIBEiD2QaaI0XF39lNHdCdnnDkdYfiYmSljum2I3DZ65wVZMKGvf3
	 CbV+pKK0hD2iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260604092320.257303-1-zenghongling@kylinos.cn>
References: <20260604092320.257303-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:34:35 +0000
Message-Id: <20260604093435.E45911F00893@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11156-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7189C63E9E6

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch introduces a NULL pointer dereference in the error h=
andling paths of `at_dma_probe()` by calling `at_dma_cleanup_channels()` be=
fore the channel list is initialized.
- [High] The patch introduces a flawed teardown order by calling `tasklet_k=
ill()` before `free_irq()`, leaving a race condition open that allows an in=
terrupt handler to schedule a tasklet after it has been killed.
--

commit 616bebad1ba493e9e69b6cbd4fcc4afc4e20c2f9
Author: Hongling Zeng <zenghongling@kylinos.cn>

dma: at_hdmac: Fix use-after-free by proper tasklet cleanup

This commit aims to fix a use-after-free vulnerability by introducing
a cleanup function that explicitly kills tasklets during device teardown.
It modifies both the probe error path and the remove function.

Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel=
.org/

> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c

[ ... ]

> @@ -2109,6 +2122,7 @@ static int __init at_dma_probe(struct platform_devi=
ce *pdev)
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
> +	at_dma_cleanup_channels(atdma);
>  	free_irq(platform_get_irq(pdev, 0), atdma);

[Severity: Critical]
Does this cause a NULL pointer dereference during a probe failure?

The atdma structure is allocated earlier via devm_kzalloc(), meaning the
dma_device.channels list head is initially zeroed out.

If dma_pool_create() fails, we jump to err_desc_pool_create and call
at_dma_cleanup_channels(). However, INIT_LIST_HEAD() hasn't been called yet.

When at_dma_cleanup_channels() executes list_for_each_entry_safe() on
the uninitialized list, it will dereference the NULL pointers, resulting in
a kernel panic.

[ ... ]

> @@ -2125,17 +2139,12 @@ static void at_dma_remove(struct platform_device =
*pdev)
>  		of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&atdma->dma_device);
> =20
> +	at_dma_cleanup_channels(atdma);
> +
>  	dma_pool_destroy(atdma->memset_pool);
>  	dma_pool_destroy(atdma->lli_pool);
>  	free_irq(platform_get_irq(pdev, 0), atdma);

[Severity: High]
Is it safe to place at_dma_cleanup_channels() before free_irq() here?

The commit message indicates we need to disable interrupts, kill tasklets,
and then free the IRQ. However, atc_disable_chan_irq() inside the cleanup
function only disables the hardware interrupt; it doesn't synchronize with
an already-executing IRQ handler on another CPU.

If an interrupt handler is currently running and delayed, it can schedule
a tasklet after tasklet_kill() has already returned.=20

Because free_irq() is the function that actually synchronizes with running
handlers, wouldn't free_irq() need to be called before tasklet_kill() to
prevent the handler from re-queueing the tasklet and triggering the exact
use-after-free this patch is trying to fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604092320.2573=
03-1-zenghongling@kylinos.cn?part=3D1

