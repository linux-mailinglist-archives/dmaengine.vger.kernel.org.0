Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56BB6AF65D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 21:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCGUGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 15:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCGUGP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 15:06:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06292BE8;
        Tue,  7 Mar 2023 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678219565; x=1709755565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2F+uMaOkT3qnyU2/Hb3cLjh0rfwHY1neNBaXD6JrhM=;
  b=hOA0JGb7nVqObhYqhNNfTx9YALD7nx8UAzxTDdpIVof3upJXLIvMu28e
   bYFpFtfgExvtjC+e93SN7doJJO6B3HlZCnXd7pBrT2M070W8Y+5rl6sh3
   StTjhkcuJHmZF5dc7qE39KNIQiiYhzG2TEEBKdCANbHKcTXGAbuYCrbjf
   aJiumx3aNKspdqyDbVT3xr9B62OJ0ONFsG0xSVwjwwa5JA169SdTaOjBq
   q00uT5mavtbgmhSk74pLkE+a+VTQQsjsSksjjsGBSp2aAOATdN0sHOQVd
   lCioexzQ6y6cV7nAVmuR1QmwXGtUtQYb8PVKNgefTEnbvc+Z0yU4bMzyI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334673427"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334673427"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679081264"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="679081264"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.116.173]) ([10.212.116.173])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:06:04 -0800
Message-ID: <675d14dc-24e7-7665-6e73-cf08248c5c18@intel.com>
Date:   Tue, 7 Mar 2023 13:06:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dmaengine: ioat: Drop redundant
 pci_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230307192655.874008-1-helgaas@kernel.org>
 <20230307192655.874008-2-helgaas@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230307192655.874008-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/7/23 12:26 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/init.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 5d707ff63554..6ca62edf47bd 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -15,7 +15,6 @@
>   #include <linux/workqueue.h>
>   #include <linux/prefetch.h>
>   #include <linux/dca.h>
> -#include <linux/aer.h>
>   #include <linux/sizes.h>
>   #include "dma.h"
>   #include "registers.h"
> @@ -1380,15 +1379,11 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		if (is_skx_ioat(pdev))
>   			device->version = IOAT_VER_3_2;
>   		err = ioat3_dma_probe(device, ioat_dca_enabled);
> -
> -		if (device->version >= IOAT_VER_3_3)
> -			pci_enable_pcie_error_reporting(pdev);
>   	} else
>   		return -ENODEV;
>   
>   	if (err) {
>   		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
> -		pci_disable_pcie_error_reporting(pdev);
>   		return -ENODEV;
>   	}
>   
> @@ -1411,7 +1406,6 @@ static void ioat_remove(struct pci_dev *pdev)
>   		device->dca = NULL;
>   	}
>   
> -	pci_disable_pcie_error_reporting(pdev);
>   	ioat_dma_remove(device);
>   }
>   
