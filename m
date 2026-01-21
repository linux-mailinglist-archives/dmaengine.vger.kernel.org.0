Return-Path: <dmaengine+bounces-8429-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNcZJ8YNcWlEcgAAu9opvQ
	(envelope-from <dmaengine+bounces-8429-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:32:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 320435A934
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E62BA8BFC7
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE674C900B;
	Wed, 21 Jan 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db1fv9Sv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6824C77D7;
	Wed, 21 Jan 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008763; cv=none; b=RwWWdLU+Ei5Ae2Alk3Gu3jhAa4jO8erIYTtqLhAQ7dtdlmBiS6kuRDNr/GWT8Te/kIco63djseQV8xjJfxMXkNBymSKoQqdEvbU8x3R7IML/miJn2wxJ8OBhv3wwIOI9OLmmJttCH8ak4QF4gcmd16zFUqQfcQkLtG5AN+wvAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008763; c=relaxed/simple;
	bh=1+YSusSEMkMAiteRU+8FWU3WXTOqPIoC9SA8+ckckPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOmyo66PO7krr3eIgy7YjLrhlJeHBMgV2UHSO34sGqTK5FwEqIM+VzN54LRyCpramBrZTJWsRxDV/u6VyAy6a8hTYfXKhdn6bmjN7xsFrrYWjuxJOBOnvLZGQr/rpU3MH7G1PWQxXgPY8oyCJi7AO+RogHyqQfHxg6KMDxn7J04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db1fv9Sv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769008761; x=1800544761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1+YSusSEMkMAiteRU+8FWU3WXTOqPIoC9SA8+ckckPE=;
  b=db1fv9SvDRze8zmO6vEMUtfatje6yVBeVhu58uZ7+bgAOgEx3T9OuV/E
   DKgVPpw65pCVlUZOy61TeEkwvyf3O7G50qAwrGfhlysK2kJKW6CE/Xj02
   b4F/Io4UIkEp9M9JZxwdYFBxQvFVplQHfCMfEKpFpdrvZel7hGUaP7ABr
   oCqep96B3TJtBtWHqXYvlvgy+FVNsal5f0jTLr+ABxLSzJHvwHBwZ4DoG
   8UhUSYeKr3KPDfSkPe3EgmaZdQg4cpAFIWCIzkzATkRfL6aNK54PwvSbo
   95igVpOnYiVFansa8qNTbKe+h6O3x7hYX4TvK+WaKmrdtszAe6rdFXmMI
   g==;
X-CSE-ConnectionGUID: lCqfYnuvSzaC705L0bxUGA==
X-CSE-MsgGUID: w2pvlh73Tp+G725++hXlmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74090987"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74090987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:19:20 -0800
X-CSE-ConnectionGUID: g0jgJXSxRPGgyjpSQGDc/w==
X-CSE-MsgGUID: pH4uvPkMSuK1JGNxQzZGQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="244047150"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:19:20 -0800
Date: Wed, 21 Jan 2026 17:19:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXDuddwBCelAVouQ@smile.fi.intel.com>
References: <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
 <20260121135803.GM2275908@black.igk.intel.com>
 <aXDos20kksml8wdU@smile.fi.intel.com>
 <20260121150256.GN2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121150256.GN2275908@black.igk.intel.com>
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
	TAGGED_FROM(0.00)[bounces-8429-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 320435A934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 04:02:56PM +0100, Mika Westerberg wrote:
> On Wed, Jan 21, 2026 at 04:54:43PM +0200, Andy Shevchenko wrote:
> > > My understanding is that some models touchpad does not work if the idma64
> > > driver is loaded but they do work if it is not. Also there is some sort of
> > > interrupt flood coming from somewhere?
> > > 
> > > When idma64 is not present the toucpad works flawlessly?
> > 
> > On *old* kernels where idma64 blindly acknowledges all the interrupts.
> > Fixed idma64 doesn't affect the IRQ storm because it's just a given
> > fact on these laptops.
> > 
> > > Does it works in Windows?
> > > 
> > > I mean if it works in Windows and we also know it works in Linux without
> > > idma64 then we can go with some sort of quirk (or better yet figure out
> > > what is going on) to keep users touchpads working. I think this is much
> > > better option than asking BIOS update from vendor which there is close to
> > > zero possibility to happen in reality.
> > 
> > What kind of a quirk? Just to create a module that will request the same IRQ
> > and always acknowledges it? Sounds to me like a heavily papering over solution
> > TBH. (Yes, I assume it may be used only on DMI based enumeration only on the
> > affected models, but still...)
> 
> Well I mean if touchpads actually worked prior this idma64 commit and now
> they don't isn't that a regression?

I don't think so, because commit did the right thing and just revealed an issue
that was rather hidden. Reverting is not an option.

> After that one commit touchpads don't
> work anymore. I would much rather make sure users devices keep functional
> even if it turns out to be hack of some sort.

It's one of the ugliest hacks I ever seen. I really don't want to go this way.
In any case, the problem is with interrupts coming from I²C controller. You can
consider adding that hack into there which sounds at least much better place
than idma64.c which has nothing to do with all this.

> For example could be blacklist idma64? Does that help?

No, it won't.

> Yes the interrupt flood still happens but if that does not affect the
> toucpad then that's still better than non-functional touchpad IMO.

So, the only "best" option I see is to add a quirk module (somewhere in PDx86
area) that just registers an interrupt handler to acknowledge it. Very weird.

-- 
With Best Regards,
Andy Shevchenko



