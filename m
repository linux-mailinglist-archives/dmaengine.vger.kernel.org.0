Return-Path: <dmaengine+bounces-8539-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMh8GGfieGkztwEAu9opvQ
	(envelope-from <dmaengine+bounces-8539-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 17:05:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7897623
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CF5F3072BD4
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D632860B;
	Tue, 27 Jan 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDacxiz9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25035CB7E;
	Tue, 27 Jan 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526574; cv=none; b=UzJK0rmOPWOOLt6o4FrTMDGn0RS+5StQ7AcTIyZIOjf37qEtrJufBJdNW0LLVkGbXXS7KmJ0qTrOLSXFpUp/xtvTz160KJQ4WdeTKZEhNrGpIwWTzhOU9dhaCCiwgeYeTVtjF9qOvtS/SBQyhW6PdxnwxIRw9QTCTyFZx+hIpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526574; c=relaxed/simple;
	bh=l6MXp60odRBYxNQsyCcgzadItXrr5jiugzsoSFXfN/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjOj6Zwap+3F0ipHB9YXIVFIptexvmB+TznTU5j2jaqeXs5P6K43v03gjsVOBbY7/bxVL0QOzK+Tnmo9ZeX742aF80Wi++i+HgIoOWB4+w/facadkOIEjufdqZzPAibbaWNdZPlqFBk3TrQB6MB71cJmid1vy4VwYDAU0EU80lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDacxiz9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769526573; x=1801062573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l6MXp60odRBYxNQsyCcgzadItXrr5jiugzsoSFXfN/4=;
  b=KDacxiz9FWivQjEJM6v0zf39TvI7RBS/CNnwsFy776Vhv/r+K8Q9jQLS
   eAtn26PhxgezERgWv5N/zVCb86KE62e2QPaMy48vxOu7hY+NZY7jKB1ib
   q3cJhaBFTpw+7HVDLsm3Su/iaiZ7H91Nbk9KblIFw1qn1lL1Ho5iN0PbN
   SssmTotVzy96d2wCWILNttsoDBx5vRM9et1ebgoPtmQ8fZ5iEQ1hXOqOW
   AE+ZMOkYZgaSMWtZolU/Swy1X6LIfxUHlAN7Ug/rgfsVIW594VBL2bSr5
   VOGfCFKBbP499OVBbsShy1yaoloiYk+OIFaUoJpd/wRFgdTT4UYI70GYQ
   A==;
X-CSE-ConnectionGUID: VBCr5KRqT42AynT6fI17PA==
X-CSE-MsgGUID: gt2C4UO8Qs6o9snfS4OmDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="96189314"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="96189314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 07:09:22 -0800
X-CSE-ConnectionGUID: Clr8MPhzQXa4KHaExIpsLg==
X-CSE-MsgGUID: I/tFTgRpQJuAxW+dJaJraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207240877"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 07:09:21 -0800
Date: Tue, 27 Jan 2026 17:09:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXjVHocwkflAnKw2@smile.fi.intel.com>
References: <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
 <20260123063621.GP2275908@black.igk.intel.com>
 <5c5645eb-66b8-4419-a4e9-ba2672af2f40@app.fastmail.com>
 <20260126135353.GT2275908@black.igk.intel.com>
 <57727c07-33d5-4b52-abe2-4fdc2a7488b6@app.fastmail.com>
 <20260127084201.GA2275908@black.igk.intel.com>
 <b285137a-06bc-43c2-ab24-b3bacf8592ec@app.fastmail.com>
 <20260127101912.GJ2275908@black.igk.intel.com>
 <3d78d3cf-bebd-4bdb-8dca-3024dd769f76@app.fastmail.com>
 <20260127144357.GL2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127144357.GL2275908@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sent.com,vger.kernel.org,lists.linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-8539-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BD7897623
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:43:57PM +0100, Mika Westerberg wrote:
> On Tue, Jan 27, 2026 at 05:56:37AM -0500, correctmost wrote:

...

> > > Okay can you set CONFIG_INTEL_IDMA64=n in .config? That should prevent it
> > > from loading. Keep the rest as it was.
> > 
> > That change makes the IRQ message go away and the touchpad seems to work
> > fine in my desktop environment (log attached).
> > 
> > These are the config changes that I tested with:
> > - CONFIG_I2C_DESIGNWARE_CORE=m
> > - CONFIG_I2C_DESIGNWARE_PLATFORM=m
> > - CONFIG_INTEL_IDMA64=n
> 
> Okay thanks it looks good to me too.
> 
> I tried to go through the datasheets again but could not figure why the
> LPSS I2C IP would keep the interrupt asserted.

We can try to dig something internally, but it's another story.

> However, I think we can
> hack^Hwork this around by simply not creating the IDMA64 device at all for
> I2C. This should be fine to do because I2C is really not using DMA in the
> first place so this is kind of just wasting "memory". So something like
> below.
> 
> Please re-enable CONFIG_INTEL_IDMA64=m and the rest and try if this makes
> it work without the irq splat. And if it does please try with the
> "original" arch setup and see if that works too (keeping the patch applied
> of course).
> 
> Andy, what's your thoughts on this?

Fun fact, that I was thinking about the similar approach as in "don't enumerate
DMA for I²C LPSS controllers" a few hours ago (and for the record, sometime ago
but I don't remember why that time).

So I'm fine, but we need to put also a big comment with the reference to this
discussion or so.

...

Btw, do we have an i2c alert interrupt here? Might be it's somehow related?

-- 
With Best Regards,
Andy Shevchenko



