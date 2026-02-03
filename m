Return-Path: <dmaengine+bounces-8691-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K5BGcHtgWkFMAMAu9opvQ
	(envelope-from <dmaengine+bounces-8691-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:44:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFBED935D
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF4A30BF119
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA72342CBD;
	Tue,  3 Feb 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="WxlAR5ZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmUQLOk0"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A634026B;
	Tue,  3 Feb 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122448; cv=none; b=gc+3RSZzSm6eDAVFmcMiPAjuTEE/fp6JXBITpMiBNKZAag8Bx2gYsQy4xAAgVZpcLAAfUHKiu4q8IFiehRQyXjPqEbvIsRyV31igX11XuWb4x5G+ecHMzww+WpxZjHNj1et77M55gEVCEGC6QMaiU+kTFjluHBl8MOKtKc2PpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122448; c=relaxed/simple;
	bh=IcRZ8K8qTDuQvnjiw6ix/KwccwaclbSkSqoz0GM6q6c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VTa4MlMVK7EGgnwdGDin5CYi+XXvOyfg55xippCYrkGMRiqtgJ0UUg8PKC1eszS+aDpgiKw5rv6C+I5+NAYM0+YaS4GQbZ0U2jjIhFpWPQpnj87UankBidevmi9vtsme/38TAtlB8EhZqCO+7/lDqZx5ZlM/4Q6W+sneKk0d3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=WxlAR5ZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmUQLOk0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FD8114000F2;
	Tue,  3 Feb 2026 07:40:45 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Tue, 03 Feb 2026 07:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770122445; x=1770208845; bh=wxJyJB/zoH
	fCCaMuaiLo1LGi/tGPqPzqaRP/DfaQ3/0=; b=WxlAR5ZOSOZm2L1FXElFKhG9Y7
	BESrRLWunnIJFtvil77EYufanIjVqhK29e6N/uv/Ud4g/PjowAhrVgXVpvvbwobe
	Um7xmuqZq0ftyLfvXsytEWkrQ//72Xp2sQcfeV2xie7q1fWxS3VHeOENj/vt9Pbo
	cYC/qsteyAt5NBo2tlqtGAlv6AbFGzLDCOw5IrBbqT1cJEbBuoXqzvFcsKRUs0P4
	C/nuJ6oSFY3K/g6zFVZiLeOCxPh0SW/624elDUxtwMPw0FrPF3/33abHlNGv8D0z
	jyR/HGrfH5UsCvKOTEHSsOw3QYhFslJICx0zntSZ5ZW4sNfSWQg1e+y3GCJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770122445; x=1770208845; bh=wxJyJB/zoHfCCaMuaiLo1LGi/tGPqPzqaRP
	/DfaQ3/0=; b=KmUQLOk0qRAM/lH85z8ms4twkom4AMsgftBb+DVVY22euPb0oh5
	ig598t5III65niEXlKBY/nu4KfMEsbVlMSesq8D+k9vFb8SN8NhKWqrQWJQdZeAq
	QpfgzZ7xUcy4y4QnF8k5K/i6bjefGFveRdEWC7LUOdbdETqGms3SM2Ozc72E/tAp
	fTIzyG0Cd75YCXU7MrUENDBT5SyS2JAB72bk8OPOVRTsuL38WHHixNJfs0w+kVd3
	YzsVRSiNWfjtFNdBsGZtodUiVFj+jfIZObfpst0ZXAnC5dGdALNBM9A1hcMTMA/f
	WC8bPltdaRG9SHUOA611qG3WWeVH/rGKcBw==
X-ME-Sender: <xms:zOyBacfrvn9TYPI-W1BxFGWJ7-Dm2Azz3KDOYMlvbg3RBq7tZHba7w>
    <xme:zOyBaZABIrWhmfrBx_Wi-flvaf4lMINBLeSKc5zsvTONxUHUtDyHQF8vYrr1POyiN
    fSPTP41T2ev9vdVhbkn_JpkFoQst45nhRQEd1FehyiCdnRM-y_Ms38W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedttdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zOyBaWF9GK7hTseFf00YaFSYACDhcXYXAlDRchWak5qf7ZiEX_THMg>
    <xmx:zOyBaRboyyaK7H0qdYx9nmRa8jDeD-v-zYD3ag5e3ghgnYdPilnhBQ>
    <xmx:zOyBaQDxdzM3geHsgU68uFjsRLu_F0ozoXNIINJlVRdTSNGu1z14Kw>
    <xmx:zOyBaRmYAGes05QXDTv1Gko69HHc5btsw-ROPK1XAgsdBqpeROyJ_A>
    <xmx:zeyBaQ0yQlDO6ppPrewWKldHxEQNUbh0nwaCETrk_nYXGSiH4UPuC31T>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7A0FB6006E; Tue,  3 Feb 2026 07:40:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Tue, 03 Feb 2026 07:39:36 -0500
From: correctmost <cmlists@sent.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
In-Reply-To: <20260203100452.GE2275908@black.igk.intel.com>
References: <20260129065837.GT2275908@black.igk.intel.com>
 <513c490f-c433-4298-ae66-6e165aa7b299@app.fastmail.com>
 <20260129115609.GV2275908@black.igk.intel.com>
 <7d966d39-aa5a-4a0f-a115-a4b90632a26c@app.fastmail.com>
 <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
 <20260202075118.GY2275908@black.igk.intel.com>
 <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
 <20260202102225.GB2275908@black.igk.intel.com>
 <5ed857f5-59ae-4052-8f2e-dac7fcd014cc@app.fastmail.com>
 <20260203100452.GE2275908@black.igk.intel.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: multipart/mixed;
 boundary=39b2417ddb104623a1ee24cf13fff407
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8691-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[sent.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 8BFBED935D
X-Rspamd-Action: no action

--39b2417ddb104623a1ee24cf13fff407
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
> On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
>> > Could you drop the above hack again so that it should "fail". Then build
>> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
>> > this is just lucky timing? Please try a couple of boots and make sure the
>> > results are the same each time.
>> 
>> I cold booted five times and the touchpad did not work during any of those boots.
>
> Thanks!
>
>> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
>> 
>> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
>> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
>> ...
>> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
>> 
>
> This is really odd because "item fetching" is not really accessing any
> hardware bus - it just parses the descriptor and the descriptor looks fine
> to me (and this is the same as in case of working run):
>
> Usage Page (Generic Desktop)
> Usage (Generic Desktop.Mouse)
> Collection (1)
>   Report ID (1)
>   Usage (Generic Desktop.Pointer)
>   Collection (0)
>     Usage Page (Button)
>     Usage Minimum (1)
>     Usage Maximum (2)
>     Logical Minimum (0)
>     Logical Maximum (1)
>     Report Size (1)
>     Report Count (2)
>     Input (2)
>     Report Count (6)
>     Input (3)
>     Usage Page (Generic Desktop)
>     Usage (Generic Desktop.X)
>     Usage (Generic Desktop.Y)
>     Logical Minimum (129)
>     Logical Maximum (127)
>     Report Size (8)
>     Report Count (2)
>     Input (6)
>     Report Size (8)
>     Report Count (5)
>     Input (3)
>   End Collection (0)
>   Usage Page (Vendor Defined Page 1)
>   Usage (Vendor Defined Page 1.Vendor Usage 1)
>   Report ID (14)
>   Usage (Vendor Defined Page 1.00c5)
>
> I noticed  you still have:
>
> [    0.069726] Dynamic Preempt: full
>
> Can you change that in .config to:
>
> CONFIG_PREEMPT_VOLUNTARY=y

Strange, I did change that config.  Do I need to change another config for it to take effect?

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

>
> Also let's add on top of everything one more hack patch, just in case ;-)
>
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index ed90858a27b7..0297ebedb802 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -371,7 +371,7 @@ static const struct acpi_device_id 
> i2c_acpi_force_100khz_device_ids[] = {
>  	 * a 400KHz frequency. The root cause of the issue is not known.
>  	 */
>  	{ "DLL0945", 0 },
> -	{ "ELAN06FA", 0 },
> +//	{ "ELAN06FA", 0 },
>  	{}
>  };

The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).
--39b2417ddb104623a1ee24cf13fff407
Content-Disposition: attachment; filename="dmesg-dont-force-100khz.txt.zip"
Content-Type: application/zip; name="dmesg-dont-force-100khz.txt.zip"
Content-Transfer-Encoding: base64

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
UEsFBgAAAAABAAEAYQAAAFmBAAAAAA==

--39b2417ddb104623a1ee24cf13fff407--

