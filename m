Return-Path: <dmaengine+bounces-11610-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FlR7HpGRM2rNDQYAu9opvQ
	(envelope-from <dmaengine+bounces-11610-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 08:34:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5F269DDDB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 08:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Smw/w9Wn";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11610-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11610-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46853305FB1B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 06:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B28318140;
	Thu, 18 Jun 2026 06:34:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44958257854;
	Thu, 18 Jun 2026 06:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764494; cv=none; b=X0UmHEA3Y0e8zCfObJ1cFC2CArsytdzkq8vZOc4KZ0wZKgteCuCdkpJBGAq0psaKn8TeopjrpqPMDs0lgkGteqwgN2hLoYLcYFaKpxbtLq2Cno3iea6uTeRpug60N3exj3eUbNxMWCgCaAEIpB5BUb+2rURymrTiQriVhKP0dqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764494; c=relaxed/simple;
	bh=mHQfaPHeB4yZmfPnmw0ITlavwoe+a+VD3LpQc7i5iTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0vYEj0sFZQJrIotI4rLxyDqclf4pgtFUkM/ns7cSjghtOAQFl//AbZmTGWlW58rsPoESK2gbzNuyqVP24czYdIDDga5WAX7tKpz/cI6TLLkTJgjtPiTDRZUDS2F/sqbPg4bvnChLtFOTvASSQxrA5thhSw9e158LvXICdKS6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Smw/w9Wn; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781764492; x=1813300492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mHQfaPHeB4yZmfPnmw0ITlavwoe+a+VD3LpQc7i5iTs=;
  b=Smw/w9WnanRGEqiiqlCweR32Vhgw7hyonNR30Ixd9xCD7otRCRuhtFsV
   yH1Rm25GJzHUzGVhSfWzggx6OGXYc4yhDDhiUH1dJoAR75xIrqjCrRFYK
   jAL/tuJyrgwtU1skd63HyZSXFQvzk9rnX9T+o87PP+36v9DhcwyUzyrxV
   H6kc7X8XNAxGvW1FGqoowSi5WG3hvsmZUEzD6EcYMfnGlgQ3C5mrq2C+U
   JBI980eZPmqpFL7rJlaunx2uNkAhrj654k9sFNSaEaryHKw3DnMkEL8q8
   wClIjxwn/0pG5OvzfR39QawpARmk4dZy91VRAfoXOandr+d+BpSQaakOB
   Q==;
X-CSE-ConnectionGUID: qGLx6OENShWAMBoeq1qmRw==
X-CSE-MsgGUID: Lwd2lX3aTNmcQzD2nMxiRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86431996"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86431996"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:34:52 -0700
X-CSE-ConnectionGUID: oBuVv9rbSoOjSZsf25/Hvg==
X-CSE-MsgGUID: jjNy/8VnRRy9uGYCzUqKsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="241905091"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:34:50 -0700
Date: Thu, 18 Jun 2026 09:34:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Free resource list at
 appropriate time
Message-ID: <ajORiHmedgWiT64Z@ashevche-desk.local>
References: <20260617091421.2649071-1-andriy.shevchenko@linux.intel.com>
 <ajMI-QgrEREC6OTD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajMI-QgrEREC6OTD@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-11610-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C5F269DDDB

On Wed, Jun 17, 2026 at 04:52:09PM -0400, Frank Li wrote:
> On Wed, Jun 17, 2026 at 11:14:21AM +0200, Andy Shevchenko wrote:
> > In one case we don't free resources when formally should, and
> > in the other we do unneeded "double free" (emptying an empty
> > list).
> >
> > Both are not critical issues at all, they just make code robust
> > against any possible future changes in the flow.
> 
> what are you talking about, can use straight forward words.
> 
> You just move acpi_dev_free_resource_list() after check return value
> of acpi_dev_get_resources().

Not really. There are _two_ cases. And while they are slightly different,
the solution is to make them behave in the same ways.

...

> >  	INIT_LIST_HEAD(&resource_list);
> >  	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> > -	if (ret <= 0)
> > +	if (ret < 0)
> >  		return 0;
> 
> Dose this change related with this patch?

Yes. It's mentioned in the very first part of the first sentence in the commit
message.

> >
> >  	list_for_each_entry(rentry, &resource_list, node) {
> > @@ -370,10 +370,11 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
> >  	INIT_LIST_HEAD(&resource_list);
> >  	ret = acpi_dev_get_resources(adev, &resource_list,
> >  				     acpi_dma_parse_fixed_dma, &pdata);
> > -	acpi_dev_free_resource_list(&resource_list);
> >  	if (ret < 0)
> >  		return ERR_PTR(ret);
> >
> > +	acpi_dev_free_resource_list(&resource_list);
> > +
> >  	if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
> >  		return ERR_PTR(-ENODEV);
> >
> > --
> > 2.50.1
> >

-- 
With Best Regards,
Andy Shevchenko



