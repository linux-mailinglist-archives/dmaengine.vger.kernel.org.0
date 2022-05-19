Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1560C52DB02
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiESRQ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiESRQz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F32FFCA;
        Thu, 19 May 2022 10:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFD0616C1;
        Thu, 19 May 2022 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2471C385AA;
        Thu, 19 May 2022 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652980613;
        bh=NzDa1LM1fArKMIx8GaH8Ju/+45nyxosJyGcCg2/N/N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOw1rebPNPjpiCVy97h1ZxdxqiPU29XbDq8OqVbbsoiFTzBbuhTne1C8z0bVyza7o
         Tc3UU3pyIrDlXWAlQpWdhJXB+97LTcMs0YqqKfyEw/pREtYdpj9mLWbpZtfTvCnLA5
         O1hEaOAxJARgyQgzUUmc+6HvqebZb3g8yWhG028kg1IE/tkrMini0fpZy36rla8I6x
         d+nutH/mHWAvKT/15aFEnTl7H4ZxmZ/L775NZTsFXUBHzfCYTLSd4Ul0LkP9i3DNSZ
         bzwNK9nRmr4B8+z6QRj5x4prlEw59MhYW4bDs9wqcuIJuDsaXaNMnnMsHHfCoy5kal
         /pfVjQ1Kfk7EA==
Date:   Thu, 19 May 2022 22:46:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rgumasta@nvidia.com, pkunapuli@nvidia.com, treding@nvidia.com,
        digetx@gmail.com, akhilrajeev@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: tegra: Fix build error without IOMMU_API
Message-ID: <YoZ7gdk06BqC9N+9@matsya>
References: <20220505093236.15076-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505093236.15076-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-22, 17:32, YueHaibing wrote:
> drivers/dma/tegra186-gpc-dma.c: In function ‘tegra_dma_probe’:
> drivers/dma/tegra186-gpc-dma.c:1364:24: error: ‘struct iommu_fwspec’ has no member named ‘ids’
>   stream_id = iommu_spec->ids[0] & 0xffff;
>                         ^~
> 
> Make TEGRA186_GPC_DMA depends on IOMMU_API to fix this.

Applied, thanks

> 
-- 
~Vinod
