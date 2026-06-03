Return-Path: <dmaengine+bounces-11143-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xhBaK4YUIGpMvgAAu9opvQ
	(envelope-from <dmaengine+bounces-11143-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 13:48:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094FB637359
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 13:48:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HzsS9LGa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11143-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11143-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DB130B155D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757AB3ABD88;
	Wed,  3 Jun 2026 11:42:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCA387590
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 11:42:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486939; cv=none; b=i/3NnMerBzSTBqfjI4aN8uj1eln9m+sTqMD4dRfZ1WxpD8NE0ZPzf5UOo+YKGgocwIoK436dNB+7e3kN0nFFRMNNpZVbc3FzJKfuQZIEG8CgvfgTN/d96U4VKn9KghSry5KU+ECDGYMRXcAn/8eeFLwGo89Oc7a6dkxF1qLl0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486939; c=relaxed/simple;
	bh=tWeGBHXg/uhAKQcyQmEIPvK6ZKXeyZMZx+JQFIvof4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aeq9xSL008nAoJmAgzzNg7Zpwx8SAsjxQsPiz19/JRijvcRueul+RzB6yCdXKTu/x3oz/8dlveikLo9Zc0E7OslqQmYdTCikv9gdaszB3CdhVg1I35ScZd1RU2AJ8MV9JFNr6CVHRtx3E/FQM240zrLscwvBK1MiiuptQlnBgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzsS9LGa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C431F00893;
	Wed,  3 Jun 2026 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486938;
	bh=k9Muvu8FwvrzUJ+coPsvNMvCDdw2M2v6Dkar3cmLPS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzsS9LGaOgUlcWBYPe1kdGP1H4s0AUa/8Y1oz44iNVwPLPCw9pqi3EtcabntWUJbF
	 Ov0jk0obEFSrMMrf2t21GKiWx/xW8dO5Tca9Os37GMrPHk1TuMheAP1uxxvj1lNzaO
	 pi1J/YfDefFbPuaDE8TspXKTy6bkMYGQRR5Scb0fFTKanNFYhAv6yyZYBWJomU12UL
	 h8U2y7DkILgNfvlPk1wkk9acfOACaToi9Tnkht4VlE2fSh9W/q+aQE73+RFgg20cEv
	 fTNUB6vsRxHm/p1r0I2/gq31R551RU7PwXJ31n6Om9njXBWZ4beBajhdlzspYmzfoY
	 9SaWUZkCY3wRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260603110628.2807317-1-devendra.verma@amd.com>
References: <20260603110628.2807317-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:42:17 +0000
Message-Id: <20260603114218.06C431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11143-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,amd.com:email,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094FB637359

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Stack out-of-bounds read and channel mask truncation on 32-bit=
 platforms in HDMA interrupt handler.
- [Medium] Incomplete enablement: DesignWare PCIe controller wrapper still =
hardcodes an 8-channel limit.

Pre-existing issues:
- [High] Argument swap when reading channel status causes it to access the =
wrong hardware register.
--

commit 0f2309c78c7292ae29af15b436ce0e4f16f62d96
Author: Devendra K Verma <devendra.verma@amd.com>

dmaengine: dw-edma: Enable HDMA 64R/W Channels

This patch increases the maximum supported read and write channels from 8 to
64 for the HDMA IP. It updates the channel structs, mask types, and probe
function configuration to accommodate the larger number of channels. It also
defines new HDMA-specific macros to reflect the updated channel counts.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index 902574b1ba867..d12fefbf39524 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -91,8 +91,8 @@ struct dw_edma_chan {
> =20
>  struct dw_edma_irq {
>  	struct msi_msg                  msi;
> -	u32				wr_mask;
> -	u32				rd_mask;
> +	u64				wr_mask;
> +	u64				rd_mask;

[Severity: Critical]
Can changing these to u64 cause a stack out-of-bounds read and mask truncat=
ion
on 32-bit platforms?

In dw_hdma_v0_core_handle_int(), the local mask variable is still defined as
an unsigned long:

drivers/dma/dw-edma/dw-hdma-v0-core.c:dw_hdma_v0_core_handle_int()
    unsigned long off, mask;

    if (dir =3D=3D EDMA_DIR_WRITE) {
        total =3D dw->wr_ch_cnt;
        off =3D 0;
        mask =3D dw_irq->wr_mask;
    }
    ...
    for_each_set_bit(pos, &mask, total) {

Assigning the 64-bit dw_irq->wr_mask to the 32-bit local mask variable will
silently truncate the upper 32 bits on 32-bit architectures. Furthermore, if
total is up to 64, won't for_each_set_bit() read past the 4-byte mask
variable into adjacent stack memory, potentially triggering spurious
interrupts or KASAN panics?

[ ... ]

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..d7a3c9a73e9c4 100644
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
This isn't a bug introduced by this patch, but does dw_hdma_v0_core_ch_stat=
us()
pass arguments to GET_CH_32() in the wrong order?

The macro expects the direction first and the channel index second, but it
is invoked as:

drivers/dma/dw-edma/dw-hdma-v0-core.c:dw_hdma_v0_core_ch_status()
    tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
                    GET_CH_32(dw, chan->id, chan->dir, ch_stat));

Will this cause the channel ID (now up to 63) to be used as the direction,
and the direction to be used as the channel ID, consistently reading the
status register of the wrong channel?

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
Does the DesignWare PCIe controller wrapper also need an update to support
the 64 channels?

In dw_pcie_edma_find_channels(), the initialization still checks against
the 8-channel limit:

drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_edma_find_channels()
    if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
        !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
        return -EINVAL;

If a host platform's HDMA IP supports and requests more than 8 channels,
won't this hardcoded check fail and return -EINVAL, preventing the
new channels from being used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110628.2807=
317-1-devendra.verma@amd.com?part=3D1

