Return-Path: <dmaengine+bounces-12365-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X5R9CkePVGpAnQMAu9opvQ
	(envelope-from <dmaengine+bounces-12365-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:09:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D810747CFD
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RkbZegGe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12365-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12365-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34563020A76
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B7E3546C9;
	Mon, 13 Jul 2026 07:07:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B535F170
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 07:07:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926472; cv=none; b=aYrE0MxPkh6k62+xkREogjc6C74kG3tMFpeLnqHz50hVaJWP6uy4D8Oas+RL8og4D8rGSuIjxVahjfZihGoVgZfrOYuMRWJeg8Yd4wto4MhwDYBVIQl22BvHkLLezBCm7Gvg0WK36oj0+lO8oyEQsNonN9Bfa0uC+WDfTian77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926472; c=relaxed/simple;
	bh=3oNqO/SbayrPL9YVI3QxD9UPfK8GIMj2NbXDoEOSCwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h5vqpZH++tSqOcWS8vHs9I40xAa8IA0Hg+Pi8wCelBMyhosuYZTUbGwopKCQXIO/tPni3v1fG465u5ykrb442IKiMG1PBTJinzFY3dr4kP0t7UQOAEsi0cVVDdLC2ixe5JdJI6uFgX0E3R0Gu+1nHYzpkgQCYndBD9Aucjbx4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkbZegGe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13091F000E9;
	Mon, 13 Jul 2026 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926471;
	bh=E8cGtnklDcLDr0BDquFG3OWODmYgCmEwjbtwI430QIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RkbZegGe6rBCUMRFhjDZubpHaLo7Qmgw78SWdziDYF8bNNqo411HMZr/yx/lxR0M6
	 1wH1Sc8nwn2Q1DpQ6HMzxU9nbiWTyESmSA/r59Ccuvy/GdJK7RSmI8Ag1U1KU/CJbx
	 5f0nrx4TB77kY5e23LMcf6VLqBDKMbmcD3EPdUs2LZ2KHiUSQ9Gq0iyM79haQIqIVD
	 VmnhVhbiOAsYbviQbdoBu+ejCKjJ1+zYOkAGhc+BEdPj1UO7HcE9z8za+e9lCmrYCk
	 1JXCOIngifF9ym1ilfXel/NqXaR4fuurPXI5wAVY0ewxzSUnLWGklR6lwdbicaVLV9
	 x2dI97zVi28Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713064854.4065262-1-devverma@amd.com>
References: <20260713064854.4065262-1-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 07:07:50 +0000
Message-Id: <20260713070750.D13091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12365-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D810747CFD

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The DesignWare PCIe controller frontend fails initialization for p=
latforms attempting to use 64 HDMA channels due to hardcoded legacy channel=
 limits.
- [Medium] The dw-edma-pcie endpoint driver silently caps dynamically detec=
ted channel counts to 8.

Pre-existing issues:
- [High] A race condition during initialization causes a guaranteed NULL po=
inter dereference if a shared or spurious interrupt occurs early.
- [High] Incorrect argument order in dw_hdma_v0_core_ch_status leads to inv=
alid register reads, breaking DMA status reporting.
--

--- Patch [1]: [PATCH v8] dmaengine: dw-edma: Enable HDMA 64R/W Channels ---
commit 639271379db4829feeac5972fb5074c44780d440
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This patch introduces support for up to 64 read and write channels in the=20
DesignWare HDMA controller. It defines new macros for HDMA maximum channel=
=20
counts, updates data structures, and transitions bitmasks to 64-bit bitmaps=
=20
to accommodate the expanded channel limits.

> Changes in v3:
>   o Reverted the FIX for AI reported GET_CH_32() issue, as
>     per the recommendation of reviewers, need to create
>     separate patch for it.

[Severity: High]
This isn't a bug introduced by this patch, but does the incorrect argument=
=20
order in dw_hdma_v0_core_ch_status() still lead to invalid register reads?

When the DMA status is checked, dw_hdma_v0_core_ch_status() calls GET_CH_32=
()=20
with the channel ID and direction swapped:

    tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
            GET_CH_32(dw, chan->id, chan->dir, ch_stat));

The macro evaluates the numeric channel ID as the direction and uses the=20
direction as the channel index, which breaks DMA status reporting.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, =
u32 wr_alloc, u32 rd_alloc)
>  		irq =3D &dw->irq[pos];
> =20
>  		if (chan->dir =3D=3D EDMA_DIR_WRITE)
> -			irq->wr_mask |=3D BIT(chan->id);
> +			bitmap_set(irq->wr_mask, chan->id, 1);
>  		else
> -			irq->rd_mask |=3D BIT(chan->id);
> +			bitmap_set(irq->rd_mask, chan->id, 1);
> =20
>  		irq->dw =3D dw;

[Severity: High]
This is a pre-existing issue, but does this initialization sequence leave a=
=20
race condition that causes a NULL pointer dereference if a shared interrupt=
=20
fires early?

In dw_edma_probe(), dw_edma_irq_request() calls request_irq() with IRQF_SHA=
RED=20
while dw->irq[i].dw is still NULL.

If an interrupt fires immediately after registration,=20
dw_edma_interrupt_common() executes and dereferences dw_irq->dw to call=20
dw->core->handle_int. This will dereference the NULL pointer before=20
dw_edma_channel_setup() finishes initialization here.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -62,11 +62,11 @@ struct dw_edma_pcie_data {
>  	/* eDMA registers location */
>  	struct dw_edma_block		rg;
>  	/* eDMA memory linked list location */
> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];

[Severity: Medium]
Does the dw-edma-pcie endpoint driver silently cap dynamically detected=20
channel counts to 8, defeating the purpose of the 64-channel support?

During probe, dw_edma_pcie_get_xilinx_dma_data() reads the channel count fr=
om=20
the hardware VSEC but caps it using the static template limit:

    pdata->wr_ch_cnt =3D min(pdata->wr_ch_cnt,
                       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));

Since pdata is initialized from xilinx_mdb_data which statically defines a=
=20
maximum of 8 channels, the dynamically read channel count is bounded and=20
will never exceed 8.

> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
> =20
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64

[Severity: High]
Will the DesignWare PCIe controller frontend fail initialization with -EINV=
AL=20
for platforms attempting to use 64 HDMA channels?

When an HDMA platform is probed, dw_pcie_edma_find_channels() in=20
drivers/pci/controller/dwc/pcie-designware.c still uses the legacy=20
EDMA_MAX_WR_CH limit:

    if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
        !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
        return -EINVAL;

Additionally, dw_pcie_edma_irq_vector() rejects requested IRQ numbers=20
that are greater than the legacy maximums:

    if (nr >=3D EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
        return -EINVAL;

This artificial cap at 16 seems insufficient for platforms using the new=20
64-channel support.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713064854.4065=
262-1-devverma@amd.com?part=3D1

