Return-Path: <dmaengine+bounces-11816-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /bbnKW98PmqaGwkAu9opvQ
	(envelope-from <dmaengine+bounces-11816-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:19:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA706CD5EA
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:19:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=folker-schwesinger.de header.s=default2212 header.b=fCb6qML9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11816-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11816-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=folker-schwesinger.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 048BC30236DC
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58FF3F44FC;
	Fri, 26 Jun 2026 13:19:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828393CE0AE;
	Fri, 26 Jun 2026 13:19:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479958; cv=none; b=SsrI3wKNCBwIMwxxMev4dGhLesXus9Z6eL/Manmozaoq+FOlgl5HPHQwolwHy4mS2tCKLsEPTs7oHBKNg3C532MLXZ2uLYye9DBHQ4Fnpdvmd1u/RvbxB8N2t5XxCPP6dWdOVI5v4/ikjHefAN3VPgqWFCFR3CfqhFNR9urNspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479958; c=relaxed/simple;
	bh=t37nkRLkcr3BKhm4ou5f6OZvlQMUBy5woWPuLyPalNU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=muo1CfGEYcsjE4m4Bgdc/BJRTr9EIIJNhb8Zv/V1qhKtTv9MUwZa3eiM8O4wF+nt7wMqg6w3hHxTDi8QG243788C5h/8i9qt/+A5rqUF7wmdCP/XbrdFeONFG15RyCvUG+TJ6/H4DAr2khY4sjDV3ZyCLhQLb7i6E6V7JvRvq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=fCb6qML9; arc=none smtp.client-ip=195.201.215.122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P2Idfefkhd5yd2wTqXvp/0zaLmn55htaW7rWMLoCA2w=; b=fCb6qML9biq0KYATmm+LYcSegQ
	fwq23ZA3TmsHz4YwMcG1/3eR7iaRM6/yYCi1EenQA3gZvonB0ZjqDt5icDzqDqdi/Ytl1X0HVbLiL
	RdvoAC9UOzVpZ6DecBzuI2vvlpSus1DCvsirhrNnkDkme7N4MQDBM7sJZj2IFszenrtFw3Bw6dAis
	HApFD0lgo75fSYNpvbj6UGAdnOq4rB0dMBEwpOZB7S3XTtHDAxH+pHPM7fLGlpiHLmovLkcQDwt3H
	yEO37KdeKmZNA4rGr8Dzkq/3EehBSUqJ+/vqaKB6HE1x4jabS587kHOvEqsu8QoV1Fs4zRyU8yhfD
	ABVaFw2Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1wd6Ak-00018g-2k;
	Fri, 26 Jun 2026 15:00:42 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1wd69m-000Cq5-0G;
	Fri, 26 Jun 2026 15:00:42 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 13:00:41 +0000
Message-Id: <DJJ00J6ROCIR.17UYIA64S2JHY@folker-schwesinger.de>
Subject: Re: [PATCH v3 2/3] dmaengine: xilinx_dma: Enable transfer chaining
 for AXIDMA and MCDMA by removing idle restriction
Cc: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Suraj Gupta" <suraj.gupta2@amd.com>, <vkoul@kernel.org>,
 <Frank.Li@kernel.org>, <michal.simek@amd.com>
X-Mailer: aerc 0.21.0-151-gce80509b8454
References: <20260626092656.1563871-1-suraj.gupta2@amd.com>
 <20260626092656.1563871-3-suraj.gupta2@amd.com>
In-Reply-To: <20260626092656.1563871-3-suraj.gupta2@amd.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/28043/Fri Jun 26 08:24:31 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11816-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp,folker-schwesinger.de:dkim,folker-schwesinger.de:email,folker-schwesinger.de:mid,folker-schwesinger.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA706CD5EA

On Fri Jun 26, 2026 at 11:26 AM CEST, Suraj Gupta wrote:
> Relax the idle check in xilinx_dma_start_transfer() and
> xilinx_mcdma_start_transfer() that prevented new transfers from being
> queued when the channel was busy, so scatter-gather transfers can be
> chained onto an in-flight transfer.
>
> In scatter-gather mode, only update the CURDESC register when the active
> list is empty to avoid interfering with transfers already in progress.
> When the active list contains transfers, the hardware tail pointer
> extension mechanism handles chaining automatically via the descriptor
> next pointer chain, which is set up at channel allocation and preserved
> across descriptor recycling.
>
> Direct (non-SG) mode has no descriptor queue: writing the BTT register
> launches a transfer immediately, so a new transfer must not be programmed
> while one is in flight. Keep those transfers serialized by retaining the
> idle check on the non-SG path. MCDMA always operates in scatter-gather
> mode, so it is unaffected.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

For the AXIDMA SG-path:

Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index ca396b709742..6e7b183cb499 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1580,7 +1580,14 @@ static void xilinx_dma_start_transfer(struct xilin=
x_dma_chan *chan)
>  		return;
>  	}
> =20
> -	if (!chan->idle)
> +	/*
> +	 * Direct (non-SG) mode has no descriptor queue: writing the BTT
> +	 * register launches a transfer immediately, so a new transfer must
> +	 * not be programmed while one is in flight. Keep such transfers
> +	 * serialized. SG mode supports chaining onto a running transfer via
> +	 * tail-pointer extension, so it is allowed to proceed when busy.
> +	 */
> +	if (!chan->has_sg && !chan->idle)
>  		return;
> =20
>  	head_desc =3D list_first_entry(&chan->pending_list,
> @@ -1599,7 +1606,7 @@ static void xilinx_dma_start_transfer(struct xilinx=
_dma_chan *chan)
>  		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  	}
> =20
> -	if (chan->has_sg)
> +	if (chan->has_sg && list_empty(&chan->active_list))
>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>  			     head_desc->async_tx.phys);
>  	reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;
> @@ -1660,9 +1667,6 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	if (chan->err)
>  		return;
> =20
> -	if (!chan->idle)
> -		return;
> -
>  	if (list_empty(&chan->pending_list))
>  		return;
> =20
> @@ -1685,8 +1689,9 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
> =20
>  	/* Program current descriptor */
> -	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> -		     head_desc->async_tx.phys);
> +	if (chan->has_sg && list_empty(&chan->active_list))
> +		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
> +			     head_desc->async_tx.phys);
> =20
>  	/* Program channel enable register */
>  	reg =3D dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);


