Return-Path: <dmaengine+bounces-11138-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R7EAI8qdH2rVnwAAu9opvQ
	(envelope-from <dmaengine+bounces-11138-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:21:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8B633D7C
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:21:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DisjDu90;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11138-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11138-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 831F8302F18E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00A23ED12C;
	Wed,  3 Jun 2026 03:21:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10023F0ABE
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:21:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456902; cv=none; b=ARcSKjzh1icpZTlpMmM0UUro7BU+cz1cLFhVZppjQdQdRT7IqO3jM0MITblAAseR2EgSIC7lkL/8jiNGWtddFykWJYzYN5cJ8K0q28L8X6E/JU2gRTABSxGo14AzyQdHawOWA18WhJwT4SYC3aU8Hfy2nYl4coSH5GY/YWPcRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456902; c=relaxed/simple;
	bh=msEblLpyLiM8Fmuhdu8jIbsmKOH4khqo2uqpD7eUu8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ToWpf5kU6w4DhAC3ZxeuRWXclVP6wG0yUitKH0BJM4kV4WOYuCJNva326t1M+1KWIvIRIr10EJSPke7Gs5jo0Ttu4LlPIWS8p+p1YbVNx1LEZPDwupyGk4GY/+BItAu5fA2c9rPCXyf2cWcqgZE+li0ZeQuJGV4wO4ZLgEeDKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DisjDu90; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E3C1F00893;
	Wed,  3 Jun 2026 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780456898;
	bh=Id7Nct797daXCVQnmaenXDuw7gGj0ngPAnyoQf9lgzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DisjDu90voALWx75ytXOctmI9ALipdaReFGM6nK20UXrDJluIbShHPt3Gb0d14Mds
	 g8vjIT3WJ4bRONbiZjNwa4nyK1h9JzRVi+bRl5Hk5DXG7z25o2lWyDyYSLuqWCNbc8
	 piFSBxp9m8x6VoEzYICfqSLDYQsCa72QsgpvZ8KynFfHFGgizYdrLvliojYbmhOp7u
	 1rCV+gJsGggXUItKhCyJm3me8xALRPgpeNrLsdDbKxp6+xlSIeF68o0gNdPifXrDJX
	 eDsbZB8fJwVjyupmBxtK0vg/rus0urvsP6MHOkUxh6JzsAtn5mOJqqeksdTnxI+8NB
	 c/IOkvcfpcbzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 5/8] dmaengine: ti: omap-dma: disable IRQs on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260603030754.288757-6-rosenp@gmail.com>
References: <20260603030754.288757-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 03:21:38 +0000
Message-Id: <20260603032138.A4E3C1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11138-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27C8B633D7C

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `return rc;` in the `of_dma_controller_register` error pat=
h causes probe to fall through and register a CPU PM notifier using memory =
that will subsequently be freed.
- [High] Missing `cpu_pm_unregister_notifier` on module removal for configu=
rations with `needs_busy_check`, leading to a dangling PM notifier.
- [High] Wrong interrupt enable register (`IRQENABLE_L0`) is cleared during=
 `omap_dma_remove`, risking an unhandled IRQ storm.
- [High] Division by zero in SG transfer preparation if `maxburst` is confi=
gured to 0.
--

commit 2fb0d3495f0f7caa9bb739f8dcae6f87cb0dcd07
Author: Rosen Penev <rosenp@gmail.com>
Subject: dmaengine: ti: omap-dma: disable IRQs on probe failure

The probe failure paths after IRQ setup free channel state while hardware
interrupts can still be enabled. A concurrent interrupt can then walk
lch_map[] and access channel memory that teardown is releasing. Disable
IRQENABLE_L1 and clear irq_enable_mask under irq_lock before teardown,
then read IRQENABLE_L1 back to flush the posted write.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..a5dc07bcbeb87 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c

[ ... ]

