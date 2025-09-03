Return-Path: <dmaengine+bounces-6347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF2B41E43
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D097B89C6
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26727A476;
	Wed,  3 Sep 2025 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hbvI6FyV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhmTLhfR"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2DF25C818;
	Wed,  3 Sep 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901075; cv=none; b=JeWFi4rq9CQ7sQkw2SnwzRE+xGmioSpJlBHKPlXS2hnN9JmBkrd5rRE9Ptu06xV19TrHBkwo0Y2TrUWOIbV0nBdb/nxePcrXIuuUkk8EMpHauU9GclGg5aEsd3F+0kN5efQjjW3OeCM5lu4lCa70/eUcSE4EG/62lqJ+vGc2AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901075; c=relaxed/simple;
	bh=Cyl0v7APsVBlLf5GdVdQAGAKxUgHPijlDA5HLDYiuLc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qzhZaZ/U1N2zAnNu8F4bGoUkve5WnwPfrWZh9HrTUJ+mwSOgPsHo0Z2AclAROJvY1b2aI81IfjUak6LzdJW8A7FO/CM+OptcdtfFTHacil3DttfzdiubJFexU+p5KUwrsyZ8p34rnS11LhVnVoUgNixfiLxR1RmhLsKgdoBMQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hbvI6FyV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KhmTLhfR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 999AF1D0001D;
	Wed,  3 Sep 2025 08:04:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 08:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756901071;
	 x=1756987471; bh=0xh9A7T8d3rEQAPQjYtdSK93dJzr1kzBQLs074dUMbA=; b=
	hbvI6FyVCUJbdHkWoowZ1gCAHul+DGlhRs5tJrt3Muw9J8jT8xR5VL6yBlPflqlO
	fLAheQzkl2Cjn671HL6aWxlog/J4eE6poZpPVvXO8mdm4p4ouxaQIW4Y234jCCbV
	vPekvr0fDoNoCZf1kn0l+dr9/YoosactGYyMCK9inCK7ObeW7UyuJeGQ76RKpw1O
	aKMrUjimJ8qKlRcJ7PeYeSeWgLLIhVmcIBt2xLRUWL2qBSZ75AYjIrzgC80aG7Az
	61TIbSHy1rUmQWk/AaNisodrwfuBw5qqpPGVyA03G8n7nLWCGYzceCIYKhoONgCC
	0T96yJaiBoHeaQb9d3nqgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756901071; x=
	1756987471; bh=0xh9A7T8d3rEQAPQjYtdSK93dJzr1kzBQLs074dUMbA=; b=K
	hmTLhfRpVKxhwZGrzgunLrJk0daRun/vSinsM45s4jnFVjc4ENRAa23NotMuy69+
	/eScqHr1ImEpQXqxHJWrpAMctVXWrBR15vB34UzE2JyOFT6KvIJ+ENvtmOz3lIe9
	/Xby/3CK+SgMp5Uws1jWSW48cQDVgnrAQeaUvefKN/XZIxi0ewpR2sRRGzjzQKl4
	eCtMHOeWl9MypAz8oGhqD4eS4Dv7bYLPfC9RMbLeGIKI3LBhT27C2nDP8DkC/osf
	yCwHtbVC+nkTtHlpvC9pJoykE8wLWLEWGffcCmgCle4qiXKPm3ewS83jKkdiYJ/B
	leGB8192ASOzeAle04rDw==
X-ME-Sender: <xms:zy64aGL2PbY7A2AyGHsaYHQrYwcCvmFvfV90tP5S5ydKeAoxyZUCOg>
    <xme:zy64aOIPDKrxPO1BE9x3YIdOrGRSZ_MQGP_JezXP67p-MUgKqNg4SmP_KqbUmWuEm
    9L2STadQOwI8CeiwNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhkoh
    hulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllhes
    lhhinhgrrhhordhorhhgpdhrtghpthhtohepsggvnhhjrghmihhnrdgtohhpvghlrghnug
    eslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhi
    nhgrrhhordhorhhgpdhrtghpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrg
    hrohdrohhrghdprhgtphhtthhopehlkhhfthdqthhrihgrghgvsehlihhsthhsrdhlihhn
    rghrohdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:zy64aBnGeSuglvz5cWZB_X8Jxmi9kZQK5Z3rxwiUsjYh00AG7IyEYA>
    <xmx:zy64aKWxzbE-AQeKVsxRuIfn5Bu3-wOPboVSpiHYv7I_f1pAxHE2XA>
    <xmx:zy64aKTUEPpeo3sUuGTGzZzd2eRgK3PIm6OpagAfF5ZciXiBq1kTqg>
    <xmx:zy64aHAv3Z7ZG9JlvBggXq44yGFTD0Rh_K_qdpz3Uqj2Pspn4XHNTQ>
    <xmx:zy64aPT303sFsMLQiJhjIjCKuzQ5b191bpSzUN65_K9iqkvImicu2Ijc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC1C4700069; Wed,  3 Sep 2025 08:04:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvKhge5cS9gB
Date: Wed, 03 Sep 2025 14:04:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 clang-built-linux <llvm@lists.linux.dev>,
 "open list" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Guodong Xu" <guodong@riscstar.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>
Message-Id: <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
References: 
 <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14: error:
 shift count >= width of type [-Werror,-Wshift-count-overflow]
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 3, 2025, at 12:08, Naresh Kamboju wrote:

> Build error:
> drivers/dma/mmp_pdma.c:1188:14: error: shift count >= width of type
> [-Werror,-Wshift-count-overflow]
>  1188 |         .dma_mask = DMA_BIT_MASK(64),   /* force 64-bit DMA
> addr capability */
>       |                     ^~~~~~~~~~~~~~~~
> include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
>    73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>       |                                                      ^ ~~~

I see two separate issues:

1. The current DMA_BIT_MASK() definition seems unfortunate, as the
'(n) == 64' check is meant to avoid this problem, but I think this
only works inside of a function, not in a static structure definition.
This could perhaps be avoided by replacing the ?: operator with
__builtin_choose_expr(), but that likely causes other build failures.

2. The dma_mask logic in this driver looks very strange and makes
no sense to me.

Guodong Xu just added the line above, to set the dma mask for the spacemit
variant, with the new logic being:

+       /* Set DMA mask based on ops->dma_mask, or OF/platform */
+       if (pdev->ops->dma_mask)
+               dma_set_mask(pdev->dev, pdev->ops->dma_mask);
+       else if (pdev->dev->coherent_dma_mask)
                dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
        else
                dma_set_mask(pdev->dev, DMA_BIT_MASK(64));

This has multiple problems:

 - the coherent_dma_mask is still left at the default 32-bit mask
   for spacemit, which I think is a mistake, even if the effect
   is the same
 - The existing
   dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
   is completely bogus, as the driver should just set a fixed
   32-bit mask based on the capabilities of the device. No other
   driver bsides mmp_pdma.c and pxa_dma.c does this.
 - The pxa/mmp variant clearly supports 32-bit addressing, no more,
   no less, so just setting the 32-bit mask should be enough.

Guodong, how about a patch to drop all the custom dma_mask handling
and instead just use dma_set_mask_and_coherent(DMA_BIT_MASK(64))
or dma_set_mask_and_coherent(DMA_BIT_MASK(32)) here? Instead of
passing the mask in the mmp_pdma_ops, you can replace it e.g. with
a 'bool addr64' flag, or an 'int dma_width' number that
gets passed into the DMA_MASK_MASK().

     Arnd

