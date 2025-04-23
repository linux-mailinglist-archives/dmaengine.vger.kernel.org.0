Return-Path: <dmaengine+bounces-5004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CFA98BD5
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 15:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F7A3A75C0
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6511991B8;
	Wed, 23 Apr 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NDs1xlyY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8O7fn8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B691BC41;
	Wed, 23 Apr 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416192; cv=none; b=EXtAnump7yrixdx4F0CuQJTKaCjtfo7ToOdSi/2JonZV/DmJ080stx21Bf5Ucqb0b4SjtvY480ng3jpR93YwIgG3WUDJyerWKbN0xKhJ4JJDni6EFmwdIJi2KoTwIZGPYhzc9gAUyhmi3Kn3mJWUokkirVBroxIFg6pWRzDS7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416192; c=relaxed/simple;
	bh=VmfpxIAfj19acRzrst9q+xyePs15pitvD/9hq5UqNU8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IKzZ8iuJeh11W5Gf0kYemS1b0J9PdSfj/UJ0oOp7Rp1d4VwI7fVmZi30ECI6zAY0jrzPkID/jA9H3oMLqpcKwtAfljIyg9kD9pw8vjcrdCniyD4TAHPXf6+Rx+xZesRoz+YbwiGJLTKB+kVw/P5KVt2ciOflhmb2yDS+Ha91Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NDs1xlyY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8O7fn8c; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F01011402D4;
	Wed, 23 Apr 2025 09:49:48 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 09:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745416188;
	 x=1745502588; bh=VChUm3sRUsCqwnuWmJt8O1m8Q+AO86xNAt/YCvK6+So=; b=
	NDs1xlyYyRJehS3fOwCtUCC1D1+2LSVtTp1FFfFHuWVNjm2Alq9XumBzy6iODHtC
	5QaF97O/bQEeiR6s67H2HoaqkuR6QpBsSetZ1dgY0bDrW/Aw5j+8qCh/ApE1ahA9
	R+iowUtks2Gg5CdIQHcxOTfw6pa8qPCA2FMTknPrO+C7UKl572GpRoQqAwZ0Gjmw
	fA2huRjLTjkhYEQjY6oxxoicQWqUVL7nch0XWUq99NqoVJyRHEJ8PM30bwFEAQdA
	e6sPACgwR56O5xGNDmyTAx4tZ4fleoM/mnhge2kFr9U0zQP/8PwLg6yB4T7PQC/A
	h4ON6dtBWjUzFUBib4TidA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745416188; x=
	1745502588; bh=VChUm3sRUsCqwnuWmJt8O1m8Q+AO86xNAt/YCvK6+So=; b=F
	8O7fn8clYWCSO+0d+SSifxp2KQ5eLRMJMODl3GMxcETrhuKoUOmEWgOOZw+zh5Vh
	QEL7G0KM1UBOOQAUJYRsUH/PZ/tU2lWEHhg5mBDi4b0eOaasTcBpWGlI5ihbFLRV
	JuSOc0H+6DOjFdEnQSo3FqmPeEK524RO50G1LB9VUpo3gWFkG9nsEhpHeixtNVe+
	NJWIZS5sI9hjn8sX2UxdJArl0MgM16UFgyRvAawU9rAc4Vw3ZCHboqPyLpOwrdHF
	umPH1yYcwbQKFC0ILf4raC4cznVv/yjJlALoBwJNr46UvbdgVa17MlZ0vUmT5hDs
	fyfrrzgl5wEs7Eu91qrfA==
X-ME-Sender: <xms:--8IaKJ8uwi0oISUPlSCJH1YkeYhfm0zbx_nqMG3mcTsLdWaGj5S8g>
    <xme:--8IaCK5G9PltrDsLnsGcnArlGIfGE8YyKpbwKI_H2EJINDVLhMZQA-2uq6PiHKw-
    e0FhKpM6UDslClZIFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeijeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepgefgjedujedvieejgeelgfdthfduffeiteef
    udeghfffkeejfeehtdejfeejteefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopegs
    tgholhhlihhnsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhkohhulheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdho
    iihlrggsshdrohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:--8IaKu32umSgzsK5FB2N-6mBhlHA0buQBz1IDRHdIUQmicKWocyrA>
    <xmx:--8IaPZBq_MT58H9OuOzQ9XapDgXq7drt8WxZTBctKTEawhF-nEs_g>
    <xmx:--8IaBbeOfyxuNJ9NnPOltD_db4EkqyxQZQ1GTTvVG6dAU_PNGnFkw>
    <xmx:--8IaLDvWbNkTuGhdQhFUJmBfieS8MFKY-7tW9-axuJpfhilogo0KA>
    <xmx:_O8IaJk8HIjtiqkGSqLBORdkagwKSQOpiccj2ax0fwtBuCni_Qf6SOuZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDC932220073; Wed, 23 Apr 2025 09:49:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8f64d9338f7a15a8
Date: Wed, 23 Apr 2025 15:49:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ben Collins" <bcollins@kernel.org>
Cc: dmaengine@vger.kernel.org, "Vinod Koul" <vkoul@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Robin Murphy" <robin.murphy@arm.com>
Message-Id: <06765168-a36a-4229-b03b-6ea91157237a@app.fastmail.com>
In-Reply-To: <2025042216-hungry-hound-77ecae@boujee-and-buff>
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
 <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
 <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
 <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
 <29bdb7e0-6db9-445e-986f-b29af8369c69@app.fastmail.com>
 <2025042216-hungry-hound-77ecae@boujee-and-buff>
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 22, 2025, at 23:10, Ben Collins wrote:
> On Tue, Apr 22, 2025 at 11:25:40AM -0500, Arnd Bergmann wrote:
>> On Tue, Apr 22, 2025, at 10:56, Ben Collins wrote:
>>
>> >> > I'll check on this, but I think it's a seperate issue. The main thing is
>> >> > just to configure the dma hw correctly.
>> >> 
>> >> I think it's still important to check this before changing the
>> >> driver: if the larger mask doesn't actually have any effect now
>> >> because the DT caps the DMA at 4GB, then it might break later
>> >> when someone adds the correct dma-ranges properties.
>> >
>> > I'm adding dma-ranges to my dt for testing.
>> 
>> Ok. The other thing you can try is to printk() the dev->bus_dma_limit
>> to see if it even tries to use >32bit addressing.
>
> Did that. Every combination of IOMMU on/off and dma-ranges in my dt always
> showed bus_dma_limit as 0x0.

Strange, either something changed since I last looked at this code,
or there is something on Freescale SoCs that avoids the
default logic.

There was originally a hack for powerpc that allowed DMA to be
done in the absence of a dma-ranges property in the bus node, but
limit it to 32-bit addressing for backwards compatibility, while
all other architectures should require either an empty dma-ranges
to allow full addressing or a specific translation if there is
a bus specific limit and/or offset.

Looking at the current code I don't see that any more, so it's
possible that now any DMA is allowed even if there is no
dma-ranges property at all.

> As an aside, if you could give this a quick check, I can send the revised
> patch. Appreciate the feedback.
>
> https://github.com/benmcollins/linux/commit/2f2946b33294ebff2fdaae6d1eadc976147470d6

This looks correct to me, but I would change two things:

 - remove the debug message, which you probably left by accident
 - instead of the explicit of_device_is_compatible(), change it
   to use the .data field of the of_device_id table instead.

       Arnd

