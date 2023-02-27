Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED06A4336
	for <lists+dmaengine@lfdr.de>; Mon, 27 Feb 2023 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjB0NsL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Feb 2023 08:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0NsJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Feb 2023 08:48:09 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22C1CADF
        for <dmaengine@vger.kernel.org>; Mon, 27 Feb 2023 05:47:59 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52ED83F59C
        for <dmaengine@vger.kernel.org>; Mon, 27 Feb 2023 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677505677;
        bh=Qt3E5flVBMfHP3C44cEpXDpByE+OTGf4ytpF8RE1WDw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rddxjiLVFoHulDjGjpJ+gi9gakrR65wDNQCV6BY8osRmpQC3KX+GEgL/3WsiMOd5v
         Y3WlIHMDLya5IEqPC7w3/nkEux7G/ZCPe3q7ddyLZJdxKT6wl1yuFly3iFtHcCFXby
         tlO9sNc8vmGJhS8S9jOsyC9iEFSTBzqQ9zmKCBWVdURG8jvTrUeAfyR016V7OMOGQx
         OmH/uPh6t3aLaXjPDa8vUZzVWb1cJ3Noy3DRP109mLurjVLakx+9W3WRYtj+y9Z6Pc
         y3ZY5Hi2Gu8AdYB+npMv+0G3joFoZ+gzRIjWKxLY4rfONrn6m/l5Y6UdN4coaijRsa
         HXVbDRcNFLnig==
Received: by mail-qv1-f72.google.com with SMTP id l13-20020ad44d0d000000b004c74bbb0affso3329472qvl.21
        for <dmaengine@vger.kernel.org>; Mon, 27 Feb 2023 05:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt3E5flVBMfHP3C44cEpXDpByE+OTGf4ytpF8RE1WDw=;
        b=didmCvOybsSiktmVMSdlHrZIs9oZXcWkfgLpx3tbs/QUQt5uVErpNquHyctEXNPDFJ
         MxlG7md84EKSHQLo4iKxM6dD+AEaMs7kCIjuO1XDcE2NV8DsrfO3QBiNMzRTbOS6xw1q
         DcW6zw/hrn89ng89o3Me1VAN62JxlqXd+fRqqboNQpBXRKO8cTzFMKlocdDQWc9pdIOg
         V7//AFfiXWUjYv2LzW7/u6MF205VzWKuyWLc2d1Z8eXPLAB4WwOYJRE49EihJMYFAVLN
         OS2bkJH3gdaZx3fUXycaElUtL+jHlD7IFTx/59weuk88hbdqv+Ufg3a0j5ZbmL5YzNTT
         G0NQ==
X-Gm-Message-State: AO0yUKUgLvuVPQhCFyebIYyMzfxe/kWg43PzOkA+Gos4QLSoNsA9yxA6
        tBIKmqbfLy2PRvQAZY9sKUspJfANk7uq2FvEZBRi+Fx8dh2dq3XW7nqDBEiSGHo/g0wlLtEcyCy
        nVFbej+cqSDAKV0BRV7ehj9spmfvSlW9g9LjrwGbvX2z8VKfxfVRWyg==
X-Received: by 2002:ae9:e313:0:b0:742:8868:bfd1 with SMTP id v19-20020ae9e313000000b007428868bfd1mr1851584qkf.7.1677505675817;
        Mon, 27 Feb 2023 05:47:55 -0800 (PST)
X-Google-Smtp-Source: AK7set/TJt2EU/afZqiJqR6VD4laReyHa5Perg50Z5/nKcJ7QgSMmS3Kx2TG7JRmCyAgRQOQJcDd5SBGKgSUDP5Ny2k=
X-Received: by 2002:ae9:e313:0:b0:742:8868:bfd1 with SMTP id
 v19-20020ae9e313000000b007428868bfd1mr1851578qkf.7.1677505675539; Mon, 27 Feb
 2023 05:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20230227131042.16125-1-walker.chen@starfivetech.com> <20230227131042.16125-3-walker.chen@starfivetech.com>
In-Reply-To: <20230227131042.16125-3-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 27 Feb 2023 14:47:38 +0100
Message-ID: <CAJM55Z946EVyN50KcBmh7chOOnzwTOjwLR+Z_fCOrfin9j7LNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dmaengine: dw-axi-dmac: Add support for StarFive
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 27 Feb 2023 at 14:11, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> Add DMA reset operation in device probe and use different configuration
> on CH_CFG registers according to match data.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Hi Walker,

Firstly your Signed-off-by should be the last line.

