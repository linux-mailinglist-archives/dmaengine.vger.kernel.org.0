Return-Path: <dmaengine+bounces-10466-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCL3Fi5cBWomVQIAu9opvQ
	(envelope-from <dmaengine+bounces-10466-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:22:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A016253DFBA
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F93301DCF0
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D61EA7F4;
	Thu, 14 May 2026 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n53ulXcK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF68381C4
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736171; cv=none; b=cEFrWSAHGEsCejtz3NVNhhrNiK7k8wr0tppbOzoi+YFuxNR96N2n+HVIfx8Iv79WMDpe8mcVEzhDQAxLe10PDLtXzRKlYHQ3ZBmZ2RfjMs3oBr18udGNgJtWZJIQfORiRo7EVmimgA4fjA6YuCDd6KrKi7hL4hwMQUr6ooGZcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736171; c=relaxed/simple;
	bh=Z7Rej0t+scEX5LH5L1LVDC17Ep+1HkwqXUHRXPusmHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GG/K2c/XHytNfhJFGTF/FRqQT4ctjBuA8HRo+BMQfpmyCikVx39m8mgTX2XTp249VRmGeNXRDNuBdGsmjkxg29A/7jj7WvrYLlN5f/IIKr57pnuzT4YHROA2GnsK1ZED80SeqGfkWG5QWtiOC3f/zVkiF696oNprpFAEmRynyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n53ulXcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7ADC2BCC6;
	Thu, 14 May 2026 05:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736171;
	bh=Z7Rej0t+scEX5LH5L1LVDC17Ep+1HkwqXUHRXPusmHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n53ulXcK8tP14kscvFU2DSpg64wf1gA+mu2nwn5+jjYVS/1RfDkEZjGyXfubz3xu0
	 IkdxogJhAlJTl2qLM2r4dToPHSvP3axMUaQAvPgqGyEXf4sAwbPnOegl13913sEnVW
	 d2u8AuusubPb7CHQUHbinb4w0vKX49C0OlqsTVuY0H26WN3FvSLvQnJG+3fOBIrb2D
	 fSIMYHvnIoMWdMawbo3D8Sd6PFbajp0pmPVsXzI4FWW83ctmxFUPmm7Q80zO4/8lhH
	 6p9SosWCSthLy1jy1s+xBriUj2WYtNraR29U6vkZ9PhUvmba9o0fOKiq06lrehM7sY
	 Kv1jmS4fSBDVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] dmaengine: sh: rz-dmac: Set the Link End (LE)
 bit on the last descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260512121219.216159-18-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-18-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:22:49 +0000
Message-Id: <20260514052250.9F7ADC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A016253DFBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10466-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing bounds check on `sg_len` in `rz_dmac_prep_slave_sg()` lead=
ing to hardware descriptor ring overwrite and silent data corruption.
--

commit a98e7dbe1a1cc544a92a491414810a97272d12ae
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor

This commit modifies the RZ/G2L DMA driver to set the Link End (LE) bit
on the last descriptor of a transfer. This informs the DMA engine that
the transfer is finished, preventing it from loading invalid descriptors
and halting without raising an interrupt.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -425,7 +426,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
>  		lmdesc->chext =3D 0;
>  		if (i =3D=3D (sg_len - 1)) {
>  			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
> -			lmdesc->header =3D HEADER_LV;
> +			lmdesc->header =3D HEADER_LV | HEADER_LE;
>  		} else {
>  			lmdesc->chcfg =3D channel->chcfg;
>  			lmdesc->header =3D HEADER_LV;

Does this code safely handle scatterlists that are larger than the hardware
descriptor ring?

If a DMA client submits a scatterlist with more than DMAC_NR_LMDESC (64)
segments, the initialization loop wraps around and overwrites the beginning
of the descriptor ring:

    if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
            lmdesc =3D channel->lmdesc.base;

Because this update unconditionally applies the HEADER_LE bit to the final
segment (i =3D=3D sg_len - 1), an oversized scatterlist would cause the last
overwritten descriptor to receive the HEADER_LE bit.

When the DMA engine starts, it executes the first few overwritten segments
and prematurely halts when it encounters the misplaced Link End bit, droppi=
ng
the rest of the segments without raising an error.

Should rz_dmac_prep_slave_sg() check for sg_len > DMAC_NR_LMDESC and return
NULL to avoid data corruption, similar to how rz_dmac_prep_dma_cyclic()
explicitly checks if periods is greater than DMAC_NR_LMDESC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D17

