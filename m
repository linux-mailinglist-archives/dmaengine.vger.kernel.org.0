Return-Path: <dmaengine+bounces-10557-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFQxOExtDGpKhgUAu9opvQ
	(envelope-from <dmaengine+bounces-10557-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:01:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ABB5802FA
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C60E3048769
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514DD4028CD;
	Tue, 19 May 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekP+CaB0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED814028CA
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199227; cv=none; b=VDEZXHa9UmIz2+/yFiIUCEbNd5cu6if95kKOTYXp86xj2QdZzE9uv6V3/zksBnya9gyOG8vfAtFZENPtkP4DgaBasYOAbr5KPhM87bXMBP49fvTnGKav7fMO9yTAKSTBSNecJEQ3xXWZsoWYOX25gHZLAvukZLxzEOqiTHaXlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199227; c=relaxed/simple;
	bh=Lkv4FkzYe52kJzX0OJux4qOxTKCc69EBDWVrPfeRBow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3ELdNiGRkpqoailNXCB3kKjJ716S6mUVcOpFHUeRGCxWzusy1wh+xZ6UYDc2VYEG4J3EGqSANtJlZGi/w1WAAVii6lW6qVjA5CIdFb+901bXNwHVgcf8icYACTIxGSoPRdK95Z4O4Z9GjXHrf1RETX2FvAxUwRQNF9ebytPtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekP+CaB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DA9C2BCC7;
	Tue, 19 May 2026 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779199226;
	bh=Lkv4FkzYe52kJzX0OJux4qOxTKCc69EBDWVrPfeRBow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ekP+CaB0VZaNHcAeB99l6ZmUWJYE+JNjU53HGr0Rri1Qa4xyji3IzLCfhBonZCGN1
	 12c6xRFmOkELAaYvHIz4aiOHkkjD8hmXPBZntm1zEyUjv3BKeNT8oDqEOFPyWWXS7Z
	 pf7ZGX94IP1zOSDQkZUBIaGZYnLTWr36V5UChB2Olj/qHUJDU1MQSD0bRi+ip/zhFg
	 rMuPqkqJt7QJJKauyrJmIESsDyM15FWmpUsahgt8LqsmDADkzC77lYuX92mvseA1FZ
	 CvTe92p9qZwxcARs9c6pzdnVrfPd0lp4nvpf+SZ8zTrZOjCZCmhmk5gJCQ1cGkWhnf
	 TirexE9QEbsxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-11-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-11-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 14:00:25 +0000
Message-Id: <20260519140026.76DA9C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10557-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 81ABB5802FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing explicit DMA channel termination during devres unbind =
causes Use-After-Free and Memory Corruption.
--

commit 70443e1ff257db05490919ac891065820eb4d755
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Use existing devres APIs in devm_qce_dma_request()

This commit switches the DMA channel requests and memory allocation to use
devres APIs, allowing the removal of explicit error handling and cleanup
routines.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index c29b0abe94453..3db46fc0c419a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
[ ... ]
> @@ -12,47 +12,26 @@
> =20
>  #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
> =20
> -static void qce_dma_release(void *data)
> -{
> -	struct qce_dma_data *dma =3D data;
> -
> -	dma_release_channel(dma->txchan);
> -	dma_release_channel(dma->rxchan);
> -	kfree(dma->result_buf);
> -}
> -
>  int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma =3D &qce->dma;
>  	struct device *dev =3D qce->dev;
> -	int ret;
> =20
> -	dma->txchan =3D dma_request_chan(dev, "tx");
> +	dma->result_buf =3D devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BU=
F_SZ, GFP_KERNEL);
> +	if (!dma->result_buf)
> +		return -ENOMEM;
> +
> +	dma->txchan =3D devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->txchan))
>  		return dev_err_probe(dev, PTR_ERR(dma->txchan),
>  				     "Failed to get TX DMA channel\n");
> =20
> -	dma->rxchan =3D dma_request_chan(dev, "rx");
> +	dma->rxchan =3D devm_dma_request_chan(dev, "rx");

Does relying solely on devres for cleanup leave active DMA transfers running
during device unbind?

While this code simplifies the cleanup path, devres will automatically free
result_buf and release the DMA channels during unbind. However, releasing
an active DMA channel without first calling dmaengine_terminate_sync()
violates the dmaengine API.

If an unbind occurs while a transfer is in progress, could the hardware
continue writing to the newly freed dma->result_buf and corrupt memory?

Additionally, the work cancellation routine (qce_cancel_work) is registered
via devres after these DMA channels are requested. Since devres unwinds in
LIFO order, the work is canceled before the DMA channels are released. If
a running DMA transfer completes right after qce_cancel_work finishes, could
the DMA completion callback execute and unconditionally call schedule_work(=
)?

Since the work cancelation phase has already passed, this newly scheduled
work would not be canceled, potentially leading to a use-after-free when
devres proceeds to free the qce structure.

> +	if (IS_ERR(dma->rxchan))
> +		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
> +				     "Failed to get RX DMA channel\n");
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D11

