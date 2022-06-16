Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070954E636
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377980AbiFPPlM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbiFPPlK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 11:41:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A84377E0;
        Thu, 16 Jun 2022 08:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97287B8248D;
        Thu, 16 Jun 2022 15:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED122C34114;
        Thu, 16 Jun 2022 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655394067;
        bh=maP/GEKe/01XwZsg6XgUHfBs8NNjXG+AorNqr2y0rkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqRuMU25pjrSLt/lczFpoqRDoqO8qdG8JmSV9WZ48VtbZtjlk2jTW66PhllC/Cesf
         aTD1VcVkvIgOhvFCHllXpfNlKtg9cMvWtdLM9Kg1Khvv3In5FTezcoWcQWqNVVCN4j
         AcV3upEeBMiymKG79rDsGNUdKlMF+36bDl+g08zpU3VhJvkuj4vk1tK8+ACCdHu9a3
         xQki6MddXO7WE7ls3UWSkGFJaTEoCkL/kIuhpZ80ZIcTAbSfukU6Ve1rDEhivf3mso
         xBkYssk5vo/TD4gb0mGX60uRCvB4UMuVcVSRrHtnpSjAikBJOAX81otQNnkspsAwxl
         6nnXI12ElAksw==
Date:   Thu, 16 Jun 2022 08:41:06 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <YqtPEm62RwFcA62W@matsya>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-05-22, 10:21, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: Change rg_region to reg_base in struct
>    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> 
> 2. Enhance EDMA driver to allow prode eDMA at EP side
>    dmaengine: dw-edma: Add support for chip specific flags
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> flags (this patch removed at v11 because dma tree already have fixed
> patch)
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for
> ep
>    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
> 4. change pci-epf-test to use EDMA driver to transfer data.
>    PCI: endpoint: Add embedded DMA controller test
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
