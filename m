Return-Path: <dmaengine+bounces-8530-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pv8NU+SeGmirAEAu9opvQ
	(envelope-from <dmaengine+bounces-8530-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 11:24:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7892BD6
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1EE301A50A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578D2FF664;
	Tue, 27 Jan 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8ajhHwp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BA337BAA;
	Tue, 27 Jan 2026 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509156; cv=none; b=DZdNycL/5Pues7K3cteMVVg9+54VTjwvyBu83OUU0H79GcCO+psG9RnilbTwnYX40QZ5trtAfBVoq8268LP/rLc9TpBCM+BC80iqhk0ZAROdxND6x5FfaEEyt1Mrmg2qMFTXTpwZwVD2x1W1MTeoVwUKY957B3Q4Xs0elLmg6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509156; c=relaxed/simple;
	bh=4uw6eTeNATXHcMG7atz65R6SekIUdQPnL7QBNyLTlns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWEVoCrRm5Wg5Yy954egeDXRaw0A3lAr+GTHswjuibJCPInjs+ZSDpYOxQfXVC4PXlCD8ws77QOcpPztGC49yNipBg6YJpb00q3kt70RmTeG2aMaeO4hy8nzyqWIOc33vV7C5mTPG0tJDfasF3EFx2StUK+rmjx/Ci53GNqohP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8ajhHwp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769509155; x=1801045155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4uw6eTeNATXHcMG7atz65R6SekIUdQPnL7QBNyLTlns=;
  b=D8ajhHwp7XF9NDyGD42cdhpaCHcBO462OFIoPezql9/wElAKgst+U6Sj
   xBTqqCGZnPfyXNLx2Caj1qNbMVz2d8Iwnb+DdQKWz+SlcGPF7CmPsFMIb
   F29S1+FAgQ0EUQnh5Ts1DcTm4N024D54/Hxu24Q1Rz2/JY1vxGEjtGAF0
   p0wPRTUzisCZiqQRxV1NYuMJLeOOE+gf6i0fJAKAeL82LqL40SLqiInXi
   zkxgvzqLEvldGVDCBd0fZSNVs9sfBzlefTygGx9Y/pIIugMdhxw+OYP+d
   0GzcWPkE9mfuBbsczOqqHqgAaQtTAwsMl2DMg6VmSGhWjgyFPLQzvjIs1
   w==;
X-CSE-ConnectionGUID: tTqSxxcAQ5mQgbgtOkcRTw==
X-CSE-MsgGUID: kfmdL/5pRn+y4mcpRVt5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74545303"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="74545303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:19:15 -0800
X-CSE-ConnectionGUID: i4631S4oRFeUJcM4H1uZPg==
X-CSE-MsgGUID: oAUH24DuRser9usX4+XVTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212402515"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 27 Jan 2026 02:19:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9330498; Tue, 27 Jan 2026 11:19:12 +0100 (CET)
Date: Tue, 27 Jan 2026 11:19:12 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260127101912.GJ2275908@black.igk.intel.com>
References: <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
 <20260122110021.GO2275908@black.igk.intel.com>
 <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
 <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
 <20260126135353.GT2275908@black.igk.intel.com>
 <57727c07-33d5-4b52-abe2-4fdc2a7488b6@app.fastmail.com>
 <20260127084201.GA2275908@black.igk.intel.com>
 <b285137a-06bc-43c2-ab24-b3bacf8592ec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b285137a-06bc-43c2-ab24-b3bacf8592ec@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8530-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,black.igk.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CC7892BD6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:11:48AM -0500, correctmost wrote:
> On Tue, Jan 27, 2026, at 3:42 AM, Mika Westerberg wrote:
> > On Tue, Jan 27, 2026 at 01:52:01AM -0500, correctmost wrote:
> >> On Mon, Jan 26, 2026, at 8:53 AM, Mika Westerberg wrote:
> >> > On Sat, Jan 24, 2026 at 10:38:14PM -0500, correctmost wrote:
> >> >> I am seeing mixed results with those i2c config changes, depending on which modules are included in the initramfs image.
> >> >> 
> >> >> Build info for both tests:
> >> >> - Commit c072629f05d7
> >> >> - CONFIG_I2C_DESIGNWARE_CORE=m
> >> >> - CONFIG_I2C_DESIGNWARE_PLATFORM=m
> >> >> 
> >> >> --> Test 1 - Various i2c modules absent from initramfs
> >> >> 
> >> >> Modules:
> >> >> - drivers/dma/idma64.ko.zst present in initramfs
> >> >> - drivers/hid/i2c-hid/{i2c-hid-acpi.ko.zst,i2c-hid.ko.zst} absent from initramfs
> >> >> - drivers/i2c/busses/{i2c-designware-core.ko.zst,i2c-designware-platform.ko.zst,i2c-i801.ko.zst} absent from initramfs
> >> >> - drivers/i2c/{i2c-mux.ko.zst,i2c-smbus.ko.zst} absent from initramfs
> >> >> 
> >> >> Result: The touchpad works, but there are still IRQ #27 messages:
> >> >
> >> > And the touchpad is working fine after boot too?
> >> 
> >> Yep, the touchpad seems to work fine in my desktop environment after booting and logging in.
> >
> > Can you do one more experiment?
> >
> > Add "modprobe.blacklist=idma64" in the command line too (keep everything
> > else as they are now). Does the touchpad still work and do you still get
> > the warning? Please share full dmesg.
> 
> Test 1 - modprobe.blacklist=idma64
> 
> The IRQ warning is present and the touchpad still works, but I think that's because the idma64 module is still loaded (the full log is attached):
> 
> intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> idma64 idma64.0: Found Intel integrated DMA 64-bit
> intel-lpss 0000:00:15.3: enabling device (0004 -> 0006)
> idma64 idma64.1: Found Intel integrated DMA 64-bit

Okay can you set CONFIG_INTEL_IDMA64=n in .config? That should prevent it
from loading. Keep the rest as it was.

