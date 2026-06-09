Return-Path: <dmaengine+bounces-11374-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3dqdEZCUKGoAGgMAu9opvQ
	(envelope-from <dmaengine+bounces-11374-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:32:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38065664984
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:32:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="eehznUL/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11374-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11374-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2DFC3010809
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C6403B14;
	Tue,  9 Jun 2026 22:28:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734A41167C
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:28:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044129; cv=none; b=F6T49weR2AxqQUhr67yuVws53/BZ3hcHjZDjSudNMaH6Mq/65x3RUiCH/OztFiOwfU2EnOuOZsFdDNmyQjtrtHWFgN39m0ZvQU+c0nDtvuRMSs2/zGtTKjppcJNmvM2hyIoPImHeGu1t29I516g9C8godqpspm69xXJedjkfgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044129; c=relaxed/simple;
	bh=DYnL6EG1lGhwXl+DfTqV2ae+Fpv7/Vpwp0n8FMyUp7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4L6EBgdnDsLr3QKN7F3j/r2OgZkEDM0zKEe+J3h6TNonGdyds/MXag/nqxG2zuDfckKTRKqlWV7PWALLTXhCqzKl8Z3aWBge2VGySzbDG+qTE5FBtqSsMeAAm59mrJx33LeW8tfBPWUbIoJ8jQmDVnwODD8Ciam+VapCiIRXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eehznUL/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA9B1F00898;
	Tue,  9 Jun 2026 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044127;
	bh=n/mBjyKIZ5tBtQ5ZxX1Fb1V0zDDT24bIB8IkMCEJ1E0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eehznUL/DdZzQFQ8est6NE6SXsuGwpjYnjKZcg39q+60ZD9Gbxgs/6BqCzQaLW4FL
	 OzrpuF0GiGCIztSwPTxzR27XcXefhXxGX2cHdsk5ZJWZ3nH+B26tVknHStIgoyzKSX
	 aZVSpBPva21CIwdakOFlub69zNS9Fls+U8YiR2Svm1Lsol4reNZhvKw0EfGcMlPFiF
	 vW8i0vGg5VeFhj88PJFH2Y4Xxm0uyvaufKbpwyTwrjPIsgdPV3B3p/1Tce1V1IqaAH
	 E52Nwzu01TDcljND9jMYqZIdg49wzLuBWToqvYPKKBWa1mPYgfcJkAECQSqXzpJnHe
	 plZfWU7fMPYaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 07/15] dmaengine: fsldma: fix request_irqs unwind
 freeing unregistered IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260609221926.35538-8-rosenp@gmail.com>
References: <20260609221926.35538-8-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:28:47 +0000
Message-Id: <20260609222847.ADA9B1F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11374-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38065664984

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to kill the tasklet before freeing the channel structure l=
eads to a potential Use-After-Free.
--

commit 5aba4f3ed6853fa11aefa9651d0a60e344f6e486
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ

This commit fixes the unwind loop in fsldma_request_irqs() to skip the
failed channel by decrementing the index before the loop. This prevents
freeing an unregistered IRQ when request_irq() fails.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1085,7 +1085,7 @@ static int fsldma_request_irqs(struct fsldma_device=
 *fdev)
>  	return 0;
> =20
>  out_unwind:
> -	for (/* none */; i >=3D 0; i--) {
> +	for (i--; i >=3D 0; i--) {

[Severity: High]
This is a pre-existing issue, but does the cleanup process fail to kill
the tasklet before freeing the channel?

If fsldma_request_irqs() fails and triggers this unwind, the error path
eventually leads to fsldma_of_probe() calling fsl_dma_chan_remove() for
the previously initialized channels.

fsl_dma_chan_remove() unmaps registers and frees the channel memory via
kfree(chan), but it omits tasklet_kill(&chan->tasklet):

drivers/dma/fsldma.c:fsl_dma_chan_remove() {
...
	irq_dispose_mapping(chan->irq);
	list_del(&chan->common.device_node);
	iounmap(chan->regs);
	kfree(chan);
}

Since interrupts are shared via IRQF_SHARED, the interrupt handler could
schedule the tasklet at any point after request_irq() is called. If the
tasklet is scheduled just before free_irq() executes during this unwind
path, could it remain pending and run after kfree(chan), resulting in a
use-after-free?

>  		chan =3D fdev->chan[i];
>  		if (!chan)
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-8-rosenp@gmail.com?part=3D1

