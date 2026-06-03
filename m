Return-Path: <dmaengine+bounces-11151-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M2bGKduBIGrr4QAAu9opvQ
	(envelope-from <dmaengine+bounces-11151-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:34:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F314363AE41
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n74QuKJr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11151-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11151-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2002E30760BF
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7E48B398;
	Wed,  3 Jun 2026 19:29:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639F3822AA
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 19:29:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514983; cv=none; b=SNqdvZIS14zihaVqnLXCUZvvaDqZ+IGkVK3BZ3I3knkY40fMt/bjkQ0CRM++ZfI9vFb2m4a8f85O8dMEdwPv624USFJ8cVc1KmEhtJC1jQgbRp6qrG9rP6QUimm1p9dvco2C9R+joCEpXFNmelRtW7wtT+DncjkA4AfdOFQzT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514983; c=relaxed/simple;
	bh=iNekmZUMIU/ROWXkk2Y0mV10c8YkGhJtC7/X0uQZGiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c8LeBb10407rn6lqwLIpCYHHRbpEEB18dsBRbF0h5i2qO0/jfXaP6EaOAh2u4VkTF416HZ2K+p9g5m2heSlChbDsTw0POQ4IW79zeh3WlSnBDRAUamx0HANcQC2aNwqLF3AgCfg1hoqvQckWaKlH3TXoZT82H4u5AhC6eIs3GZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n74QuKJr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA541F00893;
	Wed,  3 Jun 2026 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514982;
	bh=8En37R5dETLNZVzgK9M1JWp2jO3u9UjvzLRZajHP+fE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n74QuKJrp2PHLCNC3Bz/0aKrDXIv7wjRee38TBSBPG5lajgH6JY+JOG/WCA2/nhqT
	 OeFTGFwUYofBerTMvWl8zbRDeM5B+CtCN2ZLKTxy1JKT7BAaCyr9QG/F9vlKtTRZ3d
	 r2RwYB+odvtT41aCsnubRcg6HGzAdpSJKfdAF8SR2JS4d05tFV7qEbx76836ATpuQF
	 B3YRLuB93AkykCa3lKn/ka8MnT2/loCaNKRXsEHT5rD5tFJu6S3rO0i59e6dUn0jnc
	 g3/5RdgT1ehazfZV4N29OXN4YLvQ4WEWE4WrCc+FKb9FyBtIpWWHaomD6+P977GifW
	 M5vA/TRFZ3zTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma: fsldma: convert to platform_get_irq_optional()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260603191951.5729-1-rosenp@gmail.com>
References: <20260603191951.5729-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 19:29:41 +0000
Message-Id: <20260603192941.AEA541F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11151-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F314363AE41

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing tasklet_kill() in channel removal causes use-after-free of=
 channel structure.
- [High] Ignored return value of dma_async_device_register() causes silent =
probe failure and later kernel panic.
--

commit a1cff40cb09109b8d2ad16457c9eff5f0adadc62
Author: Rosen Penev <rosenp@gmail.com>

dma: fsldma: convert to platform_get_irq_optional()

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional =E2=80=94 when
absent (-ENXIO) the driver falls back to per-channel IRQs.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..a98a7798fd180 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c

[ ... ]

> @@ -1300,7 +1309,6 @@ static int fsldma_of_probe(struct platform_device *=
op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does fsl_dma_chan_remove()
safely handle scheduled tasklets?

During driver removal, the driver calls fsldma_free_irqs() which executes
free_irq(). While free_irq() waits for currently executing interrupt
handlers to finish, it does not stop or wait for scheduled tasklets.

Immediately after, fsl_dma_chan_remove() frees the channel structure:

drivers/dma/fsldma.c:fsl_dma_chan_remove() {
	irq_dispose_mapping(chan->irq);
	list_del(&chan->common.device_node);
	iounmap(chan->regs);
	kfree(chan);
}

If an interrupt scheduled the tasklet just before free_irq() was called,
the tasklet could execute asynchronously on freed memory, leading to a
use-after-free when dma_do_tasklet() dereferences the chan pointer.

Should there be a call to tasklet_kill(&chan->tasklet) before freeing
the channel?

[Severity: High]
This is also a pre-existing issue, but is it safe to ignore the return
value of dma_async_device_register() during the probe?

Looking at fsldma_of_probe(), the driver unconditionally returns 0
after attempting registration:

drivers/dma/fsldma.c:fsldma_of_probe() {
	...
	err =3D fsldma_request_irqs(fdev);
	if (err) {
		dev_err(fdev->dev, "unable to request IRQs\n");
		goto out_free_fdev;
	}

	dma_async_device_register(&fdev->common);
	return 0;
}

If dma_async_device_register() fails, the global_node list head remains
zero-initialized, but the driver still successfully binds.

Later during device teardown, fsldma_of_remove() blindly unregisters:

drivers/dma/fsldma.c:fsldma_of_remove() {
	...
	dma_async_device_unregister(&fdev->common);
	...
}

Would this cause dma_async_device_unregister() to call list_del_rcu() on
a NULL pointer, resulting in a kernel panic?

> -	irq_dispose_mapping(fdev->irq);
>  	iounmap(fdev->regs);
>  out_free:
>  	kfree(fdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603191951.5729=
-1-rosenp@gmail.com?part=3D1

