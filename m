Return-Path: <dmaengine+bounces-9689-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEvOGPxWxmmMIwUAu9opvQ
	(envelope-from <dmaengine+bounces-9689-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 11:07:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F03422E1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 11:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D7D300A8CC
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C263A75A0;
	Fri, 27 Mar 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQIwHlFg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1123624B5;
	Fri, 27 Mar 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605799; cv=none; b=gnIgoCrsNpEkqJzF+15PgQfTGilGj52Y8ZtmBXd/QO1SdOyvc84hPNWOTk+weHe5aJhu92jsKdaYKkAPJwcDPLmby47FNSWQJDFF3gX6wtxWi4j4lP0MjK10oQg0Qzc2bgJBtQnJJc88OCl31h0jrLHVt7tjY3ZDUYtomkldCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605799; c=relaxed/simple;
	bh=TJMWG88GbfSP08Ul6H198k/o250hEUBjpCdAWHzrTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nleu5Q7apTFx85W0YljsPS2Cy0Wf3JU5vGMrTHcxMCCBtjDL4JKfK3Z+AaSXzbKh/eUj69xs2jwkB90Nsz4rb6+H4nT2hpqkC7dNcP/1q0P4HjL12E/jj9wwMAXTGLERNFupaCg6NVutQUK87tztEcnxOYU89vR/SIJlIcrN9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQIwHlFg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774605796; x=1806141796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TJMWG88GbfSP08Ul6H198k/o250hEUBjpCdAWHzrTzg=;
  b=WQIwHlFgXMzlS6kWryZwnXIVWL0anAyKsOEVJrMwamU0EN0zlT4KGofg
   pqum65AFYoaIDOku/Uv9M2Ar+6RoO+2IvfBY3ytbGYrcgfYDE6vgrH2XW
   K6za0BSFaWnowFSbR/KK1aMKnI5tL6pB3tWomkt4oJzJ+dOijESx1iSmv
   UceqU85NdmHvpp+VA/IsOYoxGqFrkx0/ZKW2kT3vVQsl8AxPsCXk2Umt0
   SEDPKikejIY3f+M8c5qvHUHwoCoYHn+7LQSKa0PFrpwvEi+DqUGAKPtUJ
   xVl2wsb5ql6JJgLtkHKXI4P+UxODI+04KQgfeav3dFKiQho3SRrJS6roA
   Q==;
X-CSE-ConnectionGUID: ANv3UzkMRqOgh4ELVoyqLg==
X-CSE-MsgGUID: CthYhuEkS9yalybjqi+Afw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86297546"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="86297546"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:03:15 -0700
X-CSE-ConnectionGUID: xEqYDXdfS/Cdbo2txEU4HQ==
X-CSE-MsgGUID: b4uFh7DDS+adEmKEjk76UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="218653732"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:03:13 -0700
Date: Fri, 27 Mar 2026 12:03:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: hsu: use kzalloc_flex
Message-ID: <acZV35Q80GfDKkkd@ashevche-desk.local>
References: <20260327025943.8178-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327025943.8178-1-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9689-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF6F03422E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:59:43PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Remove hsu_dma_alloc_desc. It now offers no readability advantages in
> this single usage.
> 
> Add __counted_by to get extra runtime analysis.
> 
> Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

We refer to the functions in the comments and commit messages as func().
Please, update this patch accordingly.

...

>  static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
>  {
>  	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);
>  
> -	kfree(desc->sg);
>  	kfree(desc);

It can be collapsed to a single line, but for the sake of clarity the above is
okay.

>  }

...

> -	desc = hsu_dma_alloc_desc(sg_len);
> +	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>  
> +	desc->nents = sg_len;
> +

> -	desc->nents = sg_len;
>  	desc->direction = direction;
>  	/* desc->active = 0 by kzalloc */
>  	desc->status = DMA_IN_PROGRESS;

This nents move makes disruption is the field assignment block.
Please, move them all up.

...

>  	void __iomem *addr = chip->regs + chip->offset;
>  	unsigned short i;
>  	int ret;
> +	unsigned short nr_channels;

Preserve reversed xmas tree order.

...

> -	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
> +	/* Calculate nr_channels from the IO space length */
> +	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
> +	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
>  	if (!hsu)
>  		return -ENOMEM;
>  
> +	hsu->nr_channels = nr_channels;

+ blank line.

>  	chip->hsu = hsu;

-- 
With Best Regards,
Andy Shevchenko



