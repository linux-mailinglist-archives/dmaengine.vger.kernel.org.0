Return-Path: <dmaengine+bounces-8528-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GyUDZR6eGnBqAEAu9opvQ
	(envelope-from <dmaengine+bounces-8528-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 09:43:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873739130E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF653019BA8
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534B2C0296;
	Tue, 27 Jan 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW+Rpk7r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA620C023;
	Tue, 27 Jan 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503326; cv=none; b=A4QcuxLNuC3sC6BA8zkfjS6Do5uOIqM3okAAIfFhOT0vQ0PZDkQ99/KtrrhbsC+8uGn2WF9n19A2imahC/QZV/xxPile365D+u9aVqnV90bAruss9HzrvK83BpgNIUWsAR0MOrrzw4EEHoQBL1IAPzwcMPOCc8vDPrEgfJnRptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503326; c=relaxed/simple;
	bh=qidps2Tx7lTSgLV5S9R5cggbG2HZGgVsYm10gEmmsqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0kUZAzrea7M80hUkFjLn7zpRepFEQvcDkM7LBlAQgX0sGS9EjOl0+DN9U1GRneRPWafRQ7Hiftq1BNJH2hozEUQVdkkOlpYNAAtLzArFahdyxSaLqr2bGvz8XZLH0zjHmppi7BpzxSCPXl4PsFtkmq/q5q0jSKMIiEiW9tLM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW+Rpk7r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769503324; x=1801039324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qidps2Tx7lTSgLV5S9R5cggbG2HZGgVsYm10gEmmsqA=;
  b=bW+Rpk7rdCzWuXXSWYpzFWKlEXiVBh8l+mb3DtDPh4z7GlDbiWbtjY2+
   lvfJyqd0zM/LFmzzdY3ZXerp4iqx6DtDa5e7PexmSZAQBt6RCwrAFvr+A
   8fjorRBterU4BgWICnzau4Q+jzD1Pc83Z0egMyGON8QZ3OXqLJ84iA69W
   HF/zlmYIZirwwMFhsTedCABqZu4qGzhTjne0H3U6ms8a70qnpxiBSPcrq
   LRuU/H7FDEuLM3RQhil0JWey7ukIrTSXeJjmm64ehLhMchfaUSQ8BXDxk
   HI9uuJnL2FI9rNmHN+K1QM2tGhK/aJJWDm4GppU36CYDewz48zE4mNUDi
   A==;
X-CSE-ConnectionGUID: g2L6TA0jStaIRryqT0pJ+g==
X-CSE-MsgGUID: /oBih0iuSLaSqyLNfKfcpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80996334"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="80996334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 00:42:04 -0800
X-CSE-ConnectionGUID: wk2UtoB7QVy0dBGh0OSUWQ==
X-CSE-MsgGUID: ePFmdfQDQzuWfz7dHe99/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212029328"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 27 Jan 2026 00:42:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A2A0A98; Tue, 27 Jan 2026 09:42:01 +0100 (CET)
Date: Tue, 27 Jan 2026 09:42:01 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260127084201.GA2275908@black.igk.intel.com>
References: <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
 <20260122110021.GO2275908@black.igk.intel.com>
 <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
 <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
 <20260126135353.GT2275908@black.igk.intel.com>
 <57727c07-33d5-4b52-abe2-4fdc2a7488b6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57727c07-33d5-4b52-abe2-4fdc2a7488b6@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-8528-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 873739130E
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:52:01AM -0500, correctmost wrote:
> On Mon, Jan 26, 2026, at 8:53 AM, Mika Westerberg wrote:
> > On Sat, Jan 24, 2026 at 10:38:14PM -0500, correctmost wrote:
> >> I am seeing mixed results with those i2c config changes, depending on which modules are included in the initramfs image.
> >> 
> >> Build info for both tests:
> >> - Commit c072629f05d7
> >> - CONFIG_I2C_DESIGNWARE_CORE=m
> >> - CONFIG_I2C_DESIGNWARE_PLATFORM=m
> >> 
> >> --> Test 1 - Various i2c modules absent from initramfs
> >> 
> >> Modules:
> >> - drivers/dma/idma64.ko.zst present in initramfs
> >> - drivers/hid/i2c-hid/{i2c-hid-acpi.ko.zst,i2c-hid.ko.zst} absent from initramfs
> >> - drivers/i2c/busses/{i2c-designware-core.ko.zst,i2c-designware-platform.ko.zst,i2c-i801.ko.zst} absent from initramfs
> >> - drivers/i2c/{i2c-mux.ko.zst,i2c-smbus.ko.zst} absent from initramfs
> >> 
> >> Result: The touchpad works, but there are still IRQ #27 messages:
> >
> > And the touchpad is working fine after boot too?
> 
> Yep, the touchpad seems to work fine in my desktop environment after booting and logging in.

Can you do one more experiment?

Add "modprobe.blacklist=idma64" in the command line too (keep everything
else as they are now). Does the touchpad still work and do you still get
the warning? Please share full dmesg.