> @@ -1825,6 +1832,13 @@ static int omap_dma_probe(struct platform_device *=
pdev)
>  		if (rc) {
>  			pr_warn("OMAP-DMA: failed to register DMA controller\n");
>  			dma_async_device_unregister(&od->ddev);
> +			if (!omap_dma_legacy(od)) {
> +				spin_lock_irq(&od->irq_lock);
> +				od->irq_enable_mask =3D 0;
> +				omap_dma_glbl_write(od, IRQENABLE_L1, 0);
> +				spin_unlock_irq(&od->irq_lock);
> +				omap_dma_glbl_read(od, IRQENABLE_L1);
> +			}
>  			if (od->ll123_supported)
>  				dma_pool_destroy(od->desc_pool);
>  			omap_dma_free(od);
>  		}

[Severity: High]
This is a pre-existing issue, but shouldn't this error path in
omap_dma_probe() return the error code?

If of_dma_controller_register() fails, the code frees the resources and
cleans up, but execution falls through instead of returning. It then procee=
ds
to register a CPU PM notifier on the newly freed memory:

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
    ...
	if (od->cfg->needs_busy_check) {
		od->nb.notifier_call =3D omap_dma_busy_notifier;
		cpu_pm_register_notifier(&od->nb);
    ...
}

When devres releases the od structure, od->nb will become a dangling
pointer, which could cause a use-after-free on the next CPU power transitio=
n.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does omap_dma_remove()
correctly unregister the CPU PM notifier in all configurations?

In omap_dma_probe(), the notifier is conditionally registered like this:

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
    ...
	if (od->cfg->needs_busy_check) {
		od->nb.notifier_call =3D omap_dma_busy_notifier;
		cpu_pm_register_notifier(&od->nb);
	} else if (od->cfg->may_lose_context) {
		od->nb.notifier_call =3D omap_dma_context_notifier;
		cpu_pm_register_notifier(&od->nb);
	}
    ...
}

But in omap_dma_remove(), it only unregisters if may_lose_context is true:

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
    ...
	if (od->cfg->may_lose_context)
		cpu_pm_unregister_notifier(&od->nb);
    ...
}

If needs_busy_check is true and may_lose_context is false, the notifier is
never unregistered, leaving a dangling pointer when the module is removed.

[ ... ]

[Severity: High]
This is a pre-existing issue, but does omap_dma_remove() disable the correct
interrupt enable register?

During omap_dma_remove(), the code attempts to disable interrupts:

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
    ...
	if (!omap_dma_legacy(od)) {
		/* Disable all interrupts */
		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
	}
    ...
}

The driver configures interrupts on IRQENABLE_L1 during probe and channel
allocation. By clearing IRQENABLE_L0 instead, active channels remain enable=
d in
IRQENABLE_L1. After the IRQ handler is unregistered, any pending hardware
interrupt could cause an unhandled IRQ storm.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could a client passing 0 for
maxburst cause a division by zero in omap_dma_prep_slave_sg()?

In omap_dma_prep_slave_sg(), the burst variable is initialized directly from
the client's configuration:

drivers/dma/ti/omap-dma.c:omap_dma_prep_slave_sg() {
    ...
	if (dir =3D=3D DMA_DEV_TO_MEM) {
        ...
		burst =3D c->cfg.src_maxburst;
    ...
	en =3D burst;
	frame_bytes =3D es_bytes[es] * en;
    ...
}

Later in the scatterlist loop, frame_bytes is used in a division:

drivers/dma/ti/omap-dma.c:omap_dma_prep_slave_sg() {
    ...
	for_each_sg(sgl, sgent, sglen, i) {
		struct omap_sg *osg =3D &d->sg[i];
        ...
		osg->fn =3D sg_dma_len(sgent) / frame_bytes;
    ...
}

If a client passes 0 for maxburst, frame_bytes will be 0, leading to an
unhandled division by zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603030754.2887=
57-6-rosenp@gmail.com?part=3D1

