Return-Path: <dmaengine+bounces-11209-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZhvDwdKI2rNnwEAu9opvQ
	(envelope-from <dmaengine+bounces-11209-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:13:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC464B93B
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ayrtXKvr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11209-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11209-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5910330179F3
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324A3B71DB;
	Fri,  5 Jun 2026 22:13:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2036F918
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697604; cv=none; b=A01K7UyZkwG6t2MSW0/cxlFSRlimcPxXJ5r6i4qGLbQlRO5jOw0dzaDAzoMS+n3ExOuZGtftf2MB02ieTK1Tu00sUdzTz8jkX9lr0FR7r7fruWayy1vo9T6+6Gq3UusL3X1xkohsGUAuMws1Hn3VSS7b3pWg2nffJvqLQquR4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697604; c=relaxed/simple;
	bh=Zi+xFmw2B8b0ZXz0pY3cUswjhl1K+LAraJKBrNqXhY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sj82HwDiD8pe7cJ5vDG8PbeRkQMcTq1GXF4GqOKrgjbwUjFVhapCylN6XsZemH0iD45KFaZ9vh4yHd0/h9Ziz3mGklIljmNQLLdyY+kRPhmUQHA+iMjBMsjN+BugQZuQNzlgwzDuobL+MFsPmZ10oaojMyrsaUGDhIeOKwcxCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayrtXKvr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAB41F00898;
	Fri,  5 Jun 2026 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697603;
	bh=BVlz12vF1RDV9prL+4BxZb1kG5qoNlE9ATv2txCEX7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayrtXKvrR05HXjhMSvWZyqRmJNuXn2Ho1P/iKSGCaLw8LQqWEjBfDndMsxLfCF9pN
	 haEsoVRk3ZAqSwW5H6ukDHVbFCvozVHa5ONIQvCAwsIOIY0GIK56pP9kFPPFGbVVca
	 DRDwsVzzQzfIXVcYDNALCMZE4V7g6uzmoIcqyhz30fxFHvh75al/MbHBHM63cHze1n
	 tZV6v427lM1w5NgWo5pV+6Ggn88+P7jPQwh7oFrAWzBFH2q0FFpBLdT9MD5n1XNS2R
	 8lRn1bZCKZG3rnsAs/wrYtuFpUZ9+f7jLO1a2p1o+I5+p88qH3s7KkhRy2PNC8t3ti
	 N4XVOKjxL2Lhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] dmaengine: fsldma: convert channel ioremap to
 devm_of_iomap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605220134.43295-8-rosenp@gmail.com>
References: <20260605220134.43295-8-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:13:22 +0000
Message-Id: <20260605221323.3AAB41F00898@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11209-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FEC464B93B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `irq_dispose_mapping()` for per-channel IRQs causes a mapp=
ing leak when a channel is removed.
- [High] Failure to propagate `-EPROBE_DEFER` and other negative error code=
s from `of_irq_get()`.
--

commit 6845fba6088aa0e893f716aacd6cf99383012ca1
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: convert channel ioremap to devm_of_iomap

Replace of_iomap with devm_of_iomap for per-channel register
mappings. This eliminates the iounmap calls in both the probe
error path and fsl_dma_chan_remove, and simplifies the error
handling by returning directly on failure.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index ee6e595c2972c..0d73ce3dbfe6a 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c

[ ... ]

> @@ -1192,17 +1189,12 @@ static int fsl_dma_chan_probe(struct fsldma_devic=
e *fdev,
>  		 chan->irq ? chan->irq : fdev->irq);
> =20
>  	return 0;

[Severity: High]
Is there a failure to propagate -EPROBE_DEFER and other negative error codes
from of_irq_get() here?

The commit 'dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get'
switched to of_irq_get() specifically to handle negative error codes such as
-EPROBE_DEFER.

However, the error handling logic in fsldma_request_irqs() maps all values =
<=3D
0 to -ENODEV:

drivers/dma/fsldma.c:fsldma_request_irqs() {
	...
		if (chan->irq <=3D 0) {
			chan_err(chan, "interrupts property missing in device tree\n");
			return -ENODEV;
		}
	...
}

This forces negative error codes like -EPROBE_DEFER to become -ENODEV,
defeating the purpose of the migration by permanently aborting the probe
instead of deferring it.

> -
> -out_iounmap_regs:
> -	iounmap(chan->regs);
> -	return err;
>  }
> =20
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
>  	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
> -	iounmap(chan->regs);

[Severity: High]
Are we leaking the IRQ mapping when removing the channel?

In an earlier patch in the series ('dmaengine: fsldma: convert to
platform_get_irq_optional()'), the call to irq_dispose_mapping(chan->irq) w=
as
removed from fsl_dma_chan_remove().

However, chan->irq is acquired using of_irq_get() (or previously
irq_of_parse_and_map()), which internally calls irq_create_of_mapping() and
allocates a mapping in the IRQ domain.

This mapping must be explicitly disposed of. Because the cleanup call was
removed and never re-introduced, the IRQ mapping is permanently leaked
whenever a DMA channel is removed or the driver unbinds.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D7

