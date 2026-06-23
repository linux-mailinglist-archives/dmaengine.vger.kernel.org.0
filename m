Return-Path: <dmaengine+bounces-11757-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xTT+C9WfOmoBCAgAu9opvQ
	(envelope-from <dmaengine+bounces-11757-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 17:01:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A156C6B821E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 17:01:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FRxFtdR8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11757-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11757-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEE0E3004D3B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089035AC10;
	Tue, 23 Jun 2026 15:01:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7523C8C46;
	Tue, 23 Jun 2026 15:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226895; cv=none; b=lLLK5FywpBzxVtc1G6DRudR7IOnW/t8dIdTGuD41wawpLTit9dy2NFbqV6ag1nffJaeGvWmk9eiEgqbFeMeXz5FhEQrt4wj52by3+ha657uYgZfWalHrShmNILhrtuSFgvPfy1w6GwK6lF/TgsDwp/ji5aMLgtFreM32Lj8M3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226895; c=relaxed/simple;
	bh=A/Z7Bq3js0vurwMDHDVFnbJkxpDvYREyQXj8IUK2YJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaK9AKA63FkmwX6lQueCGiAnSNQDWjWUit3ei2dEdvFxaKSMG/a0lHkQqpwuuOi8vwIV+KOg0KKS4vNc2JPdSO9LHA06tg8uKWKxKP2xaIGghA5FzsPoWxC7A9GU1j0Sjdhv73OWHUGJIdxNxT0Rddjc/I8L6EuhJQUEs+qhqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRxFtdR8; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782226894; x=1813762894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A/Z7Bq3js0vurwMDHDVFnbJkxpDvYREyQXj8IUK2YJ4=;
  b=FRxFtdR8w/pUX+Pe8HmVe/ulIUXqi9+G9cysPJ8jn/ebj6z+IoBiHwAk
   EN30EsP7im/R1/mUVpNVTygJiK81M7Jsh/zelwqLuwINw8Ol+JYTfwN5U
   iwrDKMhvQZqJWe6BNx23/Z1BUeEZPfuaUaVSAvquQ/VcxCuYZMcn7l2Bx
   H9OeUv2YYtaSeNfSzH4AQtS6fc5QckjWxj4ii0ANObc7c7sHmF3xvCCM9
   G2oRnF7WIIxbdTorQjVMG1SYW0285TKbpEHOSpD41DB3lcE+IYCyaTJMP
   B02UECapaKqqx9f8jf19GTAbkLy/w2BPiMJBYPloyW+/iJrl79VIMxELO
   g==;
X-CSE-ConnectionGUID: 9NHNdwz0RS+J8QpcSTvRXQ==
X-CSE-MsgGUID: 5ZTAGOw2QKeqwDIZQqniXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100521991"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100521991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 08:01:33 -0700
X-CSE-ConnectionGUID: g4KZ+stwTHu+1GPZZUnSRQ==
X-CSE-MsgGUID: N8cU/1L0QzuXCCmW/vs77w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254528969"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 08:01:31 -0700
Date: Tue, 23 Jun 2026 18:01:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajqfyOH0ZxxDCdJx@ashevche-desk.local>
References: <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpWzimx-5jlczpp@ashevche-desk.local>
 <ajqKD0BdQY5kSZjh@SMW015318>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajqKD0BdQY5kSZjh@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11757-lists,dmaengine=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,analog.com,vger.kernel.org,kernel.org,metafoo.de,baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A156C6B821E

On Tue, Jun 23, 2026 at 08:28:47AM -0500, Frank Li wrote:
> On Tue, Jun 23, 2026 at 12:50:06PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:

...

> > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > >
> > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > >
> > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > there... The code seems to use the dma bus width to match against PCM
> > > > formats supported and filter only the ones we can support (per dma cap).
> > >
> > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > if cap is two byte, it should support 16, 32, 64
> > > if cap is 4 byte,  it only support 32 and 64.
> > >
> > > Needn't mask each bit.
> >
> > I think you missed the point completely. It's other way around. If the HW
> > supports say 32-byte bus width, one _might_ assume it supports lower sizes.
> 
> what's 32-byte bus width affect software? It should only impact that if
> memory address is 32byte align, preformnace will be better?

Not only, it may lead to broken software.

> > It's similar to what we have with MMIO. Some HW, for example, may only operate
> > with 32-bit accesses, while only transferring a single byte (8 bits).
> 
> That's means, dma address can't start from odd address.  The length limited
> should be controller by dma_slave_caps::min_burst

> In dma_slave_config::src_addr_width, most like indicate how many data
> transfer by one dma burst.

And the burst is assumed to be aligned by most of DMA engines. Again it's quite
similar case to the MMIO. I assume that this is due to bus mastering
implementation: DMA, MMIO, or other means to access it doesn't really matter.

-- 
With Best Regards,
Andy Shevchenko



