Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74E13D163
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 02:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAPBLF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 20:11:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbgAPBLF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jan 2020 20:11:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C39ED3220F7E9B3D5759;
        Thu, 16 Jan 2020 09:11:02 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 09:10:35 +0800
Subject: Re: [PATCH v4] dmaengine: hisilicon: Add Kunpeng DMA engine support
To:     Vinod Koul <vkoul@kernel.org>
References: <1577932428-217801-1-git-send-email-wangzhou1@hisilicon.com>
 <20200115142534.GM2818@vkoul-mobl>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E1FB80A.4030607@hisilicon.com>
Date:   Thu, 16 Jan 2020 09:10:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200115142534.GM2818@vkoul-mobl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/1/15 22:25, Vinod Koul wrote:
> On 02-01-20, 10:33, Zhou Wang wrote:
> 
>> +#define HISI_DMA_SQ_BASE_L(i)		(0x0 + (i) * 0x100)
>> +#define HISI_DMA_SQ_BASE_H(i)		(0x4 + (i) * 0x100)
>> +#define HISI_DMA_SQ_DEPTH(i)		(0x8 + (i) * 0x100)
>> +#define HISI_DMA_SQ_TAIL_PTR(i)		(0xc + (i) * 0x100)
>> +#define HISI_DMA_CQ_BASE_L(i)		(0x10 + (i) * 0x100)
>> +#define HISI_DMA_CQ_BASE_H(i)		(0x14 + (i) * 0x100)
>> +#define HISI_DMA_CQ_DEPTH(i)		(0x18 + (i) * 0x100)
>> +#define HISI_DMA_CQ_HEAD_PTR(i)		(0x1c + (i) * 0x100)
>> +#define HISI_DMA_CTRL0(i)		(0x20 + (i) * 0x100)
>> +#define HISI_DMA_CTRL0_QUEUE_EN_S	0
>> +#define HISI_DMA_CTRL0_QUEUE_PAUSE_S	4
>> +#define HISI_DMA_CTRL1(i)		(0x24 + (i) * 0x100)
>> +#define HISI_DMA_CTRL1_QUEUE_RESET_S	0
>> +#define HISI_DMA_Q_FSM_STS(i)		(0x30 + (i) * 0x100)
>> +#define HISI_DMA_FSM_STS_MASK		GENMASK(3, 0)
>> +#define HISI_DMA_INT_STS(i)		(0x40 + (i) * 0x100)
>> +#define HISI_DMA_INT_STS_MASK		GENMASK(12, 0)
>> +#define HISI_DMA_INT_MSK(i)		(0x44 + (i) * 0x100)
> 
> These really sound as offset + i * 0x100, so I think it might be better
> to define this as:
> 
> define HISI_DMA_SQ_BASE_L               0x0
> with HISI_DMA_OFFSET                    0x100
> 
> and then use read/write accessors:
> 
> hisi_channel_read(... , register, index)
> {
>         return readl( register + index * HISI_DMA_OFFSET)
> }
>

OK, I will modify this in v5.

>> +#define HISI_DMA_MODE			0x217c
>> +
>> +#define HISI_DMA_MSI_NUM		30
>> +#define HISI_DMA_CHAN_NUM		30
>> +#define HISI_DMA_Q_DEPTH_VAL		1024
>> +
>> +#define PCI_DEVICE_ID_HISI_DMA		0xa122
> 
> This is used only once so can be removed

OK.

> 
>> +static void hisi_dma_reset_hw_chan(struct hisi_dma_chan *chan)
>> +{
>> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
>> +	u32 index = chan->qp_num, tmp;
>> +	int ret;
>> +
>> +	hisi_dma_pause_dma(hdma_dev, index, true);
>> +	hisi_dma_enable_dma(hdma_dev, index, false);
>> +	hisi_dma_mask_irq(hdma_dev, index);
>> +
>> +	ret = readl_relaxed_poll_timeout(hdma_dev->base +
>> +		HISI_DMA_Q_FSM_STS(index), tmp,
>> +		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) != RUN, 10, 1000);
>> +	if (ret) {
>> +		dev_err(&hdma_dev->pdev->dev, "disable channel timeout!\n");
>> +		BUG_ON(1);
> 
> we dont kill kernel on this! you should probably complain violently
> (dump_stack() etc)...)
> 

OK, will change to WARN_ON in v5.

Thanks for your help!
Zhou

