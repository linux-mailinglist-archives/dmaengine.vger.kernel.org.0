Return-Path: <dmaengine+bounces-10465-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD2FAIZbBWomVQIAu9opvQ
	(envelope-from <dmaengine+bounces-10465-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:20:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003753DF6C
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CAB53012EA6
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5D3911D5;
	Thu, 14 May 2026 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/op5/0w"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6E38F934;
	Thu, 14 May 2026 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735922; cv=none; b=DYf34qAvtuxNNOEDW2GPTPUnNCND73X3PxEqrnxyOns0oGq1C3T8E6M1ssQI2peCKpbPrrtcCpvh5IEZajP14gKssb4bMxLK4d6tGvaW/fGE7C3TudoRbWIsnRI1yrjIa93T1MFQOrzBT5lUaCHE3Ron5Te9+mCGc6wcNPZRmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735922; c=relaxed/simple;
	bh=sYwbwqRF98uuFyhlJII/S/CDAenAqNuV3CAHUgEgjew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d25RQGAd1ULbNA2lA48viclOX1eLhlgCiq1Vo3ETiH9+MEX/wDfkTIrYzNp4cfFBTKUSVwrEbjkyv4IMQVFQuAGvBCHvaRtNmbYY06d6BK390OtCoXY4ZvZDZGQHd24Zdw4GR2/vwVbcEIWc+MYzKTmB0MgLJFXl9FqY1+EaMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/op5/0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B727C2BCB7;
	Thu, 14 May 2026 05:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778735922;
	bh=sYwbwqRF98uuFyhlJII/S/CDAenAqNuV3CAHUgEgjew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U/op5/0w3y/zN3rz33jMyASMvSLyZ58VjKkS95U8AhEZPn9pVH+t3qixejR94DwzB
	 YJZKWHhNJ69wf/wNXog+KwyEibkkP5oT7ia+uAvV0LyPM88Kvrx4Obbnu6ZyJnN1Hl
	 V+R3lEDyYls17yCyu4UtnLrIVjHSz3Y2f0grYzhfG+khB/91D/jBL51RS805PnpX81
	 r0mulOZ/mmSwGpUObAoRzfs+YNfAKUmI6D2XSL4MjO8d9Bi71M6vaG4BQOjPjFs6ss
	 zU3+iuQ5R79oafQL01+qIMfO8juufTx6IHnUmng1gv7A0gAaT28A6rv3yWW9PH0LlF
	 nY+v+BuWeFgmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] dmaengine: fsl-edma: convert DMAMUX clock
 handling to bulk clock API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joy Zou" <joy.zou@nxp.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-3-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-3-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:18:41 +0000
Message-Id: <20260514051842.1B727C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5003753DF6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10465-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Switching to `devm_clk_bulk_get_optional_enable()` silently drops =
validation for missing DMAMUX clocks, leading to a system bus hang during p=
robe on misconfigured device trees.
--

commit ac85fd72d931ccb00828f78ca0682e23cee58abe
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: convert DMAMUX clock handling to bulk clock API

This commit converts the DMAMUX clock management from individual clock
operations to the bulk clock API to simplify the code. This is in
preparation for adding runtime PM support.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index ecd14967bfbc0..c12126ea6552d 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c

[ ... ]

> @@ -747,23 +739,28 @@ static int fsl_edma_probe(struct platform_device *p=
dev)
>  		fsl_edma->chan_masked |=3D chan_mask[0];
>  	}
> =20
> -	for (i =3D 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> -		char clkname[32];
> -
> -		fsl_edma->muxbase[i] =3D devm_platform_ioremap_resource(pdev,
> -								      1 + i);
> -		if (IS_ERR(fsl_edma->muxbase[i])) {
> -			/* on error: disable all previously enabled clks */
> -			fsl_disable_clocks(fsl_edma, i);
> -			return PTR_ERR(fsl_edma->muxbase[i]);
> +	if (fsl_edma->drvdata->dmamuxs) {
> +		fsl_edma->muxclk =3D devm_kcalloc(&pdev->dev, fsl_edma->drvdata->dmamu=
xs,
> +						sizeof(*fsl_edma->muxclk), GFP_KERNEL);
> +		if (!fsl_edma->muxclk)
> +			return -ENOMEM;
> +
> +		for (i =3D 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> +			fsl_edma->muxbase[i] =3D devm_platform_ioremap_resource(pdev, 1 + i);
> +			if (IS_ERR(fsl_edma->muxbase[i]))
> +				return PTR_ERR(fsl_edma->muxbase[i]);
> +
> +			fsl_edma->muxclk[i].id =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +								"dmamux%d", i);
> +			if (!fsl_edma->muxclk[i].id)
> +				return -ENOMEM;
>  		}
> =20
> -		sprintf(clkname, "dmamux%d", i);
> -		fsl_edma->muxclk[i] =3D devm_clk_get_enabled(&pdev->dev, clkname);
> -		if (IS_ERR(fsl_edma->muxclk[i]))
> -			return dev_err_probe(&pdev->dev,
> -					     PTR_ERR(fsl_edma->muxclk[i]),
> -					     "Missing DMAMUX block clock.\n");
> +		ret =3D devm_clk_bulk_get_optional_enable(&pdev->dev, fsl_edma->drvdat=
a->dmamuxs,
> +							fsl_edma->muxclk);

Does using devm_clk_bulk_get_optional_enable() silently drop validation for
missing DMAMUX clocks?

The previous code used devm_clk_get_enabled(), which safely aborted the pro=
be
if clocks were missing. Because the optional variant returns 0 when the clo=
cks
are missing in the device tree, the probe will continue.

If the probe continues without the clocks enabled, the driver later calls
fsl_edma_chan_mux() which accesses the unclocked muxbase registers. On NXP
SoCs, accessing unclocked registers can trigger a system bus hang or
asynchronous external abort.

Should this use a mandatory bulk clock API to ensure the clocks are actually
present and enabled?

> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to enable DMAMUX block clock.\n");
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-b4-b4-edma=
-runtime-opt-v5-0-1e595bfb8423@nxp.com?part=3D3

