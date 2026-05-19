Return-Path: <dmaengine+bounces-10531-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMTBBmQ+DGqPbAUAu9opvQ
	(envelope-from <dmaengine+bounces-10531-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 12:41:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7457457CA13
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4195D314A5EF
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE87233949;
	Tue, 19 May 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b="EZaazZKd";
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b="Te2jAfZD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-65-133.flowmailer.net (mta-65-133.flowmailer.net [185.136.65.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BC233942
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186622; cv=none; b=iYl24obbJBepLY4mKXSmUnQv1NrwE2wVscpcbMOkHxQxL2pY53WUvQpDj4I/eEwo7zzSr1ZauNhAdZPIwpF0iXgDN6u/hVlz0901jMNNs1pnkThyxAyj2OZ4Drlp/0giZUw1/8+kxWxHOA/mGZh0qb79UTffkqWkA1Rui6mpA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186622; c=relaxed/simple;
	bh=FMylFNF2LBIsDQTt92IHLCTEBM4Uc4LrYwy7HvJjx8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqZG83RNVUghJTCbT5aB1yFpSgo+hPvnXuYbk1fd2VlmUPR+GIbXwu0dkDzxp24B/Gcd7zIAz5TscWG3BzovT5lgBSLy39XiUIuqdiC+yHLdN/jL6Dzzus8kikWuGs8s6GxctkTt6saXJwR25ZIRtNlWQq2Vi0yj1X7oYOU3zsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com; dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b=EZaazZKd; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b=Te2jAfZD; arc=none smtp.client-ip=185.136.65.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Received: by mta-65-133.flowmailer.net with ESMTPSA id 20260519103015bffc3728120019fd1c
        for <dmaengine@vger.kernel.org>;
        Tue, 19 May 2026 12:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=VQcumpK/VH7AMVe3D9QfBdm875bqYNSA1S/WhQcMd50=;
 b=EZaazZKd3ZONXRq4GpMzuNQLKWTjDM3BCDcJN1Zro5Jf4shP6ldQEZRd/JpK1AZ4rlK0YF
 /Aa7cioXIloqt5aLEMZp2zhOmX1/9l/6y1VhiFuSN27YZpJ0WrZoxkmuTSB8KOR9mJccLgIF
 U5YZLq88tEC65edr76mfk0J41cOEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm3;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=VQcumpK/VH7AMVe3D9QfBdm875bqYNSA1S/WhQcMd50=;
 b=Te2jAfZD7hDN23NQ3+54hePl7vopCgSM3JMxLh/fm7xcDVL3oowG/1GukwfDalvkw/93pk
 r1edcvtKHS8aMq6NRNiOadutVoT+ObgjmyLqPfqBF0IzKI4s/3l4Ljo3Ns0e8129/XbiB/f0
 eILgqZumYF4wXN2RrKqjT6iJT48jJyha8qiB1Ms2c7YCYUsoOaUZYeqchP96MjjkD2jP9Tnp
 Bup5ZCH2E2PIWkx0GqjYc7NY1+ofQc4JMbJbK42rmOgM8diRAjnGGhXNzlSI65tykwA8DWj2
 tjMUFpTA0awNupV3gXQUmo6aF83iBjTdaCqUN4ZyrwUBouDMkjB7zheA==;
Date: Tue, 19 May 2026 12:30:12 +0200
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, workflows@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook
 <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin
 <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, Andi Shyti
 <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 WilczyDski <kwilczynski@kernel.org>, Andreas Oetken
 <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens-energy.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[flowmailer.net:s=s1,siemens-energy.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10531-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,sang-engineering.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[flowmailer.net:+,siemens-energy.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuster.simon@siemens-energy.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flowmailer.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:url,cip-project.org:url,siemens-energy.com:dkim]
X-Rspamd-Queue-Id: 7457457CA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ethan, hi Wolfram,

Thank you for your thoughtful responses.

On Mon, May 18, 2026 at 05:13:58PM -0700, Ethan Nelson-Moore wrote:
> Your reasoning makes complete sense. However, there is an alternative
> to maintaining the architecture in mainline.
> 
> The Civil Infrastructure Platform project maintains super-LTS kernels
> (and a set of base Debian packages) for 10 years. They are intended to
> be used for exactly these kinds of devices.
> See here: https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_maintainership
> and here: https://cip-project.org/about/linux-kernel-core-packages
> 
> CIP will maintain kernel 6.12 until 2035. Is this long enough for your
> lifecycle? What kernel are you currently using? If it's newer than
> 6.12, we can easily wait until the next CIP SLTS release to remove
> Nios II support to avoid a downgrade.

This depends. For released/maintained firmware revisions we already
track CIP SLTS versions (candidates) to be prepared, the majority of which
is currently still running 6.1.x with 6.12.x up-and-coming.
But for the reasons outlined by you regarding architectural and feature
support in CIP SLTS, we do not, however, use the extended support duration
SLTS releases in production, and instead upgrade with the kernel.org LTS
branch release schedule and track these internally alongside mainline
to prevent major obstacles during version jumps.
2035 is still a rather tight timeframe for our typical support/phase-out
period (we would hope to get close to 2040 with the SLTS extensions),
which is also the reason for our targeted 'lifetime extension' for the
nios2 architecture for approximately 5 years, or more precisely ~2-3
SLTS kernels assuming the usual cadence of 2 years between SLTS versions
(+ some safety margin).

> Also, CIP focuses on architectures used by CIP members - currently I
> think they are x86 (32 and 64-bit), ARM (32 and 64-bit) and RISC-V.
> Since Siemens is already a CIP member, you can simply ask them to add
> Nios II to the list, and you can assist them with testing and directly
> submit patches to them once the standard 6.12 LTS period ends.

We have already been in contact with the CIP team (even though the
contact has unfortunately lapsed a bit, mostly our fault), but adding an
additional architecture seemed to be a more substantial effort.
N.B.: Due to past circumstances, we are a completely distinct business
entity from Siemens AG that merely shares the trademark and a common
history; but of course this should not hinder us from getting directly
involved in CIP (quite the opposite!). But this also requires some setup
time.

On Mon, May 18, 2026 at 10:46:55PM +0200, Wolfram Sang wrote:
> > If desired, we also would be happy to intensify our support regarding
> > reviews or testing to share the maintnance burden if it helps to keep
> > nios2 in mainline a bit longer.
> 
> ... but given this, you might want to get added in MAINTAINERS as
> reviewer (or even maintainer) for nios2? Besides that your efforts are
> already worth it in my book, it would also ensure you get CCed on
> patches like this. Then, you are not depending on people like Arnd
> putting you in the loop manually.

Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
unsure about the netiquette (can I simply do so by self-proclamation? At
least the git history seems to suggest so...).

Best regards,
Simon

