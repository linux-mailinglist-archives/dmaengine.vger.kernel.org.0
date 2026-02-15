Return-Path: <dmaengine+bounces-8907-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKnGDPdEkmlysgEAu9opvQ
	(envelope-from <dmaengine+bounces-8907-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 23:13:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13313FDF1
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 23:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C81C302C903
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B732279DB3;
	Sun, 15 Feb 2026 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="ZoN2Igkh"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EC2690C0;
	Sun, 15 Feb 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771193587; cv=none; b=jRbP/5bcpgZE8BnT6BB5OnU7EZVaTJu1BDGlxKPPytwU5+lUqx92mN+7RpbkEo0rQC+CE9WaX70wur5joEJKPJQ/QIEg67XEzffO0fA8GMQSoHuI4fDShimUk+88m/ioKIA26zi0HApR0bfs7NFNgfDPtLVh5JNqUMpeQyFsSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771193587; c=relaxed/simple;
	bh=2b28tzRro5Cv2+NZzAv9n4S24M360nAuBWxaWrliwqc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=Rv6JQ0Pnur9V5qNsrYTGZgsVI2r+V+F290dvuQIv11OLYJRxn65HSJQ2sTXaXz7VjI7e97G5hF3PUhwAbd5YZO+T4XEacpWygiY/gad0o6BubrQqnDySYC4D1jwpfcY6+CnOxkjiUX9CsgHk+TLJNCK2Fhx11VyrGvwB4XDSpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=ZoN2Igkh; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:From:Cc:
	Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uhV31VyrveJcfXQ8d+nUZ4pzcd2qb2o+AH/0c14zuUQ=; b=ZoN2IgkhkJ2CQ2A4rCOzIcTNUY
	X5eNR5vMVbYQWsjKd8AW/v/BJwlDBBF59kDbfvZ+NvFaNth/VJ2sGWcPrOzxjWgfGFMNnwpCnqZx0
	DgWomYGQfnjsPqaXmpb0bntwE4Mo3cEdrSsH/ngdrlk0tEb0CK/xR3Nu8RbTBqV6cd3XaWiSGEdfV
	7Z9qOU23eyJ+mCqDTPHocOCAtbE48Fp/lpddUWZkoigGouEsNyCig03GexXFAjeGxwjOrsY0p2e0c
	3gJtbkbQLNjMEpduY6039x5jxMGGP48+LqEz8Dc53/Mn59PvRJFyi5DYHOoh2C68AmT2/VhO6W//S
	1WqbQY1w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vrjy9-000Ekn-1t;
	Sun, 15 Feb 2026 22:47:57 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vrjy9-000FlM-1H;
	Sun, 15 Feb 2026 22:47:56 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Feb 2026 21:47:55 +0000
Message-Id: <DGFV6UIJCQCU.3AS44T9UDTHQI@folker-schwesinger.de>
To: "Rahul Navale" <rahulnavale04@gmail.com>, <dmaengine@vger.kernel.org>
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: device-wide directions cause
 ASoC cyclic DMA regression
Cc: <vkoul@kernel.org>, <michal.simek@amd.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <thomas.gessler@brueckmann-gmbh.de>, <radhey.shyam.pandey@amd.com>,
 <Suraj.Gupta2@amd.com>, <marex@denx.de>,
 <manivannan.sadhasivam@linaro.org>, <harini.katakam@amd.com>,
 <marex@nabladev.com>, "Rahul Navale" <rahul.navale@ifm.com>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc
References: <20260211140051.8177-1-rahulnavale04@gmail.com>
In-Reply-To: <20260211140051.8177-1-rahulnavale04@gmail.com>
X-Virus-Scanned: Clear (ClamAV 1.4.3/27913/Sun Feb 15 08:26:21 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8907-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,folker-schwesinger.de:mid,folker-schwesinger.de:dkim]
X-Rspamd-Queue-Id: 8D13313FDF1
X-Rspamd-Action: no action

Hi,

On Wed Feb 11, 2026 at 3:00 PM CET, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
>
> On ZynqMP platforms using AXI DMA for ASoC PCM playback, upstream commit
> 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions") causes
> cyclic playback to fail after the first buffer period.
>
> Background:
> The upstream patch adds the following line in xilinx_dma_chan_probe():
>
>     xdev->common.directions |=3D chan->direction;
>
> Its purpose is to coalesce the directions of all enabled TX/RX channels i=
nto
> the device-wide dma_device.directions mask so that dma_get_slave_caps()
> works correctly. This is required by users such as IIO DMAEngine buffers
> that rely on device-wide capability reporting.
>
> Problem on ZynqMP ASoC audio (PCM):
> On ZynqMP, Xilinx DMA provides fixed-direction channels:
>
>     MM2S channels -> DMA_MEM_TO_DEV
>     S2MM channels -> DMA_DEV_TO_MEM
>
> ASoC dmaengine PCM relies on these fixed directions to select proper DMA
> channels for cyclic playback and capture. Aggregating directions device-w=
ide
> can cause inconsistent capability reporting depending on channel probe or=
der
> or device tree layout.
>

as far as I understand it, dma_device.directions lists all slave
directions the device supports across all channels. On the other hand,
dma_slave_caps.directions is a bitmask of slave directions the channel
supports.

While 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
fixed the dma_device.directions bit in Xilinx AXI DMA, it exposes
another short-coming of AXI DMA: as with the ASoC PCM, there may be DMA
engine devices with non-uniformly distributed slave capabilities per
device channels.
To adress this, there's the optional dma_device.device_caps() callback.
So I think the right way forward is to implement device_caps() for the
Xilinx AXI DMA and override dma_slave_caps.directions with the
channel-specific directions.
This should fix the issue for the ASoC PCM while preserving
functionality for the IIO DMAEngine buffer use-case.

I'm working on a patch that implements the proposed solution. I'll
post it in the next days after testing it with the IIO use case.
Unfortunately, I don't have access to a ZynqMP device, so to verify that
it actually fixes the regression in practice, I'll have to kindly ask
you, Rahul, for your feedback.

Best regards,
Folker

