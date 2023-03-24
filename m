Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626B36C7EE0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 14:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCXNeK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjCXNeI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 09:34:08 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597219C4C
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 06:33:58 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5453B44303
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1679664835;
        bh=baRLhktlWOxcXvwHFNv0QgrA5IgUVwTfkSsdMkEu4+4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b34nfFRc1TfAcYkAdvQbNUvYd2zY0XJmbIxm4YuEEqwbARIb3CoHSAAKNtgykJZDg
         Sa3aBSNsXcgs36j1XG5VwnqCqmlvblPCKgNanTRh2QclfcW6rq7/MKz+5kUDI9rTq3
         1YPXCASO/60wnY45RTVq3LFngmVKm3P1btuNk69+1sgkUOoWna6yXMF2w0+xvfOT3a
         xGaAhqDf99yYwYAB1nBrTlpqs6+YWYx5nfpZMq3QUWlBzooWVwhZCAag0xz9NJpDWj
         tiTc/F4JUEyWNnywsRt3MMmI4m3VNlCYxusYyVUMjePX81+VrxnlVapQRywAnF0bPK
         CydrXFrzReHFA==
Received: by mail-qt1-f198.google.com with SMTP id h6-20020a05622a170600b003e22c6de617so1041031qtk.13
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 06:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baRLhktlWOxcXvwHFNv0QgrA5IgUVwTfkSsdMkEu4+4=;
        b=bhEMoQcLJmLI7tKgSC0joi7MsE9t8nWVe3IRyCDs36lg6on4FKFhUr0/RBIxO2524Q
         KZah9GVhAkOEv6/GaO32QeGy296ESBmXHJViTBiX5+JPoeq79hSIhJfW876kdkwBPnm2
         peJqvWk0GPRmeCanO6K8r9mW6Kx5Haeg/iOvTZ0A7akjF+hqfuR6mmPcS+Qoy5ttfvBw
         Sm5hCzsWsh3X56eejxZ19aZR8vM8wxmGc6AXuhRX0vOD78FUHI+JjC3rbrSOx9b19XQU
         asN0lej1cJI5NGpQ/xhVW8exLVA5+CLS3mvwjSmUlye4Xd3anfm9/PbB/2QHiPEXJm9Q
         Cl6g==
X-Gm-Message-State: AO0yUKWjKrrs0uaCeOA8hWYCHMSI3rm4oFg/rrbav7ZvTSNx/fagjCTf
        fVYQdJt6uB0fML6sc5JJVYQ1Hba2wm+skTjAB1zgsj6o5KgzesHgBdHv1WvW193/EGY+8tR+DMU
        jFNjBx3rNFy35jMcNFXidb8Tuen61e6wma6apPCI6lrX3PooyAIbk8w==
X-Received: by 2002:a05:620a:a18:b0:746:7f12:f2f3 with SMTP id i24-20020a05620a0a1800b007467f12f2f3mr651796qka.13.1679664834417;
        Fri, 24 Mar 2023 06:33:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+PMWroXLuUn1KxCXS1+t1n+7MwGF6fo/rG+E0PHsQotj4U0S9r3aNHlQweDVOeiRzH2jNJj64BuscgHlEEvaU=
X-Received: by 2002:a05:620a:a18:b0:746:7f12:f2f3 with SMTP id
 i24-20020a05620a0a1800b007467f12f2f3mr651787qka.13.1679664834154; Fri, 24 Mar
 2023 06:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322094820.24738-1-walker.chen@starfivetech.com> <20230322094820.24738-3-walker.chen@starfivetech.com>
In-Reply-To: <20230322094820.24738-3-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 24 Mar 2023 14:33:38 +0100
Message-ID: <CAJM55Z9VfY76ZxTxX-o56MNppALKbYuYvx6+fXvx=3LAg6gKDw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dmaengine: dw-axi-dmac: Add support for StarFive
 JH7110 DMA
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 22 Mar 2023 at 10:48, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> Add DMA reset operation in device probe and use different configuration
> on CH_CFG registers according to match data. Update all uses of
> of_device_is_compatible with of_device_get_match_data.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 38 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4169e1d7d5ca..6cfcb541d8c3 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -21,10 +21,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>
> @@ -46,6 +48,10 @@
>         DMA_SLAVE_BUSWIDTH_32_BYTES     | \
>         DMA_SLAVE_BUSWIDTH_64_BYTES)
>
> +#define AXI_DMA_FLAG_HAS_APB_REGS      BIT(0)
> +#define AXI_DMA_FLAG_HAS_RESETS                BIT(1)
> +#define AXI_DMA_FLAG_USE_CFG2          BIT(2)
> +
>  static inline void
>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
>  {
> @@ -86,7 +92,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>
>         cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>                   config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
> -       if (chan->chip->dw->hdata->reg_map_8_channels) {
> +       if (chan->chip->dw->hdata->reg_map_8_channels &&
> +           !chan->chip->dw->hdata->use_cfg2) {
>                 cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>                          config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>                          config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
> @@ -1367,10 +1374,11 @@ static int parse_device_properties(struct axi_dma_chip *chip)
>
>  static int dw_probe(struct platform_device *pdev)
>  {
> -       struct device_node *node = pdev->dev.of_node;
>         struct axi_dma_chip *chip;
>         struct dw_axi_dma *dw;
>         struct dw_axi_dma_hcfg *hdata;
> +       struct reset_control *resets;
> +       unsigned int flags;
>         u32 i;
>         int ret;
>
> @@ -1398,12 +1406,25 @@ static int dw_probe(struct platform_device *pdev)
>         if (IS_ERR(chip->regs))
>                 return PTR_ERR(chip->regs);
>
> -       if (of_device_is_compatible(node, "intel,kmb-axi-dma")) {
> +       flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +       if (flags & AXI_DMA_FLAG_HAS_APB_REGS) {
>                 chip->apb_regs = devm_platform_ioremap_resource(pdev, 1);
>                 if (IS_ERR(chip->apb_regs))
>                         return PTR_ERR(chip->apb_regs);
>         }
>
> +       if (flags & AXI_DMA_FLAG_HAS_RESETS) {
> +               resets = devm_reset_control_array_get_exclusive(&pdev->dev);
> +               if (IS_ERR(resets))
> +                       return PTR_ERR(resets);
> +
> +               ret = reset_control_deassert(resets);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
> +
>         chip->core_clk = devm_clk_get(chip->dev, "core-clk");
>         if (IS_ERR(chip->core_clk))
>                 return PTR_ERR(chip->core_clk);
> @@ -1554,8 +1575,15 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>  };
>
>  static const struct of_device_id dw_dma_of_id_table[] = {
> -       { .compatible = "snps,axi-dma-1.01a" },
> -       { .compatible = "intel,kmb-axi-dma" },
> +       {
> +               .compatible = "snps,axi-dma-1.01a"
> +       }, {
> +               .compatible = "intel,kmb-axi-dma",
> +               .data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
> +       }, {
> +               .compatible = "starfive,jh7110-axi-dma",
> +               .data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index e9d5eb0fd594..eb267cb24f67 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -33,6 +33,7 @@ struct dw_axi_dma_hcfg {
>         /* Register map for DMAX_NUM_CHANNELS <= 8 */
>         bool    reg_map_8_channels;
>         bool    restrict_axi_burst_len;
> +       bool    use_cfg2;
>  };
>
>  struct axi_dma_chan {
> --
> 2.17.1
>
