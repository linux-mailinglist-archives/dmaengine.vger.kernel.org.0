Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEA3C1574
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jul 2021 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGHOwH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Jul 2021 10:52:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:44802 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHOwG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Jul 2021 10:52:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295155383"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="295155383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 07:49:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="487635956"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.55.119]) ([10.212.55.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 07:49:23 -0700
Subject: Re: [PATCH] dmaengine: idxd: Simplify code and axe the use of a
 deprecated API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <70c8a3bc67e41c5fefb526ecd64c5174c1e2dc76.1625720835.git.christophe.jaillet@wanadoo.fr>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <6224f6aa-b460-4f18-99d0-38b29998a57d@intel.com>
Date:   Thu, 8 Jul 2021 07:49:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <70c8a3bc67e41c5fefb526ecd64c5174c1e2dc76.1625720835.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/7/2021 10:08 PM, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
> and less verbose 'dma_set_mask_and_coherent()' call.
>
> Even if the code may look different, it should have exactly the same
> run-time behavior.
> If pci_set_dma_mask(64) fails and pci_set_dma_mask(32) succeeds, then
> pci_set_consistent_dma_mask(64) will also fail.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Dave Jiang <dave.jiang@intel.com>

thanks.

> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>     https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>   drivers/dma/idxd/init.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index c8ae41d36040..de300ba38b14 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -637,15 +637,9 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	}
>   
>   	dev_dbg(dev, "Set DMA masks\n");
> -	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   	if (rc)
> -		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> -	if (rc)
> -		goto err;
> -
> -	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc)
> -		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   	if (rc)
>   		goto err;
>   
