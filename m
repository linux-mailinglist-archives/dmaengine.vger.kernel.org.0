Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA29C4BFC9E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiBVPbg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiBVPbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 10:31:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139D16304A;
        Tue, 22 Feb 2022 07:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8786CB81AB0;
        Tue, 22 Feb 2022 15:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B84C340E8;
        Tue, 22 Feb 2022 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543868;
        bh=9i4xuAv3MAiVPzxe+5g/FOn2ai3P/TMo7VhrUW14K+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2IFr1uJQF5P3+BH4KDnb3lCGnQ0dO4zVDFzNwNAOsBSyd0vdUO7zOqKcw6jnU86d
         +N/SDg0tbXP4GZNAfMsypnDtvYGLx1c/qxngV9EEEA+YC5G9XXexTXFWGgQVx53L9s
         Ylf1QA9YmFhnLjCv5BHlCi/Qk7iGdBbBmQXpuj3GCXROcqQesURsx4THmKpjKWIpYE
         ZzOhm0DVEm2wh9/9vDB8hrQN7xCdXuEsbJFK8Khm3XxSAzntG6ZSWLRx5fnqxmDxiJ
         ZGVhEeTfBksBamVcq3uB/3HOztGYZ4wHbI8S37wg0nwO95p2Z3V7LuWF2kxNX3Csof
         xe/VCRFUeJJZg==
Date:   Tue, 22 Feb 2022 08:31:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v20 2/2] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
 <20220221153934.5226-3-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221153934.5226-3-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Akhil,

On Mon, Feb 21, 2022 at 09:09:34PM +0530, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra. The driver supports dma
> transfers between memory to memory, IO peripheral to memory and
> memory to IO peripheral.
> 
> Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/Kconfig            |   11 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1507 ++++++++++++++++++++++++++++++++
>  3 files changed, 1519 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c

<snip>

> +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops = {

The __maybe_unused cannot split the type ("struct dev_pm_ops") otherwise
it causes a clang warning:

https://lore.kernel.org/r/202202221207.lQ53BwKp-lkp@intel.com/

static const struct dev_pm_ops tegra_dma_dev_pm_ops __maybe_unused = {

would look a litle better I think. However, is this attribute even
needed? The variable is unconditionally used below, so there should be
no warning about it being unused?

Cheers,
Nathan

> +	SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
> +};
> +
> +static struct platform_driver tegra_dma_driver = {
> +	.driver = {
> +		.name	= "tegra-gpcdma",
> +		.pm	= &tegra_dma_dev_pm_ops,
> +		.of_match_table = tegra_dma_of_match,
> +	},
> +	.probe		= tegra_dma_probe,
> +	.remove		= tegra_dma_remove,
> +};
> +
> +module_platform_driver(tegra_dma_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
> +MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
> +MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 
> 
