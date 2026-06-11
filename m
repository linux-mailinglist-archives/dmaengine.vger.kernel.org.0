Return-Path: <dmaengine+bounces-11430-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZwAgG5YzKmrtjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11430-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:03:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7666E1C4
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:03:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mmNphZOj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11430-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11430-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C61301E7D7
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED8212548;
	Thu, 11 Jun 2026 04:03:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5440D573
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 04:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150610; cv=none; b=Dd21l11dvs9gZUESGNTWVbbeZHuAEqg3UcqF8UkspEKZcSdBnR0fnId7PYeLR6jM/zCCDiyhSZ9hPoG+pv8BbdK5WnmI4pBa5ScZ0oVD6ZbiTfeplcXmlts5/0NbCrgcBbIhK/hWET9RMjJPTly8FnJITtxZPFk/qEBqiq8FlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150610; c=relaxed/simple;
	bh=LKNOr2cORPV3T20xex3Sdi7swcGMJZrOzGi/LoWxDS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsMQ+EI/pS+64I7ek+iHncKQWREdToId3vFf/nbJWYAg02wNteLAykC2JLfAkkdMY9W7TtyRbQl2/QSIK13Zxpgyi9xBJ9WYYz5UBp65DT5k9wuGoNFOSjC3efcLnyEl8x8lcCvfOptXO3H0lmzqsXz0tr9BNmrChtpxwwVWeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmNphZOj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A931F00893;
	Thu, 11 Jun 2026 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781150609;
	bh=v0GrWbNKTJrktvR52NdKBBD05j7RneQGXsOLpWTKc/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmNphZOj1oyJTUEZ7xbIM2FEG0AkXKICdxfIRKZMlc4dbLRJxedWxGlYtQFJhCic7
	 stQ7OrxOs6MO0UhWXJEMjJw7OttQvnipP4eVAPf0MBlkQmpqA13k7DQJbskxCQT+05
	 Bph8PQPmYsC6U3gcr47n/6YCuXZZoK2hu7Df6WqTGtW7YnKKnq6xyTpI5B/gPdYxYL
	 4DyNM3bdjz/wHaQ4TsS9hcBmJ8eDa6hD6WOxWIix3AgYokxgq5ocOXx1TIFM7aYXag
	 Ps5M0nR/aVTQ6ymxuM7dmbiTMY/OfHYuDp1kGVcuLf6u883XRIyFRuTca9OeLU9pkE
	 XHNnEWkQpT1/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 07/15] dmaengine: fsldma: fix request_irqs unwind
 freeing unregistered IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611035245.13439-8-rosenp@gmail.com>
References: <20260611035245.13439-8-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:03:28 +0000
Message-Id: <20260611040328.D1A931F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11430-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: D4A7666E1C4

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error cleanup path in `fsl_dma_prep_memcpy` causes a Use-After=
-Free read when using `fsldma_free_desc_list_reverse` to free a list whose =
head is embedded in one of the freed elements.
- [High] Missing `tasklet_kill()` during channel teardown leads to Use-Afte=
r-Free if a tasklet is pending or running.
--

commit d650ce798a908cef623fc8f4999005d166fe7691
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ

When fsldma_request_irqs() fails on a per-channel IRQ, the unwind
loop starts at the current index i, which calls free_irq() on the
IRQ that request_irq() just failed to register. Decrement i before
the loop to skip the failed channel.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..285c5e284d425 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1085,7 +1085,7 @@ static int fsldma_request_irqs(struct fsldma_device=
 *fdev)
>  	return 0;
> =20
>  out_unwind:
> -	for (/* none */; i >=3D 0; i--) {
> +	for (i--; i >=3D 0; i--) {
>  		chan =3D fdev->chan[i];
>  		if (!chan)
>  			continue;

[Severity: High]
This is a pre-existing issue, but while reviewing the error handling I noti=
ced
a potential use-after-free in drivers/dma/fsldma.c.

In fsl_dma_prep_memcpy(), if a descriptor allocation fails, the error path
cleans up by calling fsldma_free_desc_list_reverse() and passing the list
head embedded in the `first` descriptor:

	fsldma_free_desc_list_reverse(chan, &first->tx_list);

In fsldma_free_desc_list_reverse(), the traversal is done using:

	list_for_each_entry_safe_reverse(desc, _desc, list, node)
		fsl_dma_free_descriptor(chan, desc);

Since the list head `&first->tx_list` is embedded within the memory that wi=
ll
be freed, does the list traversal macro's increment step cause a read from
freed memory when it evaluates the previous node?

[Severity: High]
This isn't a bug introduced by this patch, but I found a potential missing
cleanup in the channel teardown path in drivers/dma/fsldma.c.

In fsldma_chan_irq(), a tasklet is scheduled:

	tasklet_schedule(&chan->tasklet);

During driver unbind or error handling, fsl_dma_chan_remove() frees the DMA
channel:

	kfree(chan);

Does fsl_dma_chan_remove() need to call tasklet_kill(&chan->tasklet) before
freeing the channel memory? Even though fsldma_free_irqs() unregisters the
interrupt, if the tasklet is scheduled right before the IRQ is freed, could
the tasklet run after `chan` has been freed and cause a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611035245.1343=
9-8-rosenp@gmail.com?part=3D1

