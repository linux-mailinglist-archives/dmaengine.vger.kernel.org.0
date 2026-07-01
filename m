Return-Path: <dmaengine+bounces-11922-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HbFfE5PgRGoB2goAu9opvQ
	(envelope-from <dmaengine+bounces-11922-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:40:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E946EBAC2
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:40:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XysRCfLd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11922-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11922-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB383046D46
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C83F54AA;
	Wed,  1 Jul 2026 09:39:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F33F482D;
	Wed,  1 Jul 2026 09:39:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898755; cv=none; b=jt2KKgAcnkRXtn9wkorxY29FyNv4sgZihEnFNQUIRBuRcUbr74ZogmYKoYvrG/r3KywGyrtD7msrvPe/aeE6c3K6rZBOZ2AR4JoITfPXldq/esxvyPmG0OfjpeLL48Rw9xve/tiUn959YAcA4Q4EgVUFexM22SbhkRlcIqhzBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898755; c=relaxed/simple;
	bh=W93f+t4Vn80OMpbdusuluMLHRIUrPWy0Dc8BLra/56E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJOc+cnIfbrVbpTGDOhX6hR/+cRVPZwCn7azIQQz+oi6cpmfAIAYr+2746K8e+dZLM65jKQuYJExMO6+uIz0Qcx5hgzbyl5pqjzFXf0cQ1qyv2Qv+dr21QPApOTtV9iUn2vOg7B6GJc1Z6ul9VDTkwAiT8xpmgIzfwH2ezx14Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XysRCfLd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F11B1F000E9;
	Wed,  1 Jul 2026 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898754;
	bh=+rCsQDn3Tc5CmoegcHXhp+OXlMYSIqvUFitheqB8XbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XysRCfLdLQ/mlFFB0HhC9ufDYGgRmY78p7rFhNT6xWQ+1yifleIOwEyajVGvyl7ma
	 Tf9MmKyM3Q17GmgdM0tD628lo1shedAIlBHdb4DSrVHCJQv9/Cuwb12AisbhX3RMVQ
	 RcxXZL2whkvIsXAOV+OCR7VAi+py7bxUbs6BRKU/8oli13rZ4Kl84W/Fo/Hsj7eT5H
	 8crW/3FqWtg3TS1VPLIIVndyT7AugWDjrqemR63M0U4NAsug6UtabewGmY1A4htyPM
	 +4ZQBOnXZZ6Q9WUXkFCY/UUN3VdGmxDid7CVokhobDhgfV6gj5NrVWYmnhpPO2FnHn
	 CDnlFzzF5syFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] dmaengine: fsl-edma: convert DMAMUX clock
 handling to bulk clock API
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-3-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-3-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:39:13 +0000
Message-Id: <20260701093914.0F11B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11922-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,nxp.com:email,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91E946EBAC2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Changing from `devm_clk_get_enabled` to `devm_clk_bulk_get_optiona=
l` silently ignores missing DMAMUX clocks, which were previously mandatory =
and can lead to synchronous bus errors.
--

commit 7885b2482d67d70ba7ccdebb1cd210d1f8dc8ba2
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: convert DMAMUX clock handling to bulk clock API

Convert the DMAMUX clock management from individual clock operations to the
bulk clock API to simplify the code. Prepare to add edma engine runtime pm
support.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
[ ... ]
> @@ -751,23 +750,37 @@ static int fsl_edma_probe(struct platform_device *p=
dev)
[ ... ]
> -		fsl_edma->muxclk[i] =3D devm_clk_get_enabled(&pdev->dev, clkname);
> -		if (IS_ERR(fsl_edma->muxclk[i]))
> -			return dev_err_probe(&pdev->dev,
> -					     PTR_ERR(fsl_edma->muxclk[i]),
> -					     "Missing DMAMUX block clock.\n");
> +		ret =3D devm_clk_bulk_get_optional(&pdev->dev, fsl_edma->drvdata->dmam=
uxs,
> +						 fsl_edma->muxclk);

[Severity: High]
Does this change to an optional clock fetch risk a synchronous bus error?

Previously, devm_clk_get_enabled() was used, which would fail probe if the
clock was missing. By switching to devm_clk_bulk_get_optional(), a missing
DMAMUX clock in the device tree will be silently ignored.

If the clocks are missing, devm_clk_bulk_get_optional() returns 0 and sets
the clock pointers to NULL. The subsequent clk_bulk_prepare_enable() call
will succeed safely. However, the driver will later unconditionally access =
the
unclocked DMAMUX registers:

drivers/dma/fsl-edma-common.c:fsl_edma_chan_mux() {
    ...
    if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_CONFIG32)
        mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
    else
        mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
    ...
}

Could this lead to a kernel panic when accessing the unclocked registers?
Should this use devm_clk_bulk_get() instead so probe correctly fails for
missing mandatory clocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-edma-ru=
ntime-opt-v6-0-354ff4229c00@oss.nxp.com?part=3D3

