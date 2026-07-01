Return-Path: <dmaengine+bounces-11923-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MVuuGtjgRGoL2goAu9opvQ
	(envelope-from <dmaengine+bounces-11923-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:41:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF06EBAD7
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UJYyHxVy;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11923-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11923-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E643300BC9E
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C213F5BD3;
	Wed,  1 Jul 2026 09:40:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A503F44C1;
	Wed,  1 Jul 2026 09:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898818; cv=none; b=ATAYj9NpH9HqsXwyOsGjU2WV/S2fSwPmhKInojfJ54qskTTUGzgHJJL6votd6ptrCjbRScH4xCfdi47TiKt335IHqPNseLvhCdIAMCxfcCLue63xxiKtYv5C5q6sGXwDY1wnGudV5TQZ06TnXBVkaNxm7R93Aa4/60dC8IHZZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898818; c=relaxed/simple;
	bh=4Zvhc7ro/iV8uYMZPY5wetHw4hO98oBXxeYj2TMiW8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGE2MAYy/EWoQIDs9lvPAR2i7gzX9y3RdZz9S3N/uUS97PZd7kMfnvXaMuMA0Q3GtAKbRqkqvlaFc0PfJ9fKnUY9+3odcNW6Y8QqZmjRF7oIlI43LCWkJUs8Gn1ujodC9fsK2EHTE/z30ymCCWjvWeZCPwjqxYs3vxqbMcUlAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJYyHxVy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A569D1F000E9;
	Wed,  1 Jul 2026 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898815;
	bh=J1tZhdK70GWlwise02fchZ/dXtCCl1SVkffw9J7oFcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJYyHxVypgGbWFX48v+iymWF4zNYGFx9VVv8NIShzW25DBqqzINuvs2It+dECK57+
	 mrkvJj3u/5AbPKex5XVKjLF1S/wi2pCgLmi4LjJTMVJDaOvYMnMt3vtkv8NFtymZUe
	 ScFPm+SXtugdtS6LBLHsEcDfSJxqxHH/byiBT66rlWd88qP+jYhK52FQLo2W0J4rsK
	 vZVxA5BfkFYr8oF2O6XYCa/lfytlbzCfGKvAAmv+UTASezwd3uGS6Z2j8xjeidUMHC
	 j6GHaoAKCWFTP/RiUh9JOpcXYnuYeyaeZBs2c/7BVT/TPvTW5IePx9GRWeKVZVKZ++
	 CseVNqIU9F21g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] dmaengine: fsl-edma: use devm_clk_get_optional()
 for DMA engine clock
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-2-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-2-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:40:15 +0000
Message-Id: <20260701094015.A569D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11923-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid];
	FORGED_RECIPIENTS(0.00)[m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7AF06EBAD7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces calls to a non-existent function `devm_clk_pre=
pare_enable()`, resulting in a build failure.
--

commit 52e4c7b7c140f88bd3ed6ad6e10c3513c2941e5c
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: use devm_clk_get_optional() for DMA engine clock

This commit updates the eDMA engine clock handling to treat it as optional,
removing the FSL_EDMA_DRV_HAS_DMACLK flag and replacing
devm_clk_get_enabled() with separate get and enable calls.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c

[ ... ]

> @@ -733,13 +733,15 @@ static int fsl_edma_probe(struct platform_device *p=
dev)
>  		regs =3D &fsl_edma->regs;
>  	}
> =20
> -	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
> -		fsl_edma->dmaclk =3D devm_clk_get_enabled(&pdev->dev, "dma");
> -		if (IS_ERR(fsl_edma->dmaclk))
> -			return dev_err_probe(&pdev->dev,
> -					     PTR_ERR(fsl_edma->dmaclk),
> -					     "Missing DMA block clock.\n");
> -	}
> +	fsl_edma->dmaclk =3D devm_clk_get_optional(&pdev->dev, "dma");
> +	if (IS_ERR(fsl_edma->dmaclk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(fsl_edma->dmaclk),
> +				     "Failed to get/enable DMA clock.\n");
> +
> +	ret =3D devm_clk_prepare_enable(&pdev->dev, fsl_edma->dmaclk);

[Severity: Low]
Does this function call cause a build regression? It appears that
devm_clk_prepare_enable() is not defined in the standard clock API, which
might result in an implicit declaration error and break git bisect.

I noticed that this is resolved later in the series in commit
a5800ff547600d938eb443a21684d6291b4658d1 (dmaengine: fsl-edma: add runtime
suspend/resume support), where these undefined function calls are removed
for both the engine clock and the channel clocks.

Is it possible to reorganize the patch series so that the build does not
fail at this intermediate step?

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");
> =20
>  	ret =3D of_property_read_variable_u32_array(np, "dma-channel-mask", cha=
n_mask, 1, 2);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-edma-ru=
ntime-opt-v6-0-354ff4229c00@oss.nxp.com?part=3D2

