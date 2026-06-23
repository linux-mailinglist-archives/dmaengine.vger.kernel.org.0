Return-Path: <dmaengine+bounces-11750-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fFAkCnFwOmo49AcAu9opvQ
	(envelope-from <dmaengine+bounces-11750-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:39:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B667A6B6C7C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NUUb+0IS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11750-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11750-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3413A303CED3
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9E3B42D3;
	Tue, 23 Jun 2026 11:39:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A9379C23
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 11:39:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214767; cv=none; b=Xs5OI7j98V3QT5n5gOL7WKfRwAYvTF1bf6bZSBAFhQmfRBSti+Zo/YQZEM64TUb+fcSStUekduOi2JqOABZlUrKM63XxvGB03bV016hSNlUBRF4p8nK6VRroMrp/crJ4mz58RnNsEAmI1gOO2QAwTvOAGpLGg09bZrFRxc7K9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214767; c=relaxed/simple;
	bh=gfKYbYmk7H4Bq7S8qC+rGecaGMuYhBmx1Sq/vjbBL14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VltbvNooVI7VmFz5H9id9DxcjUWeZYWZ42MjeKmfbL9oBjYyGCtDbwrKYepaZZMwC94ngUBR5sQ3nBYSqYPJGyZu1KHL8my3s8VQzU9ubdtrcVexPHEs/MJuzBF0s9KVgTIDmOXoYd1owg4bSNGK623KsoOb/UG9NkGBcfWD9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUUb+0IS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F001F000E9;
	Tue, 23 Jun 2026 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782214765;
	bh=Qff12oRlviH/YiAclsLPqk/FgmZf5XLbOiIn8P1zHIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUUb+0ISK/5JRYBYyh/JlSuH8HlPdwgYyeQHH5e4ErO9gCOreL/SdmnPeo3JGasjV
	 nylMgkQx/kYJlaQDl73E16RqgkqYg97Ccs1MtXiRplQoobClmHTW2k8HWCAAa+4Ftx
	 sby4o3x5N7M4fzhvDyBgbLSttD/uMNwqLU89gEicD1MOR4FnztTwFn+VFDf6BoZm/m
	 DPJkZIGzT+AKyDfI6JCqGRBnHsxwxm81SwicgSl6R7YKO0c8UFy3od6spRUBUOYBF8
	 6cwm1gjxYZuAhSy++LVG/n82N8oL0PkFGxWFmg8/cjXNbBtDUv11bah9B8Z0u/sQwV
	 5LZC/UF/RskWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W
 Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260623112308.3377168-1-devendra.verma@amd.com>
References: <20260623112308.3377168-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 11:39:25 +0000
Message-Id: <20260623113925.65F001F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11750-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B667A6B6C7C

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incomplete hardware reset during initialization leaves unallocated=
 active channels unmasked and uncleared, leading to an IRQ storm.
- [High] The patch claims to enable 64 channels but fails to update integra=
tion layers, leaving hardcoded 8-channel limits that prevent utilization an=
d break probing.

Pre-existing issues:
- [High] The GET_CH_32 macro is called with swapped `dir` and `ch` argument=
s in `dw_hdma_v0_core_ch_status()`, reading the wrong register.
--

commit 973288f2abf5c733055723f7bd6942953badd2e0
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This patch updates the dw-edma driver to support 64 read and write channels
for HDMA. It defines new macros for the maximum channel counts, scales up
internal data structures, and changes channel masks to 64-bit types to
accommodate the increased capacity.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..79f653da8e0fd 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -61,11 +61,11 @@ struct dw_edma_pcie_data {
>  	/* eDMA registers location */
>  	struct dw_edma_block		rg;
>  	/* eDMA memory linked list location */
> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
>  	/* eDMA memory data location */
> -	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		dt_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		dt_rd[HDMA_MAX_RD_CH];
>  	/* Other */
>  	enum dw_edma_map_format		mf;
>  	u8				irqs;

[Severity: High]
Does this successfully enable 64 channels if the integration layers still
enforce an 8-channel limit?

For example, in drivers/pci/controller/dwc/pcie-designware.c
dw_pcie_edma_find_channels() checks against EDMA_MAX_WR_CH:

    if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
        !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
        return -EINVAL;

And in drivers/dma/dw-edma/dw-edma-pcie.c dw_edma_pcie_get_synopsys_dma_dat=
a()
clamps capabilities to defaults:

    pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
                             FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val=
));

If a device actually reports 64 channels, won't probe fail immediately
because the PCIe wrapper bounds checks against EDMA_MAX_WR_CH (8) instead of
HDMA_MAX_WR_CH (64)?

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..84b0076f78bf0 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir=
, u16 ch)
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> +	enum dw_edma_dir dir;
> +
> +	dir =3D EDMA_DIR_WRITE;
> +	for (id =3D 0; id < dw->wr_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
> +	}

[Severity: High]
Can changing this loop in dw_hdma_v0_core_off() from a fixed hardware maxim=
um
to the software-allocated count dw->wr_ch_cnt lead to an IRQ storm?

If a bootloader or previous kernel instance leaves channels greater than
dw->wr_ch_cnt active, won't they remain unmasked and unhandled?

Because dw_hdma_v0_core_handle_int() bounds the interrupt checking mask:

    while (mask) {
        pos =3D __ffs64(mask);
        if (pos >=3D total)
            break;

Any unallocated active channel might repeatedly raise hardware interrupts
without ever being cleared.

[Severity: High]
This is a pre-existing issue, but in dw_hdma_v0_core_ch_status() in
drivers/dma/dw-edma/dw-hdma-v0-core.c, does the GET_CH_32 macro have the
arguments swapped?

    tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
                    GET_CH_32(dw, chan->id, chan->dir, ch_stat));

The GET_CH_32 macro expects (dw, dir, ch, name). If chan->id is passed as d=
ir,
won't __dw_ch_regs() evaluate dir as non-write (0) for any channel ID great=
er
than 0, causing it to always read from channel 0 or 1's read registers?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623112308.3377=
168-1-devendra.verma@amd.com?part=3D1

