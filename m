Return-Path: <dmaengine+bounces-10439-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL83LJTbBGrYPwIAu9opvQ
	(envelope-from <dmaengine+bounces-10439-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:14:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DC53A61A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A289E3013B5F
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082D3A9DAB;
	Wed, 13 May 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W529Y5a/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFF3A874B
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703249; cv=none; b=FIp+KbFXy37clPdcI5PDVeE/OphDzPHEBCVTq8rrIR+KA3Bi50379hTRY9UChfihvfkAdeWfpgXH4XikSXm5W5sjJRsHsze50wPsyfH8KusRIJlxs7SiO753zTM9ngCAM93OvikuiHLGUlX3lpbWqG+Fs2rSAeb4mjxwQ1l7bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703249; c=relaxed/simple;
	bh=GMw4dbyiku5F1PleJh7Gqgoeu0JkGIXtB2hQKEqUxj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yy+/dANeQe/98VNLbE1ovjzT/XQMjU4EieoXwXckYSAEA3ThwiwLHzntmDBXpO2SQjM/3JRyO2l0LclK09Q/nuVdlKo6eAoMZlgnHHJzI+sGemdG3c70tUWvEMta0vD8ff8kPv11JXq0OJB/TXR2oe7RsA5Bc0Oi8e5Q2wJzAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W529Y5a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A02C19425;
	Wed, 13 May 2026 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703248;
	bh=GMw4dbyiku5F1PleJh7Gqgoeu0JkGIXtB2hQKEqUxj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W529Y5a/nwoYQzeueF6jwCntFmM8TFbVGoaxhkwmH3Bdckr4gB0N3kI+Bftgy5HIO
	 i6Hu7haWzgEQwwwlKOK3NdrwbWJdq1Up7g8xEJTCR8zJtTZkvitzyRbiEJGRHELYBG
	 wQzrFD61dpKPTE7WXcwPZbhiJC5aGE5UYbBmEwcFUHaZhMFfP5wJVOGreSM0sYMuJD
	 ZZRP3e6zEbYTzFST4v+4Bv7BvLvgUFPHWtcOSI6iBXN3xF6lvJWU7fOZCuo3L5Thy2
	 6em2bXvgA/XZybkqUhiZlKIqAgnX4muXKxy97GpKoGdkzfRdO8X1Y1LRCPSNw9h2/2
	 ShRvN9xvHMZQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] dmaengine: tegra210-adma: Add error logging on
 failure paths
Reply-To: sashiko-reviews@lists.linux.dev
To: Sheetal <sheetal@nvidia.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260512092508.1406119-1-sheetal@nvidia.com>
References: <20260512092508.1406119-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:14:03 +0000
Message-Id: <20260513201408.36A02C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 285DC53A61A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10439-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,nvidia.com:email,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition on probe error paths due to async pm_runtime_put() =
followed by pm_runtime_disable(), leaving hardware powered on.
--

commit 64b163be27d8e21c8b03c51eb8cec223bd8a75f4
Author: Sheetal <sheetal@nvidia.com>

dmaengine: tegra210-adma: Add error logging on failure paths

This commit adds error logging across failure paths to improve
debuggability of DMA errors during runtime and probe. It also cleans up the
probe path using devres managed helpers like devm_pm_runtime_enable() and
dmaenginem_async_device_register(), removing manual error unwind labels.

> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e6..6987bf6ec6487 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c

[ ... ]

> @@ -1127,26 +1160,33 @@ static int tegra_adma_probe(struct platform_devic=
e *pdev)
>  					cdata->global_ch_config_base + (4 * i);
>  		}
> =20
> -		tdc->irq =3D of_irq_get(pdev->dev.of_node, i);
> -		if (tdc->irq <=3D 0) {
> -			ret =3D tdc->irq ?: -ENXIO;
> -			goto irq_dispose;
> -		}
> +		ret =3D of_irq_get(pdev->dev.of_node, i);
> +		if (ret <=3D 0)
> +			return dev_err_probe(&pdev->dev, ret ?: -ENXIO,
> +					     "failed to get IRQ for channel %d\n", i);
> +		tdc->irq =3D ret;
> =20
>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>  		tdc->vc.desc_free =3D tegra_adma_desc_free;
>  		tdc->tdma =3D tdma;
>  	}
> =20
> -	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to enable runtime PM\n");
> +
> +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&pdev->dev);
> =20
> -	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	ret =3D ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
>  	if (ret < 0)
> -		goto rpm_disable;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "runtime PM resume failed\n");
> =20
>  	ret =3D tegra_adma_init(tdma);
>  	if (ret)
> -		goto rpm_put;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to initialize ADMA\n");

Does using a scoped guard here introduce a race condition on error paths?

The scoped guard drops its reference using an asynchronous pm_runtime_put()
when it goes out of scope on return. If the probe fails after this point,
the guard drops the reference asynchronously, and then the devres framework
executes pm_runtime_disable() to tear down the environment.

Calling pm_runtime_disable() immediately after an async pm_runtime_put() can
intercept and cancel the pending async suspend work, which leaves the
hardware powered on in an incorrect power state. The original code avoided
this by explicitly calling pm_runtime_put_sync() before disabling runtime P=
M.

Also, does this change the resource teardown order?

The scoped guard drops the PM reference immediately when the function
returns, which happens before devres executes
dmaenginem_async_device_unregister(). This causes the DMA engine to be
unregistered after the power reference has already been dropped,
breaking the LIFO teardown order from the original code where the PM
put happened after DMA engine unregistration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512092508.1406=
119-1-sheetal@nvidia.com?part=3D1

