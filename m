Return-Path: <dmaengine+bounces-8460-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHQHB+0Wc2mwsAAAu9opvQ
	(envelope-from <dmaengine+bounces-8460-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 07:36:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE6710CA
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 07:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1AF300E5ED
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jan 2026 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BD32ED3C;
	Fri, 23 Jan 2026 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5HHOy5S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AD3112C1;
	Fri, 23 Jan 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150186; cv=none; b=rrpK7/xvsNa2H6qXeOn3LVEmHuilxw29B90wdFVWN36yxe2/OJq0twkjBLqbLIm6TlqmpkClBpxlprhL470CiIu8weCH26tRjo/Qpa5mz19woqGNBVuA0qzojg9y68knYcD26sMZuDZuquRNhrkyFxw6C4F7oy0gsOSxy+QlRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150186; c=relaxed/simple;
	bh=m8Uzyh3MRWYmNRd5LZIWnm3aGcvRJjfy+JkFJkChTAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajvBcbnh1AhIiR+SaeltGNvZ+/mHmqnsjme9U4t5eEs9A3Il8SpfXPhhOHIgr8opx2PktzNKAUTQ6qNqwhKv0Af2I1AJ9q46+47bgQvpWl1szsn502DDyULfRicq8zApzmM6r+SK4LyUmQNgjpwd+if0G/8JP6b1G/Stqm7foZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5HHOy5S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769150184; x=1800686184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8Uzyh3MRWYmNRd5LZIWnm3aGcvRJjfy+JkFJkChTAE=;
  b=O5HHOy5S8tPA/dOSJsJeDimWm1GSEXFkAlRPHlmUCjPVBngcF0LnLrNS
   1Ni9b+QTU0CH8eor72mddK5m6vyax6zDSTwrGpWsvF0nCmQi4Tavy8JLw
   z00t3oKgmRDCIwsmUGcz5QWvrxKApRNAZMf78BaWKZzwpvNK41efdE15E
   tIf/M/AhQgMh5XW792yHl/w9pLzFGcO27TnJTCCWhzf9XPO0/SquVJpK1
   mTOiatcLASA5sTbooulWl5ei6cP+Q3G1oUFDan25HbQYp6V20uDlxqfOd
   hBhzla+TIeBS/XHSyxc+sNep1CJbHxUGvBk1IlIQK8n+j4ki6W+fnSC1L
   w==;
X-CSE-ConnectionGUID: 8t4fIzg1Rr2Wb464Zap8HA==
X-CSE-MsgGUID: Q+JPhvrZSte62QZ3m3T5Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81772363"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="81772363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 22:36:24 -0800
X-CSE-ConnectionGUID: 4eG0LOGLR/2bt5BD0p3LFg==
X-CSE-MsgGUID: lxib6WJ3RFixgpnShOPxNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="211454639"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 22 Jan 2026 22:36:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5BE9D95; Fri, 23 Jan 2026 07:36:21 +0100 (CET)
Date: Fri, 23 Jan 2026 07:36:21 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260123063621.GP2275908@black.igk.intel.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6474592-87db-4fdc-958c-8b09d324df1e@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-8460-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 89BE6710CA
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
> 
> $ grep -i i2c /proc/modules 
> i2c_i801 40960 0 - Live 0x0000000000000000
> i2c_smbus 20480 1 i2c_i801, Live 0x0000000000000000
> i2c_mux 16384 1 i2c_i801, Live 0x0000000000000000
> i2c_hid_acpi 12288 0 - Live 0x0000000000000000
> i2c_hid 45056 1 i2c_hid_acpi, Live 0x0000000000000000
> i2c_algo_bit 24576 2 xe,i915, Live 0x0000000000000000

Well it must be there. This is from your working log:

[   27.686842] input: ELAN06FA:00 04F3:327E Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input6
[   27.689119] input: ELAN06FA:00 04F3:327E Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-13/i2c-ELAN06FA:00/0018:04F3:327E.0001/input/input8
[   27.691257] hid-generic 0018:04F3:327E.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN06FA:00 04F3:327E] on i2c-ELAN06FA:00

I suspect you have it built-in to the kernel image and that's why it does
not show in the module listing. Can you change that to m:

CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m

and put to the initramfs? Does that make it work?

