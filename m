Return-Path: <dmaengine+bounces-11288-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5zgKAatZJmoSVQIAu9opvQ
	(envelope-from <dmaengine+bounces-11288-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:56:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC3652FC3
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:56:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oTLEsb7E;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11288-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11288-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E16302F71F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E138237B;
	Mon,  8 Jun 2026 05:56:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F473590A9;
	Mon,  8 Jun 2026 05:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898167; cv=none; b=E42eHYMiFtaynLurDFs9e1WpQpmrW1ROCVwdjwNRFsMHomRED3AP/PWOay9gfJOsgBrOaLa/uJek1/Ihkk7lWxbhJg5jxSTzaJdYWDsFSUj9xhP0fNsdgZTMEEefrVYjcFoFkslkXOnrl3V6tZN+gfoODGVhjSThKcySvD6MQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898167; c=relaxed/simple;
	bh=0MdKOXRySoGARuPpCuOczIDb+WVwxAcv6j9Yr+cjKRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NcUBFLhCQNn7CRrT8uK9CIEerCLjWstwJUtc+PubI8Z8/5sYW/ZfNuVuz0hy0Fzs2mup4iD/ObDMxUwwaO0nFmbz1ptw/ER5jRM/MJhYGl2L9CcsCOFV9iBL6Z+DWCSFl5DK+00tVwGPbPKj9wIccdh1iXQ46qUOMpuZGwFwrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTLEsb7E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE061F00893;
	Mon,  8 Jun 2026 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780898166;
	bh=6tTBHhwnLy48LiDCb4fczQwpX7BSRsJ3hkvOsxaWUbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oTLEsb7EE3B35cg5dziOrLCNlD/+xoFSKHn9s4Yuvob0WV4BSru84skz6uIrcWEJv
	 JrrFnHlRKlzT6GtkgDlhndHve9Nf6Um4HOqPNo430WbdGTVdMQKZ6V0A67Miqv4t7j
	 idotGAKg4hE05FXigEK66u3PGMKTGoUgIe4ptQjVxvDM/9W75w4+qeDgT8+a4OqMXe
	 RgNNyutar610xBq3koc+Lp/7G+ECGso8DkaydAyJDGjububoSkywBP1XJ7bB8MNc4e
	 eYShytXK90umG1pBLzuESPmfBkSYCUlRbu0wqW2UL/FmxHHRfyxRmTRRWJYo2vpDFt
	 rLAR+HvPCAN3g==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, kuninori.morimoto.gx@renesas.com, 
 long.luu.ur@renesas.com, Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Subject: Re: [PATCH v6 00/18] Renesas: dmaengine and ASoC fixes
Message-Id: <178089816101.15844.5628352417869771177.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 11:26:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11288-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:perex@perex.cz,m:tiwai@suse.com,m:biju.das.jz@bp.renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:kuninori.morimoto.gx@renesas.com,m:long.luu.ur@renesas.com,m:claudiu.beznea@kernel.org,m:claudiu.beznea@tuxon.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:geert@glider.be,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53BC3652FC3


On Tue, 26 May 2026 11:46:52 +0300, Claudiu Beznea wrote:
> This series addresses issues identified in the DMA engine and RZ SSI
> drivers.
> 
> As described in the patch "dmaengine: sh: rz-dmac: Set the Link End (LE)
> bit on the last descriptor", stress testing on the Renesas RZ/G2L SoC
> showed that starting all available DMA channels could cause the system
> to stall after several hours of operation. This issue was resolved by
> setting the Link End bit on the last descriptor of a DMA transfer.
> 
> [...]

Applied, thanks!

[01/18] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
        commit: 731712403ddb39d1a76a11abf339a0615bc85de7
[02/18] dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()
        commit: 5fbf3a2a3b96ef5810e6e0fbc601f82067629bc5
[03/18] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
        commit: 89975baaa9ea2490b75d69842561a32ca888b7e5
[04/18] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
        commit: 38d4d021228386b8e3fbef2bca5f1e91eacd4fe6
[05/18] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
        commit: 32a69f1487819766d2084ed32b1350b18f971c10
[06/18] dmaengine: sh: rz-dmac: Save the start LM descriptor
        commit: e21aa306e82067457f2297ae56af4c91db86c59a
[07/18] dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
        commit: 7a94c109a5def4f0f25705a82ed5870f794ff4ed
[08/18] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
        commit: 1dddc864dfa844efaf36345eb58b121b2cdffa5f
[09/18] dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing
        commit: daa6d4617bee722e83f7d8584416e83b709c958a
[10/18] dmaengine: sh: rz-dmac: Refactor pause/resume code
        commit: dc86e47ca9b1021e258c366a5a9aa15d71c814a5
[11/18] dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with CHCTRL_SETEN
        commit: e8baee1d1cddc8e2be7bc362d6dc3fcb2021e873
[12/18] dmaengine: sh: rz-dmac: Add cyclic DMA support
        commit: 172bfb57481c65fcc94ebcae3a730f6df2f953d4
[13/18] dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return error codes
        commit: 16ba40151b1e6a52b28296a2173457bc6c31f022
[14/18] dmaengine: sh: rz-dmac: Add runtime PM support
        commit: 7c27a4d54d48d0774518390e4ce6cf3309aac141
[15/18] dmaengine: sh: rz-dmac: Add suspend to RAM support
        commit: c13ce43e70719dead7009e7e708971ba1c447568
[16/18] ASoC: renesas: rz-ssi: Add pause support
        commit: b4d34819a53964648bc53cabaa3ba9890d4fdf9c
[17/18] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
        commit: 9fcaec81ac56c9d2c5d779ffb5a76b622b4d0590
[18/18] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
        commit: cd2d36e8ae61832aaac3bddf5aafdab72821e6b9

Best regards,
-- 
~Vinod



