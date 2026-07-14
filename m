Return-Path: <dmaengine+bounces-12452-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id twiBEGG5VWoPsAAAu9opvQ
	(envelope-from <dmaengine+bounces-12452-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D1750CBC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XsAXIDb8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12452-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12452-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2783041795
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8932C375A;
	Tue, 14 Jul 2026 04:21:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1411277007
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 04:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002910; cv=none; b=PGzsz4P0to83f7unQ25TxTwWC8DnUZxnXljrYfw/CO1h+Ir6eK4KnaaHnfhDLe7zwKPbTK5UTdg4lfyqBuPNb5yo1DyBEqcknIhdOgjzS6NmJTJH+TgE8nN3MUVD8BGAC8AQXp3kSch6R2YYdw2O9Ct+Ubb+Ca7NGEniOZSV2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002910; c=relaxed/simple;
	bh=sva238LVPDhSVQznaD+l+V/lLqTr1lYOnfNe/H7RDlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l1ZDwcCLz3qPrVsE4iVplmS8ffH1SwP62QQPAgaOy4hBnfpNtTgVNqTaLIEbQAOoDViAqq1umFhXB5uorqmfEbQFu+rmJMF/muqyYYgp02iw21iSRzYXRjfETW8OTECIzfDmWjPKYfxhsaBAphI5P2WGRU1VGNVkawitGknnPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsAXIDb8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3091F00A3A;
	Tue, 14 Jul 2026 04:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784002909;
	bh=3Tf91fXPLKeJF9t4862QXhQAk5jhgSbE4kqnk8evttw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XsAXIDb80+sSxS9liiKUVHbsEYXu5n5cq1ds1sa5aJpuV/GI2AlWr8sVG52dnjBqx
	 gS+ojvfB2sji/Gxb/4AO9tJPa5ZVmsl3TQn2hdsObT/sLlw106dEQ78VUs7Sk1kMmM
	 crOQ5ctcHW7t9SYyQbOChHhZZkSaHkMy9osrrouP0wrwgRA2jQN9DWcLrXI+FAAN9M
	 fH6DEj1hzd/Zi92nt8uFQGLr+MC+E9N5UnpitckmNF0BaveDj+oBWRv9jeWoZ9Lxxp
	 nIFL+DpM39wXaNVpl4Y9zHXPYdBC7lK/tpfpvLZLSlyinwxmbHvgnndabbuQ6lpMGX
	 WKTMvP/pfY2Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] crypto: iaa - avoid counting fallback decompression
 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Costa Gomes" <vinicius.gomes@intel.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 04:21:48 +0000
Message-Id: <20260714042149.5F3091F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12452-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 911D1750CBC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing DMA API violation: software fallback (`deflate_generi=
c_decompress`) writes to the destination scatterlist while it is still mapp=
ed for DMA (`DMA_FROM_DEVICE`), leading to silent data corruption when unma=
pped if SWIOTLB or confidential computing is active.
--

--- Patch [3]: [PATCH 3/4] crypto: iaa - avoid counting fallback decompress=
ion bytes ---
commit 589e7e250edf8839b3b071db5475eb3581825d01
Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

crypto: iaa - avoid counting fallback decompression bytes

When decompression falls back to deflate-generic after an analytics
error, the request no longer completes through IAA. Move decompression
byte accounting into the successful IAA completion path in both the
synchronous and asynchronous flows so decomp_bytes only reflects bytes
actually processed by IAA.

> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
> index fb154959c2aa8..8f68b1478476e 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -1084,15 +1084,17 @@ static void iaa_desc_complete(struct idxd_desc *i=
dxd_desc,
>  		}
>  	} else {

[Severity: High]
This is a pre-existing issue, but does calling deflate_generic_decompress()
in the error path just above this block violate the DMA API?

In iaa_desc_complete(), if check_completion() fails with IAA_ANALYTICS_ERRO=
R,
the driver falls back to software decompression:

drivers/crypto/intel/iaa/iaa_crypto_main.c:iaa_desc_complete() {
    ...
    ret =3D deflate_generic_decompress(ctx->req);
    ...
err:
    dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DEVI=
CE);
    ...
}

Because the scatterlist is still mapped for DMA, won't dma_unmap_sg()
overwrite the CPU's decompression work with the bounce buffer contents
if SWIOTLB or confidential computing is active?

>  		ctx->req->dlen =3D idxd_desc->iax_completion->output_size;
> +
> +		if (!ctx->compress) {
> +			update_total_decomp_bytes_in(ctx->req->slen);
> +			update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
> +		}
>  	}

[ ... ]

> @@ -1475,16 +1477,16 @@ static int iaa_decompress(struct crypto_tfm *tfm,=
 struct acomp_req *req,
>  		}
>  	} else {

[Severity: High]
This is a pre-existing issue, but is there a similar DMA API violation here?

In iaa_decompress(), the synchronous path executes the software fallback
and returns to the caller:

drivers/crypto/intel/iaa/iaa_crypto_main.c:iaa_decompress() {
    ...
    ret =3D deflate_generic_decompress(req);
    ...
out:
    return ret;
}

Does this mean the caller will subsequently unmap the scatterlist and
unknowingly overwrite the fallback's data when SWIOTLB is active?

>  		req->dlen =3D idxd_desc->iax_completion->output_size;
> +
> +		/* Update stats */
> +		update_total_decomp_bytes_in(slen);
> +		update_wq_decomp_bytes(wq, slen);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-iaa-crypto=
-fixes-zswap-v1-0-65cac23c684d@intel.com?part=3D3

