Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F0202F76
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgFVFYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 01:24:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgFVFYU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 01:24:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F0D935380A6FDC61A87;
        Mon, 22 Jun 2020 13:24:16 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 22 Jun 2020 13:24:13 +0800
Subject: Re: [PATCH][next] dmaengine: hisilicon: Use struct_size() in
 devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200617211135.GA8660@embeddedor>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5EF0407D.2050007@hisilicon.com>
Date:   Mon, 22 Jun 2020 13:24:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200617211135.GA8660@embeddedor>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/6/18 5:11, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me, thanks!

Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

> ---
>  drivers/dma/hisi_dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index ed3619266a48..e1a958ae7925 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -511,7 +511,6 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct device *dev = &pdev->dev;
>  	struct hisi_dma_dev *hdma_dev;
>  	struct dma_device *dma_dev;
> -	size_t dev_size;
>  	int ret;
>  
>  	ret = pcim_enable_device(pdev);
> @@ -534,9 +533,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
>  
> -	dev_size = sizeof(struct hisi_dma_chan) * HISI_DMA_CHAN_NUM +
> -		   sizeof(*hdma_dev);
> -	hdma_dev = devm_kzalloc(dev, dev_size, GFP_KERNEL);
> +	hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, HISI_DMA_CHAN_NUM), GFP_KERNEL);
>  	if (!hdma_dev)
>  		return -EINVAL;
>  
> 
