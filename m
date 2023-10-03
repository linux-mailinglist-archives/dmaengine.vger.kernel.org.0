Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C567B67C5
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjJCLXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 07:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCLXk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 07:23:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89978E;
        Tue,  3 Oct 2023 04:23:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-504427aae4fso5116360e87.1;
        Tue, 03 Oct 2023 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696332216; x=1696937016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2TdzkuFEpDl4t3q/Kjs9DD3oRaFiqjM4irBtEHakYY=;
        b=Hc35AOeZ5wbXbKIJgltVFIikwQHsmoCxnC2hPQLIcANveqNcEOqQRuxVkvB32Wh0XF
         wIiF+N8AfQBq1xL8u10c54ZukpwT8rI4gX96U/AFl0fb615WGyzGUNZXh6XARx8T5unb
         +ujPoIz/5y1HYhCqZbnojGRQ9qqvj/xBwi4ajqXAiiiY/COddKRhUUchRvWLzfSmDnp1
         TG6/nChMK3zmL2+ev1KQdG1cAya57Sv4d50N1q9Td/f0xmXIZWhjeAZJ9rAH5Z09ZzoJ
         M8LofW4IdK0zd5mUJsdqMJfgQPGGadE4lGaHKJ1IBITEYPFv2YtaFOm/V+sKtrIiCZEa
         qB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696332216; x=1696937016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2TdzkuFEpDl4t3q/Kjs9DD3oRaFiqjM4irBtEHakYY=;
        b=mzV0b7Ode/o0neR1DwkQD2KN0/Oe67TI/xfdlM1Qq+3XBVfy9f96mQMemR7UjLJ8Az
         WWkmu2xFZe05FQ6NwDIdzXB5igZ9JUcoHuHs/t470cEhtyh8DRG6t99VQHkruuvn2iFz
         uiaucpC2BRs5izYVTWDPyNnfnvG2Iei0DCzV9QbyH04GhYNPjQksQ+qbR5MlPnv9R6pY
         ed6lKfq+XhxP82p871X8FQVw5CTdiVa235E8lEe/j0zZiqAmFkejfqMa5lDjp49aUsMx
         gfu5+ogCadFSzEIZhV0+X1CKZnUgJVsVuyxLHSROaxqZdwcQKyMi36n6HPjTUMqf5A/4
         rk2Q==
X-Gm-Message-State: AOJu0Yys9RX5qpp9DDpjtqITa6+/VW45ZMti+DgB4ZXRN4XVGMNGfhud
        aeaDTFJaKhHeZnrd4YKVecHZ4Pustbw=
X-Google-Smtp-Source: AGHT+IGjmd9O1S2R/S64rNqR0QuWP/7kUnqlRDeUArm0jDPeju0x12UPkTza8388cVcRQkUf89H9ZQ==
X-Received: by 2002:a05:6512:3d25:b0:502:d973:3206 with SMTP id d37-20020a0565123d2500b00502d9733206mr1730581lfv.6.1696332215541;
        Tue, 03 Oct 2023 04:23:35 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b28-20020ac2563c000000b0050419b760d0sm158429lff.17.2023.10.03.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:23:34 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:23:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 1/5] dmaengine: dw-edma: Fix the ch_count hdma callback
Message-ID: <oaruj6536km22odi7ya4np7qofyinyyr7zeqhmnzmkiamu4425@wx6a5qcf3fch>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-2-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cai,

On Mon, Oct 02, 2023 at 03:17:45PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The current check of ch_en enabled to know the maximum number of available
> hardware channels is wrong as it check the number of ch_en register set
> but all of them are unset at probe. This register is set at the
> dw_hdma_v0_core_start function which is run lately before a DMA transfer.
> 
> The HDMA IP have no way to know the number of hardware channels available
> like the eDMA IP, then let set it to maximum channels and let the platform
> set the right number of channels.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 

> See the following thread mail that talk about this issue:
> https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/

Cai, do you have anything to add in regards to this change and to the
discussion available in the thread above? If no, I guess the solution
provided in this patch is the best we can currently come up with.

-Serge(y)

> 
> Changes in v2:
> - Add comment
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 00b735a0202a..3e78d4fd3955 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -65,18 +65,11 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  
>  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> -	u32 num_ch = 0;
> -	int id;
> -
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> -			num_ch++;
> -	}
> -
> -	if (num_ch > HDMA_V0_MAX_NR_CH)
> -		num_ch = HDMA_V0_MAX_NR_CH;
> -
> -	return (u16)num_ch;
> +	/* The HDMA IP have no way to know the number of hardware channels
> +	 * available, we set it to maximum channels and let the platform
> +	 * set the right number of channels.
> +	 */
> +	return HDMA_V0_MAX_NR_CH;
>  }
>  
>  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> -- 
> 2.25.1
> 
