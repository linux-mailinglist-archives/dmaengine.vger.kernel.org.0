Return-Path: <dmaengine+bounces-8545-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HWKKU7ZeWlI0AEAu9opvQ
	(envelope-from <dmaengine+bounces-8545-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 10:39:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7D9EEA1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DD930495E4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC29346FA0;
	Wed, 28 Jan 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDJ2PbPy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289623469FF;
	Wed, 28 Jan 2026 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592877; cv=none; b=Ih/5X/6/W4PS/VwOqCAJJd5JQnuZj5m20rufEdgUzzRhIrPmu40nbrmhRqzeQI5e5TT8eUVicAc3VGBQHD/Jl7FfzCqVikb3tISWrY84bhvtUlKwnsvskCVo8gb1ln5Ch9yRJ7TK6BsOrd3JRIU2g0JnGDSLqG0dlcQnBLiSTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592877; c=relaxed/simple;
	bh=txX9P061wplIi+e2yJpM81KVALqzZjzBxIyzKGRXd2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stEJcXSowCx9ZGXmA2ad3QtS4jHZmCCbm7IL2edvM5waoSUtayiagDR773vbbKYVqK1H4+/5STfxUW0mjxkyi8x7Re5NVOS+h2dUjg2VX4IuP46n/0EYAPyA3+vQ12xGALaKWGg57FA9pUcAqfBhJlB5Tfix7irSSiqdJp4RU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDJ2PbPy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769592876; x=1801128876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txX9P061wplIi+e2yJpM81KVALqzZjzBxIyzKGRXd2w=;
  b=SDJ2PbPyPxQxxWgDkvyOZSWDYaxztkscJB7/zkJH1JBeph4clQugicdn
   7pD7jQH5UggzuaTe27tr8MRR1F9AoNoekqB+zfjpoDXhMSNxVuF5dYlAU
   DW3NfTZFjqb0ZFB6Lo6VEdyaOK/kLPv6wSAVfaXEJeWTWBKsaGa2HffDF
   L8d9u+PzVB/EBikueqUejRXSEvVGcbVukjERhP24ASgKJnT4HmLdHOBfm
   bIQu3/G24a1XZnRaOrtKl47LniPA0MmkXJqQA21Wa98PYWDkkZe4mwOFt
   veGQLNYBhGY6kpVjTV3OfFkN+OLaao1Qmo8lUtmyk7AVU0MQQf0JyjUwk
   Q==;
X-CSE-ConnectionGUID: n0weaw6RRdCD6lZnNLg1iA==
X-CSE-MsgGUID: FscJnlfuRp68SI81oqvaaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70889499"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70889499"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:34:33 -0800
X-CSE-ConnectionGUID: hKFrOdQrRhmsb4HZdrWJjA==
X-CSE-MsgGUID: lVKIuUqBTdqKsvBZz4kYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="231175192"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:34:31 -0800
Date: Wed, 28 Jan 2026 11:34:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <aXnYJQJW4wypkkPC@smile.fi.intel.com>
References: <51388859-bf5f-484c-9937-8f6883393b4d@app.fastmail.com>
 <aWUGmfcjWpFJs3-X@smile.fi.intel.com>
 <69f5dea3-17b0-4d3a-9de7-eb54f8f0f5cd@app.fastmail.com>
 <aWoM3JibLSBdGHeH@smile.fi.intel.com>
 <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-8545-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sent.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: C4B7D9EEA1
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:56:15PM -0500, correctmost wrote:
> On Tue, Jan 20, 2026, at 4:33 AM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 12:49:59PM +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 19, 2026 at 12:39:41PM +0200, Andy Shevchenko wrote:
> >> > On Fri, Jan 16, 2026 at 07:25:54PM -0500, correctmost wrote:

...

> >> > My understanding that the pin 3 on GPIO might be wrongly configured
> >> > by BIOS.  The difference with the original case is that your GPIO device
> >> > is locked against modifications and until you unlock it (usually
> >> > it's done in BIOS in some debug menu) it may not be fixable without OEM
> >> > fixing the issue themselves. In any case you can try the workaround
> >> > (see https://lore.kernel.org/all/ZftTcSA5dn13eAmr@smile.fi.intel.com/).
> >> > But I am skeptical about it.
> 
> I tested commit c03e9c42ae8 with the following patch and still saw the "probe
> with driver i2c_hid_acpi failed" error:

> +	{
> +		void __iomem *padcfg0;
> +	        u32 value;

> +		padcfg0 = intel_get_padcfg(pctrl, 3, PADCFG0);

I'm sorry to get you back to this one, but can you replace 3 with 82 and try
again (keep the kernel command options with HID debug enabled, etc, but no
other patches applied).

> +		guard(raw_spinlock_irqsave)(&pctrl->lock);
> +		value = readl(padcfg0);
> +		value |= PADCFG0_GPIOTXDIS;
> +		value |= PADCFG0_GPIORXDIS;
> +		writel(value, padcfg0);
> +	}
> +
>  	return 0;
>  }


-- 
With Best Regards,
Andy Shevchenko



