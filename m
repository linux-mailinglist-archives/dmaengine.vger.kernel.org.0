Return-Path: <dmaengine+bounces-10959-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L2BNMHEFWoAagcAu9opvQ
	(envelope-from <dmaengine+bounces-10959-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:05:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBAB5D9474
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDB830854EA
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC60395AE7;
	Tue, 26 May 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozG3mbVL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81639478F
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811064; cv=none; b=B5caVj/WABUPSYlJj0aowoxmK8evgOZTV8s4TnEo3RRfePt7S61Vb1wgSevlvtM2p5x40Vyhfa9BH4I4rn83IzCIc6UTmmuy2nYd5LFaTmxhmfJFWBiDI2K2ztjacsZ3MxNAZq+2LD6+i9UODLUire4PiSiDEkKXdaTpSSUtmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811064; c=relaxed/simple;
	bh=FFXo4Iry3vIgOlbstzQyfGfKil2pDKlbtu7JNDku8+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIjfZ3O3uohiXX7ViC9KkXMzmYsaXE1C7i51P+qkEHn2jSHran4dlAkuNNC7fqPgTwxm8UI6GdJk0SEm+p3pvYUbimKB4HOfk/tAmhw8z7pt1mh5tv5kt0iozqQyF9KIlfyzuFftFeSdQGSXO7hEG/5FM5/hbgdb2pdmcmWt8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozG3mbVL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F431F000E9;
	Tue, 26 May 2026 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811059;
	bh=khp0zdlHxtb0TbwopC91vCz40Hto5fO/4sgc/p/no2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozG3mbVL88fcT3CY0o+RnHXzRE2kKqsXzCPzJRIFOcxEr5AfxS3h2GQKj7lc5e5GM
	 MzICFudXO4lsnbrCWPrYMwA9+y4ohhvWqSONtkLXHsCl16uAcBuuZqt++gnSlqhO93
	 cZ6jGrtdOh+OvCaJyeBsvzBnF/lZIOOP3L4g1n4x784jb0k4GwLigw3nkbbZ9Llm9Z
	 CNTGHRYmUW/osJjfhZMe7tAHeGP6bF65rHd7G5SXP8kYKVsxV0jOe1ZE9P5uOe+/st
	 leTQ7nLp9Jt1PyULFdqbq+W3dRBVDA6rrBcFuavOaL/T78X0TsJgGl9AzBEWrmzUR1
	 hWHEb0BCVBXUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/14] crypto: qce - Remove unused ignore_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-9-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-9-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:57:38 +0000
Message-Id: <20260526155738.D9F431F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10959-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 4EBAB5D9474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The asynchronous workqueue accesses freed DMA channels, freed =
memory, and a destroyed mutex during device teardown due to incorrect devre=
s registration order.
- [High] The driver leaks uninitialized kernel heap memory or previous cryp=
tographic results to user space when a hardware error occurs.
- [High] Sensitive 3DES key material is copied to a stack buffer but is not=
 explicitly zeroized before the function returns.
--

commit d001aa784f83034e2199faf1b8d96703d4ecbbb7
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Remove unused ignore_buf

This commit removes the unused ignore_buf pointer from the qce_dma_data
struct and moves the QCE_IGNORE_BUF_SZ definition directly into dma.c
since it is not used outside of this compilation unit.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 7ec9d72fd690f..d1daa229361aa 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> @@ -43,8 +45,6 @@ int devm_qce_dma_request(struct device *dev, struct qce=
_dma_data *dma)
>  		goto error_nomem;
>  	}
> =20
> -	dma->ignore_buf =3D dma->result_buf + QCE_RESULT_BUF_SZ;
> -

[Severity: High]
This is a pre-existing issue, but does the allocation of result_buf risk
leaking uninitialized kernel heap memory or stale cryptographic results to
user space?

In devm_qce_dma_request(), result_buf is allocated with kmalloc() without
the __GFP_ZERO flag. During asynchronous request completion in
qce_ahash_done() and qce_aead_done(), the driver appears to unconditionally
copy the digest, authentication tag, or IV from these buffers to the caller=
's
output buffers (e.g., req->result) which often map directly to user space.

If a hardware error occurs and the BAM DMA fails to write to the result
buffer, wouldn't this copy operation expose uninitialized heap memory or
previous request data before qce_check_status() can handle the error?

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free
during device teardown related to the devres registration order here.

If qce_crypto_probe() registers the devres action to cancel the
asynchronous workqueue (qce_cancel_work) first, and then calls
devm_qce_dma_request() and devm_mutex_init(), won't the teardown happen
in reverse order?

During device detach, the LIFO devres execution would destroy the mutex
and free the DMA channels and buffers before actually canceling the
workqueue. If a DMA callback schedules qce->done_work just before DMA
termination, could qce_req_done_work() execute concurrently during
teardown, attempting to acquire the destroyed qce->lock and using the
freed DMA resources?

>  	return devm_add_action_or_reset(dev, qce_dma_release, dma);
> =20
>  error_nomem:

[ ... ]

> diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
> index 31629185000e1..fc337c435cd14 100644
> --- a/drivers/crypto/qce/dma.h
> +++ b/drivers/crypto/qce/dma.h

[ ... ]

> @@ -31,7 +30,6 @@ struct qce_dma_data {
>  	struct dma_chan *txchan;
>  	struct dma_chan *rxchan;
>  	struct qce_result_dump *result_buf;
> -	void *ignore_buf;
>  };
> =20
>  int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
cryptographic operations I noticed an issue in qce_aead_setkey() and
qce_des3_setkey().

Sensitive 3DES key material is copied into a local stack array
u32 _key[6] to check for weak keys. However, the _key array doesn't
seem to be explicitly zeroized using memzero_explicit() before the
function returns.

Does this leave sensitive cryptographic key material on the kernel
stack, potentially allowing it to be leaked through subsequent
uninitialized stack reads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D9

