Return-Path: <dmaengine+bounces-8756-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ9HIQxyhGnI2wMAu9opvQ
	(envelope-from <dmaengine+bounces-8756-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 11:33:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B42F1581
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 11:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576C7304C56C
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F322E03EA;
	Thu,  5 Feb 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2iX2hr8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789D2C859;
	Thu,  5 Feb 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287492; cv=none; b=Jad2HFXtt2yGE5IiQFEecXmPdKlkCqr5rOf/eneSsF8Xc2c75ihMk7kAqVy869mPrk2iECfuJVpR7NHvNx6sUcb4KOzguEBfgA+O0OkXEnHxjARM1cfJonp0rBniAHN6qixMNGHjyfHBMHFzv3cbD8PTPYqHromLxTq/R1EjufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287492; c=relaxed/simple;
	bh=pcP3a+xDAHGsf3sLhLOsCca0XK2h9iK3CBragd6MWUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaWgAzIW1s2EH0GKOrW8sCaNsxJrn+grHx2iajxAk68e2pKeHCMgyRE+rZREC2RTdgjgwU28kvAt7/ZPKXU/HQy0cK4sDwNUTlU9/4HtdGEB6nZmv9CZ4M97vGvTJd53MM/gnboCZM76lHjMv+ty//p0cHpBm+j3qgYW8F0H4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2iX2hr8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770287492; x=1801823492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcP3a+xDAHGsf3sLhLOsCca0XK2h9iK3CBragd6MWUo=;
  b=i2iX2hr8dfiR/aWb9WJsx7pe+/tQ/iangFK7TMkjChgBBsv+mbz7j4BZ
   gHwn836fJfiNQp8hZdNCKgZGC6XP2sy4y2wqrS2vAlsBl03XT7MalmBlb
   b5BLhGI1vVpG8p4qULhNxg67bO2JgY0MbMTueoS41uJuO3jFisp/B3pOj
   4cPWDFvJMp59AH4efgYa0yaidSINTjMYUEVoULMVx3CUMkb+57XaU57C8
   MJGzNEYkgi2Uh04npmlGSY2ioyplRaryIIptaxvykGMYgsKPZXGM4jSrH
   0fbQ8JlPC5/S9PGcPIcHnU1Uhc4lTrHcn3E1i6E0ORz60DMQKkxF4iPyP
   w==;
X-CSE-ConnectionGUID: jVuj7dVQTR60yIYO++3Z2Q==
X-CSE-MsgGUID: MJbKG9k9SvSU0ADwyq3gCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71522758"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71522758"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:31:31 -0800
X-CSE-ConnectionGUID: JuioupECQDCU2SpJ5cCDow==
X-CSE-MsgGUID: WgW1uW91RQaT0EEfdeBWEQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 05 Feb 2026 02:31:30 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4916F95; Thu, 05 Feb 2026 11:31:29 +0100 (CET)
Date: Thu, 5 Feb 2026 11:31:29 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260205103129.GT2275908@black.igk.intel.com>
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
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d13a547-5f4c-4d5b-83e2-3530469d36c1@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-8756-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: D1B42F1581
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:53:57AM -0500, correctmost wrote:
> On Wed, Feb 4, 2026, at 10:34 AM, Mika Westerberg wrote:
> > On Wed, Feb 04, 2026 at 10:12:57AM -0500, correctmost wrote:
> >> > I will try to debug the config issue and retest the touchpad with the 
> >> > proper config changes.
> >> 
> >> After fixing the config issue, I now see "Dynamic Preempt: voluntary" in
> >> the dmesg output.  I also see "# CONFIG_HID_BPF is not set" in
> >> /proc/config.gz.
> >> 
> >> The "probe with driver hid-generic failed with error -22" message is
> >> still present and the touchpad doesn't work (full log attached).
> >
> > Thanks!
> >
> > I don't see any other way than adding even more debug. It really should at
> > least be able to parse the report descriptor as that's exactly the same as
> > in working case but let's try to figure why it fails. Can you add again on
> > top of everything this one:
> 
> The attached log has the added hid debug lines.

Thanks!

I now realized that the dump of the report descriptor truncates it into 64
bytes so it can actually contain whatever crap that the controller read and
this is probably why the HID parser fails. My apologies.

I think at this point there is not much we can do :( You have the
workaround, to put everything in the initramfs (or built into the kernel
image), right? We have asked schematics from Lenovo but there is no
guarantee we get them and I think those are needed to figure out how the
touchpad is connected.

