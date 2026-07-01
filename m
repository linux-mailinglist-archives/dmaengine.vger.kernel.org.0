Return-Path: <dmaengine+bounces-11921-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tY0DMmTgRGr12QoAu9opvQ
	(envelope-from <dmaengine+bounces-11921-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:39:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89B6EBAB3
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:39:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SefysN1v;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11921-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11921-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3A9300DF63
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D63F1ACE;
	Wed,  1 Jul 2026 09:38:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B93A1A3F;
	Wed,  1 Jul 2026 09:38:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898728; cv=none; b=UsQXiofcuUXDh/lEksmUq9WbPocg6Zl5pKjxapgPShDdIaJgHfcBg5ddfk78JyXZQUrkJ+F4ssHD0CkmlloYZrC4DrJ2X2K7rFGDB0MQ78m8lYaa+zwuli4emxEjlFCz8EDLb354AlR2d1iRnJIMZwUT7EKujqJE79RQYk00Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898728; c=relaxed/simple;
	bh=mgg+G5Enqi+5HGFCZP2OCBwAxeDKVRnMETA8wCd2S44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gAfkpimywa8kO7jo8/X5HZK4cnqCeg4tyKfNtOMbZcSE49obxa8E9vBAw95oRd7uxHiLLcGdhtuGIBvfQgjL5j6ujXAslpRS5cv80Qe29rfw+6XURGcc8LyCvi2znNsjT1tpy9LD6yVc7uLAT/k2rW22N2r6PwtRWTAaK0E2Aao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SefysN1v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A541F000E9;
	Wed,  1 Jul 2026 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898727;
	bh=naMhkQLiOUYVB5390f2UsGr7Xj0UNe+EoE6OgDVCO9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SefysN1vK4DGtht0IP+3Iv/l4g8bLMoSwKIzn/OhiV9wLsl8Pyp47HnArEpgK//I9
	 2P2FVMgtsiju3KKyPK5sNFgZHzrsJC2LB+WCQemqlbx7QbVE0nzgLG/9dNfkc4zpiG
	 maoLsekswOQJrvdgduUx9/OsCmIdTUC3uikVAijPwDCKkGOIj/p79CVbe7EyP2bvOa
	 qFWqHv4N2Ysz4gqXoLHSscbuqztiBMZkpe0sxwrQII2aZRcKVJpUB0shcZKRimBSB/
	 e4Yox2p+XwAKJaUR7tKvusuYUH1WRoqw6cU0CCYFmJmR8zfrYz/qH8Z9HNaqmRyx18
	 LmQ6qI3JD3KEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] dmaengine: fsl-edma: use devm_clk_get_optional()
 for channel clock
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-1-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-1-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:38:46 +0000
Message-Id: <20260701093847.17A541F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11921-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:joy.zou@oss.nxp.com,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C89B6EBAB3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compilation failure by calling an undefined =
function `devm_clk_prepare_enable()`.
--

commit 36cfeebd16ae2d241bf40213a5b9272983d736d3
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: use devm_clk_get_optional() for channel clock
   =20
This commit replaces devm_clk_get_enabled() with devm_clk_get_optional()
and removes the FSL_EDMA_DRV_HAS_CHCLK flag for channel clocks. It prepares
the driver for adding channel runtime PM support.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a9..1e864cd4c784e 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c

[ ... ]

> @@ -808,22 +807,19 @@ static int fsl_edma_probe(struct platform_device *p=
dev)
>  		fsl_chan->tcd =3D fsl_edma->membase
>  				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
>  		fsl_chan->mux_addr =3D fsl_edma->membase + drvdata->mux_off + i * drvd=
ata->mux_skip;
> -
> -		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
> -			snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
> -			fsl_chan->clk =3D devm_clk_get_enabled(&pdev->dev,
> -							     (const char *)clk_name);
> -
> -			if (IS_ERR(fsl_chan->clk))
> -				return PTR_ERR(fsl_chan->clk);
> -		}
> +		snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
> +		fsl_chan->clk =3D devm_clk_get_optional(&pdev->dev, (const char *)clk_=
name);
> +		if (IS_ERR(fsl_chan->clk))
> +			return PTR_ERR(fsl_chan->clk);
> +		ret =3D devm_clk_prepare_enable(&pdev->dev, fsl_chan->clk);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret, "Failed to enable clock\n");

[Severity: Low]
Will this introduce a build failure? The function devm_clk_prepare_enable()
does not appear to be defined in the Linux kernel Common Clock Framework.

I see this compilation regression was resolved later in the patch series by
commit a5800ff547600d938eb443a21684d6291b4658d1 ("dmaengine: fsl-edma: add
runtime suspend/resume support"), but could it break git bisect if this
commit is tested independently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-edma-ru=
ntime-opt-v6-0-354ff4229c00@oss.nxp.com?part=3D1

