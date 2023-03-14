Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF846B892E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Mar 2023 04:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCNDva (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNDv3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 23:51:29 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C52738AF;
        Mon, 13 Mar 2023 20:51:27 -0700 (PDT)
Received: from 30.221.133.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VdqWb7B_1678765884)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 11:51:25 +0800
Message-ID: <04cc510b-6d66-99b5-4fe8-f51729299574@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 11:51:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/5] dmaengine: sprd: Don't set chancnt
To:     Jisheng Zhang <jszhang@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20230313170250.815-1-jszhang@kernel.org>
 <20230313170250.815-6-jszhang@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230313170250.815-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/14/2023 1:02 AM, Jisheng Zhang wrote:
> The dma framework will calculate the dma channels chancnt, setting it
> outself is wrong.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/dma/sprd-dma.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 474d3ba8ec9f..2b639adb48ba 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1169,7 +1169,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
>   
>   	dma_cap_set(DMA_MEMCPY, sdev->dma_dev.cap_mask);
>   	sdev->total_chns = chn_count;
> -	sdev->dma_dev.chancnt = chn_count;
>   	INIT_LIST_HEAD(&sdev->dma_dev.channels);
>   	INIT_LIST_HEAD(&sdev->dma_dev.global_node);
>   	sdev->dma_dev.dev = &pdev->dev;
