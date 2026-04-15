Return-Path: <dmaengine+bounces-10017-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rS3XLicZ32ktOwAAu9opvQ
	(envelope-from <dmaengine+bounces-10017-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 06:50:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24295400406
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 06:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6658B303E127
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442E2D5926;
	Wed, 15 Apr 2026 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4JWSjNS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92918AFE;
	Wed, 15 Apr 2026 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228571; cv=none; b=BqPJtLFmpYLhvEkGuB9z5sk8xjg9q3vfOSODbRPgc7xN21dTjdYABbqQmw9SrEOn4ETqbkIgukKcerwwLW2oMTLIbDbOJl46frvDSiUKY5qvXy3nSfuTlI5rjzDjX6JZ2MgYAVzKmqyUOGLVtwAuqTMXw9V3alPGt6RwU4/ni8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228571; c=relaxed/simple;
	bh=P9zel4N4vJ/m7EaNlzsfUxdcYvuyDvrGFljiQLe6NfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9eTAK5+Fiqgpm1eapm35yztEy+OOaKd6yFykodANTWxCpyk2v+kPnve5dWAGvPfRLaHX55NRGdbG8q9dXLrrOBWyi4Z2l9Ab+tK0WduZQFGHH5wKewHixlqDvljUTB3z4byiviGeUaEPc1QyAXNVxktocltM0SPcY/j5VPGqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4JWSjNS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776228570; x=1807764570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9zel4N4vJ/m7EaNlzsfUxdcYvuyDvrGFljiQLe6NfM=;
  b=G4JWSjNSE7CaZlNKEh0KucBIAQbZsRmzEwGV4eUMkl8kX9QPtrTDglJk
   axaPUAfE47EkiznpaEreP6JP8LjytGJ570q0l3XN9zlZBIUnaQFbj+OUM
   DWXo1UNUGIU3GcPvr3bLF9KAoobuiv+OWyBz9Q1IlmLQZZscWtDnyxmIs
   Xft6MMydnOpgERRxFvifx3SO0PaqfnpvYRVcVq6z2/+gBMzYl77sRF5qs
   O2S/42sVORxs2I+nUah2W9Ji0oItmUFuMo9cNYYMSsn10k+45qqkoebZl
   m0KYEV9fEMFu7RBbocy8blv9jzzHCZeUcEXuwJb3hK0dJnc2J0TsE1vi+
   A==;
X-CSE-ConnectionGUID: t6tmHgJTS0OfGNpyM+QJsA==
X-CSE-MsgGUID: MgV7DNVqRKygU1PN8XV7UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77220472"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77220472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 21:49:29 -0700
X-CSE-ConnectionGUID: hwmshjR5RR+cptQjVspaiw==
X-CSE-MsgGUID: ZxL9D9PjRPy5uaDr9vjVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225994423"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 21:49:26 -0700
Date: Wed, 15 Apr 2026 07:49:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Message-ID: <ad8Y02LPDO8e8URl@ashevche-desk.local>
References: <20260415032753.6006-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415032753.6006-1-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10017-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 24295400406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:27:53PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
> this single usage.
> 
> Add __counted_by to get extra runtime analysis.
> 
> Apply the exact same treatment to struct hsu_dma and devm_kzalloc().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



