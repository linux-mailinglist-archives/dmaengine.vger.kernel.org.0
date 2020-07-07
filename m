Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64E216D41
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGM5X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 08:57:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGM5W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 08:57:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067CvJNo023236;
        Tue, 7 Jul 2020 07:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594126639;
        bh=XL8Adktr4+l9LEfgRz84PfAGMebahASmc5meg1ybQkY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RsasZyhLO9IYvjNb3cUyJ6JaaShTu0XM62CAknC6MHJDokWYpFIZO+xMBtXnA3GQq
         4EGPYaWLdqN3stHCycr40f/cmKR2Q3msuvFEz+0s9liw9qe+j0hJQ3mbRs6bNQX7nh
         rgbB7gjBdS07tEaUoKEHKPTHypiwkrplIDUl+fag=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 067CvJEF083013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 07:57:19 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 07:57:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 07:57:19 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067CvHXL055502;
        Tue, 7 Jul 2020 07:57:18 -0500
Subject: Re: [PATCH v2 0/5] dmaengine: ti: k3-udma: cleanups for 5.8
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20200707102352.28773-1-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <559a6306-27b7-cbed-ca55-60709a94744e@ti.com>
Date:   Tue, 7 Jul 2020 15:57:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707102352.28773-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/07/2020 13:23, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> Changes since v1:
> - drop the check against NULL for uc in the IO functions as pointed out by
>    Grygorii
> 
> Tested on top of linux-next, but they apply (with offsets) on top of
> dmaengine/next.
> 
> Few patches to clean up the code mostly with the exception of removing the use
> of ring_get_occ() from udma_pop_from_ring().
> 
> This series should not conflict with Grygorii's ringacc update patch, they touch
> the code in different areas.
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (5):
>    dmaengine: ti: k3-udma: Remove dma_sync_single calls for descriptors
>    dmaengine: ti: k3-udma: Do not use ring_get_occ in udma_pop_from_ring
>    dmaengine: ti: k3-udma: Use common defines for TCHANRT/RCHANRT
>      registers
>    dmaengine: ti: k3-udma-private: Use udma_read/write for register
>      access
>    dmaengine: ti: k3-udma: Use udma_chan instead of tchan/rchan for IO
>      functions
> 
>   drivers/dma/ti/k3-udma-glue.c    |  79 +++++------
>   drivers/dma/ti/k3-udma-private.c |   8 +-
>   drivers/dma/ti/k3-udma.c         | 236 +++++++++++++------------------
>   drivers/dma/ti/k3-udma.h         |  61 +++-----
>   4 files changed, 161 insertions(+), 223 deletions(-)
> 

Thank you
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
