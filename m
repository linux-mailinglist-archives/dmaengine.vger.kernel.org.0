Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49775706B3
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGKPLa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiGKPLa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 11:11:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EF05A2E2;
        Mon, 11 Jul 2022 08:11:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0D5272DC;
        Mon, 11 Jul 2022 15:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D5272DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657552288; bh=hSeU9FXMoITez72aytKTs7KEhJYRCmp8Bx8U2+pCzbI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V2AmnJYfF9ZWxEnWfd1sgkIJ6uzTaV240/uLdk1LNrvHOg1VW/nRW+QrYVkBW0GHe
         8V6u8tijpGygd+4R1Gf8gFTjKAQH2AnRUdG/ON/NTwlOOFp6EtH/QafxT+E3Rho+Py
         SAYJjO/yo8WbiwkIScQfSkNOSMuSwv1Vs84YPwlDs/W8y1s7o1njjQBTNS1TycmSTQ
         HQ9l+ZTIgtFiDpzzEsD+2qSxDyQzOqD+62hl3oaMryaPjFc34gnDtYoK0NmpIVlDCo
         pmPbEDLDULYENcpDQ9e7mvjLyQscjNb3FOjPg/cG2B+ExDkCfGmf1ts2lAjr6yWPyB
         cm93bj6KL4Npg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/4] docs: arm: stm32: introduce STM32 DMA-MDMA chaining
 feature
In-Reply-To: <20220711084703.268481-2-amelie.delaunay@foss.st.com>
References: <20220711084703.268481-1-amelie.delaunay@foss.st.com>
 <20220711084703.268481-2-amelie.delaunay@foss.st.com>
Date:   Mon, 11 Jul 2022 09:11:27 -0600
Message-ID: <87a69ffzvk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Amelie Delaunay <amelie.delaunay@foss.st.com> writes:

> STM32 DMA-MDMA chaining feature is available on STM32 SoCs which embed
> STM32 DMAMUX, DMA and MDMA controllers. It is the case on STM32MP1 SoCs but
> also on STM32H7 SoCs. But focus is on STM32MP1 SoCs, using DDR.
> This documentation aims to explain how to use STM32 DMA-MDMA chaining
> feature in drivers of STM32 peripheral having request lines on STM32 DMA.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  .../arm/stm32/stm32-dma-mdma-chaining.rst     | 365 ++++++++++++++++++
>  1 file changed, 365 insertions(+)
>  create mode 100644 Documentation/arm/stm32/stm32-dma-mdma-chaining.rst

When you add a new RST file you also need to add it to index.rst
somewhere so that it becomes part of the docs build.

> diff --git a/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> new file mode 100644
> index 000000000000..bfbbadc45aa7
> --- /dev/null
> +++ b/Documentation/arm/stm32/stm32-dma-mdma-chaining.rst
> @@ -0,0 +1,365 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +STM32 DMA-MDMA chaining
> +=======================
> +
> +
> +Introduction
> +------------
> +
> +  This document describes the STM32 DMA-MDMA chaining feature. But before going further, let's
> +  introduce the peripherals involved.

Please keep to the 80-column limit for documentation, it makes it easier
to read.

> +  To offload data transfers from the CPU, STM32 microprocessors (MPUs) embed direct memory access
> +  controllers (DMA).
> +
> +  STM32MP1 SoCs embed both STM32 DMA and STM32 MDMA controllers. STM32 DMA request routing
> +  capabilities are enhanced by a DMA request multiplexer (STM32 DMAMUX).
> +
> +  **STM32 DMAMUX**
> +
> +  STM32 DMAMUX routes any DMA request from a given peripheral to any STM32 DMA controller (STM32MP1
> +  counts two STM32 DMA controllers) channels.
> +
> +  **STM32 DMA**
> +
> +  STM32 DMA is mainly used to implement central data buffer storage (usually in the system SRAM) for
> +  different peripheral. It can access external RAMs but without the ability to generate convenient
> +  burst transfer ensuring the best load of the AXI.
> +
> +  **STM32 MDMA**
> +
> +  STM32 MDMA (Master DMA) is mainly used to manage direct data transfers between RAM data buffers
> +  without CPU intervention. It can also be used in a hierarchical structure that uses STM32 DMA as
> +  first level data buffer interfaces for AHB peripherals, while the STM32 MDMA acts as a second
> +  level DMA with better performance. As a AXI/AHB master, STM32 MDMA can take control of the AXI/AHB
> +  bus.
> +
> +
> +Principles
> +----------
> +
> +  STM32 DMA-MDMA chaining feature relies on the strengths of STM32 DMA and STM32 MDMA controllers.
> +
> +  STM32 DMA has a circular Double Buffer Mode (DBM). At each end of transaction (when DMA data
> +  counter - DMA_SxNDTR - reaches 0), the memory pointers (configured with DMA_SxSM0AR and
> +  DMA_SxM1AR) are swapped and the DMA data counter is automatically reloaded. This allows the SW or
> +  the STM32 MDMA to process one memory area while the second memory area is being filled/used by the
> +  STM32 DMA transfer.
> +
> +  With STM32 MDMA linked-list mode, a single request initiates the data array (collection of nodes)
> +  to be transferred until the linked-list pointer for the channel is null. The channel transfer
> +  complete of the last node is the end of transfer, unless first and last nodes are linked to each
> +  other, in such a case, the linked-list loops on to create a circular MDMA transfer.
> +
> +  STM32 MDMA has direct connections with STM32 DMA. This enables autonomous communication and
> +  synchronization between peripherals, thus saving CPU resources and bus congestion. Transfer
> +  Complete signal of STM32 DMA channel can triggers STM32 MDMA transfer. STM32 MDMA can clear the
> +  request generated by the STM32 DMA by writing to its Interrupt Clear register (whose address is
> +  stored in MDMA_CxMAR, and bit mask in MDMA_CxMDR).
> +
> +  .. csv-table:: STM32 MDMA interconnect table with STM32 DMA
> +        :header: "STM32 DMAMUX channels", "STM32 DMA controllers channels",
> +                 "STM32 DMA Transfer Complete signal", "STM32 MDMA request"

If at all possible, please use simple tables; that makes the plain text
documentation much easier to read.

[...]

Thanks,

jon
