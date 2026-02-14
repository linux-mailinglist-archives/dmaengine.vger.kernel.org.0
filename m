Return-Path: <dmaengine+bounces-8903-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vJoGMWvYkGlAdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8903-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 14 Feb 2026 21:17:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320713D1C8
	for <lists+dmaengine@lfdr.de>; Sat, 14 Feb 2026 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFA293011C45
	for <lists+dmaengine@lfdr.de>; Sat, 14 Feb 2026 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C723C39A;
	Sat, 14 Feb 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="dRhLdFNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wVRay7y/"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F822D9F7;
	Sat, 14 Feb 2026 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771100264; cv=none; b=WlqYSlW6A3+sX/uVh8J+ZzFY8X2kCvq5qDQOh0Un1gAXT914kJCOwhOXao9gMpxIK0bk23PF7n++TqneD2hMPCZh2QYkl+riC4nfFuPkRaO4GYdzCkVmuUHYGeX7RT9o20wFaJZfMuCWmAooHl+FS6KxDEcJd1Wjmo6e8VBv/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771100264; c=relaxed/simple;
	bh=tkcpYpKdOVGR26NDevqMS/9nzXXaxloYdWOxpwUibGU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X9IK+WEs4cbjD9LP3N3T/HrX+lxLVhEJSqnDuJMaKn7YYIZ2Yt3msSdmt4bJuesnq6Gr+zAipvTJJGSBnQ9UZ9g3IXVaQ3c7rXJQFZTmr5HlmSCBen7ZRATPeBtSCKi0XAb7EdRJ24bmkx8QMS9QrpcFbMtIbasfydno4tlBwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=dRhLdFNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wVRay7y/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F0201D0011C;
	Sat, 14 Feb 2026 15:17:37 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Sat, 14 Feb 2026 15:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771100257;
	 x=1771186657; bh=IvOS+pgy2uR8zxON+k1BskxbjZLcO9n2BtEa+bvHg+0=; b=
	dRhLdFNAi/SrlOcjHVnbcN1lt1wDYSXWCXlgca92B6MJqs9/lGu93FX2d5OPO9pp
	0VAwyWjGmQzd0chL5f20LdGfFAyfDoIWt3HIlO1D4QE8RfSbBMaKjcMIL+/tfeHM
	LTupomjNhU7U0jzD9K6D9bcT1Hm5oemn8ihra719ZMrUW+A4TXlq2ooxoPwO8ZdB
	6Zh3tl8uPgEOcoNIT8AqZdVs7QltAYAPR/O2h6xlHDriCk+zxx1u4jC8Adri32FH
	N6C6/K4MwKqFJs5WtA9BZDNDLgyr+ev/WO0FdAQpHNWCshDwTxYu3IxGXmNRKQw/
	7+Lzrz0vIedY3AxQ/Cn0KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771100257; x=
	1771186657; bh=IvOS+pgy2uR8zxON+k1BskxbjZLcO9n2BtEa+bvHg+0=; b=w
	VRay7y/hyqYf9338DXddbG7skU0u4RcNqrqXMi1euDU2Jj8pkW36kejYniWB61XK
	CpvzhBAPtb6ttzDSmmxcdsaFuMRk19UHsNp7ES89+XPcR9kMrENDguMBQoYRrf4D
	XR+g7KMS0QYgtL0WFb9wyCkuqZRNz3oceluftbEtyADnbkbvA8hnNz5HXr1S2SWM
	/ZuCELOgQxFm98Vwaeye+Sjn4T8tIvAMKdTk66J13AG346+pJc6ryvWki/crym10
	ccPBsGHC+ioNuG/FByUpDFi7kwMp0Ehnv/f9p9yjbKmSSTZV86GmI++/r9gu1XSh
	CxhAAVgg7PP4qHShnoxGA==
