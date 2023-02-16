Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5D698A5F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 03:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBPCJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 21:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBPCJT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 21:09:19 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B4113CB
        for <dmaengine@vger.kernel.org>; Wed, 15 Feb 2023 18:09:12 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:08:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676513350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGZVYqrPsVzRiWIZ8ejwKDqsr3b+Ny3Dw/gLZG651EM=;
        b=dE0cEMLPCvJC/xxylQ6EoaJ3PzR7jRjojAIMO49F7OWGCatDQOwedZbTw2EXk/s8ICEkoo
        4sy72JOvyOvxmfyRJoF97G9W52lptaybOT3akVGuishptU4I92IPJMAb2cWrfBh7u7e9Aq
        ILX3AhI5IsmV2Cn3+6UuBdVkbjlYS3M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <Y+2QOAsk6qFm56E3@chq-MS-7D45>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213132411.65524-1-cai.huoqing@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13 2月 23 21:24:05, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
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
> the next read channel to be serviced.
> The same applies when you have multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are alignmented to byte.dmaengine: dw-edma: Add support for native HDMA
> 
> Cai huoqing (4):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add support for native HDMA
>   dmaengine: dw-edma: Add HDMA DebugFS support
> 
>   v2->v3:
>     [1/4]
>     1.Add more commit log to explain why use dw_edma_plat_ops.
>     2.Update the structure name in the DW PCIe driver.
>     [2/4]
>     3.Use the reverse xmas tree vars definition order.
>     4.Add edma core ops wrapper.
>     5.Add dw_edma_done_interrupt() and dw_edma_abort_interrupt()
>       global methods.
>     6.Fix some indentation.
>     7.Fix some typo
>     8.Make use off dw_edma_core prefix instead of dw_xdma_core_.
>     [3/4]
>     9.Remove unnecessary include: dw-edma-v0-regs.h and dw-edma-v0-regs.h
>     10.HDMA supports the LL descriptors placed on the CPU memory.
>     [4/4]
>     11.Split DebugFS to be a separate patch.
>     12.Refactor HDMA DebugFS like the series in @Bjorn tree.
> 
>   v2 link:
>   https://lore.kernel.org/lkml/20220925173412.u2ez6rbmfc5fupdn@mobilestation/
Hi Sergey,

  Could you please give some comments for this patch v3

Thanks,
Cai
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  63 ++--
>  drivers/dma/dw-edma/dw-edma-core.h           |  92 ++++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  88 ++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 317 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 +
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 175 ++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 860 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
