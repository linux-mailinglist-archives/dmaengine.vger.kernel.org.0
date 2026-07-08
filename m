Return-Path: <dmaengine+bounces-12108-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /897LOoGTmqJBwIAu9opvQ
	(envelope-from <dmaengine+bounces-12108-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 10:14:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C39872306A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 10:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cGIOhi6r;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12108-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12108-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB65930087D2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127D3E5A2A;
	Wed,  8 Jul 2026 08:14:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE42D949F;
	Wed,  8 Jul 2026 08:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498470; cv=none; b=Y0CXO7p18iWXl765PEioQGcCAqmcUD/tY9SRYwZVz63qQKEYI560XDuFNmPsTFToBY1Tx+MKZvEInBm0bDeoevZFUbo1gQHIQi+n/Ak155jArTnK/K8JIu6RrCsPgcxYnqcwNLIY4rYShJSadL8WRm2pCBSNECmdGRc82Ohnbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498470; c=relaxed/simple;
	bh=AZI2H3KAWPRGDbhChvy/BslTmxHV+T2WanKIv6cP9nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AmMb1PCHiRaZlroOh0aZsF6kBGGCNk3GhtOZV+ck5h5HMX0U6197XqDgrzNSHsILj7PNnSGanIeFChEHb3Eq4LBBesb/C7BwfTqTTekt7nLeXtdq7SYohQYBiRkHLZ9lRkfCOxqU+1nblu9aCV04h/vq6vJtIDKMEsrmDAXry9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGIOhi6r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E132A1F000E9;
	Wed,  8 Jul 2026 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498469;
	bh=6tYkE+qACIZ4O/W4aXCYlxFDwdLtKZiXcbFMUMyGZQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGIOhi6rCe3qGl9e5qMw5aRkcGr4ryqqeOMaccEQrB7BavAFpW3899JQSy5NnptYE
	 OeiXrzuWx7dpiWerGwAGdelZY+FF+Ta4ovFsuRJYNWhby0h6twO6L02s9hRocwQJzc
	 zOpkJjTYzHR/IsCDSi+JLd0SS3vWlvtCKOjAfeptRG2KfJ3zuMO9ga3waeIeecrEQO
	 f3mGxHMJM7fHqETZ4Ri4++m7H//S40ooH6jfzhx8DRsSHGj9tua6eqLpbFaoEdcHsM
	 04O5V65jeFEsya17PLlLfvyXDesTlGHQtpZIY/cuozZq8Ok2Kii299drDkx7+TMbv4
	 wEW1WcTeF+cIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-edma: Add error handling for
 devm_kasprintf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708075736.47822-1-griffin@kroah.com>
References: <20260708075736.47822-1-griffin@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:14:28 +0000
Message-Id: <20260708081428.E132A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12108-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kroah.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:griffin@kroah.com,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C39872306A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper handling of IRQ API error codes breaks probe deferral.
- [High] Double disable of `muxclk` clocks due to explicit disable of devre=
s-managed clocks upon probe failure.
- [High] Double disable of channel clocks on probe error and device removal.
- [High] Use-After-Free of power domain device pointer during probe failure=
 or device removal.
--

--- Patch [1]: [PATCH v2] dmaengine: fsl-edma: Add error handling for devm_=
kasprintf ---
commit a6d0ef2d595b7ee7a27a92eb52a981ce05946b5f
Author: Griffin Kroah-Hartman <griffin@kroah.com>

dmaengine: fsl-edma: Add error handling for devm_kasprintf

Add error handling statement to fsl_edma3_irq_init() for the
devm_kasprintf() call.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a9..d9fb717b5b53c 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -414,6 +414,8 @@ static int fsl_edma3_irq_init(struct platform_device =
*pdev, struct fsl_edma_engi
> =20
>  		errirq_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-err",
>  					     dev_name(&pdev->dev));
> +		if (!errirq_name)
> +			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but returning -ENOMEM here makes=
 a
pre-existing use-after-free in fsl_edma3_detach_pd() more likely to be
triggered during probe failure.

When detaching a power domain, dev_pm_domain_detach() unregisters and frees
the virtual device. Is it safe to pass the freed pd_dev pointer to
pm_runtime_dont_use_autosuspend() and pm_runtime_set_suspended() immediately
after?

drivers/dma/fsl-edma-main.c:fsl_edma3_detach_pd() {
    ...
	if (fsl_chan->pd_dev) {
		dev_pm_domain_detach(fsl_chan->pd_dev, false);
		pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
		pm_runtime_set_suspended(fsl_chan->pd_dev);
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but returning -ENOMEM here will also trigger a
pre-existing double disable of channel clocks during probe error handling.

Channel clocks are acquired via devm_clk_get_enabled(), but fsl_edma_probe()
explicitly disables them. Could devres execute clk_disable_unprepare()
again on these already disabled clocks when handling the error?

drivers/dma/fsl-edma-main.c:fsl_edma_probe() {
    ...
	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
		clk_disable_unprepare(fsl_chan->clk);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but looking earlier in
fsl_edma3_irq_init() and fsl_edma2_irq_init(), the error code from
platform_get_irq() is discarded.

If platform_get_irq() returns -EPROBE_DEFER, returning -EINVAL or -ENXIO
instead of propagating the error code will break deferred probing. Would it
be better to return the actual error code instead?

drivers/dma/fsl-edma-main.c:fsl_edma3_irq_init() {
    ...
		fsl_chan->txirq =3D platform_get_irq(pdev, i);
		if (fsl_chan->txirq < 0)
			return  -EINVAL;
    ...
}

drivers/dma/fsl-edma-main.c:fsl_edma2_irq_init() {
    ...
		irq =3D platform_get_irq(pdev, i);
		ret =3D 0;
		if (irq < 0)
			return -ENXIO;
    ...
}

[Severity: High]
This is a pre-existing issue, but while looking at fsl_edma_probe(), there
appears to be another double disable when devm_platform_ioremap_resource()
fails.

If resource allocation fails, fsl_disable_clocks() is called manually, which
disables muxclk. Since muxclk was acquired with devm_clk_get_enabled(),
won't devres double disable it?

drivers/dma/fsl-edma-main.c:fsl_edma_probe() {
    ...
		if (IS_ERR(fsl_edma->muxbase[i])) {
			/* on error: disable all previously enabled clks */
			fsl_disable_clocks(fsl_edma, i);
			return PTR_ERR(fsl_edma->muxbase[i]);
		}
    ...
}

> =20
>  		ret =3D devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_h=
andler_shared,
>  				       0, errirq_name, fsl_edma);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708075736.4782=
2-1-griffin@kroah.com?part=3D1

