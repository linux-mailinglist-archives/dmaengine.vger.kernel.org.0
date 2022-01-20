Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2349469C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jan 2022 05:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358551AbiATEye (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jan 2022 23:54:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39280 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiATEye (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jan 2022 23:54:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DC3B81C95
        for <dmaengine@vger.kernel.org>; Thu, 20 Jan 2022 04:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0591AC340E0;
        Thu, 20 Jan 2022 04:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642654471;
        bh=KFstp9rERn5ey0sGaldWn/9sicPi9x1VmxAefPpRJSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ost5Zi4I8PtW1n7Ha4HeEvH95Ndp4Myb2XNFNE8IVlgesJ8mb2LcVcZTwbqwILTsZ
         6sO+EgRPnSMfHiTNO6VoIpkeIcGJTu01rg+1831SQ7kqHwTwDTWLVBnr9TtWAGhBHT
         Bu1Hr8RkcvLWMufQ8ClBibmGuMJ6/764O2malPPh3GQKlx8dPEBg5whCCOnDrVspgE
         zCq8MfyoTnYUzDNvZO2MeLPRL1PNqt3Angrg6+MQxtFGwBsbqNoxs7IdZp7rg2mcXE
         HeiGTxDZK9cwH/EG74jY5Vfg62olu26qEcBOv1NfbYnJ16qjLAKfz42ZLfri2DiehU
         Xgly+jCoIhACw==
Date:   Thu, 20 Jan 2022 10:24:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     okaya@codeaurora.org,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Walker, Benjamin" <benjamin.walker@intel.com>,
        andriy.shevchenko@linux.intel.com
Subject: Re: DMA_MEMSET definition confusion
Message-ID: <YejrA5ZWZ3lTRO/1@matsya>
References: <59fefbb9-1bf7-89b3-10f5-93291120574a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59fefbb9-1bf7-89b3-10f5-93291120574a@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-01-22, 12:53, Dave Jiang wrote:
> Hi Vinod, we are looking at implementing support for DMA memset in idxd driver and looking at the existing code, there seems to be some confusion as to the
> expectation of the implementation. The input parameter for the pattern of ->device_prep_dma_memset() is an int, which mimics the POSIX memset() call.
> And the way dmatest implemented, it passes in an u8 value as to 'int value' when calling ->device_prep_dma_memset().
> 
> I see 3 implementations in 3 of the in tree DMA drivers.
> 
> at_hdmac:
> at_hdmac.c:
> atc_prep_dma_memset()
> Allocates a u32 DMA buffer and copies the 'int value' into the u32 memory.
> 
> at_xdmac:
> at_xdmac.c:
> at_xdmac_prep_dma_memset() -> at_xdmac_memset_create_desc()
> assign value to desc->ldd.mbr_ds, which is a u32 data stride register
> 
> So these 2 drivers basically treats 'int value' as a 32bit pattern value.

IMO that is incorrect and should be fixed, the intent of memset should
is to provide an signed int value.

> 
> hidma:
> drivers/dma/qcom/hidma.c
> hidma_prep_dma_set() -> hidma_ll_set_transfer_params() <== parm value passed in as third parameter
> 
> drivers/dma/qcom/hidma_ll.c:
> hidma_llset_transfer_params(lldev, tre_ch, src, ....) <== int value casted to 'dma_addr_t src'
> The function then calls lower_32_bits(src) and upper_32_bits(src) to program the DMA device. That just looks wrong.
> 
> None of these implementations would pass the dmatest data verification from inspecting the code AFAICT, and they deviate from the original intent of the
> memset call IMHO.
> 
> So at this point given we have 2 implementations that expects a u32 value, should we just change 'int value' to 'u32 value', fix dmatest to a 32bit
> pattern? Or do we introduce a memset32() call for those 2 implementations and specifically use a u32, and also a memset64() call for hidma so at least
> it looks sane, and drop the original memset code since there would be no actual implementation for it? Or some other solution....?

we should have memset() take int and fix the users.

> For DSA, it takes a 64bit pattern in the descriptor. So we need to decide whether to go with replicating u8 to u64 or u32 to u64.
> 
> Thanks.
> 

-- 
~Vinod
