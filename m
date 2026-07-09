Return-Path: <dmaengine+bounces-12208-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r8wJNWqvT2r6mgIAu9opvQ
	(envelope-from <dmaengine+bounces-12208-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869A732343
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EZ78hXhJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12208-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12208-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF6A730A09EE
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739433120C;
	Thu,  9 Jul 2026 14:08:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815B3815D6
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606129; cv=none; b=F+tJcTh/3E1loIOn0KRKQ3GmKQlU4B+hXgo5AcdUAsmUHwllimofdPuQSpgoZqCS6q8TIYxckb5pW2v7XZSPk/58sNuxdW28EGyP8UfoJG06Prbq1WWclYz7QV3LYvi+b0gYK4vYb4vfEP+0IMsVd7Uoz4WNP1RoCSyRYbDIZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606129; c=relaxed/simple;
	bh=wfwAVcF+qgSlh+T3TaWYQCyxbmY1H/T5Y1tEAMAKTm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VrM6A+LvBbHQrqkem68lQTT6wKAbVTqvq37BjNw4gr1oK+N2kltd7VXMuDx+8ub7yo4P2t6LwRv7unQ0Sed20c0upZG9NxoOwg6rRaBlOPYvCXxiHjNTTbcrpAg7742Vu7PZA8qx/2EPafUNpHbHWa57qksG6kgcuzvQWEv2H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ78hXhJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA4B1F000E9;
	Thu,  9 Jul 2026 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606128;
	bh=wKQj5t9hJKMsEyWI4FcEsjKcNAjJqbzKzrsaG5ZkYOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZ78hXhJOCJ06VbTIfJ6bVj4Av0cR6jAp1Hp7vLgnlrKVzVcyPtPSuf8FE7rffnWt
	 ostwtknkmGlkBa1xz19o4ndai/J/XSB46Bms4azJa4u2T6MjImI72/t8XuuAGO/yhS
	 eo4hmbnoL7gg/rXUEwoDmeSsQjCQdIX4G6mPS2AWZqtCAjuQysqR3ZeXm/uKwm8U5q
	 wUP3tTzlRzNhwAd4So9RlBDZEugw4Ak1/0RUEBWpzSzlD8g/RiSkCw0FkUCFbPHOQB
	 FfyLxxF0QbMAgIx7Q6MdocALBuMGkVPvXeM9uAKKB7gb86nNXTAhRDOgDVacL8JOG8
	 xnU/GekeX/SLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/26] dmaengine: mmp_pdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709135846.97972-7-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-7-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:08:47 +0000
Message-Id: <20260709140847.DBA4B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12208-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,vivo.com:email,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4869A732343

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference in IRQ handlers (`mmp_pdma_chan=
_handler` / `mmp_pdma_int_handler`) when handling spurious or shared interr=
upts before initialization is complete or when the PHY is inactive.
- [High] Missing `tasklet_kill()` on device removal and probe error paths c=
auses a use-after-free if the tasklet runs after `devres` frees the channel=
 memory.
- [Medium] Negative IRQ error codes like `-EPROBE_DEFER` are incorrectly pa=
ssed to `devm_request_irq()` and masked as `-EINVAL`.
--

--- Patch [6]: [PATCH 06/26] dmaengine: mmp_pdma: Remove redundant dev_err(=
)/dev_err_probe() ---
commit f205944d00824c4ac830efbda0d25e06f33f54a9
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: mmp_pdma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() function automatically logs detailed error messages =
on
failure. This commit eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 386e85cd4882a..c2a638d554883 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -1161,10 +1161,8 @@ static int mmp_pdma_chan_init(struct mmp_pdma_devi=
ce *pdev, int idx, int irq)
>  	if (irq) {

[Severity: Medium]
This is a pre-existing issue, but could irq be a negative error code here?

If platform_get_irq() returns -EPROBE_DEFER, it evaluates as true in this
condition. It would then be passed directly to devm_request_irq() below,
which implicitly casts it to an unsigned int and fails with -EINVAL, perman=
ently
failing the probe instead of deferring it.

>  		ret =3D devm_request_irq(pdev->dev, irq, mmp_pdma_chan_handler,
>  				       IRQF_SHARED, "pdma", phy);

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of a NULL
pointer dereference with these shared IRQs?

In mmp_pdma_probe(), a shared interrupt is requested before the loop that
initializes phy->base in mmp_pdma_chan_init(). If a shared interrupt trigge=
rs
immediately, mmp_pdma_int_handler() calls mmp_pdma_chan_handler() and then
clear_chan_irq(), which dereferences phy->base:

drivers/dma/mmp_pdma.c:clear_chan_irq() {
    ...
    u32 dint =3D readl(phy->base + DINT);
    ...
}

Additionally, if a spurious interrupt fires while phy->vchan is NULL,
clear_chan_irq() can still return 0. This causes mmp_pdma_chan_handler() to
unconditionally execute tasklet_schedule(&phy->vchan->tasklet), which
dereferences NULL.

> -		if (ret) {
> -			dev_err(pdev->dev, "channel request irq fail!\n");
> +		if (ret)
>  			return ret;
> -		}
>  	}
> =20
>  	spin_lock_init(&chan->desc_lock);

[Severity: High]
This is a pre-existing issue, but does this driver leave tasklets running
after the channel memory is freed?

A few lines below here in mmp_pdma_chan_init(), a tasklet is set up via
tasklet_setup(). However, mmp_pdma_remove() does not appear to call
tasklet_kill().=20

Since free_irq() synchronizes with running interrupt handlers but not with
scheduled tasklets, if a tasklet was scheduled right before the IRQ was fre=
ed,
it could execute after devres has freed the chan memory, causing a
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D6

