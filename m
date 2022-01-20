Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD11495470
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jan 2022 19:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377362AbiATSwB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jan 2022 13:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377356AbiATSwA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jan 2022 13:52:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066FC06173F
        for <dmaengine@vger.kernel.org>; Thu, 20 Jan 2022 10:52:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id pf13so6818502pjb.0
        for <dmaengine@vger.kernel.org>; Thu, 20 Jan 2022 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8EtW5aJUkZlLqS6KByBwT87+2IR1JSn6MQ8pl+a1L1I=;
        b=NQYgEA4M/w5/oPAMr8pOQ9c83buHBZm1EOwnhxvMJD73dViVTwW7SLmFSapT8MzP0k
         lp1qLzKIbojGpeLkOn1wqY9P1fr3M9lleuPC7xsasrVHWj2ODjuxoLGvzMVW6VwclLHu
         22vQjx+Zt/s4e0x5Fixv7T+W/WpFZC1ypEv9TEvEW0/cG+4OBEP2mLfdU5m4VnxRSq4h
         pZs5usczWpG+aEqvRpk0LiNJLQ7uKPzU/QjHZiFDQlWpbKtn0iSnaQDHbLBvkG6eQ9J2
         hOGCTa95y9r4vAvQ/OHyTOXA3RAGK8CF+2cQ2FazuMfX1SR+dfkWnCG33Gv/9XwxtBkk
         +sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8EtW5aJUkZlLqS6KByBwT87+2IR1JSn6MQ8pl+a1L1I=;
        b=I0dh29iaNOWd8XllryrboJfoOVhDaJne/I1+HOkg9mZRUvFFflEXGYH7BdPpJCJtzs
         I1VCl7iAt0UoUrZ4FWjRfFFkCy6A0hNHvbA9GQIfNcBKsnqpwcNQyx0LafESvXYW3tcj
         hEHA1a4+Hv8T17pUkOHxYhf5u+TqSsZH21z2BdySdNVzQUtfYlf5w6R5YOtR62lT0PsN
         j8TbrVc40J153k3p0MjBj/n++NucVOvQ1tp2/1vD3HUsflqjt0Sqq73sf3hg437I1/g7
         xRw5x8zTVOWTZUa3BqjLzxkTjBVc4t5RS5bvXvfS+kqczeO22clgKBBGxiv615IjyAwf
         acdA==
X-Gm-Message-State: AOAM533nGBiWzqTpTUIBw8Gq6meo5VqUmT6HDbnv1Q6GPN8nVxpLoVCw
        SK3sW8AxJ4i/FKyLUTj6eJIxbA==
X-Google-Smtp-Source: ABdhPJwOcKX4q0aXSX3awK4t1GwYFAHIAnuIczRRG34WtbQiXod6hQvEiN93AyBbUWCvMdAzZb7Ngw==
X-Received: by 2002:a17:902:7401:b0:14b:1339:58cf with SMTP id g1-20020a170902740100b0014b133958cfmr81275pll.66.1642704719518;
        Thu, 20 Jan 2022 10:51:59 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id q4sm4512124pfu.15.2022.01.20.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:51:59 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:51:59 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:51:23 PST (-0800)
Subject:     Re: [PATCH v4 3/3] dmaengine: sf-pdma: Get number of channel by device tree
In-Reply-To: <0d0b0a3ad703f5ef50611e2dd80439675bda666a.1642383007.git.zong.li@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-5b3e2596-3558-4534-9229-26885ee4cc5c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 16 Jan 2022 17:35:28 PST (-0800), zong.li@sifive.com wrote:
> It currently assumes that there are always four channels, it would
> cause the error if there is actually less than four channels. Change
> that by getting number of channel from device tree.
>
> For backwards-compatible, it uses the default value (i.e. 4) when there
> is no 'dma-channels' information in dts.

Some of the same wording issues here as those I pointed out in the DT 
bindings patch.

> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 20 +++++++++++++-------
>  drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index f12606aeff87..1264add9897e 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
>  static int sf_pdma_probe(struct platform_device *pdev)
>  {
>  	struct sf_pdma *pdma;
> -	struct sf_pdma_chan *chan;
>  	struct resource *res;
> -	int len, chans;
>  	int ret;
>  	const enum dma_slave_buswidth widths =
>  		DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
>  		DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
>  		DMA_SLAVE_BUSWIDTH_64_BYTES;
>
> -	chans = PDMA_NR_CH;
> -	len = sizeof(*pdma) + sizeof(*chan) * chans;
> -	pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +	pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
>  	if (!pdma)
>  		return -ENOMEM;
>
> -	pdma->n_chans = chans;
> +	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +				   &pdma->n_chans);
> +	if (ret) {
> +		dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> +		pdma->n_chans = PDMA_MAX_NR_CH;
> +	}
> +
> +	if (pdma->n_chans > PDMA_MAX_NR_CH) {
> +		dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
> +		return -EINVAL;

Can we get away with just using only the number of channels the driver 
actually supports?  ie, just never sending an op to the channels above 
MAX_NR_CH?  That should leave us with nothing to track.

> +	}
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> @@ -556,7 +562,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
>  	struct sf_pdma_chan *ch;
>  	int i;
>
> -	for (i = 0; i < PDMA_NR_CH; i++) {
> +	for (i = 0; i < pdma->n_chans; i++) {
>  		ch = &pdma->chans[i];
>
>  		devm_free_irq(&pdev->dev, ch->txirq, ch);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 0c20167b097d..8127d792f639 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -22,11 +22,7 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>
> -#define PDMA_NR_CH					4
> -
> -#if (PDMA_NR_CH != 4)
> -#error "Please define PDMA_NR_CH to 4"
> -#endif
> +#define PDMA_MAX_NR_CH					4
>
>  #define PDMA_BASE_ADDR					0x3000000
>  #define PDMA_CHAN_OFFSET				0x1000
> @@ -118,7 +114,7 @@ struct sf_pdma {
>  	void __iomem            *membase;
>  	void __iomem            *mappedbase;
>  	u32			n_chans;
> -	struct sf_pdma_chan	chans[PDMA_NR_CH];
> +	struct sf_pdma_chan	chans[PDMA_MAX_NR_CH];
>  };
>
>  #endif /* _SF_PDMA_H */
