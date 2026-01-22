Return-Path: <dmaengine+bounces-8454-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FGfG+UGcmmvZwAAu9opvQ
	(envelope-from <dmaengine+bounces-8454-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 12:15:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492365D2A
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 12:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D78370307C
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA213D2FE6;
	Thu, 22 Jan 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTvF1jRr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD742DFFE;
	Thu, 22 Jan 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079628; cv=none; b=erS14qEekk9mDr6yVUKYJ69oJK7cxu0uIHLSBZTip6sFpv0QGw6hNicXwwt3ceHSLFvEf3Up9k3zyIEe/bKp4JsiJ+zJVz8kZ/dJt/CPB9z1CLx4V4MO4Ku5XOANFxgbWPmX2z4qkLuON0v5FAp+Uyp+4zquctCs3olPmGwMgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079628; c=relaxed/simple;
	bh=iJSzDSjOLouw8pRYuxyAYFFe9Y8DhZMRz12WUAc0D84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACrIDssPliNbU5JNzM+YJvFQcB+T7Eek/NLLnpuexX4FodrehDuv+EJvg07mGYa/uwq+aolo+n4wJ6z1cLoeEThOTLM74wZr3nawVrCjnrLu6zGzEVmPtlRdwyQ5D38pSFJRo8HqAcp1OJgjgAElnoy0gdSyUvgMGNKNCQyH6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTvF1jRr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769079627; x=1800615627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJSzDSjOLouw8pRYuxyAYFFe9Y8DhZMRz12WUAc0D84=;
  b=iTvF1jRrbaFvRYOFSbbn0sa+tpiCzkCPcPosTgnScUrv8vgVjrsLPJiy
   twt2n34PekuHk+qykws1YBGAfBbsXiolvyXFpSxu8ZwN52MkwYWBYL4YK
   NvMaC/2d5jUbj8XXkh2svld4/HHEyqN0LwmVcai3Zgrj2hGBE25JmGxnP
   QWm5hIkPRYvjoVeSdGX/Y76j6kKHk4h68nQBl600eXF8/xXj5W3K60FrS
   gWsQ7jLpvmnL9aTck6LyUQ8xtrd/waKkzY6MIW3E2It/ZwnyjNGRNRv6E
   IfQwVRYKFAz0v++fVNcKLt/3IIGlZx4YMnUX6OYop9aNCnqIp5n7V6iJq
   Q==;
X-CSE-ConnectionGUID: KLwKtQ55ThiT+6a4viOSlg==
X-CSE-MsgGUID: zWlxG5/CSgKU+GEqERhZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69336470"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="69336470"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:00:26 -0800
X-CSE-ConnectionGUID: iTZLIFYrTg2FvTke9GHdKA==
X-CSE-MsgGUID: GqINrK8pTkGYPwza+Lh+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="207137681"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jan 2026 03:00:23 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 356A295; Thu, 22 Jan 2026 12:00:21 +0100 (CET)
Date: Thu, 22 Jan 2026 12:00:21 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260122110021.GO2275908@black.igk.intel.com>
References: <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
 <aXDuddwBCelAVouQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXDuddwBCelAVouQ@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sent.com,vger.kernel.org,lists.linux.dev,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-8454-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 2492365D2A
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:19:17PM +0200, Andy Shevchenko wrote:
> > Well I mean if touchpads actually worked prior this idma64 commit and now
> > they don't isn't that a regression?
> 
> I don't think so, because commit did the right thing and just revealed an issue
> that was rather hidden. Reverting is not an option.

I now looked at both working and non-working /proc/interrupts and when it
is working there is no interrupt flood at all:

 27:          0          0          0          0       2277          0          0          0          0          0          0          0 IR-IO-APIC   27-fasteoi   idma64.0, i2c_designware.0

This makes me think that perhaps the toucpad is powered off and that causes
the issue until I2C HID probes and resets it. I looked at the ACPI tables
but I did not (yet) find anything that stands out.

I wonder if it was tried to put i2c-designware*.ko and i2c-hid.ko into the
initramfs, and does work it around? I would expect so.

