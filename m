Return-Path: <dmaengine+bounces-11751-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ApGBNhNxOmp09AcAu9opvQ
	(envelope-from <dmaengine+bounces-11751-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:42:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD986B6CEF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iw5inzWi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11751-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11751-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ABEF3007642
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6C379C23;
	Tue, 23 Jun 2026 11:42:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3637B000
	for <dmaengine@vger.kernel.org>; Tue, 23 Jun 2026 11:41:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214921; cv=none; b=hs5agnPGz5APqroc9tscdSLOXIibSCV5VXv26x9SKJ71Zec4hxxSczG2Q9th8x7q/M5sPwlXvnmCqL4XsvwOlKMNmR/vQUlYcoWbfSofjMQRkLt450T5tCZDkbfIqoKYKfkvyhdp0RVUzN5gkgU73Q3FRZ3sFDATaTUDfZcBSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214921; c=relaxed/simple;
	bh=GyP14kNMHb3stHatNESeJaTunpSAqcBe2SpiWtd8Q/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/2Kr3mf2L5tK6kYsPuMYY7SbVuD81oNZ6LO54aDuNE89L34xCkhc79CYlPS4YEkQA3rsexDvnWYvuQQbmNX0auBR1y9EY4J0Iwf8pfLtkdL/Okz7Xc6sgSim7vl4xhhMD7m47I0+gB8icGjYjFQp1tAuClnvSFaHzkQbSD55Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw5inzWi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2003E1F000E9;
	Tue, 23 Jun 2026 11:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782214919;
	bh=fkznw+yNplv4vpiwjCXeqnxB+6sr1R4BHtSNMdAwMao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iw5inzWiaPWcUvdvjmoj+OTp4Ht86CxxdIeilD4lWf9TxqdZviB5vnwfYjKzMvNot
	 3f0SsHc3iHWUh1uME2i7mTaRUVied9NKMcNodAlVNPhiCra5GQ6Kwy8LiuYyFlAF3W
	 hBQCDuD3u22zbtez4IGSJUdiJYADUpwOWR8TG+eBz0Nee2ptxTTfNNINWqxC/A9S+p
	 2pEl5glX0IRxMp0QTHohKxJDlQXuXYTZhi361CybgIX14c0keuAqUFppSQth8Pd585
	 R+21JU3rwqBu4ukDoqXTDMT0ckYeO7xdglsdc/HfAvRLZ3nWjFjmrL2eZabuxK7rrb
	 2GW6vF9iZ0DuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W
 Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260623112647.3379581-1-devendra.verma@amd.com>
References: <20260623112647.3379581-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 11:41:57 +0000
Message-Id: <20260623114159.2003E1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11751-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,amd.com:email,lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD986B6CEF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The 64-channel HDMA feature is unreachable due to hardcoded lega=
cy limits in the driver bindings.

Pre-existing issues:
- [High] Potential NULL pointer dereference if a shared IRQ fires before `d=
w_irq->dw` is initialized.
--

commit ae4f94060e0e6e5d4419cd4f95926541afa41dd0
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This patch expands the designware eDMA driver to support up to 64 read and
64 write channels for the HDMA controller, aligning with the hardware
databook. It introduces new macros for the HDMA channel counts, expands
the layout of the channel-related structures, updates channel masks to 64-b=
it,
and updates the probe sequence to configure the core based on the controller
type.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c2feb3adc79fa..adf1b3939f96c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, =
u32 wr_alloc, u32 rd_alloc)
>  		irq =3D &dw->irq[pos];
> =20
>  		if (chan->dir =3D=3D EDMA_DIR_WRITE)
> -			irq->wr_mask |=3D BIT(chan->id);
> +			irq->wr_mask |=3D BIT_ULL(chan->id);
>  		else
> -			irq->rd_mask |=3D BIT(chan->id);
> +			irq->rd_mask |=3D BIT_ULL(chan->id);
> =20
>  		irq->dw =3D dw;

[Severity: High]
This is a pre-existing issue, but could a shared interrupt fire before
irq->dw is initialized here?

In dw_edma_probe(), dw_edma_irq_request() is called before
dw_edma_channel_setup(). The IRQs are requested with IRQF_SHARED:

dw_edma_probe() {
    ...
    err =3D dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
    ...
    err =3D dw_edma_channel_setup(dw, wr_alloc, rd_alloc);
}

If the shared IRQ fires immediately after registration, the interrupt handl=
er
might dereference a NULL dw_irq->dw:

dw_edma_interrupt_write()
   dw_edma_core_handle_int()
       return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);

Should irq->dw be initialized prior to calling request_irq()?

[ ... ]

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

[Severity: Medium]
Will these expanded 64-channel limits actually be reachable with the current
driver bindings?

Looking at drivers/pci/controller/dwc/pcie-designware.c,
dw_pcie_edma_find_channels() still explicitly enforces the legacy 8-channel
limit and returns -EINVAL if the configuration exceeds it:

    if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
        !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
        return -EINVAL;

Similarly, in drivers/dma/dw-edma/dw-edma-pcie.c, the Xilinx MDB HDMA data
statically declares 8 channels and dw_edma_pcie_get_xilinx_dma_data() caps
the write channels:

    pdata->wr_ch_cnt =3D min(pdata->wr_ch_cnt,
                   FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));

Do the hardcoded legacy limits in the driver bindings prevent the new
64-channel feature from being fully utilized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623112647.3379=
581-1-devendra.verma@amd.com?part=3D1

