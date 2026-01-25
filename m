Return-Path: <dmaengine+bounces-8477-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMzCLQqSdWlrGQEAu9opvQ
	(envelope-from <dmaengine+bounces-8477-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 04:46:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6887FB34
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 04:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9EB304706B
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F352940D;
	Sun, 25 Jan 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="plm9DSAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9CSsl29"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C21ACEDE;
	Sun, 25 Jan 2026 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312318; cv=none; b=PL0Ygodx8acX1YRM6OI0o5fFp0EStSPbINCNcWw4VGPOImRimjZafeKtSUbE+3cch4KQRyEgbDP6mmdHt/5vD39EMO6OvfaMJQdlgwGICg+Csbkb1XyNkUxK+rAXYGqsv1Mfc1TdUIaHJWZLaPB9Y5R2PBDyXyNrw9YZ9StHiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312318; c=relaxed/simple;
	bh=8CBl8opGapgkH6CLHjf5B1SWDdzoK+iyfd9wQYQLrBg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bDvGAvgLHBJvYbG2b48wN8n8Qa8WTPmyJXZRpoBLgADlcf4XSDHIBbJSUfDQ1C83RRWHT1dcKgst4r8F9O+ikA1+7yNTdpE44Cgrp8+JhWfZpLyRsid7KuCuCyJ3EYVPi1XVOhXlJNgZOkm9qcxqsXhMtgwhJjEJ9l+vsszoh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=plm9DSAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9CSsl29; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BDCDCEC00B1;
	Sat, 24 Jan 2026 22:38:35 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Sat, 24 Jan 2026 22:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769312315;
	 x=1769398715; bh=Te/xgObwuYwPniIVt2ST/UMRt8qYtEzb/TjR2AddXEY=; b=
	plm9DSAnf4F/hyJLWNzKfHjT7Nwl2nWw/YGSQqTvXqQ05+n/ytb9DSy5Q3FLxR6b
	8PCkiGEeBlNMoFQYsAsSTZ2d2FooCZemxZZcR9k1y+d9sVJy4oyJrev/R4eOtnNs
	gHl4tOjRdAcRASpyyWhiIqVN9u2rVTtU1y776lHagIwZcjIFiTFi0nbqdX2Cnnw4
	E30W6DIQ6lR2vdr5wzCVJkrMf8oVBv9Asdl7uMvnHMd8Hp9sPdQCSkQtAHEcN5lD
	lmYamgRRpO99e3FnIBX5kuvg/Rhq02mr+y29/8CeUEz7yQv1kTQDxeF4GfjjcROP
	kqYVzMgSavhi9Nw/S1NQag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769312315; x=
	1769398715; bh=Te/xgObwuYwPniIVt2ST/UMRt8qYtEzb/TjR2AddXEY=; b=N
	9CSsl29e/wJioM3hbJVX2zVQlIK64QTtGQlPeR+qRA0LcWtQwNjiKmhkl+s1Lxut
	M+yBAud6ER7V057gbtEZYSeicZC8Cz09qZKhIYAo97+kAuVyGnz6Qzgt6aTjGnjR
	vJKM91HwIGgGFXPOXqTA5+pyBN/1rCLqlPx+U+vp02XG7wUHlvPNbbgtrYL3dCur
	JCU34hW3CNZHT0Z7/2D2YZHjCszyDzRHAKY97ZJi01+rxeEiJSY+FteoNaJl+LaJ
	ALBtplnP6xRG7l5bxjizCRHAbDWVZhxkWkbicYThGTmnx5s8K8Nr28UCPOFLYiaY
	vdWOfZJVLIdFhQ16yvLSw==
X-ME-Sender: <xms:O5B1aavwnEx_1PqVsUS_qiAJGnbNOyB-h0bqCJJ9dEm9MwcJlep3-Q>
    <xme:O5B1aaTuPqIOfVSXthTRoU-1A2tMTN9lO5XgMrzNS_wuKY8CGC9PMHeIq-fmiiUk6
    DxmTU8RaVRHVmiHjvmuWUXB_tVFq1IkgbDzMeiu7Zhbg2uDHq4Qxws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheefjeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:O5B1aUVF3tIYCcbWrFPUwHqGI-d8FZ7zjEL_Xtuk470eOAH7qpztKQ>
    <xmx:O5B1aSrcyH7lv3dBrus5dNg5VFJJsLSxNEwzqjQwK50_b-L2bBtbMA>
    <xmx:O5B1aYTV5Uf6uPpQbGLlFgbjUmBGRAgUfcRQj6XLFf7Jk9q_3uYmZw>
    <xmx:O5B1aU18yfb2oyYyzgl9CBuNDrz4ASL1xeBcHqe4bc4hYBqtnzuPJQ>
    <xmx:O5B1aeGjeVIHVI5lAtIQ9gjT0NKSpRS6ex4fd8MaxthquCnk-fJfIJ7r>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09875B6006E; Sat, 24 Jan 2026 22:38:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Sat, 24 Jan 2026 22:38:14 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
In-Reply-To: <20260123063621.GP2275908@black.igk.intel.com>
References: <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
 <20260122110021.GO2275908@black.igk.intel.com>
 <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-8477-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,sent.com:dkim]
