Return-Path: <dmaengine+bounces-8104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA76D02200
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD1043001BF8
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC43B8BA6;
	Thu,  8 Jan 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="own0Pc+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLz/pdli"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9348E8D2;
	Thu,  8 Jan 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868029; cv=none; b=Ho7PsVSysvscfPfObXDxKmq89aWcJWy8qWQ4G0MPaLNF1cTgvK6Zosh1KbEQxGO9pQz0YXBfb7pMFuKWiQhPMuGwipwV2hVMV5Bwya+Yup1vafih2CKO0DABQe9zMCcFJkB0THKk/9m7WciskVKsmfBwt2UF/5haDGRMvLCNe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868029; c=relaxed/simple;
	bh=cw/hFBUMtTjJ9nQOD48Kt7+2qMNfXJa4DptZ3WzsYOc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tavc34Y+2iJndkMsMOTD/e0oQkt1Dc0AyS/q0Xxwq8tPvj3Bo32qA2GBzRjmwqx2XRlGjjoK19CM41t4OPU8UD/s5BgmXTpiF6ROJrdcMBW75XfCXYBNAt3z6pgHP9Czl1cCE3R/3RqOWiIodoOg9mNf3be9thhYhYKfHpiWP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=own0Pc+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLz/pdli; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 52C6B1D000CF;
	Thu,  8 Jan 2026 05:27:01 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 08 Jan 2026 05:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767868021;
	 x=1767954421; bh=hwzwki6Pe3xy/D9JLf90oZTp8vrfN7FL6aqLOPOqUak=; b=
	own0Pc+tz/1xpMkmjnIJPigoJ/n3ElwnWX2oDVY1UHfiT1OGKU6cvEGVTVd3qmtE
	LMZ48ogTLUS7KUmmONtV18M2pXzjVnMsX2PnLb9Mlp0o2TIWkMtXgufBVCcDfdi2
	emIV0ff8tyuAyRHtPzYdXWVMZIm0qyd7e6CNcE8EtCtfcVRgoj1j1ZmjLBVJLbI+
	WCXRVjwXYwFIHRHd2ls3ebkNhhCZagKQg1X8bRZRKSSbxE1yX9CBzKbWxF1mapUK
	2DlpG6wkQklyQbn+f+fdHpG1NnOr5FbjONBN2SZ1Jo8w+Ua/fmI2fXMGX/12RejT
	AkD2Jd7y5BgPv4mGdsU2RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767868021; x=
	1767954421; bh=hwzwki6Pe3xy/D9JLf90oZTp8vrfN7FL6aqLOPOqUak=; b=x
	Lz/pdlioXqr4eciYE+NwBEDQBHhCUJNXSgCPDzlcGxf38ijUo6p2jDrW3fUmQvfL
	qDk2psT/IPsjAPKMSY8dsWjxif29wzDe1Ef4NgZ7qBcEoKqCynUvnOpwWecDG9QI
	XX4tA/VrwsCVlKiVDXqJ0MwXaXPPrJAXNJt/z3HoTVVAQYEe45VEMlzQVxZre2xN
	8Ga3EHTzPY73YpyWwUmsOIh+Z3+A+4xZ9efPHYSDnVa3qky/2b2qTCNIw6EPKmJS
	CJmjr4QMRBV3YLE6t3ok2ZmP/0JSyEn4h0olqorxEXUHXJ97QX1cSRTeTgwOxyU0
	Ti5s7ElHJEnw/Vq0IdDuQ==
X-ME-Sender: <xms:dYZfaSNMp4Kww6ORbKW-_hxES8LSnmDq0nJ4ZsBjez2O51JACNBqng>
    <xme:dYZfabywdVUOVIFk19a-ew0_6gCxY8ZDY5te0Geqi6VgEtc6LlTcokwYpmveqsSUN
    V63ALWY1uWznZWFQdDH4ggR634Nfq0iWr_IXrc58mRVbm39zO05zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghllhgvnhdrlhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvkhhouhhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:dYZfaUaSGJMpeDKmT1pNVlxb5oV4UFPl4hFpySNNVaA_CeHExjT0Cg>
    <xmx:dYZfaYWFZUVBMOBNRyGruzziEsqw0YBcyHnBUpP_ZjnsmAEtJ4Q1QA>
    <xmx:dYZfaaifBIU38pTsYoKO-ehL8Sm2vJDCr4MKTuNBbfwIhByhCg8KLQ>
    <xmx:dYZfaesruqCgf5rR9-ds3xsg6piffndBbHq8z6jKoNSFkLBXMWUWwg>
    <xmx:dYZfaYHFyqX0H1yfGxsnSrTGi18pl6hPfJNrnwl-EDU3lugruSh1iFG7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 059BE700065; Thu,  8 Jan 2026 05:27:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlCBMFNMbPuR
Date: Thu, 08 Jan 2026 11:26:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: Allen <allen.lkml@gmail.com>, "Vinod Koul" <vkoul@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
In-Reply-To: <20260108080332.2341725-2-allen.lkml@gmail.com>
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 8, 2026, at 09:03, Allen Pais wrote:
> Create a dedicated dmaengine bottom-half workqueue (WQ_BH | WQ_PERCPU)
> and provide helper APIs for queue/flush/cancel of BH work items. Add
> per-channel BH helpers in dma_chan so drivers can schedule a BH callback
> without maintaining their own tasklets.
>
> Convert virt-dma to use the new per-channel BH helpers and remove the
> per-channel tasklet. Update existing drivers that only need tasklet
> teardown to use dma_chan_kill_bh().
>
> This provides a common BH execution path for dmaengine and establishes
> the base for converting remaining DMA tasklets to workqueue-based BHs.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Hi Allen,

I agree that the dmaengine code should stop using tasklets here,
but I think the last time we discussed this, we ended up not
going with work queues as a replacement because of the inherent
scheduling overhead. 

The use of this tasklet is to invoke the dmaengine_desc_callback(),
which at the moment clearly expects to be called from tasklet
context, but in most cases probably should just be called from
hardirq context, e.g. when all it does is to call complete()
or wake_up(). In particular, I assume this breaks any console
driver that tries to use DMA to send output to a UART.

It may make sense to take the portions of your patch that
abstract the dmaengine drivers away from tasklet and have them
interact with shared functions, but I don't think we should
introduce a workqueue at all here, at least not until we
have identified dmaengine users that want workqueue behavior.

If your goal is to reduce the number of tasklet uses in the
kernel, I would suggest taking this on at one level higher up
the stack: assume that dma_async_tx_descriptor->callback()
is always called at tasklet context, and introduce an
alternative mechanism that is called from hardirq context,
then change over each user of dma_async_tx_descriptor to
use the hardirq method instead of the tasklet method, if
at all possible.

      Arnd

