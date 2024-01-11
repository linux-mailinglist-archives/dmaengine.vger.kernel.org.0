Return-Path: <dmaengine+bounces-727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CE82B2DB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 17:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9B1C2456D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 16:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE84EB5C;
	Thu, 11 Jan 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qvhRAfH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fN1XZxTU"
X-Original-To: dmaengine@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE94F60B;
	Thu, 11 Jan 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 6482932000EB;
	Thu, 11 Jan 2024 11:23:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704990207; x=1705076607; bh=YcU2xy056h
	+QlQA91Rv67d7NflwBIz2XJhgM8errMgU=; b=qvhRAfH+WKlJIPmFQW2BXLXt2m
	p3gocv9L0EUUKcNqovdo+eHXD4sdf2/LXLx2hXGVKpn1G5/gccGo3od77PpwCqla
	L5aQxOHihGO6kp5F5Zn2cX/qkq744bQFG5PfKxj0o2m2kKw8GOJ2HA5+cvRKQ0rX
	8Oi/vJmkRQPXD43k3QhNK7VS/+o/TCe3NP6WZSc1d6OSvlEb0D1XgHntv9tVbAdD
	o2Jsoqh2cvwEKbTzMlfd5o9YyCubwEqF3m9ZyZW5yXt4pTDNVI4rMd8IJNeiUvwq
	KCf/mBqCfgrpVBGBMpR754uVlr20QymxYw6qj4xRkfuyS9ZY/FT4NK65MjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704990207; x=1705076607; bh=YcU2xy056h+QlQA91Rv67d7NflwB
	Iz2XJhgM8errMgU=; b=fN1XZxTUmjGGykTpRVNFeDAgMvxSZMU/qOCm0hpcOFxp
	2XYmOJ7Bx9n3sMmq8j8qgtBsx9i72/9BTBO+bWZsWL2W39QRqpZ08IEYqZktPE9l
	iTXhRkEpzapiGaGp64Mru0JJcV8u5Sjpf8u418sotDEeFTke4XWBePDlNqG+dcJL
	x66uFjrQ3TMuhTN9Mqsp9S+48hzLjtpDGxlyU1acB7MAzLco8d/hzyxp7kd4S/A4
	3cSQ/Zxo+ri+AU5K6UMkevYhZT+tj1B2tbC07T57P23/qbZVKPa2mDdLG85gOaJd
	lKtuF4i/5ONQ0gJI+Wv88KO6/rZAM5OTqt36BGN1KA==
X-ME-Sender: <xms:_xWgZZj_jmxo__tks2Y8CGjzYvzRnQDF--U201waDlEzDooIt8owAQ>
    <xme:_xWgZeB_m2qcZCMSCrb9TDTwY4J49Jfzh7QcvOpZHlFBwVIVI2uf3XFI42pJQeiCh
    r9sdkiH19UmJ640Ras>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_xWgZZEK-TI0VCzhzGjtzRQJ_76Berqs_bQ__u7RyBNxN9Vnt7gbDg>
    <xmx:_xWgZeQxFzSA15yRfWrDGcm2WSVzAo1TCeF7rENp2NU81NgGm6ZEGQ>
    <xmx:_xWgZWzaJvdG8wLar4xxAWWmzbw1I4TrvQkQnV1pGxQ6FiNpiBrnFA>
    <xmx:_xWgZdo9cZRHyFCnZvQZCFOaXYFya1M7zqS3N3cZAGz2fw0UaU3cRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 68FF6B6008F; Thu, 11 Jan 2024 11:23:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5d2d8e57-0041-40af-b237-05f3275008bd@app.fastmail.com>
In-Reply-To: <ZaASsqnq5ZYdcjm6@lizhi-Precision-Tower-5810>
References: <20240110232255.1099757-1-arnd@kernel.org>
 <ZZ8wMWQMo4eGnSuG@lizhi-Precision-Tower-5810>
 <343cedc4-a078-4cf8-ba3b-a1a8df74185b@app.fastmail.com>
 <ZaASsqnq5ZYdcjm6@lizhi-Precision-Tower-5810>
Date: Thu, 11 Jan 2024 17:23:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.li@nxp.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Peng Fan" <peng.fan@nxp.com>, "Fabio Estevam" <festevam@denx.de>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Content-Type: text/plain

On Thu, Jan 11, 2024, at 17:09, Frank Li wrote:
> On Thu, Jan 11, 2024 at 07:23:34AM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 11, 2024, at 01:02, Frank Li wrote:
>
> It should be better link into same module because some debugfs and trace
> improvement are on my TODO list. Export symbols will make more unnessary
> complex.

Ok, I'll see what I can come up with

> Or simple exclude MCF_EDMA by change Kconfig
>
> config MCF_EDMA                                                            
>         tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"   
>         depends on !FSL_EDMA
> 		   ^^^^^
> 	depends on M5441x || COMPILE_TEST 

This does not actually prevent building both as modules, it
only enforces that you can't have them both enabled if one
of them is built-in.

     Arnd

