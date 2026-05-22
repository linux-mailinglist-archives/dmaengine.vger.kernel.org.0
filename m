Return-Path: <dmaengine+bounces-10756-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHFYMh+IEGriYwYAu9opvQ
	(envelope-from <dmaengine+bounces-10756-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 18:45:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BAC5B7B26
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E43073007BBF
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03240DFD8;
	Fri, 22 May 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ24mq3n"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E374611CC
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468297; cv=none; b=tVTjSWBotGMeaBSgMCjV0DlL9xpRQbZDiQ2cwy8nUMtY9a59dsnbR9djujUHEKtPXBeu2jAxvRaSWfc/F5s0vVmru30cEuSO/ojqC0OplGQFU5r9p1KEvK0pbP/e7skED0SZ8ifEtKq3z/fmmTdDXpQmsDH9lozeW2AjokcPK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468297; c=relaxed/simple;
	bh=7J7D87B21fTW4dpT6grfg8J/CA4ZV1yexEtO5zELKC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jHBthc24lmwJ8cQakeG3l9wUBBwvZUKFi4Rjpyxudf+aWSIjcJtXsN/wJ6Bpz+wtyBig3Z6f5w0sZpOwgPWzdymHNnobDtC8EndLldfZCqnLxnVAhOPc57EvaC6cpzecAFQ6Fk5EsjK4Fsm+Y2hTgQXqtHYzgAOJH8w05aUTlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ24mq3n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAD01F000E9;
	Fri, 22 May 2026 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468295;
	bh=7WPtJOYFAcdVDdWwwwAqUM/BJDByIJMDE9s4espNTFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQ24mq3nsqkqVz6zOxdQPVLRWFx3K9iSmWyW/ImeGedujdNh4Wc9d9Li2m92BhYly
	 Apaogp1WTRR70l1A25rzS2PStE8ycW+l23bji2QsPEUS8EvhIyYJBiRdsk3fjYXACs
	 +CEBigT7HEah27eg9ayJol0LOP0V3QbONBOHDbk2X/lU268/tYO8Rhh285Jl2c3SgI
	 qjqfBDt9Jw5GJXc/cA2qdA5sYLM9ARp91ub33FtuIEFf1+XnDld0ZHI5HV1o38glLC
	 ca3ArXB3fMxRruZ5x1RjMgfRS4GchiMYNc3+POfTlZD4bjFgIU3oA3DyO5ulRMIjqH
	 2k2H8y8TdZJIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 09/14] crypto: qce - Remove unused ignore_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-9-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-9-99103926bafc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 16:44:54 +0000
Message-Id: <20260522164455.9BAD01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10756-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: 84BAC5B7B26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect devres cleanup order causes a Use-After-Free of DMA buff=
ers and channels on device unbind.
- [High] Uninitialized kernel heap memory or previous request data is leake=
d due to unconditional memcpy in completion handlers.
- [High] Device unbind causes a Use-After-Free of algorithm templates due t=
o non-blocking crypto unregistration.
- [High] Incorrect endianness handling when writing byte arrays to hardware=
 registers using writel() breaks cryptography on Big Endian systems.
--

commit 6a964ad9b9a3d2103655163cd29d62a555e25df6
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Remove unused ignore_buf

This commit removes the unused ignore_buf field from qce_dma_data. It also
moves the QCE_IGNORE_BUF_SZ macro into dma.c since it is not used outside
of this compilation unit.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 68cafd4741ad3..08bf3e8ec1243 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> @@ -41,8 +43,6 @@ int devm_qce_dma_request(struct device *dev, struct qce=
_dma_data *dma)
>  		goto error_nomem;
>  	}
> =20
> -	dma->ignore_buf =3D dma->result_buf + QCE_RESULT_BUF_SZ;
> -

[Severity: High]
This is a pre-existing issue, but could uninitialized kernel heap memory or
previous request data leak into request contexts if hardware or the DMA
engine fails to process a request?

Since dma->result_buf is allocated via kmalloc() just above this, its
contents are uninitialized. In completion handlers like qce_ahash_done() or
qce_skcipher_done(), the driver seems to copy data out of result_buf
unconditionally before validating the operation status with
qce_check_status().

Should this buffer be allocated with kzalloc, or should the status be
checked before copying?

>  	return devm_add_action_or_reset(dev, qce_dma_release, dma);

[Severity: High]
This isn't a bug introduced by this patch, but does the devres cleanup order
cause a use-after-free of DMA buffers and channels on device unbind?

In qce_crypto_probe(), the qce_cancel_work cleanup action is registered via
devm_add_action_or_reset() before devm_qce_dma_request() is called.

Because devres actions execute in reverse order during unbind,
qce_dma_release() frees the DMA channels and result_buf first. Then
qce_cancel_work() calls cancel_work_sync(&qce->done_work).

If the workqueue is executing concurrently, might it attempt to use the
already freed rxchan, txchan, or result_buf?

[ ... ]

While reviewing this, I also noticed a couple of other pre-existing issues
in the driver:

[Severity: High]
This is a pre-existing issue, but is it possible that device unbind causes a
use-after-free of algorithm templates?

During device teardown, algorithms are unregistered using
crypto_unregister_ahash(&tmpl->alg.ahash), which only removes the algorithm
from the active list and decrements the reference count.

The template is then immediately freed with kfree(tmpl).

Since crypto_unregister_ahash() does not block until all active TFMs are
destroyed, might existing TFMs retain dangling pointers to the freed
template memory?

[Severity: High]
This isn't a bug introduced by this patch, but will passing a __be32 value
to writel() result in incorrect byte orders on Big Endian systems?

The driver formats keys and IVs into an array of __be32 words using
qce_cpu_to_be32p_array(). These arrays are then cast to u32 * and passed to
qce_write_array(), which uses writel() to write each word.

Because writel() expects host-endian values, it implicitly performs a
cpu_to_le32 byte-swap.

Does this implicit swap break the engine's functionality on Big Endian
configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-qcom-qce-c=
md-descr-v18-0-99103926bafc@oss.qualcomm.com?part=3D9

