Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752025A5D37
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 09:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiH3HpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiH3HpT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 03:45:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452C15A2D;
        Tue, 30 Aug 2022 00:45:18 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGzmp43d9znTt0;
        Tue, 30 Aug 2022 15:42:50 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 15:45:15 +0800
Received: from [10.67.102.167] (10.67.102.167) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 15:45:15 +0800
Message-ID: <bf8ccd6f-b58d-8296-9e33-e7c32243922f@huawei.com>
Date:   Tue, 30 Aug 2022 15:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESENT PATCH v5 0/7] dmaengine: hisilicon: Add support for hisi
 dma driver
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220830060555.50781-1-haijie1@huawei.com>
In-Reply-To: <20220830060555.50781-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.167]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/8/30 14:05, Jie Hai wrote:
Sorry for incorrect titles with "RESENT", please drop this patch set and 
follow the latest.
> The HiSilicon IP08 and HiSilicon IP09 are DMA iEPs, they share the
> same pci device id but different pci revision and register layouts.
> 
> The original version supports HiSilicon IP08 but not HiSilicon IP09.
> This series support DMA driver for HIP08 and HIP09:
> 1. Fix bugs for HIP08 DMA driver
> 	- Disable hardware channels when driver detached
> 	- Update cq_head whenever accessed it
> 	- Support multi-thread for one DMA channel
> 2. Use macros instead of magic number
> 3. Add support for HIP09 DMA driver
> 4. Add debugfs for HIP08 and HIP09 DMA driver
> 5. Add myself as maintainer of hisi_dma.c
> 
> Changes since version 4:
>   - Fix hdma_dev->base to hdma_dev->queue_base in hisi_dma_reset_or_disable_hw_chan
> 
> Changes since version 3:
>   - remove reduldant braces
>   - add "Acked-by: Zhou Wang <wangzhou1@hisilicon.com>" in commit log
> 
> Changes since version 2:
>   - fix unnecessary line breaks
>   - fix register bit with BIT/GENMASK and adjust hisi_dma_update_bit to it
>   - remove "Reported-by" in commit message
>   - use dmaengine root instead of hisi_dma root
>   - ignore errors for creating debugfs
> 
> Changes since version 1:
>   - remove error changes casuse compile failure
>   - remove reduldant "*" in comment
>   - remove debugfs-hisi-dma doc and path in MAINTAINERS
> 
> Jie Hai (7):
>    dmaengine: hisilicon: Disable channels when unregister hisi_dma
>    dmaengine: hisilicon: Fix CQ head update
>    dmaengine: hisilicon: Add multi-thread support for a DMA channel
>    dmaengine: hisilicon: Use macros instead of magic number
>    dmaengine: hisilicon: Adapt DMA driver to HiSilicon IP09
>    dmaengine: hisilicon: Dump regs to debugfs
>    MAINTAINERS: Add myself as maintainer for hisi_dma
> 
>   MAINTAINERS            |   1 +
>   drivers/dma/hisi_dma.c | 650 +++++++++++++++++++++++++++++++++++------
>   2 files changed, 555 insertions(+), 96 deletions(-)
> 
