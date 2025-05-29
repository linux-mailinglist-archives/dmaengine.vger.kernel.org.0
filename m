Return-Path: <dmaengine+bounces-5277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4112AC814C
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CE43B891E
	for <lists+dmaengine@lfdr.de>; Thu, 29 May 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382D22D9E4;
	Thu, 29 May 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jojQbmXj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678C17A31B;
	Thu, 29 May 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537817; cv=none; b=UcTBeF3MkcP8WxpGD1OtdNBXSTp2rAIj5MBg6k9FQP9TeqQiDlOF0R3ve3cAu64NV+4ZtN/twPtOg9TgHbrppEGbuNQQNMlhFGO3QE/KbIS68tEuA3DSsRwlpWK+Nm7oXAtLyFv+RL/qphJ+H/Ia/42G9p3rdRLomAOHQfi7qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537817; c=relaxed/simple;
	bh=l42ElIx0jEFUf4x4V+Rb9grbIJ6gKs/rJeQxiQhJGQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rzs3HL6gu2UeoG8mG+7EbR2vuDPdT1wl7cpHh4uYPl+s0nX+lrXiQN+0OI9rrfIPpxbslFjP9rISyNbi1pI4azgyAJKG4/8QWtIzZhY+Itf95aqnMmMSZunM2SvpOw/cACblKk0+8yKaAImtGPgfPbBF0Z05k73kApWkxYC7cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jojQbmXj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748537816; x=1780073816;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=l42ElIx0jEFUf4x4V+Rb9grbIJ6gKs/rJeQxiQhJGQ8=;
  b=jojQbmXjd8mZ2GbrSxCDIUl6HXEtYZi4TwPI4m8HARWLSWT3DQWQOo1/
   ZakYLUEsuQ3q+ycPpUIWVaz6rA0/1QlIQklQg/KlB793zGv7ixbvo8m/s
   8tNCISjrYWulx6bgNlXTYJ18KGvnt8PXXoxcdvkFXTLhm67kMR2fVDC1W
   opNUGvc6eRszR15M3sfFNzNFX7A6sYeW31gkIqxCbkUAVloZhzjgOSxio
   59kXR7uyx83Wo3lfxVVIPX2MJcMFMnK0qV2fb1lIY3VAAZ35zCmK9Gtyv
   dBkW7hekDOgVrWwmgSrJxKmkNyKx39vMT6KVQrkYFTnyKpOAQGmPBAxfp
   Q==;
X-CSE-ConnectionGUID: 1xXCtcfDR9u7qGcxqmACVA==
X-CSE-MsgGUID: jdWP0TaeRm+jDVYIUBWzWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50536714"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50536714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 09:56:55 -0700
X-CSE-ConnectionGUID: z5gM/RERTCSYINdK5BK51A==
X-CSE-MsgGUID: FDEaArnpRmW3F9KJLpvYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148904724"
Received: from jjgreens-desk15.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.186])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 09:56:55 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com, xueshuai@linux.alibaba.com, gordon.jin@intel.com
Subject: Re: [PATCH 1/2] dmaengine: idxd: Remove improper idxd_free
In-Reply-To: <20250529153431.1160067-1-yi.sun@intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
Date: Thu, 29 May 2025 09:56:53 -0700
Message-ID: <87r0079wyy.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Yi Sun <yi.sun@intel.com> writes:

> The put_device() call can be asynchronous cleanup via schedule_delayed_work
> when CONFIG_DEBUG_KOBJECT_RELEASE is set. This results in a use-after-free
> failure during module unloading if invoking idxd_free() immediately
> afterward.
>

I think that adding the relevant part of the log would be helpful. (I am
looking at either a similar, or this exact problem, so at least to me it
would be helpful)

> Removes the improper call idxd_free() to prevent potential memory
> corruption.

Thinking if it would be worth a Fixes: tag.

>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 760b7d81fcd8..504aca0fd597 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1324,7 +1324,6 @@ static void idxd_remove(struct pci_dev *pdev)
>  	idxd_cleanup(idxd);
>  	pci_iounmap(pdev, idxd->reg_base);
>  	put_device(idxd_confdev(idxd));
> -	idxd_free(idxd);
>  	pci_disable_device(pdev);
>  }
>  
> -- 
> 2.43.0
>

-- 
Vinicius

