Return-Path: <dmaengine+bounces-10519-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIceK2VYC2oCGAUAu9opvQ
	(envelope-from <dmaengine+bounces-10519-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 20:20:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343457225B
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857AE3208F77
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DDC389116;
	Mon, 18 May 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b="oOv4FfQQ";
	dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b="dI1aE97G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-65-134.flowmailer.net (mta-65-134.flowmailer.net [185.136.65.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694E38AC7D
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127507; cv=none; b=FV5WpAsSkpL5s1m/fYQ5Bu/6957AiwpPQKllRJtKpUhNbTBrp7qKtafi/FdvIiMgvgS53neWl/l7obuh4aeEKl806qz5CgguT7iKjgP5UEfLypH9dh+Q257+dm0svL3S5dgvomSmcDZX/MMwpZT9hn2SNsriIkuBnBMyfuj5KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127507; c=relaxed/simple;
	bh=+rYo9RwlleK8Myvw5KVXSvl5djJdJZXOJbD7irbefyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBYrkp8Mk4dj4cpX9HxxPWJRkUIhUVVYm6vGfbQ0ro54nUdrnZpnki6v6gU3bFC4PUGYj2JeOhXq66TUso80La7MfiZZEUwbxda1PQe5gtCBfWl2qqA6CFkSaKAvIjEOFccIe9w0yfwxfmeSkN9v/l1rIM05T4YncN4JNoyR0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com; dkim=pass (1024-bit key) header.d=flowmailer.net header.i=@flowmailer.net header.b=oOv4FfQQ; dkim=pass (2048-bit key) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.b=dI1aE97G; arc=none smtp.client-ip=185.136.65.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Received: by mta-65-134.flowmailer.net with ESMTPSA id 202605181724462a1312131f0019fdc4
        for <dmaengine@vger.kernel.org>;
        Mon, 18 May 2026 19:24:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=/xBoFD2ZNsbMOTky3B3enP8bn+W9UZXo1Hl2aVCLXos=;
 b=oOv4FfQQlHtS5BCboX78gqtA1vOdIzc2Bde3Q6JtaXyf67I3yyl6ut16FqBNN9+Yj9rq9Z
 nyDRk4mSBg/XXlSyTrgBcXgDhCrmwyDzEj+K3hddaJfeuwolNJkOXXJ8o46GUX+ljc6wR96d
 SFujsYOnihqEglQ5vlocmhDkHNiKg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm3;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=/xBoFD2ZNsbMOTky3B3enP8bn+W9UZXo1Hl2aVCLXos=;
 b=dI1aE97GXW4w7iNDnE322TQwRLqhXPJ7u7OOtHXqPwbH7I8b7QZPUcsZ5dpM3aKOX+wuYT
 LPsjcYlVTxPExZ5kMJNCcDWODnTNTrGp6pV8qtNcwDcVLy69NW0vpvbVMGwrINlSJJ+x3xuE
 8IjsHXj0AnDwTdczWEYMyN3ZXAMnYVljNLinrYheZqc9sCRB5uWpiqfkBE0KYz9ZVSj4gXWO
 W3XtjKRwxfg4DG16B+5mpyk1TGNVwWG+Fbcs2a0kj3mxu3xIuWEGyaVHCYP7ptwU5BzA0nrO
 6VN6z+VVxxOzsIQ5H6Xp7Kj7GVjsxvKu6BvSATf/LyzOGeeNKmSh+lOw==;
Date: Mon, 18 May 2026 19:24:44 +0200
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V (Arm)"
 <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank
 Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, Andi Shyti
 <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 WilczyDski <kwilczynski@kernel.org>, Andreas Oetken
 <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens-energy.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[flowmailer.net:s=s1,siemens-energy.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10519-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[infradead.org,arndb.de,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[flowmailer.net:+,siemens-energy.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuster.simon@siemens-energy.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,siemens-energy.com:dkim,flowmailer.net:dkim]
X-Rspamd-Queue-Id: 1343457225B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ethan, Arnd, Peter and Dinh,

On Mon, May 18, 2026 at 11:29:48AM +0200, Arnd Bergmann wrote:
> We last discussed this a year ago when Simon Schuster mentioned[1]
> that Siemens Energy is still using NIOS-2 in production and would
> prefer to have this still included in Linux for at least another
> few years until the obligation for kernel updates ends.

First off, thank you, Arnd, for remembering us as this patch series came
up and also to Dinh for his maintenance of the architecture!

Regarding our status in relation to nios2, Arnd's response already gives
you the gist:

We are well aware that the architecture was deprecated by Intel and are
therefore phasing it out in favour of more contemporary hardware.
I'm also fully aware of the uncertain future of 32-bit architectures as
a whole [0] and that this fate will come to nios2 sooner or later.
But as of now, the mainline support is still in very good shape.

On Mon, May 18, 2026 at 12:57:35PM +0200, Peter Zijlstra wrote:
> Isn't that what we have LTS branches for?

Unfortunately, as we are an infrastructure provider for civil energy
infrastructure, the refurbishment cycle is a bit slower than for
traditional consumer systems. This implies that the traditional LTS
support duration (max. Dec 2028 as of writing [1]) is rather short, and
we would be glad if we could keep the architecture in mainline for at
least 5 years and only then "decay" to LTS.

On Mon, May 18, 2026 at 11:29:48AM +0200, Arnd Bergmann wrote:
> My feeling is that the maintenance burden of keeping nios2 is
> relatively low. On the other hand, maintaining it out of tree
> as a patch set is also something that should not be all that
> hard if it does get removed.

Judging from the architecture's git history, it seems that it's
currently mainly touched by treewide refactors, which are extremely
helpful as we therefore do not have to piece these changes together 
downstream. In other respects, we try to be good citizens and contribute
bugfixes as well as required cleanups (such as implementing clone3 [2]
and fixing its flag behaviour on 32-bit architectures) as they come up.

If desired, we also would be happy to intensify our support regarding
reviews or testing to share the maintnance burden if it helps to keep
nios2 in mainline a bit longer.

Best regards,
Simon
 
0: https://lwn.net/Articles/1035727/
1: https://www.kernel.org/category/releases.html
2: https://lore.kernel.org/lkml/20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com/

