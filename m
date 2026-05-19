Return-Path: <dmaengine+bounces-10532-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMSsFfhFDGrQcQUAu9opvQ
	(envelope-from <dmaengine+bounces-10532-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:14:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42357D4C9
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533E43077C16
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151D40626F;
	Tue, 19 May 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JZuc7r6s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B23750CF
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188146; cv=none; b=RaGcNiYv2BY6xGk0dRCJNe3iM0S4c0PPEA25WLKReUwFr55MXC74RAwGXPcSwAgOsdUHCcVLeEyX9nTVv2HW6ts0DDu/Udxm9T45Id3fBxLogtJBxdIvCQBqyaJLYrtXMwDEXKywknvuFZBpftQNVIzLtevGI0I1vT3mb1w9Ibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188146; c=relaxed/simple;
	bh=epm/rDej+X6xivgo3qDkqkpt7/nAmMLgz6CdD6F1VS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayqg92DkLTgnBxfyLgEEAPT+lV7aCpjYp/vqwjD0IJVMOh+4iDpp37+2vlacuRVQ2rbA+bb2kF3rc0G50zqycGeLGOFm6W5OE1QSeYel+/3Ftmsam31i03mEsGxI3sJuxI1kf+hWgOnTBuo/0RaUrJ3VV7vjtdkfC1hGIxWc3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JZuc7r6s; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ofMu
	xF8bxqlikw5Ek2X0UdXIpwNSL1SykTjDOTUnzDg=; b=JZuc7r6sNKpv5+G4eKdZ
	6LTJGSD96jwpZFGVxfF8Sk94OZAnm4AScbYH1RSQcKFu0SlPL6yD2lMGQ+JlrBAe
	77wZTXDbpz0y1UQ7Gnkkm1XyX8GcHvPLPIBUMSlKEyfC0Z5rGJa+mfOe1WOFwl/X
	84A7vrtDhpwegqZo9785QoiyIaGL5VqYDzVrDyHsCgYUqL3bn/aDcI+IIQXlEJZ/
	tija1Beh0DHaoQ0fumfywDN6WCprvbxEeRlEpI5K3bsTGql/lRi4zDBWTA9wraF/
	5EkYK/G9nBrL73L6PZIfSR46Wy3kihyHna5iGU30C/9IGOEaglcswGNETSxw+/9E
	5Q==
Received: (qmail 233840 invoked from network); 19 May 2026 12:55:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 12:55:38 +0200
X-UD-Smtp-Session: l3s3148p1@jaz1hClS+JlUszca
Date: Tue, 19 May 2026 12:55:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
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
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof WilczyDski <kwilczynski@kernel.org>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <agxBqd-ubOL2_i-j@shikoro>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10532-lists,dmaengine=lfdr.de,renesas];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD42357D4C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

> > ... but given this, you might want to get added in MAINTAINERS as
> > reviewer (or even maintainer) for nios2? Besides that your efforts are
> > already worth it in my book, it would also ensure you get CCed on
> > patches like this. Then, you are not depending on people like Arnd
> > putting you in the loop manually.
> 
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

In your case, you can do so, I'd say. You explained your very reasonable
interest in the architecture and have already shown efforts to keep it,
as we can see from the git history. The final call will be done by Dinh
Nguyen obviously with whom you probably need to sort out details. But I
can't imagine your offer for help will be rejected, quite the contrary.

Happy hacking,

   Wolfram


