Return-Path: <dmaengine+bounces-12212-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m7vXNMWvT2oJmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12212-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:27:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58C732379
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GbDbh82W;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12212-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12212-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CCFE30EB5FF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388C32B139;
	Thu,  9 Jul 2026 14:12:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF02FC89C;
	Thu,  9 Jul 2026 14:12:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606335; cv=none; b=f9VMhkZcnrMo4+urgQ0eFStmkZ/Ejmoa69tDhyDeQtPnmVyawZkynnThYtgkjzxru2OW5yVO5iFCIhmLO1AZ4xLGCvFpiElgIIaRkWsRAB0ajrrPmlEJuZ6Qq9Ki1SdvgeGtl5PZkDxl+ZyLlvTMYSNqe2R5d1NIIsnBnuYltEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606335; c=relaxed/simple;
	bh=6gWMr/1ZotjeiZqUbt/nvdp1w4S57UxJqNrYvCTuT0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NYC6u/TFKjk+bjSAUg5nDpTGbeRQvYSI5E5pPnqbBcA98lTxu2GVosdqJRXMq1oCJ4H8gxnWuqwTGXyV1q7MUjT702YhjI82ufmsC+n2I2jI3D8ZnGGkJ4bdU+neDRjNI2LuWEZaUTTlabHymif+mtxiFg+nrK43HwwhwGE132Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbDbh82W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2821F000E9;
	Thu,  9 Jul 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606334;
	bh=sPbttQasY5IyzO+TXfnvMFj9nk5fymvOX3UzqO3RvnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbDbh82Wr8Q2oXTpU+ZOlN6bw6x1COGvVIIKUg3YJud1rK0cvY4/h9RnQaLVhcT2s
	 p3J4/EvYhmXwbG2fTa5Fxg0bulT+XI+gChvh0wG1Q/pPUYHBj2t66/1TalexJ9cy5V
	 t9PCtzWrh4GrU97viRXQmox6GacbljfCyR5efZ2XOExBZXkTTElfjtf+/Q2jki3uXV
	 Qhxkb8Xev2RXQu+1Srmi4mRK5AKh/ybXbqYfMzK04pq5qIuhQHtiFtZlhGSYfEz08l
	 uGeVnhSLuAcFXxC2fOKw3Nd59MJS39PyBTyLfrXraZGyIO1S0sHNAaiacU+vjtOyPi
	 pKGpvxy6+n6pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/26] dmaengine: fsl-edma-main: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-2-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-2-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:12:13 +0000
Message-Id: <20260709141213.BC2821F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12212-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vivo.com:email,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D58C732379

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The txirq_16_31 interrupt is not freed before vchan cleanup, leadi=
ng to a race condition and potential use-after-free on device unbind.
- [High] Double disable/unprepare of devm-managed clocks during the probe f=
ailure path.
- [High] Probe deferral is permanently broken due to unconditionally overri=
ding negative error codes from `platform_get_irq()` with `-EINVAL` or `-ENX=
IO`.
--

--- Patch [1]: [PATCH 01/26] dmaengine: fsl-edma-main: Remove redundant dev=
_err()/dev_err_probe() ---
commit 0e4d4c4909fc6ed60a790a7b9fecb3bf5b716c3b
Author: Pan Chuang <panchuang@vivo.com>

    dmaengine: fsl-edma-main: Remove redundant dev_err()/dev_err_probe()
   =20
    The devm_request_irq() now automatically logs detailed error messages on
    failure. This eliminates the need for driver-specific dev_err() and
    dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a9..0881f4f36b3f4 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
[ ... ]
> @@ -418,7 +412,7 @@ static int fsl_edma3_irq_init(struct platform_device =
*pdev, struct fsl_edma_engi
>  		ret =3D devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_h=
andler_shared,
>  				       0, errirq_name, fsl_edma);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret, "Can't register eDMA err IRQ.\n=
");
> +			return ret;

[Severity: High]
This is a pre-existing issue, but probe deferral appears to be permanently
broken for the interrupt requests in this function and fsl_edma2_irq_init().

In fsl_edma3_irq_init(), if platform_get_irq() returns -EPROBE_DEFER,
the error code is discarded and replaced with -EINVAL:

    fsl_chan->txirq =3D platform_get_irq(pdev, i);
    if (fsl_chan->txirq < 0)
        return -EINVAL;

Similarly in fsl_edma2_irq_init(), it replaces the error with -ENXIO:

    irq =3D platform_get_irq(pdev, i);
    ret =3D 0;
    if (irq < 0)
        return -ENXIO;

Could this prevent the DMA engine from probing on systems where the
interrupt controller is not yet ready?

>  	}
> =20
>  	return 0;
> @@ -445,24 +439,21 @@ static int fsl_edma3_or_irq_init(struct platform_de=
vice *pdev,
>  			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
>  			       fsl_edma);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -			       "Can't register eDMA tx0_15 IRQ.\n");
> +		return ret;
> =20
>  	if (fsl_edma->n_chans > 16) {
>  		ret =3D devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
>  				       fsl_edma3_tx_16_31_handler, 0,
>  				       "eDMA tx16_31", fsl_edma);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret,
> -					"Can't register eDMA tx16_31 IRQ.\n");
> +			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does the handling of
txirq_16_31 create a race condition leading to a potential use-after-free?

When the driver is unbound, fsl_edma_remove() executes:

    fsl_edma_irq_exit(pdev, fsl_edma);
    fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);

However, fsl_edma_irq_exit() manually frees txirq and errirq to stop
interrupts before vchan cleanup, but it misses txirq_16_31:

    if (fsl_edma->txirq =3D=3D fsl_edma->errirq) {
        if (fsl_edma->txirq >=3D 0)
            devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
    } else {
        if (fsl_edma->txirq >=3D 0)
            devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
        if (fsl_edma->errirq >=3D 0)
            devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
    }

Since txirq_16_31 is not freed, is it possible for the interrupt handler
to still run during or after fsl_edma_cleanup_vchan() destroys the vchan
tasklets?

>  	}
> =20
>  	ret =3D devm_request_irq(&pdev->dev, fsl_edma->errirq,
>  			       fsl_edma3_or_err_handler, 0, "eDMA err",
>  			       fsl_edma);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "Can't register eDMA err IRQ.\n");
> +		return ret;
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is there a double disable of
devm-managed clocks during the probe failure path?

In fsl_edma_probe(), the mux clocks are acquired using the devm variant:

    fsl_edma->muxclk[i] =3D devm_clk_get_enabled(&pdev->dev, clkname);

If resource mapping fails for a subsequent mux base, the error path manually
disables the clocks:

    if (IS_ERR(fsl_edma->muxbase[i])) {
        /* on error: disable all previously enabled clks */
        fsl_disable_clocks(fsl_edma, i);
        return PTR_ERR(fsl_edma->muxbase[i]);
    }

Because the clocks were acquired with devm_clk_get_enabled(), won't devres
also try to disable them when cleaning up the probe failure, resulting in a
double-disable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D1

