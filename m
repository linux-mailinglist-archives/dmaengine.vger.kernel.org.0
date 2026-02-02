Return-Path: <dmaengine+bounces-8663-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDQ6HsxjgGne7gIAu9opvQ
	(envelope-from <dmaengine+bounces-8663-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:43:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A695FC9C59
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 09:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE378300A3B7
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725B279DAD;
	Mon,  2 Feb 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="r/yPKKHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r97XP3JQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3221F192E;
	Mon,  2 Feb 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021610; cv=none; b=ivdjfI2rCtHws17TvTagwEvR+jxA5f3IhuzyHVEMvi1WzcR9mF9/64+fXK8zMHr91tTReLfETG6B6hP12aYRZUFW7/NL16cGfGdAPnM8fNhXth+16kg1BTlW2ktTX5bYn53OS7eifw9ifpT4v/f7GJEKCxPOk6y2DatsxC27/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021610; c=relaxed/simple;
	bh=dQ+iYLE3xaCJS/gt04FEGz/SrNaX8DNQa/6h0K9miUM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nkcaTLcCs1EvLhoVrtIIbhAFCGx6V8EZdlTbXOYKtwH+ULoAWRv5et9Re/UJCu4LQzIDt/zRWfDyhjWwXF4gT5AWMk7cnrzf4zETXHd61fpWVqBbguSD638Xq17bTANK2nVstqLdixMZN/vb8m9zKWM9P9L7t5tVkbvd5eHj+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=r/yPKKHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r97XP3JQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E69D14002FE;
	Mon,  2 Feb 2026 03:40:06 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 03:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770021606; x=1770108006; bh=BYyLjiCGIX
	IfzlFPTtR+lodWTpHOCZshiBY2sJ/n/xs=; b=r/yPKKHi+tHS4BmEAmwb0OXlSs
	82aU6+Rkt9JN7Xq1G1w4xsJH14100MH4848UXANODEMp+NxICxhe7z3VYNNjQ6p5
	RYP3YYn45CSruNg21BGyxGjMR425a0eQHEn9w5oKsE6mSJ5/0qIutsZPkJQltROV
	rfToSmyzU204mtssUDcCw9oR4lQNdUbEyxdEHIu2qsMUftNBRqqKXC34koL0i/6R
	5hiI+OnXtN6eBePe/spoEH7ZEDrn3aAOCDzKjgGbNWwZxe0aFAD8egJovjt7pJ/L
	m5nFxBLPxex3gpRc9gLe+vaqkk//87V/6rwaBj/p+34KU2XNtGKf/TlC3Sww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770021606; x=1770108006; bh=BYyLjiCGIXIfzlFPTtR+lodWTpHOCZshiBY
	2sJ/n/xs=; b=r97XP3JQVK+W/p5bpRUGiJ6CmiSUcjZ+Ysvhv9HflpbBQp5dK2w
	yifMClrl4LkjeufFfhdvDusotXn+JMHxCelm9a3ynMM2uV0fn9PIVaQFUemXWiSs
	asgqpDsZ+eVAki4BzNNmGIq+OT3ZZCpS5IMjQOIS3Xn2TXNnA7ld+J1NXM2lvOUt
	2ambfgpc4BREiRjTPb9CyNdi6YRZ2Nl0wWDVL2FkI8aiqfIqBAw9/W0I0F9kGJMJ
	RSj3bbHGobVfIWt17IjS23yQu5uxuqri5h43CBkccLGW43HPY19nlhvWazx9eaJl
	C/BMR/mfVl/i07l2z9zJ1IZg3OmpmWjIK+w==
X-ME-Sender: <xms:5WKAaadZScTXbLame9sEMTZnMIDklmQ-dBAoMD05Rk9sAocDx4fYpg>
    <xme:5WKAafAJSs0xvCxTEtA4Pi1rlKKgOBtJHiSEfb4Tc3OxEYhOrF_ZAlPUbcwriYlJ4
    60A27QK8jCnOlVT5MdxzOtZNevkWYrFDDZQRajSHFpfg2sKrRoDAEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgesmhdtreerredttdenucfhrhhomheptghorhhrvggt
    thhmohhsthcuoegtmhhlihhsthhssehsvghnthdrtghomheqnecuggftrfgrthhtvghrnh
    epfeeigfejledvjefgudfhueehgfejueelieeiteegfeevkeehueelheeugfdufedtnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdgrrhgthhhlih
    hnuhigrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheptghmlhhishhtshesshgvnhhtrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhivdgtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:5WKAaUGTwiXFhcwyQ3XeE2hI5nZkVrZthVoHs0AGuwZIR1SJW7LTig>
    <xmx:5WKAaXZ4XlTO5TIk0NdC5rBaq9-fvM7FmRhBc1DpVYkRDTUTYrh65A>
    <xmx:5WKAaeCpFaEnZyuQOR6b89mnQqC_oGTW-IfuNJqZguWdpbPqeY-bVg>
    <xmx:5WKAaXmPwXW9t38OTKDIjiC171DY3YmdMXN9TMEPwaKVkqPeqUnSPg>
    <xmx:5mKAaZPhj2BOOMpzY3gixYL9meO_d4N1-rsKpPLY9aK-XcF215BlXbXb>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D41D7B6006E; Mon,  2 Feb 2026 03:40:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Mon, 02 Feb 2026 03:38:21 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
In-Reply-To: <20260202075118.GY2275908@black.igk.intel.com>
References: <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
 <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
 <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
 <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
 <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
 <20260202075118.GY2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: multipart/mixed;
 boundary=44f9bf283bc9491f90324a86bfd35519
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8663-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sent.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: A695FC9C59
X-Rspamd-Action: no action

--44f9bf283bc9491f90324a86bfd35519
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 2, 2026, at 2:51 AM, Mika Westerberg wrote:
> On Fri, Jan 30, 2026 at 03:18:05AM -0500, correctmost wrote:
>> > Lets try this: block LPSS runtime PM. I know you did it in the past but
>> > this one does it slightly differently (you commented out the ops, this one
>> > prevents the LPSS from runtime suspending). Can you replace previous hack
>> > patch with the below?
>> 
>> After applying that patch, I still see the IRQ message and the touchpad
>> doesn't work (full log attached).
>> 
>> I'm not sure if this is helpful, but it seems like a similar IRQ issue was discussed in the past:
>> - https://lore.kernel.org/all/20251102190921.30068-1-hansg@kernel.org/
>> - https://github.com/alexpevzner/hotfix-kvadra-touchpad
>> - https://bbs.archlinux.org/viewtopic.php?id=302348
>
> Yeah, I think Andy has been part of many of those discussions.
>
> I went through again the logs that you have sent and tried to figure if
> there is something we are missing. I noticed couple of things actually.
> First of all it seems that even if we get the interrupt storm the I2C works
> fine until the touchpad has been reset. Second is that the Linux interrupt
> number is different when it "works". This itself does not say much because
> it is just a number (not HW number) but since they are allocated sequently
> maybe something messes up with that.
>
> The working case:
>
> i2c_hid_acpi i2c-ELAN06FA:00: HID Descriptor: 1e 00 00 01 a3 02 02 00 
> 03 00 1f 00 04 00 00 00 05 00 06 00 f3 04 7e 32 04 00 00 00 00 00
> i2c_hid_acpi i2c-ELAN06FA:00: Requesting IRQ: 156
> i2c_hid_acpi i2c-ELAN06FA:00: entering i2c_hid_parse
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_start_hwreset
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_set_power
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 08
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 01
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: waiting...
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: finished.
> i2c_hid_acpi i2c-ELAN06FA:00: asking HID report descriptor
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=02 00
> i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 
> 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 
> 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 
> 06 00 ff 09 01 85 0e 09 c5
>
> the non-working case:
>
> i2c_hid_acpi i2c-ELAN06FA:00: HID Descriptor: 1e 00 00 01 a3 02 02 00 
> 03 00 1f 00 04 00 00 00 05 00 06 00 f3 04 7e 32 04 00 00 00 00 00
> i2c_hid_acpi i2c-ELAN06FA:00: Requesting IRQ: 155
> i2c_hid_acpi i2c-ELAN06FA:00: entering i2c_hid_parse
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_start_hwreset
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_set_power
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 08
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=05 00 00 01
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: waiting...
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_finish_hwreset: finished.
> i2c_hid_acpi i2c-ELAN06FA:00: asking HID report descriptor
> i2c_hid_acpi i2c-ELAN06FA:00: i2c_hid_xfer: cmd=02 00
> i2c_designware i2c_designware.0: i2c_dw_xfer: msgs: 2
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x10
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: enabled=0x1 stat=0x2514
> i2c_designware i2c_designware.0: controller timed out
> hid (null): reading report descriptor failed
> i2c_hid_acpi i2c-ELAN06FA:00: can't add hid device: -110
> i2c_hid_acpi i2c-ELAN06FA:00: probe with driver i2c_hid_acpi failed 
> with error -110
>
> Both cases the HID descriptor read over I2C works fine. It's just after the
> reset when reading the HID report descriptor things stall. I left the debug
> there above it shows for I2C that MASTER_ON_HOLD is set which means the TX
> fifo is empty and the controller is holding the bus which, I think should
> not happen.
>
> Notice also IRQ 155 vs 156.
>
> Can you run one more test so that you have the latest debug patch but
> comment out in the idma64.c this part:
>
> static irqreturn_t idma64_irq(int irq, void *dev)
> {
> 	struct idma64 *idma64 = dev;
> 	u32 status = dma_readl(idma64, STATUS_INT);
> 	u32 status_xfer;
> 	u32 status_err;
> 	unsigned short i;
>
> #if 0
> 	/* Since IRQ may be shared, check if DMA controller is powered on */
> 	if (status == GENMASK(31, 0))
> 		return IRQ_NONE;
> #endif
>
> 	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
>
>
> I would like to see what's the difference in "working" wrt. I2C-HD messages
> above. If you can provide full dmesg again? Thanks!

In the previous test, I had commented out pm_runtime_* calls in intel-lpss-pci.c.  I restored those lines and then applied the if 0 patch above (full log attached).
--44f9bf283bc9491f90324a86bfd35519
Content-Disposition: attachment; filename="dmesg-no-genmask-check.txt.zip"
Content-Type: application/zip; name="dmesg-no-genmask-check.txt.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAPsbQlwMLI3g7pQAAO+2AwAaABwAZG1lc2ctbm8tZ2VubWFzay1jaGVjay50
eHRVVAkAA/pggGkQYYBpdXgLAAEE6AMAAAToAwAA1Fxbc+JKkn6e/RUZMS/2HuNWle5seGNt
sPsQx9iMwd0z29tBCKmEdVogRhJu+/z6ySwJ3cAC4zMPS3Q3kqj8Mqsqr6Wq/gb4Uc4V+fkO
t8Fy/QLPIk6CaAnGObPPlU7sGh3WmQdpR1G4onbmhmZrqmGrQswMOAmJhn7+Hyd2n+TdKZzM
XRdOPvd6p8D0c37OgCvcUJiinsHnu0cIPfwVv6+weRqEySnwc00/Z6fwV1WD8XAEo4fr6+Fo
Mu3/4+5yOOjBMFqegcLhRswkFihWl7OubsMvJPt/fKv3pBctFs7SA5RHdCFYBmnsXfyf/HYW
ftIppD4PFnOIvfNw/SM5j1Ypdjy5WDlJ8jOKvY5wn6KLZQTxT4ijKPWT9HUlLsRLqkHA3c5T
4J17r0tvNr/4ZQWxSNYLcfH4OOhfOJ7JsbtKR9FU1tGEYnZmXNg4hL6nazPLn7mznGAa+X4i
0gumGszmWz15sYxPySoMUggj9wd4IhUuSdmFv172uuDGTvIULOeQPgn4IeKlCAHnLr+ShFMi
TICG46cTL6kxtlgnIu4kK8cV1VZN7leD+3FnFUfPgSc8WD29JoHrhPBwOYSFs+rubC4srnTh
20IsQHlRGp9O7ZEtfN//jrI4s1C8C8z2t8B8X4LhqIr4WXjvgWNN2dQZ59ZRshGl3QSb5WDv
l41om3Ae2t5xsiFlY9xU3/bEsbIhbQNO47aVwV32RgO4+zI+HI5ot+AcvwLnOanzHjzH34Hn
HzV0Gp81dUQz/KNVTjPdLTjzA3CWaMLpOD3Hwrn5dwXO9Y+Xzhceb8DhI/NoOH9LOv946dgG
o4TTHH/WqiZ3f4eT6xfhrlMB/UA2OQX0koVrdvD7eYvscjRAjz1OnTRwAd1omMjIFDhh8Me2
xMIPunB9M4Bnfm7B7BUGd+N/9K8xtMWr852NyUYulBdpNPg0sxl+rhTPmAaT0fAmWDrhbTSX
j23FoKbjIQ0QPlE93yN/A8Pr4eVk8kCPjJki0Dbhevwwye4ZU5gFD3efM2jGfbwd3A0mD/2c
QHWRAJldP4tlumHmKA7RNYWPMTRFC4plGJpoRMCLllujJ7v4IBbRswCcQVvvwnA4uCfqubj4
prxUtLbU1hOuG8OrU/DjaAE0/xS3tqClXsQZdq4eO9He0q6mbGZTtorOlrp6wo4TbSfYW6Jl
MwvquYYaim2W6Zby9IeDLtxe391/uQdLvfn66fbuy90VMxhnxpm0HBjd9O6Y9vUrKPYnruAf
ru1EGaKg8SskYZQmsIpW69BJhdcF/ok326eJ24W+TGcwteC6In+C4a9/kCm5IkmieA+NZhsF
zWTcq7U2NmO3XmHYEE0nsrH2ipXDxcV/7x5Ga/c84C9OifWmx2DsO4ROkk5X/hIukA79C2oX
zvbLlHLm8vlGuBq19h2Gk4cHmW+BDjiBcSASOFHBD15wFH4BDs9OHBDb/yJQ4OrpGczWQZhm
usWUooGEqmV5TM9yzNHlpIu+ZekH83XskBuDb0rH/N6Fr1cAX3sAj70O/oXsfpTdf51A1ZxV
TW/2leLmQV3VDFPFcU7ilEyJZoEyVfI5kKWpsi+V7GPjhtKo+ZRpynkN2NqtDBmEnEB5uV8Z
NMNCrMeERPt8BStnjlPhRzF4QYxKSZO0wt8qBJaJQzLGWBELmGENgS0lA6/ZBnPq/mD8WxGf
VEXfZFcq8zybhKvQ2CrPsiIMEk4cvkIqxXafBKbx6wVVcYGPybqcyR08bVXb0D+M+6NaqnN5
c02xgm64BifPWHdl7uG0BmBtAP4+7k/qAPyGWRYBMN4jALbxL72rDt4QRvaR13gnwzBTawy0
ooc3+FVn0FfJ8IlGkQz0txnIMEhUdFtnoG8Y9Ld6oGYM7J5u6tUheB8Ds9KDcY2Bdc3yHiBd
jaYY1keK/vX8+HrT695NNqx5UnDZv+2MOsODhNKVDYPxVq9vrIyBxq/Znl4P7ia3VIorisnM
OgPWwsDMe6BaveMZqC0MjEIxjOMZaC0MlIyB3le14xnobzO47mcMeI9bxzMwWxjYGQNVvbaP
Z2C9zaB/lTHoW2o+B4hzfQswcZNknHipZCD1v4WB3cLgMp9kW7s5ugdGi5r27Y1xqurxDHgL
g9wOGLu+Op5Bix30N3Zgmh9gUKgppvK8wUDfDJEmLVk7xkEaxobBcNwfNhhoGwa69MDqUQwK
Nf11dN0cIl5MsrUnSLUwKNSUyrsGg42LZ/3e0T0wC3c97N18bjBQih7sC7MtDFrUVM17wPrK
9R4tejuOm4Wa3o4GTQZFD3of6EGhpl/Hw6a77m8Y8OMn2TTeHiK+icnoNI42NLPFm/LcDmx+
c3zAMQs17V99buRSfJNLKVlEO2qILKXCoOEqeGFoumSgHMWgUNP+8PKhwaDIpazjJ9lq8abs
JrcDRTnem1otWQXLQ6Zq9y+PZ9Cipsz8Mxi0ZBVsE3CUm+PTFquwg5vRFoMy4ByvpnahpqNf
L5sMNnZg3hyvRXaRVVx9fmgyKCLaBwKOXdhBWSXL+igrABfZCoyTbupIjTsedayTXzJlVqsj
bXUbT5ZDb+OpJZ7r66ZWx9N2yjd+G88SbINHl6q/F09WRm/i2XI1vJNfMlfsxRu399e3iv76
LhdKHU9/P55Z4pmqNfswnlHiGUzRP4ynlHi6p6p1POPdeMIr8AQOoPlhPLvEc1VhfRTPm5V4
lqU2xs98P55T2ptja+LDeGV/8VLlH8Yr9c+zmHDqeNb78Ur98wzT3I8nq4kWPL3E0xVtthdP
Fg8teFqJp2EOUsezt/FkrdCCx0s8rqjmXjxZGrTgsRKPMW+2F09WAi14pf169Aq5gkcj++75
VUv5VO4p3l48mee34JXy4aW7Xz6Z1rf4q9K/4GXNvyAee3d/eRE/8BJN5MN4pf5xj/vqXjyZ
o7fglfEXL9UG3o78QKbkLXilPuOlfgAeZeAteKW+4KVl7sXbM37ML/Hwyqnj7chf9uGV/p4J
27M/jFf6U+b8GXilP8VLvzF+u/KrUTte6U/xUlP34sncuAWv1D+mmgfIJ1PhFrzSPvCy5k91
ztD/3UVw9zi8BLf2fsqP1kuv2pSj67hxfhBHB5aRJypslMZn1+v+GhamTXf3/etp/3JyeaKc
ghOGkUtvMwvBkc7TuSUl34WhaijP/0ZLkb0HTrq139DsgQwJ5GeHlKwmpbLZ5VDnoOYoKt+F
wpp9LXdKbKPcRfHCCbdQWjdI1FA0KYt4DlyBF2KxSl9rv+OIDqNnqQV/0KgkqROn8u2ZcNwn
OWHN9tmrrVxn5IxmQ1lrZxBf+SM+2rnzbGso851n74J5e5NYDcZshWnbz/UOmLa9TTUYqw3m
8KlFGxwsg5SoE5GuVxmksn+sd+PRC5z7ZQ5ylmkDKnEXWP5KNVjCeuk8O0Eo1WV70mnZdSeC
bR4GYWi0argDQuVdwKiqHQijm+bbMIrNrYNwuGrRykQTJzNJBGKmoRwMtEOgDRCjF7qH4dgc
J6l04YNlKkKYx87qKXCTHW7ctTaqVGw9K9EMVll4GXYmwULEMLiHUUSv+5UXZilWpTUvk8Bb
yp2nd8MBnDjuKpgG3jdULnSeT8H8CYQ3F7TJN8WH7PtpDYK1Q/CPQ6gHQPB2CO3jEPrHIYwD
INR2CPPjENbHIewDILR2COfjELOPQ7gHQOjtEN7HIcTHIfwDIIxWCKZ8HOIQf7EH4hB/YbZD
HOIv9kAc4i/2QBziL/ZAHOIvrHaIQ/xFO4RygF5QZju4J+pvyvcuOKvARWLgZ8UpFxWvHc+L
RZLQ1kqR7fs8g8/jASgdxuwaXKHsg7vJdPzQm95/eYCT2RppAf+dBvE/8WoeRjMnlDccPD+k
v3WxjANw7CqOnXU1FM+iAVUsD2W70uSLg5PhZX9yKlPr8XDUKJuCpU/ZAF1XgcptQXL1K/Ao
LmNYNrDmZjBzEtGVAyQXl5Qa5Zvb67TNyq9q6DIPbN9eh1i042Ay7oEnHI8O70AqU4UiT6m1
RR3qjR4hjVZRF4bOyzmE0VweUFk57g/KcrrYmNVorDdpvCBrDwfQUFtYoWA5oy0+9Na+QZM+
xdipjMyNYknDazSsSnO3XpzLdluMMIvbQ1ZlVRKyFm6XWN3+JP1hfLNPmH5FiFAq5VOU4tVc
PquiWIgyGnZRO2ciXjrZ9vcHMQ+SVMRYKy+jxHneVP1bZUx1F24NlR+JWjkWtJWCcnrB+37U
XVpcQ9WOQ93eelpD1Y9CLQ8fFYeO/gTU8thQcSCnhmocg1o5UbO9KEGoaN15Uz17DSqbCo9l
G63L0oXc3Kg3QJ9BSw919UTTvYqilDR75cTOcxCn6+y8ReW03MyJBTw5sfcTL6rkVLS48mBc
tI5dQRvAfXRKXuf3wPelu1g4yQ/pF/OP3Orsvroh/Vg+PpPPAy8U0yX+wGym2IZta4pqM43Z
sCylxtKTKi9ZZk/RgN3VGq36YYqWN+5azOawjKf4kDhPZ0GadNnmETLY3FH1l91WgG0qaDaQ
14uZ8OhUn6FmFeEnfAwJ54xZGsSSk4dza3JY41AwTash4eyskKAjl8W6rXTZ0tkF+0+sh02m
8xqOXcfBMA30jpzRYU9FBazDFR0UAxQz+80CxaYd7YxBp1P+qWLS8P2WTa77//8cKHaIlhhW
MSY4qGoYrTBD8H307HQcDn5Bu8Ivuka9MkzT5MzAp7qFnLluwAWYumabGs7H7DWtmIfKmYrA
fTpR8Aqu4z6RESRP+UJtftBArmLQrMEJjoSIkQlmTAUjCXkmx9eJTyvYps5pzQjVsPM2NFM0
SzeNEpqdgaValqFYbyNbtL84ifyUrJUWESa3V5jaYcSD5XqBopV7/zXMIS1aEw7DGYZBkGyk
v7iTqyNoolBtTHsrruTBCSbXTUJ0YSjDIpoFYZC+wjyO1qvsAO05wCRKZaoh8wyNMV3jvIZG
8SYKA/dVgnXzVZhKE04by8jHOes06pBadmlV1P3RRYlP/hBxdHoGT8JZZSbUpUPQ8taPheii
whRYhmrRxobx7SOOxa9f0cXNlxeGdgb31OULpaOewTBY3s9+F26aXGCCS5H8guaShgKvCihT
YZS9+Ggi5PLydW/qtW6iwypOoARL4NzI+l8jZlvEdFhn0xR+BukTaNlYVgk5HSjovy6dReDC
CDu4WOFw+OswrDai1CB20X/lLQJSqKdAxHS+JDuc3HuEYLEKxQIlldHofCfAX6gh2h72xpXd
k/mOPGWSu9sL6czSqOJeccTqaGoVDY00iklRZlGUEGa3fMQwPoXOK+h0HibZAvnLBD3SKpI5
rzytgwlY5MMEvXwiuySW8ghHnRCn/C8Pa++9JMjLpR6/i0p2kxrgILvZwS4ECNeCyBM0cW8d
irgjlmQ1NPZ5h4ME7VyBPGTWYfUc9tL7fS0HDOYiQoeGDomsFH+b+s4yWqfTUDj+BZ1Hq81F
FYyMl8STPenCWKQSMHkK/JQmUYMsEizohknslGKoO5s6kv1F9eHu6SYbK3gAjfy/i5FeZTTJ
rOnfwElVaeMm6vvg4W/jLuhY4mqaHGSsOsn5o+c/o4qgtOTsB2ZUQAyyeTmRCbHLHFkhLT1C
K1u7KSSYeSWymPQo8cLCNEVFqZuoanOcyR++WLp5zM5PyEIHq0dC3EQkGSKkonBdhyjzbbQm
rbycTPGzSmNUULo67Ww/qnKkKrqHIT8KkaUbhZjugbdeLF7zpBIs5YXrVQoKQkVMFnMHnbyb
AcC3NH2lo5vL+pkrJCq3+fawsEPn8xzIRQiK1IqlmGVbjTNaDl2JNK/HvdfEXy/l+WL0ceh7
Rz2mnMNNhHlpcb6rMoqaSmlQfuQYXa77RDqSvC7IutDBDj7dY1xDzyETzRqd9l2+4EfG6MSK
xZGfgYd+W7VrTfVN0/7Dr/1ikSAr7jBVp1pEAT905jIbVmq01obWWzixPFw5nxLClDhCQf2M
EVvrKuh1VsDk6oyrKYahaAYHQQ+57SAzRVd0UcO398jGarKxKq2qV2Vju2RjG9n0XDbaFGQ1
RCOpPKeGbGyQH4YPDw2ptPzQMaqOVz7dvE6pweSd6wwQKVvgAlrXgvWSMpyix5At2WTSDu6H
w0dgb+Lk6z6YEzVRSpAqsaZUiP+2FmtyDks0r8DLVpp+BmEIM7GxBKmA69UqilN44bQWJ93X
APOJTizyo5MVFdZtWr4rOFznKOipoGhOlpBjLarvj4kY9Tj/acsU9Wzba8U6EFiOImYl0mul
ETqCcE0lbI5SUFuKqjcLwzRxO4JeVm+XhG+Uhlz1HcyhXZ8bjepQ0xTT1rlhW6perQyJL6pP
Dwd4FmcZWRZhwyhawUnyI1ithIcZYxaVK2E6c5vZUhqmjv9co299PT8H2k18jppxFc2j4WA0
hpNw9fsFnatWqruOLay/uVwtQjOdPAm5T2ARoWfG1AaBN/N7MhmyOpWWHS6WBedjgtyH5HIG
yywckI5gGvechQA4eUQZTrP/PIHEriDptILfIzeYH/5GrV/mZ26vYmeJ3o1i5I+KNDVqlP7W
QWcm108hwIqhLEK0367oPSkfyi+NvlpovX20WBx9bkLo3zdn2rv5XCx+OkFKykuzvlmvq9Fg
abbA0DeXppSU6u+kVCCg63Fx9CWeiKfZWsZZdkP/nMF8jant9Ald+OZa/nsGtJeuhkzFR401
OoXxSkjlCZ4FjFMKVlevVA53sYrYkHbfbFUEJHgOHOy6m4ZVBrRPh0hTJPjCoY55vXzC+UTS
T3CJgi3k/5YxuHoY1xDY92KFCW4CHMI+FcNjTKFDmXZXEXuYO8b15k2sL8Nx73J0XacbXI2u
0H351C/xEsiMi8ZWHkevIfBKf1ijP0ThRqvXT8lPZzWn5CdG3Ymz/5BpKicLVhEmEvidOJTt
/FFfmycGamPANjfPHIdp9C/inq65bSTH5/sXrJ2HcersDPuDZFNb82DL8iSVOFFZnmz2sikV
LVG2bmxJK1mTpOp+/AHdpNhflChT2nGNa2SlAYJoAA2g0WhgzsVZjjzCvNszqEWQBShmwJfu
+fv36Gp9uu59fntrIOUW0idjFmD+UFDBqRlPC6/DVjnQ3fFUqfGFeisdPx5QR+WfoPIPlN1H
jJ8H5596sIZmz3gmHlc5WGB//i4SWIznyqxJfuCiK2ds9bOBljVFSwHtYNBrjYcDnvNPn1vi
AfcA8PQ3XWKCd/mPlTKKNYh5M8RCIgbv9Xk5fzwDHn47BFZc7G20RVJtgzg4effpGoTr8ccr
8xmR9ozvKwjCy+zWF/q1EwRRAkte8b2MCNTXNIoNLHEtlhSHC9y6M7DIr+EfGmKBNQXR8NBC
o77XIxzEk9TjkdSLyH4p9X2gtUqx8ZQ2XYGV3MeNSJKFyamKj76rsAnjaCHCMi+mlpGfR/Mn
sEawIP4cqF29yn8ShOE59qtlnsua0+t+kD0+qwz9n/lqk4+P4nc2zGI6HoJLAu5vPsnWjxCD
MJrEAizEbPq0foI/Q2LDPII9Q48IFvqFtG3L9WxmOHTFwH9mT1kH7CqQLlfC6Ww8WT86w94P
rjfeoqwRvOhf2Y2ViqHX8/XseUuaURFfJhlhmoq8dE2KUccqLdHBUa+eFtgLpFO4VLK26uTm
lYwKwYl6FUQBoeHvwckke5qiTxl+RycRfKdH/HyXnQaggNIBxr+Z84B+vpTiAAtpIFswrTqF
hp9jmgxN0HoJFv39xc1p0O9dDILJ0zP/7zP09pHm0yA4n/24lW4JCAHE/zL2Pw3OH+FFH7M/
8uDNj7slBAvSe4M3ZfRsnOcLhRGTdmcqYBwhF8FWnBYVZH0IQcZLmMSlM+NqUxTTFPhJG9kJ
7KGvwXktdvDLLVv9J/KNv4MVXNLkQnDhA7jPZzmGyuUraHBbx8ODZLMe7Sc0frRYTgOX7XzO
FuvlYg4hl/FQvnu88dDQep6XfTJIUMGK9ROGVaGwEXlq4NhoaAGvOx97wZMd4EVpAzgfjzYN
RQ3ppI5Xq+n9DGsZkQL4PFlmT7m0kKCNMaP28N4K4h4ZBcn6B0xWZiA62X0uMWzCIWyxJoPd
6psTjJhWsmjyFe6DuGIic15v9OzzYFv6WYf6r2vk4AM+cTY/K1KlEBihzq7Q2PMwdCBV4eTT
9H5Z+Gl0k/v+oQKU1d8DEQAtj+NlPpMFADLR/ncYOVrOVytZFipH2rixvOZbBqHweH6/WZpe
oykBOwLv8qgyXGtkCdaUPnw7QxUtBNUgFc9ogY3rgKMIJgqt/HoRrHL0JbPlD5VoBynQQLjc
1CnNIiyQnc2+rVPB0rHhXqNEqSLnn4qdjY08/UThl8NvBL8x/CbwK+A3DX4iIfxWC1mYRFhy
VJmhDMIPvxkqhjY2Q9r4ZmZIA9hihuJt43eaITbxgW8xQ2z3+G1mKPGy7wVmSAN/iRnSebXV
DEkMDq9ExJk8vPETgd+KJ7jlHW3kfr6+f3hGsSdSMk+xsMYonqmGK5lXu4lgnWQFTtEAb1Vl
Q4KTKE1DrqdrtGUfc3lfi/Z7nYBEKeU8ou9+ITGPSSzEO61e4gQsGeHvygKIkSQvSkWUvguW
33AnGTd4wXOGP+fqT57gX5iLP8UtgRCg71awpkd4XgfHFaVcp0H4Lhg9ZWflFzqJAtk2zv98
flpMVh1v78tiEDrIT0+bdoJ3svWxMvGEiuuLaryIKasKy6uyk00p3IdPAxmwYD+7opylaltb
tas9wSNSLI2LfedX9hOMZF/76g9C45DzmCayp4Ge41OPA12afpf5upXX7ZQbk6XXGcF0MRKW
G/wer1MhnawhmPCi42Eag1horiumDIg6dIXiC0ifpXxiRcG76cXmGa/1hyRFKdTNbVcmGzuy
S3faYUAhFgZ2ZOvus5DCfxVcGmEnpg+9W6NoqH81hK/ev/3w7hf4ePPx99uebLE6H80fA+UW
aygE1qPI8x/GVhUu2Uhu8NtVf/iud/Oh9x5YiwggoEDrjinoYn97rs9CKnvKNEL4f/gRz3E1
QZyGoJB7Ima0MWpgQrYe4+bbRrlQEWb5M0wXaND6bvUDovYyO/dKB8Y2QAWwrG6RPVvkFyck
SbD3O/AErE/aIa9klcJz/qu+OSeHDovk668hmgStqKB4wLNKHg+BDGO2i++D+zkspzN40Z8n
2XQ5XD1ky/znlyO5y2a4bzO7b4EDA63ht+mqDR0yLSvThi2QLObfAEsx9fOlgwk8FjQxZYZ5
A/iYjcdaZm7HaPBa19pYueOANdeLh4XqMBy8mT8HfawFxZq7Ij/0iNtF0kmq/KHwdaQh4hSr
BLtgphej6fDpaTS5H8oNE7lbfPJKfg0Kfid3m3RAbAMpAXvd8+ut7XlPis2q8h9VBfR4/pRN
Z3I9D77IEuvwTK81xEeUtA2HFXWSLkmiriccz67Jsare2qytRs0Bu4mPlbRkI1zHNfAIa+f/
kO8J860+BP+7flqcYdHZU5H7Rfe/LMPA0twSAqucgmIgbrZNcKFYYQlMZYdh5cd6sTfr+1wW
Ri0rmSLoPPw2VX1L5Xoqt/bPKjMUWuU8NjISMxFKO/UnzAN4esEom+EWHxYkjZWJMh/ThC65
B3Xdhi4qdhFlPKPCw2IsG1lm0zFEHMUOWrD4N0DPRg9P2fIPmcpa5Y+q5XD253f6nRvg0QZc
aZIcQuH1RqhSP8BW32MB0MOTBpVUrQHPZQ3m8OPg7cn1HCtoihO0r4zhzDO8XzqJXgi+FeL8
/h74j2bEBiYiTUhxPEH1fu4tlzDs5G59D3b/CpxITBCPYPGS0dkMou9xUXsRfPnXcHDxut+F
yPX285vu65s3v1+8HgxC8nr4e7/79TQ47w3P39/0zi//Oex9fju4HaAzqmoffhmvvj3OszE9
YzQ2yEE3eXI3Qptyq053I2fLcgt9JCv4pGjuuI87DS7Xy5Js3Df9Y734BUQsw7LKipTFSr3Q
GaWhQQqrOmyhrBRlxStZAnV+/R50E71pdFyfH+bgssvdDW6iSA/P3P77y5cylx+bZdWZmRez
jB+aZbSVPEbHZlnUnmVl/9dDsqyFlMXhkVmm9Vp9KcviQ1s91krKysaiR2NZQlqzrOzseUiW
tZCysk3n8VgmWrNMkAOzjLeSMhEdmWXiACw7tPnnraQsPbb5T1ubf0F5e5YBx94qlr1p6cEJ
Ko7LMsHC1iwr71M4JMteLmXYhfDILGutmOIQK6bBslZ+mUiO7GSIqpH1i1mWHFoxW/llIkmO
zDLRWjHTsg3AwVjWyi9LCT0uy1LCW7PsEAG8zbKXS1lKjuzKprS1K5seIsY0WNbKL0uPHWOm
UetMRnqIGNNmWQspO3aMqV+38VKWpQfw/g2WRa2krOyFfTSWVc2JX86yQ5v/6OVShieSjmr+
8QEtzT+gOLgrG79cypCco4bl+ICWrmyKffYPz7IWUnbcrCw+oKX5BxSHSP4YLEtaSdlxXVl4
QFtXFlEc2vwnraTsuMkffEBL85+GhEQHZploI2XkuK4sPKCtK4soDq2Yoo2UEXpk809o2ppl
0aEDprSVlB3XlcUHtHRlizqmQ7OshZTFR00xpqonSkuWHdqVJWEbKaPHdmVpe1d205XzkCx7
uZTR8Mjmn5LW5p+Kg4bl7ao3gJxNyHsslqXtpSw9qJPRriYDyTmylLGwtZQxetB8WbuaDCDn
uJU/+IDWARNjh1bMFrl/IIcfWTEZb+1ksOSgAVO7mgwk58iuLGtbYIAoDq2YLXL/QI44tmKK
1orJyUEDpnY1GUjOkTMZnLZ2ZTk9tGK2yP0jOUfOZHDaNpNBUrZZdEmqiEVAeRJnFazWslIc
D07/CLLRv9dTLIyW3d3ghasTUiSlceq+7IePt8Orj79/uDwN/vGA7VCW+Wr+KC/uyAr+L/NJ
vsSeamVH6CBXZ1SDswDnZKgm5X2/C37ysNd93X1z85vB+8Uf91gTf8aZ0F6MJqEbrR6DnkHv
A2tGj7ur8dfyx9Xnv5Q/xF34/1L+kP/MfDXnj5tK+Ev5Q/8z89WIPxDT86i6ibvo1vqxdx3c
yiOF78FadfTBcRVqqCujr+BHXNILQeA5XN2HzNLiZvP+000+CYLuYh12V8+Buiu5/spoGkay
oU1DaqKIh1uoKS+wjnouNW81asJaauKYk8bUwGD7vu4NNZTS6FxRQ84vHGr6q3EDapK4SvPt
pAYG23fQ67wJC97wi8ih5s23RQNqUhI25w32R6+lhl8JRQ25OL8yqDlfyHnaTQ0JtcLUXdTA
YC3H4FJzXlBT3OqtUSM504AaSqvNpZ3UUCqiLdT0CmoYTy1qpNQ0oIaJsDlvmCCsXm7IZSE3
VxcXFjXdhjOVhmLD/F4Xf9XFgZVPJMdE+hjZTW25Xjyro+PaUApeWWSiG3avL3+B/w26v4bf
4/gUv8JLH/EvagBufEDbfva64VA1rFBXpwON65VqePmAbZHy4HmZzVbZyDiyK3FuOI3tcZaL
ZY594KwWhhTZsnk4nrA+KTojrYJBGAxYMODBIHpljN8gVucUiyaheBiu4k7R7LKCA3q4c0wT
e0j6TmkKA04YxyKx72CADYJg3fk2nY3n34rW2kjT3/Hk4ixHhzdb/pBdC4O/AeZfZ/PRcvU3
1T0ql52fsgCCCuM5afGct/cz1X2yJ2hYNCBQR6LlS3oIqNCwiFcyVfTgEsFv/Z7saq7aDYBI
wvQlVxVUqm0BaxJgpZcvbm9uO8GH/FsgD+zKlRnbBmh4SJUYr8dzCYi24mGJdo+Qhqf74dM/
Xv/jZrCdCiYi4YO+6UPA3/88+NwERRxuR3G5C0XEk+oCMQ3F7cVtuAuwOvJjApIdgIL4AC9Z
d7gVME54dWLmX8Pb/xm+vvoQbqcyTiIaOTDbCQSYJHZg6A6YmLowbBeM5zl8O4wgSSW6/bcf
drBMJHQzHE+L36CFvFBK+QXZ/jU48R7PzqtrvBALFjThIfSg/6Efnoeig3wffhyA/f44CDa2
8Evv+3M+g2i5Kw9lB+eD/nXQRW2G/w/ye/R+V8H1ADzpy5vgTf/z2e2PRV5dh4wtd9FlqnnU
AgwhdlULxnOI2GfwKmV/ui/nvZsKCzjsJN5G8Gz+Tbb2W84fV8iHt/mb4nqlwZt+t/zcv+4h
0/JutsiK+yfe394El/2u8ShclZxHqdtjpPV+yhYnNnPVUXr3UuRXOmLscewgLlYFyV9YE8Do
PjvYNSxxSNR6YthjsKtqNGCsWkrL0fJamelQ++eOvHJFApQCFnyZzoOCfLzsaTRJChv/1UCW
7oVsvLmLyIcMc2ZNkG2uospK6sLwrhYp2Qepdg3SXdlwxoeU7oOUbyYf0FbtkryIWTPElSQY
0MIDvRplskkkYtAH4wlYGLwZCAYaby/G6+g6WYK+jey0AHI3eszkzX0yegtRrYp20tmjlDuw
B7KHo4ad4OLvYgebgFe0PE8nPwqvbakasj3qrliirrw0wKlOXDbyEMckcajNygZ259gh7rt0
+rCXG/gfPZdQWgid9aSL85vq6uVYnz/8o5i/mN9Nn78ayGgdMuoVBr7pvqWQYUuGiYkxqcPI
S60qb3YPmQnKhA9UdcbHDGvRrF51qkEBQZ+uvH1YR8S9LPo0Hefz8u4GeeHM6iEDeQY+33y8
Nq+FH1WKOjZuIUP0UepDr9Y71bR19IA3J4+xfaBM0oBxu9RtGo29FMqxw5vebyiyM8yM59gK
rbjZPpvKfuqRbkpp4p3AT1emQGgzuEUYErYvrtjA1ZELGCzcqwIC5ycBBMbkJF5NKZ5CPU8h
OyQOPZa9EI49CC3aqZd2Vthm61FNjQSnNoO5biTI2DUShIimFkw2oXGx24aBbK6sl38QvyxE
3JZxvs+bCmJPcqy/Kd+8KdFtNTfMIV4DrqOMbUmXKJEZlQehlhmivUkSEnvOFNx176fSVcN+
MBiGXobBJXvAeJ2N5o9jHQm3eVshKRtnGcO9r7+HhUhkMbaLYm8LAeuiF1H/9rq6ogHX61en
AQfhB3M6Wz9meDuVhoQxL/MbikMiPHNAK3Fg+4tDIoS9XkuUPnGgujiI1EtKYKYFKu8qLrUl
KoydhgxU04tsL9kSoYe3tFa2YLgrinQv2QIUXt7tLVvCJ1t0T9kSstDKRdJQtkTimBphmJqJ
x/MSTY2qijJd7K5RZWPNqLKxz6iKJLZ9I7GHFglBbZs8NpaP3POmIxCXZm8qb1B0sbtvSvXl
g3qXDyGcRX5ca3T9WiFPIddg8GiFSLy82Ucr5LFkF8XeWpGGTiww3mOaU1nfpIMTzUuISO7x
EppPc8qJ8GE3pjkqGtyeqY/eKU55EvoQNZ9iwMBrMbhTDMMj3/A9phhQxD4U+0+xzHG6iJpO
ccoSB5xqU+yzWXK7rdEUpyL1YffYLK7brMQ7zfJOLD8yaiIb6chGHmQiJMIWvsgQbV8IP2po
q0VIU3tSIke09eAFf7xkcm5rYLSfpAnVoNJFsa+kYWtJL6JmkpbiFbAOONM4fteC42mY2LkI
hX1fjuMeijt1bB+OIwpbpySKPTnO8JilO/usIccBPLadKxIbMh56OJ404zhid3Q7rvFHUl0d
U5frgCzhNsvqQyM04TpoZM98fUAEw2WDDHd4Q54SFtmEjnSe3mV7xg+IUtizPKoLJ9lXA85e
hSScEz+oTBdTk8D0uEEisbXSj6RcjqNqOY7MIIThDrRtoUd7BrgSia2Aoy3zSbjtnanhjfVV
ovDyYG99JZEdABSkNw9CAEnimPzRHgJKie2ak7EhoGRvAaXETucolD4B5V8NOC8ptbLFK9ni
tmxRauc9SL0fXydblNqpDFLvysvhtmzt58pLFF4e7C1blNpZhoL0fWSLRqGXmqayJez4mEx0
2Up98UCMt+U0WVCYbMTgYm9IHHPndqL7F6PMQxwPsV90E+KYIwoTx79QC1yor3bMt9oxFtkG
Z4OM68g27or8w5crB2TcWZEksqbRD2KIbdGqMLhaAcNdKdjHQ5IovHO1t1awyHG1Jnt4SCzy
vDmvZCZj3gA3aijQMXHfkntlRugyI0LfNMd2xr5CttnNyicZosknd7rpZImHSbw5k4S9sQPg
kcYk/nLHHbCn9i6dwm4waZIrXTgrPppLA0uL3J+5dzuZfl8vVLGVtnvLQOeJN4O+2estMvdn
mFG9yx9gkSoWrNNAXh4b6rgKi6g9mvi3jWEwoU75ANlCJ6H2JmSDbQaEK4TafAz+gXQFy/x5
vZTUyY3Hp+z7r9VtiQxP33iTwBZ78I6UneyJWOSwh9axJ2KxsTjRcledRHdJJwpRmRw5IxBs
UeW52BvUiNEMw0uMVoZJz6uHXoMdRabylYgaalAUCWfiaf3Ew3B34nduKCBc6lRA0B0TTw1w
rydtTTw7gyhk58THzCluYbUTH5seP9tMfJiPOncC0w7OxFNpYOomPjE9VmZOvBkQhYYxiRJz
P1wHpVvCIFdmROqlYS+HFZCIWiTu0hyH5tLM9pPTWHZEcGatTk7dSpNmgSte4+R5zFY5ZQa4
1yu35JSf4cvskNNNAYVGCq+T05iaesk3cgoUdURMiW9/B0SF1MlpzMxCIu43UFyufmfFR3Px
iy1fUkdB/KGVvHZOR8HNND/fJqleMY2thDjfIaZxyH3DG4qp4MwpduP1YircLFqj8BXgfLKx
VUy5Dh57l+/Gboa2JgvHzd1zTTZwOQmw/cy8icsOZPZTRQOXtzCwMbsjZ3tUytQq+zMvLkGS
GWC89w4r9NB5NaC9NXcWNO/Ii9Ixnxma0Pbmsw9adDZ1gKHx4k6xmQ961NEy2Dq0U2HmgSZh
LXQDrhFeC2170j5oUQvtraK0oOvf21YJDzStf297k9YHXfvedsrZC1373vY+ihdavjcbR4wk
WWZAN5BUVvveUQNJZdp75yZ0A0ll9e/dgOesdr7tUF0VvPn1OxvZ+m3nLLzQxXvLWDMxoL11
fV79lvkf0zI5tRY+aO29ifne3lLULfptPttbIFqv37HxbHv/3wutz/fIgPYWhNbrNzef7S0B
rdNvbtlUe0PfC12r3/7C0Kb67a8CrdFvbuu3U23iga7Xb3srwwvNa3neQFrq9dupWvFBV/NN
qjuPJbT93rxev8nY1m97M9ILXby3u36nNuU+aPneqgrWlLXUlnMfdK1ds6safNCFfquCWUO/
nYo1H3StfttlCl7o2vlObVnzQde/d4MZq12/Y6fc0Qddp9+xk+LyQde9dxw2mDGl3yFhd4SP
TOgGM1ar3061jxdae+/UhG4wY7X6HdubR17oOv0uM0J2OOTVb27rd+ysJT7oav0mxvqdODz3
QZf+Obf0O7FLpLzQxXsLYq3fiV2c5oOu9c+FI2s+6Do5F05c4oMu55sg43Rox3fwQWv6PdGh
U08aeYt+TyYmNGswYxv9xpyIPmNpTejt0e/yQFkFnfpKqev02+E5Xkm8G7pOv9PQ8RV90DXr
t2phsRO6Rr9T4qnFrtdvinv0OrSzlqgUhVe/maXfKfWXrzfTb4D2FqI30++UOlbRB12j3ykl
rn470HX6DdDeivNm+p06mVAvtNjMGDWhnRN3Puga/U7d03UeaKXfuK8SGZ4HQDfgeZ1+p5Q1
4HmtflM7H+iFrtNv6rGpDnStfrsHC33Qdfrtnib0QdfpN/1/1r60uW1cWfuvoOr9MHbFsrkv
upVbry07E9/YiY7lzMw5U1MuiqJsXWsbUkri+fW3GyRFgGhQkONZvMh8HmLrRgPobrQdi0h0
I9+O3GrKWjDqmL+nbflW5m8KLa6/ZXRbvil0We+obZ/Hapgfhdasv2M1po9A7+xzjL3wJDQZ
Z2FmnwO6PVootLa/ldUchdaOc2U1R6B19jmgDUaLzj4HtEF/6+zzWPGUItHl+jtyI3n9HTtt
r0oKrZdvJQyJQmvs89hR1sAUWl9vg9Gis89jNfZp0rH+ztryrcz+FLqst9NefwOajLAh5ZvH
l8jyrawkKXQ9f7fl27XIWBuNfGPEkSehyVAlQ/l2FRuZQuv621WsHgqtk2+XDg0ylG9XWYdS
aJ18u8pxFoXW17s9zik0r3fohFZrpLrKKpZAa+XbVcJHKbRQ71BGG/S3Vr5dxW+JQov2mijf
btvas7X7axjZ1W41hwyQMpRv1yFjlAzl223biiRakG+51dq2IoW2KzuVB5tJ8t0+VSTR2nGu
BGAcsL8GaDLKzFS+icCuA+S7vVtDorX1VlzYD9hfi13F01u7v+ZGQdiav932qSKF1su34ua7
Z39Nlm/F2fuA/bXYVQJZDthfi1WfYk+3/sawvrZ8t7OAkGidfe62EyKQ6LLepeeUJN+KEy6F
1tnnruJKTKAb+9xryXd7j4tEa+dvIj5Wt/4uwxKldyvRMhQ61b5bHeea9Tc11pSoGQqtle/2
2oBEa8d5ZDBadvLtt+VbiYMg0Hr5btvnJFqodySjDUaLXr7b+R5ItHb+bp+2lNGXGvlu+bfE
ntVuNQotyrc4Ur32HheJruZvZf3tKQ5HFFpnn3uKtx+B1p1/A7rdYxRaN8553v69aF1/e4pn
O4XWzd+eYnkQaK18e4rlQaG19W7vM5Fobb3pgGNavv32+tvzDMa5Vr49ZQ6l0Dr59tp53Ui0
tt5KIA6F1s3fnjKX8FhfjXyP2/KtJDCg0Fr5bu8UkWitfCtxqBRaK9/tPQ8KrZfv9tk7idaO
89ig1bTy7bd3Dki0Tr799tqfQmvl22+vgUm0rt4+oc9VtLbeSpQrha7lu22f++3EZRRaK9++
EgVFoXXy7SsrSQqtrbeykqTQTX/L52O+olu0598Ymt+Sb1/RLd3n362SK4G4+vPvUJFvP2j3
WNf5t/LuoN1j+vPvMleAJ6ENWk1rnyuedyRa29/K2mDP+beMVvR55/m3gjZoNb18K2sD7fk3
iTao906+p235VrIZHHL+7bd3/km0UG9fRhvUWy/fykzUdf7dnr8VX6rKrZ6U73HSlm/FuqfQ
Gv/UOFBmIgqtO/9WfKlItO78W/GGotDa82/FG4pE68a5mvuIQtf9jSHmMtqgzRv5RriIVuZQ
Al2ff5f/SmiDNteefwftnWASrTv/DugsFYbn32pQM4HWynegBIxQaN35d6Ak+aHQOvkOFMuD
Qjfn367casr8rT0fwywbLfkOlPlbfz5GyDedSMNUvpW9va7zMUW+lb09/fkY0ebK3t6e87EW
2qDNd/LtYc0ltEGba/1bAmX2156PYUyd3xqpSkq6rvMxRb6ViHvt+Rgl38paUHs+RrW5Yjsc
cj4WKPuKe87HWq1m0OZ6+VZ2JbvOx9r+LSGRrEEr33H7fCxU9BqFburtSfIdKpqJQtfybbfk
OyQyQ5jb56Gyx0WgtfIdEtkbzOU7VHIVUWhdfysJUUm0bpyHyg4Zgdba5yGdq8bQPg+VVHgU
WltvZXeOQlf2uWO37PNQOV0j0Fr5DpXTNQqtrTeRRMdcvkPldI1Ca/u7HTdXZoqh5Ttt2+eh
MgNTaN36O6QT7JDyzVMSyfKtzEQUeldvR56/Q0WfE+hm/W3J6+9Q0akUWrf+DpX1GIXW9nc7
KodEa/ubyFWl218rO0ysd6SsiSi0rt5qDkkKrau3kqKcRFfyPU5b8h0R85j5/lpEzESd+2u+
jCazMRnKd0To8679NXn9HSnZSXmSI1q+E7cl3xGRREtFV/4tfA51RbRiI1Po2r8FT8BtCU2m
idKff8utpuwzEehGvqPWOFeSLVJo7ThX9nootLa/lbNYCq2tN6EdFHQzf2fTRGpzQjuoaN08
Fim7NRRaV28lMoZE1+ffbfmO6WRehvIdK7sWFFpX79gm06UZynesnORSaJ18x4SV62vl22vJ
d0xYuSpatM9lNJmjzPB8LCasXBWtG+cxoRUVdCnfdZo0Ca32mIrW9jdh5apobX8TVq6K1tab
sHIVtNY+jwkrV0Vr601YuSpaW2/CylXR9f551pZvwspV0Hr5bl+dQKK19SZsZBWtrXc7twSJ
pvvbtlz53XWKNVK+LTvApHASmsz0ZrS/hujQAF35cWHGOUG+EU3mrdPLty3VW96do9G1fypP
HuNJaMcATfc3osm0dkbyjWiDHtPIN6INekwj34g26DGNfCM6MkBr6x0a9Fgp39RIle01Gq2R
b0Qb9Lfm/BvRBj2mkW9E+wZoev62cV0rot0O+caUf5j7T0KTKQKN1t+Ijg3QkWDdS2jZf02D
1sm3J5+20Ohmf03yfUc0mf/PUL49+bxEg47qM6qWbmndEadB6+Tbcwx6TCvfnmPQY1r5bmV8
06B147zlO6dB83p7USs/E6LD/WitfLc87zRoev8c0QY9ppVvzzMYqVr5bnkkeR3yjakSMWei
iJb3PDRonXz78nmoBl3Fh2JCRknGfHnHRIPWyXcrBR6NrufvMpOjiHYM6l3Kd53EUUIb1Fs7
f/uOQb218t3ypaLRWvlu+VJp0Dr59l2Demvl25fjajToyj5Ps5Z8t7L10WitfLey9WnQ4n5L
KqEN6q2V71a+PQ1aI98uP/GQrqW/Gl722eV2PZ+lmPP9Zjiy2MPl6JZNt8sUk34X7GiRFM9I
aB9LVNCEN6vvvTJlPMBmk3nGtkWZMX6STZPtfMMzeRYvxSZbsGJbrLNlkwPUsT10FCqLczXo
s9lyk+X5dr1h2+UYb1TP5Ic98eEMk5KTD/I8m82DV4OHwe3lGXwbDd5bP4LgBD+6PL8/x98c
CRiJwF+HV/hEJj0Rt9pvAO1/MxxcnF4NrIc+u8CbNy5Hl/fAAPWZbWbJfPZPmfs+5fcxbyQ+
3Mnp4sNyfMUm3ayqbKpskyfLIqn6Bj4qW6IQWTESd7ZaLLbQtVU/TFaLZLbkqW377B4p5ngj
tA51e14j7m8uoCLfoBqTshrrFYyVlz6bJ/+8sMVqkrU5RoPRNXT2uOr2XSuob5vPxskmYd+y
vEBm99Sy2HyVTLLJafvRspEwkSjPzvt1dMHy7HEGb8hV3m0xTlc5VLR5hC2z7+UAmyZpxib5
DN6KD06VljNGP23HptjqlujmtW3g1eX5gN1Cb/+W5X1sidNG6h2XpxjOprNvSV702V3DXX3G
Vuss590j1MblHoSfs81NMs7mfXZdd8Rs+Sg9FYhP1f3+lBRPrIBeY++Z7UQSIJQA63y1WaWr
eQFPfv18c35xdXN1yQbXw9GXbx4bnN/gTyIe3b0F/HY5x59wkOfJdDpLWTKf82u0Gz0iwaG8
i3Sz7rNFskweswUqAhSu1RJ/4vKB6Y53BWPYJRIDVuDqXmrJ4YeH28H9sAFNk8Vs/iLAuJvb
cHCNEokpbPlFF6jfru/+xfLVdiO2qxeEGK3DHwd1/ZAm6VP2MJ8tswfeqEW2QZkOPKjkJitE
nBJf3FzIjuOqyPJvPC1v993s03nyyG989iyeEfxo8t46Yev31rH0LjLLIc+TTrxLd3V78y7H
sVLtu8ishvzuC+ldyqXuO360vGwdvXKPvben2cibq02aLWxl/JauJCDeRd1OYPgeMhFFZ52I
i2PN3tV2EBfua9W9i7i61fBd+ktDyfZT7w81ew8d2tndfuollobv0l9sqX2Xesel0bs8+vio
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
/ua38WfVfib80fFvQ3/fSvonOyEaj+wzLPOpqNr80LLebCIql29+C8vSiUNvTfuw+gEmDzXZ
7fpjMZ2ZYrTjvw57hzFM9v7T1wXV9WYQRzuYQfB9jJxm4qrAP9XtHXUp1FGzDvZHOGw9+OqJ
XqqTunjrbmC0iU0Q9XBuIi+uW1s/PT7cTBYfZnerrXR0EDJemM3w7asX1TUVo1FbTDJ9uyUI
PJuPl/PPi3S89ubNsU5T83zz9aNV+J4/ak6ST7PZ52fV5c1kNB/dVD/W/1RdUPKVum7WCI6Z
ehxyXEv7+djgRO2oq9lDPhQ8mFuNtXW2trpuT+uh4C+Yp//+7uqFYJE9Ml30+rUQzMUMx5o1
5FldEx/r9k6FSD9H1Wu/Xryl12w9d/3q5fsff/n94u3r129/jtPdZ+PZXXU7up/e/ZHJiuw7
iByzCV1RPVMTyacI/n1TptydB9/i6C2cZSxoru5Gf+wRM5nYL+LF86vjBG0meP3i9RFifk1n
XfaO8hTqKANn3ztKIKVv1+blEpyJUlvL5jDmoBpu/7VOErQ69Fn1dTQl5b4u64h4+qhZKHvv
UAAZmDLdfYccwFIPMB5gKgnOOXu6VRFgxMChCz0wcuCQoh4YNXC2XQ+MVognxY2GrMYC/M0A
49zTfaoA40tP9Awm7GPEaoQYONquB0YC/M0AowD+ZoDRA6fI9sDUad8nw1iAvxlg3FF54IMw
HuBvCi7ZwHFjPTAC4G8GGAnwNwOMAvibAUZDlKgcOvS/B8aWWic5jBs4orQHxlsEjGIQU4Cy
0E926QOMON4g7dpcbaHGaQZ3MEIwWn6OHYSX58HpquflbGVbI9LBtO0OS1kkkQECOUqb7rAA
RQpSmplMLUBVk5iUPHaWPi8/cA7ZbhjNBo4B74HhAyf19sBIVvpmZTA1Sd2TYep5h0+GMbLU
WMpgbPFJnsG44vxHBuMHjrneDWOYg8BEEvinw8hiezSDURzxpILlVmosZTBmIIdRD4wtLhLJ
YFxx/iOD8QOHz+6Gsay4SCSD4Q6hi63wEBhV7NRnMLrYqc9ghk4e7oGxxfZoBuOKk8gZjB9Y
Rb7bdHOs2KlPV+N4cRI5gxHFTn0Go4qTyBmMLnbqMxgD0cWDOV16YFxxEjmD8RBTwLNipz6D
4cVJ5AxGFDv1GcxxdZUHYXSxU5/BmGKnPoOxxU59BuMkQqV7rwAvA6WcAKsRjCMMWsEEwqAV
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

--44f9bf283bc9491f90324a86bfd35519--

