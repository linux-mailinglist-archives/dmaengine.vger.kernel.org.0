Return-Path: <dmaengine+bounces-10464-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPqvHNlVBWqAVAIAu9opvQ
	(envelope-from <dmaengine+bounces-10464-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:55:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7C53DC82
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BA83026C0F
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 04:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329E3B895D;
	Thu, 14 May 2026 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzQ0caEZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430A3B8950;
	Thu, 14 May 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734550; cv=none; b=jvkmRiS7Cbrrlb5mSht1LC2NrN83GSq7fEoGfgAYvA34POliZ3ue47dPAuQacNQBysZxMnKirLtYnNpUK3usaub/ye52nq2cBUhsYdJ4hr2cQGLlatJTXNz+vIEiMLJsVWOXaXR0zracN/Jv95STtFAN+CktVYDqrCQoiRyCoO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734550; c=relaxed/simple;
	bh=GiCsnbj5xJtYzAw8DqcmNOV4R8sx7quJIngvYKzo0J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asipbRUnUztftyOxu7nJtxn9/aCQtjueQlqCQ5jCHIhloTvDaJAZ7EICXvLPg5tps7o9YfBxqiQgbXpC5F+nOi5FMWBonjX8z39VaDKlJoJMuMcQxz2Jx153lK/LTMfYoO2Mexenubv2vkHDo8LcdtV2Hs9KMdlPri11EZ20LVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzQ0caEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484CDC2BCB7;
	Thu, 14 May 2026 04:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734549;
	bh=GiCsnbj5xJtYzAw8DqcmNOV4R8sx7quJIngvYKzo0J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KzQ0caEZqNctlB4t6vyLGjlg7kVTWWs4N98tRoD48W8Cr3UrmUutSsuL9gQEbX/yZ
	 +9n9SuKXc1hcdnKU5LOWUndi/Ia79UyGyDwnG/+FhaqYUi6YSE60waYvYjR32geLB3
	 t9Rqt8ZNDVN3inelHxFsQQzD9deAv22INfWmXkDLB/kS8QZyIcgvZus14KKtMIOh2X
	 OJhrXXuNlP2cnRAYeWT1x6dBJ8l9ZEve/7gRVVzvnVfXwBA84h/D0vQV4wKss9dS7i
	 FuFY1nf0XbUR/OtejnkKWLtc0q+ONsGUYVb/9GuwqWi1pFVUKQbPP8tCzqR6DDLglz
	 NdB8HVwPpootA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] dmaengine: fsl-edma: use
 devm_clk_get_optional_enabled() for DMA engine clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joy Zou" <joy.zou@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-2-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-2-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 04:55:48 +0000
Message-Id: <20260514045549.484CDC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C2F7C53DC82
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nxp.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10464-lists,dmaengine=lfdr.de];
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing mandatory clock validation risks kernel crashes on miscon=
figured device trees.
- [Medium] API Mismatch: `devm_clk_get_optional_enabled()` conflicts with t=
he stated runtime PM intent, leading to unbalanced clock disables.
--

commit 571d7197ad2ed67c4508436798804c62669d46f2
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: use devm_clk_get_optional_enabled() for DMA engine clo=
ck

This commit replaces devm_clk_get_enabled() with
devm_clk_get_optional_enabled() for the eDMA engine clock and removes the
FSL_EDMA_DRV_HAS_DMACLK flag. The stated goal is to simplify clock handling
and prepare for adding channel runtime PM support.

>     Prepare to add channel runtime pm support.

If the intention is to manage this clock via runtime PM, does using
devm_clk_get_optional_enabled() conflict with that?

The devm_clk_get_optional_enabled() helper registers a devres action that
automatically calls clk_disable_unprepare() upon driver unbind. If the devi=
ce
is runtime suspended and the clock is already disabled when the driver is
unbound, the devres cleanup will attempt to disable the clock again.

Can this trigger a WARN_ON in the clock core for an unbalanced enable count?

Should the driver use devm_clk_get_optional() and manually handle
clk_prepare_enable() instead?

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 87f575d6ccaff..ecd14967bfbc0 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c

[ ... ]

> @@ -733,13 +733,11 @@ static int fsl_edma_probe(struct platform_device *p=
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
> +	fsl_edma->dmaclk =3D devm_clk_get_optional_enabled(&pdev->dev, "dma");
> +	if (IS_ERR(fsl_edma->dmaclk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(fsl_edma->dmaclk),
> +				     "Failed to get/enable DMA clock.\n");

Does removing the driver-level validation for this clock risk kernel crashes
on misconfigured device trees?

On platforms where the eDMA engine clock is physically required (e.g.,
i.MX7ULP, i.MX8ULP, i.MX93), a missing "dma" clock in the device tree
previously caused a graceful probe failure. Now,
devm_clk_get_optional_enabled() will silently return NULL and probing will
continue.

If the driver subsequently writes to unclocked eDMA registers, such as duri=
ng
edma_write_tcdreg(), can this trigger a synchronous external abort (bus fau=
lt)
and panic the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-b4-b4-edma=
-runtime-opt-v5-0-1e595bfb8423@nxp.com?part=3D2

