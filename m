Return-Path: <dmaengine+bounces-11208-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jDvbIfJJI2q4nwEAu9opvQ
	(envelope-from <dmaengine+bounces-11208-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:13:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601E64B92F
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ljfJ5mo7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11208-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11208-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 659E430407EA
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963E1FE47B;
	Fri,  5 Jun 2026 22:11:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3137BE74
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697467; cv=none; b=VLZXDtXIGIQLhVIRrI35rQwseL9qH5dbg5vJ2hrhLzxztzw00jB5hTGR/eOzkm9VH4YSI5BJsLlvmdLFjTIDnZK2tUAeVBFk5PDv8C0i67jjktTsCFVD4ut9xSL5nLo2QjDao1JoiK0VJvTmpG6NJyeJijxj4oarCCoNcZigb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697467; c=relaxed/simple;
	bh=ck7xBLtubO04cipOVITXxF8wCgYqd4n0S6Ive/seBwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ax63Nlry5fyRpEF0Thn5Q/cl4bYiPwsELTQHDmCOnIKPyC96VzQMFv9/alnv127HigOAhSRDF6JR+9AYE5/K7oHgz68hjHnqh4J5rFZh8dPN6Rm6dYLVB2dAWQF3z/IAjI4rzjSjdLBbgvTDclZy7Rn8PhKF100loV1UWrCuB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljfJ5mo7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2031F00893;
	Fri,  5 Jun 2026 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697466;
	bh=MaRZKFBgFdvszyrgdG0n9odK39jx2xT6BvezVK4PXwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljfJ5mo7gFO1zW5Gy0Lmgea5zchYuvW+BhNDTlsHhMTEHCrAsYr/4W7nGDsmCKikl
	 YbuS0l9eIB6OhoLkM3in3N5uOEpYsbJrQ7cx+NE9/iuwPkbKfChOl+VjaOsbMf6XX3
	 MDwJwQIE9Fyls3nPoE9gKiCXjihP75x3ST2TduE6ckQUjnDdZCUlTKytRw2XL0tus3
	 +HbsHBI78GUWSjpsoRubAvDlgjayOYsmHVRufFYICjxD7zzLeZTZCmqotvDmKhsV/w
	 ieshv7vYWYRMky16Nm6WNPWrVeTcL0IAH9uueWFyWRrcE7PyCjSz2RWTJZSlvgkRyA
	 TzDczVoDXYA5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] dmaengine: fsldma: convert to devm_request_irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605220134.43295-10-rosenp@gmail.com>
References: <20260605220134.43295-10-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:11:05 +0000
Message-Id: <20260605221105.DD2031F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11208-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1601E64B92F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `request_irq()` with `devm_request_irq()` without adjust=
ing the teardown sequence introduces a fatal use-after-free race condition =
involving channel tasklets.
--

commit 7b8afa7a0cf79eb3a5fc201866996718ea5d9be8
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: convert to devm_request_irq

This commit converts the driver to use devm_request_irq() for managing
interrupt lifetimes. It removes explicit calls to free_irq() and the
fsldma_free_irqs() function.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 79a268139b9f8..01c9cd27e7951 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c

[ ... ]

> @@ -1304,8 +1268,6 @@ static void fsldma_of_remove(struct platform_device=
 *op)
>  	fdev =3D platform_get_drvdata(op);
>  	dma_async_device_unregister(&fdev->common);
> =20
> -	fsldma_free_irqs(fdev);
> -
[Severity: High]
With the explicit fsldma_free_irqs() call removed, does this leave the IRQ
active while the channels are being removed?

If fsl_dma_chan_remove() is called while the IRQ is still active, it invokes
tasklet_kill(&chan->tasklet). However, if an interrupt fires during or after
this point, the IRQ handler fsldma_chan_irq() can unconditionally call
tasklet_schedule(&chan->tasklet).

Later, devres unwinds allocations by first freeing the IRQ and then
freeing the channel memory. If the locally scheduled tasklet executes
after the channel memory is freed, could this regression result in a
use-after-free and softirq list corruption?

This could also happen in the out_free_fdev error path in
fsldma_of_probe(), which calls fsl_dma_chan_remove() to kill tasklets
while successfully requested devm IRQs are still active.

>  	for (i =3D 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D9

