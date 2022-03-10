Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2B4D5283
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiCJTqd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiCJTq3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:46:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E4194AA9;
        Thu, 10 Mar 2022 11:45:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v28so9223759ljv.9;
        Thu, 10 Mar 2022 11:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elBDpnkZgvTqqmpB5TnahezV/zWR7nYFd2WS1+9K4n8=;
        b=FiBlIxp7G1h+TOnQWyJpcth4syj4CxuV3z8OnrtH/ReOnFb0Qq78tuXHniUfPL9NtB
         MqpgCRzC29GWpI34cAaZ0HU1JFNEKzMdmXVBvW+YxJsL+Cb3oQR0jlSBdH/IQ9sx2VSj
         acdvoyz3hR+G5XqcwxQGRBXQ5CZQ9LLwFIyD3s2q96+9VEZgjY3gOXdNfv2dwWoZMwUY
         P7UQS71txpdy6wyXq/YlI8IVl1XWfKBRZGk+o6TYpW3RkZ4qxKsQTrjvfTzt4qeNmg03
         qZfbl5KXgdxw9YGNb+0z9kas8+K9cUMz9a9L/pjWjod5C8HIDRdhTIOcvsuFufQLITfY
         iepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elBDpnkZgvTqqmpB5TnahezV/zWR7nYFd2WS1+9K4n8=;
        b=hBYB2NpNz4FfzC7K5DwNwRdOh7tUx46ML5r4zvd5o7bEjANHvMBLbQnR7oTt4aKVH6
         SKFN5daKVzvb5md6Vv751ExzgfQgvhTEUTmJ2gmW7McR0FRgUfIaU9RRytkrEKe5NJ8M
         OBAeSy7wvXPE00YTyptg4uQQYlbZ4mPCJtrkStAAz3glhOcVpgrIHoarZHU9SzcEAxR+
         8q/QE2dXotsrMCyLJS+B9kehNlV8aGlcVUgNVIUckCSmuBkbgLrFyiz+qf/Hpj0A8bZv
         4NmUu8xqEuSHQ1jM9tpbYWjVfylX0RvVDXl9uNaJA4DSFjL1cJMzTGQnJZoZGZ+mtNve
         c63A==
X-Gm-Message-State: AOAM532IyG7vCaKwMcqTLT8BBUZmozMptvQb2vkzM2yS+4mbKk3Soe6X
        qVglSyfRC3fv8jLzT1oowyk=
X-Google-Smtp-Source: ABdhPJwvrW2TFj32PSk5S2XDLp7kBhWnqzZQm1m+qgdiaT/FwIZ7XHmyIT1ibAwEjDEJD/QVqHsslg==
X-Received: by 2002:a05:651c:1797:b0:23a:18d7:1d39 with SMTP id bn23-20020a05651c179700b0023a18d71d39mr3946049ljb.470.1646941526389;
        Thu, 10 Mar 2022 11:45:26 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm1142550lfn.240.2022.03.10.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 11:45:24 -0800 (PST)
Date:   Thu, 10 Mar 2022 22:45:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v5 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220310194521.g6emg63bparbjic2@mobilestation>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Frank,

Please don't re-send patch so quickly. We haven't finished discussing
and reviewing v4 yet, but you've already sent out v5 with possibly some of
the comments missed. In addition you haven't addressed all my comments
in the v4. Please get back there and let's finish all the discussions
first. Regarding the resibmitting procedure see [1].

[1] Documentation/process/submitting-patches.rst: "Don't get discouraged - or impatient"

-Sergey

On Thu, Mar 10, 2022 at 01:24:48PM -0600, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: change rg_region to reg_base in struct
>    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> 
> 2. Enhance EDMA driver to allow prode eDMA at EP side
>    dmaengine: dw-edma: Add support for chip specific flags   
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
>    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
> 4. change pci-epf-test to use EDMA driver to transfer data.
>    PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 
> 
> 
> Frank Li (7):
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Add support for chip specific flags
>   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
>   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> 
> Manivannan Sadhasivam (2):
>   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
>   dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 131 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  46 +++---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
>  include/linux/dma/edma.h                      |  56 +++++++-
>  7 files changed, 298 insertions(+), 168 deletions(-)
> 
> -- 
> 2.24.0.rc1
> 
