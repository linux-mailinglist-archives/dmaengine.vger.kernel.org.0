Return-Path: <dmaengine+bounces-8080-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67FCF9379
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 17:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8271A3093EE0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D002E7F25;
	Tue,  6 Jan 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij/9yY2I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522233EB09;
	Tue,  6 Jan 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713858; cv=none; b=sKUH8RdUeofCDKXDRfW4bdlDFa4ifnJZ80eV8HDSscYlbTDkmEgLjg0jqpQ+0FJg3iezDYrA4JorSQWZb4RfsK8r3ifgiLBvtg2bOyna9nNIgNP0G2qKDowvSl4HWVV/nFRQRY3MhNWwRUqRNfeRQergwiQyiglw7FC+Xdgtvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713858; c=relaxed/simple;
	bh=iRylZQBceivq5hzOwZPUC0NQQSBb/09Lmuix8C1gY3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjKI0S+wwiT83orGb/Cd3D35d30epeBlLNoAoZi/pDi4O8VbrqBnf+XiRDgmjT0uaNdI17p5j8LuCv0gYlNUHr0uT0th13p/Gye/fa2aRRq/VMIDuno+W2FxlWB5Mq+QpBFloc7q53Bx9O43pfoMvapUhZPgqE5ANcCdzIASpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij/9yY2I; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767713857; x=1799249857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iRylZQBceivq5hzOwZPUC0NQQSBb/09Lmuix8C1gY3Y=;
  b=Ij/9yY2I7tcWirqAEYybxHfPHkJ3ZiICssqVJPsa3eKsv2SjE3wO01lm
   jadK/NQv8UdCjvn27faivcOsKQBnffYDI6qXejELYfnCiu13+KhfKI4sV
   DDLQ1P/IK+OYelp1pqYWIL8RsaIPyw9TamNI8SH1lySJWzDVKNwVmmUaS
   cJj6DqbhBLB6ADkHBbsuin0f5KCjYh5+DTwcdnZVEf+lAw8TK8JCX3UKG
   AwAULcVXKdh3SrvpFeSVjdwcpB2Qlc2AefUxlVWeF1AtRr3mRnrxRohfB
   lUIQsgJXIaLV93RyhX87pejgxnazMYqnUNBK4V+9HtqVLMr969/ucaEVD
   w==;
X-CSE-ConnectionGUID: ZLAprozJRg6vYGExbL8AKw==
X-CSE-MsgGUID: GWfO3dCdSFKa4tyDHIrehA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="94547219"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="94547219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 07:37:36 -0800
X-CSE-ConnectionGUID: UYbs41t8QBW2nx0n9Gzr+g==
X-CSE-MsgGUID: O90ThpW8RBGnqi1va06q6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="207553033"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 07:37:36 -0800
Message-ID: <b892c320-3138-4689-8a10-12e365961e63@intel.com>
Date: Tue, 6 Jan 2026 08:37:35 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: fix possible wrong descriptor completion
 in llist_abort_desc()
To: Tuo Li <islituo@gmail.com>, vinicius.gomes@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106032428.162445-1-islituo@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260106032428.162445-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/26 8:24 PM, Tuo Li wrote:
> At the end of this function, d is the traversal cursor of flist, but the
> code completes found instead. This can lead to issues such as NULL pointer
> dereferences, double completion, or descriptor leaks.
> 
> Fix this by completing d instead of found in the final
> list_for_each_entry_safe() loop.
> 
> Fixes: aa8d18becc0c ("dmaengine: idxd: add callback support for iaa crypto")
> Signed-off-by: Tuo Li <islituo@gmail.com>

Good catch! Thanks. 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index 6db1c5fcedc5..03217041b8b3 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -138,7 +138,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
>  	 */
>  	list_for_each_entry_safe(d, t, &flist, list) {
>  		list_del_init(&d->list);
> -		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
> +		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true,
>  				      NULL, NULL);
>  	}
>  }


