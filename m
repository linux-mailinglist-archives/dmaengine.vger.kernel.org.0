Return-Path: <dmaengine+bounces-10961-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ13LuTKFWqQbgcAu9opvQ
	(envelope-from <dmaengine+bounces-10961-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:31:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325235D9BB6
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97FE1300B57D
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635403BE148;
	Tue, 26 May 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU1uOv/e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CD3C4B76
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813034; cv=none; b=fwzysBz1Hg+oAm90KSiKqIxT9kzNuLjC0gz/dxmSpqnz/Hi43S2Z6rA6j6uaRoanv6JoUj9tX0lJhsE4ItJ3HA5YcGzuzprFJ4XIQ438YhUDKCNYdtdevSnz59HB/6yrThS8GYJpcnXEYX/6nrXjXsLFdo6V/TwzBOOT6mD+064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813034; c=relaxed/simple;
	bh=afyRj54G4C8v/MwKIXNGpc9wOYhSheiRvneiifQbWjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQgXzQdzROsF39RLiBCBrf5/YaCNaNwBeIc+tryWn6R+EWpkT4hTl8YDBrLXyEf6ASQvGv9VKsyG4EAigc2NvO8plV6jxKtgn4TnwEtICisqIkZow93MJUIO5p1fsieTJ4Cgt6wooJU3w7nK6R6ftOxOgKYow/iM7yt5XfyTjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU1uOv/e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A881F000E9;
	Tue, 26 May 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813033;
	bh=us8tVTFYMK9Gwx4b1efPebw4ep5vFbH/z0FYs1xytzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MU1uOv/eJ5l8SNi5yfiBBOWiFdX2HB6z1BAqfQZYudfFLQRPhiAzc6X4sFvOh5k1m
	 ZEQ2JedX4GnPRFF12wdxTkDFhbjzxndlJJWzyAgMweCTMexRyWwSeeXy4lTWO3tyB3
	 WZND9jiQECHPdQCvdhoDQimZsT1ZUptWXQUhS8rTK0YkewrUR/5Q2aICa4mEa+btlm
	 8Pl5jSjVGvSJk/ryJvd80EhTQNGch+2vpyb89/tJRCIDzs01c1k1y1ufeik7nK8huq
	 E4t1pyyfWKsjhlBYfvlcBpG1BwYStuej2Cmi8oo8JMxCByl9P8jqi+7mbi2ipQ5e79
	 ThoxmixHiMQyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/14] crypto: qce - Map crypto memory for DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-12-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-12-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:30:32 +0000
Message-Id: <20260526163032.E0A881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10961-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 325235D9BB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added DMA mapping is unmapped before the DMA engine is t=
erminated and the workqueue is cancelled, leading to potential IOMMU faults=
 or memory corruption during teardown.

Pre-existing issues:
- [High] Explicit free of devm-managed resources in `qce_dma_terminate` cau=
ses a double-free and memory pool corruption.
- [High] The background completion work is cancelled after its required loc=
k is destroyed and DMA channels are released, potentially causing lock corr=
uption or a use-after-free.
--

commit 0c5470463f2ecb5c08f0a1037a6585137db4fa3e
Author: Bartosz Golaszewski <brgl@kernel.org>
Subject: crypto: qce - Map crypto memory for DMA

This commit maps the crypto memory range for DMA as an initial step towards
converting the driver's register I/O to use DMA.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index a0e2eadc3afd5..d7b7a3dda4649 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
>  	cancel_work_sync(work);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that the
background completion work is cancelled after its required lock is destroye=
d?

Because devres executes cleanups in LIFO order, if the devm cleanup action
for the workqueue (qce_cancel_work) is registered before
devm_qce_dma_request() and devm_mutex_init(), the mutex is destroyed and
DMA channels are released before cancel_work_sync() is called.

If the background work is executing or gets scheduled during this teardown,
qce_req_done_work() might attempt to lock a destroyed mutex and access
already-freed DMA channels, potentially causing lock corruption or a
use-after-free.

[ ... ]

> @@ -255,6 +264,18 @@ static int qce_crypto_probe(struct platform_device *=
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

[Severity: High]
Will this cause the DMA mapping to be unmapped while the DMA engine is
still active?

Since this devres cleanup action is registered near the end of the probe
sequence, devres will execute it first in LIFO order during device unbind
or a late probe failure.

However, because the background work cancellation and DMA channel
termination were registered earlier in the probe sequence, they will
execute later. This means the memory could be unmapped from the IOMMU
while the DMA engine is processing in-flight requests or while the
workqueue can still submit new requests, potentially leading to IOMMU
faults or memory corruption.

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the cleanup
sequence in qce_dma_terminate().

In a preceding patch that converted the driver to use devm_kmalloc() for
dma->result_buf and devm_dma_request_chan() for the TX/RX DMA channels,
the explicit kfree() and dma_release_channel() calls don't appear to have
been removed from qce_dma_terminate().

Calling kfree() on a devm_kmalloc() pointer bypasses the devres allocation
header and corrupts the slab allocator. Likewise, calling
dma_release_channel() on devm-managed channels usually results in a
double-free when the devres framework later runs its own cleanup loop.

> +	if (ret)
> +		return ret;
> +
>  	return devm_qce_register_algs(qce);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D12

