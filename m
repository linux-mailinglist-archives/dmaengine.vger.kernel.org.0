Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D365BE460
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiITL1i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITL1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 07:27:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7335F7F4;
        Tue, 20 Sep 2022 04:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 795E3B81D8B;
        Tue, 20 Sep 2022 11:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EDFC433D6;
        Tue, 20 Sep 2022 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663673254;
        bh=WdzZGXEytt0PPm4g3TwrmXy6TK0VHyA/hs9By4NFYQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsfwkzcRhJvcU9X5zcNx9fyzgcy+YMt8vgjkBA5x4kioU21pcZiNhPDN0L2RjbW0/
         I1AFl3bpBeQWwW9+tC3k5xeuMXZrro+fhh99xRa1Uu2gyCklKqCVVPHdGwJHFDWCCr
         BGmEFkPIjzNIzNs2bOTVGrlVVI171oy3U9iSYILabxaDl2q+sIHwC5xjvmaq/ZUUuv
         PvfMMTn3SNmmsf6SyQ+V5MWTNQTWtW/PmwUYaM1RMGzUbTn7ZNy91WZLVSqNbOLz9J
         JFvmS4fBgGh9dWCEXBFwyciiHd0SGqP0N+X86xc1Wo1qlEdjYYasJdzmSXDcpJxmE2
         S/avBTqkcs3Ug==
Date:   Tue, 20 Sep 2022 16:57:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@xilinx.com,
        git@amd.com
Subject: Re: [RFC V3 PATCH 0/8] Xilinx DMA enhancements and optimization
Message-ID: <YymjofmCECa3iF20@matsya>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-09-22, 11:21, Sarath Babu Naidu Gaddam wrote:
> Some background about the patch series: Xilinx Axi Ethernet device driver
> (xilinx_axienet_main.c) currently has axi-dma code inside it. The goal is
> to refactor axiethernet driver and use existing AXI DMA driver using
> DMAEngine API.
> 
> This patchset does feature addition and optimization to support axidma
> integration with axiethernet network driver. Once axidma version is
> accepted mcdma specific changes will be added in followup version.

why is this tagged RFC? Is it not ready for merge?

> 
> Changes for V2:
> - Use metadata API[1] for passing metadata from dma to netdev client.
> - Read irq-delay from DT.
> - Remove desc_callback_valid check.
> - Addressed RFC v1 comments[2].
> - Minor code refactoring.
> 
> Changes for V3:
> - Add device_config support for passing any dma client data.
> - Address RFC v2 comments.
>     - remove hardcoding for axidma_tx_segment.
>     - Below review comment is in pipeline. We are facing a race issue when
>       addressing it. we will fix it in the next version.
>       "chan->idle = true; in xilinx_dma_irq_handler() needs to be gated on
>        the active_list being empty".
> 
> Comments, suggestions are very welcome
> 
> Radhey Shyam Pandey (7):
>   dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected
>     property
>   dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
>   dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
>   dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
>   dmaengine: xilinx_dma: Freeup active list based on descriptor
>     completion bit
>   dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
>     usecase
>   dmaengine: xilinx_dma: Program interrupt delay timeout
> 
> Sarath Babu Naidu Gaddam (1):
>   dmaengine: xilinx_dma: Add device_config support
> 
>  .../bindings/dma/xilinx/xilinx_dma.txt        |   4 +
>  drivers/dma/xilinx/xilinx_dma.c               | 107 ++++++++++++++++--
>  include/linux/dma/xilinx_dma.h                |  16 +++
>  3 files changed, 115 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1

-- 
~Vinod
