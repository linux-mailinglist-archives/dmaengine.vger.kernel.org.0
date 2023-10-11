Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DDC7C5084
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjJKKry (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKrx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 06:47:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40B692;
        Wed, 11 Oct 2023 03:47:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so8480320e87.1;
        Wed, 11 Oct 2023 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697021270; x=1697626070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVKb52P/acdOegXUvVk4ObTPK15ZJRlslOWZhhK70RY=;
        b=GQZjJDQS0JFzerIRtunPw55XYZY1CBhImfgV/L2OpcHl95V9Qmgs057M4cVl0SZVkr
         cSeT00TYwJsplEm8hRDTTh/sioxt7O4eD0Vvqg832B3bTT6Pv7ujuPF32HxZwtRnsXwY
         tWBYWD+9xBvaXZhRRgKnydapxpg+2fNTw2Kztfn9aEfTFebBrdTgRLE3z0U8b2BZqd3L
         ZqNsHFwTgrnQkqP+MiZ0I1qOUxzuO1ci2Yc9WCYTT4RVXvK1vaaYQiP/AnceymBgYQsk
         Z1fuij7iMI/saIMFwdWeJ/ntp5qAqU1uCPRrP4sQUDkmBJ+Ryl5hCA888U0DnbEGy03r
         2hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021270; x=1697626070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVKb52P/acdOegXUvVk4ObTPK15ZJRlslOWZhhK70RY=;
        b=VDljj6wepBnf8Hhj9nj+n4OSX1kF1FS1sEzybAMluyz+JUN8x7fsfGqId+q5RVoYD4
         qcsvBe3qjdaXrbF6qIRbpvtplczwqffqcSEigElmPFJYK49o1MhroOELLJQvcNvNNb25
         /BZvrokRKiqYxC5fvuz1f5UVsP7M7/D1qBh9uk9faoE3VHVayzawsoWsrdR3JBXonHW/
         1R8S3uLqkiuzKAMYjo1zm+Pph+rAxPngqZavUKWbe+zlpXyXJxZCAcWc4p3NiK87Lym6
         bIWvWF7gxhT60x/Pf8YWB5X/lwMZ6OVAz45wjVaG/4a09MybFHFiqZxslzOL+9Y9UNNA
         xMug==
X-Gm-Message-State: AOJu0YyCDk/W8qIDwmE3c5m9fUMl7SVoGYd+2l+9lPBo5RoMG900R1GE
        HwqsLaj0hvvCDVKvANEpIEo=
X-Google-Smtp-Source: AGHT+IHwAwZ0p/8U14m7ATpDvmadPexRyhxkVxSyPsZgOitMCbTZVOF6c5Jh86N8Gak1nVW7nhI8TQ==
X-Received: by 2002:ac2:5b4b:0:b0:503:c45:a6e1 with SMTP id i11-20020ac25b4b000000b005030c45a6e1mr14760902lfp.46.1697021269672;
        Wed, 11 Oct 2023 03:47:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004ff96c09b47sm2214345lfi.260.2023.10.11.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:47:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 13:47:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v3 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <6adlujxc4cnrxbl5fbqpg5fishq7jvk6w6chgjyktbwcxd2dvi@w4ayo5ooh7fq>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
 <20231011-b4-feature_hdma_mainline-v3-5-24ee0c979c6f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-b4-feature_hdma_mainline-v3-5-24ee0c979c6f@bootlin.com>
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

On Wed, Oct 11, 2023 at 10:11:44AM +0200, Kory Maincent wrote:
> The Linked list element and pointer are not stored in the same memory as
> the HDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error can appears.

s/can appears/may occur

> In remote setup we can only use a readl to the memory to assured the full
> write has occurred.

s/assured/assure

> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> 
> Changes in v2:
> - Move the sync read in a function.
> - Add commments
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 04b0bcb6ded9..13b6aec6a6de 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
>  }
>  
> +static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
> +{
> +	/*
> +	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
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
>  static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
> @@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	/* Set consumer cycle */
>  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
>  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +
> +	dw_hdma_v0_sync_ll_data(chunk);
> +
>  	/* Doorbell */
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
> 
> -- 
> 2.25.1
> 
