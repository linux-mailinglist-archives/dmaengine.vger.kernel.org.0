Return-Path: <dmaengine+bounces-12117-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zYYHNatZTmpzLAIAu9opvQ
	(envelope-from <dmaengine+bounces-12117-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 16:07:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42A727195
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 16:07:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GT5ed4ip;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12117-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12117-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C99F30B52AB
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B63F1ADB;
	Wed,  8 Jul 2026 13:59:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF03FFAB0
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 13:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519192; cv=none; b=D5tj0f5sjOQ3cjeVjHKTHtS+ZgHiuTi2amrbwPutj3Msjul294WTRJfuXJNsCji6ZExQqvv0Kb7bcWLbCcWRn7yLuFAkEo49LLfn37W8VsXCie3VJnJjbs7btgWr2K7B5vYYMHIvneXa9qrZ0JbURnckd6yffscmacE3wmo/XEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519192; c=relaxed/simple;
	bh=yIar/Pj3JD/D5X8hoT5Ydec3mIYpnjlCUk8KiJU85HA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3c83Tz9o4extmfNtdqcEpgv5cluNj8gc4Ejt+ABy2ufxH1eKIWAvSEjvB1DM8SBkAu60nO/IPINQipLjp6R0M/65zB2dWGaV//J63ape3a4SPViPGAygdeEk+Ma7cpT8MYI15FzTLbnqkKk2nVztixLQdu4F8RsJki9c3b0AZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT5ed4ip; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEEF1F000E9;
	Wed,  8 Jul 2026 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519191;
	bh=najBX2Dff9j6carmjGpgoXxWFdpg6vy/jeydv94RzFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GT5ed4ipDbp2I6n62BAKav1CNWU8zMtV3mBmIarX613T3xhgYhR2EkpYybs+7JX0y
	 S/BcHsplEBfnnYpBTl5lvfj4FjfPLJkUMZ3Q+ax5T80yOddAxPN3tOtL7KQcUzoyO+
	 hJW4yRk/fMDFMUIbdef1iIco1h2AfQM++bGfvY/Z9AxiWQwrvEXmnRDrBO4u3V500w
	 9dKlR4bd7v42OQn7YfTJ5c9jMYBdKQeMgm0m3gLdoFSJSPOYoiTiYfF0uEPEvvEmLF
	 XTTtl+XcSAO0i6zmQ138xmWwtLrOJjWiZ+8D02sduKCw+X1XBRv8qbs6Osb0NrPTkN
	 p7OxehiFJGA/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260708134343.3806759-1-devendra.verma@amd.com>
References: <20260708134343.3806759-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:59:50 +0000
Message-Id: <20260708135950.DEEEF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12117-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D42A727195

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Designware PCIe core bounds checks reject HDMA configurations with=
 more than 8 channels.
- [High] Standalone PCIe eDMA driver statically limits hardware to 8 channe=
ls.

Pre-existing issues:
- [Critical] Missing register offset when setting the eDMA/HDMA base regist=
er pointer.
- [High] Incorrect arguments passed to GET_CH_32 macro causing wrong channe=
l registers to be accessed.
--

--- Patch [1]: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels ---
commit 4834a312ef82b7f9b290aedb3a1f566db2548955
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

As per 'Designware Cores PCI Express Controller Databook',
Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
channels. Current controller driver supports up to 8 read and
write channels only. In order to utilize all the channels the
controller driver need to have the channel related structs
and variables as per the number of channels supported by IP.
Following changes are made to enable 64 Read / 64 Write
channel support:

> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e3153..da7a5cc93ad43 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
> =20
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64

[Severity: High]
This patch introduces 64-channel support for HDMA, but does this break
when used with the Designware PCIe host driver?

Looking at drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_edma_find_c=
hannels():

	/* Sanity check the channels count if the mapping was incorrect */
	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
		return -EINVAL;

And in dw_pcie_edma_irq_vector():

	if (nr >=3D EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
		return -EINVAL;

Will these sanity checks reject HDMA configurations with more than 8 channe=
ls
because they strictly enforce the EDMA_MAX_WR_CH (8) limit?

[Severity: High]
Does the standalone PCIe eDMA driver statically limit the hardware to
8 channels?

Looking at drivers/dma/dw-edma/dw-edma-pcie.c:

static const struct dw_edma_pcie_data xilinx_mdb_data =3D {
...
	.wr_ch_cnt			=3D 8,
	.rd_ch_cnt			=3D 8,
};

And later in dw_edma_pcie_get_xilinx_dma_data():

	pdata->wr_ch_cnt =3D min(pdata->wr_ch_cnt,
			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));

Doesn't the min() operation cap the dynamically detected hardware channel
count to the static limit of 8, negating the new 64-channel HDMA support
on Xilinx MDB controllers?

[Severity: Critical]
This is a pre-existing issue, but is there a missing register offset when
setting the eDMA/HDMA base register pointer?

In drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe():

	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;

Should this map the whole PCIe BAR but also add vsec_data->rg.off to
chip->reg_base? Because all register accesses via __dw_regs(dw) directly
dereference chip->reg_base, will all reads and writes hit the beginning
of the BAR instead of the actual hardware registers on hardware where
rg.off is non-zero?

[Severity: High]
This is a pre-existing issue, but are the arguments to GET_CH_32
swapped here?

In drivers/dma/dw-edma/dw-hdma-v0-core.c:dw_hdma_v0_core_ch_status():

static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
{
	struct dw_edma *dw =3D chan->dw;
	u32 tmp;

	tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
			GET_CH_32(dw, chan->id, chan->dir, ch_stat));

The GET_CH_32(dw, dir, ch, name) macro expects the direction as the second
argument and the channel ID as the third. Here it is invoked with
chan->id as the direction and chan->dir as the channel ID.

Since chan->id is evaluated as the direction, won't any channel ID > 0 be
treated as a READ direction? And won't chan->dir restrict the accessed
channel index to 0 or 1, meaning it will always read the status of channel
0 or 1 instead of the intended channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708134343.3806=
759-1-devendra.verma@amd.com?part=3D1

