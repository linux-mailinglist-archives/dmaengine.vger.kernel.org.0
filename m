Return-Path: <dmaengine+bounces-4936-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B4A96434
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 11:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3773A308B
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998F1F2382;
	Tue, 22 Apr 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="3CI0aNne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUuQOuaM"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806751D515A;
	Tue, 22 Apr 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313969; cv=none; b=JubxIxutJWOV9v132RbDArvLiicHmNCWPqkYlmhmlqUOudlGsrOnKe03OZjiGyOBGLFRtuGR/75qJmjW5rNbzMEOJqweCHxn+0ObSt+i3VRTs+bQuWQV2iKjOilLDstrF55hDTywgztx0gt7a84YGaYg5u+QmC9q6dMMI2TUR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313969; c=relaxed/simple;
	bh=7MVnBhI5qCCN7PqdZru6boeV6jlWC5T5MzkC5xQYqOI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nu09Byvsrq+Q7JtQNYAIS5ALOI1cMTkAxDCUnPYOX8h+O4az5GwdYQmQMAvd+vEYnd5rJf/qDqM4O3gH+B53/IyUId1V2MUn7UReYFMJAQKW2tDIdZeXHrouGV66hRtGU6mLfdPI2hlQnP48NrMBt2gxn2At8OKiZi45HxRfu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=3CI0aNne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUuQOuaM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 236CD254016E;
	Tue, 22 Apr 2025 05:26:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 05:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745313962;
	 x=1745400362; bh=1/+0YVTUvXTj7AvVeAYrj06s3CToZPPnPcHrNo0HQwA=; b=
	3CI0aNneHYAVSeaMa04aK7khsdUCytYTXWMqLjXvptLWdEdiuhsngS3z+CyNSXs2
	ShJC85FEH5QPTcCyKMD4bk6f9pLYhKZGcI0jbVMC1y7xVtH3EsP1QQaS+rsSRN6b
	aNt742LCKcQBSJIQaj2wVfth2YVX5sPDKjflfSL6bEEfTeZc3sEzAxaXONjeDwxE
	ESF5+NVzF1d9hCMkS0ABBnftJ1cEyez1ukbTc9FUsgwJlVGPNiHu9CiDtXdhKm3b
	lspXRDl8NNdvmovyZaGirRYzc+y4GEcPbpHtkOkxeyR3ELUdB/U1l7NnjkYwZMnO
	lbEmDiTjmQ5eWinETqn24g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745313962; x=
	1745400362; bh=1/+0YVTUvXTj7AvVeAYrj06s3CToZPPnPcHrNo0HQwA=; b=H
	UuQOuaMKbtJzpCIfZmWV+gYDfTnBHQJaYWXoVeNIFlFv70/kSMa/2Im0PbapCPrH
	SnhdnVdW6aNl+aeqUGUI279NWzrQMdpwFeXgSxvn/8PbRdzvgzcIIKKcB73zRE/5
	vq7//tvMEJtrCcqKIj/weV5wkGn360rJPGlMhsxFFOgbEKDrp/oDCUFi2hpcbWTx
	YyrbgTixma8fhgLz48cy2gZgyhje0wGJYMZzqVKmpi7+AaXIfSUFCN8A7y1kc9mA
	QZ4av96q62HpL//+AgPKnoug5dsqpKMDQkhDp+fl76yhHTOVotcStQQQMIMZoEY2
	Lvqvgg/w/tiRkIGAnX+kQ==
