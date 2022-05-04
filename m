Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8051AD1F
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiEDSrb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 14:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbiEDSrb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 14:47:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16264DC;
        Wed,  4 May 2022 11:43:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so5923903pjb.5;
        Wed, 04 May 2022 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWeu0nEWN3XSTkbN9zMmwPgQVi68QrONisgvlMfoNCE=;
        b=J8GzvYrxew0M1XivYp6N34lfK02T0WoaJ+KLKwglomN5WdhzYAtJWWdEoFww2XwIyE
         Fp7HOA6XmIl2YyPEl0A5XCpW8u/mRnAkTDq3HUY3P6ahyEG2H5h363JuOXR552JO0Uk3
         dvotBEACmkIDwVUowi07DOQn6AFiHqVFJyy34RUqoIhsXPi+9nWQIZ1fSAAyJhaBSu4s
         iY1S4DgycGJyxDHemMFdM6AJriuIOUuLvNVjgSkTkxE6auay1ui8Z00PxoMT470bJ9E+
         KWckgWDRmjdSnqD7JFJ6EUm8zYtfXNP/Khr6bbfzjaaTrMRxYnqGSmDwcFo/V20gBIgo
         HGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWeu0nEWN3XSTkbN9zMmwPgQVi68QrONisgvlMfoNCE=;
        b=ZXJ3JdNRsI8TyJcIfE/gAFQV1Na2IRNHJaL8I0+H5oYPcXNMXJ3wywhV8T/fSoYATH
         VeqMF1wAtD7p+FsPjN6mIVLAchyUgQMYhIwFg6kS9pEIUURJIGMR0Aqk6tvB68+JXOWn
         ZZ2b/Z7Zc1q8ZecKRCHt1Ebsg5hf4YGD/GPvIDO2dWkv/HFu+0u8Gq3kdKyaF6bC6bxH
         poG4c3lqNkmnCc4NGaDJZ1OdirwXE9F6MV5bMdGZ4J7xsvvZniWYD9gaHm7OGQ5DeW/u
         lpWRwQeCoumom3Gdh0S9J9eI+BOq09cbNhv9iB7STI2q4VZIYdtTL/OlOkeZoMCAE47P
         Sm2A==
X-Gm-Message-State: AOAM532e3U21qrxCpoNvY15dFl0UjppoUx1gMuy11VUivQi4WZ956FVV
        Lg+2LFoIxp9lGCm18ltaH4oMQpAL3yCauH4Eoao=
X-Google-Smtp-Source: ABdhPJwpvdPgJAEMKUJvMA4X+x59qOnVrqDDstxA1jgczkWBqfMP1CnntW6M1CcPciH2Tsv9d2w3QCIwCfYLLbvfNfk=
X-Received: by 2002:a17:903:120e:b0:15e:84d2:4bbb with SMTP id
 l14-20020a170903120e00b0015e84d24bbbmr21885314plh.165.1651689833389; Wed, 04
 May 2022 11:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220503005801.1714345-1-Frank.Li@nxp.com> <20220503005801.1714345-9-Frank.Li@nxp.com>
In-Reply-To: <20220503005801.1714345-9-Frank.Li@nxp.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 4 May 2022 13:43:41 -0500
Message-ID: <CAHrpEqSSfk37Z1v=TbXc5LbL4JxcET0qzcUW7y7UFJ3adp=W2Q@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI
 for chip specific flags
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 2, 2022 at 7:58 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
> allows only 32bit access to the DBI region.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

I just found a fixed patch already upstreamed.
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=fixes&id=8fc5133d6d4da65cad6b73152fc714ad3d7f91c1

So this patch can be skipped. This is the last patch about eDMA change.

best regards
Frank Li

> ---
> Change from v6 to v10
> - none
> Change from v5 to v6
> - use enum instead of define
> New patch at v5
> - fix kernel test robot build error
>
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
>  include/linux/dma/edma.h              |  2 ++
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 2ab1059a3de1e..2d3f74ccc340a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -417,15 +417,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>                 SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>                           (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>                 /* Linked list */
> -               #ifdef CONFIG_64BIT
> -                       SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> -                                 chunk->ll_region.paddr);
> -               #else /* CONFIG_64BIT */
> +               if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> +                   !IS_ENABLED(CONFIG_64BIT)) {
>                         SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>                                   lower_32_bits(chunk->ll_region.paddr));
>                         SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>                                   upper_32_bits(chunk->ll_region.paddr));
> -               #endif /* CONFIG_64BIT */
> +               } else {
> +               #ifdef CONFIG_64BIT
> +                       SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> +                                 chunk->ll_region.paddr);
> +               #endif
> +               }
>         }
>         /* Doorbell */
>         SET_RW_32(dw, chan->dir, doorbell,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 7baf16fd4f233..1664c70a8a0c5 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -36,9 +36,11 @@ enum dw_edma_map_format {
>  /**
>   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>   * @DW_EDMA_CHIP_LOCAL:                eDMA is used locally by an endpoint
> + * @DW_EDMA_CHIP_32BIT_DBI     Only support 32bit DBI register access
>   */
>  enum dw_edma_chip_flags {
>         DW_EDMA_CHIP_LOCAL      = BIT(0),
> +       DW_EDMA_CHIP_32BIT_DBI  = BIT(1),
>  };
>
>  /**
> --
> 2.35.1
>
