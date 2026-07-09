Return-Path: <dmaengine+bounces-12237-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZaLJeW/T2o0nwIAu9opvQ
	(envelope-from <dmaengine+bounces-12237-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068A732FAB
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AoigiLgx;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12237-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12237-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA3D30D46A3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D837B13A86C;
	Thu,  9 Jul 2026 15:30:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED5379C34;
	Thu,  9 Jul 2026 15:30:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611037; cv=none; b=oI8adNeFq+r8NSFcThsDGjfU9i4UPNFk/1w/TocwZGeSRcyHMbE9mjwFNLUJAe6J5aZCsvNzM9DwXyHWgkjSdcq8zT0YtLfTSJ45tqi19MUObAfdx8DUN42DvTOYa1R8km8CtPLdVXXYd7CtYpAMZsz/3ZIENhGLqVORXHr66Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611037; c=relaxed/simple;
	bh=VPJXC8PlX+3g80UFKW55dUQBu5ucrvmJd2Q8qexzeMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU120y4+rFgAE3RW/WrGm7m2MSsUsJ3NRnfny3ctiOX2y4LueqKq4WJDAtP5ctQZxTbwdU7+aRAk6FdSZHExJv4Qe480Mq6X1n11ZYKiqnICD4nF5DOix9I5Cy5tfmY0wPmLEBmJzaHY4NQIhGGd0vl5uDAoU5r0L/kT9FGASpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoigiLgx; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783611035; x=1815147035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VPJXC8PlX+3g80UFKW55dUQBu5ucrvmJd2Q8qexzeMs=;
  b=AoigiLgxRkAecTITFi4DVEWU8bGfoANRR8y7ty/TbCX7XLyuqh8VB1NF
   0JN4xg6yIz82Yh6HIKXS3x5ALuHg807pJF1lO80k8aRgXFQ40VCb8mL8m
   PO/txKZNagw8+6B2oB5+soS9pud5B/eWJ7YGntHUx8yxkPXel4cTnVXny
   swXD798h4pXBSRC2qN7qY/l60VdpxIBdnFuOC+ZBwOw00dvazzDVYELhH
   LzEo02rawzClHhpBi31hhrd6+ocLMgrHpgM3RhA0xq0nrNS+4ZChktX6r
   j+qxHqxPC4kT797EstJ2uXrhXFeWIEMMMspkfsvr0Sl9RRsIHta5GHfbG
   w==;
X-CSE-ConnectionGUID: 4hnUlQklSLimo3m8X3oCMA==
X-CSE-MsgGUID: KiVDP0boRNuJ3GrAGEei3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95810096"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95810096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 08:30:26 -0700
X-CSE-ConnectionGUID: qlINnsEJTwGOSP/wT4n9Kw==
X-CSE-MsgGUID: Ay1mQhCFSg+cEjAddHug1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254123962"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.142]) ([10.125.111.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 08:30:25 -0700
Message-ID: <097a48cd-7436-4499-886a-d8f313ec56f6@intel.com>
Date: Thu, 9 Jul 2026 08:30:24 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Remove channel from list on registration
 failure
To: Ruoyu Wang <ruoyuw560@gmail.com>, vkoul@kernel.org
Cc: ashok.raj@intel.com, fenghua.yu@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260709062303.4167624-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260709062303.4167624-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:vkoul@kernel.org,m:ashok.raj@intel.com,m:fenghua.yu@intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12237-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0068A732FAB



On 7/8/26 11:23 PM, Ruoyu Wang wrote:
> idxd_register_dma_channel() links the channel before registering it.
> If dma_async_device_channel_register() fails after that, the error path
> frees idxd_chan while chan->device_node remains on dma->channels.
> 
> The DMA device can therefore retain a channel list entry that points into
> freed idxd_chan memory. Remove the channel from dma->channels before
> freeing idxd_chan on the registration failure path, matching the driver's
> normal unregister path.
> 
> A static analysis checker reported the stale list entry, and manual
> source review confirmed the registration failure path.
> 
> Fixes: 397862855619 ("dmaengine: idxd: fix dma device lifetime")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index 9937b671f6376..f2c03f3cf1925 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -289,6 +289,7 @@ static int idxd_register_dma_channel(struct idxd_wq *wq)
>  
>  	rc = dma_async_device_channel_register(dma, chan, NULL);
>  	if (rc < 0) {
> +		list_del(&chan->device_node);
>  		kfree(idxd_chan);
>  		return rc;
>  	}


