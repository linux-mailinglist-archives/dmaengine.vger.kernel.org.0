Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA3691839
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBJGDb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBJGDb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:03:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C45074315;
        Thu,  9 Feb 2023 22:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F93BB82315;
        Fri, 10 Feb 2023 06:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E34C433EF;
        Fri, 10 Feb 2023 06:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009007;
        bh=hvP52EYukgAZMIySUS+RB61bPYiZH+yvISqtT2LvyrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YY3Jdv+VPFC7FfD45hMm6voAS3OaivLbCO//owFseGavJPlujZlZVDCgjxOGzWlOi
         mA56wyqykmSJmCtXAJLPaODfpD9xKqem5uLUfUwSP1w/oFRvIqpg6I5pl44eUH2M0j
         0RfZTO2cCbD0L2TA5/S8pyRBfXalKqXARDCoE7GG6Sd3aQ4b6FzJpGUJ8F3KmLnEnq
         yeYB6FiiCVffO6bOgaFi5m4xLcRdCbvpr9DK/zhhC3+xKvr6eHvSn67ZSxF4yDnJrb
         0YjcfbT9ZRobzYxWl49lzY9ULAH/yaByIgvzwCayf7It4jdcoPP86+7yh0kaBOdUUo
         o/M29jPWR99Iw==
Date:   Fri, 10 Feb 2023 11:33:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, tumic@gpxsee.org
Subject: Re: [PATCH V12 XDMA 0/2] xilinx XDMA driver
Message-ID: <Y+XeKt5yPr1nGGaq@matsya>
References: <1674145926-29449-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674145926-29449-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-01-23, 08:32, Lizhi Hou wrote:
> Hello,
> 
> This V12 of patch series is to provide the platform driver to support the
> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with the
> PCI Express IP block to provide high performance data transfer between host
> memory and the card's DMA subsystem. It also provides up to 16 user
> interrupt wires to user logic that generate interrupts to the host.
> 
>             +-------+       +-------+       +-----------+
>    PCIe     |       |       |       |       |           |
>    Tx/Rx    |       |       |       |  AXI  |           |
>  <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>             |       |       |       |       |           |
>             +-------+       +-------+       +-----------+
> 
> The XDMA has been used for Xilinx Alveo PCIe devices.
> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>     https://www.xilinx.com/products/boards-and-kits/alveo.html
>     https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems
> 
> The device driver for any FPGA based PCIe device which leverages XDMA can
> call the standard dmaengine APIs to discover and use the XDMA subsystem
> without duplicating the XDMA driver code in its own driver.

Applied, thanks


ALso, please dont resend the code every few days, that serves no
purpose. It will be reviewed in the queue!

-- 
~Vinod
