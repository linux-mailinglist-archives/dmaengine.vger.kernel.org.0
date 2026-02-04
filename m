Return-Path: <dmaengine+bounces-8717-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FKsMcFRg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8717-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:03:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B3E6CDF
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4FCF300C7D5
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDF22127A;
	Wed,  4 Feb 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Z9b9lqXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKNNYcCn"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496954723;
	Wed,  4 Feb 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213682; cv=none; b=pzm2eo9aSRO13iYJg0IyRypHheevZAJ9dLC80s/+MUWDjW4sAseM8gZZyip7r0jaGAocNneUOzO88DPd97zTSfXuNUuRGEK4jF+fPyiQQ4fqpYMUfoAbEk6ZhamODEVBHwPab+R4xTSaUgKy5MH459s4UYVhSE0fTwvrJv2EdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213682; c=relaxed/simple;
	bh=cxCoQUgyB5uFoNXencSaKrrHlbF28CImoCVBhUEYQjY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t1tgwyFXrackqcIjBHkJ5HV/H+e5Er76cYTtDWehG/dzqrcOsavIdn0iMzh2Hqnor2Quo3Ze6T+5Jq8GrWUusHWRVwytfMyXiUku16kmnwc4/C4t5eGO/r/iCI8fXNd8OcdzjvPrD6/Hq/QU/s7iidWUyjde+5c3dpmE23+QkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Z9b9lqXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKNNYcCn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AC927A0160;
	Wed,  4 Feb 2026 09:01:21 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 09:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770213681;
	 x=1770300081; bh=qv4GIpt/eGZa57JuRvpIe4Hk8AHNwetxeVikP31gzg4=; b=
	Z9b9lqXIcLvtAFqXmLL6eyv4VETuPAKF3A7G+xX7+XWP9wp6sqMOCkKwNDlCu9o/
	47t4c4xKk/ODsXAu2h2ParX6wEyS0YqQiUuwBk+0lFAkiT+ikHmEdQnunwhqLiWp
	IgkX5QfqTwStpZcsva1wOswqgXhOaYfJoLzyHHaAPKnF1jaz8xBUVYOKzy7Fv8JQ
	aMaMsIld4kXVKW+pDjb1+KbJb3zFeXnSTwHNQOoZ+NvS5gT8rHUFCCQysqMZCc0Y
	uV/Ux6SAhfyP8dugGrfUsd9nw0WLS/5lmxNf94wUAMWh3cShsJpXzT7t7AN7Zd8p
	FfetV2WXwo9L9CgPgbcnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770213681; x=
	1770300081; bh=qv4GIpt/eGZa57JuRvpIe4Hk8AHNwetxeVikP31gzg4=; b=k
	KNNYcCn4W9pTJqFNdeev6mkc4Q4GIcUZsaS8XUvMFsCZacDcMW7e4m1wwHl2PRex
	G1SH851yltp2ZgPFZgFFDUCMLWmaE/2IrDplUkWwqxg8XzaEfVoOLPsjcWEwO0cf
	YHGH/ifgBWbJs7U3XTL/hLkIs6GIwAiZ4QrEspCGSf/IgxQCjXaAjT84aBiQD6mV
	FbEZpxD1WD7xgNd2wa3DugH3FndhwdsEDV2FOxWn+gddOcVHlh0xpM0SmhT+p2oF
	M8jI2OYiNENuzMs9LdUXf6xkVsgKdNm8nevyJeLwYmxC3u3X3Cp+/VSZWo03GEr/
	N0ho5pkVtbWylC7Hx3zPw==
X-ME-Sender: <xms:MVGDafAK3Iza7Jb0gkeOeuYUR2QrLcn6lC9L0Pe6rqo1E-3AHqZ2GQ>
    <xme:MVGDaQUcU7wRVoP4KYxBzxdgCY8HUGINYoZCSPhMT1G4ALfKtSLqyXRvpI7dvoVY8
    2HCqJ1ZvjZ_G8PhlcOkksqa2Fqy4hYZucViO6VkzedF6DoBi8cssAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedviedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MVGDaUqhxoG3BOSkoOen_5dleyaDF7-HlSXIzzzKBfVrO2yDXI1GoA>
    <xmx:MVGDaUuIAOX3rJiLmCakfYDf9Q2a-YRKUo3f6jVcBoEg-z7GRzBChg>
    <xmx:MVGDaZHFqx6z6Rv15cNh3gietaOIvFy6mMN0RNNLnXh1fnoqyQk2ZQ>
    <xmx:MVGDadZfuNBN11g1tX56J-T6Vcw177hxbewtnGrxi9upuoWLJEad0Q>
    <xmx:MVGDabLiwEF5-HUso4YmW3glUiOu10IftddhWUStW0mo0-GqFzDuXONV>
Feedback-ID: i87314915:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C111B6006E; Wed,  4 Feb 2026 09:01:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwebR64VcaZc
Date: Wed, 04 Feb 2026 09:01:00 -0500
From: correctmost <cmlists@sent.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 dmaengine@vger.kernel.org, regressions@lists.linux.dev, vkoul@kernel.org,
 linux-i2c@vger.kernel.org
