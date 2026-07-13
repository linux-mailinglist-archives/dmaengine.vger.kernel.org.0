Return-Path: <dmaengine+bounces-12393-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZhlG9fmVGpRgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12393-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF0774B870
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oUiiLc+X;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12393-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12393-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D5030ACC9A
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92341C30A;
	Mon, 13 Jul 2026 13:15:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745241C2E8
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948518; cv=none; b=uBUecW7p9hjFBRwmC+mMS7iba6COInFVYkiN0prOPVT1WjA12dbAqOwf/4JHfwPCbT86BPL/OPlgD/2y1X96/1CHxZkATXLd8uYxItGMNKKY+LDhI6ixM8V3sQZr7nNh6Go6pg2zF3+xEdxSm345g+s/L9pcbXOj50vAR2WFgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948518; c=relaxed/simple;
	bh=21Hu/gpd6TFUb6itatnCWnRTVF/3SiTMng95i3hjDg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDb0ST5tSH8sc//zHN6wNbJzgM31j6WOoUxiw/wt3qB0rj+K8GnAFRMjDn6Iz3ppPCVXfyichzGTFNqDEwtvtotywb8IrrMvgbd7n72ToxrvRKo3Vnw90hR9gh5L2CLNDPhWZj1NpXQ8Y4/VsCRmE2pGws1EfQlj5mWQArBVJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUiiLc+X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C91F000E9;
	Mon, 13 Jul 2026 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948517;
	bh=yIPm54EsmtgAE3C+2a8VTxMb/7ex2kTS+BsrtJpy0BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUiiLc+XIc/opS4AVbJlrq8p16Fq1F0PuvDWpJ9O8wCvBvZdnp99HmjmW0OTNPMhK
	 AWYfUmQ3R5zsZ3V09e9tgn8TwnncNpSIqU3rxeAwneqQ6fll3f2/TH5bXI6GTQdGKv
	 hF2lySXyVi1ZrcGQeOAMhGfUjqA2hHyiV6s1IWBCRALbvJeDqao0FXuC7VaUkeiDf8
	 duq6VHQ13t6aRBg3eVah8/mm8kJ2LHjPtgbZ51iRQQA+vsqyZfOPYaXjpDT84TGX6i
	 KvjUTyc9deCoL/eoypnr067euUHUaVdVKeLNbGv/Njzn1onZZbSVa0D8b1O0BMAtL5
	 8sPiCCr6QoRyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 07/14] crypto: qce - Cancel work on device detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-7-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-7-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:15:16 +0000
Message-Id: <20260713131516.D03C91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12393-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,qualcomm.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAF0774B870

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Devres ordering introduces Use-After-Free and Mutex Use-After-Dest=
roy vulnerabilities because the workqueue is canceled after its required re=
sources (mutex and DMA channels) are freed.
- [High] Terminating DMA and cancelling the workqueue during unbind without=
 explicitly completing pending crypto requests causes callers to hang indef=
initely.
--

--- Patch [7]: [PATCH v21 07/14] crypto: qce - Cancel work on device detach=
 ---
commit 4cbda8145d4c325fc75ff4841164bf36bd06014c
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Cancel work on device detach

This commit introduces a devres action to clean up the workqueue on
device detach. It moves the initialization earlier to ensure outstanding
DMA transfers are terminated before the work is canceled.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D7

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index ac74f69914d61..b52a26ffff5ee 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
[ ... ]
> @@ -226,6 +233,11 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> +	INIT_WORK(&qce->done_work, qce_req_done_work);
> +	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);

[Severity: High]
Could this devres ordering introduce a use-after-free and mutex
use-after-destroy during driver unbind?

Because devres cleanup executes in LIFO order, registering qce_cancel_work()
here before mutex and DMA initialization means it will execute last during
cleanup.=20

When the driver unbinds, qce_dma_release() and mutex destruction will occur
before cancel_work_sync() runs. If the worker thread qce_req_done_work() is
scheduled concurrently, could it attempt to lock the destroyed mutex and use
the already freed DMA channels and result buffers?

> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_qce_dma_request(qce->dev, &qce->dma);
[ ... ]
> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 68cafd4741ad3..7ec9d72fd690f 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -13,6 +13,8 @@ static void qce_dma_release(void *data)
>  {
>  	struct qce_dma_data *dma =3D data;
> =20
> +	dmaengine_terminate_sync(dma->txchan);
> +	dmaengine_terminate_sync(dma->rxchan);

[Severity: High]
Will terminating the DMA transfers here cause callers to hang indefinitely?

By aborting the active DMA transfer during unbind, the normal completion
callback won't fire, so qce->done_work is not scheduled. The driver then
cancels the workqueue via qce_cancel_work(), but it does not appear to
explicitly complete the active request (qce->req) or drain qce->queue.

Will callers waiting on these requests block forever when the device is
unbound?

>  	dma_release_channel(dma->txchan);
>  	dma_release_channel(dma->rxchan);
>  	kfree(dma->result_buf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D7

