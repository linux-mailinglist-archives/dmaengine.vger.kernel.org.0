Return-Path: <dmaengine+bounces-11673-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HPu6LtfKNmrWEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11673-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC946A957B
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fiKs+LqB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11673-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11673-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C518B3003336
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618E2853F3;
	Sat, 20 Jun 2026 17:16:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D624E4C3
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975765; cv=none; b=bzEPN1/0DlEF7C+W15NNo64yNH8vEZPEGq0uVZnKamcGuJn4TKeJPaagayy73sBiztIVGE+GjGA5lZSzNH6n4eRKxFW+P19Kl2RM+vBonTaL2lNjkkRCpBYEiVtF/7Q5iwyf+aixguTVKrpJ4TWkHmyKSUMVfoiKUBXnm0XdcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975765; c=relaxed/simple;
	bh=5ThALS6BQ+2qRsyrmpR3WREjkH+jmRUGymEDg5QBx7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/TNRbAvId3pWbQVa5UffojFWe005rKFzgcaMPtKNTqNhsYGtImOkBEsK3doz450UFrIU8ppufNgmM1faYYQz0gZR8B02pHKf0g+Efk8e87xZiD2zatRHMbAYgJcQtr4aCDaoihGvoFI0GdoO59CYD32twjbHdqiKAgzKeWcHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiKs+LqB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6211F000E9;
	Sat, 20 Jun 2026 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975764;
	bh=rplyo1ZYY/KCH89C4laPHNYYSr8nG7OXzE/BrHMv420=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiKs+LqBhjJqy6mBrtuCPivPZWF4wS+CTaIsR307vhFA7pHV3LI9NJ7npjuaR+RI8
	 fLguPbWciiG2mpw7lVrxjGIyTQdavTirUvzomacesgekgWF8/fYWuid/i+lvM4K5Cc
	 PuN74sB8Ol8W9K9yW9uV9rFqN3Ic/QSfI7H8oniLBu0Qk4syj9olHNkc6Spw5u7cFd
	 jPywA2A7qqJ5fAUFJpdGDJs14hPWWP5nlkmSRTikZAYijFE8He+htbDKixtfAIzoOQ
	 z0yp8Nygo85Xz5AMJT6JBNgq7wGbNZNzFJ15ydiu3SZx6Fdl4dygYoiWwWqx+60XMY
	 bZTZ8jeID/Z0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] dmaengine: dw-edma: Add partial channel
 ownership mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260620170040.3756043-6-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:16:03 +0000
Message-Id: <20260620171603.DA6211F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11673-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AC946A957B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] In partial ownership mode, `dw_edma_probe()` skips the global core=
 reset but fails to quiesce the DMA channels it owns, exposing the driver t=
o fatal race conditions if the hardware is active from a prior state.

Pre-existing issues:
- [High] Teardown order in `dw_edma_remove()` disables hardware and frees I=
RQs before unregistering the DMA device.
--

commit b3810423aa75ab232c8bec54552ca8cb72acd420
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add partial channel ownership mode

This commit adds a partial ownership flag to allow a dw-edma instance to
represent a subset of a controller shared with another OS instance. It skips
the initial core reset during probe and uses a limited quiesce path during
remove, while enforcing ownership granularity for shared registers.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c782eaa12021e..d87791205837b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1128,8 +1156,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
> =20
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}

[Severity: High]
If the instance is in partial ownership mode, could the hardware be
active from a prior state (e.g. kexec or an endpoint driver)?

By skipping the global core reset without calling dw_edma_core_quiesce()
in its place, the hardware remains active. The driver requests IRQs via
dw_edma_irq_request() just below this, before calling
dw_edma_channel_setup().

If a pending interrupt fires during this window, the handler will invoke
dw_edma_done_interrupt(), which locks and dereferences uninitialized
vchan structures:

dw_edma_interrupt_write()
  dw_edma_done_interrupt()
    spin_lock_irqsave(&chan->vc.lock, flags)
    vchan_next_desc()

Since vchan_init() has not been called yet during dw_edma_channel_setup(),
does this sequence lead to a kernel panic or NULL pointer dereference?

> =20
>  	/* Request IRQs */
>  	err =3D dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
[ ... ]
> @@ -1173,8 +1203,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
> =20
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		dw_edma_core_quiesce(dw);
> +	else
> +		dw_edma_core_off(dw);
> =20
>  	/* Free irqs */
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  	dw_edma_emul_irq_free(dw);
> =20
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);

[Severity: High]
This is a pre-existing issue, but does the teardown order in
dw_edma_remove() expose the driver to a race condition?

The hardware is disabled or quiesced and the IRQs are freed before
dma_async_device_unregister() is called. By leaving the dmaengine device
registered during this teardown, clients can still issue new transfers via
vchan_issue_pending().

This would invoke dw_edma_v0_core_start(), writing to registers of a
disabled DMA engine, potentially racing with dw_edma_core_quiesce().
Additionally, transfers submitted after free_irq() will hang indefinitely
since completion interrupts are no longer available.

Should dma_async_device_unregister() be called before tearing down the
underlying hardware and interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D5

