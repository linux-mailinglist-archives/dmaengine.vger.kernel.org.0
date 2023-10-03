Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49537B686B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjJCL7R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCL7Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 07:59:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A1A6;
        Tue,  3 Oct 2023 04:59:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bffa8578feso9858731fa.2;
        Tue, 03 Oct 2023 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696334351; x=1696939151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRQsXlis8bcxxf3Vikn6E0Pq7/PwcJpTSRHT5Z+ns0I=;
        b=W3T0/J0x6+UESw3v7XLuviyixi+cMiPoCssMaFHQx8CKhGDL4rFcRCImT9NrCBah0O
         m8w0O6/rmMJUENI2VQwHhh7B4tduGZH5R2cuz4ZOun8GkatzjTbZedncIUdiV/vRnSxy
         BtN20cUELfjjL+UjyWap4zenIsZdh9xjwXHaOm1MKLHGdGpQ8aM3m9PdCtWtomCaCUUZ
         dfD+DNjsVqJbBvmpBqzbMkoJEQwcpravM7u5O5e45Sid6UNFJKuBZmSTd1G59UK6PIw6
         +CE9VC+aOXxG037vbOkCf0NJdG6GgDOKBrRarHPv3KjbDb5lPFiHaIR0FYcsz+iW2zP+
         hFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334351; x=1696939151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRQsXlis8bcxxf3Vikn6E0Pq7/PwcJpTSRHT5Z+ns0I=;
        b=ep1kk97MYHQBK/AwLAd7aVN2ghgD7C+mtumN81epUmsJrRbYiEQ4cKggMUslTgoM8t
         XliHOsSLe62Z3+X6Gq3IA9q1mFUquhktDs8QYQjlRpwjNPF9+ZhK4bYJXeYLISfcaq9q
         jNQopqXUCrFkDdupFxmH/lrn82mu2D8uukHFaWzSbUGj6ur5Uel7ni3X5MoG1Opmzs0d
         sn1QjoWGZo3suqD0C6IaaHwofGdI78kH1fLVOMYBEf4YKfema67ajAYEe+VceH2Qcrz+
         n90KI3PyklWdzP+54aRDZVsZFg5sFJI6Bylj3o0dyDVlCVHjwVfjSzPBpy0PkVHlO+lJ
         mowQ==
X-Gm-Message-State: AOJu0Yw5RKhRsa/p0uQboJnh4a2ZLpJMmeaONY5gV77tJhqxyNQ93xmz
        pEEOXRODqaDw9kSqSEmf+hU=
X-Google-Smtp-Source: AGHT+IGCn4atHOBNQrAn4W8VAMNSpDAygO3YqoEz6RSbhWQGUE3O/PtKQJJ2Fhx1NZcRcK1MHiGhPg==
X-Received: by 2002:a2e:b0c4:0:b0:2c0:240:b574 with SMTP id g4-20020a2eb0c4000000b002c00240b574mr13124283ljl.31.1696334351131;
        Tue, 03 Oct 2023 04:59:11 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h3-20020a2e9003000000b002bff98b3080sm205688ljg.60.2023.10.03.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:59:10 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:59:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 5/5] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <gf3oy5d2ycuvdkbvjc7iyavccfys24vpeil4pfe7svup2z5pvu@dxdqwvxqatuf>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-6-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-6-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 03:17:49PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The Linked list element and pointer are not stored in the same memory as
> the eDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error can appears.
> In remote setup we can only use a readl to the memory to assured the full
> write has occurred.
> 
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b38786f0ad79..75c0b1fa9c40 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -346,6 +346,25 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  

> +/**
> + * dw_edma_v0_sync_ll_data() - sync the ll data write
> + * @chunk: dma chunk
> + *
> + * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
> + * configuration registers and Application memory are normally accesse
> + * over different buses. We need to insure ll data has been written before
> + * toggling the doorbell register.
> + */
> +static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		/* Linux memory barriers don't cater for what's required here.
> +		 * What's required is what's here - a read of the linked
> +		 * list region.
> +		 */

The same comments as for [PATCH v2 4/5].

-Serge(y)

> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -412,6 +431,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
>  	}
> +
> +	dw_edma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> -- 
> 2.25.1
> 
