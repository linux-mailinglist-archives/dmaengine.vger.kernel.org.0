Return-Path: <dmaengine+bounces-11432-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g2RON/szKmr6jwMAu9opvQ
	(envelope-from <dmaengine+bounces-11432-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:05:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC066E1CE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:05:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ODrAk77c;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11432-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11432-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE6C301E7EE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E1212548;
	Thu, 11 Jun 2026 04:05:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7340D573
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 04:05:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150712; cv=none; b=Y305aRqjk3HhmZZabWRZC/4gFz3nKZzYLKslJ/1ZbAZvDzmLRG1awlWMg/D8E5YOw4wl1j1dWhYvjdbNYMpEIuWT+Ik7rEClTEVZ0eBv9eBz1IFs6goa20CEbtFFz+8ZwfMESMySlRrjuoiNQ/exJALQFlVAG5/IIU3W+bOND1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150712; c=relaxed/simple;
	bh=ddz7xRY4ICJqiclQqz56B81pZfU6wJLI5naL4FK96dI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZeqnsAcwGAKuK1NtQvLyGuB2+UqSdNMmY8E8LotzNlC7WetufIodkDMAG9aAfRR3a1I+oR4/CwvTfvO6HrGcSTXAEiY0OZIGttFEAgqSP4S/WqEjQ3qw0PEXE/JD30a00FNzqzpGL91ltSLQ99bMMPf2Sm5whTahpdMymL4aMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODrAk77c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA21F00893;
	Thu, 11 Jun 2026 04:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781150710;
	bh=Q+eb10XsyAYRaCkI2HEBeIn2DIzfwGS7vSa43ebES2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODrAk77c9pWFU+N7fkBYi5FkqcFNM9/wdB+cNXgpT5zwUbk09ULoOEcRM3P9oZk9z
	 15qCDrqCMKs0bvt0fbSUhLUtsvbufg+qjATXN813otzbFCXwdo8SpR9B7p0dW4agYm
	 SQ8g3Hkoj9d7p3GwTUljUb7We2lJ5pEqI8XGLElHBnuCeCWDHpqCz6o21etvw7a9F0
	 s3QK7f9e34YFtlexgU1A9m27xtGdu9f7T/2nGJVhz2mnBwCH/a3voGdXpk8ASF3p7i
	 Ya2P4BHlWMal7dkoeNidT0HTGFsigfnqqyuIcQHOzfXtVTBmWN1lDq3t7exej4nuP0
	 +qmkmC8hSD7Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 01/15] dmaengine: fsldma: kill tasklet before removing
 channel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260611035245.13439-2-rosenp@gmail.com>
References: <20260611035245.13439-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:05:10 +0000
Message-Id: <20260611040510.A1FA21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11432-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51DC066E1CE

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] fsldma_of_probe ignores the return value of dma_async_device_regis=
ter.
- [High] Use-after-free read in fsl_dma_prep_memcpy error path due to freei=
ng the list head during iteration.
- [High] Link descriptors are leaked if fsl_dma_tx_submit() is called while=
 the device is suspended.
- [High] Deadlock caused by invoking client callbacks and dependencies with=
 desc_lock held.
- [Medium] Incorrect loop unwind in fsldma_request_irqs leads to freeing an=
 unallocated IRQ.
--

commit 45ba39c99b39bf6124bcca48128dda7ac68f9811
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: kill tasklet before removing channel

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..0e2f84862261c 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device =
*fdev,
> =20
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);

[Severity: Medium]
This is a pre-existing issue, but I noticed the error handling in
fsldma_request_irqs() can free an unallocated interrupt:

drivers/dma/fsldma.c:fsldma_request_irqs() {
...
out_unwind:
	for (/* none */; i >=3D 0; i--) {
		chan =3D fdev->chan[i];
		if (!chan)
			continue;

		if (!chan->irq)
			continue;

		free_irq(chan->irq, chan);
	}
...
}

If request_irq() fails for a channel at index i, the driver does not own
the interrupt for that index. Does starting the unwind loop at the same
index i trigger a kernel warning for trying to free an already-free
interrupt?

[Severity: High]
This is a pre-existing issue, but the return value of
dma_async_device_register() appears to be discarded during probe:

drivers/dma/fsldma.c:fsldma_of_probe() {
...
	dma_async_device_register(&fdev->common);
	return 0;
...
}

If dma_async_device_register() returns an error code like -ENOMEM, the
driver will falsely report a successful probe.

Could this leave the device partially initialized and cause a
use-after-free or id allocator free on an uninitialized id when
dma_async_device_unregister() is called during module unbind?

[Severity: High]
This is a pre-existing issue, but there appears to be a use-after-free
read in the error path of fsl_dma_prep_memcpy():

drivers/dma/fsldma.c:fsl_dma_prep_memcpy() {
...
fail:
	if (!first)
		return NULL;

	fsldma_free_desc_list_reverse(chan, &first->tx_list);
	return NULL;
}

When fsldma_free_desc_list_reverse() is called, it iterates through
tx_list:

drivers/dma/fsldma.c:fsldma_free_desc_list_reverse() {
...
	list_for_each_entry_safe_reverse(desc, _desc, list, node)
		fsl_dma_free_descriptor(chan, desc);
...
}

Since all descriptors, including first, are linked into first->tx_list,
when the first descriptor is freed, its embedded tx_list head is also
freed.

Does the safe iterator macro then read a freed next pointer when
evaluating the next element, resulting in a use-after-free read?

[Severity: High]
This is a pre-existing issue, but link descriptors seem to leak if a
transaction is submitted while the device is suspended:

drivers/dma/fsldma.c:fsl_dma_tx_submit() {
...
#ifdef CONFIG_PM
	if (unlikely(chan->pm_state !=3D RUNNING)) {
		chan_dbg(chan, "cannot submit due to suspend\n");
		spin_unlock_bh(&chan->desc_lock);
		return -1;
	}
#endif
...
}

Since the descriptors were allocated by fsl_dma_prep_memcpy() and
ownership was handed off for submission, returning here without queueing
them leaves them orphaned.

Are these descriptors permanently leaked from the dma pool?

[Severity: High]
This is a pre-existing issue, but could invoking client callbacks while
holding desc_lock lead to a deadlock?

drivers/dma/fsldma.c:dma_do_tasklet() {
...
	spin_lock(&chan->desc_lock);
...
	fsldma_cleanup_descriptors(chan);

	spin_unlock(&chan->desc_lock);
...
}

fsldma_cleanup_descriptors() iterates over running descriptors and calls
fsldma_run_tx_complete_actions(), which invokes callbacks:

drivers/dma/fsldma.c:fsldma_run_tx_complete_actions() {
...
		dmaengine_desc_get_callback_invoke(txd, NULL);
...
}

If the client callback calls dmaengine_submit() or a dependent
transaction executes on the same channel, it will call
fsl_dma_tx_submit(), which attempts to acquire
spin_lock_bh(&chan->desc_lock).

Will this cause a self-deadlock since the lock is already held by the
tasklet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611035245.1343=
9-2-rosenp@gmail.com?part=3D1

