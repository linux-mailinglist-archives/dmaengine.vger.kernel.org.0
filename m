Return-Path: <dmaengine+bounces-11827-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cYkVLb/XP2oKZAkAu9opvQ
	(envelope-from <dmaengine+bounces-11827-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 16:01:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A266D20F3
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 16:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mB8FI/Ie";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11827-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11827-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70B033008FEF
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4C25CC57;
	Sat, 27 Jun 2026 14:01:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C02472AF
	for <dmaengine@vger.kernel.org>; Sat, 27 Jun 2026 14:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568888; cv=none; b=kFbf6zqM/vqo0Rj0VUrze36ZPRWcrwAm0+nm87ry9LHFjM9+azbMau6naGXtBQkGkx0fqtVMsz53Ob5P8SkkXmiT2r8VfwcqORgdjrhbC59csuWy21saChcLmx+5uM2B0u85HrmGiyoxeXWJugGQaagQ6oBHlPvV5wu/Bhn2Nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568888; c=relaxed/simple;
	bh=d/xj5jUHm+6tQ7c8jB/uOXD7RYy0faz7KixOqq51Jm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jLoLKjTB9e1IzNEGqSlFe0BftNZrMSjm7yL9qOCp6dxwle79fx75DO3tH3B4YhBYn83l3Ed9hXBiF1US3UjHNjBWB1al6wfFQDcnv/03MgXl+B0yubApU827ovjiG+J3Mjlw3XokpR5MlfSkQCgg68c4B38jm06+opdV3/omc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB8FI/Ie; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3881F000E9;
	Sat, 27 Jun 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782568887;
	bh=HH1km1OXXSjTh7oXBBhuqb6IQhCGD8oCrRmisHENviE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mB8FI/IeyO3dsv1ncv9hDya6E1HKQhGbafqVXgIOkidvst4Ai+GRliooA2frMdX/6
	 kuSqaSJgJ20Pe6shx47PD7B3VX530Rf+AZOGotJhxROFCoM/I8Le3aNKURPfShR7FR
	 SIC7yLw4iY6wsJtLv+gBFJ8ILAyCLhVblPmsn+vUunQtrRP770A95yCzR9qaqN2ILE
	 R57IWe1PqRK2WKIJfiPwxEJqGD0doJ+FPYmbXoEfGuEhzgJ+RSqSSP5GUSF2S0z6QP
	 puVgO8WWuHoxpVdU0JEpi1RnM83UQuhm2xjKdbW6MZu0Kse2ArFG6oezMTX6OpT4dW
	 YMIPlzmYa0r/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: mediatek: hsdma: fix runtime PM leak on
 init failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260627134915.8749-1-mhun512@gmail.com>
References: <20260627134915.8749-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 14:01:26 +0000
Message-Id: <20260627140126.AD3881F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11827-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86A266D20F3

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Tasklets are killed before disabling hardware interrupts, crea=
ting a race condition that leads to use-after-free.
- [High] The DMA controller is registered and exposed to the system before =
its hardware is initialized, creating a window for unclocked hardware acces=
s.
- [High] Hardware is deactivated before the DMA device is unregistered, all=
owing active clients to access unclocked hardware.
- [High] Acquiring a spinlock without disabling IRQs in process context ris=
ks a deadlock with the hardware interrupt handler.
- [High] The driver disables the hardware clock without waiting for the DMA=
 controller to become idle, potentially causing bus hangs.
- [Medium] Manual removal of channels from the core device list in `remove(=
)` prevents the DMA engine core from unregistering them, causing sysfs and =
memory leaks.
--

commit 88d1e6220aea175827fde9c64724395b19cd385b
Author: Myeonghun Pak <mhun512@gmail.com>

dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
   =20
mtk_hsdma_hw_init() enables runtime PM and gets a runtime PM reference
before enabling the HSDMA clock. It currently ignores failures from
pm_runtime_get_sync(); if runtime resume fails, the usage count remains
held. If clk_prepare_enable() then fails, the usage count remains held.
   =20
Use devm_pm_runtime_enable() to manage runtime PM enablement, and use
pm_runtime_resume_and_get() so resume failures do not leak the usage count.
If clk_prepare_enable() fails after a successful runtime resume, drop the
runtime PM reference before returning.
   =20
The probe path also ignores the return value from mtk_hsdma_hw_init(), so a
failed hardware init can continue as a successful probe. Propagate
mtk_hsdma_hw_init() failures from probe, while keeping a separate unwind
label so mtk_hsdma_hw_deinit() is only called after hardware init succeeds.

> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-=
hsdma.c
> index a43412ff5eddc..27cb370106c77 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
[ ... ]
> @@ -868,7 +878,6 @@ static int mtk_hsdma_hw_deinit(struct mtk_hsdma_devic=
e *hsdma)
>  	mtk_dma_write(hsdma, MTK_HSDMA_GLO, 0);
> =20
>  	clk_disable_unprepare(hsdma->clk);

[Severity: High]
This is a pre-existing issue, but does disabling the hardware clock without
waiting for the DMA controller to become idle risk bus hangs?

In mtk_hsdma_hw_deinit(), the driver clears the MTK_HSDMA_GLO register and
immediately calls clk_disable_unprepare(). If the DMA engine is actively
flushing data to the bus, abruptly disabling the clock can freeze the system
or cause imprecise external aborts.

Should it poll MTK_HSDMA_GLO_BUSY using mtk_hsdma_busy_wait() prior to
disabling the clock?

> =20
>  	pm_runtime_put_sync(hsdma2dev(hsdma));
[ ... ]
> @@ -983,7 +992,9 @@ static int mtk_hsdma_probe(struct platform_device *pd=
ev)
>  		goto err_unregister;
>  	}
> =20
> -	mtk_hsdma_hw_init(hsdma);
> +	err =3D mtk_hsdma_hw_init(hsdma);