Message-Id: <e7a0d992-ed5c-4435-b567-e0b873360a48@app.fastmail.com>
In-Reply-To: <aYNHeqYYa9ixrksM@smile.fi.intel.com>
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
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work when idma64
 is present in initramfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sent.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8717-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[sent.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmlists@sent.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[sent.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sent.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 871B3E6CDF
X-Rspamd-Action: no action

On Wed, Feb 4, 2026, at 8:19 AM, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 08:11:27AM -0500, correctmost wrote:
>> On Wed, Feb 4, 2026, at 7:31 AM, Mika Westerberg wrote:
>> > On Tue, Feb 03, 2026 at 07:39:36AM -0500, correctmost wrote:
>> >> On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
>> >> > On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
>> >> >> > Could you drop the above hack again so that it should "fail". Then build
>> >> >> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
>> >> >> > this is just lucky timing? Please try a couple of boots and make sure the
>> >> >> > results are the same each time.
>> >> >> 
>> >> >> I cold booted five times and the touchpad did not work during any of those boots.
>> >> >
>> >> > Thanks!
>> >> >
>> >> >> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
>> >> >> 
>> >> >> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
>> >> >> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> >> >> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
>> >> >> ...
>> >> >> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
>> >> >> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
>> >> >> 
>> >> >
>> >> > This is really odd because "item fetching" is not really accessing any
>> >> > hardware bus - it just parses the descriptor and the descriptor looks fine
>> >> > to me (and this is the same as in case of working run):
>> >> >
>> >> > Usage Page (Generic Desktop)
>> >> > Usage (Generic Desktop.Mouse)
>> >> > Collection (1)
>> >> >   Report ID (1)
>> >> >   Usage (Generic Desktop.Pointer)
>> >> >   Collection (0)
>> >> >     Usage Page (Button)
>> >> >     Usage Minimum (1)
>> >> >     Usage Maximum (2)
>> >> >     Logical Minimum (0)
>> >> >     Logical Maximum (1)
>> >> >     Report Size (1)
>> >> >     Report Count (2)
>> >> >     Input (2)
>> >> >     Report Count (6)
>> >> >     Input (3)
>> >> >     Usage Page (Generic Desktop)
>> >> >     Usage (Generic Desktop.X)
>> >> >     Usage (Generic Desktop.Y)
>> >> >     Logical Minimum (129)
>> >> >     Logical Maximum (127)
>> >> >     Report Size (8)
>> >> >     Report Count (2)
>> >> >     Input (6)
>> >> >     Report Size (8)
>> >> >     Report Count (5)
>> >> >     Input (3)
>> >> >   End Collection (0)
>> >> >   Usage Page (Vendor Defined Page 1)
>> >> >   Usage (Vendor Defined Page 1.Vendor Usage 1)
>> >> >   Report ID (14)
>> >> >   Usage (Vendor Defined Page 1.00c5)
>> >> >
>> >> > I noticed  you still have:
>> >> >
>> >> > [    0.069726] Dynamic Preempt: full
>> >> >
>> >> > Can you change that in .config to:
>> >> >
>> >> > CONFIG_PREEMPT_VOLUNTARY=y
>> >> 
>> >> Strange, I did change that config.  Do I need to change another config for it to take effect?
>> >
>> > Probably not.
>> >
>> >> CONFIG_PREEMPT_BUILD=y
>> >> # CONFIG_PREEMPT_NONE is not set
>> >> CONFIG_PREEMPT_VOLUNTARY=y
>> >> CONFIG_PREEMPT=y
>> >> # CONFIG_PREEMPT_LAZY is not set
>> >> CONFIG_PREEMPT_COUNT=y
>> >> CONFIG_PREEMPTION=y
>> >> CONFIG_PREEMPT_DYNAMIC=y
>> >> CONFIG_PREEMPT_RCU=y
>> >> CONFIG_PREEMPT_NOTIFIERS=y
>> >> # CONFIG_PREEMPT_TRACER is not set
>> >> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
>> >> 
>> >> >
>> >> > Also let's add on top of everything one more hack patch, just in case ;-)
>> >> >
>> >> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> >> > index ed90858a27b7..0297ebedb802 100644
>> >> > --- a/drivers/i2c/i2c-core-acpi.c
>> >> > +++ b/drivers/i2c/i2c-core-acpi.c
>> >> > @@ -371,7 +371,7 @@ static const struct acpi_device_id 
>> >> > i2c_acpi_force_100khz_device_ids[] = {
>> >> >  	 * a 400KHz frequency. The root cause of the issue is not known.
>> >> >  	 */
>> >> >  	{ "DLL0945", 0 },
>> >> > -	{ "ELAN06FA", 0 },
>> >> > +//	{ "ELAN06FA", 0 },
>> >> >  	{}
>> >> >  };
>> >> 
>> >> The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).
>> >
>> > Thanks again! It still fails in completely unexpected place I wonder if the
>> > BPF quirsk somehow could affect it?
>> >
>> > Could you still try with CONFIG_HID_BPF=n and see if there is any change?
>> 
>> I applied that config change and saw the same touchpad failure (full log attached).
>
> Just to confirm, after you applied the change, compiled a kernel, the change is
> visible in .config in the kernel output folder (by default it's the same where
> kernel sources are located for compilation), correct?

Sorry, the CONFIG_HID_BPF=n and CONFIG_PREEMPT_VOLUNTARY=y changes are not visible in /proc/config.gz.  The CONFIG_PCI_DEBUG=y and CONFIG_LOG_BUF_SHIFT=24 changes are visible, though, which is why I thought my process for applying config changes was working okay.

I will try to debug the config issue and retest the touchpad with the proper config changes.

