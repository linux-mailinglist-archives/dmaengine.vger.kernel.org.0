Return-Path: <dmaengine+bounces-8716-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ADYJYJHg2nqkgMAu9opvQ
	(envelope-from <dmaengine+bounces-8716-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 14:20:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C648CE6520
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6931D300A123
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A259239E97;
	Wed,  4 Feb 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEy5rUIq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF222ACEB;
	Wed,  4 Feb 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211199; cv=none; b=FeD79b9MTIRIuDfn3/snoLwRAGPDgb0vCOQ749BDoZlSk5NgCCaArjvEHXpSMsg3SnTN38s1Xd22HoMijq1XgxVYLahhV3TjT4eE9fD7n1bdLSJaT+k+o8Ad2Z8hHGOBujsl/bFSwoK0E9NJiV9GRW1dQ5UdMuMh1CmdMGAu0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211199; c=relaxed/simple;
	bh=SgSxA2J6ja4BxP6/Riq/QHszeWWdPZF8xIlK/0qqK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsK7nMiIKjzcYTm45IaXrSTHD3IS3q7OnR9NqBP5stLExdjyo/kl0IFvBmZzNGoWGHYyc2xzIWpF87SDfFxSRIyCUB+37p2XZC409+QHV59vVYhqfttjgasgEHD9C+CKg1whm4Je0DFoAe84H0HkBGHU0Rp1YCMmPlwHVuYZqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEy5rUIq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770211199; x=1801747199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgSxA2J6ja4BxP6/Riq/QHszeWWdPZF8xIlK/0qqK7E=;
  b=EEy5rUIqIuhRN0p8nKjwVcmvzHCAt0cK8WSg5Ss950IHV5jo0vrUcUtk
   gNsiguhXDqll2JHNqTwRpNW2F53MlCseJcI8BvYpL2b9w1u9TgVXwObT1
   Q3QoxR+97YXc2CZrnNstYvE4Ngu8K63XB3Kf0hwqsyUzNZo5dAv3Jt3cT
   Vgv1evdeaPXEu7XLCeCd2xijKFnbBqhaSBuzJ8kPlEIfIHjkRao9wqkx1
   Xn+4vGevvMro1RQBwb2WJYoo1ABSjqkbfY9eIwb70vcyoKuNz+68fe3W6
   i8oeZf0VAj+8bRMIN6BQS76MGj261zok6TXX7SS6d+/MU9E7ByfTrsufW
   A==;
X-CSE-ConnectionGUID: rjAZDRyzROSjqXhJoMtl1g==
X-CSE-MsgGUID: yrUcYZICQN6Wlhu6+JI17w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96849192"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96849192"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:19:58 -0800
X-CSE-ConnectionGUID: jlegvz9sRfep+AJiTD5eLg==
X-CSE-MsgGUID: KYb1sv/zTG24TXj8Y6BQuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="215141869"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:19:56 -0800
Date: Wed, 4 Feb 2026 15:19:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aYNHeqYYa9ixrksM@smile.fi.intel.com>
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
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed53c66-69e9-45e1-9b89-e3d555ff412c@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8716-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: C648CE6520
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 08:11:27AM -0500, correctmost wrote:
> On Wed, Feb 4, 2026, at 7:31 AM, Mika Westerberg wrote:
> > On Tue, Feb 03, 2026 at 07:39:36AM -0500, correctmost wrote:
> >> On Tue, Feb 3, 2026, at 5:04 AM, Mika Westerberg wrote:
> >> > On Mon, Feb 02, 2026 at 06:16:02AM -0500, correctmost wrote:
> >> >> > Could you drop the above hack again so that it should "fail". Then build
> >> >> > the kernel with CONFIG_PREEMPT_VOLUNTARY=y and add the below hack. Perhaps
> >> >> > this is just lucky timing? Please try a couple of boots and make sure the
> >> >> > results are the same each time.
> >> >> 
> >> >> I cold booted five times and the touchpad did not work during any of those boots.
> >> >
> >> > Thanks!
> >> >
> >> >> I noticed that the "probe with driver" failure reports -22 instead of -110 now:
> >> >> 
> >> >> [   33.023932] i2c_hid_acpi i2c-ELAN06FA:00: Report Descriptor: 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 75 08 95 05 81 03 c0 06 00 ff 09 01 85 0e 09 c5
> >> >> [   33.026070] hid-generic 0018:04F3:327E.0001: item fetching failed at offset 638/675
> >> >> [   33.027573] hid-generic 0018:04F3:327E.0001: probe with driver hid-generic failed with error -22
> >> >> ...
> >> >> [   33.183959] hid-multitouch 0018:04F3:327E.0001: item fetching failed at offset 638/675
> >> >> [   33.183975] hid-multitouch 0018:04F3:327E.0001: probe with driver hid-multitouch failed with error -22
> >> >> 
> >> >
> >> > This is really odd because "item fetching" is not really accessing any
> >> > hardware bus - it just parses the descriptor and the descriptor looks fine
> >> > to me (and this is the same as in case of working run):
> >> >
> >> > Usage Page (Generic Desktop)
> >> > Usage (Generic Desktop.Mouse)
> >> > Collection (1)
> >> >   Report ID (1)
> >> >   Usage (Generic Desktop.Pointer)
> >> >   Collection (0)
> >> >     Usage Page (Button)
> >> >     Usage Minimum (1)
> >> >     Usage Maximum (2)
> >> >     Logical Minimum (0)
> >> >     Logical Maximum (1)
> >> >     Report Size (1)
> >> >     Report Count (2)
> >> >     Input (2)
> >> >     Report Count (6)
> >> >     Input (3)
> >> >     Usage Page (Generic Desktop)
> >> >     Usage (Generic Desktop.X)
> >> >     Usage (Generic Desktop.Y)
> >> >     Logical Minimum (129)
> >> >     Logical Maximum (127)
> >> >     Report Size (8)
> >> >     Report Count (2)
> >> >     Input (6)
> >> >     Report Size (8)
> >> >     Report Count (5)
> >> >     Input (3)
> >> >   End Collection (0)
> >> >   Usage Page (Vendor Defined Page 1)
> >> >   Usage (Vendor Defined Page 1.Vendor Usage 1)
> >> >   Report ID (14)
> >> >   Usage (Vendor Defined Page 1.00c5)
> >> >
> >> > I noticed  you still have:
> >> >
> >> > [    0.069726] Dynamic Preempt: full
> >> >
> >> > Can you change that in .config to:
> >> >
> >> > CONFIG_PREEMPT_VOLUNTARY=y
> >> 
> >> Strange, I did change that config.  Do I need to change another config for it to take effect?
> >
> > Probably not.
> >
> >> CONFIG_PREEMPT_BUILD=y
> >> # CONFIG_PREEMPT_NONE is not set
> >> CONFIG_PREEMPT_VOLUNTARY=y
> >> CONFIG_PREEMPT=y
> >> # CONFIG_PREEMPT_LAZY is not set
> >> CONFIG_PREEMPT_COUNT=y
> >> CONFIG_PREEMPTION=y
> >> CONFIG_PREEMPT_DYNAMIC=y
> >> CONFIG_PREEMPT_RCU=y
> >> CONFIG_PREEMPT_NOTIFIERS=y
> >> # CONFIG_PREEMPT_TRACER is not set
> >> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> >> 
> >> >
> >> > Also let's add on top of everything one more hack patch, just in case ;-)
> >> >
> >> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> >> > index ed90858a27b7..0297ebedb802 100644
> >> > --- a/drivers/i2c/i2c-core-acpi.c
> >> > +++ b/drivers/i2c/i2c-core-acpi.c
> >> > @@ -371,7 +371,7 @@ static const struct acpi_device_id 
> >> > i2c_acpi_force_100khz_device_ids[] = {
> >> >  	 * a 400KHz frequency. The root cause of the issue is not known.
> >> >  	 */
> >> >  	{ "DLL0945", 0 },
> >> > -	{ "ELAN06FA", 0 },
> >> > +//	{ "ELAN06FA", 0 },
> >> >  	{}
> >> >  };
> >> 
> >> The "DSDT uses known not-working I2C bus speed 400000, forcing it to 100000" message is now gone, but the touchpad still doesn't function (full log attached).
> >
> > Thanks again! It still fails in completely unexpected place I wonder if the
> > BPF quirsk somehow could affect it?
> >
> > Could you still try with CONFIG_HID_BPF=n and see if there is any change?
> 
> I applied that config change and saw the same touchpad failure (full log attached).

Just to confirm, after you applied the change, compiled a kernel, the change is
visible in .config in the kernel output folder (by default it's the same where
kernel sources are located for compilation), correct?

-- 
With Best Regards,
Andy Shevchenko



