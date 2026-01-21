Return-Path: <dmaengine+bounces-8426-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBoEM3PgcGnCaQAAu9opvQ
	(envelope-from <dmaengine+bounces-8426-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:19:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147158505
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B6FF62A4F5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA248C404;
	Wed, 21 Jan 2026 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0QiTXlO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1348A2C1;
	Wed, 21 Jan 2026 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003889; cv=none; b=pT5s3XGATLSC1mn4Jr38SPFglzCXbd6iwPTm5CrIkQ//bG3N6lWaUZgj+9E5tG0JqzlLC8iHaCz+jxGhsnG7uMrBT6UIOWLWZiAosNC3/vLA4ffhO4jH6FgUr/H94rGRHL4CRNFhhjxOz2cTBb80qAB+fd12dHPtt3HoIsHC+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003889; c=relaxed/simple;
	bh=ETt/LN4lbulA9QDwDajQBkQCBJzQt0VC3RtEBaKq0KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoSs6N2YW+PIpYBjg9CjnnYrXAlDmtsKDR4P/uby7oycA5Q/AF4tmmAX/PEm3UusjcoUisZud+NdJKGm+QN9EehwSaZIrO8CdAUoEDjxpej1UsgnqzAn1nKf7CpMxE6eWEd4agu8NgLyvqgXb1Wi8VsiBt3DMWKB4D51cm2NArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0QiTXlO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769003887; x=1800539887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETt/LN4lbulA9QDwDajQBkQCBJzQt0VC3RtEBaKq0KY=;
  b=K0QiTXlOEE00WKAGTViOauoVrbQqm8ok1B9W+p35I/QnDFccSoHmowVB
   PtavCSinzCmdetF5LDm150/uXP7RPeIt5mnkinACT5zJkQ9A2qzhkYNcT
   ArI+mAd5ph6w1mGFRo64j6ONzQfJ56IQNRrBkCzf04236D55Do42IqRUH
   +GZdonoLYGt2HV5cN47pXwI4wSjAX9QBH0z/G4aWYMG238x7PaDejXAXV
   2NxwiqLrANpBur/RnYhGgyLlsWXFKAATqhtZpgdVQ65/wUZABa7Y6JAKI
   aP1Xec4MQLzCfazk2kjHObxXlXSKUP6GSH26hv7IOJEPMXEQwqb6i8FeP
   w==;
X-CSE-ConnectionGUID: /GiPnJT/TMucI9WoaWy5iw==
X-CSE-MsgGUID: QG8ZWZflT06mhErBfOhmPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70323036"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70323036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:58:07 -0800
X-CSE-ConnectionGUID: pclYBALVQlGrOlB3Y+2ZUA==
X-CSE-MsgGUID: HJyw/4FWSYexAKHIiGhoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210960256"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 21 Jan 2026 05:58:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 86A9D99; Wed, 21 Jan 2026 14:58:03 +0100 (CET)
Date: Wed, 21 Jan 2026 14:58:03 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: correctmost <cmlists@sent.com>, dmaengine@vger.kernel.org,
	regressions@lists.linux.dev, vkoul@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260121135803.GM2275908@black.igk.intel.com>
References: <aWUGmfcjWpFJs3-X@smile.fi.intel.com>
 <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXCYwBMTwkHZPYsi@smile.fi.intel.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sent.com,vger.kernel.org,lists.linux.dev,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-8426-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:dkim]
X-Rspamd-Queue-Id: 6147158505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:13:36AM +0200, Andy Shevchenko wrote:
> Mika, do you have any other insights, suggestions, comments?

I have not been following deeply what has been discussed so apologies if
I'm missing something already stated.

My understanding is that some models touchpad does not work if the idma64
driver is loaded but they do work if it is not. Also there is some sort of
interrupt flood coming from somewhere?

When idma64 is not present the toucpad works flawlessly?

Does it works in Windows?

I mean if it works in Windows and we also know it works in Linux without
idma64 then we can go with some sort of quirk (or better yet figure out
what is going on) to keep users touchpads working. I think this is much
better option than asking BIOS update from vendor which there is close to
zero possibility to happen in reality.

