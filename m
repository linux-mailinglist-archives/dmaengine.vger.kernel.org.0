Return-Path: <dmaengine+bounces-8461-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLrGIWIbc2mwsAAAu9opvQ
	(envelope-from <dmaengine+bounces-8461-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 07:55:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21F713D0
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30A7A300F249
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EC34A3DC;
	Fri, 23 Jan 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNik+zHF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44B33D6D6;
	Fri, 23 Jan 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151239; cv=none; b=nffUHA97bWUWWsKPjQLe4svwQw5F2meUL62FFM+wY5nD8IUMFVvlcltY3EYliMVbZiu4MjsWjF+7XBypAaHibGK7hnLYPaau7j9hr6lZUyLdcutpLjqe7HgN8aN9vtZI9laax8aH0RYoESLVb4uhWUNV+MTKDXCFFGXZnXpD5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151239; c=relaxed/simple;
	bh=42gUiI1ZqYMbUsEspGleDV/f+8xy3ciRajpf+AzMI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V82Pjn4q41mVrWDQejNUM8XTnfFLXLJs/i9SFAZ1Kl1wzeGloiEUCBl8uEhtc9gFB9awY4qI/72TWSAaDjjWJbbvwMp2uChIQnQdzBC5nkPT59XjSXxiytXXoUpCYCrC93m1bYy477OakPxRPj2ZnlpGh2Ui5dUqYQ3bjYKGG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNik+zHF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769151236; x=1800687236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=42gUiI1ZqYMbUsEspGleDV/f+8xy3ciRajpf+AzMI1k=;
  b=ZNik+zHFV1oeSnyDtxmJDvOK2SvHJGG1fzgiCF2MsNYht3HvG7FhYMSq
   1Z6NRoFP7Gsn2+dZkfHQqoULHByxMEbMgKWdFgr0UBc8ONA4C90qV7mSI
   sLYMQCSbM9zC6+z0oHewoVfIhN+6O0LN0V9zLownnvbMh7JP75APqCVg1
   w4JZByufXKYlZF+r/DZ0dKyWUEYG042hNDGvW4SC0WI77iubzAmlV/7JO
   O0VtHC9IT/1ma/YWIOgVuJqYVv0eF2ZORXVV2IXQ/ld5ZLkGCaXzb4j45
   myk4dSICorKMv+8aqygmnAq2hg0Zd9tj2pAXP+g96Zow4CTZa7T/mUGuO
   A==;
X-CSE-ConnectionGUID: XT9gKCHGRQ65EtMXxAa4Aw==
X-CSE-MsgGUID: cC0qo8dASbGzinfMliupaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70462645"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70462645"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:53:54 -0800
X-CSE-ConnectionGUID: 11HnK7FxSCWEVttt57MoJw==
X-CSE-MsgGUID: b8zPJSN7StCmBtbv1A3NsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206066158"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:53:52 -0800
Date: Fri, 23 Jan 2026 08:53:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXMa_VH0j1BzonCV@smile.fi.intel.com>
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
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8461-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sent.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA21F713D0
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 05:29:38PM -0500, correctmost wrote:
> On Thu, Jan 22, 2026, at 6:00 AM, Mika Westerberg wrote:
> > On Wed, Jan 21, 2026 at 05:19:17PM +0200, Andy Shevchenko wrote:
> >> > Well I mean if touchpads actually worked prior this idma64 commit and now
> >> > they don't isn't that a regression?
> >> 
> >> I don't think so, because commit did the right thing and just revealed an issue
> >> that was rather hidden. Reverting is not an option.
> >
> > I now looked at both working and non-working /proc/interrupts and when it
> > is working there is no interrupt flood at all:
> >
> >  27:          0          0          0          0       2277          0  
> >         0          0          0          0          0          0 
> > IR-IO-APIC   27-fasteoi   idma64.0, i2c_designware.0
> >
> > This makes me think that perhaps the toucpad is powered off and that causes
> > the issue until I2C HID probes and resets it. I looked at the ACPI tables
> > but I did not (yet) find anything that stands out.
> >
> > I wonder if it was tried to put i2c-designware*.ko and i2c-hid.ko into the
> > initramfs, and does work it around? I would expect so.
> 
> I don't see an i2c-designware module loaded when my touchpad works:

It's most likely built-in. This is the requirement when kernel wants to support
some of the (old) Intel hardware. If you see it in `cat /proc/interrupts`, or
in the output of `lspci -nk`, it's there.

> $ grep -i i2c /proc/modules 
> i2c_i801 40960 0 - Live 0x0000000000000000
> i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
> i2c_mux 16384 1 i2c_i801, Live 0x0000000000000000
> i2c_hid_acpi 12288 0 - Live 0x0000000000000000
> i2c_hid 45056 1 i2c_hid_acpi, Live 0x0000000000000000
> i2c_algo_bit 24576 2 xe,i915, Live 0x0000000000000000
> 
> I tried adding all of the following modules to my initramfs image and I still
> encountered the touchpad failure:
> 
> drivers/dma/idma64.ko.zst
> drivers/hid/i2c-hid/i2c-hid-acpi.ko.zst
> drivers/hid/i2c-hid/i2c-hid.ko.zst
> drivers/i2c/i2c-mux.ko.zst
> drivers/i2c/i2c-smbus.ko.zst
> drivers/i2c/busses/i2c-i801.ko.zst
> drivers/mfd/intel-lpss.ko.zst
> drivers/mfd/intel-lpss-pci.ko.zst
> 
> (The drivers/i2c/algos/i2c-algo-bit.ko.zst module was already present in
> the working image, so I didn't have to add it.)

-- 
With Best Regards,
Andy Shevchenko



