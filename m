Return-Path: <dmaengine+bounces-10039-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PIcGxHY5WnWoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10039-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:38:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D844F427CEE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2D33018D4D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CAD383C8E;
	Mon, 20 Apr 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDC+maY2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8228641E;
	Mon, 20 Apr 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670519; cv=none; b=mLpSAXN60PPXctGHlnftFA5voZXQNuJ/JnkBFgWeZyHj6Ah/s1Fj4wYGyfl9TN/Eop3NNvlvgaeHmHLE19XGB2D8cki5lMGcPS+GPNV/JNt9rsJiYnnnW5C1Bkt4nKV5XFgRODFGl9zdYdiHNntWF+AKqlwqU6H3M5FLC/OIi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670519; c=relaxed/simple;
	bh=PFEGMCBzjIZQkB/V5r43RprUGemYn8ONbd5FGpN3bbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiCMEnz4w53K9I2Bmf6IcuKIcp9fVfT/aj/GOmzTXzK1uxmNsXIGD8ddwpPBU1tIcJeMkO26zaZffwf2yR5r48CNhs0sT8lL0JvQvMgf51E8ylVfAH0CjhE5OfcUKC+ciCaJ/32m45HwKc93WFk9LsiSQwmZjInbNeOT0+mZgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDC+maY2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776670517; x=1808206517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PFEGMCBzjIZQkB/V5r43RprUGemYn8ONbd5FGpN3bbo=;
  b=jDC+maY2nqno2L4C3JgTl4ngheNWkhZsUVICOX+a9DrteIHyJbslhVz0
   LBDG7hn6BzsgH4YWn1PCeOF/zsLj+jPiV7AG7i8vMxR1FsVvrycVLaM0/
   iRaQs7+lHlT8IE4WgFciMbv77GRxRwdfsdWRxFFCDW/GP0zANQNaiZE1V
   M6tMk+dSSZZroQvqLnBTT9K3PMmwtZ8k01KsceE01kMQsYRUCASyhDSJc
   xhtg5PKO5sHDkSsrtqvvzhD1hEwI5VXxqpUBkTf3aoAUUBsuvuvN+1tyL
   pU/iTTZGQyBuoveL6y6imwYUWYXaw13jglRLCAuKE2QrGQds6IE5iv3Ll
   g==;
X-CSE-ConnectionGUID: N199YgORS3i0q4BCLDwjvw==
X-CSE-MsgGUID: RfKUqCWXSqmDFbtpxSrFwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77592709"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77592709"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:35:17 -0700
X-CSE-ConnectionGUID: ZyV3VCYsTeWVmFmAYvAnJQ==
X-CSE-MsgGUID: N+jxu0rVTtq1lW42wwf/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="227312260"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:35:14 -0700
Date: Mon, 20 Apr 2026 10:35:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Message-ID: <aeXXMIzB7xbOEkBU@ashevche-desk.local>
References: <20260415032753.6006-1-rosenp@gmail.com>
 <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
 <CAHp75Vfp=Wvtq5EFM2vOZUfkGDcq_m_zpK_px0BKTFiiR8EwwA@mail.gmail.com>
 <aeXVByacaoBGK9sX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeXVByacaoBGK9sX@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-10039-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: D844F427CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 03:25:59AM -0400, Frank Li wrote:
> On Mon, Apr 20, 2026 at 09:49:48AM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 20, 2026 at 9:14 AM Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > Subject
> > >
> > > dmaengine: hsu: use kzalloc_flex() to simplify code
> >
> > Not really. The main point is to have source fortification being enabled.
> 
> Okay, but need know purpose in subject
> 
> use kzalloc_flex() to ....

Not objecting this.

-- 
With Best Regards,
Andy Shevchenko



