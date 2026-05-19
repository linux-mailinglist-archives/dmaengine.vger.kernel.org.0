Return-Path: <dmaengine+bounces-10554-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHHrCTBsDGo8hQUAu9opvQ
	(envelope-from <dmaengine+bounces-10554-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:57:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC5958019B
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D27D13095601
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16B33CE88;
	Tue, 19 May 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRclahZR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9FE2D0C63
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198742; cv=none; b=BdxfaOAqF3G/1mxY/4/2TmfvARY13SMPqJRosi/zH5JKzNEQPuk7FPeqt9PuouUo8ApFzJj/12yZY4YWVR5DIrYksdtat5ZIDiaWiuDRaO6/m2P/JvegEN5cXTjOi3CnZOwPgexi5ONPHKBCRhv23ye+2Ln1FNx5aVND7YUYV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198742; c=relaxed/simple;
	bh=mwmvHWlmN6ezU5i1Qh2hFYEiHZLZOkreapCmSTq474Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IVFmPDGWMmCA1xCULKxayosuhuKjrjqmipz64MbIXtmVXlwIWYVizqbtSfbBED8JzG8pVXOeLDiEmWqn44pX8Fiab7yHJnZCHvYaODwBsno/C182trzlcBpb7dNAZwCfAc/JyRZmrp/HvPXm398B3g2OSDQ+VqRdbzFww9KOHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRclahZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DB1C2BCB3;
	Tue, 19 May 2026 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198741;
	bh=mwmvHWlmN6ezU5i1Qh2hFYEiHZLZOkreapCmSTq474Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PRclahZR+7BRF5isR0omgd7NwGeaWT9dwI2yjxQPfN7dpnAy/yf+1jM8a724Q4A3X
	 OOg8sZsrrGddgOswyFreMJk5bL/qpyb3jRYhavLuUbeNeS/ePek1WLVji5jPsHTahF
	 ewMKs7nPLmH8Uq0R5DRtk5fs5thKnQfpIKL23ohmp7DRdEv1HoPYzqmUlUODR7AtmP
	 LEnIGTvsHwRrDQdpGHa2flTRhokHYOWdTV5bbEAqcHrLGe8QHP7nbMGpVM/8yIac3M
	 2WQ2euy4vnpjm7EAaye5w/IvyDDQbHxYj1wslKtj/xZ9XY5T8id0IjTKDACqPwgUPZ
	 +vqf+ACvhC27A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/14] crypto: qce - Map crypto memory for DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-12-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-12-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:52:21 +0000
Message-Id: <20260519135221.A7DB1C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10554-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6AC5958019B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect devres registration order causes the DMA memory region t=
o be unmapped before the workqueue is canceled and DMA channels are release=
d, leading to an IOMMU fault or cross-device memory corruption during devic=
e unbind.
--

commit 9ae25e5bbea3d25573282f095abfbb5389db2d09
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Map crypto memory for DMA

This commit maps the crypto memory range using dma_map_resource and adds a
devres action to unmap it during cleanup. This is intended as the first step
in converting the driver to use DMA for register I/O.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 90f44db660617..92e551f4570c0 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c

[ ... ]

> @@ -256,6 +265,18 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	qce->async_req_enqueue =3D qce_async_request_enqueue;
>  	qce->async_req_done =3D qce_async_request_done;
> =20
> +	qce->dma_size =3D resource_size(res);
> +	qce->base_dma =3D dma_map_resource(dev, res->start, qce->dma_size,
> +					 DMA_BIDIRECTIONAL, 0);
> +	qce->base_phys =3D res->start;
> +	ret =3D dma_mapping_error(dev, qce->base_dma);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);

Because devres executes cleanup actions in LIFO order, will this cause
the DMA memory region to be unmapped before the workqueue is canceled and
DMA channels are released?

Looking earlier in qce_crypto_probe(), the driver requests DMA channels
with devm_qce_dma_request() and registers the workqueue cancellation
with devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work)
before getting here.

During device unbind or a late probe failure, the unwinding sequence would
execute qce_crypto_unmap_dma() first.

If a cryptographic request is still in flight during unbind, could the
DMA controller attempt to access the unmapped IOVA before the asynchronous
work is canceled, potentially resulting in an IOMMU fault or cross-device
memory corruption?

> +	if (ret)
> +		return ret;
> +
>  	return devm_qce_register_algs(qce);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D12

