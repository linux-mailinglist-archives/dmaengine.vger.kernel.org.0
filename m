Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BEB494155
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jan 2022 20:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiASTxu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jan 2022 14:53:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:43980 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233089AbiASTxt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Jan 2022 14:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642622029; x=1674158029;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=+U5D9ADrsvYDzOMZJ6dhfHQKSSr4dL70+Ecs5n4Muys=;
  b=LyPh3ERpHhoBKrX18TBoxsRrwATYZIYE27T8x6n3b6JMURU9VR13t8m1
   vHdipUpKbeCljM40hy52Kldy5CU1fheBmOzfvNY999wHPSfbQgKNBxfkW
   NzoHeCM5SH++Ns4ImtHS51wd5CMYTvSHojfYykiHCyO/YM9AHvrYyu1HX
   61HVH9lkpDNV85c5UbZc6ejJHfplkj3vZGpNzCciVsIZA7QSHb9edIMj2
   sPYjl087wqmnRqNYcEPn4bRmpr7mj0lPGsyyFqmurDuvJ06AptSCWScFz
   FZQfmzyT60PFWQ0DvUkosUIJg3igyeaGO52LxQGLbPGZi9M9gd70iqlk6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="331529712"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="331529712"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:53:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="561176604"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.18.248]) ([10.212.18.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:53:41 -0800
Message-ID: <59fefbb9-1bf7-89b3-10f5-93291120574a@intel.com>
Date:   Wed, 19 Jan 2022 12:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, okaya@codeaurora.org
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Walker, Benjamin" <benjamin.walker@intel.com>,
        andriy.shevchenko@linux.intel.com
From:   Dave Jiang <dave.jiang@intel.com>
Subject: DMA_MEMSET definition confusion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod, we are looking at implementing support for DMA memset in idxd driver and looking at the existing code, there seems to be some confusion as to the
expectation of the implementation. The input parameter for the pattern of ->device_prep_dma_memset() is an int, which mimics the POSIX memset() call.
And the way dmatest implemented, it passes in an u8 value as to 'int value' when calling ->device_prep_dma_memset().

I see 3 implementations in 3 of the in tree DMA drivers.

at_hdmac:
at_hdmac.c:
atc_prep_dma_memset()
Allocates a u32 DMA buffer and copies the 'int value' into the u32 memory.

at_xdmac:
at_xdmac.c:
at_xdmac_prep_dma_memset() -> at_xdmac_memset_create_desc()
assign value to desc->ldd.mbr_ds, which is a u32 data stride register

So these 2 drivers basically treats 'int value' as a 32bit pattern value.

hidma:
drivers/dma/qcom/hidma.c
hidma_prep_dma_set() -> hidma_ll_set_transfer_params() <== parm value passed in as third parameter

drivers/dma/qcom/hidma_ll.c:
hidma_llset_transfer_params(lldev, tre_ch, src, ....) <== int value casted to 'dma_addr_t src'
The function then calls lower_32_bits(src) and upper_32_bits(src) to program the DMA device. That just looks wrong.

None of these implementations would pass the dmatest data verification from inspecting the code AFAICT, and they deviate from the original intent of the
memset call IMHO.

So at this point given we have 2 implementations that expects a u32 value, should we just change 'int value' to 'u32 value', fix dmatest to a 32bit
pattern? Or do we introduce a memset32() call for those 2 implementations and specifically use a u32, and also a memset64() call for hidma so at least
it looks sane, and drop the original memset code since there would be no actual implementation for it? Or some other solution....?

For DSA, it takes a 64bit pattern in the descriptor. So we need to decide whether to go with replicating u8 to u64 or u32 to u64.

Thanks.


