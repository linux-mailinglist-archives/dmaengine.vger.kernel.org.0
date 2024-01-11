Return-Path: <dmaengine+bounces-719-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECB82A789
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 07:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE51F23A89
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD7FBF6;
	Thu, 11 Jan 2024 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GkipVFTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/8wUkSJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A202FBF2;
	Thu, 11 Jan 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id BE0CE3200A7A;
	Thu, 11 Jan 2024 01:24:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 01:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704954257; x=1705040657; bh=DrHB+y9Pgc
	vV0CSGp8H420Yn6g7abiIoAQ9Qr6Gyars=; b=GkipVFTE0PStlL9e/y52pEHOHM
	+nDgLIhX+lPWbqe7arZFqGvrxEt/mZ2l+BGl0OvhbIbEPvLfL1/Y1Qngp+0+Z+aY
	ua4T6YTQxQl6G1i4M4Dx9lXbiodzGTXB0ZCE6zn5qhxfmc//SR0UyHHkypMqGs21
	GVTc8LiPYV2ObPT2XVVQflil3evqzbZ5gOu1J/5jZcrQjP2mG6chgGRBCUuNmbIO
	276SYaLT+zSGmYn2LS3pQ8xEMnqywOtbo2oRX7dTggg3QFaRs0Uwi9URroObMNf1
	A85G+p0O8KWiXf/pV0YFXLRvK/YBlm5FPQeJQBa/sawDBpG+G1CKdlMFniNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704954257; x=1705040657; bh=DrHB+y9PgcvV0CSGp8H420Yn6g7a
	biIoAQ9Qr6Gyars=; b=Y/8wUkSJEobH2iVWvcsm87q14HOzEf7pmiM7brlRtgQX
	4L/XOIQ3jsYxcIELJUxK/d5vS4fg4bOf9TrGu9/+HRslPN/3bzXGndLFMq2u5mA/
	1X8DZhvGY+RucQ7w/2slxRdFODZA4i7KOf6OdbuxnWyKx4tF05DUN1drg3YKrHbe
	3uKiuIKe6XyazwypVu4xDflhDoAOa1KSGMFKiMQyO8qCAPtaDokB2ioy1sYLm9LU
	joRdj6mJ3ikCQBFIpiqaj+huP+Gbf6ZtVDeGqAaVnekDjpLcHrJUSjOzCZgPRdL8
	jnxMLt2UJMOPdVusDcoeSqJj2s3LyklhjexnBI7m6g==
X-ME-Sender: <xms:kImfZToohpB0iiVwCIIpSA4gA8h7hnsWXOMP1kX45e4dmbma1uipEA>
    <xme:kImfZdpYsbq9wZTS4w6n_ZGDR_1uhdy7I8Nttm2_w71c6dyIx9PEn8b8iBRB4f7BL
    Ox0xvU51Q6rj8Hrtg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kImfZQMJr7-RRGACZLQVMhlKrezabwoIQZr8tLGh9sHILBFP-TjdVA>
    <xmx:kImfZW70Rg18t07fBnnqOk5jWKeaPE8d7rS0if3N8_In5hv4BRVotw>
    <xmx:kImfZS6rfFwcP9SjhxgzptIJvPsVAlIDJIycNmX4dOtn1SsNwYMtOA>
    <xmx:kYmfZUSa1bIot4l6cbwDd7RBweTaKAxT-SNfrk_Eo9CQDZGFWdFhqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D2E92B6008D; Thu, 11 Jan 2024 01:24:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <343cedc4-a078-4cf8-ba3b-a1a8df74185b@app.fastmail.com>
In-Reply-To: <ZZ8wMWQMo4eGnSuG@lizhi-Precision-Tower-5810>
References: <20240110232255.1099757-1-arnd@kernel.org>
 <ZZ8wMWQMo4eGnSuG@lizhi-Precision-Tower-5810>
Date: Thu, 11 Jan 2024 07:23:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.li@nxp.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Fabio Estevam" <festevam@denx.de>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Content-Type: text/plain

On Thu, Jan 11, 2024, at 01:02, Frank Li wrote:
> On Thu, Jan 11, 2024 at 12:03:42AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> A change to remove some unnecessary exports ended up removing some
>> necessary ones as well, and caused a build regression by trying to
>> link a single source file into two separate modules:
>
> You should fix Kconfig to provent fsl-edma and mcf-edma build at the same
> time.

That sounds like the wrong approach since it prevents
compile-testing one of the drivers in an allmodconfig
build.

> EXPORT_SYMBOL_GPL is not necesary at all.
>
> mcf-edma is quit old. ideally, it should be merged into fsl-edma.

I have no specific interest in either of the drivers, just
trying to fix the build regression. I see no harm in exporting
the symbols, but I can refactor the drivers to link all three
files into the same module and add a hack to register both
platform_driver instances from a shared module_init() if
you think that's better. Unfortunately we can't have more
than one initcall in a loadable module.

     Arnd

