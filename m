Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9081A4910DB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiAQUGJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 15:06:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:30123 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235671AbiAQUGI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Jan 2022 15:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642449968; x=1673985968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bkKHnyJ7fNQ9UDJcRCjjrULZ9FpJnVUdJPwib2T8Bi4=;
  b=nl7zN2vNXd/L5RcZBbhLyHDogoAxhIWcZsUeOeBf04Zdti6YaLKLyRvS
   XHPe5sfHATHk7COdRVfMzh7W4wna/reYmoGyycRPykI4TPKY3+5P0TCST
   W6WgdFa34yHh6JgIiL44R7SMcX2hyR8pAdPm37sUdmTmfc9zMG4N/IGCw
   uWQKxVtP4nA//K7I5IZOySSgdnSPgWhE4Oq9aE/vchzn4ebPYmwwu5uVg
   V+VPHKnPciJD6nAjUQHyy3V0b9MNaziBsjbf7mBvSF2/HUxrQQV+gZlQu
   yHgpd4+AlSLAHTtgYHb6oz/se73P/JsTItOmZTzA2Q4oLZCo+n8ci8oQl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243511786"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="243511786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 12:06:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625284468"
Received: from sycha-mobl1.amr.corp.intel.com (HELO [10.209.168.94]) ([10.209.168.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 12:06:07 -0800
Message-ID: <123e3681-d247-80a3-a40d-884603c7ee16@intel.com>
Date:   Mon, 17 Jan 2022 13:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] dmaengine: idxd: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <009c80294dba72858cd8a6ed2ed81041df1b1e82.1642231430.git.christophe.jaillet@wanadoo.fr>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <009c80294dba72858cd8a6ed2ed81041df1b1e82.1642231430.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/15/2022 12:24 AM, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
>
> Simplify code and remove some dead code accordingly.
>
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks.

> ---
>   drivers/dma/idxd/init.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 08a5f4310188..993a5dcca24f 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -604,8 +604,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	dev_dbg(dev, "Set DMA masks\n");
>   	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -	if (rc)
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   	if (rc)
>   		goto err;
>   
