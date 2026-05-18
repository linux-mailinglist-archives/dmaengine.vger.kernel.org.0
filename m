Return-Path: <dmaengine+bounces-10518-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APBaFJYxC2oZEgUAu9opvQ
	(envelope-from <dmaengine+bounces-10518-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 17:34:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F6570108
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F9B305A737
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A843EE1FD;
	Mon, 18 May 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwZqROts"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE153F076F;
	Mon, 18 May 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118183; cv=none; b=exknd1zBqcU6Ne6V/wzA1Go+FmSdZWGiw7CVS6AY780tlOqy8D16kyfjVg9KfGdB7JM1bWPZo9LumJ84yEWtjWUOKJnf50OqYhsneU7i5eEZWlK6PPFYkZONsoP4R07jOqS9WIQW2XMbqZlzQmzuUUSLdHVNYYAQQZ3AO8o4IrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118183; c=relaxed/simple;
	bh=sG79W+MkJg5APZjQ0IZO8BppN8H3r5aAnNzI61jDF3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpvCWr+J1D5vOwsL9P8R+ucqn97HHCe1Fdo4XbTDXNNbP6w0V+Bu5Baq8H9gBN9jiarB6R5zjhXTtd9ESTjr0rRzw8Hwh9UEuuwjeVq5Z7ffbQ+MetDLcovvw1xComT42x7SJEEmE9EE2GaC+AIH7ijGXJcomZH8XpifgKImJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwZqROts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022C5C2BCB8;
	Mon, 18 May 2026 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118182;
	bh=sG79W+MkJg5APZjQ0IZO8BppN8H3r5aAnNzI61jDF3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwZqROts39mMfmYdvXCT4HPiFfhe7pphuh2eDKH6Wk1FhbfIuLFoJAzIV1w6dNRkv
	 gS8cb8Xmb9xkOCt1qVIvLGgvmZE6oe/kQRj9Y6tOcK3J7+SZnfUwT+d+1JQHBnsM7k
	 y3T2EZLmM1+zyp9NgHNPRUHvt0LY1DRZbWBLEBpI5BZTxG52678vBTHhYBIh0DFCr2
	 oQc7xvwwanHA8iVLjTvBSa4aPqcGU3EOVTPRsiGop7Ajz+J42dwFVmK6swcGn2j3CX
	 P6VUm6NFcP5DRUG3+5LkZrUBKtbe441Fuid0F7nbIj+YzyFabtEFqfwvMKgxkES4aO
	 fEdY++PK5+AOg==
Date: Mon, 18 May 2026 16:29:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 workflows@vger.kernel.org, linux-arch@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh
 Nguyen <dinguyen@kernel.org>, Kees Cook <kees@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod
 Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Dave Penkler
 <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260518162921.73e7c3aa@jic23-huawei>
In-Reply-To: <20260518042833.272221-1-enelsonmoore@gmail.com>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10518-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,gnu.org:url,altera.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A58F6570108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 21:28:33 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> The Nios II architecture is a soft-core architecture developed by
> Altera (since acquired by Intel) and intended to run on their FPGAs.
> 
> Licenses for the architecture have not been available for purchase
> since 2024 [1], and support for it has been removed from GCC 15 [2],
> Buildroot [3], and QEMU [4].
> 
> Given all of these factors, it is time to remove Nios II support from
> the kernel. The maintainer stated in 2024 that they were planning to do
> so soon [5], but this did not come to pass.
> 
> Remove Nios II support from the kernel and move the former maintainer
> to CREDITS. Thank you, Dinh Nguyen, for maintaining Nios II support!
> 
> References:
> [1] https://docs.altera.com/v/u/docs/781327/is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=e876acab6cdd84bb2b32c98fc69fb0ba29c81153
> [3] https://github.com/buildroot/buildroot/commit/6775ccc5a199d574ad70b5f79ec58cce97a07c6f
> [4] https://github.com/qemu/qemu/commit/6c3014858c4c0024dd0560f08a6eda0f92f658d6
> [5] https://sourceware.org/pipermail/newlib/2024/021083.html
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
If it goes for IIO trivial changes.
Acked-by: Jonathan Cameron <jic23@kernel.org>

