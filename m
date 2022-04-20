Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0872F50876B
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbiDTL4F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378306AbiDTL4D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:56:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCF424BB;
        Wed, 20 Apr 2022 04:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E68B81DAB;
        Wed, 20 Apr 2022 11:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F3C385A1;
        Wed, 20 Apr 2022 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455591;
        bh=QYlKOJ+DmYe6vbnj1QajFS51R78ZBn3p5g948vKctbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNEWrkJ/yix+sTTMWMoeYbftbREFjK0jpXadX9j75PaUEWBp7lwe2+RfsxLPlwSRV
         QXqUOmfu6VyRTuPyjLBfXQyfSt6J6rYP7p7gLjA+3ga3WsUDnk+TFw/FG9Bg3/ehta
         RIMwWF0pgQMf7H0lSuP0ML+wPPhJ8Y3kj0623pECLwqgikRTq89dnoMlG5RrFxAdZL
         myexqvaOAjjuoc17OP/1tejf5gJP5glsC5x4MBGIiUuhYx+vkWW9ffhA/KBAXHgcab
         JbhKucnAh8d2NTvLIFFp26epJ1wzjbHCBq6nIu3Ph5xeycxTvB1FUPSBaG/ge1CV9T
         6DZGwgRD7Nv1A==
Date:   Wed, 20 Apr 2022 17:23:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: tegra: Remove unused including
 <linux/version.h>
Message-ID: <Yl/0I1E02Pi8ime9@matsya>
References: <20220413083842.69845-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413083842.69845-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-04-22, 16:38, Jiapeng Chong wrote:
> Eliminate the follow versioncheck warning:
> 
> ./drivers/dma/tegra186-gpc-dma.c: 21 linux/version.h not needed.

Applied, thanks

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index f12327732041..97fe0e9e9b83 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -18,7 +18,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> -#include <linux/version.h>
>  #include <dt-bindings/memory/tegra186-mc.h>
>  #include "virt-dma.h"
>  
> -- 
> 2.20.1.7.g153144c

-- 
~Vinod
