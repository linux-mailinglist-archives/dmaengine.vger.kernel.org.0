Return-Path: <dmaengine+bounces-11855-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUnVKIJGQmot3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11855-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:18:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF76D8CE2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BEDZcGEs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11855-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11855-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F43A303D306
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B403BBFD9;
	Mon, 29 Jun 2026 10:14:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD993603F6
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:14:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728084; cv=none; b=pZqTHJSEYkAtbR+DSL6+ApCujAipLUIHYVKol/fg04ik5e/c3RYg6P61aIAP21t522s59IZMw6btZBjXvfgUcbogWjJ++blh/MUUPMiNBq62XwUX+Y6dgdqxvozrhm6c/AMZ6KRWp7c0Ifve0rr6DEhxaEG+2Ilz27BI0rUHfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728084; c=relaxed/simple;
	bh=Kl3RVeehqETfsRNDXrEWnDAG7f1ZEl+D/JcPEBpD32E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cK3KpiF5UX8MplWVOFKUssqIkAsp6E6QI1iTFbhuXmZp4s6QEeljsKf/1QIHZC3jF1HxnKXQIIJZ6rtQY3Pk/CqvqwmPtkpe5NIfLKBxEyayR+IAxWWRKK2lPkvzvpNX87TfdiY4rYjz+o06dW/e6h1JZ8dkHB2pYqvuwj4/sXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEDZcGEs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230F91F00A3A;
	Mon, 29 Jun 2026 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728083;
	bh=cxzKjVpNkcy/fYMWgs4fJ09r87NIXJ7OPY5BDu6pCEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEDZcGEsEla1PCNNa3r++EuodiOBHy9/evO7PalnThvMYGsJXqhoEn7HPOo859ph6
	 fEeinNKy7jlhV0LHNM0T0URi7dZnFrt0FTq0PY3sBLf26D9thUYXYxBwFmxuAXVzpp
	 H1jI67U04PLuDATuvP/MGKCnSNXqSWIgYF6sNAcJa32B7Iv0kRJQAL+tXQfYj5s3WN
	 ku7qGmU4rXpd65a2F2huZmmtMngOYbxZqFMEXHu9J9EvX9aUOd8Du2SJolSPMhuUd4
	 c63kwZJF7IaV+vY90KU89zFDQlZDTSfA14wgxyqntw4E6cN2+/XwEqgGiFcReqhsAO
	 BB1I9S9Mk96kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 12/14] crypto: qce - Map crypto memory for DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-12-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-12-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:14:42 +0000
Message-Id: <20260629101443.230F91F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11855-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03AF76D8CE2

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The DMA resource for the crypto memory range is unmapped before th=
e DMA channels are terminated during device unbind, leading to a potential =
use-after-unmap.

Pre-existing issues:
- [High] Incorrect algorithm unregistration during probe rollback in devm_q=
ce_register_algs().
- [High] The worker `done_work` can submit new DMA requests during device u=
nbind after the DMA channels have been terminated, leading to hardware acce=
sses with disabled clocks.
--

commit ee076bef79e68732cc680da917ccaf5eb87c11ef
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Map crypto memory for DMA

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index a0e2eadc3afd5..d7b7a3dda4649 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
>  	cancel_work_sync(work);
>  }

[Severity: High]
This is a pre-existing issue, but is the teardown order of done_work safe
relative to DMA termination?

In qce_crypto_probe(), the qce_cancel_work devres action is registered befo=
re
devm_qce_dma_request(). Since devres executes in reverse order, on device
unbind, qce_dma_terminate() runs before qce_cancel_work().

While qce_dma_terminate() cancels pending DMA transfers, it doesn't prevent
new submissions.=20

If done_work runs after qce_dma_terminate(), could it dequeue the next cryp=
to
request and submit a new transfer to the BAM DMA engine?=20

The active engine might then attempt to access unclocked crypto registers w=
hen
devres proceeds to disable the clocks, potentially crashing the bus.

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
Is this devres action added too late in the probe sequence?=20

It is registered after devm_qce_dma_request() has registered the action to
terminate the DMA channels. Due to devres LIFO execution, on unbind
qce_crypto_unmap_dma() will execute before qce_dma_terminate().

If a crypto request is running when the device unbinds, could the IOMMU
mapping for the crypto registers be destroyed while the BAM DMA engine is
still actively accessing them, causing memory corruption or an IOMMU fault?

> +	if (ret)
> +		return ret;
> +
>  	return devm_qce_register_algs(qce);

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be an issue
with the error handling inside devm_qce_register_algs() if algorithm
registration fails.

When it enters the rollback loop, it doesn't update the ops pointer:

drivers/crypto/qce/core.c:devm_qce_register_algs() {
    for (i =3D 0; i < ARRAY_SIZE(qce_ops); i++) {
        ops =3D qce_ops[i];
        ret =3D ops->register_algs(qce);
        if (ret) {
            for (j =3D i - 1; j >=3D 0; j--)
                ops->unregister_algs(qce);
            return ret;
        }
    }
    ...
}

Because ops is not updated to qce_ops[j], won't this repeatedly unregister
the algorithm that just failed to register, while failing to unregister the
successful ones?=20

This could leave algorithms registered after the driver fails to probe,
leading to a use-after-free later.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D12

