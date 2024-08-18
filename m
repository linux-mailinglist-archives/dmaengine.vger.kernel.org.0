Return-Path: <dmaengine+bounces-2891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A334955C67
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2024 14:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEA01C20987
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2024 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764E182A0;
	Sun, 18 Aug 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l5Pdqc4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeMQmBP4"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96A8F66;
	Sun, 18 Aug 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723984101; cv=none; b=rgFmeQTIL5bw04I16hO432/2oDK4BYfurxmy6GIuXUP7r3hbkjgoO2C930XLU+Up+iYE+F5XDW+xliF9SaFAioPFhbBGuDSrBGKGLumHuP6iYGqh6mgKzhSMhgZ4ZiTzqqaH3HuvXlXPfCtekJXW0zk+MBMVPBsn6m92JdlNJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723984101; c=relaxed/simple;
	bh=QGZSgaDwjkzBfnoDRA6+KuuqDqZikjRQ6sBf6Ujr0d4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gc6Ass31ZVps2gfQv44orj/QPwb6uWEBYwBWItykDYpQW0i4RgYyV9zO+d9JFen2P32zuhwsFmJIaIs9EHWHDXzigQoj/XJy/fDsyR/6npMEedOaY5PUPHuoFBJeHaym8YsxBHPldHrZlZ/CtoDDKkBjncOvSOseIWlzeVmpZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l5Pdqc4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeMQmBP4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9059A1151B61;
	Sun, 18 Aug 2024 08:28:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Sun, 18 Aug 2024 08:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723984097;
	 x=1724070497; bh=DRpDj2if4gk6AAWUrO6EDxIFDLegIjhrreMFy1AqthQ=; b=
	l5Pdqc4dnK65nM1uaF6yLTV2hFu+IyDTanJMSqyq3aXX4Qv/CDdovxO2hJ6Xnuet
	fdwJyzl7z7VGXIcc7Cc/yhATrB4OBaLTF16FBlLd+iBg/aGEdlCZdQBCXCK2o4/O
	O7GbY9TkA1wiaT/+gwTusn3A+KaaLZ9rmq2wCeUHFcUuCZb28OaSJAncrpzyB80d
	BRYStQRBzvVmWz67yQBGFV1X12yuqv0rwpyQKZGbwE4cw46lKNT4WJCIstvqkSxj
	HITkd+xg33dnnbRa1tBmK6ovhrLFQI4N5xivXm63f00edQU5SBJu1PlII4W2xaGg
	Gry9vt1cx6FqQLAdfW+zEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723984097; x=
	1724070497; bh=DRpDj2if4gk6AAWUrO6EDxIFDLegIjhrreMFy1AqthQ=; b=F
	eMQmBP4rC8xHAiJGQZh9F40ZSgYgtwP+C1zdx2Jrz18tJ0nV+0JKeZeyc0iKe1Lx
	ixfIQoJupI31wBMV5RqMdSDmwcJamFvlvGRt+Hpofm/Ft8WuvEuU0LTtZY4IZzTE
	PKXGq01szZVR3I5WTXtTwFOntHyY3NCWxJfwq9CsM+/NGxFk6nLKb8Dz9z+F1GKO
	V+vw0+Q3fyycTqqUbZV48aoey5qAmh1BU8132NuulOcwB8NOeLmw+vwdT1VxyEpu
	WprbwTnMzz6AKYvLHnRTc+6nC8a/faqo9eo876ugbNpljhR2bgy1uBVvK44JWR/z
	itPDAbqUbCuSmpo/oJvBw==
X-ME-Sender: <xms:4OjBZsOU3EN2qawhBpwSUIaTMFtdmE78ULT6N9fXI-3NgSOex4kugA>
    <xme:4OjBZi-lTJj4wMlCqlXASbTZcAe_0HlX6aZ9UJbnV1Tc7eA5Vb38K6DAdEJFeeLgn
    1EfsK3jLs10APN-S20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrkhgvvdegsehishgtrghsrdgrtg
    drtghnpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegumh
    grvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrg
    gslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4OjBZjTnvrU0NCwBe3Y88TYgtWycaQvN7eRtu9wX1lApoAHFquOG9A>
    <xmx:4OjBZkuV1GYcWyJwTsr5YVjuJj8r2SKR_1lSM6bRwrFfAyeUnKfMhw>
    <xmx:4OjBZke3DK4PelYEF4eVQBcvXzT5gz09Mn51Qkpb_dV6hSZJjw2Zuw>
    <xmx:4OjBZo1vbpD8PDdXimKFpqaNs8dxD43UXTJijjJVzHfG-wiwXXdrDQ>
    <xmx:4ejBZpH0_HFlfQm6b9HG-iOGxzoq-wc6hUyTKbKZyB3nup0caigtxdIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C9BAB16005E; Sun, 18 Aug 2024 08:28:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Aug 2024 14:27:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ma Ke" <make24@iscas.ac.cn>, "Vinod Koul" <vkoul@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <68f613a0-64c8-4c3c-915c-ce6e76eee317@app.fastmail.com>
In-Reply-To: <20240818071757.798601-1-make24@iscas.ac.cn>
References: <20240818071757.798601-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] dmaengine: moxart: handle irq_of_parse_and_map() errors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 18, 2024, at 09:17, Ma Ke wrote:
> Zero and negative number is not a valid IRQ for in-kernel code and the
> irq_of_parse_and_map() function returns zero on error.  So this check for
> valid IRQs should only accept values > 0.
>
> Cc: stable@vger.kernel.org
> Fixes: 2d9e31b9412c ("dmaengine: moxart: remove NO_IRQ")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---

This makes no sense to me, you explain why the current code is
correct and then change it to something wrong?

> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 66dc6d31b603..16dd3c5aba4d 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -568,7 +568,7 @@ static int moxart_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	irq = irq_of_parse_and_map(node, 0);
> -	if (!irq) {
> +	if (irq <= 0) {
>  		dev_err(dev, "no IRQ resource\n");
>  		return -EINVAL;

The "if (!irq)" is clearly the intended check, as you explain
irq_of_parse_and_map() returns 0 on error.

      Arnd

