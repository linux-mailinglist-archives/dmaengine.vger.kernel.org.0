Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B276A12328E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfLQQdj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 11:33:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:8478 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfLQQdi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 11:33:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 08:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="221792307"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 08:33:37 -0800
Subject: Re: [PATCH 5/5] dmaengine: ioat: Support in-use unbind
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>
References: <20191216190120.21374-1-logang@deltatee.com>
 <20191216190120.21374-6-logang@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <9cc20739-2a02-b4e1-b5e6-9578fe9314ef@intel.com>
Date:   Tue, 17 Dec 2019 09:33:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191216190120.21374-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/16/19 12:01 PM, Logan Gunthorpe wrote:
> Don't allocate memory using the devm infrastructure and instead call
> kfree with the new dmaengine device_release call back. This ensures
> the structures are available until the last reference is dropped.
> 
> We also need to ensure we call ioat_shutdown() in ioat_remove() so
> that all the channels are quiesced and further transaction fails.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/init.c | 38 ++++++++++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index a6a6dc432db8..60e9afbb896c 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -556,10 +556,6 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
>   	ioat_kobject_del(ioat_dma);
>   
>   	dma_async_device_unregister(dma);
> -
> -	dma_pool_destroy(ioat_dma->completion_pool);
> -
> -	INIT_LIST_HEAD(&dma->channels);
>   }
>   
>   /**
> @@ -589,7 +585,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
>   	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
>   
>   	for (i = 0; i < dma->chancnt; i++) {
> -		ioat_chan = devm_kzalloc(dev, sizeof(*ioat_chan), GFP_KERNEL);
> +		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
>   		if (!ioat_chan)
>   			break;
>   
> @@ -624,12 +620,16 @@ static void ioat_free_chan_resources(struct dma_chan *c)
>   		return;
>   
>   	ioat_stop(ioat_chan);
> -	ioat_reset_hw(ioat_chan);
>   
> -	/* Put LTR to idle */
> -	if (ioat_dma->version >= IOAT_VER_3_4)
> -		writeb(IOAT_CHAN_LTR_SWSEL_IDLE,
> -			ioat_chan->reg_base + IOAT_CHAN_LTR_SWSEL_OFFSET);
> +	if (!test_bit(IOAT_CHAN_DOWN, &ioat_chan->state)) {
> +		ioat_reset_hw(ioat_chan);
> +
> +		/* Put LTR to idle */
> +		if (ioat_dma->version >= IOAT_VER_3_4)
> +			writeb(IOAT_CHAN_LTR_SWSEL_IDLE,
> +			       ioat_chan->reg_base +
> +			       IOAT_CHAN_LTR_SWSEL_OFFSET);
> +	}
>   
>   	spin_lock_bh(&ioat_chan->cleanup_lock);
>   	spin_lock_bh(&ioat_chan->prep_lock);
> @@ -1322,16 +1322,28 @@ static struct pci_driver ioat_pci_driver = {
>   	.err_handler	= &ioat_err_handler,
>   };
>   
> +static void release_ioatdma(struct dma_device *device)
> +{
> +	struct ioatdma_device *d = to_ioatdma_device(device);
> +	int i;
> +
> +	for (i = 0; i < IOAT_MAX_CHANS; i++)
> +		kfree(d->idx[i]);
> +
> +	dma_pool_destroy(d->completion_pool);
> +	kfree(d);
> +}
> +
>   static struct ioatdma_device *
>   alloc_ioatdma(struct pci_dev *pdev, void __iomem *iobase)
>   {
> -	struct device *dev = &pdev->dev;
> -	struct ioatdma_device *d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
> +	struct ioatdma_device *d = kzalloc(sizeof(*d), GFP_KERNEL);
>   
>   	if (!d)
>   		return NULL;
>   	d->pdev = pdev;
>   	d->reg_base = iobase;
> +	d->dma_dev.device_release = release_ioatdma;
>   	return d;
>   }
>   
> @@ -1400,6 +1412,8 @@ static void ioat_remove(struct pci_dev *pdev)
>   	if (!device)
>   		return;
>   
> +	ioat_shutdown(pdev);
> +
>   	dev_err(&pdev->dev, "Removing dma and dca services\n");
>   	if (device->dca) {
>   		unregister_dca_provider(device->dca, &pdev->dev);
> 
