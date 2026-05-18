Return-Path: <dmaengine+bounces-10520-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF2fG9Z6C2orIQUAu9opvQ
	(envelope-from <dmaengine+bounces-10520-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 22:47:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E197F573886
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186A1301E3F7
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC5395D87;
	Mon, 18 May 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hIDL4Pci"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAD391E74
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137222; cv=none; b=H3TEWiWIRjrvDNncuua8ZRiGK6dLap+NmQj+UOt2aE2RLlzYuHfy1KZt37qFPe4frkUAfNib9NxdMf1Iut9QufUqaefdqkxPtU7oKmSLUgcGIn2PchASb8hI6uDUMI0089RGzAEA5vSkvAOnmOa0wqr6sTxSyLXmBkOtr6Yu45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137222; c=relaxed/simple;
	bh=Ju0bBZL4gIhDXt1wxIRcD+B9cM8rwS33tQQtnjcKUwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MstEtXG2uWP3gthj6zHN4KBs6BAy2TsxNDERH3FfRddo0U1L3du21jlNE/PKEvz9bAXc6wfnT6hYOzzjMlCHUbxupdi3I4lt+xRgPo+nzyuic+bN9V5zqnhr5NqeXe5vpZ9OCaZctTIK3uEW0Fdira/9Kz5VhIKiPo/eG3yCJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hIDL4Pci; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=L52K
	0rxWySw3mD5z7jnwvPV6H6bdzA5sgxRy/hQVyAI=; b=hIDL4Pci78/puo7y9yQi
	i2QwANMnkO9c+JN2J1AuGPGc7VaJw5mv5oB/Zi5V2NpOtmNWm9XOO1R+IJNZFnZR
	meEUR+IwLqIIqHU3FlF+jDqISV7XhoIBKJj5YhCwfcISYldprr8eaDDjBG3r5TZw
	mxP8JHNcHv1dzvI+ZmsQ1fBQiFdtCyshmDbAh204tTJkZb0f6TFW0ExyfM/Kk91P
	wss0BhGJm15JjnmFgKwqDs+m+p0q5M7k+F6MldfbQ6dnZbJ07U0epn56qjQWMMuA
	laR67xnGRvGP5v3vFrD1q2AD1KEOA7i38hJabnRO/72MrxDt/qCiKctVFaQbZ1ji
	mA==
Received: (qmail 5619 invoked from network); 18 May 2026 22:46:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 May 2026 22:46:55 +0200
X-UD-Smtp-Session: l3s3148p1@dIu7qR1SQNMujnuR
Date: Mon, 18 May 2026 22:46:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org,
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
Message-ID: <agt6vy3WtjFy9sfU@shikoro>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10520-lists,dmaengine=lfdr.de,renesas];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,arndb.de,gmail.com,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sang-engineering.com:dkim]
X-Rspamd-Queue-Id: E197F573886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

> downstream. In other respects, we try to be good citizens and contribute
> bugfixes as well as required cleanups (such as implementing clone3 [2]
> and fixing its flag behaviour on 32-bit architectures) as they come up.

Well, this is definitely 'good citizen'...

> If desired, we also would be happy to intensify our support regarding
> reviews or testing to share the maintnance burden if it helps to keep
> nios2 in mainline a bit longer.

... but given this, you might want to get added in MAINTAINERS as
reviewer (or even maintainer) for nios2? Besides that your efforts are
already worth it in my book, it would also ensure you get CCed on
patches like this. Then, you are not depending on people like Arnd
putting you in the loop manually.

Happy hacking,

   Wolfram