X-ME-Sender: <xms:YNiQaWRXfB90OD5w1nLmKYSmQrhjg57uosn0H2v-ajGEluIlg4vYQQ>
    <xme:YNiQaWnhM0KBSV5L9jmlxA4gIjEWfDolLvniceqhD5hGkIxO7b4hgVFxpuzkxceys
    OQ91uzk2qJJ3JLxzB_BvQzd62HpzLTvRGExPMKraty3jpBlS2oyrJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvtdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YNiQab68jDa0O663yj5h9dvLxAGwTAciGtUFqPohlGnS4kD61KCUmQ>
    <xmx:YNiQaa9w9MBYSO5Qzqzd_V4yqz0BVdcZJK9SiGX_xhYajqNY6OjAMw>
    <xmx:YNiQaSWQf9ytig_y_EfoFOpuEhkGAwBTISvOv4jD-14OM499f7c59Q>
    <xmx:YNiQadqYVgTrwhnyxX6Mm0b5XyNAUy0jWeud3BRtIPqREZB5a3qVmw>
    <xmx:YdiQadb_caXY0-noZFNEfysA5n1PMCIzI8heZAeypZtvEBuwYN4QFjaT>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D47AB6006E; Sat, 14 Feb 2026 15:17:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Sat, 14 Feb 2026 15:17:15 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <1654dd48-c86b-4756-82cf-d1fec5732d60@app.fastmail.com>
In-Reply-To: <20260205103129.GT2275908@black.igk.intel.com>
References: <5ed857f5-59ae-4052-8f2e-dac7fcd014cc@app.fastmail.com>
 <20260203100452.GE2275908@black.igk.intel.com>
 <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
 <20260204123107.GN2275908@black.igk.intel.com>
 <5ed53c66-69e9-45e1-9b89-e3d555ff412c@app.fastmail.com>
 <aYNHeqYYa9ixrksM@smile.fi.intel.com>
 <e7a0d992-ed5c-4435-b567-e0b873360a48@app.fastmail.com>
 <72c71247-8b54-4820-b25d-34f659e7f957@app.fastmail.com>
 <20260204153402.GR2275908@black.igk.intel.com>
 <0d13a547-5f4c-4d5b-83e2-3530469d36c1@app.fastmail.com>
 <20260205103129.GT2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[sent.com];
	TAGGED_FROM(0.00)[bounces-8903-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sent.com:dkim]
X-Rspamd-Queue-Id: 3320713D1C8
X-Rspamd-Action: no action

On Thu, Feb 5, 2026, at 5:31 AM, Mika Westerberg wrote:
> On Wed, Feb 04, 2026 at 10:53:57AM -0500, correctmost wrote:
>> On Wed, Feb 4, 2026, at 10:34 AM, Mika Westerberg wrote:
>> > On Wed, Feb 04, 2026 at 10:12:57AM -0500, correctmost wrote:
>> >> > I will try to debug the config issue and retest the touchpad with the 
>> >> > proper config changes.
>> >> 
>> >> After fixing the config issue, I now see "Dynamic Preempt: voluntary" in
>> >> the dmesg output.  I also see "# CONFIG_HID_BPF is not set" in
>> >> /proc/config.gz.
>> >> 
>> >> The "probe with driver hid-generic failed with error -22" message is
>> >> still present and the touchpad doesn't work (full log attached).
>> >
>> > Thanks!
>> >
>> > I don't see any other way than adding even more debug. It really should at
>> > least be able to parse the report descriptor as that's exactly the same as
>> > in working case but let's try to figure why it fails. Can you add again on
>> > top of everything this one:
>> 
>> The attached log has the added hid debug lines.
>
> Thanks!
>
> I now realized that the dump of the report descriptor truncates it into 64
> bytes so it can actually contain whatever crap that the controller read and
> this is probably why the HID parser fails. My apologies.
>
> I think at this point there is not much we can do :( You have the
> workaround, to put everything in the initramfs (or built into the kernel
> image), right? We have asked schematics from Lenovo but there is no
> guarantee we get them and I think those are needed to figure out how the
> touchpad is connected.

I have been excluding idma64 from my initramfs image to work around the issue.  I was hoping it'd be possible to make the touchpad work without any user modifications, but it doesn't seem like there is a clean solution.

For future readers, there are two items that I did not yet attempt:
- Update my BIOS to see if that helps resolve the issue
- Try to access advanced BIOS options to unlock GPIO pins

Thank you (and Andy) for proposing patches and reviewing all of the debug output :).

