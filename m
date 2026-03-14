Return-Path: <dmaengine+bounces-9428-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHfUG0YgtWktwwAAu9opvQ
	(envelope-from <dmaengine+bounces-9428-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 09:45:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE728C348
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B70673024CA9
	for <lists+dmaengine@lfdr.de>; Sat, 14 Mar 2026 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAF286A4;
	Sat, 14 Mar 2026 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="q84TXm9t"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C21F5EA;
	Sat, 14 Mar 2026 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773477931; cv=none; b=AKW6ERQ2tMiUmST8TlXv+k/C+0z/F5+TAdZ1Cm/JblXe7/BdR2u1K0w8QgIhgBQvODRpvYRd42OlmHYKsvAscqfL59662aBpHRY8F7SVWEAqgwBaqOcy8MM+Fb3z+nrhUIe9qNTbhw8p5YAmsP0tWhnCaKyrh0RJePmFyjWe5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773477931; c=relaxed/simple;
	bh=Pg0oVFRscnlmYy+Eh/DH0v3AyH+o/BdVyC5aCHMXo/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=iKm8feKq2083zJlhSsf+CffP4z9iF+HvGGDm1sIPMcdkbBXj8ETBDzTeMSV7lLSzW9xudikHuCFuuInXWN2vwuyRaULHmixLracVO3CX9fzM3HfCoKHSOGWjIBeUbU7M5sU/i1gQZA5IRYzbM6rRzo1NsvVvo2avHg9Idzx3EmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=q84TXm9t; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Pg0oVFRscnlmYy+Eh/DH0v3AyH+o/BdVyC5aCHMXo/o=; b=q84TXm9tunwc9vj6azWkRxpIy2
	FWFOuqEtx3jMzqBnQWhpH7NpVz/H9lUPGti7Ex6ittsHQ1TZtvJlwwyCJozJweSAhyzLlO/979lBu
	rXgeSzdPzA99Zord2OfPYzXyER2kehKQy2AyIktwzprg/yZsd93OFyr1C3yGLQbaOV5b02HnwtFY0
	R+/Tfz15ro0putZ9g6np/gVVtolTo9gXIhmCpZSTRZI9KSzo2R5RTP91wtg0tnNP1QmDz2CwVVX/H
	Z4BcjAHSlIVIIY2J9cRk22Lpcl1K1yGKTk++7EZ5yebeqlMbe74bRGiXMkNQhoYKYQXXKAI1f3uaj
	oW9XTfjg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1w1Kcg-000HtS-1S;
	Sat, 14 Mar 2026 09:45:26 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1w1Kcf-000M4O-0A;
	Sat, 14 Mar 2026 09:45:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 08:45:23 +0000
Message-Id: <DH2DGEG9CHLG.1WO05WV70B987@folker-schwesinger.de>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
Cc: "Vinod Koul" <vkoul@kernel.org>, "Frank Li" <Frank.Li@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>, "Suraj Gupta"
 <suraj.gupta2@amd.com>, "Thomas Gessler"
 <thomas.gessler@brueckmann-gmbh.de>, "Radhey Shyam Pandey"
 <radhey.shyam.pandey@amd.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Rahul Navale" <rahulnavale04@gmail.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: <dmaengine@vger.kernel.org>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27940/Sat Mar 14 07:24:47 2026)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9428-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[folker-schwesinger.de:dkim,folker-schwesinger.de:email,folker-schwesinger.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,ifm.com:email]
X-Rspamd-Queue-Id: C2CE728C348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Feb 17, 2026 at 7:49 PM CET, Folker Schwesinger wrote:
> Since commit 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device
> directions") all channel directions are aggregated into
> dma_device.directions so that dma_get_slave_caps() works for IIO
> DMAEngine buffers.
>
> However, this caused a regression in ASoC audio on ZynqMP platforms,
> that causes cyclic playback to fail after the first buffer period,
> because ASoC dmaengine PCM expects fixed per-channel direction reporting
> from dma_get_slave_caps().
>
> Implement optional device_caps() callback and override caps->directions
> with the channel's fixed direction. This keeps device-wide direction
> reporting for IIO intact while restoring correct per-channel semantics
> for ASoC.
> Other dma_slave_caps fields are left unchanged from their respective
> values initialized from dma_get_slave_caps(). In case there should ever
> be the need to override other fields, these can be added later.
>
> Fixes: 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
> Cc: stable@vger.kernel.org
> Reported-by: Rahul Navale <rahul.navale@ifm.com>
> Closes: https://lore.kernel.org/dmaengine/20260211140051.8177-1-rahulnava=
le04@gmail.com/T/#u
> Closes: https://lore.kernel.org/dmaengine/CY1PR12MB96978AEBD6072FC469DFEA=
F1B762A@CY1PR12MB9697.namprd12.prod.outlook.com/T/#u
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>

@Xilinx/AMD maintainers:

Even though this patch does not fix the reported regression and there
may not be an immediate need for the implementation of the device_caps()
callback, it might be an improvement to the Xilinx DMA driver. In case
you see value in that addition, let me know and I resend the patch with
the necessary editorial changes.

Also during the debugging session, the following was identified:

> From a quick trace through the code I found that in the Xilinx DMA
> residue_granularity is set for AXIDMA independently from the SG setting
> of the DMA core [1].
> However, in xilinx_dma_tx_status() one of the conditions for residue
> calculations is that SG mode is enabled [2].
>
> [1]: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/dma/xilinx/x=
ilinx_dma.c#L3284
> [2]: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/dma/xilinx/x=
ilinx_dma.c#L1293=20

Not sure if this needs addressing, but this could have the potential for
subtle bugs...

Best regards
Folker

