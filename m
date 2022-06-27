Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494255C2C0
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiF0HBw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 27 Jun 2022 03:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0HBv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 03:01:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489D5F7E;
        Mon, 27 Jun 2022 00:01:49 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWdsT55gFzkWpD;
        Mon, 27 Jun 2022 15:00:29 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 15:01:16 +0800
Received: from kwepemm600007.china.huawei.com ([7.193.23.208]) by
 kwepemm600007.china.huawei.com ([7.193.23.208]) with mapi id 15.01.2375.024;
 Mon, 27 Jun 2022 15:01:16 +0800
From:   haijie <haijie1@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Thread-Topic: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Thread-Index: AQHYiGfM3YbFHDZNZ0e0XQ9uDDsCpq1iQvQAgACSJCA=
Date:   Mon, 27 Jun 2022 07:01:16 +0000
Message-ID: <494c689c9141429caae0285a9e778c3b@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-3-haijie1@huawei.com> <YrlKZgC999AYMvXY@matsya>
In-Reply-To: <YrlKZgC999AYMvXY@matsya>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.102.167]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Vinod,

This happens bacause I rearranged this patch without checking, it will be corrected in v2.

Thanks.

-----Original Message-----
From: Vinod Koul [mailto:vkoul@kernel.org] 
Sent: Monday, June 27, 2022 2:13 PM
To: haijie <haijie1@huawei.com>
Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update

On 25-06-22, 15:44, Jie Hai wrote:
> After completion of data transfer of one or multiple descriptors, the 
> completion status and the current head pointer to submission queue are 
> written into the CQ and interrupt can be generated to inform the 
> software. In interrupt process CQ is read and cq_head is updated.
> 
> hisi_dma_irq updates cq_head only when the completion status is 
> success. When an abnormal interrupt reports, cq_head will not update 
> which will cause subsequent interrupt processes read the error CQ and 
> never report the correct status.
> 
> This patch updates cq_head whenever CQ is accessed.
> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine 
> support")
> 

No need for blank line
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/hisi_dma.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c index 
> 98bc488893cc..0a0f8a4d168a 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -436,12 +436,11 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  	desc = chan->desc;
>  	cqe = chan->cq + chan->cq_head;
>  	if (desc) {
> +		chan->cq_head = (chan->cq_head + 1) %
> +				hdma_dev->chan_depth;
> +		hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,

q_base?

--
~Vinod
