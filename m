Return-Path: <dmaengine+bounces-11123-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +USvOG/cHmrmWQAAu9opvQ
	(envelope-from <dmaengine+bounces-11123-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 15:36:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE362E8D4
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 15:36:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cWxipr1D;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11123-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11123-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 026A93094341
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167933E1D17;
	Tue,  2 Jun 2026 13:30:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E03233941;
	Tue,  2 Jun 2026 13:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407054; cv=none; b=i4mFyqlV4VWuZgAJABEttyBatww1cN+FnBWaKqpqk9D1I2QA3qwnBRbtGB35lY2y/qnmHbME0jsH8+FRL5kwXomxvrGa+pdwrWn0KuWimya1OHSYoh5mjojHwnfzyKQwhqo5SmOlVNk3X33qNG8C8uDIv+0TC2MV39wJUP3SJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407054; c=relaxed/simple;
	bh=WnoCYYY2O9xdTYGKzcRY4YVB5VH1xlhm+ELi8P1QuIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0YXY6UqTjyo8JB/89gFaDfr2GJzQcdQkSCcQIV/n7aN9fusrLGhY5EA7HlsESenweLVQTFrtl673nfcocAeAdUSodaK6MQAylMhzKHCyup242eT9lObmVBZ31vYfISumTQitPLkSoq+6C+kA+e/lfaD3KE77qkw/5cNYnlcLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWxipr1D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1501F00893;
	Tue,  2 Jun 2026 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407052;
	bh=LPGoqrF6mb31SwqNmGzzMqxaVZZ8znhqb4FkUA/VCz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cWxipr1D62ketjcWQHp6nNED2Wmoompy3wuVag1agy1YlyiB3s4WiamHmW6b8d8f3
	 1yD2BRNTAteW7+MDmYHZRdfdHf8du/YyVlmwrm4qRyJtqow/sSmgUcFDpVWuw+MtvR
	 araYop00eGUzJNx31nuneRZZMJ6HwEv2tEORdQVbyiSgQZ5tixZKF5zkRNIHb2GqIZ
	 zSW/gqMAycpZrGfVqoT+YKOytAN9Zbfz+56EtCx4WW8941NAJO//JeqgrHQLtalpb4
	 ysqff86AgezehekBpCTN58qCIdOtrfdMpiGQgHQi5LhQNDgWhsa3X/18M3jaT8F4NC
	 WXIXczCGQBnIg==
Message-ID: <8bfee508-9d3e-47ef-8542-cda6cf28847e@kernel.org>
Date: Tue, 2 Jun 2026 16:30:47 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/18] Renesas: dmaengine and ASoC fixes
To: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11123-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:perex@perex.cz,m:tiwai@suse.com,m:biju.das.jz@bp.renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:kuninori.morimoto.gx@renesas.com,m:long.luu.ur@renesas.com,m:claudiu.beznea@tuxon.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:geert@glider.be,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACEE362E8D4

Hi,

Gentle ping on this series.

Thank you,
Claudiu

On 5/26/26 11:46, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series addresses issues identified in the DMA engine and RZ SSI
> drivers.
> 
> As described in the patch "dmaengine: sh: rz-dmac: Set the Link End (LE)
> bit on the last descriptor", stress testing on the Renesas RZ/G2L SoC
> showed that starting all available DMA channels could cause the system
> to stall after several hours of operation. This issue was resolved by
> setting the Link End bit on the last descriptor of a DMA transfer.
> 
> However, after applying that fix, the SSI audio driver began to suffer
> from frequent overruns and underruns. This was caused by the way the SSI
> driver emulated cyclic DMA transfers: at the start of playback/capture
> it initially enqueued 4 DMA descriptors as single SG transfers, and upon
> completion of each descriptor, a new one was enqueued. Since there was
> no indication to the DMA hardware where the descriptor list ended
> (though the LE bit), the DMA engine continued transferring until the
> audio stream was stopped. From time to time, audio signal spikes were
> observed in the recorded file with this approach.
> 
> To address these issue, cyclic DMA support was added to the DMA engine
> driver, and the SSI audio driver was reworked to use this support via
> the generic PCM dmaengine APIs.
> 
> Due to the behavior described above, no Fixes tags were added to the
> patches in this series, and all patches should be merged through the
> same tree.
> 
> In case this series will be merged this release cycle, as the audio
> patches are acked, best would be to go though the DMA tree.
> 
> However, there might be merge conflict on the rz-ssi driver due to the
> recently posted patch at [1].
> 
> Thank you,
> Claudiu
> 
> [1] https://lore.kernel.org/all/875x4agb2x.wl-kuninori.morimoto.gx@renesas.com
> 
> Changes in v6:
> - addressed sashiko review comments
> - addressed Frank's review comments
> - collected tags
> 
> Changes in v5:
> - dropped patch "dmaengine: sh: rz-dmac: Do not disable the channel on error"
> - added patch "dmaengine: sh: rz-dmac: Add runtime PM support"
> 
> Changes in v4:
> - collected tags
> - addressed review comments got from sashiko.dev. For this:
> - added patches:
> -- dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
> -- dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
> 
> Changes in v3:
> - addressed review comments got from sashiko.dev. For this:
> - added patches 1-9
> - added patch "ASoC: renesas: rz-ssi: Add pause support"
> - dropped patches:
> -- dmaengine: sh: rz-dmac: Add enable status bit
> -- dmaengine: sh: rz-dmac: Add pause status bit
> 
> Changes in v2:
> - fixed typos in patch descriptions and patch titles
> - updated "ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs"
>    to fix the PIO mode
> - in patch "dmaengine: sh: rz-dmac: Add suspend to RAM support"
>    clear the RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED status bit for
>    channel w/o RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL
> - per-patch updates can be found in individual patches changelog
> - rebased on top of next-20260319
> - updated the cover letter
> 
> Claudiu Beznea (18):
>    dmaengine: sh: rz-dmac: Move interrupt request after everything is set
>      up
>    dmaengine: sh: rz-dmac: Fix incorrect NULL check for
>      list_first_entry()
>    dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
>    dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
>    dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
>    dmaengine: sh: rz-dmac: Save the start LM descriptor
>    dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
>    dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
>    dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor
>      processing
>    dmaengine: sh: rz-dmac: Refactor pause/resume code
>    dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
>      CHCTRL_SETEN
>    dmaengine: sh: rz-dmac: Add cyclic DMA support
>    dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return
>      error codes
>    dmaengine: sh: rz-dmac: Add runtime PM support
>    dmaengine: sh: rz-dmac: Add suspend to RAM support
>    ASoC: renesas: rz-ssi: Add pause support
>    ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
>    dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
>      descriptor
> 
>   drivers/dma/sh/rz-dmac.c   | 823 ++++++++++++++++++++++++++-----------
>   sound/soc/renesas/Kconfig  |   1 +
>   sound/soc/renesas/rz-ssi.c | 399 +++++++-----------
>   3 files changed, 723 insertions(+), 500 deletions(-)
> 


