Return-Path: <dmaengine+bounces-8428-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJfDJPD2cGmgbAAAu9opvQ
	(envelope-from <dmaengine+bounces-8428-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:55:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D259852
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECB4AACC6FE
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273E4A2E3E;
	Wed, 21 Jan 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKxq75Qv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AB4219EB;
	Wed, 21 Jan 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007781; cv=none; b=PcGsA+PK30myZtmRccPJlv9VLGy9GJuaBqbVhIX4QdJJZHbEKpDjpldA+wpso4GheOeG+ROfIOrlPa+95fqQMJbaGSH2EcMhXk94NTjGyiC93xMjAejzN9L2hq1lrF4r4mRnXNoejfTDE/jiwl1NxROqs6lfosVrM/rj7u8T8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007781; c=relaxed/simple;
	bh=k/52MAuKJbrBuSyrs5H+Q9hMy67Ed/TF7faby/5XgKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2vg7Y6nCfockFK3ua6mfWekgkbPwdiMWAkUIsmJPoXEY+W1xJJybDZl1+kWGo5ig8XTT1IlINZtG8U4jlQLIip4IfmPdp0+vfAPJ2hTknrAmug9aMAT4vg7rDnaYnyEiPMFoZBxt27kEa+cioa6m5cbwXD9dq/yNF10VaZl3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKxq75Qv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769007778; x=1800543778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/52MAuKJbrBuSyrs5H+Q9hMy67Ed/TF7faby/5XgKg=;
  b=PKxq75QvnkUxwBcxSl+N9GaIo4uP9wfNAnR9vc8HHb/FirdbI6oSy7lM
   Bfv4hgYcDHYW2OUO3R3XKn2VXdiLbgYd+3mz0YGHca3ZZGqjriUxJRu0j
   OGKXow2AEks9Rn0ntdnRsJ89IDAVTP7Bw8rHi5ozpOzEGBw/AqfqKKw0Y
   o8whrEnxwb42WykRs506cbS3QE293tVKZE/pwMir+EmTjfV8Lmt56sVmy
   /TbHF9c957hSmPrsdGu1ubYqv7NMwc/JJm4HP2zp0eKFgBum/+p4j/N4K
   VUVENGNw+sYuEVzA5KNM4i4pFln4B+3GlCCIGJoFxkDm2HT29ZNTGAmuE
   g==;
X-CSE-ConnectionGUID: d3wSyzQyR4KniKRIKbMdsA==
X-CSE-MsgGUID: C+VqtlfeS2uWjOOaaahPow==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74088336"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74088336"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:02:58 -0800
X-CSE-ConnectionGUID: vm+gj4XUTOSuk3PgsDDZ4g==
X-CSE-MsgGUID: 48fw+G5NRmyx/kAw4I/UNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229438060"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jan 2026 07:02:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B263999; Wed, 21 Jan 2026 16:02:56 +0100 (CET)
Date: Wed, 21 Jan 2026 16:02:56 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260121150256.GN2275908@black.igk.intel.com>
References: <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXDos20kksml8wdU@smile.fi.intel.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sent.com,vger.kernel.org,lists.linux.dev,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-8428-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim]
X-Rspamd-Queue-Id: D18D259852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 04:54:43PM +0200, Andy Shevchenko wrote:
> > My understanding is that some models touchpad does not work if the idma64
> > driver is loaded but they do work if it is not. Also there is some sort of
> > interrupt flood coming from somewhere?
> > 
> > When idma64 is not present the toucpad works flawlessly?
> 
> On *old* kernels where idma64 blindly acknowledges all the interrupts.
> Fixed idma64 doesn't affect the IRQ storm because it's just a given
> fact on these laptops.
> 
> > Does it works in Windows?
> > 
> > I mean if it works in Windows and we also know it works in Linux without
> > idma64 then we can go with some sort of quirk (or better yet figure out
> > what is going on) to keep users touchpads working. I think this is much
> > better option than asking BIOS update from vendor which there is close to
> > zero possibility to happen in reality.
> 
> What kind of a quirk? Just to create a module that will request the same IRQ
> and always acknowledges it? Sounds to me like a heavily papering over solution
> TBH. (Yes, I assume it may be used only on DMI based enumeration only on the
> affected models, but still...)

Well I mean if touchpads actually worked prior this idma64 commit and now
they don't isn't that a regression? After that one commit touchpads don't
work anymore. I would much rather make sure users devices keep functional
even if it turns out to be hack of some sort. For example could be
blacklist idma64? Does that help?

Yes the interrupt flood still happens but if that does not affect the
toucpad then that's still better than non-functional touchpad IMO.