[Severity: High]
This isn't a bug introduced by this patch, but does registering the DMA
controller before its hardware is initialized create a window for unclocked
hardware access?

In mtk_hsdma_probe(), dma_async_device_register() is called before
mtk_hsdma_hw_init() enables the hardware clocks and PM:

    err =3D dma_async_device_register(dd);
    if (err)
        return err;

    err =3D of_dma_controller_register(pdev->dev.of_node,
                                     of_dma_xlate_by_chan_id, hsdma);
    if (err) {
        ...
        goto err_unregister;
    }

    err =3D mtk_hsdma_hw_init(hsdma);

This makes channels available to clients before initialization completes. I=
f a
client requests a channel immediately (e.g., via deferred probe) and trigge=
rs
mtk_hsdma_alloc_chan_resources() before mtk_hsdma_hw_init() completes, it
will access unclocked hardware registers, potentially causing a system crash
via imprecise external abort.

> +	if (err)
> +		goto err_free;
> =20
>  	err =3D devm_request_irq(&pdev->dev, hsdma->irq,
[ ... ]
> @@ -1000,8 +1011,9 @@ static int mtk_hsdma_probe(struct platform_device *=
pdev)
> =20
>  	return 0;
> =20
> -err_free:
> +err_deinit:
>  	mtk_hsdma_hw_deinit(hsdma);
> +err_free:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err_unregister:
>  	dma_async_device_unregister(dd);

[Severity: High]
This is a pre-existing issue, but does deactivating the hardware before
unregistering the DMA device allow active clients to access unclocked
hardware?

In both the probe error path and mtk_hsdma_remove(), mtk_hsdma_hw_deinit()
cuts the clock and drops PM before dma_async_device_unregister() runs.

If a client holds a channel when the DMA provider unbinds, calling
dma_release_channel() will trigger mtk_hsdma_free_chan_resources(), which
accesses unclocked registers because the hardware was prematurely deactivat=
ed.
This can cause a system crash via imprecise external abort.

[Severity: Critical]
This is a pre-existing issue, but are tasklets killed before disabling
hardware interrupts in mtk_hsdma_remove()?

Looking at mtk_hsdma_remove(), tasklet_kill() runs while MTK_HSDMA_INT_ENAB=
LE
is still active:

    tasklet_kill(&vc->vc.task);
    ...
    /* Disable DMA interrupt */
    mtk_dma_write(hsdma, MTK_HSDMA_INT_ENABLE, 0);

    /* Waits for any pending IRQ handlers to complete */
    synchronize_irq(hsdma->irq);

If an interrupt fires immediately after tasklet_kill(), mtk_hsdma_irq()
handles it and calls vchan_cookie_complete(), which reschedules the tasklet.
After remove() returns, the devres-managed memory for the channel is freed,
but the tasklet remains queued and will execute on freed memory, causing a
kernel panic.

[Severity: Medium]
This is a pre-existing issue, but does manual removal of channels from the
core device list in mtk_hsdma_remove() prevent the DMA engine core from
unregistering them?

In mtk_hsdma_remove():

    list_del(&vc->vc.chan.device_node);

This empties the core's channel list. When dma_async_device_unregister()
subsequently iterates over device->channels, the list is empty, bypassing
__dma_async_device_channel_unregister() completely, which causes sysfs and
memory leaks.

[Severity: High]
This is a pre-existing issue, but does acquiring a spinlock without disabli=
ng
IRQs in process context risk a deadlock with the hardware interrupt handler?

In mtk_hsdma_free_active_desc():

    spin_lock(&hvc->vc.lock);
    if (!list_empty(&hvc->desc_hw_processing)) {
        hvc->issue_synchronize =3D true;
        sync_needed =3D true;
    }
    spin_unlock(&hvc->vc.lock);

This is called from process context (via dmaengine_terminate_all()) and
acquires hvc->vc.lock using plain spin_lock(). The hardware interrupt handl=
er
mtk_hsdma_irq() also acquires this lock. If the interrupt fires while the l=
ock
is held in process context, it will spin forever causing a hard deadlock.
Should this use spin_lock_irqsave() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627134915.8749=
-1-mhun512@gmail.com?part=3D1

