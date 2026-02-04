Return-Path: <dmaengine+bounces-8730-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDotCfRkg2nAmAMAu9opvQ
	(envelope-from <dmaengine+bounces-8730-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:25:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CDE883D
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B8B312AA2A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C642316D;
	Wed,  4 Feb 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="tAfnLoIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKhMoz9d"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7258423169;
	Wed,  4 Feb 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218035; cv=none; b=fKA2N8UYuoqQf7bg9Kbv4yMD2FqeQf9HF0XkN0SwOmcwpTFYO9FYrBO8KrajfSgTD9R+BRqgUceWgiWYFr/0xnHISpftI9/VcP+Y27CrNn5+KkOqtm0FRQ2PA2N3pqiQtbHJ23/Zw6ISxsMwG1ghstVUZZvKHrmfXATVaaf0whc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218035; c=relaxed/simple;
	bh=Yyjh4+l/IxH8P6nerHNdHuYjMdTVUIpGOygW8kjHscs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hwcu9GHLmPrBAMEJiPQzuHzg4SkK1L70lfrceDGZEbBTFfh1A+iSfFzkfVi4F01NoTHcGodqgT4bMjw0k09MPvwB5MoPHmXkqWMOtfPUzpFGaTX0sH6gkxuP4nU4YWR4ywhaDKyzf0urpHWbPcaI/ej2UBKpQ1/pt/YRNn3rqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=tAfnLoIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKhMoz9d; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C44F17A0125;
	Wed,  4 Feb 2026 10:13:53 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 10:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770218033; x=1770304433; bh=3w8vX+ZNbW
	xKduxnOofr9+42qwoIGqomIUCMzxaczAg=; b=tAfnLoIAWu9OKh37N96G7Jvcyd
	f+w3V1t/HbcmdhY0l1upqEz58KrsuTtAWHUCJlEaEUPfJqY9Bumwjjf1gy+yGItS
	egvXewgJpDxRcYq4/TcQLb62dSN58OAw4zKee3+tASq6UuTD7+A+sg9GN5vINv7e
	FPPSw+263ONAJH8eDXQ7bKeB0ALywZBKFGB+pfxSJ+n4aeDlpPwk5b0lKqXKe+sm
	Z//ACsXAzXqo1lo1Xr0qMxXdhhyy66Fz4Ee8O0KnSX3BQOTj3pCRelb1x69WfeXF
	WQueSua7lxvsK7RBuE8bJbTkcjxSXe0gu7wu3w/oeR8PvFcsaGvRAj+5/X7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770218033; x=1770304433; bh=3w8vX+ZNbWxKduxnOofr9+42qwoIGqomIUC
	MzxaczAg=; b=SKhMoz9diW3NXTF+U1Exc1KnBrzZQlQdfijbctArCU42uVLcIbL
	gSJsKWoQbF/XBwXaMpQNAaXMYZfh3Ccti234w3KouulK2eIGi6v2QeDb//5iHFgX
	RqdjBP1Nnq8RfhroZ9Llg7ERhpC47kb3VMqsuGnHxdoX3NrkDMvERoOyyz+AzSZd
	8J2dYIPH0XByGtjF3m7rK2f6hfrNltmR0mfgYfSquhWiE+zmr6rsKYu0YB+P3Hqv
	vSUAHwrQbrnlS6Mrv7BKUgBwAHzeqIH9bzmlmSXPO9R1K7MdGb+drL++s78+J05y
	aJysuGtoqV/nQi9RNnBhYucriaKCCq4xGgA==
X-ME-Sender: <xms:MWKDaVvxKP0ziBSfmLYZuUa3EcKRlsOKzz3-_NJ17sb5zeudURDOFA>
    <xme:MWKDaZRZudj7Q_hOa3L6sEMUZMV8OoDwLzQygt3GGXIqcznbd-mrzFpoi1oAtkHyo
    lZH-fZjX2YN_34XNNIVwo9N068g4wHrwvHVWxbBBSnNYZdxnN8Z8WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MWKDafXp3-IUYCruVkj4njXEuhFxn6Qp-CCyYPw9GBlPFoBrT688Hw>
    <xmx:MWKDaRobsjsu6QGtYcDgsxVwBNm108HESPe_1eJ-yoAjCOd2uk2IoQ>
    <xmx:MWKDabRBAWswIahk_ATV70WIzWfvPd-tkR-L6x9ICJLTG8QMASN54A>
    <xmx:MWKDab2s6ehdPBaDqFFJMQ8gFTO3bSKPyyUE2nv386hvaCEPXeEsuA>
    <xmx:MWKDadFn5nSRjpzBqeMiYAdsYsxNYNORLv7u8uU0NUiLEHU-qd7eIXsV>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 309A6B6006E; Wed,  4 Feb 2026 10:13:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Wed, 04 Feb 2026 10:12:57 -0500
From: correctmost <cmlists@sent.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <72c71247-8b54-4820-b25d-34f659e7f957@app.fastmail.com>
In-Reply-To: <e7a0d992-ed5c-4435-b567-e0b873360a48@app.fastmail.com>
References: <20260130072620.GW2275908@black.igk.intel.com>
 <53bd143f-525d-4748-af93-3460c9f59d1a@app.fastmail.com>
 <20260202075118.GY2275908@black.igk.intel.com>
 <00ee321d-1f36-4f1e-91f7-fdee4212c5cc@app.fastmail.com>
 <20260202102225.GB2275908@black.igk.intel.com>
 <5ed857f5-59ae-4052-8f2e-dac7fcd014cc@app.fastmail.com>
 <20260203100452.GE2275908@black.igk.intel.com>
 <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
 <20260204123107.GN2275908@black.igk.intel.com>
 <5ed53c66-69e9-45e1-9b89-e3d555ff412c@app.fastmail.com>
 <aYNHeqYYa9ixrksM@smile.fi.intel.com>
 <e7a0d992-ed5c-4435-b567-e0b873360a48@app.fastmail.com>
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: multipart/mixed;
 boundary=824c073b30d14b85b56a14ca93aa4655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8730-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[sent.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 046CDE883D
X-Rspamd-Action: no action

--824c073b30d14b85b56a14ca93aa4655
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 9:01 AM, correctmost wrote:
> On Wed, Feb 4, 2026, at 8:19 AM, Andy Shevchenko wrote:
>> On Wed, Feb 04, 2026 at 08:11:27AM -0500, correctmost wrote:
>>> On Wed, Feb 4, 2026, at 7:31 AM, Mika Westerberg wrote:
>>> > On Tue, Feb 03, 2026 at 07:39:36AM -0500, correctmost wrote:
>>> >> On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
>>> >> > On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
>>> >> >> > Could you drop the above hack again so that it should "fail". Then build
>>> >> >> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
>>> >> >> > this is just lucky timing? Please try a couple of boots and make sure the
>>> >> >> > results are the same each time.
>>> >> >> 
>>> >> >> I cold booted five times and the touchpad did not work during any of those boots.
>>> >> >
>>> >> > Thanks!
>>> >> >
>>> >> >> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
>>> >> >> 
>>> >> >> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
>>> >> >> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
>>> >> >> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
>>> >> >> ...
>>> >> >> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
>>> >> >> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
>>> >> >> 
>>> >> >
>>> >> > This is really odd because "item fetching" is not really accessing any
>>> >> > hardware bus - it just parses the descriptor and the descriptor looks fine
>>> >> > to me (and this is the same as in case of working run):
>>> >> >
>>> >> > Usage Page (Generic Desktop)
>>> >> > Usage (Generic Desktop.Mouse)
>>> >> > Collection (1)
>>> >> >   Report ID (1)
>>> >> >   Usage (Generic Desktop.Pointer)
>>> >> >   Collection (0)
>>> >> >     Usage Page (Button)
>>> >> >     Usage Minimum (1)
>>> >> >     Usage Maximum (2)
>>> >> >     Logical Minimum (0)
>>> >> >     Logical Maximum (1)
>>> >> >     Report Size (1)
>>> >> >     Report Count (2)
>>> >> >     Input (2)
>>> >> >     Report Count (6)
>>> >> >     Input (3)
>>> >> >     Usage Page (Generic Desktop)
>>> >> >     Usage (Generic Desktop.X)
>>> >> >     Usage (Generic Desktop.Y)
>>> >> >     Logical Minimum (129)
>>> >> >     Logical Maximum (127)
>>> >> >     Report Size (8)
>>> >> >     Report Count (2)
>>> >> >     Input (6)
>>> >> >     Report Size (8)
>>> >> >     Report Count (5)
>>> >> >     Input (3)
>>> >> >   End Collection (0)
>>> >> >   Usage Page (Vendor Defined Page 1)
>>> >> >   Usage (Vendor Defined Page 1.Vendor Usage 1)
>>> >> >   Report ID (14)
>>> >> >   Usage (Vendor Defined Page 1.00c5)
>>> >> >
>>> >> > I noticed  you still have:
>>> >> >
>>> >> > [    0.069726] Dynamic Preempt: full
>>> >> >
>>> >> > Can you change that in .config to:
>>> >> >
>>> >> > CONFIG_PREEMPT_VOLUNTARY=y
>>> >> 
>>> >> Strange, I did change that config.  Do I need to change another config for it to take effect?
>>> >
>>> > Probably not.
>>> >
>>> >> CONFIG_PREEMPT_BUILD=y
>>> >> # CONFIG_PREEMPT_NONE is not set
>>> >> CONFIG_PREEMPT_VOLUNTARY=y
>>> >> CONFIG_PREEMPT=y
>>> >> # CONFIG_PREEMPT_LAZY is not set
>>> >> CONFIG_PREEMPT_COUNT=y
>>> >> CONFIG_PREEMPTION=y
>>> >> CONFIG_PREEMPT_DYNAMIC=y
>>> >> CONFIG_PREEMPT_RCU=y
>>> >> CONFIG_PREEMPT_NOTIFIERS=y
>>> >> # CONFIG_PREEMPT_TRACER is not set
>>> >> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>>> >> 
>>> >> >
>>> >> > Also let's add on top of everything one more hack patch, just in case ;-)
>>> >> >
>>> >> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>>> >> > index ed90858a27b7..0297ebedb802 100644
>>> >> > --- a/drivers/i2c/i2c-core-acpi.c
>>> >> > +++ b/drivers/i2c/i2c-core-acpi.c
>>> >> > @@ -371,7 +371,7 @@ static const struct acpi_device_id 
>>> >> > i2c_acpi_force_100khz_device_ids[] = {
>>> >> >  	 * a 400KHz frequency. The root cause of the issue is not known.
>>> >> >  	 */
>>> >> >  	{ "DLL0945", 0 },
>>> >> > -	{ "ELAN06FA", 0 },
>>> >> > +//	{ "ELAN06FA", 0 },
>>> >> >  	{}
>>> >> >  };
>>> >> 
>>> >> The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).
>>> >
>>> > Thanks again! It still fails in completely unexpected place I wonder if the
>>> > BPF quirsk somehow could affect it?
>>> >
>>> > Could you still try with CONFIG_HID_BPF=n and see if there is any change?
>>> 
>>> I applied that config change and saw the same touchpad failure (full log attached).
>>
>> Just to confirm, after you applied the change, compiled a kernel, the change is
>> visible in .config in the kernel output folder (by default it's the same where
>> kernel sources are located for compilation), correct?
>
> Sorry, the CONFIG_HID_BPF=n and CONFIG_PREEMPT_VOLUNTARY=y changes are 
> not visible in /proc/config.gz.  The CONFIG_PCI_DEBUG=y and 
> CONFIG_LOG_BUF_SHIFT=24 changes are visible, though, which is why I 
> thought my process for applying config changes was working okay.
>
> I will try to debug the config issue and retest the touchpad with the 
> proper config changes.

After fixing the config issue, I now see "Dynamic Preempt: voluntary" in the dmesg output.  I also see "# CONFIG_HID_BPF is not set" in /proc/config.gz.

The "probe with driver hid-generic failed with error -22" message is still present and the touchpad doesn't work (full log attached).
--824c073b30d14b85b56a14ca93aa4655
Content-Disposition: attachment; filename="dmesg-config-redos.txt.zip"
Content-Type: application/zip; name="dmesg-config-redos.txt.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAEVPRFwHrbxWL4sAAJHqAgAWABwAZG1lc2ctY29uZmlnLXJlZG9zLnR4dFVU
CQADgl6DaaVeg2l1eAsAAQToAwAABOgDAADUXFtz4kqSfj77KzJiXuw9xq0q3dnwxtpg9yGO
sRmDu2e2t4MQUgl0WiBGEm77/PrJLAndwMLGMw9LdDdCqvwyqyqvpar+BvhRzhX5+Q63wWrz
DE8iToJoBcY5s8+VTuwaHdaZB2lHUbiiduaGzh3VVNSZqtpwEhINPf4fJ3YX8tcpnMxdF04+
93qnwPRzfs6AK9xQmKKewee7Rwg9fIrfV9g8DcLkFPi5pp+zU/gLg/FwBKOH6+vhaDLt//3u
cjjowVfhnYGiwY2YSShgWlflXd2GX0n0//hW70gvWi6dlQcojuhCsArS2Lv4P/ntLP2kUwh9
HiznEHvn4eZHch6tU+x3crF2kuRnFHsd4S6ii1UE8U+Ioyj1k/RlLS7Ec6pBwN3OIvDOvZeV
N5tf/LqGWCSbpbh4fBz0LxzP5NhbpaNoKutoQjE7My5sHEHf07WZ5c/cWU4wjXw/EekFUw1m
852ePFvGp2QdBimEkfsDPJEKl6Tswl8ue11wYydZBKs5pAsBP0S8EiHg1OVXknBKhAnQcPx0
4hU1xhabRMSdZO24otqqyf1qcD/urOPoKfCEB+vFSxK4TggPl0NYOuvu3ubC4koXvi3FEpRn
pfHp1G7Zwvf97yiLMwvFu8BsfwfM9yUYjqqIn4T3HjjWlE2dcW4dJRtR2k2wWQ72ftmItgnn
2epx40aUjXFTfdsTx8qGtA04jdtWBnfZGw3g7sv47XBEuwPn+BU4z0md9+A5/h48/6ih0/is
qSOa4R+tcprp7sCZH4CzRBNOx+k5Fs7Nvytwrn+8dL7weAMOb5lHw/k70vnHS8e2GCWc5viz
VjW5+xucXD8Ld5MK6AeyySmglyxcs4PfTztkl6MBeuxx6qSBC+hGw0RGpsAJgz93JRZ+0IXr
mwE88XMLZi8wuBv/vX+NoS1en+9tTDZyoTxLo8G7mc3wc6W4xzSYjIY3wcoJb6O5vG0rBjUd
D2mA8I7q+R75GxheDy8nkwe6ZcwUgbYJ1+OHSfabMYVZ8HD3OYNm3Mefg7vB5KGfE6guEiCz
6yexSrfMHMUhuqbwMYamaEmxDEMTjQh40Wpn9GQXH8QyehKAM2jrXRgOB/dEPRcX35TnitaW
2nrCdWN4dQp+HC2B5p/i1g601Is4w87VYy/aa9rVlM1sylbR2VJXT9hxou0Fe020bGZBPddQ
Q7HNKt1Rnv5w0IXb67v7L/dgqTdfP93efbm7YgbjzDiTlgOjm94d075+BcX+xBX8w7W9KEMU
NH6BJIzSBNbRehM6qfC6wD/xZvs0cbvQl+kMphZcV+QjGP72J5mSK5Ikig/QaLZR0EzGvVpr
czt2mzWGDdF0Iltrr1g5XFz89/5htPfPAz5xSqxXPQbj3yF0knS69ldwgXToX1C7cLafp5Qy
l/e3wtWo9e8wnDw8yHwLdMAJjAORwIkKfvCMo/ArcHhy4oDY/heBAldPz2C2CcI00y2mFA0k
VC3LY0aWY44uJ130LSs/mG9ih9wYfFM65vcufL0C+NoDeOx18C9kv0fZ768TqJqzqpnNvlLc
fFNXNU2nOUvilEyJZoEyVfI5kKWpsi+V7GPrhtKoeZdpynkV2OD7lSGDkBMoLw8rg6aZ6nd4
TEi0z1ewduY4FX4UgxfEqJQ0SWt8ViHQLdSeMcaKWMAMawhsKRlUQXUbdRtz6v5g/HsRn1RF
92a5cMzzbBKuQmPQUJOHxyDhxOELpFJsdyEwjd8sqYgLfEzW5Uzu4Wnoypb+Ydwf1VKdy5tr
ihX0g2tw8qTw3D2c1gDULcDfxv1JHYDfMMsCqfw9AmBb/9K76uAPwsg+8hp/yTDM1DoDY8vg
Br/qDPoqGT7RKJKB/joDGQaJin7WGdhbBv2dHqgZA7unm3p1CN7FwGCVHoxrDKxrlvcA6Wo0
fEvzSNG/nh9fb3vdu8mGNU8KLvu3nVFn+DahtC2D8U6vb6yMgcav2YFeD+4mt1SKo6tlZp2B
3sLAzHugWr3jGRgtDIxCMYzjGVgtDJSMgd5XteMZ2K8zuO5nDHiPW0czMJUWBnbGQFWv7eMZ
8NcZ9K8yBn1LzecAca5vASZukowTL5UMpP63MFBbGFzmk2xrN8f3oMUO+vbWOFX1eAYtatrP
7YCx66vjGZgtDLZ2YJofYFDYAabyvMFA3w6RJi1ZO8ZBWoWaDsf9YYOBtmWgSw+sHsWg8MC/
ja6bQ8SLSbYOBKkWBoWaUnnXYLB18azfO74HhZoOezefGwyUogeHwmwLgxZ3reY9YH3l+oAW
vR7HrUJNb0eDJoOiB70P9KBQ06/jYdNd97cM+AcmucVd821MRqdxtKHZrIVBbgc2vzk+4NiF
u+5ffW7kUnybSylZRDtqiGytwqDhKnhhaLpkoBzFoFDT/vDyocGgyKWs4yfZbnHX7Ca3A0U5
3pvaLVkFy0Omavcvj2fQoqbM/DgDU2nJKtg24Cg3R6ctplKo6c1oh0EZcI5WU1Mp3PXot8sm
g60dmDdHa5GpFHZw9fmhyaCIaMcHHFMp7KCskmV9lBWAy2wFxkm3daTGHY861skvmTL7XsMz
dvFkOfQ6nlriub6OeVQNz9wr3/h1PEuwLR5dqv5BPFkZvYpny9XwTn7JXHEQb9zeX98q+uu7
XCh1POv9eGaJZ6rW7MN4RolnMFSQj+IpJZ7uqWodz343nvAKPIEDaH4Yzy7xXFVYH8XbrrMQ
nmWp9fFjyvvxnNLeHFsTH8Yr+4uXKv8wXql/nsWEU8dj78cr9c/DouQwnqwmWvD0Ek9XtNlB
PFk8tOBpJZ6GOUgdj+/iyVqhBY+XeFxRzYN4sjRowWMlHmPe7CCerARa8Er79egVch1Pfff8
qqV8KvcU7yCezPNb8Er58NI9LJ9M61v8Velf8LLhX5j27v7yIn7gJZrIh/FK/eMe99WDeDJH
b8Er4y9eNvwz25MfyJS8Ba/UZ7zU34BHGXgLXqkveGmZB/EOjB/zSzy8aviXPfnLIbzS3zNh
e/aH8Up/ypx/BV7pT/HSb4zfvvxq1I5X+lO81NSDeDI3bsEr9Y+p5hvkk6lwC15pH3hZ96c2
R/93F8Hd4/AS3Nr7KT/arLxaU3QdN84P4ujAKvJEhY3S+Ox73V/Dwm7c3fevp/3LyeWJcgpO
GEYuvc0sBEc6T+eWlHwPhhxp+N9oJbL3wEm39gzNHsiQQH72SMlqUirbXQ51DkaOovJ9KKzZ
13KnxC7KXRQvnXAHpXWDRA3FlLKIp8AVeCGW6/Sl9hwT0WH0JLXgTxqVJHXiVL49E467kBPW
bJ+92sp1Rs5oNpS1djbxlQ/x1t6dZztDme88q8LQ+7BWmNc3ib0Dpm0/1ztg2vY21WBYG8yb
p1ZHGxysgpSoE5Fu1hmkcnisX8HDGHC/ykHOMm1AJe4Cy1+pBivYrJwnJwiluuxOusleQbDN
t0EYzNoPofIuYFTV3gjDaX32NRjF5tabcLhqaHvGJDNJBGKmobwVSN/Try0Qoxe6b8Shxf/S
hQ9WqQhhHjvrReAme9y4a21Vqdh6VqLptl6kOaNhZxIsRQyDexhF9LpfeWaWYlVbG0USeEu5
8/RuOIATx10H08D7hsqFXVwE8wUIby5ok2+KN9n30xqE1g7B3wCht0OoH4fQPg6hvwHCaIcw
Pg5hfhzCegOE2Q5hfxzC+TjE7A0QVjuE+3EI7+MQ4g0QdjuE/2EIWuD4KMQb/EX5xnw/xBv8
xSGIN/iLQxBv8BeHIN7gL0zWDvEGf3EI4g3+4gCEclAvsIxCSQf3RP1N+d4FZx24SAz8rDjk
ouK143mxSBLaWimyfZ9n8Hk8AKXDmF2DK+xlcDeZjh960/svD3Ay2yAt4L/TIP4HXs3DaOaE
8gcHzw/pb02scs2uBceu4thZV0PxJBpQ5XYhuStNvjg4GV72J6cytR4PR42yKVj5lA3QdQ2o
CLly9SvwKC5jWDaw5mYwcxLRlQMkF5eUKiVnr22v07Yrv5iVyDywfXsdYeEIT8Y98ITj0eEd
SGWqUOQp1bYqHfQZPUIaraMuDJ3ncwijuTygsnbcH5TldLExeyONF2TtYYeG7dBQW1ijYDmj
XT58hyZdxNipjMyNYknDazRqleZuszyX7XYYYRZ3gKzKqiRkdW5alewSq9ufpD+Mb/cJ01OE
CKVSLqIUr+byXhWFytjRsIvaORPxysm2vz+IeZCkIsZaeRUlztO26t8pY6q7cGuo+pGolWNB
zRTUkGXu+1H3aXEN1TwOdXfraQ3VOgq1PHxUHDr6F6CWx4aKAzk1VPsY1MqJmt1FCUSlCjhv
qmevQWVT4bFso3VZupCbG/UG6DNo6aGmnlQLXUVRSpq9dmLnKYjTTXbeonJabubEAhZO7P3E
ixo5mpYrD8ZFm9gVtAHcR6fkdf4IfF+6i6WT/JB+Mf/Irc7uixvSw/L2mbwfeKGYrvABs5mC
OYutKarNNGbDqpRaVZiO0yTL7CkasLveoFU/TNHyxl2L2RxW8RRvEufpLEiTLtveQgbbX1T9
ZT8rwDptcdhCXi9nwqNTfYaaVYSf8DYknDNmaRBLTh63DJPDhhucaVoFyaAKbI0EHbks1m2l
y5bOLth/Yj1sMp3XcNQ6DoZpoHfkDBQOikpHPhUdFAMUM3tmgWLTjnbGoNMp/1QxKT35PZtc
9///OVDsEGV06xgTHFQ1jFaYIfg+enY6Dge/ol3hF12jXhmmaXJm4F3dQs5cN+ACTF2zTQ3n
Y/aSVsxDZRZlYX06UfACruMuyAiSRb5Qmx80kKsYNGtwgiMhYmSCGVPBSEKeyfF14jIxUbmm
6rRmhGrYeR2aoUfSTaOEZmdgqZZlKNbryDrF4yTyU7JWWkSY3F5haocRD1abJYpW7v3XmNzK
e4PKNcMwCJKN9Bd3cnUETRSqjWnP6ZU8OMHkukmILgxlWEazIAzSF5jH0WadHaA9B5hEqUw1
ZJ6hMaZrnDfRRlEYuC8SrJuvwlSaWORgyMc5mzTqkFp2aVXU/dFFiU/+FHF0egYL4awzE+pG
q/ynHwvRRYUpsAyV0W7Q8e0jjsVvX9HFzVcXhnYG99TlC6WjnsEwWN3P/hBumlxggkuR/ILm
koYCr0ooGz3Sd/DRRMjl5eve1GvdVA2jOIESrIBzI+t/lZgrO8R0WGfbFH4G6QK0bCxLQhPd
Hmnjy8pZBi6MsIPLNQ7HUxRuVqkTv1Raclq8iV10YnmzgLRqEYiYDplkJ5R7jxAs16FYorgy
JJ3XANQc4BdqiAaIXXJlH2XSI4+a5D73Qnq0NKr4WBy2FjS01CgmbZlFUUKY3fIWwyAVOi+g
06GYpA6CmdQvE3RL60gmvvLIDmZhkQ8TdPWJ7JJYyXMcdUI0tF8eNt57SZCXSz1+F5XsJjXA
QXaz010IEG4EkSdo594mFHFHrMh0aOzzDgcJGrsCedyswxo57KX3x0YOGMxFhF4NvRKZKj6b
+s4q2qTTUDj+BR1Kq81FFYwKZBJP9qQLY5FKwGQR+ClNogZZOFjSDyaxUwqk7mzqSPYX1Zv7
p5sq6IIH0Mj/uxgZVUaTzKT+DZxUlaYW9X3w8NdxF3Su6ZomBxlLT4oA6P7PqCwozTl7wIwK
iG5v9SMhdpk3K6SlW2hlGzeFBNOvRFaUHmVfWJ2mqCh1E1Utyip/+GLl5oE7PyYLHSwhCXEb
lmSckIrCdR2izMHRwrTyfDLFzzqNUUHp6rSze6vKkRa8exj3oxBZulGIOR94m+XyJc8swVKe
uV6lsKqBWcwd9PRuBgDf0vSFzm+u6gevTNUuFxF6WN2h83kK5EoEhWvFUsyyrcboCNRiLdK8
KPdeEn+zkoeM0cehAx71mHIONxEmp8Uhr8ooalwuVWbnjtHvugvSkeRlSdaFXnbw6R6DG3oO
mW3W6Ozv8i0/MkYnVqyQ/Aw8dN6qvb9p/+G3frFSkFV4mK9TQaKAHzpzmRIrVVoKkRmtt3Ri
ecJyPiWEKXGEgvoJw7bWVdDrrIHJJRpXUwwq6TgIusltB5nRqyVRw9cOyMZqsrEarV2Vje2T
jW1l03PZaGeQ1RCNpPKcKjK9ecqQH4YPDw2ptPzkMaqOV97dvlOpweSD1xkgUrbKBbS4BZsV
pTlFjyFbt8mkHdwPh49Q66ilVXDyxR9MjJooJcirxH/diA05hxWaV+Bly00/gzCEmdhaglTA
zXodxSk8c1qQk+5rgElFJxb5+cmKCuuWxSscrnMU9FRQNCdLyLGW1ZfIRIxjlD/aMUXdpkyy
ah0ILEcRUxPptdIIHUG4oTo2RymoLYVrzeowTdyOoDfWu3XhK/UhV30HE2nX50ajRNQ0xbR1
NC5L1avlIfFFxezhAM/iLC3LImwYRWs4SX4E67XwMG3MonIlTGduM1tPw/zxHxv0rS/n56DZ
Nj9HzbiK5tFwMBrDSbj+44IOVyvVrcfI2DblkhGa6WQh5GaBZYSeGVMbBN7O78lkyOpUVnbC
WFadjwlyH5LLGayycEA6gmncUxYC4OQRZTjN/gcFEruCpFGm0CM3mJ8AR61f5Qdvr2Jnhd6N
YuSPijRN6lsHnZlcRIUAy4ayEtF+v6KXpXwovzT6qtGaNVrvEC1WSJ+bEPb37cH2bj4Xy59O
kJLy0qxvF+2qNLROvMTQN5emlJTq76RUJaDrcXH0JZ6Ip9mCxln2g/45g/kGU9vpAl349lr+
ewa0oa6GTBVIjTUq93gtpPIETwLGKQWrqxeqibtYSmxJu6+2KgISPAUOdt1NwxoDLWOQIsEX
DnXM69UC5xNJP8ElCraU/2XG4OphXEOgPCxfZoKbAIewTxXxGFPoUKbdVcQe5o5xvXkT68tw
3LscXdfpBlejK3RfPvVLPAcy46KxlWfSawhGpT+s0R+icKP1y6fkp7OeU/ITo+7E2f/KNJWT
BesIEwn8/idxz7bbOLLj8/6FcOZhEpw4o7ro5sE85OKeNDpJG3Gmp8/2NgzFlhPvOLaPHXeS
xX78klWSVTc5cmTvBAg6dhcpFotkkSyKtUzR2/kfPUGPD4gMhhUfflBgUxeYc9rKkEeYfHsC
tfBSD8UM+HJ2cnmJrtaXq87Xj7ca0thA+qitAqwfCio4NcNx7nWYKge6OxxLNT6Vs1Lx07y9
wAiVvyftPmL82jv50oE9NH3CF+Nxl4MN9ueXOILNeCbNmuAHbrpixZY/a2ijumgpoO31Oo3x
cMBz8uVrFZ64Hh5wDwBPd90qxvuUvS6lUWyGOBaIwXt9WswmLeDh80asST2suNmbaPPM2hqx
d/DpyxUI1+T1sPoZL0sIwosU1zf6ve15QQRbXv69iAjk1zQIVSzMr8SS4PAYz+80LOJr+A8N
C6nEQohAw30DjfxejXDewCOojwNzUvJ7T+mXgniogqew6RKs4D6eRpLUj45kfPQiwyaMoyHq
KJJjchv5eTB7BGsEG+LPnjzaK/2nmFA8oPiwyDJReHrV9dLJk0zT/8iW66R8EH4yYebjYR9c
EnB/s1G6mkAMwmgUxmAhpuPH1SN89IkJMwF7hh4RbPRzYdsWq+lUc+jygf9KH9M22FUgXeyE
4+lwtJpYwy57V2tvURQKnnY/mN2V8qFXs9X0aUOuURJfZBphmfLkdEWeUcUqLNHOUS8f59gQ
pJ27VKLA6uDmUESF4EQdeoFHqP+HdzBKH8foU/ov6CSC7zTBv+/SIw8UUDjA+JlZD+hmCyEO
sJF6og/Tsp1r+AmmydAErRZg0S9Pb468bue0540en/g/W+jtI81Hnncyfb0VbgkIAcT/IvY/
8k4mMNFJ+lfmXbzeLSBYEN4bzJTR1jDL5hIjrOekJQPGAXIRbMVRXkbWhRBkuIBFXFgrLk9G
MU2Bfykj25459Bic1/wYvzi3VX8C1/g72MEFTTYEj10A99k0w1C5mIICt3E8PEh07FF+fO1H
ieUUcNHTpzVfLeYzCLm0h/K3x2sP9Y3nOdknggQZrBg/vl9WC2uRpwKO3YbmMN3Z0AkevQGe
1zeA8zExacgLSUdVvFqO76dY0IgUwN+jRfqYCQsJ2hgyag7vLCHuEVGQKILAZGUKopPeZwLD
OhzCPmsi2C2/OcCIaSkqJw/xMMQWE5HzulCzz71N6WcV6j+ukIMP+MTprJWnSiEwQp1dorHn
vm9ByurJx/H9IvfT6Dr3/SoDlOWvXuwBLZPhIpuKKgCRbf8VRg4Ws+VS1IaKkSZurLF5TiEU
Hs7u11vTMZoSsCMwl4nMcK2QJVhY+vDcQhXNBVUjFU9ewMa1wVEEE4VWfjX3lhn6kuniVSba
QQoUEIbnDmuzCBtke314a5WxtFU4PHI4RomSlc4/5ccba3n6icIvh98AfkP4jeA3ht/E+4n4
8FtuZH7EI80MpRB+uM1QPrS2GVLG1zNDCsAGMxRuGv+mGWIjF/gGM8TeHr/JDEVO9r3DDCng
7zFDKq82miGBweJVHDAq3nf4icBvyZM4FMfPudzPVvcPTyj2REjmEVbXaBU05XAp8/JIEayT
KMPJu+Aty2yIdxAkic/VdI2y7UcMw62r3KUjQUI5/Hz6hYQcHhPHn5SiiQOK6YVPRRXEQJAX
JHEQffIWz3icjKe8AQWgxUx+5ID/k8jFH+GRAIEPd0vY0wPCfXjMup7ryAO8g8e0VXyhkhgh
24bZj6fH+WjZdjbAzAehg/z4uO4peCf6H0sTT2h8dVqOjwMSl9XlZe3Juh7u+ktPBCzY1C6v
aSl715Y9aw/wPSmWhPnh86H5BC3Z17wEhIj6qZBGorGBmuOTjwNdGr+IfN3S6XaKg8nC6wxg
uRjxi1N+h9cpkY5WEEw40XE/CUEsFNcVUwZEvnmF4gtIn4R8YlnBp/Hp+hnH6kM4ldVAN7dn
ItnYxlbdQdBmyRFWKWRt0b+75dOWr3g0CcPmFdedW61yqPuhD19dfrz+9Av8efP5j9uO6LM6
G8wmnnSLFRQhDb7Ll0C0oyrcspFc7/cP3f6nzs115xJYiwggoEDrjino/JB7pq5CEkWkJsL/
xT/xZa56iBPOtkTMaG3UoDrpaoiHb2vlQkWYZk+wXKBBq7vlK0TtRXbuUAXGeqkcWJS4iMYt
4osDEokTSVgosD5JmxyKUoWn7Df1cE4M7efJ1998NAlKZUH+gCeZPO4DGdpq59979zPYTqcw
0Z9H6XjRXz6ki+zn9yO5S6d4bjO9b4ADA63+83jZhA6RlhVpwwZI5rNnwJIv/WxhYQKPBU1M
kWFeA07S4VDNzG0eDV7ryhKLwXw8f5jLNsPexezJ62JBKBbe5fmhCR4XCSep9If848BEBBAg
94Nx//FxMLrviwMTcVp8cCi+BgW/E6dNTsDO2cnVxh69B/lhVfGfsgx6OHtMx1Oxn3vfRJ21
31ILDtVH9PsldYIuQaKlJ2KsLLrWC6xRc8Bu4mMFLekA9/E1eALmDwzVX2KesN7yD++/V4/z
FlaePea5X3T/izIMrM8tILDUycsH4mHbCDeKJZbAlHY4SRiWBV+s7jNRHbUoZYqg8/D7WDYv
FfupONpvlWbIN2p6EBlXkJGQxb6wUz9gHcDT8wbpFI/4sCppKE2U/hgNVeCmS5xBXW1LV6gg
o/FbRGnPKPBAnMmxg9giHQ8h4shP0Lz5vwF6Onh4TBd/iVTWMpvIvsPpjxf6wlVwbN+Vg0tN
EkMoTG+AKvUKtvoeC4AeHhWoIFg7LSeiELP/uffx4GqGFTT5a7SH2vDEMbxbOIkuiNDfCHFy
fw/8RzNiASdRUrRikg2gO4sFDDu4W92D3f8ATiQmiAeweYnobArR9zCvvfC+/Ve/d3rcPYPI
9fbrxdnxzcUfp8e9nk+O+390z74feSed/snlTefk/F/9ztePvdseOqOy9uGX4fJ5MkuHtAWu
rEYOnkeN7gZoU27lK97I2aLcQh1J8/flJM1t+3FH3vlqUZCN56Z/rea/gIilWFtZkjJfygm1
KPU1UmjZZgtlJa8tXooSqJOrS9BN9KbRcX16mIHLLk43uIaCkd0zt3t5/l7msn2zjMWNWcZ3
zTLaSB75vllW9nd+P8uS3bOsgZQFdM8sC4LGLCts8s5YxhpJWdFAem8sK1+0fjfLiveTd8my
BlJWvNO6N5aVryW+m2VF6+GdsYw3krKij/DeWFa2+X03y+Jdm3/eSMrifZv/uOmOGftFJ54m
LAOOfZQsu2jmwcXiNdE9sgwe0NSWAYod2DKTZe+Wsli8DbtXlrGmtiz2iyBjZyxr4pcBOWzP
LFMuH3g3y3atmE38stiP9q2YUWPFJLuIRjWWNfHLgJxwvywjfmPzT8iuFbOJXwbk7FkxCWms
mITvwC/TWNbELwNy9mz+SdDULwMUu1bMJn4ZkLNfvywmQXPFjMMdsyxoJGXF5QZ7Y1l598C7
WZaw3bOsgZQl+w2Y4AFNU4wxpTvIZGgsC5tIGWX7Tf7AA3hjlrFde/9hEymjbM+KSXljxaTR
rp2MqJGUrRMr+2JZ1DQrCyh2rZhRIymL962YcWPFZGTX5j9uImWM7Nn8izrIhiyjO8iXmSx7
v5QxumfFFNV4DVkW7Nr8J42kLNiz98/CxskfFu7a+08aSVm457Cchc0VM9mx90/8JlLGiyud
9sUy7jdO/nB/x2E5suz9Usb9PSsmJ43Dch7v1MloWL0R82TPTgZPGjsZfLeK2bAmIw72rZiB
39j7D9hOvf+GNRlAzp6djIA1djICtmvFbJT7D/ieFTPgjRUziHbqZDSsycB+dXtmWdTYyQji
XStmo9x/EO9bMePGuf+Q7NTJaFiTAeTs2ckIaWPvP6S7VsxGuf+Q7lkxw4aFnxQ+0fWmSxJJ
LAKKN3GW3nIlKsXxxelXLx38ezXGwmjR3Q0mXL4hBYhEBbox2evPt/0Pn/+4Pj/y/nzAdiiL
bDmbiNs70pz/i2yULbCnWtEW2svkO6pey8M16ctFueyegZ/c75wdn13c/K7xfv7XPdbEtziL
DzV6bObvg55e55rVoie03ae/lT+OuoS/lz92Dutv5U/0/7NetfnjyCT/vfyx94O/jz+E8XLH
LVq2fu5cebfilcJLsFZtdbB1tfYH+IlPOxDqkqS4P50l+fXm3cebbOR5Z/OVf7Z88uSFydX3
RlPCg/Jq7Tep4WF5RbODGnCdBDVBx6bmo0KNX0kN+Ku0NjVBpCQuTWrOGd4cKXohnJxa1HSX
wxrUhFFZ4vsmNTDYvKNc5Q3LecNPA4uai+d5DWpiWuY23qQGBm+gRryTjVeyn5580Kg5mYt1
qkFNktD6UoxvG22gJr/am+RXeyvUCM68TQ2+dlubNzi4Wm5IRHNqQPUMaoTU1KCGJvV1Cu8j
rdQpSk+SXMM/nJ4a1JzVWykas/Lq+c4Z/srbAxWfCMdQdYzoprZYzZ/kq+Pq0ISVk5Po+mdX
57/AP72z3/yXMDzCr/DmR/xEFUBe0mHaz86Z35cNK+T96UDjaikbXj5gW6TMe1qk02U60F7Z
FTjXdGN7nMV8kWEfOKOFIQ4sM/b4hvVB3hlp6fV8r8e8Hvd6waE23rgcJm8Sii/DldzJm12u
4RhYfvs1Tewh6XpLM9bgAu21SOw76GGDINh3nsfT4ew5b62NNP2Kby5OM3R408Wr6Fro/QMw
/zadDRbLf8juUZno/JR6EFRozwnz53y8n8ruk52Y+nkDAvlKtJikg4ASDY1LY1f04Iq937sd
0dpcthsAkYTliz6UUDGJAocEGOnl09ub27Z3nT174oVdsTNj2wAVT7kpVuM5B0Qb8fCQRS6J
PLv+8ufxnze9zVTwKCqLphXomy4E/N2vva+1UPDNKM7fQhGypEysKShuT2/9twAT17MBkGwG
5L6T6HN21t8IGIVRrLD79j/7xx+u/c1Uwp7KmAWzmUCAiQMLhr4Bk7DQgmFvwcQ2DN8ME3FF
Bbofr99gWeyXpTn4tvgNWshTqZTfkO3fvQPn69lZeZcXYsEVw5fQve511z/x4zbyvf+5B/b7
c89b28JvnZenbArR8pl4Kds76XWvvDPUZvi3l92j97v0rnrgSZ/feBfdr63b13lW3olMo4Tg
7lDxqDkYQuyq5g1nELFPYSpFf7pvJ52bEktMRH+ZaoKns2fR2m8xmyyRDx+zi/yOpd5F96z4
u3vVQaZlZ+k8zS+huLy98c67Z+qjAt/1KHmFjLDej+n8wGSufJXevhn5UEWM7pqFON8VBH9h
TwCj+2RhV7AELJb7iWaPwa7K0YCxbCktRgffxSOU/26Le1cEQCFg3rfxzMvJxxufBqMot/Hf
NWThVsiG6wuJnMiiesjW91GlBXW+f1eJNNkGqXIX0l3RcMaBNPG3QcrXiw9oy3ZJTsSkHuJS
EjRo19IuB6loEokYlMGciruBxuuBYKDxCmO8k66dRngKKzotgNwNJqm4vs8PhRiCZObtpNOJ
kDuwB6KHo4I9IE7sYBPwnpan8eg199oWsiHbRHXFABwPJTRwqhKXDhzEMUEcarO0gWcz7BD3
Ipw+7OUG/kfHQWgudMaTTk9uyvuXQ3X98EO+fiG/Gz+pCxDkcuFARp3CwNfdtyQybMkw0jGS
Koy80KrienefaaCh7+Sh7IyPGda8Wb3sVIMCgj5dcQWxhoi7EH0ZD7NZcXeDuHVm+ZCCPAOf
bz5f6XfDD0pFHWpXkSF6SxAFernfyaatgwe8PnmI7QNFkgaM27mvoQhcKMTY/k3ndxTZKWbG
M2yFll9vn45FP/VANaUhc0rDlw+6QCgrWC0MIZ5Fbocr1HC1xQYGG/cyh8D1iQCBtjjcKXL5
U6jjKWSzxIXcKXEbEA4dCA3aqZv22LlsdY1EZIFz1UiQoW0kCInrWrCYhC7spmEg63vrxQfi
loXEMod8i5nKy9Q18FCdKV/PlKi2mmvmEO8CV1BSak5PoERmlB6E3GaIMpOw2GNMuKvOT4Wr
hv1gMAw9971z9oDxOhvMJup8RGPwCiRF4yxtuKlJ4ZYWIhSdrm0UW1uIkEemMZSk316VVzTg
fn145HEQfjCn09UkxdupFCSRZfLCLcQhItamEB7TUhzY9uIQifp+G6VLHOh3FS5KXHCenhYo
vauw0JYgN3YqssJXM4nYRrYicUFaBRJbtmC4k5dbyFZke1ICxdayBYGfe/7byBaEnLaC0tqy
JV8k1MBjzdSMHJ5XXNeoxoSaM4zdRpUNFaPKhi6jCgbanGm8hRbFtgUcattH5pjpwGes3kwp
N4kbumdK1e2DOrePWFwCZSNzKoZTK2JqOdTDDRY3FjdH2cO30Ar5soiNYmutiEXrShtR3WWO
IsMeEMVLCEjm8BK2WGbLSyC2lxDkDW5b8k/3EsfmEktEWyxxbC6xgsGxxLG5xHL4Nkscm0ss
UWy9xIm4SN5GVHOJExbaS0yVJXbZLGwKW2uJE05svlKnzeKqzYpcy5xwh7xQI0KU8AMV2cCJ
LPQNv4gEmmi7QvhBXVudRNRc3cASbTV4wR8nmbHp7UlEW0gavubkQrGtpCUJC4gLUT1JS5KA
m8sXHDOF43cNOJ4koem6SOzbchwQJaZuC0T1OY4oAheKLTnO/IRxe+lYTY4DeBCY2hdqMu47
OB7V4zjDMiZzPcMKfyRR1TGxuY7IQlNhqkMjNOEaqMmk6oAIhsfMlOL68QMjPg1N8RioPL1L
t4wfEKWZRpMoXfFDeRaAcGYoI+Gs+EFmuphcBKbGDQKJyXg3kmI7DsrtONCDEIYFBqYSDrYM
cAUSJ4fd64nDnROora8ChSnJg3dYSEDEqalwgy0DXEASctObGWwhoECEOZmhJqBkawElvuUG
DqsElH/X4Ew7ONwoW7yULW7KFiGWo1Ltx1fJFiAxZavalRfDnRPYQrYAhXM5tpYtiHVMbR9u
LVuEm3EbqR8PAHhMTF0bqbKVuOKBEG/LqbGhYIGbye3RFsRRYm0hI9W/GKQO4jiarDrEQcBr
sn9k+Rdyg/PV3Y45djtAZsUPa2RcRbZ2V8QHV64ckDE3srrRj8BgWpwSg60V1Lbyo608JIHC
yc2ttYLaFndU30PCe4XMrXd0zEuZSZkzwA3qCTQNLM9bYHfITKzKTOy7ljlgtnZw4zQrG6WI
JhvdqaYTRNdeX16fSZG1PY6OA4VJ/P2OO2CPub2CgcGkUSZ1oZX/qW8NNPFdR8qj8ctqLout
lNNbHO7OoK/PevPMfQsN7l32AJtUvmEdeeLyWEWQGayX+WjiPjbGwZw5BlfRCcPd6fKNxwwI
F1nH9vAY/IB0eYvsabUQ1ImDx8f05bfytkQAJ8Q+MaAWe2gLj0jfYg/NAxiFFFrJHhpqkkCL
U3US3EXtwMfo35Izgtc4S8/FPKBGjHpSvMBoZJjUvLrvNNiM6zwpENXUIAjjuIMNlQvPrcO5
GgcKCGeXVtA3Fp5q4E5P2lh41sLX5t9a+IBZM2aVCx/o+Tu2Xng/G7TvYoxirYWnwsBULXyo
qw7TF14PiHzNmLBQz3KooHRDGGTLjGE2C0RbOaywM9NKJPbWzJIgcg2vKafcTyzLwarllBPf
He69EbgCnOsxG+WUqeDmMYt0Yg055S0svXhDTjkJLDnlVXIKRkCTKr6WU0qitnxt0T7fAVEh
VXLKqR6scbeB4mL3a+V/6psfoEiqUBB3aCWunVNRMN3w8k2S6hRTwBBXYrDFlPPEObymmEbi
bhVr0arEFIabTl6t8DVi3PWYjWLKVXD3aXdtN0PZkyNunSxutyfruJz5hdpmXsNl5bm3U0Ud
l6vasDa7OTOPuoRMLdMfWX4JksgA4713WKGHzqsKbVXuuKB5W1yUjvlMX4d2VuwZ0HF7XQfo
axO3jjtd0IO2ksHWoE1v1gFN/Epo09lzQfMq6MCsF3BBx5XQ5rmqC7py3oGpXg5oWjlvM9fg
hK6edw2e0+p515BUKubNhgEApKkKbSYiXNCsct5hDZ4zZd6ZDl2D56xy3mYqzAldud7usla3
fqcDU78tY+yCzuctYs1Ig3YW2zn1W+R/dMsUmfN2QSvzJvq8nWWVG/Rbf7azkLJav0P92aak
uqDV9R6o0GaeyAmtzJtrz7bq9hzQpX5zw6bGNaSlWr/NIwgndKWcmycSTuhCv7mp3+7Czrr6
beZqnNC8kuc1ZK1av+MasqboNynvPEboxFkz6tZvMjT1OzGf7YLO523v31aZjAtazFtWwWqy
FphhkBO6yq4FVqm5AzrXb1kwyzVoZ3FsTf0OfGcVcM39OzAPgJ3Q1fOusWKV+3fg11ixSv0W
7w69CV05b7OoxQkt503YHeEDHbrGilXqd0BqrJiq34kOXWPFKvU7IKZ1cEFX6Xdg+alhtX5z
U78Day9xQZf7N9H279ARPlX759zQ79A8UXVC5/OOibF/h47C1Pr+eWTJmgu6Ss4jK7JwQRfr
TZBxKrTlO7igFf0eqdAxcdbdV+n3aKRDu3PfFfqNORF1xWLLZ3JBx+od6Ap0YlkHF3SVXUus
WNABXanfieUruqAr9m/YmWrIWpV+x755EuOELuZN8YxegSbWm04yReHUb2bod0wclNvQFfoN
ouYsRK+n3/J6ljehK/Q7rjouqaXfMXFX3NfTb4CuMe+1fovmFRp0jXlX6XdMzDoqF7TUbzxX
+T/WvrW7bRxJ+6/g7H5o+8Syeb9oN3teW3Y63tiOxnaSnunTR4ciKVsb3ZqUknh+/VsFkiJA
FCg43T0ZX2Q8D65VKACFgi9ZHoCmN7SM5BvQBmNNJ9+ANhhrOvmuXuI5hNbJN6AN2lwr3zYx
h6ponXzbXcciEt3KtyO3mqKZop75e9aVb0UjU2hx/S2juzJGoat6R137HNDkxQmz9Xek3h8j
0Hv7HO9eeBK6q1MptMY+BzR5ocTMPo9sZR1KobXjXFmHEmidfV69JHQQrdVryjqUQuvrbTBa
6vV3hFFTxPV3ZCv3kAm0Xr6V62UUWmOfV+8RHURr6931XCbRGvs8cpRVbNaz/s478q14p5Ho
qt5Od/0NaPKGDSnf/H6JJN+Osgam0M383ZVvR1kDE+i9fOONI09CkxehDOXbsbrjnELr+ttR
VtAUWiffjmJxEWitfDuKxUWhdfLtKKsaCq2tt7Kao9C83qETWt2R2vVhpNBa+XaU9TeFFuod
ymiD/tbKt6NYmhRatNck+VZukmj31/BmV7fVupcPSbRWvhWfe+3+GiXfXVuRRAvyLbea4jen
3V+rL5tJ8q2cHR/YX+vkbdBqevnuhicg0Vr5VvzqXrG/BmjyepqpfCs+6K/YXwO0QZs383cQ
duZvR3Gff8X+WuQod5wO7K/J8u0bjFS9fCv+z6/YX4scxf3Z062/8VpfV74VN3UKrbPPlTu2
JLqqd+U5Jcl3qLa5dv3NwVKrEXcxdevv6p6hJN/KFQUKrZ2/FfdhCh01eaedvBU/agqd6vLu
riwotF6+lVszFFor34pHMIXWjvOufU6iG/n2u/Kt3Hoi0Hr5Vm73UWih3pGMNhgtevmODUaL
dv52u3ZqdftSI98d/5bI7dprJFqUb09Cq1c3tfO3sv52FR99Cq2zz136BqzZ+XfkKrYDhdaN
c1exHSi0rr/drk8RidbN3253H5lCa+WbujlqPn+7Xb8eEq2tt28wWhr59rvrb1e5aEOgtfLt
KrMghdbJt6vMYxRaW29lHqPQuvnb7e63VHd9NfI97cq3olMptFa+6TvPpvJNX3c2lG9PuddG
oLXy7SmXkCm0bpx7RBAAFa3rb0+5DUehdfKtRjMg0Fr5VkLvkGhtvYnwBCpaW29lLUihG/nu
2uceoVMVtFa+PWU9RqF18u0payIKra23siai0G1/y+djnqJbtOffeDW/I9+eolv6z787JVeC
jejPv0NFvtVLcn3n32reBvVu7fO4I9/KRcED59+Sjaz4cZFobX8rGvnA+XcHbdBqevnuhvMi
0Vr57u4jk2htvZV7QNrzb5DvWVe+u35cFFov310/LhIt1NsX0b4yl7zm/FvxpSLRuvlb8Qqq
3epJ+Z4mHfn2lbmEQmv8UyPFK4hE686/Fb8eEq07//Y11wnMzr99JWwLhdaNc5+Ot6CRbxd9
cyW0QZu38o1wCW3Q5s35d/U/CW3Q5trzb1+ZgSm07vzb78ZzJNE6vea7Bm2ulW+/e3JPonXn
3+odaAqtlW/FdqDQ7fm3K7eaMgNrz8cwykZXvpUAY/rzMUK+lflbfz5GyHf35J5Ea+Vbmf31
52NEmyuz/4HzMRmtzP5952Me1lxCG7S51r/FV3bItOdjeKfO74xUZYes73xMkW/FdtCej1Hy
rdgO2vMxqs2V/bXXnI/5iuVx4HxMbjXF8njN+ZivWB5952Nd/5ZA0YozvXzH3fOxQNlnotBt
vT1JvgMitoNevu2OfCuBt0m0zj4PlDMqAq2VbyXiNYnWyXegrKgotK6/Fb9cEq0b54GyQ0ag
tfZ5oOyQUWhtvZXAbBRaW+/uzTcSXdvnjt2xz4Pu3TUKrZXvoHt3jURr600E0TGX70AJ3kSh
tf2trL9n+v21tGufB3SQHcP1d9D1XyPRVb15SCJZvpVVLIXe19uR5+9A2Rkk0O3625LX34Gi
kSm0bv0ddO/VkGhdf4ddj2ISrevvsOvfQqFr+a46TKx3SES66t1fk+odKqsaCq2tt7KyoNC1
fE/TjnyHxDxmvr8WEjNR7/6atKoJFY8FCq2tN6HP+/bX5PV3qJxg8yBHtHwnbke+Q8W6p9C1
fwufQ10JTcZmovfP+Qm4KN8hEU9LRWvHubJLRaBb+Y4647zr7UiiteNc2fmn0Nr+Vs5DKbSu
3lHXZ5BCt/N3PktsCW2Qt3b+jgjdoqJ19aai6Kno5vy7K99R1wuMQmvlO1LODSi0tt6EZlLR
2noTmklF6+Q7IqxcXyvfXke+I8LKVdGifS6hCStXRevOxyLlJJdCa8d59w4Xha7kuwmTJqHV
0aKitf1NWLkqWtvfhJWrorX1JqxcBa21zyPlDJpC6+ttMFr08k1YuSq62T/Pu/JNWLkKWi/f
SsRSCq2td2AgY3r5JixsFU33N6zGPTLEGinflh1gUDgJTUZ6M9pfwyfFbQN07ceFEecE+UY0
GbdOL9+2VG/ZZ5BGN/6pPHiMJ6F9AzTd34gODNB0fyM6NEBr+9s36DGNfANajgasQWvrHRi0
uUa+Ee0ZoFPdSA0M2lwj34g2aHPN+TeiDdpcI9+ADg3aXDN/A1q29twe+caQfxj7T0C78u0U
DZpefyOajKJHyrcTqWjfAK2Tb1f2MaHR7f6a5PsOaNlvT4PWjXNXvimhQUfNGVVHt3S8/jRo
nXy78rkgjdbKd8dnUIPW1tsx6DGtfHc8DjVoXm8v6sRncvD2wmG0Vr47/ooaNL1/jmiDHtPK
t+sajFStfHsWGUSQkm8MlYgxEyU0GVrRUL49eTWnQdf3QzEgoyRjnrya06B18t154oZGN/N3
FclRQhvUu5LvJoijhDaot3b+7gQC1KB18t3xQKPRWvnueKBp0Dr57oSx16C19XYM6t3Y52ne
kW/PNai3Vr4916DeonwHqYQ2qLdWvj2XjLppJt8u3wmWnqW/Gl8O2eVus5inGPP9Zvxgscnl
wy2b7VYpBv0u2dEyKb8ioX0sUUE1btbfB1XIeIDNs0XOdmUVMT7LZ8luseWRPMuXcpsvWbkr
N/mqjQHq2tyBoirO1WjI5qttXhS7zZbtVlN8UT2XE8di4hyDktMJcSHQJrwaTUa3l2fw7WH0
1voRBCf40eX54zn+5khARwT+Or7CFLmUwu203wja/2Y8uji9GlmTIbvAlzcuHy4fgQHqM9/O
k8X831Xs+5S/x7yV+br90eHDcnzCJt2u62iqbFskqzKp+wY+qlqiFFj5idx8vVzuoGvrfsjW
y2S+4qFth+wRKRb4IrQOdXveIB5vLqAi36AaWVWNzRrGysuQLZJ/v7DlOsu7HA+jh2vo7Gnd
7ftWUHNbzKfJNmHf8qJEZvfUsthinWR5dtpNWjUSBhLl0Xk/PVywIn+aQw6Fyrsrp+m6gIq2
Sdgq/14NsFmS5iwr5pArJpwpLWeMft5NTbH1K9Fttl3g1eX5iN1Cb3/OiyG2xGkr9a7LV8b5
bP4tKcohu2+568/YepMXvHuE2rg8jtxdvr1JpvliyK6bjpivnqRUoZiq6ffnpHxmJfQae8ts
J5IAkQTYFOvtOl0vSkj56e7m/OLq5uqSja7HDx+/eWx0foM/CXgeLE3A71YL/AkHeZHMZvOU
JYsFf0a71SMSHGq1TLebIVsmq+QpX6IiQOFar/AnLh8Y7nhfMIZdIjFgja8epZYcv5vcjh7H
LWiWLOeLFxGGpvR4dI0SiSFs+UMXqN+u7//BivVuK7YrPoUe18lBXU/SJH3OJ4v5Kp/wRi3z
Lcp04EElt3kp4pRINu2D7Diuyrz4xsPy9r/NPlskT/zFZw+j/PzBjrK31gnbvLWOpbzI2JA8
TjqRl+7p9jYvx7FSXV5KnJv2JXcpL+VR9z0/Wl62lp4MydbTbOTL1SbNFmo2qnR5Ua8TmOXT
vcgqvBarqxPxcKxhXmQQhN68iKdbzfJStkd7+4p6P9QwH+1jk/r2Ux+xNMyLvBioEyXdG5dG
ebn0sVl/vSKr+zyNYV7qVranF1vh9RoTsQV6co9fVxXiERkhGx7+RJMNuSl+8IGaIUuT1S9b
fApgvvwvtlrziQZm2ilYYtILaGJmyg2V4LDYqu8rEt1jY8VsqWIeuc+h5qW8l0F0D0VPbifo
RjX1poZZNXxyAa7XCMpzCsQwoLJxddnYmmwsS3pywTAb0l2nfwCIutTVzRFUXqSLjCqf/S+S
meWFOi6PnH0lcnZ/fgtW+WwGVm37QGs8s5oHWmP5CUDkiA5zuIGX1/MYV8EKR2zCMbXtHg7c
CD/IMXWcWjDdKcVhG3BksVu3hzujOJzDHJ4z3Ztd7s9yJLN0T5IQJfGUcEDcQPv2lCTFdIgW
K1q4LCnZFFe5n389r5c15hy1xkzXq20BJvZmXZaoSc0J2kxZksE6cQi/pbAGLd/O12+gnifr
76v9z7gzUL5dwbKgm0FDVy02xb+iu/ntGlZK62Jw+z2Zb0G9LxZsWu9sgMme4zKQjQZ29Uye
BA5Mwc5fAbtdcHXnOeX1Xe+KFNafD9/nW1hxcJzwB7Yt00GeFMLCxo9CVPKf3z3Aun9efmV/
7tZb6OQMv0+C00BYiUJaNBOrtPj3AV/XVIvFLb4Qg4Us5jmsUn3bYUfrIoMiw3zsWXFQLXUE
hRJF3Nt7BUu58WpcLahwu6BNEdvovVDvJFQDopnKrCDiOiaIZ39gAaCl8lUz/jOJwtVQwNI7
H/BvByl8DcUsC7jBkKFJ20fBQ14IFE5bisj3Bvxb2EcRWDafVlYbVs1d9aM8gnJP29VZ2gg4
sKUJjCAGA2r9LS8WyaaUhItPFTHxvHbWLO/4q1iwMM4FdQGlwVshQoXwycXGkMrSvSGVpSEv
Rm/FIktPlbRUiWVAZfdQ2S2VbUDl6KmctlRh1c7perfIwELcosiSdJ6eLm7pYvev03n+ni4y
LV2gpcutfenyelD1tJtt4f6QQOXvR7pT0TjWLO+niPnZn6gXhmy23q0yFtbqv90xCUIeN0HS
fkm6mU82S9whqrau65G8TH5M0pd0gfqp+fCEf4qb15MVfOxYIIdgFjkeW4mZeHioR2waXcNn
2k2jIORvol+P2TzDTVpSUTqBY3terSuHLD6BMsSh7TuVvjxhuGuUFK3eDGMfzy+26WaywJKs
JrjdBfNhMeH8VCYYlnKfhX/CbNe2wr4c0P/pETkGm7zY7oopSRv4vhvseYOTpjJa3gB3xR5H
Y5aXSDUvcY6imOsCNtQRFNny8BqcnjuKau4pvlF1uLgmLR2jmQicQ/Z+z1fWJy07HAJHYkWa
VsX8eV4tFSy/cTfidowF3K6/5iu62oEbtWMhPGFu7Dq2ttKRxR/S+3Q5PtzrQOY7nhNFPWS4
Fwxkg5v5lp7VX8vIt5UIsfl0d/3bGXy/+Tg6v9HKD+DxrSMC/9ulfqsWUPSbN5/fyU9A8jVc
u585IyY80CVgoz6tBPUE9PTzLjW91dLbIr0diPQ6ZjJQUpc2FGnxlwO0Lh2fhaC1RVr7EK1y
6VzdVfGtsNlV4T9WuyoUWfc+tNFLuYDrvilv9NAq4siY79qH7cU93M7aCciU67kmr2gijrwE
rhRC3r3pZq7cLaJJtHs0EplymcDkoUXEkQ96agsh7qwohWjiCcnPCIKhUC1i9m9l1xRWOgvr
DGQWp4/F37NklXWDo51iUR58FlkCwXJuTFX4OtWyKW+Vimwh0UDTRi1RbH4fW0Qe3ISNnqMZ
lfcyHYHRNpSHxplHfh12T6O836vAlSenXboUvWPZU9+o9WiavtHo8lmRn+SNbh72R3Ynex+H
wBMS8xC9kHhweXvenBSW69n2e1LkbAo2LGRcbczgX/jx4Ud29PDl+uPjzcWxRIRmdIOERPB3
NGg3G5gBO6s1J/Wz6X7s8f9cq/roD3YUeLcyM9o0kr28LdOurdz+17GaHXeWhKGTzpygYzp7
0Oux7wRx5Pqi8Ry5/LVE0/0JAcdPah+LF2wqSLhbbZL0KyvW6+2sZPNlAnoFVhG4ZVAky1l5
err3G4AO9VGTNYfesACulyTbYlfiU7hf8xfsglJABNhcH/KXysdguoDM0MAmPA1wMxh9Yb+v
i69Ikm+hEedLtAWXmwlMmOVbMDSxdbip9NYBo3CXfs239e9WSwRLDRC5GSzRh7wm7Oh8fL33
iQhPPf9YSGzjXg16IjwV8+0L6OVFsoVBtMRi8xFFuFsgDLdRBNhtkj6DrdY0Ao2KuHvKjzVY
esluu14m23maLBYvbMdH9RRqy6APoe92yyUfzbXPEOCTbz9Y9Z/E5wvtm5Qvy2UOdmVKNjCk
hnY5bxNBWdkmKWCxyH4BOY1/0cBwU/YChxRbJC/omoT+KE/5KkeSo2n5dNz4YTSNDLh6KxCd
nf4PZNKRWj0KcfyCxipxyO7wSePln4MsTzI0eOlihGiWSJCvL1P4qkkcdRJPZ3+SSeMQzaRF
nkGTPA3SzU5yNQEZAY1euXKhi9A36GwGFRyNP5UiR31olD9vuHdCzheQE35UkOaThpC9ZZaI
qk8acu5cIVtpzYYqKtsVf/xZBNbvlVLAYrdCueE+FKjbcBjhLgXY9t/mWeUDkhTp857O3jvA
U3Tj2yvQLWBaJov9K8NIbTuWwOC6eobp93RbLIaw4uEPXmsp6mguFAXlLtt9Dg0omjnSgKL1
mfXbOy9IUd/VNaAgA8sgRX0p3oCCjC4DFM07focp6BAUSNHTIyZ+8kgR6keZxplWeiwNKILa
nDKgICPOIEXtn3mYgn42DSnqa8wGFGTsGaBobt0bUJCOpkjhmo5OOgoNUoSmo5N2tfXwmpbp
6KT96ZGi9rc1oNC1RdSjcbSRaYTIkUARu/qK9ChPBGoGlHMI6GmGkfMzWtdunjGi6PRaVxiU
dvOgAMXQo3UlilBPQWtdt6N1bSfSN4uZ1gUKfVOYaV27CZ9uQKHRurYTa6TL8OE6TmHaFjqt
CxQarWv4hB2n0Cgrw3fsOIVGcRs+Zudx/wtTCo3WtRu3LAMKjaaxXZ2+M3zbjlOYtoVO69qN
U5YBhUbr2s2NOQMKfVtotK7he3dIoZvEDihPu3HhkoHVvtoBINX6FfAntG7zaD1Fp9e6jsDQ
hFOlGHq0rkxBtaJ5aFROQQ2HA/FRPUnrNu89G1DotG4T3tWAQqd1m5efD1NotW4T6NWAQqd1
m2ivBhRk4FROYdojdPRUpHBMe4QOocopTHtEq3V9x7RHtFq3CQNrQKHTur5j2pxarduEdDWg
0GldnzQWzQOsIgW5pDSPsooUIaW4DZSnTxpW1UHCASA1YVXAn9C6oUNZJPVBiFbruiKDRzZB
dkDrShS+vjE0WtfuaN3QJ8d1f9RaWeuGvr5lDbVu6JOD0jh+LVIE5KA0DmLLKch50DiSLacw
7RE6nC2nMO0Rra3bxEg7TEEHtuUUpj2i1br02l4f4pZqTnKfwzzOLacw7RGt1g3JjTzziLec
wrRHtFo3DE17RGvrRrRxc1B5wmJsf6n1fIT/Z+dZssH939/PR+eXf7Cj9WqAG93HIgg37Oar
zW47ZDfzrD7PwdOYs9pB6+zm7reHfz483kIxqp8vPj3gz+O7sXUO2gJ+rJIO7Sn/cGRd4oec
tfpqiTm2t3Onu+12vZIy/v3m+tL6Q0weRvsCjvkV5QuOMi7iyBp1SiOMf8dGg1YujZTL7+Mv
9xdCecDQgVbePufFMlkwyOvx/dX9bX1cu9+/h7LVSSb/Xq9yS8L7TYZ1kiF7rOn+BWnZ74//
4qd9TsRGQk/5PLbBQ17MERE5vnVmB75v1WcgJ8x1GI6Y8oTPQeVzwg+E6smp5QliFJTnTb6d
cO+6JMuGeB8G3c7ysmTrgs2LP/Ewjk1G9w8tMLRwM/IOxtC39SLZzhc5W+bLdfGyP4WxT10p
OVT0Zr7a/WDJ0+YpgcHc3rz9Zp3alpjaQxv0XZHnzSlWkdX0QzzECZ0P+8QBRqRRbhJnxXIC
wrXK0+2aPJ0J4gi77sczyM5zmrWryEOShcBIC3y1WQJ0eB1QQ8f7i5/KQcWWCdZBuI7Kwb4W
/OP96Jq9X5dbNqo88xd5IUIDfb54uRkvY2O2beOd7B18+B9WuyUefbXyE1r8NqiG8zlN8aAv
WZas8hkNZ6kNn87bA7sfIODsz928+Fq2CpU7c8WRYDlgPt7hNrvNl4MvxeAar7m3WFh967G9
TYbQ4G9pMkfi1I8mXpJyt+GSzNndU4ddrZ6TVQqMD7tNXjxscmFYAx9qyF05xf/bQ3ZXF6u+
XsHdbU/YPPucr7J18dbOgin+Oi7W2S7dvsX2PmHTNLvk6d+y4NSOJfa4h73c8rP3IbudFW/d
E9awAmWlqu54/d/aIiPu3LaMNeRwV8iw22S1A1Wy3RXowVjpGSz6qTUo0mBgD57m2wFf0wye
At9J3NByp64b85YfQMtL1I5ILZZ8KHWQgOGbx8+7KbMHMDtj32Gz4Ae8xcWUuDsrpbS5poY2
3IK2kvqSP5JUl8T5mb50+/qSP6KkZf+ZvuS3XVpG077swP7OvuRhEFpqo770m750DvUl90WR
UtazLtGZDo+69fr5BoCksqsuVx8AhlrgqycqWD2TmqqiOzBRAdinZtsK3D88AErNcRX0NVq3
NTBC1w/0dfmpicomJyqXPw+jyae6ZMV9TXjwiDV65bJ5yfuh1vriCHJpS8GkDV0esvVvaENP
4tT3CzVz2f0zlxvhfaFaVt2/e+YCdqeH/Se0HTC6IqOhtuvC/kZtB9SeSE1rO+wgAROjhkQd
5h7Qdp6FiyMppa1Xd77jtmXx/u65C9iDHvaf6E1gDEVGw94EWCTC/sbe7FKb9KbPA0NiH3kH
etPnwRCllJ6+MyOPmrsOT0F+FAavC9xU8lpOasc+iamyPMt6zYv1qpqk0TMiPXrgqhwxnprN
I8tD4+RuDF8ezhyhX2F9fzfG85Dh+MH58AdLtgyv05/AFw/XweJaB8gcggwdeTF0E4/s9S1n
559+q807fq0T9ep8Bmt9UPP4bwUNU0Brs80iT8q8uoPNt4458+lqvVlt2kwD7vyOTbAeVinY
h4vLKoO+wgYBHi0V23SSLtfoND20wLK9fxxhIAz2PfkKElmsl+xB0O8hD0rXxcjbGvBXYfSF
AZo4XURzw7x21OVuwdg8GPN2YIHl5D3a3tD3h57FPkGJjnAX0rGD2GtjfSA3rr263MkiKWCa
3m2QELdLltCXzyfsxf16whyvvgHGVt9gNt9zRVaMm604+haTDb90jWG04Dc2HvBfm/E4J2Jr
eREYJF4X/v7LWNlciZwIl5rlHAPEDWZQhLy+u69+hIL0e1Ys/xAvRMHCYJGsoPx8QMBfwSxZ
CQMaMkATvsJdt76+NT8CbAw5VoXrI/JEJ9LlfAV/bXsxcmM8kgWhKNcLqFnJd+JqV+10vVjv
CsZJmkAEtc4FA+iH254x4EOn8asrP5vizmhTevg3m1KZibnw5dQ8g5GZfGfvry/rwHlNFx6N
jtn/zos5+7Au56ukRWL859epJshFglfzBc8blRHmjVw1QkhqY3CCrFhvJssqEoActQ0y3KLH
OU/C6iSsdtsVaBw8w9PcVQ101+Y8dPf2cavwiUdUu68imtXHU+NvgZQQWuR+fGOWOOB++INy
vt2xj+e37Ogavh7TaXGxTpR8fD76oL9nC8tCfnh6dXd1/+s/J+Or+3eTi+vzB5wKeZi1X2Dk
LpPFLyegwUr2C5iU6DOPFuYvAkeIPnrLeVqsMaTEkI12oHFXOFt8m6M13+zdB7brSjBfgn3a
ZBhakfEwC1xbNkBPPOGLghhNk+vxNSufQS1jeEc2LdZJlsKqaKgqidjG+63cRXzCdSMaEfz6
ASurW5pHIOi4wIitE1gghKEdBseD/znybd8LrSAA+2bgBHHsuHF4LPDyF71EL/Kk/Iraqtwv
Y9oJIrY8XFvcQDExY4yGNIdSDuYr9tupb8UszQuY2bkLeutyHns86mm9HX/+KESg5F3koHP/
dJ0UmbQ9v6kvN5zxCeyMz2bSjvx+e8zH6x5xVS7gbIvCfrnYzRcZv5zBbzHwuT6pLoAUK9Dk
kDM0duCGtptbgQXSk02dmeMFVhKl9ixL4iDzrcTPnNif/dJm6HDf1H+X35NNE0ikvhixWcMI
/Xe5zcTEeHpxmS/X/H7ENimecmhfVLd3MGgwLNBqt1i0ANdG/4z9XYnTWZkWLxvqKgpPGwtp
66QDvkDH7sMykTg+b19si1lZV+CE4bFD9vYFrzfNSuj++fYFfxNBaKi1l2TmTxO8mEHxR3Z1
SLS/ddKMGmWkgNBcvbseZlMRjDNWB9zp2lsUOrwixb7wi2xlY4xjG49H52A52Dj3wwRjwaCP
cjtIvTgMozSLrVkc594sTnI7TH0/mfnuL1LuwV8oeqzWW1v00boAq6yKrYpUbF9u202y6cxz
rXiaRU5oxSkU3PdmYLrnme84cRQl9jTzxHLzoFQ/W24Hp5+fKPdw3/5tBRxYVib5LPVn0+k0
t3w/i2ZRliR+BMrIhdnYs8Nk6ie+EzpSBfC46ucrIPcaDAfQi0s+ukkSNgg9Ee/KmV8VBUho
knEwDHNurTdaaX95qlsO2w8wIvj4Fq+/3iZP87TeFIEu9YaBFw9jNxZSh/g67z1OV6PKxufK
nOeNoQZgvcHPpoQ7WvtrbjAKQleMM7pcprOnCWrWyXwFCnM7aa47lkfHPAWohSkonB+RyIGv
GxlyVB/1hZzZE2Pc2jZ2b7IF/QCN+rCAlcvvF+ePGHSu/hQv25cw1x4LWN4s6eIrD0tUbxru
VjwYUnVjUEyL4ooNDup9kxGIKkp1FdtWAPqBberab5H3eJDC+2v3eJCCdAsxv8eDFDqndEMv
G6AISVdR83s8SGHcnLSXjc+jmf2lezxIQfo9md/jQQrja1H0PR6k0HnXG3rZAEVkfLOK9rJB
Cuev3eNBCs/0NhHtZYMUPVcATbxskCIyvk2kbYvY9HIWfY/HdwOrh2J8e/WfXbPdB5OcdBur
IDzk2eT+6lfc9andEGBdmix2lUEwS9C6ZkftbVQgdHvumFV6rtqbSGFJ8VQd0PB8YO66dJ/X
+/Bqvm/xx7ob94laVWY5tx9zwZHCcoMPLcp20TbtoGprurqUfYRzFaCP9xQw5zsSBS6avhQY
ZgYXdVBtvnHwnDdERZ5kg/UKVlCwmkqGzIX1j/NVYOBnHL2F2OY/tmdgEGKM+adk0xYmiISi
ODyIQi9RxXGmEtmwHBKoohh1148oOFvCmm+EV6OB68ub35qDsxI6KClLNLRXa/6HDWRQVluu
pyIRXt6qsp3AQmqLG1gLhj+VDDo4Z+Uuhem4nO0WEgpqcr9bsTN+kby+Go8NjGmlhDBdsmoF
DkuRHa7hy6GUIMQErGKS/hDtkfnq27xYrxA8VJMw9v7j7dXbM+kvcfWXx6v727cL3PNu/hrE
QRTuo8Blv9t/gKGwryOMgiWYouxsVxZn7dA4bdEhj1oqouufmePHA2eAJ5R4lLmq/ISaPUZ8
v4AdvRmf37I3558urx/Z4OHq5vru02/w+3h8fn/78Z4Nrm/P2Zvr8RV783B7PvoA365Go4+3
Y/bm19H9P8eP8P3u0+PNA3vzcXx19/BwA+ARfLm4+XB9yd6MPt3DL1c37z49XmOid9eXHx0g
vLxzgPvyjr35cPsR0t1cX3C6h6vHT+POr5Pxzadfr+8e+MfvLq8foBTj0f0V8Iy//OPT+c31
4z/hR9v+AHV484/7q7vRx0so8OP4FpJc/Ot6DN9u/uWxN7/9i735F5DA14dHyPVi/G7y7v78
9urLx3sgvXh8B2k+XED9bj9C0T49Qj0HD/98+Hx9h9SAPL8fvb/+fHUstr7tyK1/WR8N8KPh
Of68g1ELojEIPKnbbF8G3rd9VLlziakDvIkippZ2x5Z1UANoc75HXSSwKFmyesW/LvZMoe0E
dn1k4g786mDzef70PCjxpFE8IGr8cOqlfXOysWdyg9By5TL9Y5fvcGt1i65r/7ee8lV+Eyuk
WvnzchfZ/nWOR/7pvnwYK8yPZdYRjHpsz3KBxXrgX8+qBPW3bFC/0pHPSpEqsoKOXGHJgAqM
5E2CzpNj0Enf11Ce+/zPHdcxMFXU+7qQquDrjxf2BRNLzF6nO65+bGpNXjcfbuWcwdT29Wz6
Mtjt5tlZkoX4uDksGDzXHni5FQ6mTh4PwHyCte00mk3TqRDHA3OJApNcnjbbAW7wDDA8iMxQ
bTCLgyxPquAjVW+ME9Bmn6BLpHaLA7cXVfWBCusWtwv7nmxEgM0dHnsAj/MljMBuPnhPXIbd
8FiA2CxgOPwvrNdWyYI94Os4W3bEm2ixfjoWKWwrNqaQ8uauaFrgDvJqzspqtAjmVwP7wR+q
6VfF8qe2+hq3qm63sapHQxQZwCwrueJlQL8K+HwL6/XqMJnvzZXSWPKVsbRnuuL7vRf1gvYm
/wY14DaARABzoK0h2Dd4taEvwmw7ijwNDHdImha7XWP4EKnItuNHnQaHSQFW+/dQ1qKY49FH
pWmP+e54+XXOQww1cWOhURLoFpjm8ZWVVTavHjPCirGjUfPBQ57u+GbhMk9KDIw42H2dH4ul
CCy7t+tu1inU/WrVGJ+f1wuwS4RehEEXh/29SPQeTiQ4+KUmCQNf1wmj9SLbLHZP7BwMLj4Y
KzapTR03dDvd8Q7akMeANBhQLY9nu63wD/6vGgBAGHOVX2398KDbO2hmMDvLktuL83J/SiyQ
BfyOC1ko/dhs4bHrhxo4NcT2QNeOu3qk2xh9/dLy+HbXhhNnqkXywp/XGqA+ZFegE2FiT1/Y
bdMo1yv2DkxF9pCCLb8SeKPQ7VqWTW/fQ1UG0wRN/lv+mFDBZ+u6oFfVASEezLybd8TKje3G
C4mbEAfcVlwrjWW3ldSX3Fas03ZHiJP7enKd14rd8VpxJMJQINw7rVzzzU5uWYwSaNNEgog2
kuywEj08jBz71nEcz/9sP9x7uHs0tiR0LKAVn5T9NkcUBPydFqrfX9k9e8ow5EfTFGVXyTaY
2Pe8eF/ioLIJcemhtQldjU0YB2DUwkD+vqwCz9XfB/xSie1VAZHfzYslD+x2sXuC0n35x4XN
F7qMv2fHwAwDOW3i5IPqfV5X0Zsl5xyeU/zqnJyfyCnygqCOPIYt0g35qXftQWRk65GvdS+N
8UA9bvgWm7INfFjFSu0rim/hbpgW+jNl8Zwewr2zaz1yjnBTiw3+B5O1sYHxbobTV6XeiwqA
DsKf7Bqfb/xr88VtpF351vphiZDQez0Ej2WyZYL+RvwbJn3HA3pX7jTzVg3h24OBN5i22w7I
ENuvzTSyoldDHP/VkN7+pyF+X1/TkLBv2NKQ+NXdFNuvbOS4OnzaHwZvyq/EQXAcuxH6dM+d
dAIT//xpxdWR/CvmACp6laEPwC3uyrwf3T0Ob+ALe8tAPoaB70iMsQHjuwSMMIUNVlxDIQQN
suH5y0G2C1CxfDIQiY88y2Jf3//7WKCLuZY5RFfvFGOL8saVm9blm2V/mST4O0jw8sJfJMEY
lH8DCT+f/ask/t9BEpqM6EMkXEb/Ioltm4zdfhKcQsBcysCSQVMtxb26y/nTfAuGUsejmSts
0eFNZOE7uBXLaL15KeZPz9uj9JiNYZUJlB/LcpmsBEDg9GmcnpkLoJ5Wv7mHoL42V/cnjAAg
DLRTjWtsBMRR7GqnH/eQERDH3OaUJ1nbeJK1T6Es/LCed99go7yRpmtRjuThfXTI1zVoxce3
kzV8D5foaJ+2I7J6GeR3fI1+WA2powLW7c3TZZwxjg6Kmm08A1WMh7WibTQD1WwHpdg2m4GQ
LnJxQtM1IDUgrXpAOiJL2NcNfRe5AG2DlR4YVKkZHfXr4NW2ucDiWH3C2jMqAYp7/K8uwKze
uxCJ9HYhlKHctQWXYF7jjdQHI7LznD51Qsd+yaetV0pF4vbpR61fCgxFkcTrrTjlmZLiO6PN
6r4i6VW3Gt8Uq/VNqUm0CxWFpPJOqV+z8ESSQGusqySEH0JNYt47NuGJUJGEljkJ4ZdRkehN
fIWk9VJRSMyr4xA+O5zEt15REl2b8D16UxLeJi4G+w6TRCSxtSslhYTyVqlIHPPBJvqrRDKJ
uexQHisVySuk2G3Hyd5nBUkc7q2/XKbU3MkdZa/Z76Ju/6Pe2DoHK0GgCeyeOaVHETsWv9C8
+gZKtgI5RiDUggTo1eaEU8X7Jqj2npz8gq5wAYnfK2lmBIHIw/UHJ8IvFi95G/VeJG9Btoe+
HETupCK3bGjmaSjBfRM4EcCrhocm8GoAYsBlR1DeCKebjlbblqy2Ae6b1N22mqCslqiwEe6a
wGm1hHCTptMoaYQHJnBaPSOcHsBGihngeG3mMFxb98Ck5TXKGOEmLV+pYWrQBiYtr1HACDdp
eY3qRbhJy2uULsJNxrygbm1B3TpO/4z6Wo8/Thn2zq/mPn9ABtrB0cemoV2e7VwyLnHzwzKl
qPoIX1H2LEeicEwpasMS1LhoWCKFPj6PkVmJFPqoSKTLs43x0gQd5VWB8s0ohPEayKXQR/Yx
0lVA4Zn2iEZfIYU+JJORzkIK007V6C2kMO1Uje5CCtNOrfRXCPLVHeA98ZuMdBhSmHaqqMdC
mUIfCMZIlwGFbzouXNEVfiZQ8IMUDYXq8gwQ3+WmogbyEwrQ96xY3xIH1V+6XrSFC32+YSoa
cclisU75tpjrsNv5BXvGLc86SF19nfgoAuuQ33UtG68WJAv5vWqRzHbOrDOr8fc7Q1/Vsw3Y
2njQumsu0iE05qfe7XEzmLCNf2qCl1Y31U7Pf7GmjaAuCfdSrP6AIRn2bJFtS4fXh4JopGEi
eSP4kRREw3dOBSMyAp0X6cklbwRbH0PDFQltRyDceyNcPX6KLf88igZXUmJfSCz7IVz9ev0g
JQ2FpLLTAdqy/rvxh5EbtKIeuRFaOlXvrWwYTTbbtPNU5DkObYbp1y527AfOvsS2ZeBK4JGu
BPap4weB0fZ+7y4asjgHt8IIlu7eFBK5vQfG5FYYwML+00h6KwxwkX73T7eCAmNFVOacpDdz
g60wJLF7D3oNtsI4Se85roHNwkl6z481W2Gi1YIkvQ4HJlthSKLfnTC0XDiJdtvH0HZBEs+c
hLZeOEmvx4CB/YIkvnmb0BYMJ3lFdZqtsEjcCkOSwHyw0VYMJzEfJ/R6DEnCXr8KA0uGk5i3
Cb02c6A2Xp8+eb1p4gSx26tdXrM2c+2YhwloJ44D07g1zaRp3It8t+tUaEnsYQ/7q+dxZAws
kXE/kV8sdvl2vd4+s/skm68lhC0i5Nn8Pk8W2/yrlNwVk3fdCHPLq24g77UsD8wAhaoqNeDv
pULSHQ/2MmwjWpxap66IwQ2LDma+TreLIfPg76fWgP/GjhzL8QeWN3Ci4/2N7BIP5LLlIEO/
2v+HT4aWp/x20yl80mbiVhv2se23FqzTb0twUEyCXrsPClRBQOdfhdSpjoqTRZYXi+RrPtmc
Fclmu65+2bGjephcX7IkTNJj8Tg5q/1z963rwsCDAZVXxbraD0LfiULnUNCgbLdcvjSjMgIN
5wvw6qBU34ZZzh++RHmDj1AlYEYtAdiXfY1QPdjLw5NsEh795f3uKee39AQO/s5GTyE+/3qO
1yi5n3Mt9UMGq5D6s7fz9RtYXpzIvw7X31fNz2JeuLLvrTCQVLFYYETAEPjO5iDEtkRh91JM
JvDTZFu8POE7tj+PxAoMmSvh+0d8hd/s9jrQd23Ppitcj9LGtbyJ6XB5OwLLsfZxRdhZki02
k2yZnk7nK3b0zTl1rL3ChgLxO+pa/l8f4cdfdyTn0y6dhBan3b/Pi9FtTj2RHrfX+unfK/Tb
p8XkeZfK1KexoKL8mL8XepCYv9X7DAN3Xi1p0V8a745i3ChssnYYB1YQ9olC1RKfRmifT5fz
kheqs9bnJAfry0kebsYjFW7bIT3CuvB7AuxYcd9QGVcXizGCSV7d8Toa/zY+bi4cYxyJNeiw
1T7+qPoMMubi8flEm4sQqMrrC8MGVGG1MaKGYePk9mlQR2ATs2kjr7VyGaKF2MTVQGW/BpWD
3xrP+N9/ffcbvgWw3C2288FznoD6eYFyMR6MarVmYJfgpeLVuhUMjMnXPplQ0aG/ySufdICP
P19fXn0cym8ntAMZ415FGMAtxcAxWPMqetvRbGod482WTTFfJsWLFMEN2sZ2XWy8V4ebczzr
R7ifQaA3+amQtjt5YLm2VNqYcpyqcts2n9AdvDAaBP0KndTGNbI/ux5tXOG506KxNuYY7gP0
U6XlE/1fKC3fgzUvrXtqO4HP3USKP5kT4uierrMXliYom0db3MwDk3Qfpg6DDfwHpMXduf9g
6w2a+MciF3rVj8afoFY2+3R9CfYmG1ffRmu84I+hv8BQPIM/363xai9aRJlZFNf/tNn4/urq
dvx49G29gIkbRvwxY56bZLGVBn42c2ZpEKRpnvuWleRh5sZR5mVBnM8yLxKLieGK3ydFxmeT
FQzXIbu5uvv4+SOL3HdfQCA/313Yge3YwQm7uP74wMbvRne29+ULs+Izx4J/jifxwaQwwikD
rKA0H0p/wrAB/w0W5/9In+J9fzDaNhNY56RfJ4tvizfWDz87s340y8AqIV7fg24reOCKyTTJ
JtD8kNT1Iek0FZLyy4JozmIIIlCuxW6zPcV93De4aobUzRZenRq38DCA3iJHygk39t/gzj4k
jS0padwmnaHX2npelyJLILE9k1Lj4IcSp9Df61VbFEjt2ZA6kRNj9YikkaUkxWfv2H+fdVoy
QL8T9t+P5w8f1I+TckmVwwmA3JPJMZzU9RjXR7BmSje7OVY2R9CEr0QBNp0izJZwLjfMMYQh
GO/wL49YGrEswZ9nM/w1d1k+w5/hnxexKGYpSOeM2fCrV6Pc/8/etTa3bSzZv4LN/RC7yqSA
wWvAirNXluREd+1YV3J8XZXKskAQlFgWH8WHZe+v3z49eAxIPCnk7pd1JTZF4ZxpzKOnZ6an
20oejhzD9fnh2HBcQzr4TA9L17BtwxTJ86RkDxh+ctyf8dTM48el4UeGaSW/dALDsw3S61S+
mBgiIgWPz97EmFqGJ5VchdeirnR7p6pDjhChasoJKoWwY18aV2/fnf9yp+Ik00go9Cvsb92e
fx4ZQMlJHNEKjjfkjNs3nxNI/sciI+X422IVI0DHpfbQJHQnVjwhwrtrVQz9CX0znEnbpW8v
rxsIEYjzzU0ZIe9CFv8I+jY4+tYvEKLz8Lah9iecUUe4RUy62cEf+lZk1TOZzsJZLIu9EZP9
rWXn0MCdSFtGJCFvLB7VoeXWvzLOGI3/NMr7dRgd92usQYqPQ+dg/LrF56AapqsxnqMnrDCm
R0SRy024xrzHvV+Db/Md4zA4wzZa4VloS35uvI1xdTrkJy0Lj1rFsrErkuqOlNpz8LQNKWhR
VHjaZ/VxpCjg96B022arK26+IPbHT2ltxmEsp5E1+zl1GIcGNP5Qn//UcdiwyHHSjqxpZFo/
J2cJT+P5dqM97iOSQR56DTsTfxNJ7/L4NNLy9CJHcIR2AkFT9OPjhKaOLVviyCeVGuBe5ivQ
fDEp7WA60pO6rFygafmNBXa83ZGNhuRqxaEk8MJyKz0+694ByGbX8E7CCISebXU5rATJrgo9
CmMj/uNJrQtkq2tb7YVxXM+vvlZSJwyQHW9JNQlDS2vfbHXtrwzZ6sJde2FIOfr1hz1VwgAp
u11CaxLGx1nASaOJkOowsD9hpC/UDl1nYYDsuWYCn9ZrJzUTkF6PHdiyhhYWrHZR39PKp1L1
JhDZvc8rpNp403R9c2F+x/uETa8s4F3XXZslSL9fYWzH8WTtmVmVMITsu2YcmjraXZUuQwY9
ajMLm6mCTZXuwgDZ8V5ukzAeJp2TagbIoNtN4yZhEGHN6q7NEmTHi7VNwkiaOqovINUJA2TQ
7b5xkzCIT2i3uh9fhvT7FAbOWYLdTrsKo5Cyz2Yiq9AWqs+01fMKcoJNnyCzO+1t9LyC+D0a
ikRpp7ubneUH0uu3/h3H9Kqvk9UJ42Bp1XhJs5MwLk067WJ1lCD7nXQ87ND79d5FVcIAKfsc
s2R7YqXTKiRJGdLrt5lw4V90NxQTZK+GCtmenunJk7QBIX3RZzP5Q9NzTjGhE2SvJrQ/tGjq
qHcZrBLGStdIPQkjyCoU0u2i51NI9wGYIB27vZ5PIT3qeaJ0bOGeYCgmSNGjoSjgGuHV3LOt
EwbIjiFpmoTxnLr7unXCANlzzZCVyPF8uwsDpNOjAiFKiZRfJ9UMkHa/YzZwxYl9Bshe+wzZ
nq70TtjRSpB2n80kSEHW3VqvEwbIVu707YURnnNSn1HIXoUhqxC5r2QHPa8gVqtIcmWFZX2+
jZ5PIH12Bg9+hW67cHFlyJ6F8TDptAoRV4bs04QmSh+TzknCANmrnifb07HcUxSIQvaqWsn2
dJwThQGyV2HI9nSCk4RRyF6biWxPTDonjCaF7HU69nFzwDW7Ly4SpOjTnvSH8P87rWaA7LPP
2BZVtuPiUDIL37jb7LdwYDoI4ciPepyNK3s0zsJ0Hz8sEDjKUum4rjmBShZO1ngBh2djIJIw
U/S0bbo+/CuvPn90BrOt8WK6GJgvkfwjSQn/Iv62jjdzXL0MH18al9cfjHC3Wswj4wnpY7ZG
+LQfL+bLkeGYgfdK/Rh+Uz9mpdgB+9wclrKAz3TmEfYDrn2Em2nqDfbKmOx37CeW+BJOV8gR
vModRhOAVgxvhZUWA2dchClWmUfa5EEwNmdPSrLVZsoephy4F0lLhsY/96vkMzzdlkkkYxtu
16Z3eM5eN6WmkO5aPkHaTvv5O4X0OK6I0hPOKeMqQfY5ZRKlj0Vvd8syQfZcM76Ly9OVIeZv
4yief0UW1utfkJRHJU65ub40LONFgnmZ9SxpBrb//2l2/i/S7Kjadw4D5Den2QFQ2H5wEKEf
UT3hK4qYR3Cg/gkEP+cQsiRPWFEnSLfHdSNRBpbHIVl0+Sfr2YDUym4zj3akaUfGu7v3BtUx
nPvvNyHp192O00tkJGSOnrAVlSD7PNmyBVyMXLP7ln2CtPqsXoE78MFhchGVEGSgfOxVRp0k
zTj6XHrDaqqlIUuzcTGhY3pHmRxWnFXkjhmNWzDmz+OmUKlayfRVXvwdWnX/yKbHNs2x9Cr7
gW9BxRtcJAh3hqUXctSJijmVPs03u334aLxP0kghrwDi3ob0w0Zl+9HYaNbz6tiKGZqm881i
eb/R8L4lrPb4+3i30yvYl67sgF7fD8gOW+pVLo+ywrRiGEw2qydqC40pEK5zClP8bbcJdZ5A
2KfwbLcPOUtgutJsz8Jpx79NNbwl7A71QhMb59PVCThYe9fUXbNtmouFSQRHfasm+Z2agDvo
XazuZR10z4AGVP9Zv5jZ5qBsZcxvV5snBM8tJf4XbhRUszrmUV4lmpj2a87Zzuazcb6ZkFLC
zaCrb3G0V1mSkfgDBS+Qrp5/uFMmx3mGu1nN9Z4fOOwU2jFt2YV3eTF4a16+SXPAMBUtyZ6R
1EhRSCEbKO7JkLohu2y904FkQ5u1QLX2ulw9Lfnenw6Vh2MkVc9ZjrISLR34zuHbHsCSrHZa
M+il+kfjuxyOUnUOjUI6tt+ivq+XSQZv7Qrgcc3LoyHSkBaOUYFz2HsOULfxgsqsqoQgOKz6
pqxyBEOKuMN8NqUv/ilueGtkSvbrkr5d6lfgDb5HQ4tOeqWl8fb67QedSXA0zEqmf3JiGSye
WVlx2Hg2HOLH7+pWaqYoNFKyVOtIb1QqUyRKp669X6wLOeKYwZHCqWEgPTrF7dh8WJL6PLuM
048akxscWjEFprehUmW3MWxolZ9ooU+yFkLt1VV2qmw/7HfrPVHsWQclmYmO38yXh8ky00Ru
71XSNQ5P9RclcUskEAcSvA+/xJkYNyvqvN//SgFodWHV9V5S2dQea2T3Al9tdUrp13W1yiyG
DEYuiibwp3DzOF9+KQEHhzZGAczj5TKkCS6kmksTXx2yWCrEZ6Ex0t0sxCyg0YWsaLoiHWpo
WhN6FeibD3fXn9O8aiqdaSWNbTt2BU2SL+4ynuzvK/GOMM16PN9CrMLb1pHxedc9s6NiOsrs
eJz1LokwM3vOIFOEig8l0BrtP1Jaravbwj408Q9r5oJR+40KTlNVQyI4NPRL3gt31ft9JWLU
38Y2j3KNHksxQ5H9igHKghxHk1ZWq29/v7vKBnxVbToccqBspcoTCM0E+/XfO66XidWyKiyr
Bnadwz+0yxslw/xD5sEUuxw0221x29ngoDKrr0hwx3lF0NfJdI84Wxx++cqwfkmjI67j8Isu
Q3CY3PTiMQ43GHtUnb/OJ9RCKh/kagPdcr2crZ7R4DDQrr4h3M5rLKTO0pgaZ/Fsjv+/hpvt
WVYqTCSgBjKaCc9xJgNnYtJfQs4GpJD9gTeFz5RrTiPP1/uMHxwmY850TEXKVoYFsjSdZUPK
VkCxO+RXzPR5jmtt0v8Lp1ySxbHKZTk01P99Eh3a0JDot69sgqgIVP/G+rGs48VUml00VitQ
riis1pMmL6wN9Ha3OAxVYWnKiVvxfne3/4U1MS2J/8KXEbasSozLfZbtGmTl3KqTgtyaLr6I
bR8u1PJpuSnBLhM45qF9lWqzPMn53+mrrqqWiJ2KrclPCXGxS3MDQlHuNojvsEVNn6UFa7Qq
JFTn/VwgvR5vtzAlWbZlRhW9Y4VhmEMDjhFSBm2yCjMOl2q4gqPSJMzBlhB+LfjYHszBQhz2
ms5pmRVPcLhIPhCi2vTKSWzXP1wsJSSVlkYOdo62IYvJmOsGosYSaOs17ewPIZA75ZdmNtet
TF3enOfZuEe7qdGoDXTXM5Em6nz7fUGqa0PgLzGZFTRxkwHy4/pLtJU/HvkYABe4skzDVGX4
BcazfaSjODyc38SD9Hy+zaF8zuc7buBUV292tho9zjEHbdRuKDZDZ4/77UMWwS8BasSSvenO
pxzgDEfbZJg4XzjgDBaIZ/gAX4KhQRPefAWVPhpYRvwN0ay2I7IFjTDarLbbkSUkNs18j5ah
d2kBAi6q3d31EmSf7oZEabuiJstNnTBAuj3e5iVKh8bsCQ7fCVL0e0rouJJjlS8ibBAs999o
gE7nIQvHGRhHxldzmMSnwPM+LfbqvDiagpHqTHatP2oeKbU5TCrzBQ6uouZ5g4jIGYrKEM6z
LIRzgsY9x0b0cexmhXaxb92IVoFnXTyThBNN0U4L9HEGnBTdQvIsuQStL5MwzQnaaiF5SV6J
FG23QMu07Oiw7BYtpkdkPig7aEaXhGJO0BhKjejjGMwp2m2BPg40nKJbtFgaddlzs6jLCRpe
ek3oknDLKbpFi5XEWU7RLd67JMByipYt0MdZIoCWNCFjQrmPl944noZRHrOtLlq+gnrsClEF
7RTnNiHEJvEm3tK8CiWZfqJXWeJ4hFdFo3Q+Bt8fCzL180qZxVOOKjwofgXd/Ocr4+lhHiEH
Q7jcGgucQ+xIlRrr5dqAzE5KppHgow9wQUYaXXCTg68CvzsfJCPij4twaFIQU14pf2bvzjEd
kZ7szfntViP0MVVcXZ5fGO8vqNp+mX/l7eT9Lj3UJA2/UPtsWl1HxcS+j2NlrIzvVuD5GxFd
Xn0qtIjx4vq3j1e3t7/ffHypF4/2T4q3+ireal285PTSJ3U/aacVx3h6WgzdYT4DSHURhuNs
0rukczH/TC24ZpcrfU4WQ21cSce16gwK+K2gE1VkM+O0rMXY+wmrqJufj1l1jaOyDxfTAiSs
1bk6FeseLmNaeocEVhuOJYEV0jukuDZL31QD6MXrJK0udx+QHAvj2jirUzmtt2cP8+kZkQy0
fwcR1eiQ9N+v15cGD1Y1flWMXXoIVerqhLLN2yWes6QkNiNjsb3PYjeDJAjYk4qrdrxeRGPI
YNAIsO1zCzVsHMWsJRjN3EkUB47lenNh3GGjFi4jWjDXNPvh2Trarr9s9Gitjs6ErAgq1Cwy
/SpP8Yf9chpvJqvHXcnijKYhDpyYBYEfqfNa7CnTEkLoz2Ex8dvVR6yWsjC6N2/Hb979fvXx
w4ePv3Kw3lVE6+RZuJg/ftexmGm1MpDZMtE12GtLDFMYpIvkCK2sqsBjH/Fs+bDNeAy/18Dc
AuyduDi/aQeUBeDdxYdmGPalu93SsNJlRW6Oep6jIgWcwOJbjkYj04AWNC7GYbSe44fB1bvz
30zv7Tl3zLdxGp73IeYhQ0VEmzkiyutE0msiSn+rRki0ILEQDFInaRUFpWSgZV3R95KYaM+q
X4nz/m4X9cvql2gC22+qFlTpZValpDTiJEIm1U6o4muqEJs2/rZm/DkNsYn/XP7b4xicNn7l
x1R68RlTq2iI5TeKdZtbVWSxkViumxPY2Xq9moADNLL7ePIYbwZpHJ7ZyJH+lqeK8cPTBi4a
OoUlWlPEuzGvmwtweUKnddMalTpVq0s9dXNE4Hte8EzVYA9pIcFRJU/ruhmN5VjZferTKsfS
qbw2d8GqK4dIpOO53farSipHkJbqGEyhrHKIRnqtO56yUNLOOzKewjlGVbZ5ynyB+9wasgPh
dYxOVFJDTuA9o/s4OY2v7J2Taii16YY6nWwcquH2C/vMkD5VkamPZirFlIbh7NSvRaZAmcQy
23TG6pnKHtJi2esYDKakvXzzdEtAuHmDYZuuYzipUp7AEpzS4Hk8ztAknfF8eZyhJRAo6/k8
Qjgq5u0zeRDbpOO+eymPYwuOBfxcHheBGk+0l3QezzE9rwceH2GnTmx3v0ATBI3651ZpCd34
wvxFRmkAmyu08Flm31j8jTK4AsPibwQ/yakNDMFP+vx34OJ7aeFvfPb4s53z2yb/bQFLvyKs
P2Os1LCe9o2bMESZrTdLpIKEMT5Hbv7+fgCDHKvd+3gZ4zyOo6abzlt7ZAv/aoj9bdJQOBuf
pRZ+suEf4mR1BmdYWuKceb5GG3DEhkZatapOsqdgIV6AJMXwr+PNhhbdg3QxSWWQLQXfhdvz
m3fGzfvfR8b5zbWxp6UUTjPFfw/ItP3HCgemrwyHpopvnP6F7wrRN0gc4Zmka43V19kjuzlt
CsyezvzwpIhXM2O6WoTzpbFem7w9gIIsJymoQCAbCMLoC87VK/FBkwDW4H69r8TDa60Wv/2+
rQA7PN8s4vk4S4Jqjiyvbl8NMFcEVbBuW7pMZkMbl5LxiNbubrzIts1MM71mzhQcK3+7ng+Q
TIf+VTnd9+v143fjaxTlt9RfJdlYVR6yTXy/fwwzWwBUvoWbDPXSYK9kgfwSWMvkUCkw7Sbb
KeGOfv1d5Yd9WK2+jIzraRyuw6nxRv3KuMKJLi74ZAzSMlV8Pd7aSZ/nu1S4rb5bLYspe6hp
EgnPMklnQ5Wy58IM8P2nmwthms5Bxp589GKKp6rjM368mmW8/3hpZE7WWxxJ/6CRuz+MdCyq
Pd/QLOyrS7XHOTJ+QGKSHzJUYDnYXSk0lnVaY5E+wyqiY/clwTzH7/LOA1KFayt/czBgzVD+
5pZZeHMre3Vpm4IjxUvTGm8X6EVaKU6tzATlBVMVtOuwI0LPrSO8u7k0/oUgDEnQ/xiqNltp
M4Fv1hK8R4Yp1YA3F9dGltgkY3AC9teKZvfSFEhA8S5J+xatFmtMBwNSXp+HLqaxmBpnxmnP
trwlm3WG7xw3Ad70Ga8rfNz+UW7CGoHx45agtIrgLCgTIafTmeOH8SyI4tD/McfTq9ml+KcY
iYw8KzL5dDAMJ9NoFjiTqRniEMj0Il84cjqxZES2vM4Y4G79LNx/GyeTX/4Co+TqXJ42Dne6
Dt5yOJ2UzpF6ETCO88pMnt6tFF2BKkN5Ngd8xEzMZ0+71T566MMsADPmpTbM5ZaBhqo1DkgL
mXYyG62/rQtqYDCbzLxZNLMGgRfNBk4s4kHohd7AmoQTGU1i25uQABOOX5IdKyEz24vVessJ
qsA53sUx8vOsV0scYOFXf+B3f77UhAhkMm88TKMDKSZUOeHEjwcBSUBShGIQuq4YTK3IdSae
8Gdwb6iVAqTlBQdmkIbAGW/C9eN4gTgdN++cPJBJEkhgqIH4hrIGUulJRkmiULYmitZLAeu0
xMJsKgDdlsD98gjqtZWXrJ0M6MvAP1Hj4tAI4n68+DD+yjl5x0mFItMsfh4kP782M1Dg2Hzs
BdDTdJd9SAUN1VEoKcRfDfpVZtd8UnkhX3uv8PWb87ur1/B5Mc2XGrWKPHJMrZ0pDI2HmOax
Cc1sr2k5sY0j48Vy9RR+X+1JzIwsMAUr7/3XSB112gN3ZGHaVGL+/umCs8qm8l3n6WAvQjKf
Q+OFbUYwMCJXJw2kSgCMxhtpp0dsBWXHqOkon+zo0RztyIODpQcyb2hF9vEdmV7fwsWc71DR
l9QcyI/MHzfx19fUohPjcbFOv8fH7X6Cn6gVRV6CK3HOUl7CZrUYp9k5U0ewNF3nayvn8Gqk
nOw2u8dx3hwjdnic06Au4N0qfJr2FCyT3Rn9A/kn+/HsCdlDcxI/ODhnakOizouLRNKSldLQ
VDLe/o9BXXK32oWPBj7jiqmGZn/e1u2d9raMwA8CrCNw7BgZGElmqgWJ0x7gG6F0YHLgR2OQ
fsp7HBli8A0oJxBMYNUTSIc9gjaraLx7iDeL8HGsu8mYTr0tCQJcOmog6GqdEa1ntlWyBwo6
kDQj2Ce/kzukgSiD1OF9vItwML3CumdEuunC+KDme1wZSs8wCeNCWektYR01pV3dEgmBX0Ug
mvoCE3D+v83uSQZj7vLpksBu8BRRYPYrqgZ3a0JQ2j6OkmooH5WBmZl9/OgZ/sbTNOgHVj5a
wejxhcgaxrr1sq1VFS2XRTuikqUuEXhCclCX5XS8pV4Wfi3Mq3ZtVQMb1GE717QnAmgB3tC7
ub3hNRhv5v22Mu7Qhf41h1E9X37ZZrZQAeyc+iq0KrNr6/Ft2rbp1GIORYD/LNd44c0mdhw5
1stXOE/IH3mlHDHcQjn1Xfs55dhpOZZPSzLcsVjNBrg0sBrQOw+U68/u/rF1vTCP35ana3MT
O3uvntTcACO5w7NfUbrq6hx1m4dpyFk7O6K9enTnaiFOmJ6nVQuBObJNjUBt9uKYyXcamCoX
OjzhcLNoqy3SgNPjlQ+XJL3gGU0gZZv89cXsxymyPMt0c/bjFF+e7b08+zEwgWm6DR2mXmUL
S3Im3ZQBsToxsS/Jsl7uDPoK1X5hXpIYF58tS0r6wBmFEaRngCU6DqhzOrJkzY506zlMBuzP
79cG729gX+juDhEJ/TAc4X20AlT0gBYFQMLEGRKkWXlUG/GYFj7b12QEwiXyjNZU+v8vWQGO
tsqBrlC0065o+pOgVUEmCjKPyilQ+62pH9a6+F49bfC/rZ1rj1w3cob/ygD7YbNA0uL9YsAB
DHiDDRBnDQT5LMylxxqsLCkayVH+faqK7OnTmiK7yENBMGx46jk1PDx8i0WyKMZCHPnxB/rn
W5oWfrtodS1s9Zubkqiul5GerI3Y+ubml6d7XKzLFwBhJ6U/VHgGz4NV0u0LCa9Hsy+p9L/9
/NNm4g0/LEij2zfPOE69wRqwNXketviSdWHwfzvePnx69xGrzM08JG4ekkutUe4hP//y729+
/vWfP93//qOde1DaPshmwYPi3IPy9kFRCx6U5h6k1fZJWQmelCefpM9Pyp2swuP/nsOtb848
WHc87cn2B4sr/4ox/env//VrOfD3TOsRJ8Qf+nAeIS3oBxbj7ESFuGxx8/nx+JbivKfns4g5
bS2Genefnx5+O+L2mvd1Z94fT7cQV3x684R/AxViozOjHzCP/AF32t7+cfv0nlYEIAR5OD7e
fn3/5XDz35/ofPX/ffz6+aasnT+/5J7vPr/9cPxSnnHz9Ig/dPPhiMnpd0/PL5ri8PPvz28+
P/7j6f37m3fwIijavTzuBo8rWwC2xNgntiMEF1PCk0qnn0BJhn+BUOT4Yfsz+OWcfqaeBj2v
C93dPbj7O2dOu8n/XEp6/XkLwD3YJwAI4g8XgdGPP/7rZaT0Cc/bnvDa3meTz3Ec4rBHbXze
/jjMI9RDvjenH/fQOlhwdNp9BFi1zH3CWbH7KWk66voNE4Hv7jch5cPAicjKSU3O0HlIj4la
Z9q0X3/5659eDmBvbWzbph/agTHd7N4w5k5h3kZ9PJ/CLAgsSilDlEMsJuOpFXOBEHtRzqnd
K6wdpC8QWYqoh9Vwmfk87iMClzVFiJeTmRBpnkdlQrR71fXjmRUhbU7NnNmrCGlzbg9qfoeQ
Nid3WrMgMMyXIZgjmxVhpIhmW+BGMhmC2iKaqL7v4LjTRYTgTnBWhPSNbI9xxkuE9I1wZzkL
Iko7OHegkxAxtDs4DVB1K93JJKvocrtDn0dIvDNBMkgCkHRvcui29x/fb5zLVE5trwwgJ7Sb
dlAGYEbmfbvHvTrEtxlV1cvRwO/GWJgdBdV+Day0oI1uf399aQFjKnS1Q1oQoaXDKS8thJB+
vLy0EKLdRyTSggizT1oIsU9aCCFtC15aCCFtC15aEGHFusAOp4QQ6wIrLYSQyiwvLYSQDuq8
tBBCPKg328KJB3VWWggh7Vq8tBBCrJGstAACc7RD0mK96nxWE9JivTPt9zEmLTb0PhW5tACn
872MSgueP27/hnPS4nLodEFeWtCm3WGuSIvLyUmHkIa0IEI8qPPSAggv9oKXFkRIB7KGtCBC
KrMNaUGEWBd4aUGEWBf4IQQQ4vlCQ1oQIR0LG9KCCOlY2JAWROyUFkRI30hDWhAhfSMNaQFE
lL6RhrQgQtrBG9KCCLE68dLicrbt5mSlJZTLNtdJS7AqtX0Yk5bgeoItl5bgeiPYqLTEsF5a
YrSdGIuXFrDpyNEVacEDKvsSYoiw0lGoIS10smWftCBCPP3ipQURYl3gpQUR4lQULy2IkMbI
DWkBhDhGbkgLIsS6wA+niBCnonhpQYRYF9ptIdWFhrQgYuesBRDiXGtDWhCxc9aCCOkbaUhL
jFfTKt9LSyqlA9dJS8o5tX0YkxaYg3VyhHJpQY4k6yf7DbNzeaSa0/PX50/HDw/bmlBEoQ9w
mHJZFKqCuteifj0//cKMrjq6ZsY8LvcrofLFMtPFRwsQ171a8GrNzArp1rNmlYmO8+ktpFtO
TKRNCJG3SVGny8JmBRLknmz1yV14ErqlYSUKhZVMu11DolEI6V5lKVEphMhfcUOnaPYhhzTb
JHW/Mrbypk/nypsFkuWvuKFWCJF7wtXhRIhX/QvHJYqFEHm332iWPmlWOChle7HMRKCOTKwm
PRKoF5s0t7xAxkGLo2wmUK+IPcsLFSFe/GYC9YoQr1Awg2FFiKNsJlCvCHGUzQTqBWHECRym
e1fEnkC9IvYE6hWxJ1CviD05oIrYkwOqiD05oIoQx/pMoF4Q4gUfbtiriD0r1wURR3JAaBJ8
V09HQ3VERqv2lGK37z5+eYHp6LJk75HYOx1zJ+E3MJFAVnb7JxKVs2giATSrfSexOid91vhO
1pmXPrSZW/4g4yhfNeClDxDiZHtD+hCxJ0dVEWIB5qUPEeLtUrz0IWJPjqoi9ix/FIQ42d6Q
PkTsWf6oiD3LHxUhVs92W+yUPkSId1y122Kn9AEi7ZQ+RIhXUHjpsya5NoKVPud7gdiEtLig
OoPkmLS4GHcspagtJy/atBXwokTf2Sw1Jy1B+c5r4KUFbdo9/4q0BAhQxCMyLy2AEGfKG9KC
iD2btipiz37ggti1H7gixIvzvLQgYs+mrYoQz+14aQHErpX1itgpLYjYOatCxJ5NWwUhXxZv
toV8WZyXFkSI1y6abSGW2Ya0BJU6GslKS7R079I6aYlOdWLZMWnBcoDzG8DUltOR3FFpSTCK
tH/DOWlJyVzbyf1KWtBmWlpScvJDHry0JLyJZJ+0IGLPUZOK2CktgBAPpw1pQcSe/cAVIVYn
fghBhFideGlBhHhBmh9OESE+rcJLCyDkc6dmW4gH9Ya0IEI8qDfbopMvEUkLnivcs2mrIsTT
L15aUuptEeCkRSvdO802Li1aGd1pzCFp0crmToZdLC3I6WSnB6VFa99T4ylp0TrETgqelRa0
6ex46ksLGGd5KoqVFkLskxZC7JMWQuw5alIR4mCflRZEiMdCXloIIX0jvLQQQixwrLQQQpyK
YodTQoinHKy0EEI85Wi3xZ5NWxWxZ9NWQcizWay0EEK8kNNsi50JMa2jujZAfS8tptS3alYD
5ffg3NqLd4A1G3p1j/lhhrbP2AtIkENOAw1eYKu3ED3gCf95IcSLIefLbNN2sDGlqpYUwg83
CBnwhO9YJtElrVJIs02s3JPzoHN8vL14Ozh7lEL4YQchWQ5ptgmOoFLI6fbb+/MenALJ8jZp
DD4m0TYJKaTVJnTLnhTSahM6Gy+FsHtwtMlelCAQh6oQR3TCwrFQ1Rrdyb/KQ1XgdEL40VDV
Wd+Zrs6Fqnixy+C2Je1gKJ0ruEHGZue2JUSIN8k0QlVE7Nu2RAhxtMuHqojYGaoCQnxQoqEd
iNiXBSHEviwIIfZlQRAhPhXZ0AxE7Cm4URF7Cm5UxL61W0LsW7tFhPyIQrMt5EcU+FDVeduZ
EbKhqoewrP3UCWkB9d5xkvlSWkDEOwlDubQEvIF4mbRE2zvKPyct0ffmbLy0gE1uv7or0hKD
kZ9H5qUFEPL8Ay8tgBBPVRvSAojO+r5IWgCR95yKJoTtVAgTSQsgxGLfkBZE7JQWQIj35Tak
BRH7dsQSYmcWBBDiXaANaUHEnlpOFbFTWgCxq+BGRexLsAPCd87ss9KSle8sOk1IS4aPbtG2
IFAEj6uDTw+/3wb39unz//xwYzOVH7y7vf/HM91pA0P58/HCpH8AqN7m8e2x/tlY0tmBeiXr
E96bc/1hdFZg4C7K01NPV1J+70U0ytvuYZ2W/2g5eCX5NWfS6U7TYWfQcvAe5WvOZJOinnqz
aDl4kW7fmYgb8ELqnu7inSHL6MbuL73mjLYhzvSZYjl4meo1Z2DCEk33PFPLGbSMa1+TdS6a
iT5TLOPKTzsenEvRdM9rtpxByzx2c/c1Z7yHbjj1msCSShwvcyYfnNeKXZLRrhXnen18OIcB
hNCai2dYBBPnFgSr4SyCiXMLgt1IxiI2ce4pDCgINn/FIUqc6xWdgnUbhGFjOxbBxHYFwR5I
YBFMPFMQ7PIUi2DiXEJYxcV2HIKLcwuCPUjHIlptYdmkFototYVlEzks4pRyj+eUe0Gwa9Ec
gotzC0L8Rrg4lxBO/Ea4OLcgxG+ES7UTwud273wd54JJcJbdUFBMxIe0nD5E6Nd6ICqtJv2j
+uxoWy1P95RLotJiktRCUQdk0vUS+GH/EyZ1FgaCgMxGhdQ9dt1yBq/boGIHq5wxB0V3S4w7
Q5bRLRR1QMKLnxH1Ypn0WmcMBrrjUWmxTC8zsTXOWBtm4vViubYDGwjnFJ19HXcGLVdGpYD0
DjrwlDNgGe3algkuBTP1NaGlXzno2YPyOijJaFHH5m+PRxicf3/+7fl0P1SFxF4tEVl+vJK6
XXgkQ4684HToHVx+lSO/DBVrjpz+OLWhmm53ek3dxiquUC/KuhSqDT39BOrX348X5XmKWexW
PqlmF+V5ql2STHFOZYW2j99AUpKMYt9BvncG3nq0Y/MtferS+uW9mGjC4BTyhRK122AyBm9o
9+7p4S3dLwf/8S9//Y+f/lOFf/sJ2/bl//52/PK23rnz9AHvcHt//IK/J91D/U9WvzEa4rq/
nOG2TJD3fHA2QqQyNkQyzeWSinqy0TfNBZh8cqbTXKWJ1B30zhul8Z/x8ebO0n+e/56hWpaa
6DWTTzB4SypndZspJLzqfHczASYbvbSZ3AGvFBAFe+0KY4VCldj2VRiroNwNh15XGCMzTGwM
Vhg72Q3U9TolVc4VxirEyAthMRXGKsQOlCl7XWHsBJGXn2KWECvEDRQHoza5lKIKiXsqjFWI
HygO9noifYLIXzGTYqmQIC8/xSRZTpCBul6v0ywV0o2UriZaKqQfzbKplk2FsRNE3tmYZEuF
5IHiYK8rjJ0g8s7GJFwKxCh5Z2NSLgjJ0XVr4g2uFBISfrvewCBPyoQDDlt4l6Y4KVNMJvLx
xZLOkYuTMtVkTG/785NwyDA22+4H0/IfLePKyVI8KB1Cnphgk2USRX0Dzhhz9QJjXv/ub8/6
RxxKew1wzhLo1JYTsxrilC/ZKdxZrzecpP0Q5+VjNi9CWDhuyJ/zTv+zFhZOGPKH2VVTOWno
fXGKSJxsxvxhRLFw/BCn6qLexgqFk8wQp9U+OaUhTrN98tjvVQXy7rz9nzi46DXC4TSycoZ+
r61M+guOHvpOOaUsHDP0XXBiSRytrvTnV4sUaGc9HWbo2clFMR600WWvwfCgrOny5aWDsjEu
5gm5JctSSnedMxaPjXQDq5YzaLlyLR6QzprcLSHYdAYtF7eMtyHYqT6D25pX7oYCZHAq6Sln
gtNqcQeO7ko2selMxFrnC3e2eH3IWOrKyePdajIRohXLHAa2xp1MFi61eXMAqQj9KuO8/2SZ
TFzqjNYmTiybFMvs17aMgRDajw+tZBnV4paxRkU1PrQWSwoDFzrjjEv9vFHLGWc8xRQLnfEm
xTQ+YSuW2S/ccwVIGOTTxOyRLCHaWjh7BGTEG/HGFZAsy8Hvhc7A1ChNbBokS11qua9yBkJC
GLvo95OO88VkpjHRUis9kNc4mSwUfUBq5dJEXqZY0tnPhc7AkBRnPhOyzEsHEIg9QXT6ydqW
M2CZV242AaTTIU7sCSLLqJd+sxB7GjXpDFhSpZmFzgQUnYlACy396gEkouhMjQZgSbVWFjqT
QHT6C0otZxLus13bZ/AaVj0RqJBluT1kkTMBQtQcfBrIX1eTPN6YxTKGLB/nq0lcOIAA0ihV
KlEM+w+WdJ3DQmcsTI7SuOgUy7zyqAsgHc5XppwBy9U902uTuss0TWfAMq+M5wGJZ4QnkkjF
cumEFJAR5ytTzkSj1co5ICATiI4ZH83I0i+N5wGZTaKbssedyXgoY2XLWDqrNRHCFculG1ED
hKjQNBSIScf5YtLd/NbwHy3tOQkmGeerycpvFgJh+O4mwiGyjGpwF9Y1Zxz0Lj+eUSRLrVZu
dwWkxyTeeHaiWGa/tmeGSdFBS/hmF84BAYnHHuZaJmpbNj6tcybhxtuJQAUt49qhNdIZhjie
nSiWtIq4zJlEZxgmpl3Fcq0cJzrD0L+Or+UMWC5tmQghakpFOoTjfDWZEM1imUcOCZ1M1v7K
FnRqIm9WLPPKo+uAxN6lx3tmscyDe1qvORMwIzcegZClVitHM0BGXAaaek1R1XtR1zmTQHT0
VMsknOkslGNAZhgHJhSwWC6ddkWL26JmTotXy5VbzQCpQXT6GzxbzoDl0kAFkAZnOhMdmCzX
DnqYy7RD+flqMpGfJ0t3Dick43w1WTm0Quypc5rYOxEp16pWzqciZUzTxGpjtbRrO0O0MH2a
erPRGr2yqELEjGksB2GGnYFmWbqmBsjsLF0VNO4MWC5duYgQe+JujIk+Q5ZRdN+83BntvZ0o
a1Ms3dKoKR0MTOXyRNSEllqv3IkESBtAAcfj+WKZV05IkznAKOPDwKH/ajKRHiyWwQ7stzmZ
LOwMgAwJOtj4HLxY0tUPC52J8EInRrNiufSYMiBT9t6Mj2bFcumh/2RxuX/qNZFltGud0aqO
ScPOgOXSo+2ABEl1elyOi+XSWmqAtBrG+fHZfbH0K+t5ANIZvGl6xhmwtCvjeUB649XEykWx
NCurViRKPKo8sA5bTK4c0eT9J0vzcrhUMs5Xk4VRa6L0ZphYBy+WS7cyJkxS6snGBEuzMiGQ
MEnpw0Q9lWJZcnnrnNFWXTkz2nIGLO3KmQ4gjXV03eW4M2CZ3cKZDiCtzWqiakixNGrhahcg
nYNfcKplwDLEtc54F/PEfhuyTHrp0JoOAWKmiZWLYulX1m3KuOgdNO2oFY7z1WSizxdL++K/
YJyvJn5h+wMywzDQP0zc8h8s/crYLOPSuvMTdbOKZdkEuc4ZbVOaOFlAllmtnOkA0jg7E5sV
S7uyzi0goa2dGo9ai6VfWVoWkO5aLaWmMw4P9K/8miD29H4mi0uWQa3cvQbIgOtE46mGYmlW
Ft0FJHydZqLYYbF0q1a7/h9QSwECHgMUAAAACABFT0RcB628Vi+LAACR6gIAFgAYAAAAAAAB
AAAApIEAAAAAZG1lc2ctY29uZmlnLXJlZG9zLnR4dFVUBQADgl6DaXV4CwABBOgDAAAE6AMA
AFBLBQYAAAAAAQABAFwAAAB/iwAAAAA=

--824c073b30d14b85b56a14ca93aa4655--