X-Rspamd-Queue-Id: 0E6887FB34
X-Rspamd-Action: no action

On Fri, Jan 23, 2026, at 1:36 AM, Mika Westerberg wrote:
> On Thu, Jan 22, 2026 at 05:29:38PM -0500, correctmost wrote:
>> On Thu, Jan 22, 2026, at 6:00 AM, Mika Westerberg wrote:
>> > On Wed, Jan 21, 2026 at 05:19:17PM +0200, Andy Shevchenko wrote:
>> >> > Well I mean if touchpads actually worked prior this idma64 commit and now
>> >> > they don't isn't that a regression?
>> >> 
>> >> I don't think so, because commit did the right thing and just revealed an issue
>> >> that was rather hidden. Reverting is not an option.
>> >
>> > I now looked at both working and non-working /proc/interrupts and when it
>> > is working there is no interrupt flood at all:
>> >
>> >  27:          0          0          0          0       2277          0  
>> >         0          0          0          0          0          0 
>> > IR-IO-APIC   27-fasteoi   idma64.0, i2c_designware.0
>> >
>> > This makes me think that perhaps the toucpad is powered off and that causes
>> > the issue until I2C HID probes and resets it. I looked at the ACPI tables
>> > but I did not (yet) find anything that stands out.
>> >
>> > I wonder if it was tried to put i2c-designware*.ko and i2c-hid.ko into the
>> > initramfs, and does work it around? I would expect so.
>> 
>> I don't see an i2c-designware module loaded when my touchpad works:
>> 
>> $ grep -i i2c /proc/modules 
>> i2c_i801 40960 0 - Live 0x0000000000000000
>> i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
>> i2c_mux 16384 1 i2c_i801, Live 0x0000000000000000
>> i2c_hid_acpi 12288 0 - Live 0x0000000000000000
>> i2c_hid 45056 1 i2c_hid_acpi, Live 0x0000000000000000
>> i2c_algo_bit 24576 2 xe,i915, Live 0x0000000000000000
>
> Well it must be there. This is from your working log:
>
> [   27.686842] input: ELAN06FA:00 04F3:327E Mouse as 
> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input6
> [   27.689119] input: ELAN06FA:00 04F3:327E Touchpad as 
> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input8
> [   27.691257] hid-generic 0018:04F3:327E.0001: input,hidraw0: I2C HID 
> v1.00 Mouse [ELAN06FA:00 04F3:327E] on i2c-ELAN06FA:00
>
> I suspect you have it built-in to the kernel image and that's why it does
> not show in the module listing. Can you change that to m:

Oops, thanks for the clarification.

>
> CONFIG_I2C_DESIGNWARE_CORE=m
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
>
> and put to the initramfs? Does that make it work?

I am seeing mixed results with those i2c config changes, depending on which modules are included in the initramfs image.

Build info for both tests:
- Commit c072629f05d7
- CONFIG_I2C_DESIGNWARE_CORE=m
- CONFIG_I2C_DESIGNWARE_PLATFORM=m

--> Test 1 - Various i2c modules absent from initramfs

Modules:
- drivers/dma/idma64.ko.zst present in initramfs
- drivers/hid/i2c-hid/{i2c-hid-acpi.ko.zst,i2c-hid.ko.zst} absent from initramfs
- drivers/i2c/busses/{i2c-designware-core.ko.zst,i2c-designware-platform.ko.zst,i2c-i801.ko.zst} absent from initramfs
- drivers/i2c/{i2c-mux.ko.zst,i2c-smbus.ko.zst} absent from initramfs

Result: The touchpad works, but there are still IRQ #27 messages:

irq 27: nobody cared (try booting with the "irqpoll" option)
CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Not tainted 6.19.0-rc6-1-git-00200-gc072629f05d7 #25 PREEMPT(full)  965b63aac2bda1b665a30a4496712f4ba614bf9b
Hardware name: LENOVO 83FW/LNVNB161216, BIOS PFCN14WW 09/20/2024
Call Trace:
 <IRQ>
 dump_stack_lvl+0x5d/0x80
 __report_bad_irq+0x35/0xbc
 note_interrupt.cold+0x28/0x66
 handle_irq_event+0x72/0x90
 handle_fasteoi_irq+0xda/0x1f0
 __common_interrupt+0x41/0xa0
 common_interrupt+0x80/0xa0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40
