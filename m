Return-Path: <dmaengine+bounces-12392-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X5VYJIfmVGojgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12392-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:22:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81474B82D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:22:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cK7wM9X9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12392-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12392-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1135F30C7455
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9D420E61;
	Mon, 13 Jul 2026 13:14:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11C41C2F2
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:14:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948491; cv=none; b=sZx8zd63I190hs38/fk+hehE+PsEC8li4QgQvEuEBrJ6slwv6BKNALrHoQZJz3hgOp3kfQhiVd8P//27kquQpDGoQx9oQF38iqUIBD2hTA573ycqIbq77cJDJDIyMyH0bEWlvVsFjYBF9GZZFrXDod65Vez8dhswQOwx78pbbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948491; c=relaxed/simple;
	bh=1tWu0KQWbwbph6LljN7rPz1XWX/Vk43rUjVUgaYOyHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U19EUE5GxRatdCNKomO1IHTVrd7E5uT3moTaTpZIae1YDnzFOKdC0aHWIdGhW5piP4lf6nbcHPHG5hBhfdt7RI+Mwm1gZvbIfA2inEQPQUC8mHb/86dM6IBdfhVKhmDyJPY1OKCrmNUFai+3aLFlD7fJsipC2HqGeuSP12puycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK7wM9X9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70A01F000E9;
	Mon, 13 Jul 2026 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948490;
	bh=UnfMn/t6APs33Xf6KptP0TcehOf99PEEWmEOJdMAoIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cK7wM9X951XDEGifXQ2uAFyYv2cBP4gnajtz4xMwdVlxblj8izvxOn+KX0OcIMlGC
	 qE8BJ3cIRefKWYTJKT5vTAqUTGscLBIY/Op4M4V+a5ANuoA0PtiRjXyZt7CeSRFGHZ
	 ucwy77k0eqzOcy+19xm9U/fQTYuCeZyqoeLev967OdV18NC/TFT1hfKnfhf+5Bm2Cu
	 MPiveEG3cWwa1Jg8/ba3Yu4EHsjVS70uq1uzJG0d64laoaE5iSmBZd4cCva3Vkilrj
	 Bp7cszu15QCLHeojN5ErSChWhlXg2kCd/+FtlNdfrxyoC9P3vREDrsUhYNwnxi9Ohr
	 Ck77vP/6CO3HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 09/14] crypto: qce - Remove unused ignore_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-9-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-9-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:14:49 +0000
Message-Id: <20260713131449.C70A01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12392-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B81474B82D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free of DMA resources during device teardown due to inco=
rrect devres ordering.
--

--- Patch [9]: [PATCH v21 09/14] crypto: qce - Remove unused ignore_buf ---
commit 65a70a3ae148fcccff0fe900df224577ddcc1190
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Remove unused ignore_buf

This commit removes the unused ignore_buf field from qce_dma_data and
relocates the QCE_IGNORE_BUF_SZ macro since it is only used within a
single compilation unit.

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
>  	return devm_add_action_or_reset(dev, qce_dma_release, dma);

[Severity: High]
Does this devres registration order create a use-after-free risk for
dma->result_buf and the DMA channels during device unbind?

In drivers/crypto/qce/core.c:qce_crypto_probe(), the devres action to cancel
the background workqueue (qce_cancel_work) is registered before the DMA
resources are requested here.

Because devres executes actions in reverse order, qce_dma_release() will run
before the workqueue is actually canceled.

During device unbind, qce_dma_release() frees the DMA resources:

drivers/crypto/qce/dma.c:qce_dma_release() {
	...
	dma_release_channel(dma->txchan);
	dma_release_channel(dma->rxchan);
	kfree(dma->result_buf);
}

If the workqueue is actively processing requests or starts running before
qce_cancel_work() executes, it will process the next crypto request in the
queue and call qce_skcipher_async_req_handle().

This function will then map the freed result_buf and attempt to use the alr=
eady
released DMA channels, which can lead to memory corruption or a crash.

> =20
>  error_nomem:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D9

