Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07396A2FEF
	for <lists+dmaengine@lfdr.de>; Sun, 26 Feb 2023 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBZOZr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Feb 2023 09:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZOZq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Feb 2023 09:25:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C09FF13
        for <dmaengine@vger.kernel.org>; Sun, 26 Feb 2023 06:25:42 -0800 (PST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 492563F59C
        for <dmaengine@vger.kernel.org>; Sun, 26 Feb 2023 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677421541;
        bh=CE3OT5IllSccKQ947nt7em2EjnyBc3+YZANwp69JN68=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I8Esoa7MZ8h/NXPF3Wihs3B7VE5EKqxDIsPAsV02BDV0tE+DdJSkdzSpTp9Mtw0s0
         xiEhMi6BQMiYNojL/+TAahDQ1cIX3PtXybsm4IUYf2UG87Qx/e+lsFzUVv5JWqh6gS
         xsFiJfIrUAStT9ls9xp+88Gzlw+pTmXruUftPuL8mE28X/HTtBu/voyPMg7P7gdOfi
         9rHbJ9MBXUawtdO7WCXsC8om/T/ZndVlbCrx6trY2Zob3Oc0Ggd380N3tVMNTuYxQG
         56A16gZ4XfJe1PM733piV/o0C/YJ9LyyKPWUsVZnjwEuEbiW1uClfvkgmX3WKZWES0
         XkYJFaGoHzK+w==
Received: by mail-qv1-f70.google.com with SMTP id x18-20020ad44592000000b00571bb7cdc42so2046128qvu.23
        for <dmaengine@vger.kernel.org>; Sun, 26 Feb 2023 06:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE3OT5IllSccKQ947nt7em2EjnyBc3+YZANwp69JN68=;
        b=ciBMBBI2TbXFWscOcYLTtnzRgxiad7P0oJ7IiqW0jtOVoBWufX+0V3HZy3HGC3g51l
         n1pdvmnjSZ5LzMdQ0Wt3WClNQQSuJ5tZ95DSD02Bb5UZirE9hLD3wOaHVOye0cbhfzqm
         63JJdFLPPHr3EUpioQjFbtqF9xi3aDpzWoxbUJqfDnfeL4nbqHJtJhDsYIQJ1Ps3RnH2
         6+7lVHC6a2/topDIT5gDvgi3BQneeNEow+yh9t3p04ydcCK81EyQJ4CcNKT6G/AqTdHD
         DmYaEbMn2mlG6RnYXjrPDZOHwloRKPP+iUykZJCi+W5evobjkI3RYiwZ2C6WmO6CwXA7
         1sFQ==
X-Gm-Message-State: AO0yUKViM3IxNjkbX5ufxH8JSOUTcHXnB03rlvdeX2JkIgQSW16N2Fs4
        +7NeGwRfh4b0pOcCrBrpNzxA/IZLgkjS2t72firYcvXGj4gkzyfS7+VNsDUxRCnx/hGFb66aUZX
        TpZZzuKzH1eGGgQ9o8UZpY1H05TDnc5G+N/OWC4ghQ8EFNqK2o6nPig==
X-Received: by 2002:ac8:7007:0:b0:3bf:c91e:2cad with SMTP id x7-20020ac87007000000b003bfc91e2cadmr898433qtm.3.1677421540103;
        Sun, 26 Feb 2023 06:25:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/zy1s2v+Lzd9J0sv9I/9lsKv+esWVBt0QC2Ah3KHHqofKm+G9VBwwKfAON+OfBw4vmzheo5xJnbGkq5mOaqdI=
X-Received: by 2002:ac8:7007:0:b0:3bf:c91e:2cad with SMTP id
 x7-20020ac87007000000b003bfc91e2cadmr898429qtm.3.1677421539852; Sun, 26 Feb
 2023 06:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20230221140424.719-1-walker.chen@starfivetech.com> <20230221140424.719-3-walker.chen@starfivetech.com>
In-Reply-To: <20230221140424.719-3-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 26 Feb 2023 15:25:23 +0100
Message-ID: <CAJM55Z_buj_CBKtJw=n_K-Ma4ZGP9pmy_uM20nLpJhTMNh=bJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dmaengine: dw-axi-dmac: Add support for StarFive
 JH7110 DMA
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Tue, 21 Feb 2023 at 15:04, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> Add DMA reset operation in device probe and use different configuration
> on CH_CFG registers according to compatible string.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 19 +++++++++++++++++--
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index bf85aa0979ec..858c4337650f 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>
> @@ -86,7 +87,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>
>         cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>                   config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
> -       if (chan->chip->dw->hdata->reg_map_8_channels) {
> +       if (chan->chip->dw->hdata->reg_map_8_channels &&
> +           !chan->chip->dw->hdata->use_cfg2) {
>                 cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>                          config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>                          config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
> @@ -1142,7 +1144,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>         axi_chan_disable(chan);
>
>         ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -                                       !(val & chan_active), 1000, 10000);
> +                                       !(val & chan_active), 1000, DMAC_TIMEOUT_US);
>         if (ret == -ETIMEDOUT)
>                 dev_warn(dchan2dev(dchan),
>                          "%s failed to stop\n", axi_chan_name(chan));
> @@ -1416,6 +1418,18 @@ static int dw_probe(struct platform_device *pdev)
>         if (IS_ERR(chip->cfgr_clk))
>                 return PTR_ERR(chip->cfgr_clk);
>
> +       if (of_device_is_compatible(node, "starfive,jh7110-axi-dma")) {
> +               chip->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
> +               if (IS_ERR(chip->resets))
> +                       return PTR_ERR(chip->resets);
> +
> +               ret = reset_control_deassert(chip->resets);
> +               if (ret)
> +                       return ret;
> +
> +               chip->dw->hdata->use_cfg2 = true;
> +       }
> +

In the future it would be great to use match data rather than all the
calls to of_device_is_compatible.

>         ret = parse_device_properties(chip);
>         if (ret)
>                 return ret;
> @@ -1560,6 +1574,7 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>  static const struct of_device_id dw_dma_of_id_table[] = {
>         { .compatible = "snps,axi-dma-1.01a" },
>         { .compatible = "intel,kmb-axi-dma" },
> +       { .compatible = "starfive,jh7110-axi-dma" },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index e9d5eb0fd594..761d95691c02 100644
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
> @@ -70,6 +72,7 @@ struct axi_dma_chip {
>         struct clk              *core_clk;
>         struct clk              *cfgr_clk;
>         struct dw_axi_dma       *dw;
> +       struct reset_control    *resets;

This added field only seems to be written, but not read from anywhere.
With that fixed:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>  };
>
>  /* LLI == Linked List Item */
> --
> 2.17.1
>
