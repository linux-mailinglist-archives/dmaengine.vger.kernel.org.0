Return-Path: <dmaengine+bounces-10761-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGmZHOyZEGoMaQYAu9opvQ
	(envelope-from <dmaengine+bounces-10761-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:01:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5B5B8B33
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77343004239
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BEF3176FD;
	Fri, 22 May 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jejSvTRy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3215357CFB
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472605; cv=none; b=GniRPOpvbzCXiW4k4g/rcAV9Ay7nAdtvG+UoWvr4PxIcF6+3Y0vuA/D6ml85nYV3QTM5KvKCqy/xiPMDGzJLwlqrwy/EuCPE7WIB7+nkjGI3gqXlhKfw6W2LsSPe6uEAS1dREK/0ZKz5mtzCW1GTXpabVwmzg9m2ZgEV/n4O8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472605; c=relaxed/simple;
	bh=uLFTdiMkU5dQEjx+CblPqgVX3vy/xmLvnSlFSaDhPz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HBp8SXj/MBpJLVBhtbSZrM4ADW+9Uj0C99bSPxpN/QQV4VgAf/nvgOOUC4XLytUPk4+ka14kxNWQ4Yw1O9Ssq5ne8bfw/ZXKPtsmDDbcf1I+LrrZF7UzPP2TqWyD0eP7DyjYIQ9Yos6XywpzbHBoOj3gtyIhxxy+3TZuzcv7fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jejSvTRy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6022E1F000E9;
	Fri, 22 May 2026 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472603;
	bh=wcjGCBUYy2Z4vZ/zxv0u5rToXraK1XSPIuZ1zVYfryw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jejSvTRyH/qRdzXp7fVRXoIYj1zKGCO+AjUAuyLgLB2LrXVbIdrj1UvsPJ8poELNd
	 o70K7GNqAFsEc7cDVcJHPaL/Fyr2c3nAuOJodj2mivdGKwa5eRuslbB3Es7+vhZwTt
	 mru3rneR9+otSnP9oNdfrwyx+5yyq/1UQRdkMJlvpY3ha60QQ4fzZwN2VZRH05El6f
	 VsOQMm7PjMa8fVAQGv7Z5kFx0TNDpHya8c/MHFloSObqH6Q5hYuUU3BDUL7pcj9TUr
	 WvjdS6GIVSbms/mBVXOLlEUuEh05O5kU+5hFNdZ4ycfkPc8QqjXhQ8KtJCTXKYm1rp
	 QKohSQ+9VrpCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 12/14] crypto: qce - Map crypto memory for DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-12-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-12-99103926bafc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:56:43 +0000
Message-Id: <20260522175643.6022E1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10761-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: CAC5B5B8B33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but in the error pat=
h of `devm_qce_register_algs()`, the driver fails to properly unregister al=
ready registered algorithms and repeatedly unregisters the failed one.
--

commit 56e64a8a181facb8444e80e7d550153e25a41208
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Map crypto memory for DMA

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index a0e2eadc3afd5..d7b7a3dda4649 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
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
> +	if (ret)
> +		return ret;
> +
>  	return devm_qce_register_algs(qce);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but in the error path of
devm_qce_register_algs(), the driver fails to properly unregister already
registered algorithms and repeatedly unregisters the failed one.

Looking at devm_qce_register_algs() in drivers/crypto/qce/core.c:

	for (i =3D 0; i < ARRAY_SIZE(qce_ops); i++) {
		ops =3D qce_ops[i];
		ret =3D ops->register_algs(qce);
		if (ret) {
			for (j =3D i - 1; j >=3D 0; j--)
				ops->unregister_algs(qce);
			return ret;
		}
	}

The rollback loop iterates backwards with j, but calls ops->unregister_algs=
()
where ops still points to the currently failed algorithm qce_ops[i].

Should it be calling qce_ops[j]->unregister_algs(qce) instead?

As a result, previously successfully registered algorithms are leaked, and =
the
driver repeatedly unregisters an algorithm that either failed to register or
was never successfully registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-qcom-qce-c=
md-descr-v18-0-99103926bafc@oss.qualcomm.com?part=3D12

