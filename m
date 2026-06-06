Return-Path: <dmaengine+bounces-11247-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DFOJEVRnI2qqswEAu9opvQ
	(envelope-from <dmaengine+bounces-11247-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:18:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAA64BFBF
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:18:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hdpamIkY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11247-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11247-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D7A303C3CE
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8013D503;
	Sat,  6 Jun 2026 00:14:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6A12FF69;
	Sat,  6 Jun 2026 00:14:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704849; cv=none; b=GnAqJ+l6/SlLDI7Q+ByC8BvJStH6qsLW32LCy4OShZCMcXBTQKez144wuygKvRhJGNL0UUFdZtKFvTp0joZgd/wXpxXOV3kHdhK+/F22aGRtv++PAoaAG7MfiHVBYwJ7BHD9WMbG0weQAS5r7YZe99X0wqFgYDDadjUgrLetyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704849; c=relaxed/simple;
	bh=f5Md8LwCKhyXXTuXwhAnQ/Kcq/C5eITs9P4bZaRhu3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=twbsFxjJp4ps0Z0eowuderD5aW3UePMZoxJN6EPb3bCSa6IEZk7PPjdYoE6TV8JtvevPiKtO5a8U0kyzwfxuDz/piK0GMuotBhoue8xzf5ItPkarKUSgmtb5CEFv7Rz7qwrVDel4EgPqW8saghUMrjvqbEzsQjp9d1t4t6uuxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdpamIkY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C3C1F00893;
	Sat,  6 Jun 2026 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704847;
	bh=AbDGVPbpIVCExegbI/TbWTMyiiXdzh7ah4mCgaQrYpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdpamIkYC3eC4oR3wwkgTwVUD5Pi9e4q4TeIKAcbimJubgH8gjZ7D1ppnFNVeyyZc
	 KCN/y4C68mHq2EyLhA6TVBHSzR8jc7SNmNSduErF1mMaGF0DJOeM+lz4aZ5Jl+wcHb
	 dHdcujb5VgHMrclc+/2pJaknkArPFWrLVPZvBH93/gdu58c1fT71qj1qMgjDX/wK6O
	 QVJ01xoz8s4EDfyg06K7ztEHRNrbdMrk+JdT2yvnETsmrU94YFihjnLuSZMycGZzUf
	 tdp+MvwK+B2+QnCjDPfjIdJKQzaHZZK4tZnDs8vU78xi8UnqkIFT5xdjpexSut33uY
	 s/KoH5dFFz8IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-4-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-4-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:14:07 +0000
Message-Id: <20260606001407.85C3C1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,amd.com:email,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-11247-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2AAA64BFBF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing explicit case for `SDXI_GSV_STOP` in `sdxi_dev_stop()`, ca=
using an unintended hardware reset and a race condition during initializati=
on.
- [Medium] Failure to escalate soft stop to hard stop on timeout breaks kex=
ec recovery.
--

commit 17aa147e1376754aa9259ca4aa25570606278ae6
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Feature discovery and initial configuration

This commit discovers device capabilities, introduces register definitions,
and performs initial configuration. It also attempts to force the SDXI
function to a stopped state during initialization to recover from kexec or
prior driver bugs.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 0974a83bb45ca..7c6652f9c3c04 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
[ ... ]
> +/* Get the device to the GSV_STOP state. */
> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
> +{
> +	enum sdxi_fn_gsv status =3D sdxi_dev_gsv(sdxi);
> +	int ret;
> +
> +	dev_dbg(sdxi->dev, "attempting stop, current state: %s\n",
> +		gsv_str(status));
> +
> +	switch (status) {
> +	case SDXI_GSV_INIT:
> +	case SDXI_GSV_ACTIVE:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
> +		break;
> +	case SDXI_GSV_STOPG_SF:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
> +		break;
> +	case SDXI_GSV_STOPG_HD:
> +	case SDXI_GSV_ERROR:
> +		/*
> +		 * If hard-stopping, there's nothing to do but wait.
> +		 * If in error state, the reset is issued below.
> +		 */
> +		break;
> +	default:
> +		/* Unrecognized state; try a reset. */
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +		break;
> +	}

[Severity: High]
Does this switch statement need an explicit case for SDXI_GSV_STOP?

If the device is already in the stopped state (which is the expected
post-reset state), the switch appears to fall through to the default block
and unnecessarily issues a hardware reset.

Immediately after the reset command is written, sdxi_dev_gsv_poll() reads
the status register. Since hardware resets take time to execute, the very
first read will likely still sample the old SDXI_GSV_STOP state. This
could cause the poll loop to exit immediately with success while the reset
is still actively running in the background.

Since the caller proceeds to configure critical control registers right
after this returns, could this lead to lost writes or corrupted state while
the hardware is resetting?

> +
> +	/* Wait for transition to either stop or error state. */
> +	ret =3D sdxi_dev_gsv_poll(sdxi, status,
> +				status =3D=3D SDXI_GSV_STOP ||
> +				status =3D=3D SDXI_GSV_ERROR);
> +
> +	if (ret =3D=3D 0 && status =3D=3D SDXI_GSV_ERROR) {
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +		ret =3D sdxi_dev_gsv_poll(sdxi, status, status =3D=3D SDXI_GSV_STOP);
> +	}
> +
> +	if (ret) {
> +		dev_err(sdxi->dev, "stop timed out, current state: %s\n",
> +			gsv_str(status));
> +		return ret;
> +	}

[Severity: Medium]
If a soft stop times out, should this escalate to a hard stop or reset
instead of returning an error?

The commit message mentions forcing the device to a stopped state to
recover from kexec or driver bugs. However, if the device is in
SDXI_GSV_ACTIVE and the soft stop (SDXI_GSRV_STOP_SF) times out (perhaps
due to pending PCIe transactions hanging after a crash), this simply returns
-ETIMEDOUT.

Since probe is not automatically retried, does this leave the hardware
stuck in SDXI_GSV_STOPG_SF and break the intended kexec recovery?

> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D4

