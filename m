Return-Path: <dmaengine+bounces-5960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03552B1CA4F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 19:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19472565BB5
	for <lists+dmaengine@lfdr.de>; Wed,  6 Aug 2025 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38F28B7ED;
	Wed,  6 Aug 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKmqaiPf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C529AB1A;
	Wed,  6 Aug 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500198; cv=none; b=LwVbhQtX3ycktgRCCroUM6lxeQpNfyuUIFS9GxiWbYV1GLJgUi7Oc9UqYwwBR9F0bqVjm9Vzb5jXR7gnjlLcSCoRXu+ed/DvVYJd+ohWHEZcPN8eM+to5Vyvo//WDImUQqCtYVESHafpG29z0cgq8JYFbYxOR3AC1U3H2V8epHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500198; c=relaxed/simple;
	bh=cZ1Z55OakBzymc2XNbJRmhXQLhcZ3OEX5Xx1bQ/QyXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiB/Z0ENrn4tOWEwR53G8tgYF4PaZ4qzqVYEZ/Vh/8flupu7Fiz7LJ6kWaK3dHy3h9mgoE0gePF+2XfCByPRQSyEwE2CiZTIQWrAKenYZ2Jy72Tu8SobIGydg+2ifbsknZsSZBQ3GHsmKeGTVvC2tq1uqDJq+P387tQnGsgPqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKmqaiPf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754500197; x=1786036197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cZ1Z55OakBzymc2XNbJRmhXQLhcZ3OEX5Xx1bQ/QyXU=;
  b=EKmqaiPfrQ4/3oHXKeTrmwydeKqQjERnWZGpqlPSOJLFTuAkDqh7XTGU
   XUKRMSeC8AkB8FxOrKC+wiBRPB3Js2kzQT+ZC5ezW2JgJWoXYnNZS4koV
   Ey9cYM6M/x7oNKhAjAytjK3VKgMi45he7lU/OHwz1hwwebMJZNXFXD+rH
   hd1Cc/zJZW+VNDDiJn7R43nh/wTt59IHLjFfClBdEGPNna2aVz9hyCElZ
   pLXtlhzXmODCAa03MndCwMvM6f/FohqZcjggyUE02sJ7c3lxITC14xLa8
   7OJL5HrjV7JtYIFPTv4m2Acads0Dk0cfS1l8vhskXqOnC5lEUm9UXa/na
   g==;
X-CSE-ConnectionGUID: LwxUwAfUTCe4ydQVezcxdQ==
X-CSE-MsgGUID: cFEZDWH5Twqidm5Jc82W1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60636037"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60636037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:09:57 -0700
X-CSE-ConnectionGUID: Gd6KdXKqTlqLc6i7l8ZOnQ==
X-CSE-MsgGUID: b81DbpytQZOPb7meGkNrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="201992498"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.97]) ([10.247.119.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 10:09:53 -0700
Message-ID: <ab033580-de87-4dc4-990d-0a0334bc67f0@intel.com>
Date: Wed, 6 Aug 2025 10:09:47 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dmaengine: idxd: Fix possible invalid memory access
 after FLR
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
 <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 6:27 PM, Vinicius Costa Gomes wrote:
> In the case that the first Field Level Reset (FLR) concludes
> correctly, but in the second FLR the scratch area for the saved
> configuration cannot be allocated, it's possible for a invalid memory
> access to happen.
> 
> Always set the deallocated scratch area to NULL after FLR completes.
> 
> Fixes: 98d187a98903 ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a58b8cdbfa60ba9f00b91a737df01517885bc41a..31e00af136a7e13887d3ffd00efbb05864712a80 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1136,6 +1136,7 @@ static void idxd_reset_done(struct pci_dev *pdev)
>  	}
>  out:
>  	kfree(idxd->idxd_saved);
> +	idxd->idxd_saved = NULL;
>  }
>  
>  static const struct pci_error_handlers idxd_error_handler = {
> 


