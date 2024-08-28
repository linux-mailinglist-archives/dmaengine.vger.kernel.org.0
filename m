Return-Path: <dmaengine+bounces-3000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D3963530
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55D21C216F0
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA11AC45F;
	Wed, 28 Aug 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K54KhmUL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AB158DCD;
	Wed, 28 Aug 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886489; cv=none; b=FcsgI1KrV55Ljp815FZUSSydO0m57TW21WMYbXlHTM647Iym3niFdypDnGui4/OJbcizH8FXhIAXBIZlSkPhuspegnKBXgunT4BpjlgRpwMMGHt8mNexCAu4azGAgwHg/xCgXfhy5XW5lN3Syr/D5QVN2mFwjLmL/rN4tloq+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886489; c=relaxed/simple;
	bh=i0uB2sUefbuO8XrBuAFwU+CfGf52TFkPDAb8TRyXpBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlifpZLJr91G5YlYeLZkRwAM6xr2SOtzPvKIi42HUHl3CHZPye6EUdk6ycLAwwC7ZI4Sp/rRketvrBQKsWXeTRVXj7gF3sDG8EO0+EEuJfS1it/2MTTH0VTNAtRX3iBfbsdnHQFaeh26+O9FbiwB+c50NeLmneCOLguKX50IPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K54KhmUL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724886487; x=1756422487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i0uB2sUefbuO8XrBuAFwU+CfGf52TFkPDAb8TRyXpBw=;
  b=K54KhmULr1PJ38Mznp//ZrFbL4QQIO4LxSfaPmuNAxNNB3dlJ+/vQA2Y
   IVx4eqs+iOtCLsOQJNw8NuK9G9KbKctgTWbG/Ona/It4u92p18JZeY0Nt
   8ysaCNeX76EQ3BD/LhDixY/4fKkKM/MUdsa6opEMHjF+4hI7li/kqWJK0
   MBvk+lf4ttAZ366RuaPAPu4NqgKTsw3rTf5PQF1GtaD6m/F2N+ZkckC6w
   kBPyoq/re90oUE5z+Thvt984gEpdzULgXnMxf4Ewg+ANx2k1At25UrWo6
   +Zswl2aFQU/XB0ODgbE6rVcEGGgfhNu4UcQYZVghP2e2CR22cj3b27dzi
   w==;
X-CSE-ConnectionGUID: ke4eiZ4oSXOQr90YhhyjGQ==
X-CSE-MsgGUID: UulagVIAQUSI0rTRZwTy8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23580393"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23580393"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:08:05 -0700
X-CSE-ConnectionGUID: pWPcFnc0RMWgHGE0wAfTKA==
X-CSE-MsgGUID: scl/BcmZQeO7hK0x+BrDaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68210575"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.94]) ([10.125.111.94])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 16:08:05 -0700
Message-ID: <b80f8c27-9f10-411f-ad40-36eb5ba4fc88@intel.com>
Date: Wed, 28 Aug 2024 16:08:03 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: idxd: Add new DSA and IAA device IDs on
 Diamond Rapids platform
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828224204.151761-1-fenghua.yu@intel.com>
 <20240828224204.151761-3-fenghua.yu@intel.com>
 <d8505c21-dec0-45ce-8757-e1aea7ca7432@intel.com>
 <f3c438bd-7346-62ce-5d5f-86b97f8cdca1@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f3c438bd-7346-62ce-5d5f-86b97f8cdca1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/28/24 4:07 PM, Fenghua Yu wrote:
> Hi, Dave,
> 
> On 8/28/24 15:45, Dave Jiang wrote:
>>
>>
>> On 8/28/24 3:42 PM, Fenghua Yu wrote:
>>> A new DSA device ID, 0x1212, and a new IAA device ID, 0x1216, are
>>> introduced on Diamond Rapids platform. Add the device IDs to the IDXD
>>> driver.
>>>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> ---
>>>   drivers/dma/idxd/init.c | 4 ++++
>>>   include/linux/pci_ids.h | 2 ++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index 415b17b0acd0..21e3cff66f77 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -71,9 +71,13 @@ static struct pci_device_id idxd_pci_tbl[] = {
>>>       { PCI_DEVICE_DATA(INTEL, DSA_SPR0, &idxd_driver_data[IDXD_TYPE_DSA]) },
>>>       /* DSA on GNR-D platforms */
>>>       { PCI_DEVICE_DATA(INTEL, DSA_GNRD, &idxd_driver_data[IDXD_TYPE_DSA]) },
>>> +    /* DSA on DMR platforms */
>>> +    { PCI_DEVICE_DATA(INTEL, DSA_DMR, &idxd_driver_data[IDXD_TYPE_DSA]) },
>>>         /* IAX ver 1.0 platforms */
>>>       { PCI_DEVICE_DATA(INTEL, IAX_SPR0, &idxd_driver_data[IDXD_TYPE_IAX]) },
>>> +    /* IAX on DMR platforms */
>>> +    { PCI_DEVICE_DATA(INTEL, IAX_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
>>
>> IAA_DMR?
> 
> Sure. Will fix this.
> 
> Also add something in the commit message? "Use IAA in new code instead of old name IAX. The IAX name (e.g. IDXD_TYPE_IAX) is still kept in legacy code"

sure

> 
>>
>>>       { 0, }
>>>   };
>>>   MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>> index ff99047dac44..e15ebb3942ae 100644
>>> --- a/include/linux/pci_ids.h
>>> +++ b/include/linux/pci_ids.h
>>> @@ -2707,6 +2707,8 @@
>>>   #define PCI_DEVICE_ID_INTEL_82815_CGC    0x1132
>>>   #define PCI_DEVICE_ID_INTEL_SST_TNG    0x119a
>>>   #define PCI_DEVICE_ID_INTEL_DSA_GNRD    0x11fb
>>> +#define PCI_DEVICE_ID_INTEL_DSA_DMR    0x1212
>>> +#define PCI_DEVICE_ID_INTEL_IAX_DMR    0x1216
>>
>> s/IAX/IAA/ ?
> 
> Ditto.
> 
>>
>>>   #define PCI_DEVICE_ID_INTEL_82092AA_0    0x1221
>>>   #define PCI_DEVICE_ID_INTEL_82437    0x122d
>>>   #define PCI_DEVICE_ID_INTEL_82371FB_0    0x122e
> 
> Thanks.
> 
> -Fenghua

