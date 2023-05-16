Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94387705583
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjEPR4x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjEPR4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B199B;
        Tue, 16 May 2023 10:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B906463625;
        Tue, 16 May 2023 17:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9498FC433D2;
        Tue, 16 May 2023 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259804;
        bh=7ULD3yxJaogVlKiE5g0T5dzK9aiAn4kF1SV1cudf0a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAyDZvq3aI7/IDGeV2SK+xROv4K/jTU2+ZB3sCeAk+zcBLZcL0uYl7DxSR6UkmAbc
         GiL70Fl1igazasLe7Nfh1eye/vhD7JlpTfEwFNZa4V3mJ7oWobs3KJAybvXJUm9Z1s
         jmqTpuxy/tY3W9o/cVEo2kiZ1ONxXb6ZX3MTypvUR7cVMr2kykDqZgrrAQO0fn0BK7
         +bi2nP6QdG1CyxxfjVNbIRJ9UZ5OX2/Tqf04H+Q2pzva0bfJi1FstVkdad04QkvTNF
         DQVh1PrLL/V+pmjguWD+nhXThIs7nitRkmHAwu9uwJ2r5hL9SVV0HT/H3jT/f/tTql
         zJ9h3Yz63kG0A==
Date:   Tue, 16 May 2023 23:26:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
Message-ID: <ZGPD1wELeXafPJ/T@matsya>
References: <20230506111628.712316-1-bhe@redhat.com>
 <20230506111628.712316-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506111628.712316-3-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-23, 19:16, Baoquan He wrote:
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=n, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
> 
> Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.

I have 2/2 patch here, where is patch 1 of 2..?

> 
> --------------------------------------------------------
> ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make: *** [Makefile:1264: vmlinux] Error 2
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> ---
>  drivers/dma/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> index 3f926a653bd8..ace75d7b835a 100644
> --- a/drivers/dma/qcom/Kconfig
> +++ b/drivers/dma/qcom/Kconfig
> @@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
>  
>  config QCOM_HIDMA
>  	tristate "Qualcomm Technologies HIDMA Channel support"
> +	depends on HAS_IOMEM
>  	select DMA_ENGINE
>  	help
>  	  Enable support for the Qualcomm Technologies HIDMA controller.
> -- 
> 2.34.1

-- 
~Vinod
