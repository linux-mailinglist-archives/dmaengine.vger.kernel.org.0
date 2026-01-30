Return-Path: <dmaengine+bounces-8590-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHJfCOg+fGkxLgIAu9opvQ
	(envelope-from <dmaengine+bounces-8590-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 06:17:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69897B743B
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 06:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFEE33029AC5
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 05:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE434B404;
	Fri, 30 Jan 2026 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQs4P4cK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AB346777;
	Fri, 30 Jan 2026 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750201; cv=none; b=WUNBp7tHptUv/ei80p7Wthe/9ABuWNwvREm9G5KLSlUPganRr1vRHxyuQHmO0ymvaAPEcPL52vTH3TEZATIsqjVi7iJZKjDmA8zRHf1TImpMW7+up7/R0i79JZ4jw1MJ5MwEBOTff6/6DN6sHUJ04sECQJXQD0R1Qd3NXhp/0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750201; c=relaxed/simple;
	bh=QWzojPpWshSmgsgJ299CJhd8Qzr7Bii0gBjNq20TX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjuCN51QhOwKdHnjvP8LVW4tnzxAs6qn0o5yBNrxJ6VJ7OU23mrzVt1+UBLUcRlyl8+OXIT4OQURfmZIq2qdv5JXhD03bRhGavK0/+9h+AhubSzFjwv9IOmeXUkELej+Czma+eEu8n8edAEpmqpONmwbYWsaZmoI4HO8NF6Kzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQs4P4cK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769750200; x=1801286200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QWzojPpWshSmgsgJ299CJhd8Qzr7Bii0gBjNq20TX8s=;
  b=OQs4P4cKQer/onvNj619BV/GgHys/RsvyHC7NIALHuaTqFL/ORyXugzy
   argweIB+TnJbtbrMZoEGVlxH6TnUfExOOssvK1c00kpf52AOxakn2LXyX
   WkxchaMDDccxhUygffkLsflTMFkzcsJryFMkc3+qiXYN4sI8QUqWHZflR
   El7m3F0FbzpKrm129fFqKoL4RC9qjlxMSO8ahJGyXKyKsQkimwfFKy0BK
   J5j/aaQYIYpgDjwTZgedrS9Gvb1wqBmL2ed6raOZiCemqqyJ/wly5JcwZ
   LyBkyX1206WHwjDViEc7BmlVv9TTfilHO9yOpzTilL6nIc5HGlQCfipIj
   A==;
X-CSE-ConnectionGUID: kE2quuRxQx2Uel5sUPCtmw==
X-CSE-MsgGUID: oT0rmL0xT5eOrwchS+I9bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81314348"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="81314348"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:16:40 -0800
X-CSE-ConnectionGUID: FiquJXReQROYjI29C7spdA==
X-CSE-MsgGUID: nQBSwhOpRySGyVZaVs+wlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213295501"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:16:39 -0800
Date: Fri, 30 Jan 2026 07:16:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: idma64: switch to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <aXw-sxwYIm39S7k_@smile.fi.intel.com>
References: <20260129104916.200484-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129104916.200484-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8590-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 69897B743B
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:49:16AM +0100, Andy Shevchenko wrote:
> SET_*_PM_OPS() are deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS()
> and use pm_sleep_ptr() for setting the driver's PM routines. We can now
> remove the __maybe_unused qualifier in the suspend and resume functions.

Please, ignore this, it was sent without proper testing.

-- 
With Best Regards,
Andy Shevchenko



