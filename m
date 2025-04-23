Return-Path: <dmaengine+bounces-5013-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E4A999CB
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 22:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE543A5502
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F327933F;
	Wed, 23 Apr 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sFEG/VRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5xgqome"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4426FA5F;
	Wed, 23 Apr 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441786; cv=none; b=c7wsHGhgy9KcYqdnsTP0bYRa3pVpDGZ0BDagQMCOMxeK/M0tZOvEXLwVfUr3Ar0LxGhaNWQ5U+lucnXiHhc/DXaC0bAJL2iSCNGYZrZYAsKlrIcnPevrlMwAFMEXFXUwF9PhLhL9G5vb0CAd1GzHD4f+11a0fWXWNI4bYzoHD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441786; c=relaxed/simple;
	bh=7CKJRpVrcW8z+qkq8P4iPUSZPfcgCdmaXd8OoOh2BIc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JLbVdRNDsLb/XdgCr+xx5uHEJmeihh6NJYhbpsKYyvUlkA0jzYFGeGlJmN1aOozeF77v7AxdxhQJ/blrnTvSvcT6Y4XcqdfOyJhtd4NnNuYWtHffmeQzDPoP0NfWrkM4FJbRI92ZJy6wjx9d5FXOgxRs2wzaPZzKdONyuSp1vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sFEG/VRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5xgqome; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD7EF11401A4;
	Wed, 23 Apr 2025 16:56:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 16:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745441782;
	 x=1745528182; bh=Bb0LHun5eme3JvaCWcXczY1F5v3r5KRrL1ZFam4vbcY=; b=
	sFEG/VRMqOkVkVZASq1+o9nxMN+MNE6oGHnEVxRuHf7ODQUfFljNu3sXdG9NWV+K
	6knGlnjQqi35GJzpRJjLsVypmHK5uVHpxfiFbLM85Gy5MoLo5U93Pgono0+K8cB3
	pbsI3ypwLmBfW/JCzWtzGyDzdBBGsE1qloExacsd9eDTeT47hwqzKGAOcjUIf5/T
	nnniRWn3FsTx8aV0k7aJitK4n+ehsV4DtjqshR8xP/ORMPaG3vEMHsF+H5YAoVKl
	wv52MlQcpEDMt2WhuCHKBBWxdPpOAPkBf3rlauUBmmEbYvfxRXJOpDBJjDhsvRvI
	1ComTwB3ZGwaovCcneBhPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745441782; x=
	1745528182; bh=Bb0LHun5eme3JvaCWcXczY1F5v3r5KRrL1ZFam4vbcY=; b=I
	5xgqomehtEMxc600NdY6MPcAgP3SxbaHXrvXjwrfv6O1A00BVbzYQ8W9T/Z885ex
	f3pPssXN9ZqRjfvQDAlFD1rauZLCKtIACR4V+VJa2ygebreemR9ClKa9mOp7OwKZ
	OqxS/ltThjzCRHMrzLy/MrMTGAAq3elEYuY73lrEoeCFY7ODkquZRm3YzqO34iws
	QaPZq6jKmkc6R4F3R0kHq/D9+gKTyWXfvipnh9TQ4QZVZCM+cvWsi+XyesrkpTYz
	sj+PD8Trg53EGEaKggjCEgmJVmbmTw+16+xUFc+hfdO+PKLWQu7XwaQhg4UqOJB0
	NOISyi1fYvHqLjPazk2PA==
X-ME-Sender: <xms:9lMJaD87CsCAjkk85XHwNZZlnlaa0-YPpWtpfTxDhBCGUrCZOdzeig>
    <xme:9lMJaPvvn33kNKB-4LUvadejICTL7_YWJzdqs7a99SH70DlTIRIGXHXSvYIOcpWr7
    XCVR2gKR1h4ET92jlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihse
    grrhhmrdgtohhmpdhrtghpthhtohepsggtohhllhhinhhssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtohepughm
    rggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9lMJaBAIeQtMtD3XTZ193C-81qbbbSlloEDu2bOA_vrQpw-RXvTK3Q>
    <xmx:9lMJaPc6ajNqqpwwivumIo73CuutN-Q2KKfH5o8OQYspS9ywyF3rRQ>
    <xmx:9lMJaIPJLB-bdI381BfdIcKavMVygvcXLGNwc27NZDSfh6z_9TJEgg>
    <xmx:9lMJaBkbyGIBEPm8Q71gmEhMqA4qi98uwRDOI9T9i6yJX7MwxrJkNw>
    <xmx:9lMJaIrwPM1H0E8MfFk6WLps2TACto1q3m9t3TXnLloUvDMBHq9Udm9A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4076A2220073; Wed, 23 Apr 2025 16:56:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8f64d9338f7a15a8
Date: Wed, 23 Apr 2025 22:56:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ben Collins" <bcollins@kernel.org>
Cc: dmaengine@vger.kernel.org, "Vinod Koul" <vkoul@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Robin Murphy" <robin.murphy@arm.com>
Message-Id: <7d914aa8-dc6f-426c-b7fc-dbb03c6b676c@app.fastmail.com>
In-Reply-To: <2025042316-nippy-lemur-debd6b@boujee-and-buff>
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
 <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
 <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
 <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
 <29bdb7e0-6db9-445e-986f-b29af8369c69@app.fastmail.com>
 <2025042216-hungry-hound-77ecae@boujee-and-buff>
 <06765168-a36a-4229-b03b-6ea91157237a@app.fastmail.com>
 <2025042316-nippy-lemur-debd6b@boujee-and-buff>
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 23, 2025, at 22:41, Ben Collins wrote:
> On Wed, Apr 23, 2025 at 03:49:16PM -0500, Arnd Bergmann wrote:
>> Looking at the current code I don't see that any more, so it's
>> possible that now any DMA is allowed even if there is no
>> dma-ranges property at all.
>
> It's still there. It hardcodes zone_dma_limit to 31-bits:
>
> arch/powerpc/mm/mem.c: paging_init()
>
> I'm digging into this more. I'll check back when I have a better
> understanding.

zone_dma_limit is the other side of this: you need a ZONE_DMA
and/or ZONE_DMA32 memory zone that lets a driver allocate buffers
from low addresses if the DMA mask is smaller than the available
memory.

      Arnd

