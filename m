Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974987B154A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjI1Hrd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjI1Hrc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:47:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01992
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 00:47:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527E8C433C8;
        Thu, 28 Sep 2023 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695887251;
        bh=jZr3m3nYQp75gFwOQ2csGb3/m9Y1zYNLh0lKYPrPVzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx2xwpP6CMPxbmaX+RFEbFZq4QhCw7PbFMU1E3kVrAnwQ96Ra7MKbLb80zsvht3qC
         eKhmmj+K3V+P00WHMkr0jIBijkm7d6H9psOwcR9o5yTrYwhlQjRsT0PRsAPjilyp1G
         bcSf6QkrkigDlyM4kmnCqhbTW1AupodA2b7CzpXCiGAqcf+gafsvbUrcIjDxBK1tOt
         uiuRPXE7TIropYMR4FeS9tNs+AM+BWhV3d7t27UXzrKEGDG1IwYNaV2JnfsUdi0PFB
         1OuBCtRbEe6WSBMmbnHosTAnUScjIkHOx+qg7+43U9S2t3+OM0uGNUwagE41nGjMoL
         c6DoF19cgxuqg==
Date:   Thu, 28 Sep 2023 13:17:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 57/59] dma: xilinx: xilinx_dma: Convert to platform
 remove callback returning void
Message-ID: <ZRUvjz7oO6iK1HTm@matsya>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-58-u.kleine-koenig@pengutronix.de>
 <MN0PR12MB59538717A8FEA06243DFFBEFB7FFA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20230928072711.k63x7snqdfiholxg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928072711.k63x7snqdfiholxg@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-23, 09:27, Uwe Kleine-König wrote:
> 
> Good catch, I should add that to my pre-send checks. I fixed it in my
> tree, so an eventual v2 will be good. I'll wait a bit before resending.
> 
> @Vinod: If you pick up this series, feel free to skip this patch or
> fixup with 
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 0c363a1ed853..e40696f6f864 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3242,8 +3242,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  /**
>   * xilinx_dma_remove - Driver remove function
>   * @pdev: Pointer to the platform_device structure
> - *
> - * Return: Always '0'
>   */
>  static void xilinx_dma_remove(struct platform_device *pdev)
>  {
> 
> or apply as is (in which case I will follow up with a separate patch to
> fix this).

Follow up patch is easier to handle

Thanks
-- 
~Vinod
