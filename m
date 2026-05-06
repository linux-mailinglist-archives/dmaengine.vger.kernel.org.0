Return-Path: <dmaengine+bounces-10242-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KUaMdmS+2mrcwMAu9opvQ
	(envelope-from <dmaengine+bounces-10242-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:13:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C93184DF9F5
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1A083008467
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBD30EF63;
	Wed,  6 May 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ02v9Yx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D121ABD7;
	Wed,  6 May 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094804; cv=none; b=YwUeHP5soQhU98cA+cxtRZn/00DfS+5KmH1aVKQm4wIe1tQCny0SEXmfZRfbQ0GOrQhjM+xDzLavqOBXmVlBFp4mtGgqX0vuuzs9zwC3VB9nWVm/MUK4umb5dWHMKUK8tt02+lChWUqN8Uwilxzr4IQrWkHReGcnQGjRNCHKKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094804; c=relaxed/simple;
	bh=MwzrSQ4fiAmN5nCFQCemXjP5zzuycMBMfVig9YY1FLY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NKVa0RJpYeYuKUrfhFl2fbGrF8NAniwbpSb+648nwyGlWKlcnivHVI6+7ggyLKvCKm9ujfyjJuLRfan6MBb489erLG0MbVSd6xzUsfNjCHpr52nSSQbfM7kXHJ8qjxBKkv2dPh6i2CsBdr0bPtcmh0gKsStFVX7EDFFI+3qqAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ02v9Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E98C2BCB8;
	Wed,  6 May 2026 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778094804;
	bh=MwzrSQ4fiAmN5nCFQCemXjP5zzuycMBMfVig9YY1FLY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FZ02v9YxnFq6tkTW2U2IYKgfy1R5OeW2RxUXfrE5CORSM44w3lmwYWSRbc9zTmtbC
	 9w+9FABbQMs73fZuz9PGA1PF4kB6Z0EnlVZUIUGOd+wYQORgSrNRN4wKPCsj3ZCTSY
	 Vletv8j66HKNScuONplbkmag4upfxN0+t5fXn2B1Ku78puhMiZrEiXT/DQ+EGGVfC5
	 LoTV13pjwzQhUj4BMip0tH2tIXS8MQr/licueoPuX9lSHSiA6KQv5JCwr8b1oVQ7yi
	 DdmUPsX7vuSaK7W9+XlwZ3BpaaTjScr8jwy5rkxUBL0JQ9QcI873tghURnekyhl4WT
	 JmKDL+EzGpkVg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2865F4006B;
	Wed,  6 May 2026 15:13:22 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Wed, 06 May 2026 15:13:22 -0400
X-ME-Sender: <xms:0pL7aSXPA8QHNQbds6W5BUsHcdxhIHmw-NHMJYY2GkR68z0qE5G7Sw>
    <xme:0pL7aZZEZckVx0og8towP9gINkoFRvIccL_qhqB0hOatU8r3FLZkK34eY0hKE1ouM
    fwZ0Jw-gy0uGTuOaugXnJ7PhKuygRq4w68ZIRVuFLNrKEtWWpsR8k8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggu
    uhhrvghghhgvlhhlohessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepohhlthgvrg
    hnvhesghhmrghilhdrtghomhdprhgtphhtthhopehgvghrgheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghp
    thhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgtrghnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0pL7aYgU40u_E267iFRC27ZHEl0roArdH9mPSMUcT3gkwqS8N7dJMw>
    <xmx:0pL7aXBlhAotVrZFHrdE6GWeSDVXfgQGR3DslpyIThc1JnlGgenU1Q>
    <xmx:0pL7aa45gqQbrCje9y2vZPHLRAXayJ7R0JUFs-8aM0231oG8RsT-aw>
    <xmx:0pL7acHzHt7XSIMXTOeqamF765eGiHjToQWiZ5zqkI4f1k4RM9AK5A>
    <xmx:0pL7aVDxk__UOgD53mk0418hw-fLbXikrmm-QP75gByQBb2p_AhysOC_>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FABC1060065; Wed,  6 May 2026 15:13:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am-_gogYW4uZ
Date: Wed, 06 May 2026 21:12:42 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Greg Ungerer" <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, "Greg Ungerer" <gerg@linux-m68k.org>,
 dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, "Vladimir Oltean" <olteanv@gmail.com>,
 "Angelo Dureghello" <adureghello@baylibre.com>
Message-Id: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
In-Reply-To: <20260506142644.3234270-8-gerg@kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C93184DF9F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-10242-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-m68k.org,gmail.com,baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:

> drivers/dma/mcf-edma-main.c
>   Supports big-endian access by setting the big-endian flag of
>   the drivers struct fsl_edma_engine. But locally should be using
>   ioread32be() and iowrite32be() instead of ioread32() and iowrite32().

I'm still a bit confused about how this works at the moment,
since the drivers/dma/fsl-edma-common.h file already contains
checks for the edma->big_endian flag, which is set in
mcf_edma_probe(). The version after your patch makes sense
to me, but it looks like the existing code cannot work.

> drivers/spi/spi-fsl-dspi.c
>   Setting the regmap format_endian flags to use native endian will
>   force driver to use appropriate big or little endian access on
>   whatever platform it is built for.
>
> These drivers have only been compile tested.

I would suggest marking these as explicit BIG_ENDIAN rather than
NATIVE_ENDIAN. The effect should be the same since coldfire CPUs
cannot run little-endian code, but the way that hardware usually
works is that the endianess is fixed at the bus level to one way
or the other. NATIVE_ENDIAN to me implies that the registers
have configurable endianess that is switched along with the CPU
mode.

       Arnd

