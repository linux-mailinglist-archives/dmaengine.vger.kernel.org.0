Return-Path: <dmaengine+bounces-12003-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MKaTGV3ZRmpWegsAu9opvQ
	(envelope-from <dmaengine+bounces-12003-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:34:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECC6FCFB4
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=foj5yIGc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12003-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12003-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E821302EEA9
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CEC37D131;
	Thu,  2 Jul 2026 21:31:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA63264C7;
	Thu,  2 Jul 2026 21:31:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027882; cv=none; b=iovj65uXLAuj/begDqJ9DpWMyPpE1EMI3cBji3iFSEONu3MSk57/XMKoY8JwMiT4B4MuclHSwEYdTHac2jSnSzlXjU/SnP2hFHW3pvohocpCBaS35GyW9RctdYHWnAV8yEhsLc9ko+kDOe//lmgneb2ncuN1ohK3GQ0yrBBFThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027882; c=relaxed/simple;
	bh=LlhYnzV1pT2T4sp1DPbQwKprrN6AHAzA4zUxMJQxGoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9r+O4Zg4+sKoNjjJVIwspKU73OFW1kwRJha1Kk/fEBapofp3nnWbXSWjLM1XB/ndXB/EZ2ZW1hmbt+NEAKBMne0iW4Ds8O5qaZeonOrpyuCyHBTkz67wW3bOBzZ0RDgLAM3nHQkfWD3fERye3VIP8NCa/I2mTF0ZVeAl6wJres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foj5yIGc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A91F000E9;
	Thu,  2 Jul 2026 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027881;
	bh=kUpZTwnD6/kp6cafFlUIPqH49c1OEK5pPn6xn41gBtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foj5yIGc0ecRWLp3FIvKtYmo3QWt9dwNIxiq8QiTnnai3gr6cQfCFnOz+C3TYS37v
	 645eMLY1UNf8bcH5+hN5ONY9Wau1ewVP/Tk6GoGDATF3egGp1Rto4nvjjddVxXAlMU
	 aA1MJ402tbLfLH3ThO9EzUbrLNTOIFjF7NOQpNSdXc1+H1M7VOVAV7XChxkuCCQ4Sy
	 YW9Tea0q4IPZ3N8KTR6VU6TIr5X5JvKF3mNdgKju534JhOo8umKBnNxoXJZPECCnj/
	 8t779XjC/ZjoWdUvJUyTDQrlJ+wDf4kYTiZ7TDmJRDdDWfbR1UmVtqZFFbHvE6aSMP
	 RmbGs0uxqyCWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-6-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-6-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:31:20 +0000
Message-Id: <20260702213121.0F8A91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12003-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DECC6FCFB4

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `addr` parameter is completely ignored in both the `dw_edma_v0_=
core_ll_link` and `dw_hdma_v0_core_ll_link` callbacks, with the code incorr=
ectly hardcoding `chan->ll_region.paddr` instead.
--

commit b095560e132d78a5d96555e8baeab1d49da1b0c1
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add callbacks to fill link list entries

This commit introduces four new callbacks to fill link list entries and han=
dle
channel operations. This abstraction allows sharing logic between the eDMA =
and
HDMA paths to avoid duplicating code.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 8d38867cd9983..10ad63d7e6016 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c

[ ... ]

> @@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	}
>  }
> =20
[ ... ]
> +static void
> +dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64=
 addr)
> +{
> +	u32 control =3D DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |=3D DW_EDMA_V0_CB;
> +
> +	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);

[Severity: Low]
Could this omission cause a regression if the caller expects the provided a=
ddr
to be used? The callback signature explicitly takes a u64 addr argument, but
the implementation ignores it and hardcodes chan->ll_region.paddr instead.

> +}
> +

[ ... ]

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 31bbdc6a40642..52c6ea09fcab5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c

[ ... ]

> @@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma=
_chan *chan)
>  	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
>  }
> =20
[ ... ]
> +static void
> +dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64=
 addr)
> +{
> +	u32 control =3D DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> +
> +	if (!cb)
> +		control |=3D DW_HDMA_V0_CB;
> +
> +	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);

[Severity: Low]
What about the HDMA implementation? The addr argument passed to
dw_hdma_v0_core_ll_link() is also completely ignored in favor of hardcoding
chan->ll_region.paddr.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D6

