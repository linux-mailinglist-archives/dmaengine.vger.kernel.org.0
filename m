Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310B6AF7FD
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 22:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGVuO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCGVuL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 16:50:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3856164;
        Tue,  7 Mar 2023 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678225810; x=1709761810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=77dMKDKBCqeHL/BHmh65e59P0A/ZjNveCWI4JDmFEZA=;
  b=UUX5VioKVRc7gcShTU24XxcSbgLSi7qhevbpwWXnhyaLufUdFZ2O6OX6
   XbEewKsn0HyCURKQnPkILVhaQ6ZuV4IN27rQT0S0i/krxt1sjBLPh0phL
   4muuRTcVGoI/fglUON+x0L5LeGEFFAw5HwG9lbPVBJqMAmytOnYnZU4ew
   rODVeIH1XerNfMX+LyuvGX67816nLznZdHx84daK/0e+LcZ3sq1qygYOZ
   br4BVI1VLdAzWTG8lK7V10atv7EVEc4G3DVJWMZ41+zao+HjlGD+67W8D
   h4OoHYYLlw9vVM9Tv1C2gdxq2xpKzxSaZZrWaSujZ/kE98qm/OlvoLXXY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333455340"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="333455340"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="670082995"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="670082995"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.116.173]) ([10.212.116.173])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:50:09 -0800
Message-ID: <18a73c95-53da-9acb-9e10-0e6095e7dd31@intel.com>
Date:   Tue, 7 Mar 2023 14:50:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] dmaengine: ioat: use PCI core macros for PCIe Capability
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230307214615.887354-1-helgaas@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230307214615.887354-1-helgaas@kernel.org>
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



On 3/7/23 2:46 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe Capability is defined by the PCIe spec, so use the PCI_EXP_DEVCTL
> macros defined by the PCI core instead of defining copies in IOAT.  This
> makes it easier to find all uses of the PCIe Device Control register.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/init.c      | 6 +++---
>   drivers/dma/ioat/registers.h | 7 -------
>   2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 5d707ff63554..fa7c0f9aa61d 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1191,13 +1191,13 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>   		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
>   
>   	/* disable relaxed ordering */
> -	err = pcie_capability_read_word(pdev, IOAT_DEVCTRL_OFFSET, &val16);
> +	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
>   	if (err)
>   		return pcibios_err_to_errno(err);
>   
>   	/* clear relaxed ordering enable */
> -	val16 &= ~IOAT_DEVCTRL_ROE;
> -	err = pcie_capability_write_word(pdev, IOAT_DEVCTRL_OFFSET, val16);
> +	val16 &= ~PCI_EXP_DEVCTL_RELAX_EN;
> +	err = pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, val16);
>   	if (err)
>   		return pcibios_err_to_errno(err);
>   
> diff --git a/drivers/dma/ioat/registers.h b/drivers/dma/ioat/registers.h
> index f55a5f92f185..54cf0ad39887 100644
> --- a/drivers/dma/ioat/registers.h
> +++ b/drivers/dma/ioat/registers.h
> @@ -14,13 +14,6 @@
>   #define IOAT_PCI_CHANERR_INT_OFFSET		0x180
>   #define IOAT_PCI_CHANERRMASK_INT_OFFSET		0x184
>   
> -/* PCIe config registers */
> -
> -/* EXPCAPID + N */
> -#define IOAT_DEVCTRL_OFFSET			0x8
> -/* relaxed ordering enable */
> -#define IOAT_DEVCTRL_ROE			0x10
> -
>   /* MMIO Device Registers */
>   #define IOAT_CHANCNT_OFFSET			0x00	/*  8-bit */
>   
