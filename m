Return-Path: <dmaengine+bounces-11040-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEi+AyFJGmoA2wgAu9opvQ
	(envelope-from <dmaengine+bounces-11040-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 04:19:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D4C60AEEC
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 04:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 480BB301AA89
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10C4A32;
	Sat, 30 May 2026 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxYaeuN8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010118A6DB
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107548; cv=none; b=mof8oAEXIdCiptpZbhUd2oIxB3fZXqxkGXg6x9xODZlwH2TtdTLhy5H+SDD0/ECgiub/pR4GQPzvhTL3GttzmPy9c227U+7tSUDSM0mRB4+ckNKSq0CxWSzTKAxS/TgWbps2GEMUOfrKs5o3NLRYTx2wvNeyMrXP3d1M6PGlJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107548; c=relaxed/simple;
	bh=KBy0qZAvJ+hiQNOAsJMIQk14rpayj0tEColT0HbVBBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rofIA145NOnsyftYkgY0Tk+dAnzGPu39zzz2GBY8Yg4eJd0egR5Ajl8RlR0E9jLztggaGkd4EXrUob5+1xRWEt2NsiokiI9OlIPEGhaLqHqoLPWzpCSekJ+h41TsVARRmJM9BQxL4Id99ooAgUVP8l0Qtr/sJRfzSGi3sgVCeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxYaeuN8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C2B1F00893;
	Sat, 30 May 2026 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780107547;
	bh=A1CWsA/2oxkhdYMxf+/KimzS1g8ME52Kshvzv1TX/G4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxYaeuN8vQW7/+sQJxNytWbPVK5gr0R8Ve8US0can/fBSEvMZmekgsYqUQCDQQEIN
	 YX6mAhu4aQeiw5by6RRCPZLjAs79hk/dR2Ac4HRSvucHaXzR1oGQ3N7Xv1aZKSCpmF
	 dRqyQoDzjmBFC8qNcaI+LEy9n8j3B5p1ZVizqxXfSILIk7ytWgT27oEziXHL9kIulf
	 /kR2dX1xfjdyNCPVh7vO7sU9j8+Jftn2rduD6fiDbZ4DlLhs3taMnBBovrzqIP9ue5
	 2IyMgwL1yj95GQHvZVjl5rB+gZ1ssY4DbxjAaTg2FIRogfx6LRTowv9SoctYNoEluK
	 oEINjnGKF+WWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] dma: bestcomm: gen_bd: split struct bcom_psc_params
 from array definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260530012554.68605-1-rosenp@gmail.com>
References: <20260530012554.68605-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 02:19:06 +0000
Message-Id: <20260530021906.99C2B1F00893@smtp.kernel.org>
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
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11040-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 71D4C60AEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inadequate or missing bounds checking on `psc_num` can lead to out=
-of-bounds array access in `bcom_psc_params`.
--

commit c24864efcf21b2526be68d727e70076f6cee258c
Author: Rosen Penev <rosenp@gmail.com>

dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition
   =20
This commit splits the bcom_psc_params struct definition from its array
declaration to resolve kernel-doc parser warnings. It also adds missing
members and marks the lookup table as const so it can be moved to read
only memory.

> diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
> index 8a24a5cbc2633..61b5746e1a972 100644
> --- a/drivers/dma/bestcomm/gen_bd.c
> +++ b/drivers/dma/bestcomm/gen_bd.c
> @@ -254,17 +254,23 @@ EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);

[ ... ]

> -static struct bcom_psc_params {
> +struct bcom_psc_params {
>  	int rx_initiator;
>  	int rx_ipr;
>  	int tx_initiator;
>  	int tx_ipr;
> -} bcom_psc_params[] =3D {
> +};
> +
> +static const struct bcom_psc_params bcom_psc_params[] =3D {

[Severity: High]
This is a pre-existing issue, but does this fixed-size array expose an
out-of-bounds access?

The array strictly contains 6 elements (indices 0 through 5). However,
bcom_psc_gen_bd_rx_init() checks the psc_num index against
MPC52xx_PSC_MAXNUM:

drivers/dma/bestcomm/gen_bd.c:bcom_psc_gen_bd_rx_init() {
        if (psc_num >=3D MPC52xx_PSC_MAXNUM)
                return NULL;

        ...
        bcom_psc_params[psc_num].rx_initiator,
        ...
}

If CONFIG_PPC_MPC512x is enabled, MPC52xx_PSC_MAXNUM can be 12, allowing an
index up to 11 to access the 6-element bcom_psc_params[].

Additionally, bcom_psc_gen_bd_tx_init() appears to perform no bounds checki=
ng
on psc_num at all before indexing this array. Callers like=20
mpc5200_audio_dma_create() can pass an unvalidated cell-index from the
device tree directly into these functions.

Can a malformed device tree trigger out-of-bounds memory reads here, leading
to out-of-bounds MMIO writes when using the read garbage as the initiator
and ipr?

>  	[0] =3D {
>  		.rx_initiator =3D BCOM_INITIATOR_PSC1_RX,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530012554.6860=
5-1-rosenp@gmail.com?part=3D1

