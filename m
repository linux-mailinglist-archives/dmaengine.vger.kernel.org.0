Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E17C508F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjJKKvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJKKve (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 06:51:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5FD98;
        Wed, 11 Oct 2023 03:51:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50435a9f800so8723245e87.2;
        Wed, 11 Oct 2023 03:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697021491; x=1697626291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShGf3xWZxL7u0sSfNkL2qhOkBWoTr/U461AtsQmQLsI=;
        b=IkYbRwfpNrAqKjMikTYW8hik6loecCpGmdFCxlhEN4gKH0D/NhCF35XDwynRoSma9o
         4Vr+q0lhT5+qvZGOSxxKmYEOjBk3lWYEXyYXL7KJZPwwyrhIkayIVg7HP/At2izsLsmU
         rBJ9h57VYoeXYidqgMz0GgujfIHei4aHzSsBwpshA43NdC6+1okP55w1v/h833Jn3JZe
         KGzdE3BDFZXMk7NrU/ziCRQ6jYZ6t4kV24hKbLLPGHrY//LK9TwlzfJMC9fCAefOaZL7
         9e8JBb96PHBACcLbUb4G2j2RwRWlnOyGRkzUY02Pww53scarM3pqAuK5DYkoLRiwGn+D
         O6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021491; x=1697626291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShGf3xWZxL7u0sSfNkL2qhOkBWoTr/U461AtsQmQLsI=;
        b=JMRjg4ZpAu2CDWnU1Z1TQsK/xRC1klTtLWEFZTNbrQmIVtrPUObkFoHt+bme84+qqm
         R5wIQ92lzAGpSyO60Ta+fbAj1H1kUxwvXzAWs+jYlNB0ed6iykZKz6TtgaCpF+MDuJTF
         8QBX58RXZHVe+jlhLTmCHZsE6KZKQrYzHdbcEGLZ5h55LlWjsy7RL4hvLWJ9Gnm9u66q
         vP9fJof482j/HUOpwMzSC7faUpFhimqIqaL3psv5i4577xLUrrUkpNa0PKYnZniX2NRj
         Q4k4ZFbS++P04ADyRazJ8cm1JogIbtn6LIzdKsBuP6lEjz75Huo3xL7B+6cbvg5tnCEZ
         W3BQ==
X-Gm-Message-State: AOJu0YwOxResqTwbxNqX3H4GB0StIzUpQP4Un1mj3LRK7InX+OriALgg
        9nj3ov8c2b9rKqLC52ydw4c=
X-Google-Smtp-Source: AGHT+IH2nfOeFbPn9InT7+ExjXjVAIkXx7SMWRZK2sgYZeeCXsnyc6hx/W6r2oITFhenTPbCXiaX5w==
X-Received: by 2002:a05:6512:3da8:b0:4ff:7f7f:22e7 with SMTP id k40-20020a0565123da800b004ff7f7f22e7mr20316256lfv.17.1697021491108;
        Wed, 11 Oct 2023 03:51:31 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l21-20020ac24315000000b00500a4679148sm2215812lfh.20.2023.10.11.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:51:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 13:51:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v3 6/6] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <ikc5snu4zgrfvo7ecelgu3mlqknvxoahmisqwqmmzph6bx4tos@e6yzx7kxmpk5>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
 <20231011-b4-feature_hdma_mainline-v3-6-24ee0c979c6f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-b4-feature_hdma_mainline-v3-6-24ee0c979c6f@bootlin.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 11, 2023 at 10:11:45AM +0200, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the eDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error can appears.

s/can appears/will occur

> In remote setup we can only use a readl to the memory to assured the full

s/assured/assure

> write has occurred.
> 
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> 
> Changes in v2:
> - New patch
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b38786f0ad79..6245b720fbfe 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -346,6 +346,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
> +	 * configuration registers and Application memory are normally accessed
> +	 * over different buses. Ensure LL-data reaches the memory before the
> +	 * doorbell register is toggled by issuing the dummy-read from the remote
> +	 * LL memory in a hope that the posted MRd TLP will return only after the
> +	 * last MWr TLP is completed
> +	 */
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		readl(chunk->ll_region.vaddr.io);
> +}
> +
>  static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -412,6 +426,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
>  	}
> +
> +	dw_edma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
>  		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
> 
> -- 
> 2.25.1
> 
