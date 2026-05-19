Return-Path: <dmaengine+bounces-10553-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJRNA6FqDGo8hQUAu9opvQ
	(envelope-from <dmaengine+bounces-10553-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:50:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1A580016
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0135305CB9C
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B23ED3A5;
	Tue, 19 May 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iylfxz3i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AA39D6DD
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198523; cv=none; b=qittxYUoOMafelq4BE16B277vVcREyna1WmDVT/Yc5eWC1LzDW0u9aLA6hFz8he5Fpyt+FSSqAar4OgJeNmbpl4WmPKseR7YE780oG09vQktg7dwnOFAOckQpwy08/Ee8/sbs09LoAPn52aNcGRebp+7dXWnrzOGYrS0PTV/zGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198523; c=relaxed/simple;
	bh=3mTAX3gg7xWAAELRKrnbF7uZS0riBSLTv+e0FZknT68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bxs1aTtvRi8JAZwE3bBks1PoQFeJj1pgfzNeHQMvBlnu7NaGjqR4Oi9mhTXADQofp57Ovy+DGm3iBduSFQBdLMkc2Y/wn82mL9UaqQsP5jxBgB/rD1+gQAO9uPIE/7saxNU1sJ5O70BzqMXBVUFYXe6VDKaG6VbhnfRoQ4V9uL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iylfxz3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A6AC2BCB8;
	Tue, 19 May 2026 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198523;
	bh=3mTAX3gg7xWAAELRKrnbF7uZS0riBSLTv+e0FZknT68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Iylfxz3itJIAP69aqju9wKrPYpvcX+Ri1TpxalWbMu8O9OAOZhMrpiSp4b9DwT9Zi
	 OiEkRrS9/9pvdmVzig3gFiEorSxCAnLOzqbBD8xvblmhOUDqOCNtx9ZC8iihLgzDuv
	 UwEijRPHn3WIxYNKcftME0jh8xzVjrjlRUNFFVVgim9u006Myp72gAoqTK15/+EGji
	 D+lILdiWv1NKKenOxJjP2hMjPLXfyGOEUkQgMhlIAt/PENEwcQmDVCjWLkaPsxeHO2
	 kDq07ElUl78ql5J+9Jh8Ej+wC35qh6wR10xVzzEdS9A8YtaKpnz5zrscJWcm6Iqi1/
	 h8Fn54ryi/EzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/14] crypto: qce - Remove unused ignore_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-9-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-9-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:48:42 +0000
Message-Id: <20260519134842.D7A6AC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10553-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 38B1A580016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] qce_dma_release() frees the DMA channels and result buffer wit=
hout explicitly terminating in-flight background DMA operations.
- [Critical] The surrounding error rollback loop in devm_qce_register_algs(=
) uses the wrong loop variable, leaking registered algorithms and causing s=
ubsequent UAF.
--

commit 86b6706b62fa03437f8e5e0bdb45e4e4d945b1d3
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Remove unused ignore_buf

This commit removes the ignore_buf field from struct qce_dma_data and the
assignment in devm_qce_dma_request() because it was unused. It also moves t=
he
QCE_IGNORE_BUF_SZ macro definition into dma.c since it is only used locally.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 68cafd4741ad3..08bf3e8ec1243 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -9,6 +9,8 @@
> =20
>  #include "dma.h"
> =20
> +#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
> +
>  static void qce_dma_release(void *data)
>  {
>  	struct qce_dma_data *dma =3D data;

While reviewing this code, I noticed a pre-existing regression in
qce_dma_release().

When the driver is unbound, devres cleanup calls qce_dma_release(), which
drops the DMA channel references via dma_release_channel() and then frees
dma->result_buf.

Since dma_release_channel() does not stop active DMA transfers, could the B=
AM
DMA engine continue to write data to the newly freed result_buf if a crypto
request is in-flight?

Would this lead to a use-after-free and memory corruption?

Should the driver explicitly call dmaengine_terminate_sync() before releasi=
ng
the channels?

[ ... ]

I also noticed another pre-existing regression in devm_qce_register_algs()
regarding the error rollback loop.

When ops->register_algs(qce) fails at index i, the rollback loop correctly
counts backward with j =3D i - 1, but it appears to fail to update the ops
pointer to qce_ops[j].

Does this result in repeatedly calling unregister_algs() for the failed
qce_ops[i] instead of the successfully registered algorithms?

If probe fails and devres frees the device memory, is it possible these
leaked algorithms pointing to freed memory cause a use-after-free when
accessed by the crypto subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D9

