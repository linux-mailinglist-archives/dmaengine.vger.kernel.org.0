Return-Path: <dmaengine+bounces-5935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE88B18935
	for <lists+dmaengine@lfdr.de>; Sat,  2 Aug 2025 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E7F1C268AF
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFD223DE1;
	Fri,  1 Aug 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrIyDZa+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1121146C;
	Fri,  1 Aug 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087484; cv=none; b=BCRbBha25Dx8v0a+U/DuNrF4Vv+4VuhGyoP4UpFjB2nvcsPn3+SJ0HBjmsTaOz9vByNdHVtzRCOyEMZ065e9EyR0Pu19SU4RByRXOpScj95M19GafHiu5IpWJQX76Nt21HOE2/jO4IOhE7WjsXZsRCA8ANRY0DgAax7fokVH1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087484; c=relaxed/simple;
	bh=lYGsLXzWFqJ8JyodS1uNE9QWm6glJtKWEhzyZ3WMbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCs4mdR6629pOLi3CZtqS9xhsMuwfBZeb/z5E9R3G+ux+4u04ZokcJ4ajFYNxSsKmtgnuX4QwabaDTVD0KjfroQZFzHk8kl3KOSNiqqGmzKGdACdaRokgipk2YXPW4KqJoPTU2ezM8KBH/yskC17TDOsonkmETWQrWpLHL0DMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrIyDZa+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754087483; x=1785623483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lYGsLXzWFqJ8JyodS1uNE9QWm6glJtKWEhzyZ3WMbt0=;
  b=jrIyDZa+G0eOA5mWA5Jo/CcEsyLykSMDuKTLZdwIWg+MBCphEEb8ZRvV
   yqPbXQTaBuWLXIvQXkBaAyji41pZoW4fr0NZrk2xoqkTGoHTcM4Oc8YD1
   qWYAJYsfM2CnhKw8xIEoYlBFsG0hWCBCb+OyObbiVUpVwWpsZitJoNU5X
   0jsluIZ2JmQpCmR06ioUfmGUc4FUEYtnImWKwvdYyLsfknI5ET3N3/1Jm
   yZ9Cjf237s8kjxgdvISmGe/bmLFauDHmA3ImrL60VSUcHv19PgDJNmUdI
   o1l1ZPvWb9jN5rR0WpjdkmbEu4BpEv1o18TRa3h4ua35h79iyuDN67Fxg
   w==;
X-CSE-ConnectionGUID: x5bO8dx2SIKBOK+zRJJxiQ==
X-CSE-MsgGUID: eApQ6vzyT42Q9NVkOCwreA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="44036465"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44036465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 15:31:22 -0700
X-CSE-ConnectionGUID: tQLmhw0FRPm8KifedDP6mw==
X-CSE-MsgGUID: mlXRH9TDRNKQy1/3ZfqMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163367171"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.40]) ([10.247.119.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 15:31:19 -0700
Message-ID: <d8041f34-7c4a-4bfc-ac6e-6c7d9a1e1208@intel.com>
Date: Fri, 1 Aug 2025 15:31:13 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Add a new IAA device ID for Wildcat Lake
 family platforms
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, dmaengine@vger.kernel.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
References: <20250801215936.188555-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250801215936.188555-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/1/25 2:59 PM, Vinicius Costa Gomes wrote:
> From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> 
> A new IAA device ID, 0xfd2d, is introduced across all Wildcat Lake
> family platforms. Add the device ID to the IDXD driver.
> 
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/init.c      | 2 ++
>  drivers/dma/idxd/registers.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 35bdefd3728b..f98aa41fa42e 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -80,6 +80,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
>  	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
>  	/* IAA PTL platforms */
>  	{ PCI_DEVICE_DATA(INTEL, IAA_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
> +	/* IAA WCL platforms */
> +	{ PCI_DEVICE_DATA(INTEL, IAA_WCL, &idxd_driver_data[IDXD_TYPE_IAX]) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 9c1c546fe443..0d84bd7a680b 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -10,6 +10,7 @@
>  #define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
>  #define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
> +#define PCI_DEVICE_ID_INTEL_IAA_WCL	0xfd2d
>  
>  #define DEVICE_VERSION_1		0x100
>  #define DEVICE_VERSION_2		0x200


