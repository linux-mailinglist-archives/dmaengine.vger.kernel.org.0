Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B684E5107
	for <lists+dmaengine@lfdr.de>; Wed, 23 Mar 2022 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiCWLLh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Mar 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiCWLLg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Mar 2022 07:11:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF878061;
        Wed, 23 Mar 2022 04:10:06 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KNlsD5kC9zBrWR;
        Wed, 23 Mar 2022 19:06:08 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 19:10:04 +0800
Subject: Re: [PATCH] dmaengine: hisi_dma: fix MSI allocate fail when reload
 hisi_dma
To:     Jie Hai <haijie1@huawei.com>, <wangzhou1@hisilicon.com>,
        <vkoul@kernel.org>
References: <20220216072101.34473-1-haijie1@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <cc687bb8-c1b5-d54a-a563-bd8f3923e7b5@huawei.com>
Date:   Wed, 23 Mar 2022 19:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220216072101.34473-1-haijie1@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500017.china.huawei.com (7.221.188.110)
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

Looks good.

Reviewed-by: Dongdong Liu <liudongdong3@huawei.com>

Thanks,
Dongdong
On 2022/2/16 15:21, Jie Hai wrote:
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
