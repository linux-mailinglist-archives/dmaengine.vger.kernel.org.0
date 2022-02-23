Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3194C0A3D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 04:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiBWDat (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 22:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiBWDas (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 22:30:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539F38DB9;
        Tue, 22 Feb 2022 19:30:20 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K3M2q1hbHzcn5D;
        Wed, 23 Feb 2022 11:29:07 +0800 (CST)
Received: from [10.67.103.22] (10.67.103.22) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Feb
 2022 11:30:18 +0800
Message-ID: <5882d4c4-8ab9-0d33-91eb-ac4cfcd189b6@hisilicon.com>
Date:   Wed, 23 Feb 2022 11:30:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] dmaengine: hisi_dma: fix MSI allocate fail when reload
 hisi_dma
To:     Jie Hai <haijie1@huawei.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220216072101.34473-1-haijie1@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20220216072101.34473-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.22]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Remove the loaded hisi_dma driver and reload it, the driver fails
> to work properly. The following error is reported in the kernel log:
> 
> [ 1475.597609] hisi_dma 0000:7b:00.0: Failed to allocate MSI vectors!
> [ 1475.604915] hisi_dma: probe of 0000:7b:00.0 failed with error -28
> 
> As noted in "The MSI Driver Guide HOWTO"[1], the number of MSI
> interrupt must be a power of two. The Kunpeng DMA driver allocates 30
> MSI interrupts. As a result, no space left on device is reported
> when the driver is reloaded and allocates interrupt vectors from the
> interrupt domain.
> 
> This patch changes the number of interrupt vectors allocated by
> hisi_dma driver to 32 to avoid this problem.
> 
> [1] https://www.kernel.org/doc/html/latest/PCI/msi-howto.html
> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>

Thanks for fixing it.

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Best,
Zhou

> ---
>  drivers/dma/hisi_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 97c87a7cba87..43817ced3a3e 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -30,7 +30,7 @@
>  #define HISI_DMA_MODE			0x217c
>  #define HISI_DMA_OFFSET			0x100
>  
> -#define HISI_DMA_MSI_NUM		30
> +#define HISI_DMA_MSI_NUM		32
>  #define HISI_DMA_CHAN_NUM		30
>  #define HISI_DMA_Q_DEPTH_VAL		1024
>  
> 
