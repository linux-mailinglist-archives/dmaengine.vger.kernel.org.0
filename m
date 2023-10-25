Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24367D6C9E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjJYNBX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 09:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjJYNBW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 09:01:22 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1690
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 06:01:20 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 771793FD3A
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698238871;
        bh=Ja9/pCBWGEb2jT4TVb34dvtYhqs8vTUmcB3t9wcKY1o=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EHYy9dt903g8qiZzSrrqfJaJsy8c7VpZeHGOPco6b18HEWSAyGvstFFMnK6D6YOSY
         P3ri4q52Szp63XWu/NIclAeU6MQWerLvECopD96SuMqDCdeAeb5Qs1npLAK0hdbSaZ
         H/hB2X3MmboO/YlKAkdQOPeHRDO2Kz79OqBdQI3UDJc69NK2cijDQnAYQaqtQx+HlN
         jmKR5fRQn829vaexNbqZjurSbKsLIabG1JnmRCUyBLhvE/1ZRzLAnA7S/lpICnipfF
         N3g2sCfd4jbDIdXh63h43u7xrkvFp0fnOT3IBwUoo05w2N/jGYK+sM/9tiPqyiLM8R
         ZYtQO3+cvFuGg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cba6d1330so57526491cf.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 06:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238868; x=1698843668;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja9/pCBWGEb2jT4TVb34dvtYhqs8vTUmcB3t9wcKY1o=;
        b=StS75BKFD45JRzvYxUiF0ROkC6m7d9DfXtBhgLsobEe9pkcB9qkvmNIYTJRqhRmv6H
         eSVDZYNfuAX3AnsUthPSDquEh04qa4ReiCtdgtgPec27f9TRNfHvc/HMjPAvz49PMZ3F
         TWDqvyrAqV9FRpEjY8MTLvgu0fFojtHhnmVQFlFH853c08/Y89H7GYhlTEwnRu6rFu8J
         xmaiolgXc28oQgvO9jMIELP4AVc+dybLbEuS95vAB6puYShL/IET+jsSbFajS/QS80L0
         KkcHRSaoyuk4dHorXWKs59w2X5elA1RUy2bMOaW218hTExOuMaCJmn3bDg3KrrRkmS/A
         /66Q==
X-Gm-Message-State: AOJu0YzyKAyoYjrSRLFnaGftBv6ki9hR3/ABbxVs23Vt90wmxK8F1IOB
        645a/gK8RtLYpmLxxJQ39t5MhBE5eOTNth+Ko85AqVpLpogs9+j2Txty8CmIN5PTS7aeBzwDceG
        le8WwesHpIt7tIps30Lc+elVmNqSI4os/9q5rg7bYQ2ogf5ey2DBy9A==
X-Received: by 2002:ac8:7f55:0:b0:403:2877:bc52 with SMTP id g21-20020ac87f55000000b004032877bc52mr14847388qtk.0.1698238868273;
        Wed, 25 Oct 2023 06:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR4n03DxpEQ8FKBl/cC8JZSa2ZdjBM0k+4vHHfPQdbqvxHY2awJSdK2W4XYzETcAfXppp1yQjthWwRg+k5wtE=
X-Received: by 2002:ac8:7f55:0:b0:403:2877:bc52 with SMTP id
 g21-20020ac87f55000000b004032877bc52mr14847345qtk.0.1698238867829; Wed, 25
 Oct 2023 06:01:07 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 06:01:07 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231025102251.3369472-4-shravan.chippa@microchip.com>
References: <20231025102251.3369472-1-shravan.chippa@microchip.com> <20231025102251.3369472-4-shravan.chippa@microchip.com>
Mime-Version: 1.0
Date:   Wed, 25 Oct 2023 06:01:07 -0700
Message-ID: <CAJM55Z9s4AFcA0OdfBEOP8=OK9Oa3NzV5qZ9f-Q2f0Kn-BcE8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
To:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

shravan chippa wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Sifive platform dma does not allow out-of-order transfers,
> Add a PolarFire SoC specific compatible and code to support
> for out-of-order dma transfers
>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
>  drivers/dma/sf-pdma/sf-pdma.h |  8 +++++++-
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 4c456bdef882..9cc4beec40f0 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -25,6 +25,8 @@
>
>  #include "sf-pdma.h"
>
> +#define PDMA_QUIRK_NO_STRICT_ORDERING   BIT(0)
> +
>  #ifndef readq
>  static inline unsigned long long readq(void __iomem *addr)
>  {
> @@ -66,7 +68,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
>  static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
>  			      u64 dst, u64 src, u64 size)
>  {
> -	desc->xfer_type = PDMA_FULL_SPEED;
> +	desc->xfer_type =  desc->chan->pdma->transfer_type;
>  	desc->xfer_size = size;
>  	desc->dst_addr = dst;
>  	desc->src_addr = src;
> @@ -520,6 +522,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
>
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
> +	const struct sf_pdma_driver_platdata *ddata;
>  	struct sf_pdma *pdma;
>  	int ret, n_chans;
>  	const enum dma_slave_buswidth widths =
> @@ -545,6 +548,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
>
>  	pdma->n_chans = n_chans;
>
> +	pdma->transfer_type = PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
> +
> +	ddata  = device_get_match_data(&pdev->dev);
> +	if (ddata) {
> +		if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
> +			pdma->transfer_type &= ~(PDMA_STRICT_ORDERING) ;

The parentheses are unnecessary and you have an extra space.

With that fixed:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> +	}
> +
>  	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pdma->membase))
>  		return PTR_ERR(pdma->membase);
> @@ -632,9 +643,19 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static const struct sf_pdma_driver_platdata mpfs_pdma = {
> +	.quirks = PDMA_QUIRK_NO_STRICT_ORDERING,
> +};
> +
>  static const struct of_device_id sf_pdma_dt_ids[] = {
> -	{ .compatible = "sifive,fu540-c000-pdma" },
> -	{ .compatible = "sifive,pdma0" },
> +	{
> +		.compatible = "sifive,fu540-c000-pdma",
> +	}, {
> +		.compatible = "sifive,pdma0",
> +	}, {
> +		.compatible = "microchip,mpfs-pdma",
> +		.data	    = &mpfs_pdma,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 5c398a83b491..267e79a5e0a5 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -48,7 +48,8 @@
>  #define PDMA_ERR_STATUS_MASK				GENMASK(31, 31)
>
>  /* Transfer Type */
> -#define PDMA_FULL_SPEED					0xFF000008
> +#define PDMA_FULL_SPEED					0xFF000000
> +#define PDMA_STRICT_ORDERING				BIT(3)
>
>  /* Error Recovery */
>  #define MAX_RETRY					1
> @@ -112,8 +113,13 @@ struct sf_pdma {
>  	struct dma_device       dma_dev;
>  	void __iomem            *membase;
>  	void __iomem            *mappedbase;
> +	u32			transfer_type;
>  	u32			n_chans;
>  	struct sf_pdma_chan	chans[];
>  };
>
> +struct sf_pdma_driver_platdata {
> +	u32 quirks;
> +};
> +
>  #endif /* _SF_PDMA_H */
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
