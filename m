Return-Path: <dmaengine+bounces-11617-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rL5TL6CdM2ozEQYAu9opvQ
	(envelope-from <dmaengine+bounces-11617-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:26:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44469E10F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:26:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gnXEuFfb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11617-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11617-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB01300B60F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F673C73E1;
	Thu, 18 Jun 2026 07:26:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BA3C5826;
	Thu, 18 Jun 2026 07:26:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767577; cv=none; b=leq0iiVrjkacdy6ghPqBnMHxM7nj4FnAgwaWwYHQ0B04RirZeNaHjV4yvTDtIs04mmATqVwbYyFit8c+3XhBXVPvTVRFRe4OD0QxSj0QfuPS+Bx1YfxJ17wFvJUgSqMNBiPDe+HDydI67ULxknOLjk4ouJ40GcV+IIv5rLY5o8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767577; c=relaxed/simple;
	bh=H/JLuSmB+H0EWOQQoDRYCrFv1tVBWOsaRQOh77qHVTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aObXCp1/hoMl9h4y6ARoS0/xi88OEeclNGfxvncXEBqUkBH5KF0v2mFdUtEM7lDgCkTExIvjaWwCh2oQ2LZeLftKY4zfhk+/J8zIsq7BXOh6xLBCS7UNTo1mmX+DNbshHJcPZweWXmO3U8hq8Zoh9bfyB+nRT/+fIrBXzP3c530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnXEuFfb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3401F000E9;
	Thu, 18 Jun 2026 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781767575;
	bh=lKfakM9o3ofUGN9mWR7hUHTUaV6oPgZU68pHQaYNWlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnXEuFfb1u30FMwbiTFkQXGAOh/uWAu6LsRAolskBwENkM/esqq00ZZpW77bF/9v2
	 gLs/2aYC37heJxcmFJcmVftKwEI6KSpFHOdhktc/V47MTeRppJBoYh/pUFwU+A9f3i
	 wTv4KjDdVmjpbAXiPui59c5zDJa7vNoDPEgHSbqlW+s+yS9ovqmurP/lVJWueTvefq
	 Tkom5/Kq/berRXhNxvLYXXnK6cSdIDJ1RaC9RbgWM9yWPK3Ld/OAQn9xxrt6dytpyC
	 GgXl9ELlTkNQMyJSoJsmdPgDp0eQuif0/5uAkZqM7NAI9j5ydBoPtGR1Viy7ntHug9
	 62k9haDvfqwBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/3] dmaengine: zynqmp_dma: Guard IRQ handler against
 spurious interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Golla Nagendra" <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260618071056.2024286-4-nagendra.golla@amd.com>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-4-nagendra.golla@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:26:14 +0000
Message-Id: <20260618072615.5D3401F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11617-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:email,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E44469E10F

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The interrupt handler drops valid interrupts when CONFIG_PM is dis=
abled.

Pre-existing issues:
- [High] Memory and runtime PM reference leaks on error paths in zynqmp_dma=
_alloc_chan_resources().
- [High] Missing synchronize_irq() before tasklet_kill() allows the tasklet=
 to run after channel resources and PM references are freed.
--

commit 62db01b8d81ad56c8fb04b0d8f2adecdae634703
Author: Golla Nagendra <nagendra.golla@amd.com>

dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts

This commit adds a pm_runtime_get_if_active() check in the
zynqmp_dma_irq_handler() to safely handle spurious interrupts. It
returns IRQ_NONE immediately if the device is not runtime-active,
preventing potential synchronous external aborts.

> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> index a9dfec3c0ca3d..ce9163138be74 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -730,6 +730,9 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, vo=
id *data)
>  	u32 isr, imr, status;
>  	irqreturn_t ret =3D IRQ_NONE;
> =20
> +	if (pm_runtime_get_if_active(chan->dev) <=3D 0)
> +		return IRQ_NONE;

[Severity: High]
When CONFIG_PM is disabled, the pm_runtime_get_if_active() inline stub
automatically returns -EINVAL. Does this check unconditionally drop valid
interrupts in non-PM configurations?

Because -EINVAL is less than or equal to 0, the handler might always return
IRQ_NONE. This could potentially lead to an unacknowledged interrupt storm
or the kernel permanently disabling the IRQ line.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but do the error paths in
zynqmp_dma_alloc_chan_resources() leak the runtime PM reference?

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_alloc_chan_resources() {
    ...
    chan->sw_desc_pool =3D kzalloc_objs(*desc, ZYNQMP_DMA_NUM_DESCS);
    if (!chan->sw_desc_pool)
        return -ENOMEM;
    ...
    if (!chan->desc_pool_v)
        return -ENOMEM;
    ...
}

If pm_runtime_resume_and_get() is called earlier, returning directly
on memory allocation failures without calling pm_runtime_put() will
leak the PM reference and previously allocated memory.


[Severity: High]
This is a pre-existing issue, but does zynqmp_dma_synchronize() miss
a required IRQ serialization step?

drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_synchronize() {
        struct zynqmp_dma_chan *chan =3D to_chan(dchan);

        tasklet_kill(&chan->tasklet);
}

If zynqmp_dma_irq_handler() is executing concurrently and gets preempted
just before calling tasklet_schedule(), tasklet_kill() might see no
scheduled tasklet and return immediately.=20

When the IRQ handler resumes and schedules the tasklet, could it execute
asynchronously after channel resources and PM references are freed,
potentially causing a synchronous external abort?=20

Would calling synchronize_irq() first resolve this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618071056.2024=
286-1-nagendra.golla@amd.com?part=3D3

