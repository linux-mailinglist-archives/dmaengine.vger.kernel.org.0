Return-Path: <dmaengine+bounces-11682-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fUUJIif8Nmp7HQcAu9opvQ
	(envelope-from <dmaengine+bounces-11682-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:46:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D26186A9B81
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:46:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mk2kZQXc;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11682-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11682-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FCF30107C8
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531612F0C79;
	Sat, 20 Jun 2026 20:46:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9218A92F
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 20:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781988388; cv=none; b=I6CkGdlVgmM+XkslmocuCr/jHWsDmHY9pUsGjSaudHa4RZldMOJVlokf+q9xfbTnzLJMpltEE2uu2e14t7NHuaWJAbW2CqVRWQ8pZrjLc+G15LhaUnu+rk2nihzHA0SVJYHhJ6OKC9RXo2Orhci/TCstchQpbkChqMJF/uMGV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781988388; c=relaxed/simple;
	bh=9OMddAER8ysz3qOphHy6Ge8vDf6Hkw0cENlUlI5UDd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/Obp/Gu/shuqH13xlPEsqgQdfYEJr2JFri0bRbBDaiMH9ueeUcg2rkBdX0OxwHJFrJiZl9s6kSvK1Jp0XPfFJgx/EfRU/kydtXbqkIHh8XMiU+JMvkA+KPrTB+HyEbH+xA9bOtuv0g/luhgVEiuhZQPGhvVgX3Gj8shBDs9vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk2kZQXc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE9A1F000E9;
	Sat, 20 Jun 2026 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781988386;
	bh=vPICMI/UV/75uJe7FMSSCUWpFqObmysiYXdJkO2Co5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mk2kZQXcQiI16Xe1AARCpVc9cuGlpK5PZ0WyQDULU5v7ll8GNAtgWSfFvlSBI6rdL
	 MU4dWckv9tGWDJGJ6DxAnArwFzAINHVql72w2ZubtnWNrD70A7llzxSx0jChSDQDNa
	 sr0JOxP0JpTurFGkJ1AKI/AC8RHCkNHL+GMW2bS5zi82QUo5EP9WcR34HoJCPLVIq/
	 asu/qk7vv0UgyjknhFc7ZecWu+1Fh7SSxPZ9AJ/X0kZc8xTm3jWrxbiQfUKZOVQ7Kk
	 rdD4WLJOnWqbHxDevTFl+ZgJdr2Ggzi83J10nul7tP+a5/lbN1Ticf9GEMoPOOTX2d
	 AgO+GGtHQDMLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 3/3] dmaengine: xilinx_dma: Optimize control
 register write and channel start logic for AXIDMA and MCDMA in
 corresponding start_transfer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suraj Gupta" <suraj.gupta2@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260620203417.4000360-4-suraj.gupta2@amd.com>
References: <20260620203417.4000360-1-suraj.gupta2@amd.com>
 <20260620203417.4000360-4-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:46:25 +0000
Message-Id: <20260620204626.7DE9A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11682-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D26186A9B81

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent read-modify-write on shared global MCDMA registers due =
to lack of a controller-level lock.
--

commit ecde894a65e016199009c2bd5c7fcf89cdab08cf
Author: Suraj Gupta <suraj.gupta2@amd.com>

dmaengine: xilinx_dma: Optimize control register write and channel start lo=
gic for AXIDMA and MCDMA in corresponding start_transfer()

This commit optimizes AXI DMA control register programming by combining
coalesce count and delay configuration into a single register write to
reduce bus overhead. It also avoids redundant channel starts by only calling
xilinx_dma_start() when the channel is actually idle.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 35b553ee3205c..aa3dee0dc2fcb 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c

[ ... ]

> @@ -1693,7 +1693,8 @@ static void xilinx_mcdma_start_transfer(struct xili=
nx_dma_chan *chan)
>  	reg |=3D XILINX_MCDMA_CR_RUNSTOP_MASK;
>  	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
> =20
> -	xilinx_dma_start(chan);
> +	if (chan->idle)
> +		xilinx_dma_start(chan);

[Severity: High]
This is a pre-existing issue, but does the lack of a controller-level lock
cause concurrent read-modify-write operations on shared global MCDMA
registers to race?

In xilinx_mcdma_start_transfer(), just before this diff context, there
is an unprotected read-modify-write on the shared XILINX_MCDMA_CHEN_OFFSET
register:

	reg =3D dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
	reg |=3D BIT(chan->tdest);
	dma_ctrl_write(chan, XILINX_MCDMA_CHEN_OFFSET, reg);

Similarly, when xilinx_dma_start() is called here, it performs an
unprotected read-modify-write on the shared XILINX_DMA_REG_DMACR register:

	dma_ctrl_set(chan, XILINX_DMA_REG_DMACR, XILINX_DMA_DMACR_RUNSTOP);

These operations appear to be protected only by the per-channel spinlock
(chan->lock). If two channels on the same controller execute their start
transfer logic concurrently on different CPUs, can the read-modify-write
operations race and lead to a channel's enable bit being silently
overwritten and lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620203417.4000=
360-1-suraj.gupta2@amd.com?part=3D3

