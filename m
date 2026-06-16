Return-Path: <dmaengine+bounces-11546-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZmtH1C4MGpkWgUAu9opvQ
	(envelope-from <dmaengine+bounces-11546-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 04:43:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2168B86B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 04:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hAbZTP1r;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11546-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11546-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62AD3300680F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ABA3ABD98;
	Tue, 16 Jun 2026 02:43:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F83C13FC;
	Tue, 16 Jun 2026 02:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577803; cv=none; b=OD1u3YFJy72PuLsA7+zRcJ2N1fy17hGQE6KCG1wcuosX+juMyHs9LGjtX0FtrxPO9RZxXfn/lgiW7B9Q0LDTALHojro8u/i50W5NG7Mf+M3tB6JpVUeLJbl9bIi+Rt0/++xnwB6Ps1+0fyvXmoHnJIxwvpdwX2s8curExs38IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577803; c=relaxed/simple;
	bh=RqtLDnK1LArrCVjXTRJR1zG4sIFb29GBLPlQ85tB5yI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=luvvqPyC5BTTnG43i7D/oT/fk1kzlv4NvGhQFawO3RMczCCVr/B8THOzOZkWXoFv+6+Ipoi+j57bIhePOPB8N0MEkVd1GWv1jsEgDy67f4oUbmm+xwHJ9v5Chl6OhXU6sheZznvw8ErlBoYDM2dIjmaTkANJygelSLO156LJLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAbZTP1r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6691F000E9;
	Tue, 16 Jun 2026 02:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577802;
	bh=n3KFIERD7hFiSqQxH3xMgFz4YZgYmrfttHqpqbxh6fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAbZTP1r+RqgzTfLP8c85etkwxJBcPs0+ZLMI0l6F78U1qdfJncAbPWlqgp7SInqe
	 JhZxwwfIY5vCzTVlBVRPKFwwPW9Cib+JjzPNWdCKn/LdhvZgkKAAlUGq62CoBRxwEx
	 E7B7+oAv0RcKdD58oH/LN4vDGTO3WeOl8FM+X/+FkfsX9nhHYaRaNDEx2NTxl+5/Oy
	 2PT8qeeM8d18tBdKMYJZnEhBElCnJi54oJRoLOBZjaGUa3jLCGoKjy0JnvLYaFH7a9
	 Bn1RcSkAChzfvhyc6nTF1O0W0NWCluU88q3c/7zbJoZjRja4m0Ty5vwh3jLImN7TwA
	 x9cwKvm5O/Bew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260616023138.15904-1-zenghongling@kylinos.cn>
References: <20260616023138.15904-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:43:21 +0000
Message-Id: <20260616024321.BF6691F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11546-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:linux-sunxi@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70B2168B86B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak in `sun6i_dma_terminate_all` for active non-cyclic des=
criptors.
--

commit 81994b3beae8e2aae413048bdddddd1fbb74bec0
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix use-after-free in error handling paths
   =20
This patch fixes a use-after-free during the error handling path of
sun6i_dma_prep_slave_sg and sun6i_dma_prep_dma_cyclic. It replaces an
unsafe manual loop traversal with a call to sun6i_dma_free_desc(),
which safely stores the next pointers before freeing the current LLI.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..7a79f346250a5 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c

[ ... ]

While looking at this driver's descriptor cleanup, I noticed a separate
issue in sun6i_dma_terminate_all():

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all()
	if (vchan->cyclic) {
		vchan->cyclic =3D false;
		if (pchan && pchan->desc) {
			struct virt_dma_desc *vd =3D &pchan->desc->vd;
			struct virt_dma_chan *vc =3D &vchan->vc;

			list_add_tail(&vd->node, &vc->desc_completed);
		}
	}

	vchan_get_all_descriptors(&vchan->vc, &head);

	if (pchan) {
		writel(DMA_CHAN_ENABLE_STOP, pchan->base + DMA_CHAN_ENABLE);
		writel(DMA_CHAN_PAUSE_RESUME, pchan->base + DMA_CHAN_PAUSE);

		vchan->phy =3D NULL;
		pchan->vchan =3D NULL;
		pchan->desc =3D NULL;
                ^^^^^^^^^^^^^^^^^^
[Severity: High]
This is a pre-existing issue, but does this leak the active non-cyclic
descriptor?

When a non-cyclic transfer is aborted, pchan->desc is not added to the
desc_completed list (unlike cyclic transfers). Because it was already
removed from the desc_issued list during sun6i_dma_start_desc(),
setting pchan->desc to NULL here seems to permanently orphan the
descriptor and its associated LLIs, leading to a memory leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616023138.1590=
4-1-zenghongling@kylinos.cn?part=3D1

