Return-Path: <dmaengine+bounces-8427-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LKEEGMEcWmgbAAAu9opvQ
	(envelope-from <dmaengine+bounces-8427-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:52:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B185A2AC
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A84E880F3FC
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73648C8A2;
	Wed, 21 Jan 2026 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQiVtyV0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2B28C2DD;
	Wed, 21 Jan 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007289; cv=none; b=f4DdiEfAZkadwAoHrISVM7cm60ZcVyyEWJ81LMaXkh1G8+AW4YnmRla/5aNuAINg7FOGNiFIqv1pdAl72B2ziwqjFzVSYv4nrueIcphR90rj1KEfS2kwKX6Rz4a444flSOpc+itRoDmzncYMRUULBExbpycLp15gu23M2DvWSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007289; c=relaxed/simple;
	bh=TtJbgAS3RZvTUfXWgLfXcl1lJjZkUvw7gHtxoPWX4kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/zKsbHVaneJgaBCZOVw4jxooE5zEZxfVaJZmju6xpiz31qwx/t22T6ZsKvPGxIog2NztmD9HvAxmY3qApaBTys91WIhqZVLrWdbxh9K3C5WMND/Vi3RzwqImhl3CEPJukpo8uWh8Xq8wBcR33K1S2yVh3IMRUFtX0b5+PJH9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQiVtyV0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769007288; x=1800543288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtJbgAS3RZvTUfXWgLfXcl1lJjZkUvw7gHtxoPWX4kU=;
  b=LQiVtyV08SNe8Sx4W9/3zQ+m8b82aZkbbwW0gzIw5ZDKWBZ6aBI4rrMv
   HQmfy2Z32fUVZwzps00zGazygNSy2W8Px89KlPKx4zqrMPYMO+g5cF3rr
   EzzPJGvQiTyHcJnD2Sx30d0VcOrWJIcvjn1ZJejKa85HKogogkspXVLt6
   YViniFYrBA1VKtTrSoHkpRziUzJSn+ccRuEcs5iU6hL+jlqAswad7y2f5
   0QI+i1v+pS0PBMCWiQgcF/ZC3DdI4nJKJtvXjgpBJy0VWmBmTBKv34CFX
   lsNPY5vNNMueKFV6Ey/cRgnMtlEXUH/PR7falejCDFC7d5cTh83TIBRI5
   w==;
X-CSE-ConnectionGUID: KP6Cmeg6T7yD7DbyrVo6Dw==
X-CSE-MsgGUID: uBimkR6yT9uclcKul+gIww==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74087506"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74087506"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 06:54:47 -0800
X-CSE-ConnectionGUID: pcdePdZLRmK51nZ+edY2rw==
X-CSE-MsgGUID: dfjkX4hxQFyFryZvU7TudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229434356"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 06:54:45 -0800
Date: Wed, 21 Jan 2026 16:54:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXDos20kksml8wdU@smile.fi.intel.com>
References: <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121135803.GM2275908@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sent.com,vger.kernel.org,lists.linux.dev,kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-8427-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C2B185A2AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 02:58:03PM +0100, Mika Westerberg wrote:
> On Wed, Jan 21, 2026 at 11:13:36AM +0200, Andy Shevchenko wrote:
> > Mika, do you have any other insights, suggestions, comments?
> 
> I have not been following deeply what has been discussed so apologies if
> I'm missing something already stated.

Thanks for chiming in!

> My understanding is that some models touchpad does not work if the idma64
> driver is loaded but they do work if it is not. Also there is some sort of
> interrupt flood coming from somewhere?
> 
> When idma64 is not present the toucpad works flawlessly?

On *old* kernels where idma64 blindly acknowledges all the interrupts.
Fixed idma64 doesn't affect the IRQ storm because it's just a given
fact on these laptops.

> Does it works in Windows?
> 
> I mean if it works in Windows and we also know it works in Linux without
> idma64 then we can go with some sort of quirk (or better yet figure out
> what is going on) to keep users touchpads working. I think this is much
> better option than asking BIOS update from vendor which there is close to
> zero possibility to happen in reality.

What kind of a quirk? Just to create a module that will request the same IRQ
and always acknowledges it? Sounds to me like a heavily papering over solution
TBH. (Yes, I assume it may be used only on DMI based enumeration only on the
affected models, but still...)


-- 
With Best Regards,
Andy Shevchenko



