Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B843F11AA19
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 12:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfLKLnq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 06:43:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfLKLnq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 06:43:46 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28FF54857F20124B918A;
        Wed, 11 Dec 2019 19:43:43 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 19:43:34 +0800
Subject: Re: [PATCH v2] dmaengine: hisilicon: Add Kunpeng DMA engine support
To:     Vinod Koul <vkoul@kernel.org>
References: <1575943997-164744-1-git-send-email-wangzhou1@hisilicon.com>
 <20191211105234.GG2536@vkoul-mobl>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5DF0D666.6060908@hisilicon.com>
Date:   Wed, 11 Dec 2019 19:43:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191211105234.GG2536@vkoul-mobl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/12/11 18:52, Vinod Koul wrote:
> On 10-12-19, 10:13, Zhou Wang wrote:
>> This patch adds a driver for HiSilicon Kunpeng DMA engine.
> 
> Can you please describe this controller here, how many channels,
> controller capabilities etc

OK, will add related description about this controller.

> 
>> +static void hisi_dma_enable_dma(struct hisi_dma_dev *hdma_dev, u32 index,
>> +				bool enable)
> 
> Coding Style expects the second line to be aligned to preceding line
> brace opne, --strict option with checkpatch should warn you!

seems code it right, just looks wrong in patch. However, I checked
whole patch again with --strict, find some other warnings, will fix them
in next version.

> 
>> +{
>> +	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0(index);
>> +	u32 tmp;
>> +
>> +	tmp = readl_relaxed(addr);
>> +	tmp = enable ? tmp | HISI_DMA_CTRL0_QUEUE_EN :
>> +		       tmp & ~HISI_DMA_CTRL0_QUEUE_EN;
>> +	writel_relaxed(tmp, addr);
>> +}
> 
> why not create a modifyl() macro and then use that here and other places
> rather than doiun read, modify, write sequence

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
>> +	if (ret)
>> +		dev_err(&hdma_dev->pdev->dev, "disable channel timeout!\n");
> 
> you want to continue on this timeout?

need find a way to handle this, thanks.

> 
>> +static int hisi_dma_terminate_all(struct dma_chan *c)
>> +{
>> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
>> +	unsigned long flags;
>> +	LIST_HEAD(head);
>> +
>> +	spin_lock_irqsave(&chan->vc.lock, flags);
>> +
>> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
>> +	if (chan->desc) {
>> +		vchan_terminate_vdesc(&chan->desc->vd);
>> +		chan->desc = NULL;
>> +	}
>> +
>> +	vchan_get_all_descriptors(&chan->vc, &head);
>> +
>> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> +
>> +	vchan_dma_desc_free_list(&chan->vc, &head);
>> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);
> 
> pause on terminate? Not DISABLE?

here this function just aborts transfers on specific channel.

> 
>> +static struct pci_driver hisi_dma_pci_driver = {
>> +	.name		= "hisi_dma",
>> +	.id_table	= hisi_dma_pci_tbl,
>> +	.probe		= hisi_dma_probe,
> 
> no .remove and kconfig has a tristate option!

Use devres APIs in probe, so seems nothing should be done in remove :)

Best,
Zhou

> 
>> +MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
>> +MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
>> +MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
>> +MODULE_LICENSE("GPL");
> 
> GPL v2..
> 

