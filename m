Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEE6E0627
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 06:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDMExa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 00:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDMEx3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 00:53:29 -0400
X-Greylist: delayed 4871 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 21:53:27 PDT
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7359ED
        for <dmaengine@vger.kernel.org>; Wed, 12 Apr 2023 21:53:27 -0700 (PDT)
Date:   Thu, 13 Apr 2023 12:53:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681361605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALJc8puE3WTaCZtOEUK7wahcJtZl4wkyJ9W7p0RjjH0=;
        b=Z3mB6XZ01R3VKQkLYX1KABQcNA4snHAXdkfwNuGx+3BHPjNGUvY/eA9c/ZciNbGuN/rlk8
        v6CG2IfZYNcV9J1VZA+tGNH3dGiqU5Ay5bhesjyA77lKnzzBdsk2uUCogAZ/FnoRGaEdL6
        Gm4AxY2K/tHA42r5+2+NDomGD1zMSs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com, vkoul@kernel.org
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
Message-ID: <ZDeKwXeCo1TyfUxT@chq-MS-7D45>
References: <20230413033156.93751-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413033156.93751-1-cai.huoqing@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Hi Vinod,

thanks for your reply,

these resend patchs base on dmaengine-next.

please try it.

Thanks,
Cai-

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
