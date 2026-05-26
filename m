Return-Path: <dmaengine+bounces-10926-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPLFvJrFWoEVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10926-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:46:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E25D3A22
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED2B330479A1
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C483B7770;
	Tue, 26 May 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODXXB/WS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639E3D891A
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788593; cv=none; b=XLUOvar6FfkrjUMyVncjZtSj8sd7ir+uOzDyoo6YkMsRXWdxsPt3mHfVnXWGQwrH1paD0ejpPU+WRo6rGf8jwp722BJmPfGDHo7e/sBxO7inQXDA+Nu5KyY3RcTXtl5vE6eFbyyk5aXLxFGe28FiWnz2glHMdu+UrHEMgZ6LD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788593; c=relaxed/simple;
	bh=lcnZ9VwEVwrmZl1T/9mmG9sMM7x3CzlxnavXuABSDZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9pNO1FjaRPgkpWZ2DB7YvVT+cO5NvDbcK7XNLkN0TJP/pVnkFa2Lio8oMovxzoYANo2i++IxeZv1bKgQnBDxrEWTE8jFRpMjxIpNq3PBAKSv1HLGsS+7vCC7yb/6J1wuVpo/xSuGIsh3dmdqYvdaqetnr7khuF1cO2xGlU9OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODXXB/WS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123341F00A3A;
	Tue, 26 May 2026 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788591;
	bh=+Gyl/kAJ+j+NAEFsixxAivETb308NNotM3OaCrAC0eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODXXB/WSjPLzvyiDbFebteg9Q/2lklfp9KrbhiQBkJ3anGB5TdCW+LbaOlNVjo9al
	 lu8f+mSHVnTbpNzDlN+cTjH/vxlEAHMRYX81yM4MIEhZnRzO6YrdVcshdM62KQflYN
	 NH/FECf1TXJmYIoZLTQzD9qVRpXR8fGb1Izqfqb8scZTQ8vtvfV38h8snhU+0Amhdl
	 Zz54BGap3fMJXJogIIM769s6Ly+tmKI3crfryNapODMxzNpFxlO33E3owwNq1yH14n
	 iAc7vwKUMcSaU44yXSVik4fIwB9jWbo4wBolIu9xUyNy1y7c/kB6aIxk7b1hD2QH4o
	 zqEsGY2vzfd1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/18] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526084710.3491480-16-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-16-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:43:10 +0000
Message-Id: <20260526094311.123341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,renesas.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10926-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: C20E25D3A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The error recovery path in `rz_dmac_suspend()` fails to restor=
e essential hardware registers before re-enabling cyclic channels.
- [High] Error paths in system suspend and resume callbacks fail to properl=
y manage the runtime PM usage counter, causing an imbalance that leads to u=
nderflows.
- [High] The IRQ handler accesses hardware registers without verifying the =
device power state, risking a crash if an interrupt fires during or after s=
ystem suspend.
- [Medium] The `rz_dmac_suspend()` function incorrectly mixes scope-based `=
guard()` locking with `goto`-based error handling.
--

commit 2944b998cf54bad86273dc3ee963623d49e8fffa
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Add suspend to RAM support

This patch adds suspend to RAM support for the Renesas RZ/G3S SoC DMA IP to
save and restore DMA IP registers. It adds specific handling for cyclic
channels by pausing and resuming them during system suspend/resume.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index bd4ca8e939f17..2a7124e4aea3a 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
[ ... ]
> @@ -1421,6 +1474,122 @@ static void rz_dmac_remove(struct platform_device=
 *pdev)
[ ... ]
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
> +{
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		rz_dmac_device_resume_internal(channel);

[Severity: Critical]
Does this error recovery path fail to restore essential hardware registers
before re-enabling cyclic channels?

If pm_runtime_put_sync() fails in rz_dmac_suspend(), the driver jumps to
reset_deassert, calls reset_control_deassert(), and then executes this
function. However, the prior reset_control_assert() wiped the hardware stat=
e.

This function simply calls rz_dmac_device_resume_internal(), which writes
CHCTRL_SETEN to start the channel. Since essential configuration registers
like NXLA, CHCFG, and DCTRL are never restored, the hardware could attempt =
to
execute DMA transfers with zeroed configurations, potentially causing wild
memory accesses or silent data corruption.

> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev)
> +{
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);

[Severity: Medium]
Does this function mix guard() based locking with goto based error handling?

According to the subsystem cleanup guidelines, a single function must never
mix goto statements with __free() or guard() declarations. This function us=
es
guard(spinlock_irqsave)(&channel->vc.lock) inside the loop, while
goto suspend_recover and goto reset_deassert are used for error handling
outside the loop.

> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		ret =3D rz_dmac_device_pause_internal(channel);
> +		if (ret) {
> +			dev_err(dev, "Failed to suspend channel %s\n",
> +				dma_chan_name(&channel->vc.chan));
> +			break;
> +		}
> +
> +		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);
> +	}
> +
> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret =3D reset_control_assert(dmac->rstc);

[Severity: High]
Does this logic risk a regression if an interrupt fires during or after sys=
tem
suspend?

This driver implements system suspend using SIMPLE_DEV_PM_OPS, so this
function runs during the normal suspend phase where device interrupts are
still enabled. This function asserts the hardware reset and powers down the
DMA controller.=20

If a delayed interrupt fires concurrently on another CPU,
rz_dmac_irq_handle_channel() will execute and directly read the CHSTAT
register. Since the driver neither disables the IRQ, calls synchronize_irq(=
),
nor verifies the power state via pm_runtime_get_if_active(), the handler wi=
ll
read from powered-off or reset hardware.

> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret =3D pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		goto reset_deassert;

[Severity: High]
Does this error path fail to properly manage the runtime PM usage counter?

pm_runtime_put_sync() unconditionally decrements the usage counter. If it
fails, the function jumps to reset_deassert and aborts system suspend witho=
ut
restoring the usage counter via pm_runtime_get_noresume().=20

Because the system suspend is aborted, the resume callback will be skipped,
leaving the usage counter permanently decremented. Subsequent suspends could
underflow the counter and break runtime PM functionality.

> +
> +	return 0;
> +
> +reset_deassert:
> +	reset_control_deassert(dmac->rstc);
> +suspend_recover:
> +	rz_dmac_suspend_recover(dmac);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D15

