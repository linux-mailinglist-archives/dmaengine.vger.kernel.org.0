Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454456B103
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 05:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiGHDQi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiGHDQi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 23:16:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180B7479E;
        Thu,  7 Jul 2022 20:16:36 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LfJKg03j7zkXKY;
        Fri,  8 Jul 2022 11:14:31 +0800 (CST)
Received: from [10.67.103.22] (10.67.103.22) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 11:16:35 +0800
Message-ID: <8848a346-0c4b-3752-5c26-3326a51cc2f0@hisilicon.com>
Date:   Fri, 8 Jul 2022 11:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/7] dmaengine: hisilicon: Add support for hisi dma
 driver
Content-Language: en-US
To:     Jie Hai <haijie1@huawei.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20220629035549.44181-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.22]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/6/29 11:55, Jie Hai wrote:
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
> 4. Dump registers for HIP08 and HIP09 DMA driver with debugfs
> 5. Add myself as maintainer of hisi_dma.c
> 
> Changes since version 1:
>  - fix compile failure reported by kernel test robot
>  - fix reduldant "*" in comment
>  - fix reduldant blank line in commit log
>  - remove debugfs-hisi-dma doc and path in MAINTAINERS
>  - add more explanations in patch 3/7
> 
> Jie Hai (7):
>   dmaengine: hisilicon: Disable channels when unregister hisi_dma
>   dmaengine: hisilicon: Fix CQ head update
>   dmaengine: hisilicon: Add multi-thread support for a DMA channel
>   dmaengine: hisilicon: Use macros instead of magic number
>   dmaengine: hisilicon: Adapt DMA driver to HiSilicon IP09
>   dmaengine: hisilicon: Add dfx feature for hisi dma driver
>   MAINTAINERS: Add myself as maintainer for hisi_dma
> 
>  MAINTAINERS            |   1 +
>  drivers/dma/hisi_dma.c | 730 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 635 insertions(+), 96 deletions(-)
>
For the whole series:

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks for the bug fixes and supporting for IP09 dma :)

Best,
Zhou




