Return-Path: <dmaengine+bounces-10558-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAbuEhVxDGpKhgUAu9opvQ
	(envelope-from <dmaengine+bounces-10558-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:17:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86CD580617
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE9F43033F77
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908A4028EE;
	Tue, 19 May 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUc4PXKN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E774028D7
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200260; cv=none; b=fG33k5RDyuIH0dWUadcQzQ/2XZG4Sflw2ArqCMjACK7ozUBKyjiEza9GLoT31M2cLBB5fxPxaRjOdwYxWulDXUGB0VQFJiybWeOCf+bqHWPSTj7mwlDB8M39Evdk/PGkJ3Jnf0Cxg0CuhUzXIjXrYS4wXQXU7DlfPNPNUWeAic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200260; c=relaxed/simple;
	bh=oPWm6QeU7Ez5gidpx9UvJefw79pdupyqpRVsJ23GDi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJ2f4OR0y9Bm46r7+OxOr1EMWOaODFDF8VZTXOUJQ/k1CRRqNUT6uSIsIMxrF1LuAOFJX02TM57pEK35WKKhAVfySAgK/CAZdy6scD2GYZKcKmZlfcdnRoDlUZbyhiqi51vju9/8iZCE1evr9F0UDa1oNRKTJeoVeaXB3z1eP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUc4PXKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB4C2BCB3;
	Tue, 19 May 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200259;
	bh=oPWm6QeU7Ez5gidpx9UvJefw79pdupyqpRVsJ23GDi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mUc4PXKNI2fn63K10KZAXLo1amWms9sW79G1bDYhycaiAxbq4yjvWEej60l1NspBH
	 w3JpZs1VRDdfhOyQaM9JaIMwH32moblOSIv4K0ps/BCu9TJpszM/FIF04a1oS2KXJh
	 KG4BdSZ9arzx1f/2yspf/0u2HnIn4dI8Kc855EWXcubg5iqY5bIVaWX1ompkvg5CFy
	 BChoIDmOIbgDgGyPjb7FOYcbe7x/fx2e1x6FW372rLAwZsbJ1suh7Sg+QifljGh4Q4
	 kzkn3PpX4kUxi49nmckLfJcUJba+IVd2sctmdKsbXyRcxcQDadsT7g+7DwKFpD3ttI
	 namxDvfeAOzRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-14-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-14-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 14:17:38 +0000
Message-Id: <20260519141739.3BAB4C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10558-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: D86CD580617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Passing 0 as the length parameter to `dmaengine_desc_attach_meta=
data()` bypasses size validation.
--

commit 1f893f890dfe69aa8cb0e7aec2e87e8d24b5cdc6
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Communicate the base physical address to the dmaengine

This commit fills out and attaches the BAM descriptor metadata to the DMA
descriptor. This provides the BAM DMA engine with the scratchpad address
for dummy writes related to pipe locking.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index b66e6386fccda..97b0f02c2b4d2 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> @@ -63,6 +68,10 @@ int qce_submit_cmd_desc(struct qce_device *qce)
>  		goto err_unmap_sg;
>  	}
> =20
> +	ret =3D dmaengine_desc_attach_metadata(dma_desc, &meta, 0);

Should this call pass sizeof(meta) instead of 0 for the length parameter?

The generic DMA engine API dmaengine_desc_attach_metadata() expects the
length argument to specify the size of the metadata payload being attached.
While the underlying BAM DMA provider might not currently validate the leng=
th
parameter, passing 0 bypasses this API contract.

If size validation is enforced in the future by the generic DMA framework or
the underlying driver, this could cause the call to unconditionally fail.

> +	if (ret)
> +		goto err_unmap_sg;
> +
>  	qce_desc->dma_desc =3D dma_desc;
>  	cookie =3D dmaengine_submit(qce_desc->dma_desc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D14

