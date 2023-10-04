Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37FE7B8252
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbjJDO31 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjJDO30 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC3C6
        for <dmaengine@vger.kernel.org>; Wed,  4 Oct 2023 07:29:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F015AC433C8;
        Wed,  4 Oct 2023 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429761;
        bh=AIrlR0G7YIszz3lEYRBWx2v6sOuVzooxdYFXGD9qJw8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D+emskeIjJl/c1HgJURFnkITFcoW7+153BzUR5I+z80eUzOZb32dIyKdzMpPpYZpS
         qRtxQ9un983TbMN15VrMmOYVL/MP9UUEcMeMEY0OQiExUZIV40i02B+z095jKSDsWN
         ZOsnGVDBp7B7iq7C1mNL2TKAbCScU+01k5Gdc0aQpE/JDEQorzHW1H0fbr3LI5FAZT
         CZzTaJqHC9t9J79gfDsDAcXCRawULabALY5Calnlb3NKiv0S2wGeJsyeNd/ttRrE1H
         2HBZ+RctjKK/XH4Up/wqmzGaJDpv1zH8KWC0uIfTKb6+yN4c13kJl23XDvra+TYb5Q
         CVyGIxXjdkbXw==
From:   Vinod Koul <vkoul@kernel.org>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        michal.simek@amd.com, Li Zetao <lizetao1@huawei.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230803033235.3049137-1-lizetao1@huawei.com>
References: <20230803033235.3049137-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] dmaengine: xilinx: xdma: Use resource_size() in
 xdma_probe()
Message-Id: <169642975858.440009.16772567164005014864.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:18 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 03 Aug 2023 11:32:35 +0800, Li Zetao wrote:
> There is a warning reported by coccinelle:
> 
> ./drivers/dma/xilinx/xdma.c:888:22-25: ERROR:
> 	Missing resource_size with   res
> 
> Use resource_size() on resource object instead of explicit computation.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: Use resource_size() in xdma_probe()
      commit: 90a6c030f506585f484a9804aafe29cb42b93697

Best regards,
-- 
~Vinod


