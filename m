Return-Path: <dmaengine+bounces-11781-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GTq4IirzPGqDuwgAu9opvQ
	(envelope-from <dmaengine+bounces-11781-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:21:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8311F6C42B7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:21:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uu7FtSog;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11781-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11781-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F27E83013C54
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B717384CFB;
	Thu, 25 Jun 2026 09:21:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E42FD665;
	Thu, 25 Jun 2026 09:21:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379279; cv=none; b=KhkOo7CQgcmR9AJTcfakvZdmVGuu+dcm8Sj0GcfFxDWkWwLcfYBwTwWC/L3TyAwIVm2GIjB+zlanjBt9v3/YCVeYmCby8lVsK4WF7wA4BtIvb0OHajF+vfU1Q+aYMCtW1NM7cmXMw1fzY5VhfD7dDGIfqnT6ET19vEcZrnKfvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379279; c=relaxed/simple;
	bh=lwhv5b/WmqtM+0FRnJJk7OcV1ke5fouT28ItryejZc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CCoHtpluB/o72FstGxBiJB9SNn9L8e/AZiXr0PExFRlNPuwKODzhD069O9RSLLEcZjOA9kpkEjas+2sgc76wxlZSgGBRsy7argNwueWIGkVjHQkMIOsttSqajmwc3BO5+HFR4njFCMbgBtHNfnpobAqY7sFF/AqjSy1cqF1yHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu7FtSog; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C001F000E9;
	Thu, 25 Jun 2026 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379277;
	bh=V5iJDybVYPLoX8tIWuO1oSOYbYzxjByZEtoOXZZEB1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uu7FtSogfsh1/TsUEzgdwoSQBWNkFG5vJ3tixdsCR/67YmVD6Furdy+HvBTV9Cqyk
	 GJlUnSYCrsZlncPObmImIZp8s0EsTONe9s5xF5V6+0nON6ZpJlIajv6OepeOyq0xlh
	 pgdw5asM/17CGDBA+9Vy5mIHhQxClHje624+g/KFHSZqp5xBF+ds7ePYLOWkrAb65c
	 A/jLEl0eilyDqlZ8CO7CelKMyLh5FDACfx6y7iIA71ZRnxMsuDyXG9YyK5l/pU+UG4
	 4ceDvBgAXAHv4oA8t2sxNTtZjPgCxBLTOSyafyJ9jWJfyQ2BMAjlfw6OgDJHq2zWV+
	 ubxocSsyjvlhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] dmaengine: mcf-edma: Use devm for per-channel
 IRQ registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jean-Michel Hautbois" <jeanmichel.hautbois@yoseli.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260625-b4-edma-dmaengine-v3-5-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-5-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:21:16 +0000
Message-Id: <20260625092116.C8C001F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11781-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,yoseli.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8311F6C42B7

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Replacing explicit `free_irq()` with `devm_request_irq()` introduc=
es a Use-After-Free race condition by deferring IRQ unregistration until af=
ter the virtual channels are torn down.

Pre-existing issues:
- [High] dma_async_device_unregister() fails to clean up channels because f=
sl_edma_cleanup_vchan() improperly empties the channel list beforehand, lea=
ding to a resource leak.
--

commit 3174cb73d4f28e4270bffd2960b8600186152672
Author: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

dmaengine: mcf-edma: Use devm for per-channel IRQ registration

This patch converts the eDMA transfer interrupt registration to use the
managed devm_request_irq() API with per-channel names. It also adds logic
in the remove path to manually quiesce the hardware since the interrupts
are now freed later by devres.

> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c

[ ... ]

> @@ -249,8 +234,21 @@ static int mcf_edma_probe(struct platform_device *pd=
ev)
>  static void mcf_edma_remove(struct platform_device *pdev)
>  {
>  	struct fsl_edma_engine *mcf_edma =3D platform_get_drvdata(pdev);
> +	struct edma_regs *regs =3D &mcf_edma->regs;
> +	int i;
> +
> +	/*
> +	 * The per-channel interrupts are requested with devm and are only
> +	 * freed after this function returns.  Quiesce the controller first so
> +	 * that no interrupt can fire while the virtual channels are torn down:
> +	 * disable every channel's request and acknowledge any pending
> +	 * interrupt.
> +	 */
> +	for (i =3D 0; i < mcf_edma->n_chans; i++)
> +		fsl_edma_disable_request(&mcf_edma->chans[i]);
> +	iowrite32(~0, regs->inth);
> +	iowrite32(~0, regs->intl);
> =20
> -	mcf_edma_irq_free(pdev, mcf_edma);
>  	fsl_edma_cleanup_vchan(&mcf_edma->dma_dev);

[Severity: High]
Does deferring the IRQ unregistration until after the virtual channels are
torn down introduce a use-after-free race?

Since devm_request_irq() defers freeing the IRQ until after mcf_edma_remove=
()
returns, the driver loses the synchronization barrier that previously waited
for in-flight handlers. The manual hardware quiescence loop does not
synchronize with already executing handlers.

If an interrupt handler executes on another CPU, could it complete the tran=
sfer
and call vchan_cookie_complete(), which executes tasklet_schedule()?

If this happens after fsl_edma_cleanup_vchan() kills the tasklet:

fsl_edma_cleanup_vchan()
        tasklet_kill(&chan->vchan.task);

the tasklet could be placed back on the runqueue. After remove() completes,
devres frees the IRQ and device memory, meaning the scheduled tasklet would
execute on freed memory.

>  	dma_async_device_unregister(&mcf_edma->dma_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does the order of operations
here leave dma_async_device_unregister() operating on an empty list?

Looking at fsl_edma_cleanup_vchan(), it iterates over dmadev->channels and
removes every channel from the list:

fsl_edma_cleanup_vchan() {
        list_for_each_entry_safe(...) {
                list_del(&chan->vchan.chan.device_node);
                ...
        }
}

Immediately after, dma_async_device_unregister() is called, which relies on
iterating over the exact same device->channels list to unregister the
channels.

Because the list was just emptied, the iteration does zero passes, skipping
the core channel unregistration and permanently leaking sysfs entries and
per-cpu memory.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-b4-edma-dm=
aengine-v3-0-44be00ace37d@yoseli.org?part=3D5

