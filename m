Return-Path: <dmaengine+bounces-8459-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPFQIpelcmmMoQAAu9opvQ
	(envelope-from <dmaengine+bounces-8459-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 23:32:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EAB6E2F8
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 23:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DE1300AB0A
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FA3612DE;
	Thu, 22 Jan 2026 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="lvykA7IL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fxna4hgU"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9C32254E;
	Thu, 22 Jan 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121166; cv=none; b=DPx2YTyY7yk/KuIEWOSx8QTc6OoKi0nt30jQpA8uQQcH0clFiO+LeSRBfaLxhwoqcOLES1WO+lzgC594nAZJaKY96gTWCK0QBmZL9Svt2F8chIv7uPm/WotKdFEJf3nHgL58jekPj15Cpfnt4i9VXmyFEQ19nxBzj0FoP7yGXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121166; c=relaxed/simple;
	bh=NOAclorXp0xk/AletFeCwImesuzw6pMoIT+Mo/HvVvI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k11GkDtsk5/8KaE/Lfl4y+Z6BC/eirdV2fzMSiOelAEiSTmhYnAHR9eibbDXhLCAPDgl9tylJTJB4DyawwUZyUzUOfqJJQ5yF7MZa2TtXHFQa/tA9629pXSfEvkwu0jnSqn3Eb1moN+Xzdmvbm0BInut4f+7+QPM2F2GR048p18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=lvykA7IL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fxna4hgU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 485817A12AA;
	Thu, 22 Jan 2026 17:32:37 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Thu, 22 Jan 2026 17:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769121157;
	 x=1769207557; bh=zQRMWdGZbciyHZ89+it2gFuutzz7AH0pjJZIPfqd0bU=; b=
	lvykA7ILot/Xh+M6roE+fi+6Imaqa7buXBZsCL68ixhK3AYa1aAsEgb3UKUtfjzW
	9hB7psAOszxi3+yURSNEtEraMMwoAU9spL2KYSx2x4RNs2hkqgPaCT/FJeowRx+R
	0wFKjMxMC9QZfPlpxSvw2Lqemsvw+j7pRzfQS74+5QUzhcmqyK6pVWDlcNX/ktaf
	PAmsJXPSLvts43Xg/7BYxH+b+QZMowV/8lHpTXbmjaaPopTUq3nYW2x8i7gnG/j1
	eLJyYpJHx/D2dSjPEZ9Tfs0mO8FBPn9k2qG0wOAnVlnpmlAvMVge1izxfhLDgxUh
	5NiWstwQxNkQAZ8pq4zoLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769121157; x=
	1769207557; bh=zQRMWdGZbciyHZ89+it2gFuutzz7AH0pjJZIPfqd0bU=; b=f
	xna4hgUNfV6Zyy5w3zSezYLab9gylWvBAY2yYyY7bDTaOQz0o/yo/dg+j6CxbViL
	Ozz9Cfg3hR0l01efi1wuSxMotuMJg/3BohJLOfnY97Tsw9b7/6fiIuUoxHXX1OQX
	xtyFNAeVUqJU4ZoDzCZhYQGREz8eskf57N0qSmp8Kul6Ltby9S7+RhjcutS5V2jw
	zKQZXkyEY0cHiabaDKvJxw+7CuUla/QXxI3a59nrEV0Icl5jr6kp1nj+HsqPKM84
	nVU7jBL5qwbe/5j6dAFVHAtOsAoktuqRaqmxdcbK+4a20h91luMHFc+w3rkq8VD8
	m1sRQgjeKmHjdgQv2d+JQ==
X-ME-Sender: <xms:hKVyaX5H3ivQLh2Df439nHeLXkQa5YGkcgQrDfkau11nc-FuHDovow>
    <xme:hKVyaXt4lmnouzgkB37D2CPiGrYulbTEqniuocwBQUVszVQVh6o-4X5a6sRYh0Nz1
    CmrRjEt9LlE9PM_Hvahh4P088t9f5jWyyxr35v3JsPUnN86-B49Unc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpegtohhrrhgv
    tghtmhhoshhtuceotghmlhhishhtshesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrh
    hnpeejleevhedvjefhtdfhueffhfefgedtvddtgfegfeeiveffhfeffeelgffgffegleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtmhhlih
    hsthhssehsvghnthdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhkohhulheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtoh
    hmpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqihdvtgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hKVyaVg8Dl4WgUcEGSI0LXkw6l-pEG76UUcWYM7P1w-Sox__CCr0vA>
    <xmx:hKVyaUEhtBnRfJcDyK22kvMYG-eyGtGkM31jUKT0kf6A2KcB21xkIw>
    <xmx:hKVyaU_qWEF9KxBGlfHf8EI3oqHKeNh32IiV3_PWekO0lh5hHXg2kA>
    <xmx:hKVyaby4m8Z_iSZ4GvMjBOVu07gAjdj2j2Qh6MEUUqaeHLXp6iKuFg>
    <xmx:haVyachMuLRgpCAngAQl3CX0LtLhqUVsA1msLZR3BIdHIWG2EemRPL6J>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A761B6006E; Thu, 22 Jan 2026 17:32:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Thu, 22 Jan 2026 17:29:38 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
In-Reply-To: <20260122110021.GO2275908@black.igk.intel.com>
References: <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com> <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
 <20260122110021.GO2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8459-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[sent.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SEM_FAIL(0.00)[172.234.253.10:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sent.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 26EAB6E2F8
X-Rspamd-Action: no action

On Thu, Jan 22, 2026, at 6:00 AM, Mika Westerberg wrote:
> On Wed, Jan 21, 2026 at 05:19:17PM +0200, Andy Shevchenko wrote:
>> > Well I mean if touchpads actually worked prior this idma64 commit and now
>> > they don't isn't that a regression?
>> 
>> I don't think so, because commit did the right thing and just revealed an issue
>> that was rather hidden. Reverting is not an option.
>
> I now looked at both working and non-working /proc/interrupts and when it
> is working there is no interrupt flood at all:
>
>  27:          0          0          0          0       2277          0  
>         0          0          0          0          0          0 
> IR-IO-APIC   27-fasteoi   idma64.0, i2c_designware.0
>
> This makes me think that perhaps the toucpad is powered off and that causes
> the issue until I2C HID probes and resets it. I looked at the ACPI tables
> but I did not (yet) find anything that stands out.
>
> I wonder if it was tried to put i2c-designware*.ko and i2c-hid.ko into the
> initramfs, and does work it around? I would expect so.

I don't see an i2c-designware module loaded when my touchpad works:

$ grep -i i2c /proc/modules 
i2c_i801 40960 0 - Live 0x0000000000000000
i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
i2c_mux 16384 1 i2c_i801, Live 0x0000000000000000
i2c_hid_acpi 12288 0 - Live 0x0000000000000000
i2c_hid 45056 1 i2c_hid_acpi, Live 0x0000000000000000
i2c_algo_bit 24576 2 xe,i915, Live 0x0000000000000000

I tried adding all of the following modules to my initramfs image and I still encountered the touchpad failure:

drivers/dma/idma64.ko.zst
drivers/hid/i2c-hid/i2c-hid-acpi.ko.zst
drivers/hid/i2c-hid/i2c-hid.ko.zst
drivers/i2c/i2c-mux.ko.zst
drivers/i2c/i2c-smbus.ko.zst
drivers/i2c/busses/i2c-i801.ko.zst
drivers/mfd/intel-lpss.ko.zst
drivers/mfd/intel-lpss-pci.ko.zst

(The drivers/i2c/algos/i2c-algo-bit.ko.zst module was already present in the working image, so I didn't have to add it.)

