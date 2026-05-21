Return-Path: <dmaengine+bounces-10688-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKgjNNk6D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10688-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:03:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F85A9D0B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9178C3682F92
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49C368D40;
	Thu, 21 May 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b="MMFq36yT";
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b="Zq3CXr0l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-65-142.flowmailer.net (mta-65-142.flowmailer.net [185.136.65.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B5345CBD
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377863; cv=none; b=SZ9bjb1ez+Rd3QS0ied0xVq0j6eN/SlK4kRCZoJvZJeejE972Oi78lQh4gtLng4Alss7VmzQVcZz+O3hYCzelC9zTiycnoeTs3iZaa5V4m5ZON/Sj50B6lMYwugvslGQu2htevSFGMW0O0Ql5M2YQnh04aPYz1gy/L5BnqFkVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377863; c=relaxed/simple;
	bh=ueEF+bxWvWqR586sT6h/9OE/noXhk1FsLD5ozFIo48g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca8Tl0GLP+3NlMoxBMmR+pEZECvlo3cTKjxLg6lyhpZh6obrUOCGULAOm70chPFF6dteJIS7zBUt+w3edSSgRTnYIFHYZlIMUM+y5wxQeoGtOlxuvduQT3cH05rgRbTGJDD/qqRW1Tv2+pSrKf4X0zXVMq8HgL0ys6Rrb06vPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com; dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b=MMFq36yT; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b=Zq3CXr0l; arc=none smtp.client-ip=185.136.65.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Received: by mta-65-142.flowmailer.net with ESMTPSA id 20260521153732fa24ffd4bf0019fd3d
        for <dmaengine@vger.kernel.org>;
        Thu, 21 May 2026 17:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=KcRzYfxPkdiV7UzaW+6lIfDEOBCRNUcUcG27X2U1VSs=;
 b=MMFq36yTf/DJOdkiWD8dxyVJTeBb2CpUxQWl6ikCBdoeyzPO1YF1TlVatLLSDsvGHWcQd5
 VDsmO4GbpHypEfkjO53Qz6kghqkYW63SBOu0Z3QcrtuSqWyhCWSOJvxnT/UwU+hUbYuuGM0J
 HuZSr59c5et2+K6wbsqMmvXOzxMIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm3;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=KcRzYfxPkdiV7UzaW+6lIfDEOBCRNUcUcG27X2U1VSs=;
 b=Zq3CXr0liSNgT0BCELoEs6XA0YM8cHIjZYr0stylqb6wFZbahGV2hbEmOBF/1TqoTWIGML
 pQmKEA14s3UI+M6MccDXkCrApiCPspbcb8X1z4i0qqkc0XKsEuZWyaX++RCNyx2Oho4OkebH
 CljyjSOBruD/mCsSnEVDpu/bRn9huDA1sfKAPLG4TnjoGEs76ifH2dvqbyplGH4LM/bN//MJ
 TbAfvH9UHgJigDJ9qujRe7uPZe7uulWgnP1HXFpgW6KlqYd6iasg0kXPD7frFGW+6jdQlaQd
 pc5Ftr3JZPBE4ZdvXY4aK24gQwmJHg5mcdt41zeDIsJIor2N0FKdzstA==;
Date: Thu, 21 May 2026 17:37:29 +0200
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-doc@vger.kernel.org,
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
Message-ID: <20260521153729.ig2xgvskkbg3nx47@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
 <76af64fa-7820-4d92-8aa9-826c3bd812a1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76af64fa-7820-4d92-8aa9-826c3bd812a1@app.fastmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens-energy.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[flowmailer.net:s=s1,siemens-energy.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10688-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,kernel.org,sang-engineering.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuster.simon@siemens-energy.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[flowmailer.net:+,siemens-energy.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens-energy.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,flowmailer.net:dkim]
X-Rspamd-Queue-Id: 523F85A9D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arnd, Dinh, Wolfram, and Miguel,

thank you for your explanations and encouragement; I've now sent my
application for co-maintainership for arch/nios2 to you, Dinh.

On Wed, May 20, 2026 at 09:06:33AM +0200, Arnd Bergmann wrote:
> I think that is a reasonable target. We have a bunch of embedded
> architectures that have a similarly small user base and I expect
> that we will want to remove most of them at some point, as we did
> for seven architectures in linux-4.17.
> 
> As long as there is a maintainer for nios2 and it's not actively
> getting in the way of a specific treewide change, I don't see any
> reason to remove this any earlier than the other ones.
> 
> Obviously at some point nios2 will have to get removed because
> of the limit to gcc-14 or older, but that should not be a problem
> for the next few LTS releases.

This all sounds quite reasonable, including the toolchain
considerations. Thank you for the offer to keep it around a bit.
If any issues arise with tree-wide changes I'd be happy to look into
what can be done on the arch/nios2 side; now that the issues should
reliably reach me via mail.

> > Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> > unsure about the netiquette (can I simply do so by self-proclamation? At
> > least the git history seems to suggest so...).
> 
> Dinh already replied that he welcomes the help, and I also suggested
> the same thing a year ago. As the only known user that has contributed
> patches in a long time, you are obviously qualified.
> 
> Sending a patch for the MAINTAINERS file to Dinh is the first step,
> once he has sent that upstream, you can (optionally) apply for
> kernel.org account that would let you host a git tree on kernel.org
> or have a tree that you both have access to.

I've sent the patch, I'm sure we can work everything else out from
there.

Best regards,
Simon

