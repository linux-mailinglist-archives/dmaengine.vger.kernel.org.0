Return-Path: <dmaengine+bounces-8714-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPP7Kpg8g2ngjwMAu9opvQ
	(envelope-from <dmaengine+bounces-8714-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 13:33:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13120E5D6C
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0546301BC31
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9D3F0759;
	Wed,  4 Feb 2026 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW+JXJqW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0333344B;
	Wed,  4 Feb 2026 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208271; cv=none; b=M538q9bTpYD5LWlGW861BESUuFhnGA1JSiZ8V1THO/6By/DNQ0c6dM7s8k+MvNbHvOF5oAv2195NvMOYBeN/lcshJPA1p2ZliwWeDyDBMiosk1qj550b0cSCdHYXsmu6QchuqhJLAGF4rYEqrzMmqxzkcski6NSsaqbjdmedQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208271; c=relaxed/simple;
	bh=rLAcu+ulBxj8TqYakwEhskbVYCF68qpui+jojYzCD6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjnCZDdp6BumEk8sqC+QYH72e1Ey/5Fbv3zxzX4nGGejB9Cs2x3JF12MnUrz1YYipVlrfbJdd9MsJHpRr9+xmWT3FqMHB4CwgxxaW8363Omf5USB4DEsIWfY0xFrTpMZnOyCqNFrZvG4pSI4NfHCygdDEBJo3ftaCXDHrE0D6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW+JXJqW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770208271; x=1801744271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLAcu+ulBxj8TqYakwEhskbVYCF68qpui+jojYzCD6Q=;
  b=NW+JXJqWVxrIDVnyDf1p6mwSY4vh+Is+j1uGnrJRMnvJ4UbmiqBQZqq/
   GDhjr28To00gTQyzecwrJY0k6kBzgrOgaWvAv+7d7EflBRp6O4DeWBvJZ
   1VODDAe3PbMS64WErUzTUpgva1IsRslaUm4nkCQGTa+b/WrC5KL6o/5OV
   r0jWIjiajvp4H6WarZqLpREP7HIp8pkFBLkXMjPAH9K7L45Ggxbs4nxhk
   uNDVWJkyTlIVTDQQ17OEAqxDZfupb0iD3Q0U3J9Y9tCdmox06U8ZLhUxR
   575l80tTRdGrzWiOjcNrPaMU0Q+mv6EOC7ktyC6Px7oVP506WrkF6sZP9
   w==;
X-CSE-ConnectionGUID: zOwl2hNAQnycw2AGB2jblw==
X-CSE-MsgGUID: fMYjZsoJR8SD8Njaq+Nvhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71426841"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71426841"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 04:31:10 -0800
X-CSE-ConnectionGUID: XbPJoQ+KSyifeE8htG6Uhw==
X-CSE-MsgGUID: 3ibdJ50gSvKBCc4AGDOClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209254745"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2026 04:31:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A85C195; Wed, 04 Feb 2026 13:31:07 +0100 (CET)
Date: Wed, 4 Feb 2026 13:31:07 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260204123107.GN2275908@black.igk.intel.com>
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
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d134f4f-f7f4-4972-9adb-6d10ede5c1bb@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8714-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13120E5D6C
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:39:36AM -0500, correctmost wrote:
> On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
> > On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
> >> > Could you drop the above hack again so that it should "fail". Then build
> >> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
> >> > this is just lucky timing? Please try a couple of boots and make sure the
> >> > results are the same each time.
> >> 
> >> I cold booted five times and the touchpad did not work during any of those boots.
> >
> > Thanks!
> >
> >> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
> >> 
> >> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
> >> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
> >> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
> >> ...
> >> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
> >> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
> >> 
> >
> > This is really odd because "item fetching" is not really accessing any
> > hardware bus - it just parses the descriptor and the descriptor looks fine
> > to me (and this is the same as in case of working run):
> >
> > Usage Page (Generic Desktop)
> > Usage (Generic Desktop.Mouse)
> > Collection (1)
> >   Report ID (1)
> >   Usage (Generic Desktop.Pointer)
> >   Collection (0)
> >     Usage Page (Button)
> >     Usage Minimum (1)
> >     Usage Maximum (2)
> >     Logical Minimum (0)
> >     Logical Maximum (1)
> >     Report Size (1)
> >     Report Count (2)
> >     Input (2)
> >     Report Count (6)
> >     Input (3)
> >     Usage Page (Generic Desktop)
> >     Usage (Generic Desktop.X)
> >     Usage (Generic Desktop.Y)
> >     Logical Minimum (129)
> >     Logical Maximum (127)
> >     Report Size (8)
> >     Report Count (2)
> >     Input (6)
> >     Report Size (8)
> >     Report Count (5)
> >     Input (3)
> >   End Collection (0)
> >   Usage Page (Vendor Defined Page 1)
> >   Usage (Vendor Defined Page 1.Vendor Usage 1)
> >   Report ID (14)
> >   Usage (Vendor Defined Page 1.00c5)
> >
> > I noticed  you still have:
> >
> > [    0.069726] Dynamic Preempt: full
> >
> > Can you change that in .config to:
> >
> > CONFIG_PREEMPT_VOLUNTARY=y
> 
> Strange, I did change that config.  Do I need to change another config for it to take effect?

Probably not.

> CONFIG_PREEMPT_BUILD=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> CONFIG_PREEMPT=y
> # CONFIG_PREEMPT_LAZY is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> 
> >
> > Also let's add on top of everything one more hack patch, just in case ;-)
> >
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index ed90858a27b7..0297ebedb802 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -371,7 +371,7 @@ static const struct acpi_device_id 
> > i2c_acpi_force_100khz_device_ids[] = {
> >  	 * a 400KHz frequency. The root cause of the issue is not known.
> >  	 */
> >  	{ "DLL0945", 0 },
> > -	{ "ELAN06FA", 0 },
> > +//	{ "ELAN06FA", 0 },
> >  	{}
> >  };
> 
> The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).

Thanks again! It still fails in completely unexpected place I wonder if the
BPF quirsk somehow could affect it?

Could you still try with CONFIG_HID_BPF=n and see if there is any change?

