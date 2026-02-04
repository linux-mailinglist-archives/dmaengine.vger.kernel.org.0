Return-Path: <dmaengine+bounces-8715-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJKjKqBFg2nqkgMAu9opvQ
	(envelope-from <dmaengine+bounces-8715-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 14:12:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36129E63AE
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5AEC300F142
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E43D3306;
	Wed,  4 Feb 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="1QQLiVpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cy8hbqrY"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8E3B960B;
	Wed,  4 Feb 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210712; cv=none; b=tHxY9Jk3ibglKeYr+6TJmvMfX3MBPaH2gXTpv3czLCui8v3y6EPmbOT3lR1gAfaU3R0fK0mWLi0SF6s7DVmaasy+g6VXqgYKuJ5c0ZGDA/VxyDHLxG/YZCX4Q+Ocm07p+PeenPmWVg63Nm37sPiFbBg1HiV5viVFdz5/fzsvq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210712; c=relaxed/simple;
	bh=y3fBhwLvnm617GIdHE44zVIr3atHm3eVzWdQwZfhfNc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rRZa8CwV5UzMhl/lVTMfeIVUS1k+wj+BJ1ZqpXdy4NdaTyHtmt8UF6tVRFrDldhmjzC3iW2wFMD8G9wgqaVU/A7rzB55YfMIa3H+R1OndMaNY1DzXLGFf7im+cv/iPNUeS5JPSc/Uw8MIP7fLIgtpEetOHOJlW9CLOn30D2NLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=1QQLiVpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cy8hbqrY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 28A2D1D0008E;
	Wed,  4 Feb 2026 08:11:51 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 08:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770210710; x=1770297110; bh=GMKFhp9eO6
	WyixMsSB8WG2zBFNw2kvfD8OHMzAr/1gA=; b=1QQLiVpUI1Sd31KhgZ4FhISBie
	57LCLCSGCwo0hndq6vxuF++kxduwL0MZ9VbFlZZnppe/mw/9RHnd26MlzjFmfUyc
	0nMT8sC0CA5vnCvoR4T4dll3RnoZO7S4IlHVUXpNtTUQfLJcE4ph7oxNxGVIOxjo
	WAdETyPIgWrRJMBZ0sV/xhUByT5lrnmkhTLOYFD7q8/pUatvozdQaFEnRvz4mMUX
	MvfkoHzOYttxDUnqH27y/HUYIa+5EImMN8b3I+dn3YzfXEfYjQxiXb0d9nceSkNX
	q1fGyIOVL3KpEbpLAkvFmSA6KxLj5uis7q53FdjRSjddrbxTqYwbMShBVUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770210710; x=1770297110; bh=GMKFhp9eO6WyixMsSB8WG2zBFNw2kvfD8OH
	MzAr/1gA=; b=Cy8hbqrYiAxrs06yh/pixv1DFurgz3m18QGldqfhPkzIMYCQ1hM
	VJ6L025WaW7X3MKViiMOlnlMpygfrYJWfqiPCrxQQw7STaLW2OcQYeFuI3nxgnnC
	bmPFE2n42ab1Cp8tcn4isILmpmOdtsWrF0+AiD4HPAE1jMdnbuthS824C4ZN9S82
	fHiAmeT1jjugt1p+m3I4rKNdpGDLsEct4p6Z5nBwuPq2qytJjzTn+Ilq7rBz41kW
	go2tzBb2rOOwka3/5Zd7QcR5gHROOdC6LlOMiB1rotFQo8EbfK0fSPM5cUP4FgkK
	F6rZV6vafIMmG04UGcEp2X9cfiA4cFj5vPA==
X-ME-Sender: <xms:lkWDaW0p2inIiTrg8PvWQNwHa7i1_c3XeC1p00JqRjISxkR-exPLTA>
    <xme:lkWDaT5lJmWEY1mZ1Cl7LDy1tcmJnnKBZgk-sELoLqVx4TWfpuiP_iJUTEQOxiuyG
    wC3cO9z4llI9QG_5GjoU26bZTbJoH6fTOPrcGUIQHq-QlozKhOYen0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgesmhdtreerredttdenucfhrhhomheptghorhhrvggt
    thhmohhsthcuoegtmhhlihhsthhssehsvghnthdrtghomheqnecuggftrfgrthhtvghrnh
    eptdegkeevieegtdejffefteetffdtuefgueeiieeggfetgeffueegffevieefjeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghmlhhish
    htshesshgvnhhtrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghp
    thhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
    dprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lkWDaYf73AADjNYl-7_TKgFoIUbqBfjd4D0v-2UQCdIOeQ5S62Gc-A>
    <xmx:lkWDaUTC0yxeXbv1QRRoY2cqpcOyC-rTDLfR998M4OI2mqOiuPTc-g>
    <xmx:lkWDaZYqPdm6_QoJUUXTo4AJXZfM6QfUs6m-kyfc5jir_9-7h0ac7Q>
    <xmx:lkWDaffg_ledmXeZW8dbwIF-6MlCPYuk17M2Iynq7kES0fEfbN82iw>
    <xmx:lkWDadvTl43Dm1_U8IrKqFMWzZHHqtpcdJ0U_JVUlEG3nWhSNwGi3V4A>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28CBCB6006F; Wed,  4 Feb 2026 08:11:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Wed, 04 Feb 2026 08:11:27 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <5ed53c66-69e9-45e1-9b89-e3d555ff412c@app.fastmail.com>
In-Reply-To: <20260204123107.GN2275908@black.igk.intel.com>
References: <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
 <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
 <20260202075118.GY2275908@black.igk.intel.com>
 <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
 <20260202102225.GB2275908@black.igk.intel.com>
 <5ed857f5-59ae-4052-8f2e-dac7fcd014cc@app.fastmail.com>
 <20260203100452.GE2275908@black.igk.intel.com>
 <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
 <20260204123107.GN2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: multipart/mixed;
 boundary=4a1d4c8bb0514dfbbbc6c06556d89197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8715-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sent.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 36129E63AE
X-Rspamd-Action: no action

--4a1d4c8bb0514dfbbbc6c06556d89197
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 7:31 AM, Mika Westerberg wrote:
> On Tue, Feb 03, 2026 at 07:39:36AM -0500, correctmost wrote:
>> On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
>> > On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
>> >> > Could you drop the above hack again so that it should "fail". Then build
>> >> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
>> >> > this is just lucky timing? Please try a couple of boots and make sure the
>> >> > results are the same each time.
>> >> 
>> >> I cold booted five times and the touchpad did not work during any of those boots.
>> >
>> > Thanks!
>> >
>> >> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
>> >> 
>> >> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
>> >> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> >> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
>> >> ...
>> >> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> >> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
>> >> 
>> >
>> > This is really odd because "item fetching" is not really accessing any
>> > hardware bus - it just parses the descriptor and the descriptor looks fine
>> > to me (and this is the same as in case of working run):
>> >
>> > Usage Page (Generic Desktop)
>> > Usage (Generic Desktop.Mouse)
>> > Collection (1)
>> >   Report ID (1)
>> >   Usage (Generic Desktop.Pointer)
>> >   Collection (0)
>> >     Usage Page (Button)
>> >     Usage Minimum (1)
>> >     Usage Maximum (2)
>> >     Logical Minimum (0)
>> >     Logical Maximum (1)
>> >     Report Size (1)
>> >     Report Count (2)
>> >     Input (2)
>> >     Report Count (6)
>> >     Input (3)
>> >     Usage Page (Generic Desktop)
>> >     Usage (Generic Desktop.X)
>> >     Usage (Generic Desktop.Y)
>> >     Logical Minimum (129)
>> >     Logical Maximum (127)
>> >     Report Size (8)
>> >     Report Count (2)
>> >     Input (6)
>> >     Report Size (8)
>> >     Report Count (5)
>> >     Input (3)
>> >   End Collection (0)
>> >   Usage Page (Vendor Defined Page 1)
>> >   Usage (Vendor Defined Page 1.Vendor Usage 1)
>> >   Report ID (14)
>> >   Usage (Vendor Defined Page 1.00c5)
>> >
>> > I noticed  you still have:
>> >
>> > [    0.069726] Dynamic Preempt: full
>> >
>> > Can you change that in .config to:
>> >
>> > CONFIG_PREEMPT_VOLUNTARY=y
>> 
>> Strange, I did change that config.  Do I need to change another config for it to take effect?
>
> Probably not.
>
>> CONFIG_PREEMPT_BUILD=y
>> # CONFIG_PREEMPT_NONE is not set
>> CONFIG_PREEMPT_VOLUNTARY=y
>> CONFIG_PREEMPT=y
>> # CONFIG_PREEMPT_LAZY is not set
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_PREEMPTION=y
>> CONFIG_PREEMPT_DYNAMIC=y
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_PREEMPT_NOTIFIERS=y
>> # CONFIG_PREEMPT_TRACER is not set
>> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>> 
>> >
>> > Also let's add on top of everything one more hack patch, just in case ;-)
>> >
>> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> > index ed90858a27b7..0297ebedb802 100644
>> > --- a/drivers/i2c/i2c-core-acpi.c
>> > +++ b/drivers/i2c/i2c-core-acpi.c
>> > @@ -371,7 +371,7 @@ static const struct acpi_device_id 
>> > i2c_acpi_force_100khz_device_ids[] = {
>> >  	 * a 400KHz frequency. The root cause of the issue is not known.
>> >  	 */
>> >  	{ "DLL0945", 0 },
>> > -	{ "ELAN06FA", 0 },
>> > +//	{ "ELAN06FA", 0 },
>> >  	{}
>> >  };
>> 
>> The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).
>
> Thanks again! It still fails in completely unexpected place I wonder if the
> BPF quirsk somehow could affect it?
>
> Could you still try with CONFIG_HID_BPF=n and see if there is any change?

I applied that config change and saw the same touchpad failure (full log attached).
--4a1d4c8bb0514dfbbbc6c06556d89197
Content-Disposition: attachment; filename="dmesg-no-hid-bpf.txt.zip"
Content-Type: application/zip; name="dmesg-no-hid-bpf.txt.zip"
Content-Transfer-Encoding: base64

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

--4a1d4c8bb0514dfbbbc6c06556d89197--

