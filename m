Return-Path: <dmaengine+bounces-10263-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ap6DT6O/GlhRQAAu9opvQ
	(envelope-from <dmaengine+bounces-10263-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 15:06:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72C4E8E10
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 15:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E64301F4B9
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D33F23AF;
	Thu,  7 May 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuVsmwWr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47213F20F4;
	Thu,  7 May 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158791; cv=none; b=mw+LgbJS9H7SIY+1HCtVhslLOq9a4KZqLS4YB8h00F+GfN92CL94qWrbfOMwh9z+ylYgojzlrXDI10DrdqHGh57wSvKZbeMuCpj2JapCym8ZZ5v1tMOU8pEyWz4Jom/TFXhH7B0Eg91+rhSth/Nf7N6IYjd5dgAfhgPIvCupsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158791; c=relaxed/simple;
	bh=SPkdp1hAd3kbxPL1+HqVTfSGgCVdV7lIVFIOyf9qB3M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TBO0fKNhLXEjICoN4dLh8sC9S1yEbZEw0XeADe9loj+0oVdyDlP4urCXifi2mnQp2Eyc6/UFMvi+fUx0oSrKEI4REXaWhwoCobL9kd8V0NTQaf66LtfkuzJ1yrXAQTh1Snzrzlx9ww8BZlbwt2G9n7ouOEhYnSGgC62akcIDdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuVsmwWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7648DC4AF09;
	Thu,  7 May 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158791;
	bh=SPkdp1hAd3kbxPL1+HqVTfSGgCVdV7lIVFIOyf9qB3M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MuVsmwWrACEvMVGOT6T62XSIRW5C6lut1XjzJv8VMgV7kv6fBgg/3Cw/GNR+uRfi8
	 CgMkARZjEIRgfY+YzGltkW3xeGf25ZPsuwxHYzSHwBxSaLWH0TM38r2EQ6FE+gsoga
	 wcy9AypcEoOVj4gO4khQ/1uhjFAtzsUPgQTO28Vp9ItrAth58+77aKOLcUElthKBum
	 PpSOq+v5ukaMF0cPIpxGsh+20YSvM2lb3m5u5LFsn1WghiJbuSjJajAUhgnx8G/779
	 uCTPlo28aAn1TUghVoItw+BILS9jlJC1tMPM9P3Qzf0b85avMKVab+xPRXvL6zEnYc
	 q8HiuvRK+k2JQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 817D0F40068;
	Thu,  7 May 2026 08:59:50 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Thu, 07 May 2026 08:59:50 -0400
X-ME-Sender: <xms:xoz8aVBolen00sW23GmU_yryCHf-zOEL9iXr-Y4eiKIHwOFLzNgZaA>
    <xme:xoz8aeUdpBXoUJLkQdRh1Vnr7qihBkFSsdFf-iYpGDOMRr8RQWMdGVqRvNdd1JFc3
    Rnft1FigRvBlWWdrh2YYegLzlKmThP3t1BRk6MuHjULEqQyEFNxiDtF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggu
    uhhrvghghhgvlhhlohessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepohhlthgvrg
    hnvhesghhmrghilhdrtghomhdprhgtphhtthhopehgvghrgheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkh
    drohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xoz8aWS6Dbd7vLZ9DfWLWri47kgjf6hFSspF3rk5dLP6blJ7z0-k3A>
    <xmx:xoz8acPqH-S4hI1w0plNhTt9Z6EQIvDRHoCdx6ANHd_81QGNTqMZ4Q>
    <xmx:xoz8aUgjTR3zU2EW93PQJQq91aeHmyeyWe_7AUm8II-ZW185vezDVA>
    <xmx:xoz8aZmctjWvS7E15xE--4swG_Bmnyoag4GGxu_H708S60ibJUzwOw>
    <xmx:xoz8aQhcJG6RGWfgHmC2ckoc5oLid6ge9IfBiKTBdukoMrH1cTYnvImV>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 600371060066; Thu,  7 May 2026 08:59:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am-_gogYW4uZ
Date: Thu, 07 May 2026 14:59:30 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Greg Ungerer" <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "Angelo Dureghello" <adureghello@baylibre.com>
Message-Id: <4a617879-5147-4595-b6ce-ef3391b936d9@app.fastmail.com>
In-Reply-To: <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA72C4E8E10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-10263-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 7, 2026, at 14:43, Greg Ungerer wrote:
> On 7/5/26 05:12, Arnd Bergmann wrote:
>> On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
>> 
>> I would suggest marking these as explicit BIG_ENDIAN rather than
>> NATIVE_ENDIAN. The effect should be the same since coldfire CPUs
>> cannot run little-endian code, but the way that hardware usually
>> works is that the endianess is fixed at the bus level to one way
>> or the other. NATIVE_ENDIAN to me implies that the registers
>> have configurable endianess that is switched along with the CPU
>> mode.
>
> Ok, will change. I chose native endian in this case since the regmap config
> entry used for the m5441x family is also used by the vf610 devce (which looks
> to be an ARM imx SoC). So it will need a duplicate setup with those endian
> flags set to BIG_ENDIAN. But that is no problem.

Sounds good. In this case, splitting it up is technically even required,
because you can run a big-endian ARMv7 kernel on vf610, so the vf610
entry has to use little-endian registers rather than native.

I don't think anyone has run big-endian kernels on vf610, though I have
heard of users testing them successfully on i.MX6.

      Arnd

