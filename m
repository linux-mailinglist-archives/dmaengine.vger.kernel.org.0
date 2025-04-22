Return-Path: <dmaengine+bounces-4931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1762A95E49
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 08:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188287A336E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1B21ABDE;
	Tue, 22 Apr 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tm96GUz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S15YVYNg"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9806221FA7;
	Tue, 22 Apr 2025 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303729; cv=none; b=cIfbVEGpXjz7wwJ+MiYhP57CLTMsMLbhx1EGi5k/028h+aDQ3MCeJwU3eZdojjpRyMk3LvqqN3EGKF4nutJ1tHhr03gzS8ztlbK8N847JBmy6lSccLqjazGUChlAoanholnOy8E70eWafzWgl/Pv3OdbJEVwaAh+J/0ukXPVTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303729; c=relaxed/simple;
	bh=H9p6hvgQxAMugFl26NqAOx5UFw2lmOm7sVOIyMGXh50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aK/ZKkNgx1A0qJAJN+RDB4hR8lQcDVi/iALlI7TSS0TN/Au8o1tOrjscNkPDQhyJl991E7ydpt8kVpgelXvir7yri4VGAueAs8tvSv6/huDSWPgFNJLIWIpE98dttiAHWcM9het/bdEjo+j13m5I+0OkGYxip1UzmHBE4U2fKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tm96GUz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S15YVYNg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A27AA11401A2;
	Tue, 22 Apr 2025 02:35:26 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 02:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745303726;
	 x=1745390126; bh=CSbqA3bAQF15TSj2kU2AijUmnn5D8n+f1WrGXiMzIZc=; b=
	tm96GUz/5laSpVdtqvT92jAn/qGy66m52ES4GFPViDC0RE+s7/JAca2z2jBmsFDQ
	tb+28qUcHFs3qx0R+2c8CeddgRWIV/9h24rqr23EKUIVwGa4GPeuUrG0tmlgoVt+
	ZHzn79ST+9I0goMv6y7eOFP1Aob1j4VDt2+5sE7rtuLB/Zyu8JY3KagvyAlC+uir
	rPD9fI8V4/OHOin2f7bJbaudSREsZk0UkCOyZ72FVn9fVz6n0ZPaVfcXkbrUymZU
	ouwPj1ZyoYsCGSohjo6H3xKXwjVezVgklx4GrPhsrNwmX/3tHp6p59fFeFvlcY+t
	n1n6Hewxl/eZ7t4kVuIsaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745303726; x=
	1745390126; bh=CSbqA3bAQF15TSj2kU2AijUmnn5D8n+f1WrGXiMzIZc=; b=S
	15YVYNgzRi5te+XpEAxt4na3Nt+HZmh0lSNmiT6bmHdemAiHDAbCzmFlZJnif8wp
	yCdy4UgPdeNG1xrL/evW7VosMvkF/ejT2XX2AK5cdhSQqhHYKgmh8WkQDkaCNKQZ
	gdXIRzwckAGICeIMDcBAtBBBxNhz7r2YJrNdpVAuRj4nCv/v2kBypQlTtjeAUY+m
	7igWf2du+M/CD9uRKd+LIw+CprBFKq/cz8wsSwh+RM+may8pIwu3Qmhotlo8S3rf
	G3u0RpmIuZwd5iHVjAU/+4Ewik3jRMzl70nih37gjyqwEQTCHmC3NNJ+V8M0Q1Ap
	Xr7VnNo0wpayDOl4WUcxQ==
X-ME-Sender: <xms:rjgHaCFqDcjmUeR6G11LG7Oqyq2Y-1euR6CcOwuJwp6vhdzD9MujAA>
    <xme:rjgHaDXycfeQgfS-QA-mrGPXCnQqVcLRH66U2WTcFBaHi9yn-auW0sN55lCa81azh
    mrSLfZ_axPLjcHTZG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggtohhllhhinhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtg
    hpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopeiifiesiihhqdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rjgHaMIWXPEbidvdIojmW-kdRwy8zzfCt9WApBEWzFCXD-yt1uAIBg>
    <xmx:rjgHaMFoY_wlw3acJWj1FJeo6mWISxD64I-MTmyUqcd_1wqL4GE8aQ>
    <xmx:rjgHaIXEoPJ7GIiIDnVr0Fz4oezSwmkq6GD9_mZYSAC5_MmJ0LLwsQ>
    <xmx:rjgHaPPGhcATyxbCYLHL0jhu-KvDKMNruOYPP8Ywi-NNbun1FpncCA>
    <xmx:rjgHaOx8Ctd0-LE-TORyy1WlNtGQ4_XQ-zli77A2XR6VeO-24Y54Dtg5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29A312220073; Tue, 22 Apr 2025 02:35:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8f64d9338f7a15a8
Date: Tue, 22 Apr 2025 08:34:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ben Collins" <bcollins@kernel.org>, dmaengine@vger.kernel.org
Cc: "Zhang Wei" <zw@zh-kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
In-Reply-To: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 22, 2025, at 04:49, Ben Collins wrote:
> On 64-bit QorIQ platforms like T4240, the CPU supports 40-bit addressing
> and memory configurations > 64GiB. The fsldma driver is limiting itself
> to only 64GiB in all Elo configurations.
>
> Setup fsldma driver to make use of the full 40-bit addressing space,
> specifically on the e5500 and e6500 CPUs.

I don't think making the mask depend on a compile-time option is
correct, e.g. when you build a combined 32-bit kernel for e500 and
e5500, you set a different mask compared to an e500-only kernel.

The question here is whether the mask is a limitation of the
IP block or the bus it's connected to, of if there is any
limitation at all:

- The driver just writes the DMA address as a 64-bit register,
  so most likely the DMA device can in fact do wider addressing,
  and any limitation is either in the bus or the available
  memory

- SoCs that don't set a dma-ranges property in the parent bus
  are normally still capped to 32 bit DMA. I don't see those
  properties, so unless there is a special hack on those chips,
  you get 32 bit DMA regardless of what DMA mask the driver
  requests

- If there are chips that have more than 64GB of RAM installed
  but have a limitation in the way the DMA engine is wired
  up to 36 bits, that should be reflected in the dma-ranges
  property, not the device driver.

- If the limitation is indeed specific to the version of the
  IP block, this would normally need to be detected based on
  the compatible string of the DMA engine itself, not a compile
  time setting.

     Arnd

