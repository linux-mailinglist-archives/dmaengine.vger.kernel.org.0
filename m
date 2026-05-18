Return-Path: <dmaengine+bounces-10506-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p9POIf/dCmqP8wQAu9opvQ
	(envelope-from <dmaengine+bounces-10506-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 11:38:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE1569D96
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E468A30078EB
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139643E63B2;
	Mon, 18 May 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vt0ThH1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7Zrs/v1"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514C3E3C59;
	Mon, 18 May 2026 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096739; cv=none; b=n5K7EiX+3imEzbBoYIomkyKXWQB9iI9mwA9/BVXmLpiRp0KarTwUlvQQnONr0alMtZwkqzXDTHfUkQZqBV8M9jXVm99U3yxsiNon9McOjumG/HGVX3l2Sicqi+5tYXcmjvq7QHkk4TuYcaf7IaGq421OEZtTSR4GwsLPIADNZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096739; c=relaxed/simple;
	bh=ypzeTVt77Q2YbxNzeBXoLlB99i/DAfX/BMXiXdWvVGE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R8CjqA5q1PvxkAKfHKMWOoN1zXwm4hCiDyeNbCgWSlCaTEfAlBngES4jlmOwp7FUAjRyhxfrCwcMLSuo5GKWnaYec27h+FQ8/bfuE4bgvJwBeZ+V/uYaNLpkreranjZlOJ2UT6rXiGfSpBtyA26m/LXd02NZH2XIgHY+B+zz4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vt0ThH1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7Zrs/v1; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 91C52130011D;
	Mon, 18 May 2026 05:32:14 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 05:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779096734;
	 x=1779103934; bh=Q1EsgrhmOtBlhH6lTl5Uo51ZkO0kpI0RkBVnwq5QUz4=; b=
	Vt0ThH1rLYcI1Ix28b0JP5KyKVSNK7tWRDDAnyloBA5/OwJqvN0ri23ATRKH/uyF
	y8piX8XfSOJ2Bufr6N0+eUn5rg446FLnMUuwx7hDbKGF/j7vqGhTISTNEbVMBtD3
	Er3HNGz+7bqwmkQZXphusyxP6gZ5RoN5+grgyIc2fAVd5zF9uz9rWHF2yR2iKE6c
	j5CWOhjqbuvDbRqe9DRYBaSya//gp1ZPuFln02tSYpandTwCO8xeGVrBKM1uBGsV
	9p2JckdJcHMQXLay3F89Y+/C/8zpBN5u1/pireYxLZJvV/0ez2Hvrz9lErx9PSRW
	EsZ3YkVJzigHewFB4l4G1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096734; x=
	1779103934; bh=Q1EsgrhmOtBlhH6lTl5Uo51ZkO0kpI0RkBVnwq5QUz4=; b=d
	7Zrs/v1i2pD7/PQEYdz7BPzqLdbR898qrLSWf/HozUAsyPe+XrqlKiGdfOVHUinw
	6Q0TqsEx4aDRD2knrLMZmE8pGW7wNnAsh4iVY1NGQyME8dm34CKZoUYySoSwGt3m
	WO5a6SL/c0VjK4nrTWAgl+UOgREv8GocunpjwMzoH2o93J9K6JzFGz0Nv/ew5u7v
	otDT3CesstoEPlNlDbtFawhwJUvW/W1HcemrhTjADJgyRVPcEmoEpY9owJYiw0so
	hKSiM+D0KAtC7+FYC/VwBnzCVieL8gHr9uBPe1fZUpAoCDiIEatJShmPKAswwKNf
	PdCn7RLUd8Xkv45idAYWQ==
X-ME-Sender: <xms:m9wKaiS1nRXcm5q7ZK6FjXk-vPvsJCwaGlPICQR9d8H9UXzQ4G_8uA>
    <xme:m9wKailMo_Vsg2pUTHY2LO2mRgZMiiYsetrfaJAgSSwVAluO1sPqyU7-v1LlFoahd
    gD4YhMSwmAQLKH7qOY_UXwDIOVaw4Ju_GOiNEeGM_TfF_ltikUCbgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgfetleektedtheehheegffdtgfejvddvveeigfehjedvkefguefffedvhfehkeeu
    necuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhn
    sggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhunh
    hordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtohepughlvggthhhnvghrsegsrgih
    lhhisghrvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepughpvghnkhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vghnvghlshhonhhmohhorhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhggh
    hinhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepugiimheludeshhhushhtrdgvughurdgtnhdprhgtphhtth
    hopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:m9wKaoXO8csU_OfH3IC96vXBm6hf3_s4i74Aa2ze3_cRkDErTRhnQA>
    <xmx:m9wKavCYpT9XIqZZ3KxcyxUwagyNayqYTaDfbOM66aYrE-DDmC3CvQ>
    <xmx:m9wKaqGfXgsGxAHGFR9PVXMFX8vv_m3SQ0OhOrBlqJJ6MAENfFzlyA>
    <xmx:m9wKameOBxifjWiOCFYmJ24tKTUi0NpUiwxhzkeayVo8Iddh1ByhbA>
    <xmx:ntwKarDXvcCscqze7RatHo9_OeoAzcLLCvtlqj7thJsDiA792-MymQA7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5AE44182007E; Mon, 18 May 2026 05:32:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoFiOxpvQUXV
Date: Mon, 18 May 2026 11:29:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, workflows@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <si.yanteng@linux.dev>, "Dongliang Mu" <dzm91@hust.edu.cn>,
 "Hu Haowen" <2023002089@link.tyut.edu.cn>,
 "Dinh Nguyen" <dinguyen@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Will Deacon" <will@kernel.org>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Frank Li" <Frank.Li@kernel.org>, "Dave Penkler" <dpenkler@gmail.com>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Simon Schuster" <schuster.simon@siemens-energy.com>,
 "Andreas Oetken" <andreas.oetken@siemens-energy.com>
Message-Id: <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
In-Reply-To: <20260518042833.272221-1-enelsonmoore@gmail.com>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5DE1569D96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10506-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,messagingengine.com:dkim,arndb.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sourceware.org:url]
X-Rspamd-Action: no action

On Mon, May 18, 2026, at 06:28, Ethan Nelson-Moore wrote:
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

Hi Ethan,

We last discussed this a year ago when Simon Schuster mentioned[1]
that Siemens Energy is still using NIOS-2 in production and would
prefer to have this still included in Linux for at least another
few years until the obligation for kernel updates ends.

My feeling is that the maintenance burden of keeping nios2 is
relatively low. On the other hand, maintaining it out of tree
as a patch set is also something that should not be all that
hard if it does get removed.

Simon mentioned that he expected others to also use nios2 with
new kernels, but I have not heard from anyone else actually
doing it.

I've added Simon and Andreas to Cc here to let them comment
more here.

     Arnd

[1] https://sourceware.org/pipermail/binutils/2025-March/140140.html

