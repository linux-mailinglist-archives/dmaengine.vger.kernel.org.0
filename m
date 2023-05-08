Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE76FACBD
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjEHL1m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjEHL1U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 07:27:20 -0400
Received: from out-45.mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9149E8
        for <dmaengine@vger.kernel.org>; Mon,  8 May 2023 04:27:10 -0700 (PDT)
Date:   Mon, 8 May 2023 19:27:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683545228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElYf2a+Vf3tVF0EX4H5zzAhn5sjX7aaNhZ53YyFncJg=;
        b=ES68el+rj7HOKoaPk83JuJcSrCi+3BH/j+tQBfnaiunnqlbxHYkOfDJW9iXwiqRdiW6uC5
        o25WWQaoGb5xT/eH+C2hto9iZZOKibDerDEdjq8GWd7V3Hi0TFMGf0LS3fARrBimQl114V
        JHx9GTqndCtyb+df4UErYKbjpCAVsE8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     vkoul@kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v9 0/4] dmaengine: dw-edma: Add support for native
 HDMA
Message-ID: <ZFjch8wPNgpbNo1E@chq-MS-7D45>
References: <20230413033156.93751-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413033156.93751-1-cai.huoqing@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13 4月 23 11:31:51, Cai Huoqing wrote:
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.
> 
> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.The same applies when
> youhave multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are aligned to byte.
> 
> Cai Huoqing (1):
>   dmaengine: dw-edma: Add support for native HDMA
> 
> Cai huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add HDMA DebugFS support
> 
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
Hi Vinod

Just ping this patch.

I have rebased this patch series, pls try it.

Thanks,
-Cai
> 
> v8->v9:
>   [3/4]
>   1.Drop an empty line.
>   [4/4]
>   2.Update commit log.
>   3.Remove unused macro
> 
> v8 link:
>   https://lore.kernel.org/lkml/20230323034944.78357-1-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
>  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 170 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 807 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
