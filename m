Return-Path: <dmaengine+bounces-10460-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLYEL44uBWrITAIAu9opvQ
	(envelope-from <dmaengine+bounces-10460-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 04:08:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58E53CEF4
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 04:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24243301A40D
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44D3290B8;
	Thu, 14 May 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blK2AmRG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901632570D
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724491; cv=none; b=DGPYAM9qJ3pT3yPLCXtAhYQmQb0ERjf+GhnIMiTSkH4K5xJ7sCoDJtlTAca+yEtZE7IWVO4BxK/ni96Szh9mvfYpZHlfpo+NfVoTBeFB7AUfP8mFoz2N7YSuw3Emjo/UGVpSIWiaXM/nvabMntYWKEU0tWUwymXuVlN5dLNqD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724491; c=relaxed/simple;
	bh=KLBCpPkR33CaltGVJ2QISbt/fPIw9KRuFoLO0v8Q12k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFvjHqv6Kev4BhR0EkHMNWcPHv+WXrUfBYI++YsUW6ltIO4jY1PCVrolj/y4TJaE175+LsttsY5ZGV6G0HEBVLzAEmKeQMu+ToC1XS6jL57efCtAdSlb4zLtoyq1l6jW2TePhwUavE9OHq0vMtQw+6fZPH4tx1YqPyMCC0cSfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blK2AmRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B47C19425;
	Thu, 14 May 2026 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724491;
	bh=KLBCpPkR33CaltGVJ2QISbt/fPIw9KRuFoLO0v8Q12k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=blK2AmRG7TSCbirH/dO3ztWedCuP3vuGNozdFSna6uvmdvf6jn2EBFiuejGv6BGQv
	 PlCbIxuPEWh8ND5ofmD1GNNeAwHssevokhOm4iWMihGFt5B4klVleRSheXOUizAA0Z
	 WB+0y6QR1b41wY2PbQTwLVlI606K8wzvRDd/Fn2I6xxBLZZqfzdz9ywCy7/wHTeyHG
	 VnOd8B+Lkfiot2TADGwuNGOZw2q9glVefQZ8mGnBd8hyzB0G6BTeJ04Pu64aACZl/c
	 fl4YVgQWjK8UJQuyYG4cwd2/WcNLFtgE3hcqAf/LZ8qamwaUjgXGnI0zR2oQPhx/i+
	 avNNY5KQygEKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add runtime PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:08:10 +0000
Message-Id: <20260514020811.32B47C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3C58E53CEF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10460-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,renesas.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Early returns on runtime PM failure bypass critical software clean=
up, causing resource leaks and Use-After-Free
- [High] `rz_dmac_tx_status()` returns a negative integer instead of a vali=
d `enum dma_status`
- [Medium] Silent DMA queue stall in `rz_dmac_xfer_desc()` on PM failure
- [Medium] `rz_dmac_tx_status()` incurs unnecessary PM locking overhead for=
 software-only status queries
--

commit 537bc713380d43d1dfa0d61269accb53a834436d
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Add runtime PM support

This commit protects driver exposed APIs with runtime PM suspend/resume
calls before accessing HW registers. The changes avoid accessing HW
registers after a failed system suspend leaves the runtime PM state
improperly reinitialized, preparing the driver for suspend-to-RAM support.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d6ad070be705c..df91657fd5e3d 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct =
rz_dmac_chan *channel)
> =20
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>  {
> +	struct dma_chan *ch =3D &chan->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(ch->device);
>  	struct virt_dma_desc *vd;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;

Does this return early without pulling the descriptor from the queue? If PM
acquisition fails, it seems the descriptor is left permanently stranded on =
the
virtual channel's issued list, and the channel queue could silently stall.

[ ... ]

> @@ -549,6 +557,12 @@ static void rz_dmac_free_chan_resources(struct dma_c=
han *chan)
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	struct rz_dmac_desc *desc, *_desc;
>  	unsigned long flags;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;

If the runtime PM acquisition fails, does returning early bypass all subseq=
uent
software state cleanup like vchan_free_chan_resources() and freeing allocat=
ed
DMA descriptors? Even if the hardware cannot be accessed, shouldn't the
software-allocated resources still be freed to avoid memory leaks?

[ ... ]

> @@ -697,8 +711,15 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_a=
ddr_t buf_addr,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	unsigned long flags;
>  	LIST_HEAD(head);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;

Similarly, does returning early here skip clearing the virt-dma lists? Fail=
ing
to do so could leave orphaned descriptors active, which might lead to
use-after-free issues when the client subsequently frees its DMA buffers.

[ ... ]

> @@ -909,8 +935,15 @@ static enum dma_status rz_dmac_tx_status(struct dma_=
chan *chan,
>  					 struct dma_tx_state *txstate)
>  {
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	enum dma_status status;
>  	u32 residue;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;

Is it valid to return a negative integer error code directly as an
enum dma_status? Client drivers might check the status against specific
enumeration constants like DMA_ERROR, and could fail to recognize this
raw error code.

Also, does this add unnecessary PM locking overhead on the hot path for
software-only status queries? Since dma_cookie_status() might resolve the
status entirely in software, and hardware residue is only queried if the
status is DMA_IN_PROGRESS and txstate is not NULL, could the PM acquisition
be deferred until after verifying that reading the hardware residue is
actually necessary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D13

