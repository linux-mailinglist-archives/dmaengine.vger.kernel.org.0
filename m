Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425E7B1A09
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjI1LI0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjI1LH2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7644D199E;
        Thu, 28 Sep 2023 04:05:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33219C433A9;
        Thu, 28 Sep 2023 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899111;
        bh=RXNjr5wEScumRKn/TreikDC8qWu4O0tiXE/36zkFsM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTIGi8B4SUrhiJoeBl7bQ58ZHJVWEd011+becaBjYmaG+mA8yyNHltLM7zooKPuGG
         fK6jKKIQlC1q2l/PMeGaRv1Jv5FEoUVTqIQkYzrYUVymykUUeIa2sksmxXT82L3lU1
         YlVuiQH/algnNPgMALiZiNQUMQ7l9hh6HFxnx7VX9bSh4pmG2TgSTov2puH+jsN5PV
         9PhVL0UzYvrBna+9jLcqMmKBKQDBl/bccIKOEHwQBiiBfqe2Na9vG80djxiEygFlsS
         dma/FN8YTMcAUFUqV8dFPsy1BLt08ICO7sSLpjrVDO5Q6ivfRVxZQQCbC7V52MA/Op
         9bROlbT76FAHw==
Date:   Thu, 28 Sep 2023 16:35:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        nishad.saraf@amd.com, sonal.santan@amd.com, max.zhen@amd.com
Subject: Re: [PATCH V5 0/1] AMD QDMA driver
Message-ID: <ZRVd4yodNiwhqO9R@matsya>
References: <1695402939-28924-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695402939-28924-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-23, 10:15, Lizhi Hou wrote:
> Hello,
> 
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
> 
>             +-------+       +-------+       +-----------+
>    PCIe     |       |       |       |       |           |
>    Tx/Rx    |       |       |       |  AXI  |           |
>  <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>             |       |       |       |       |           |
>             +-------+       +-------+       +-----------+

This should be in patch description as well

> 
> Comparing to AMD/Xilinx XDMA subsystem,
>     https://lore.kernel.org/lkml/Y+XeKt5yPr1nGGaq@matsya/
> the QDMA subsystem is a queue based, configurable scatter-gather DMA
> implementation which provides thousands of queues, support for multiple
> physical/virtual functions with single-root I/O virtualization (SR-IOV),
> and advanced interrupt support. In this mode the IP provides AXI4-MM and
> AXI4-Stream user interfaces which may be configured on a per-queue basis.
> 
> The QDMA has been used for Xilinx Alveo PCIe devices.
>     https://www.xilinx.com/applications/data-center/v70.html
> 
> This patch series is to provide the platform driver for AMD QDMA subsystem
> to support AXI4-MM DMA transfers. More functions, such as AXI4-Stream
> and SR-IOV, will be supported by future patches.
> 
> The device driver for any FPGA based PCIe device which leverages QDMA can
> call the standard dmaengine APIs to discover and use the QDMA subsystem
> without duplicating the QDMA driver code in its own driver.
> 
> Changes since v4:
> - Convert to use platform driver callback .remove_new()
> 
> Changes since v3:
> - Minor changes in Kconfig description.
> 
> Changes since v2:
> - A minor change from code review comments.
> 
> Changes since v1:
> - Minor changes from code review comments.
> - Fixed kernel robot warning.
> 
> Nishad Saraf (1):
>   dmaengine: amd: qdma: Add AMD QDMA driver
> 
>  MAINTAINERS                            |    9 +
>  drivers/dma/Kconfig                    |   13 +
>  drivers/dma/Makefile                   |    1 +
>  drivers/dma/amd/Makefile               |    8 +
>  drivers/dma/amd/qdma-comm-regs.c       |   66 ++
>  drivers/dma/amd/qdma.c                 | 1187 ++++++++++++++++++++++++
>  drivers/dma/amd/qdma.h                 |  269 ++++++
>  include/linux/platform_data/amd_qdma.h |   36 +
>  8 files changed, 1589 insertions(+)
>  create mode 100644 drivers/dma/amd/Makefile
>  create mode 100644 drivers/dma/amd/qdma-comm-regs.c
>  create mode 100644 drivers/dma/amd/qdma.c
>  create mode 100644 drivers/dma/amd/qdma.h
>  create mode 100644 include/linux/platform_data/amd_qdma.h
> 
> -- 
> 2.34.1

-- 
~Vinod