I may have been unclear in my last review, sorry. I meant to give my
reviewed-by if you just removed the reset pointer that was never used.
This new version also adds a lot of new code.

Though, I'm glad you want to update the driver to use match data
rather than of_device_is_compatible, but then please update all uses
of of_device_is_compatible. With this patch starfive uses match data
and the intel,kmb-axi-dma still uses of_device_is_compatible.

More comments below..

> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 34 +++++++++++++++++--
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  7 ++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index bf85aa0979ec..400eeef707bf 100644
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
> @@ -86,7 +88,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>
>         cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>                   config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
> -       if (chan->chip->dw->hdata->reg_map_8_channels) {
> +       if (chan->chip->dw->hdata->reg_map_8_channels &&
> +           !chan->chip->dw->hdata->use_cfg2) {
>                 cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>                          config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>                          config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
> @@ -1142,7 +1145,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>         axi_chan_disable(chan);
>
>         ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -                                       !(val & chan_active), 1000, 10000);
> +                                       !(val & chan_active), 1000, DMAC_TIMEOUT_US);
>         if (ret == -ETIMEDOUT)
>                 dev_warn(dchan2dev(dchan),
>                          "%s failed to stop\n", axi_chan_name(chan));
> @@ -1367,6 +1370,17 @@ static int parse_device_properties(struct axi_dma_chip *chip)
>         return 0;
>  }
>
> +static int jh7110_rst_init(struct platform_device *pdev)
> +{
> +       struct reset_control *resets;
> +
> +       resets = devm_reset_control_array_get_exclusive(&pdev->dev);
> +       if (IS_ERR(resets))
> +               return PTR_ERR(resets);
> +
> +       return reset_control_deassert(resets);
> +}
> +
>  static int dw_probe(struct platform_device *pdev)
>  {
>         struct device_node *node = pdev->dev.of_node;
> @@ -1374,6 +1388,7 @@ static int dw_probe(struct platform_device *pdev)
>         struct resource *mem;
>         struct dw_axi_dma *dw;
>         struct dw_axi_dma_hcfg *hdata;
> +       const struct axi_dma_chip_config *ccfg;
>         u32 i;
>         int ret;
>
> @@ -1416,6 +1431,15 @@ static int dw_probe(struct platform_device *pdev)
>         if (IS_ERR(chip->cfgr_clk))
>                 return PTR_ERR(chip->cfgr_clk);
>
> +       ccfg = of_device_get_match_data(&pdev->dev);
> +       if (ccfg) {
> +               ret = ccfg->rst_init(pdev);
> +               if (ret)
> +                       return ret;
> +
> +               chip->dw->hdata->use_cfg2 = ccfg->use_cfg2;
> +       }
> +
>         ret = parse_device_properties(chip);
>         if (ret)
>                 return ret;
> @@ -1557,9 +1581,15 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>         SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
>  };
>
> +static const struct axi_dma_chip_config jh7110_chip_config = {
> +       .rst_init = jh7110_rst_init,
> +       .use_cfg2 = true,
> +};
> +
>  static const struct of_device_id dw_dma_of_id_table[] = {
>         { .compatible = "snps,axi-dma-1.01a" },
>         { .compatible = "intel,kmb-axi-dma" },
> +       { .compatible = "starfive,jh7110-axi-dma", .data = &jh7110_chip_config },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index e9d5eb0fd594..7b404ae9a26a 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -21,6 +21,7 @@
>  #define DMAC_MAX_CHANNELS      16
>  #define DMAC_MAX_MASTERS       2
>  #define DMAC_MAX_BLK_SIZE      0x200000
> +#define DMAC_TIMEOUT_US                200000
>
>  struct dw_axi_dma_hcfg {
>         u32     nr_channels;
> @@ -33,6 +34,7 @@ struct dw_axi_dma_hcfg {
>         /* Register map for DMAX_NUM_CHANNELS <= 8 */
>         bool    reg_map_8_channels;
>         bool    restrict_axi_burst_len;
> +       bool    use_cfg2;
>  };
>
>  struct axi_dma_chan {
> @@ -72,6 +74,11 @@ struct axi_dma_chip {
>         struct dw_axi_dma       *dw;
>  };
>
> +struct axi_dma_chip_config {
> +       int (*rst_init)(struct platform_device *pdev);

Please just spell reset in full, it's not that much longer.

> +       bool use_cfg2;
> +};
> +

This struct is only used in dw-axi-dmac-platform.c above, so no need
to add it here.

>  /* LLI == Linked List Item */
>  struct __packed axi_dma_lli {
>         __le64          sar;
> --
> 2.17.1
>