RIP: 0010:cpuidle_enter_state+0xbb/0x410
Code: 00 00 e8 c8 1a 01 ff e8 e3 ef ff ff 48 89 c5 0f 1f 44 00 00 31 ff e8 c4 97 ff fe 45 84 ff 0f 85 33 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 7c 01 00 00 49 63 ce 48 2b 2c 24 48 6b d1 68 48 89
RSP: 0018:ffffcf8d80223e78 EFLAGS: 00000246
RAX: ffff8e7c1339b000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000008ebc2cb1 RSI: fffffffe2d068d19 RDI: 0000000000000000
RBP: 000000008ebc2cb1 R08: 0000000000000002 R09: 0000000000000008
R10: 00000000ffffffff R11: ffffffffffffffff R12: ffff8e7b9fafe840
R13: ffffffff8bbf3700 R14: 0000000000000001 R15: 0000000000000000
 ? cpuidle_enter_state+0xac/0x410
 cpuidle_enter+0x31/0x50
 do_idle+0x1ae/0x210
 cpu_startup_entry+0x29/0x30
 start_secondary+0x119/0x150
 common_startup_64+0x13e/0x141
 </TASK>
handlers:
[<000000004fbc1763>] idma64_irq [idma64]
Disabling IRQ #27

[...snip...]

input: ELAN06FA:00 04F3:327E Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input6
input: ELAN06FA:00 04F3:327E Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input8

---

--> Test 2 - Various i2c modules present in initramfs

Modules:
- drivers/dma/idma64.ko.zst present in initramfs
- drivers/hid/i2c-hid/{i2c-hid-acpi.ko.zst,i2c-hid.ko.zst} present in initramfs
- drivers/i2c/busses/{i2c-designware-core.ko.zst,i2c-designware-platform.ko.zst,i2c-i801.ko.zst} present in initramfs
- drivers/i2c/{i2c-mux.ko.zst,i2c-smbus.ko.zst} present in initramfs

Result: The touchpad does not work

irq 27: nobody cared (try booting with the "irqpoll" option)
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc6-1-git-00200-gc072629f05d7 #25 PREEMPT(full)  965b63aac2bda1b665a30a4496712f4ba614bf9b
Hardware name: LENOVO 83FW/LNVNB161216, BIOS PFCN14WW 09/20/2024
Call Trace:
 <IRQ>
 dump_stack_lvl+0x5d/0x80
 __report_bad_irq+0x35/0xbc
 note_interrupt.cold+0x28/0x66
 handle_irq_event+0x72/0x90
 handle_fasteoi_irq+0xda/0x1f0
 __common_interrupt+0x41/0xa0
 common_interrupt+0x80/0xa0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40
RIP: 0010:cpuidle_enter_state+0xbb/0x410
Code: 00 00 e8 c8 1a 01 ff e8 e3 ef ff ff 48 89 c5 0f 1f 44 00 00 31 ff e8 c4 97 ff fe 45 84 ff 0f 85 33 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 7c 01 00 00 49 63 ce 48 2b 2c 24 48 6b d1 68 48 89
RSP: 0018:ffffffffaa203e18 EFLAGS: 00000246
RAX: ffff8b8e748db000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 00000000a352a39c RSI: fffffffe2c5332b3 RDI: 0000000000000000
RBP: 00000000a352a39c R08: 0000000000000000 R09: 0000000000000020
R10: 00000000ffffffff R11: ffffffffffffffff R12: ffff8b8e1f83e840
R13: ffffffffaa3f3700 R14: 0000000000000001 R15: 0000000000000000
 ? cpuidle_enter_state+0xac/0x410
 cpuidle_enter+0x31/0x50
 do_idle+0x1ae/0x210
 cpu_startup_entry+0x29/0x30
 rest_init+0xcc/0xd0
 start_kernel+0xa60/0xa60
 x86_64_start_reservations+0x24/0x30
 x86_64_start_kernel+0xd1/0xe0
 common_startup_64+0x13e/0x141
 </TASK>
handlers:
[<00000000aabf1a70>] idma64_irq [idma64]
[<00000000de67822d>] i2c_dw_isr [i2c_designware_core]

[...snip...]

i2c_designware i2c_designware.0: controller timed out
hid (null): reading report descriptor failed
i2c_hid_acpi i2c-ELAN06FA:00: can't add hid device: -110
i2c_hid_acpi i2c-ELAN06FA:00: probe with driver i2c_hid_acpi failed with error -110

