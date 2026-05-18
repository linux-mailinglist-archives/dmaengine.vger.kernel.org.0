Return-Path: <dmaengine+bounces-10507-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIkVA8XwCmpv+AQAu9opvQ
	(envelope-from <dmaengine+bounces-10507-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 12:58:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A1C56B14E
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B454A30038EA
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2BF3EFD1F;
	Mon, 18 May 2026 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oaydknFL"
X-Original-To: dmaengine@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CE3CF680;
	Mon, 18 May 2026 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101889; cv=none; b=TfgvuwzCEI0Seko26+ALIdBTcUATqeXfkIXLgb0KWPLgJNBeGXTGZpEw59BLiZCEjaK50sSj+D3eDNj72cSBBOWolZzng+WbRKFg9gGUKBzZoqhwumwABprqW45LrQhZNtmW+qcqTvKgacInIMJOT+IEHre0xRAOQ8kF1zEc088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101889; c=relaxed/simple;
	bh=CeJdp63t5M3yrMI58BNBOA4lTzNvLQlOWbKDErRCEaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyowQN+JroVJfEIo2v/kygpXyNFrxcLkEdvf9zACXdBok4tMEaurZAj43IF1E6TKbcvbr4FjZV7LLKmGMAuL8SnlqYtAzdZ8ov7vQohfKuRS9OeVuAEhfOroxeuQO8nTHYzsszEOVbevAejd+s4viFjla2y8ISDASuVzFPIwvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oaydknFL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jBVg5PAElT/VJaPv+0RYYYnJBg28cPCXxION0Y0Lv4k=; b=oaydknFLp/ZK1dYVkG8aeaicn4
	tL8zn5YeFiI4wR8LwtlU5+J57P84vdG88LIZgwZyUqoBwsb6cJCKJ5KZGd2c/3AGzOVPXCLF2kmB8
	8U7N0P6tDEQs90979e5/EUmvwWH7J/OrNiRpwUskUsse4lGRaVrJ2pu1fF6GcR7aSJwbY7pWs06hA
	7t4sBerD3jWTQMAGXm1LSXYETXKuukJY1ngImNn+ebXj4m4P/onLMBfLQnxqWYf6zRvehFm8Z8fbu
	+0nTRjXX3PqW1knekPfczMPT+Sd3qcdNc9JzLFcqjNsA0kMe4HgIx/hWZJDOQ5cM0fR7S8w8GURIp
	RMQ12bOw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvfE-0000000AqRU-2NAG;
	Mon, 18 May 2026 10:57:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 730F53007A4; Mon, 18 May 2026 12:57:35 +0200 (CEST)
Date: Mon, 18 May 2026 12:57:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, workflows@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
	Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Dinh Nguyen <dinguyen@kernel.org>, Kees Cook <kees@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
X-Rspamd-Queue-Id: B3A1C56B14E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TAGGED_FROM(0.00)[bounces-10507-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 11:29:48AM +0200, Arnd Bergmann wrote:
> On Mon, May 18, 2026, at 06:28, Ethan Nelson-Moore wrote:
> > The Nios II architecture is a soft-core architecture developed by
> > Altera (since acquired by Intel) and intended to run on their FPGAs.
> >
> > Licenses for the architecture have not been available for purchase
> > since 2024 [1], and support for it has been removed from GCC 15 [2],
> > Buildroot [3], and QEMU [4].
> >
> > Given all of these factors, it is time to remove Nios II support from
> > the kernel. The maintainer stated in 2024 that they were planning to do
> > so soon [5], but this did not come to pass.
> >
> > Remove Nios II support from the kernel and move the former maintainer
> > to CREDITS. Thank you, Dinh Nguyen, for maintaining Nios II support!
> 
> Hi Ethan,
> 
> We last discussed this a year ago when Simon Schuster mentioned[1]
> that Siemens Energy is still using NIOS-2 in production and would
> prefer to have this still included in Linux for at least another
> few years until the obligation for kernel updates ends.

Isn't that what we have LTS branches for?

