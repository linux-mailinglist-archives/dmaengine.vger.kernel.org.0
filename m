Return-Path: <dmaengine+bounces-12207-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id //8mDImvT2r+mgIAu9opvQ
	(envelope-from <dmaengine+bounces-12207-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:26:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469F732353
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:26:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e2EMBZ+z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12207-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12207-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E201330409EB
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850EF330666;
	Thu,  9 Jul 2026 14:08:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CD27E1DC
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:08:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606113; cv=none; b=PpWL6ktYlscqyVQndkEmd+aZTPlwdvCNF8NjevNes0THrAGjs+FWBFUrJZNPSC7OnMo7wJ2fFit9fYQE/9YhwpHDFj/arlKvNtJMQ7kHmJvCcYpqQm4Z9FlqT+AVres0Dwtd7AkBkqD3zcZ7OinyPoSpqVyhxTlahhqV6z/Q0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606113; c=relaxed/simple;
	bh=qSG1Q7lbVybJcG2BdmQ+OarGtMBTx+H0ZOV316+b1fU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4QF2wRnxjiiW8bXLj4rHp9y5tnaTdZZRvHXuptivXFv9sYBqA1ep2jwlJrM9TO8VjDGfRi/VKJBI5K+/QLtbDPKwaXOfc0vajImW8h5b0jOtBFBrsQPF1CCFiC4LUKX91vUIm/xRgme2tAP1k2i/gqcDtEgVv6FxofRN8ERZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2EMBZ+z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC151F000E9;
	Thu,  9 Jul 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606112;
	bh=XYPbZi+gbo2Rh/4xN7dXWjk9IyVNBhO2SUPAPVi/Of4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2EMBZ+zXihojsNgNc8Ra4v5dGrJT33x9TEA3mtp6vZ7w0+YUUd4UKlB2TTqKnfMU
	 NUh3fjYnXMj+3yJBpMsMo96iiLamNM7d8Ln/Ce1zGYkFfELTXDwwziqtr+jbw/L3Te
	 ksRTOqXNYvEfJrwEYT9EVcrgFwI4Yg4BaYvbW3nHgR7VQC1LeW/SV1NGMEAGE1vXfi
	 d4rEbB/zUXsl4gfELl+nAt4pFrZk/SqqPOJUbcgwz220XPFYIgXNogWRR0A4bm92r1
	 TQe7X5Z9rAKJIF4ipWh73RK2QEpDOAMsIzpv7zR+hdTVzWSAOLaIw3LY99QMKD5DuE
	 IEn0+e99k8Ahg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/26] dmaengine: fsl-qdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-3-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:08:31 +0000
Message-Id: <20260709140831.AFC151F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12207-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,vivo.com:email,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5469F732353

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete Refactoring / Commit Message Mismatch

Pre-existing issues:
- [High] Driver fails to halt the hardware DMA engine on teardown and error=
 paths
- [High] Inverted teardown order: driver destroys internal resources before=
 unregistering the device
- [High] vchan tasklets are not killed on probe failure
--

--- Patch [2]: [PATCH 02/26] dmaengine: fsl-qdma: Remove redundant dev_err(=
)/dev_err_probe() ---
commit a6f00a613e01411f16385ac0c92bca0027dc654d
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: fsl-qdma: Remove redundant dev_err()/dev_err_probe()

This commit removes a redundant error log following a call to
devm_request_irq, as the core already logs failures. It intends to clean up
the error paths in the qDMA driver.

> The devm_request_irq() now automatically logs detailed error messages on
> failure. This eliminates the need for driver-specific dev_err() and
> dev_err_probe() calls that previously printed generic messages.

[Severity: Medium]
Is the commit message accurate regarding dev_err_probe? Looking at the
patch, no dev_err_probe calls are actually removed.

Also, does this patch miss the second devm_request_irq in the same
function?

drivers/dma/fsl-qdma.c:fsl_qdma_irq_init() {
[ ... ]
        ret =3D devm_request_irq(&pdev->dev,
                               fsl_qdma->queue_irq[i],
                               fsl_qdma_queue_handler,
                               0,
                               "qDMA queue",
                               fsl_qdma);
        if (ret) {
                dev_err(&pdev->dev,
                        "Can't register qDMA queue IRQ.\n");
                return  ret;
        }
[ ... ]
}

> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index df843fad0ece5..7f0d69b99289e 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -818,10 +818,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
>  	ret =3D devm_request_irq(&pdev->dev, fsl_qdma->error_irq,
>  			       fsl_qdma_error_handler, 0,
>  			       "qDMA error", fsl_qdma);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't register qDMA controller IRQ.\n");
> +	if (ret)
>  		return  ret;
> -	}
> =20
>  	for (i =3D 0; i < fsl_qdma->block_number; i++) {
>  		sprintf(irq_name, "qdma-queue%d", i);

[Severity: High]
This is a pre-existing issue, but does the driver fail to halt the hardware
DMA engine on teardown and error paths?

fsl_qdma_reg_init() explicitly enables the DMA hardware and its interrupts.
If probe() fails later or when the driver is unbound, the driver never=20
invokes fsl_qdma_halt() to stop the device:

drivers/dma/fsl-qdma.c:fsl_qdma_remove() {
        fsl_qdma_irq_exit(pdev, fsl_qdma);
        fsl_qdma_cleanup_vchan(&fsl_qdma->dma_dev);
        of_dma_controller_free(np);
        dma_async_device_unregister(&fsl_qdma->dma_dev);
}

Because the DMA buffers are allocated via devres (e.g., dmam_alloc_coherent=
),
they are freed immediately upon driver removal or probe failure. Can the
unhalted hardware continue to perform DMA operations into this freed memory?

[Severity: High]
This is a pre-existing issue, but does fsl_qdma_remove() have an inverted
teardown order?

drivers/dma/fsl-qdma.c:fsl_qdma_remove() {
        fsl_qdma_irq_exit(pdev, fsl_qdma);
        fsl_qdma_cleanup_vchan(&fsl_qdma->dma_dev);
        of_dma_controller_free(np);
        dma_async_device_unregister(&fsl_qdma->dma_dev);
}

fsl_qdma_cleanup_vchan() is called before dma_async_device_unregister(). Th=
is
creates a window where the DMA controller is still visible to clients via t=
he
DMA engine API, but its backend is destroyed.

Furthermore, fsl_qdma_cleanup_vchan() removes channels from the channels
list. Will dma_async_device_unregister() then iterate over an empty list and
fail to deregister the channels from sysfs?

[Severity: High]
This is a pre-existing issue, but are vchan tasklets properly killed on
probe failure?

drivers/dma/fsl-qdma.c:fsl_qdma_probe() {
[ ... ]
        ret =3D fsl_qdma_irq_init(pdev, fsl_qdma);
        if (ret)
                return ret;

        ret =3D dma_async_device_register(&fsl_qdma->dma_dev);
        if (ret)
                return dev_err_probe(&pdev->dev, ret,
                                     "Can't register NXP Layerscape qDMA en=
gine.\n");
[ ... ]
}

vchan_init() initializes the vchan tasklets for each channel. If a subseque=
nt
step like fsl_qdma_irq_init() or dma_async_device_register() fails, probe()
returns the error code directly without calling tasklet_kill().

Because the hardware is already enabled, could an interrupt fire and schedu=
le
the tasklet? When devres frees the fsl_qdma->chans array upon probe failure,
would the scheduled tasklet execute against freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D2

