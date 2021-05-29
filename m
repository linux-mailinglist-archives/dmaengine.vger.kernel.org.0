Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F404394B35
	for <lists+dmaengine@lfdr.de>; Sat, 29 May 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhE2JPY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 May 2021 05:15:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2091 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhE2JPY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 May 2021 05:15:24 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsbMn3F9CzWnql;
        Sat, 29 May 2021 17:09:09 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:13:47 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 17:13:46 +0800
Subject: Re: [PATCH 0/3] cleanup patches for PM reference leak
To:     <vkoul@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <yi.zhang@huawei.com>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5ffefa65-121b-d1d8-78f0-ee0167f71e52@huawei.com>
Date:   Sat, 29 May 2021 17:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210517081826.1564698-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ping ...

On 2021/05/17 16:18, Yu Kuai wrote:
> Yu Kuai (3):
>    dmaengine: stm32-mdma: fix PM reference leak in
>      stm32_mdma_alloc_chan_resourc()
>    dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()
>    dmaengine: zynqmp_dma: Fix PM reference leak in
>      zynqmp_dma_alloc_chan_resourc()
> 
>   drivers/dma/sh/usb-dmac.c       | 2 +-
>   drivers/dma/stm32-mdma.c        | 4 ++--
>   drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
