Return-Path: <dmaengine+bounces-9260-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DcFJVOwqGmfwQAAu9opvQ
	(envelope-from <dmaengine+bounces-9260-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 23:21:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB888208715
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BBC30DE3C7
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417D3264F5;
	Wed,  4 Mar 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP3005HF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55E29994B;
	Wed,  4 Mar 2026 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662358; cv=none; b=eeRuCAhiom3c82NMPdHR1L1wcZwc4JWcJ6UEXHRvhgwVjppQrHd3DuRovE8sl07ZMW9fSqOm/x3T2aGKgnFL4GlPpS/yCiC7Do5E2huxEeBoxg4CD8yFCDw3dnsmg6BcSQz/7RBb/3/LG593wDuEM8iFq/3WOl+zP3JUNu+403g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662358; c=relaxed/simple;
	bh=oabEO9qhWAelmM/HFZ8gOzEKgnMbVzua9t4hAOIZ9Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKM0zTNek8zfbZ6IwO1r+Su5m5IMP7ANcV9/676t92AGsS42jRrrJ1uiQu/Tv7MP0Xcm8ajIFJ3n58jYRqpoaigsbAmd7YaDhb8rJpYJqrsI6P3xfOR8iDMG0WhBSUFYgKPfTlfq61Kp6nXhSAGU7uU4nSVfoGPmzwLxpGvRsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP3005HF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772662356; x=1804198356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oabEO9qhWAelmM/HFZ8gOzEKgnMbVzua9t4hAOIZ9Q8=;
  b=LP3005HF96Vu4LI2iqu2IBWjjhDqiBBkn7HrNiZU7zRXAh5gyUYt9Gsx
   wWN9Hwo+YdoOVYPGOeYLKAbrL/RTDIzQKvpvSAzjFkFDJF+sT7Rs+wKqL
   nKOVbNi//MI8A/jY43psWVzeK65Mzkd27pQi8fsPS95aZinra8P2t/zEo
   o7BkwDslFWKad5CXM6s9VKd25H6wVvfwdmc6n+uvihEQtQ7gZ/pKppl1e
   Wnqbqq2pLl1s9nT+H19nAhQp4H38zo+dvT9zMkZFzsaL1HEszNiFX6TEa
   vxOY0NsiGqg59f0FTtDgUM/QbmTJ09WYddwfrw0reUWbuKTJtNPbyiIX4
   w==;
X-CSE-ConnectionGUID: JIc4zPKPSPGiEDeG9UCkOg==
X-CSE-MsgGUID: 0xmpz34oTgqHwfy/xk7w6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77610983"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77610983"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:12:35 -0800
X-CSE-ConnectionGUID: Cz1fwWJdSZCj3Tvfp4tXrQ==
X-CSE-MsgGUID: p0/WfvGeTsy8IKVjZakdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222619194"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.218]) ([10.125.108.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:12:35 -0800
Message-ID: <079e8200-ccac-4261-8460-6ec4cd557bfc@intel.com>
Date: Wed, 4 Mar 2026 15:12:33 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dmaengine: ioatdma: move sysfs entry definition
 out of header
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
 <20260304-sysfs-const-ioat-v2-2-b9b82651219b@weissschuh.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260304-sysfs-const-ioat-v2-2-b9b82651219b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB888208715
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9260-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action



On 3/4/26 2:44 PM, Thomas Weißschuh wrote:
> Move struct ioat_sysfs_entry into sysfs.c because it is only used in it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/dma/ioat/dma.h   | 6 ------
>  drivers/dma/ioat/sysfs.c | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 27d2b411853f..e187f3a7e968 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -140,12 +140,6 @@ struct ioatdma_chan {
>  	int prev_intr_coalesce;
>  };
>  
> -struct ioat_sysfs_entry {
> -	struct attribute attr;
> -	ssize_t (*show)(struct dma_chan *, char *);
> -	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> -};
> -
>  /**
>   * struct ioat_sed_ent - wrapper around super extended hardware descriptor
>   * @hw: hardware SED
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 5da9b0a7b2bb..709d672bae51 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -14,6 +14,12 @@
>  
>  #include "../dmaengine.h"
>  
> +struct ioat_sysfs_entry {
> +	struct attribute attr;
> +	ssize_t (*show)(struct dma_chan *, char *);
> +	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> +};
> +
>  static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
> 


