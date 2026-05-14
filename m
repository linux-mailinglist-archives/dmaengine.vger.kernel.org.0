Return-Path: <dmaengine+bounces-10453-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDIhNRMTBWpoSAIAu9opvQ
	(envelope-from <dmaengine+bounces-10453-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:10:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03C53C42D
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ECFA300847B
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51C145355;
	Thu, 14 May 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh/d1w0E"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60D2BB1D;
	Thu, 14 May 2026 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717453; cv=none; b=OSMHpJQ6+wDEjNQQjfgjDGnuth91H5b59O8lhGmk/Mynt38n1xIsUmSc7XpxN2uJD/xu/800sNDOeE7SNytPYklQeUNuBSAVZI7a8yI+51mt5HQqOG1cG+DFDp/uRnW+KiE632QXii5aFZIseUpZvYgd+t5L9MnuvXyWG4U+N2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717453; c=relaxed/simple;
	bh=y4irLMsIHMcEQrL53y0pEP1UQ/K/1Si8tzza2rhUW58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3684Se6c/ZgYzY16RT6HFktBrxHnH0eGeNYCz3/lmdEe6cvQRhiIAlVGrEBmuvi3D0aZ2+C3epyycTb6hnIMlEOeeRp/Jgw2LTu9U4x13vJWTEEGAe+xnka6Tmv0EFHWkxs0mfYhdKoJNXYpdVB5jLf+tTt9iJ4kLfc3YO/s84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh/d1w0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F5C19425;
	Thu, 14 May 2026 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717452;
	bh=y4irLMsIHMcEQrL53y0pEP1UQ/K/1Si8tzza2rhUW58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Wh/d1w0EulmLQjspVtY459lpQC0HL8hXsRoBJg5PTWmXClH0VGbPuPGz+5AQlBCTV
	 n230/mC82mmjwiDOPIp2ZKANU0tvWPqoaVavxWUixc7KZ97v5f2MhaYNf2e8blSOXI
	 TgmGRwFLB9onJri0NW1QnqQGxBGgU3Ur2T0KLLhlBd17HMU6bYheKiRHA4bhvJtJFz
	 muPtBqMaelkA4id93Nl8AqnvbYy/vqaim06jOLMrpOvnsjXyvCcelQHHi+XagMd3V+
	 c7uXCNoTXz3ONXcgiYqUKboNgDnZeyC2OQ25/MxhNoCUcZtw/uv4+Qk1Sq/Ak/oTzW
	 XrFzfFVUST5ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-4-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-4-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:10:51 +0000
Message-Id: <20260514001052.7F6F5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DA03C53C42D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10453-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The return value of dw_edma_device_config() is ignored, leading to=
 silent failures and state corruption.
- [High] The .device_prep_config_sg callback mutates shared channel state w=
ithout locks, violating atomicity guarantees.
--

commit cc74cf96b36ed28ea1019078a61ff3eac8097031
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Use new .device_prep_config_sg() callback

This commit introduces the .device_prep_config_sg() callback to the dw-edma
driver to combine configuration and descriptor preparation.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..f7f58b0010e26 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, =
struct scatterlist *sgl,
>  	xfer.flags =3D flags;
>  	xfer.type =3D EDMA_XFER_SCATTER_GATHER;
> =20
> +	if (config)
> +		dw_edma_device_config(dchan, config);

Does this need to check the return value of dw_edma_device_config()?

If dw_edma_device_config() returns an error like -EINVAL, the driver will
silently proceed to dw_edma_device_transfer() with the old configuration.

Also, dw_edma_device_config() unconditionally clears chan->non_ll before
validating the new configuration:

static int dw_edma_device_config(...) {
	...
	chan->non_ll =3D false;
	if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
		if (config->peripheral_config &&
		    config->peripheral_size !=3D sizeof(int)) {
			dev_err(dchan->device->dev, ...);
			return -EINVAL;
		}
	...
}

By ignoring the error, the transfer function might calculate bursts_max
incorrectly using a corrupted chan->non_ll flag. I see that subsequent
commits in this series do not appear to fix this missing error check.

Additionally, can this sequence result in a data race if called concurrentl=
y?

When a driver implements .device_prep_config_sg, the dmaengine framework
skips its internal spinlock in dmaengine_prep_config_sg_safe() and delegates
atomicity guarantees to the driver.

However, dw_edma_device_config() locklessly mutates shared channel state
such as chan->config and the chan->non_ll flag.

While a later commit in this series attempts to fix this by passing config
directly to the transfer function, dw_edma_device_config() still mutates
the shared chan->non_ll flag without locks, which is then read by
dw_edma_device_transfer() to determine bursts_max.

> +
>  	return dw_edma_device_transfer(&xfer);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D4

