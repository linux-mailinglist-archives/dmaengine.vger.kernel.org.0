Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC506BF362
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCQVBL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 17:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCQVBJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 17:01:09 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581AF74C;
        Fri, 17 Mar 2023 14:01:03 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id i19so3390445ila.10;
        Fri, 17 Mar 2023 14:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9EiAA4lskfU5fZwDEEjXMLNpA6IiIed6Ih+9/z1fuw=;
        b=pYGK199wffHhYmNOY1w5cj8FvokhOIrEL7oCDPDdseRtFcpl0S9rFpcvV6QcnVRurL
         0IKBevJHqWtvVEpc7HU6U494/dsONTa7AzKWYU3/SeGCrXuYR08qc/+raYVEwdojFhdv
         V7kCqI3bI5eBwIOQjtwNHhNtlt890ar4gK9PVUdy+HI9mHcoco9EHdmBKxVROkJHFO+B
         +2S42fNf+WnL+A3y/ESMx6URIYXDXoHGD9UKxW3OWuRJvxgOxilNauFCL7/RbmuRtlHG
         MPSOOGCFRji96erE3RlD0qi/QomWOn1scJ73ZJ+BvlD1vaeUwVruEy1/UacKm2vuchcU
         h61Q==
X-Gm-Message-State: AO0yUKWr2xB13SZzoxpisf+mW3WezSA/yhONZDHZUvSvj0Bua0WM0Zof
        49Xm1/yfYqYllMU72zf/Qg==
X-Google-Smtp-Source: AK7set+Toby4I08PfKs5Vv4ur/RProzX9zB/qL38RB1Lpcl0LMr7CHYESvkyeKXSl8neA8xDhSDJCg==
X-Received: by 2002:a92:c9d2:0:b0:317:9818:ea49 with SMTP id k18-20020a92c9d2000000b003179818ea49mr35659ilq.2.1679086863038;
        Fri, 17 Mar 2023 14:01:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s20-20020a056e0210d400b003170014ee5bsm881484ilj.21.2023.03.17.14.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:00:57 -0700 (PDT)
Received: (nullmailer pid 2794739 invoked by uid 1000);
        Fri, 17 Mar 2023 21:00:54 -0000
Date:   Fri, 17 Mar 2023 16:00:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pmenzel@molgen.mpg.de,
        ilpo.jarvinen@linux.intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 3/5] dmaengine: aspeed: Add AST2600 UART DMA driver
Message-ID: <20230317210054.GA2790192-robh@kernel.org>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230314021817.30446-4-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314021817.30446-4-chiawei_wang@aspeedtech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 14, 2023 at 10:18:15AM +0800, Chia-Wei Wang wrote:
> Aspeed AST2600 UART DMA (UDMA) includes 14 channels for the
> DMA transmission and recevie of each UART devices.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/dma/Kconfig        |   9 +
>  drivers/dma/Makefile       |   1 +
>  drivers/dma/ast2600-udma.c | 528 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 538 insertions(+)
>  create mode 100644 drivers/dma/ast2600-udma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index fb7073fc034f..c35f87dbafd9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -748,6 +748,15 @@ config XILINX_ZYNQMP_DPDMA
>  	  driver provides the dmaengine required by the DisplayPort subsystem
>  	  display driver.
>  
> +config ASPEED_AST2600_UDMA
> +	bool "Aspeed AST2600 UDMA support"
> +	depends on ARCH_ASPEED

|| COMPILE_TEST

> +	help
> +	  Enable support for Aspeed AST2600 UART DMA. Select this option if you
> +	  have a AST2600 SoC integrated system. The driver provides the UART DMA
> +	  support with the dmaengine subsystem, which can be leveraged by generic
> +	  8250 serial drivers.
> +
>  # driver files
>  source "drivers/dma/bestcomm/Kconfig"
>  
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a4fd1ce29510..6cbacebcdcab 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_ASPEED_AST2600_UDMA) += ast2600-udma.o
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ast2600-udma.c b/drivers/dma/ast2600-udma.c
> new file mode 100644
> index 000000000000..ff678724f9d9
> --- /dev/null
> +++ b/drivers/dma/ast2600-udma.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) ASPEED Technology Inc.
> + */
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>

> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>

You probably don't need these as you should use platform APIs instead.