X-ME-Sender: <xms:qmAHaFNR0X0b4egu_tnuKLWqQgqv03-YG9SqHayrII8pRJaN5yIhUg>
    <xme:qmAHaH9Oqtsi__sG5JpeZ12gpTVo6QIJ7HzQxf8jp36dFeK-Gl_O6SsP5lPUfr0My
    dG97OOg1PjvcjTfyzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeffeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:qmAHaETefQDELZAy3qwtvFTJy62gjJmNz063VTFsm8XqipYnX6fGAg>
    <xmx:qmAHaBsn3G4ckJzKk-H_T0K65dQ-7sNKobWy0xyT6GQzrOPIypkgEg>
    <xmx:qmAHaNesBrKIYh1wNpw1f1NaaFosHIIciyoHATzlgdDcqn0Loe5v6w>
    <xmx:qmAHaN1dOxWES_oyUS2pwvAckyzrL4QX9KIdfZInhG7IuDJWNiL35w>
    <xmx:qmAHaFaf_Cy045B3uzzvlC2Bc64HbuymKtz1TKHvS1k02Th8kYjPJ-yA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92CE32220073; Tue, 22 Apr 2025 05:26:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8f64d9338f7a15a8
Date: Tue, 22 Apr 2025 11:25:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ben Collins" <bcollins@kernel.org>
Cc: dmaengine@vger.kernel.org, "Zhang Wei" <zw@zh-kernel.org>,
 "Vinod Koul" <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <29bdb7e0-6db9-445e-986f-b29af8369c69@app.fastmail.com>
In-Reply-To: <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
 <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
 <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
 <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 22, 2025, at 10:56, Ben Collins wrote:
> On Tue, Apr 22, 2025 at 09:59:42AM -0500, Arnd Bergmann wrote:
>> 
>> Right, but this could just mean that they end up using SWIOTLB
>> to bounce the high DMA pages or use an IOMMU rather than actually
>> translating the physical address to a dma address.
>
> There's a few things going on. The Local Address Window can shift
> anywhere in the 64-bit address space and be as wide as the physical
> address (40-bit on T4240, 36-bit on P4080). I think this is mainly for
> IO to PCIe and RapidIO, though.

There are usually two sets of registers, not sure which one the Local
Address Window refers to:

- Translation of MMIO addresses (PCI BAR and device registers) when
  accessed from CPU and possibly from P2P DMA, these are represented
  by the 'ranges' property in DT.

- Translation of physical memory when accessed from a DMA bus master,
  represented by the 'dma-ranges' property.

The latter is what the dma-mapping API needs. This code has changed
a lot over the years, but in the current version the idea is that
the limit enforced by the driver through dma_set_mask() is independent
of the limit enforced by the platform bus based on the dma-ranges
property. 

The bit that matters in the end is the intersection of both,
so dma_map_single() etc only maps a page that is addressable
by both the device and the bus.

>> > I'll check on this, but I think it's a seperate issue. The main thing is
>> > just to configure the dma hw correctly.
>> 
>> I think it's still important to check this before changing the
>> driver: if the larger mask doesn't actually have any effect now
>> because the DT caps the DMA at 4GB, then it might break later
>> when someone adds the correct dma-ranges properties.
>
> I'm adding dma-ranges to my dt for testing.

Ok. The other thing you can try is to printk() the dev->bus_dma_limit
to see if it even tries to use >32bit addressing.

>> > So a little research shows that these 3 compatible strings in
>> > the fsldma are:
>> >
>> > fsl,elo3-dma:		40-bit
>> > fsl,eloplus-dma:	36-bit
>> > fsl,elo-dma:		32-bit
>> >
>> > I'll rework it so addressing is based on the compatible string.
>> 
>> Sounds good, yes. Just to clarify: where did you find those
>> limits? Are you sure those are not just the maximum addressable
>> amounts of physical RAM on the chips that use the respective
>> controllers?
>
> This is where things might be more interesting. The P4080RM and T4240RM
> is where I got this information. Register "cdar" in the fsldma code. This
> makes up 0x08 and 0x0c registers.

> In the RM 0x08 is the extended address register. On P4080 it says this
> holds the top 4 bits of the 36-bit address, and on T4240 it says the top
> 8 bits of the 40-bit address. So the asynx_tx physical address needs to
> be masked to the 36-bit or 40-bit.

Ok, makes sense.

       Arnd

