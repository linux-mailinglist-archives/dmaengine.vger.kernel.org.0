Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB36734887
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 23:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFRVPk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFRVPi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 17:15:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B31A6;
        Sun, 18 Jun 2023 14:15:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f841b7a697so3075457e87.3;
        Sun, 18 Jun 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687122935; x=1689714935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDzL659mInwMNE073Jb4Ftlk6P1hdEMNdSJRGCKw9YI=;
        b=c6Pmlzs5fS2xSN3DeE3uS0xxrFBFE3j/FB43UgBcrDPzeiN5c5U5nc58MUHJoEE7W6
         T705/CNKQGJbSNyzQQOA5vBocHYiMwQkTJy0ZMiygnxPbpoHqePtUP9GiQ5exNRbjE1S
         E9yWGAnV6nqR7mUqh5NvC5etDIN2IRCFg8rh5ytU28pdcEeXm4SZ/LOTNQYtPsaypamB
         BPs3n/Lf48tqmSe6S6BjW8eW6q6/WB2p1Gn+rq5A1L5dxqIT3lzXMyXKxNRZXk1GtZV7
         9CWOtM2/7mQlRryxIudgiNGqmheKXNqLuwTKlEuyXjFZa5VRTAOl3WvMsUm/dWQ/n4Ca
         KAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122935; x=1689714935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDzL659mInwMNE073Jb4Ftlk6P1hdEMNdSJRGCKw9YI=;
        b=ESYMjhaGACiLJsLQryQWaqKxnfGv33Fojzmx+1ZJlk/nQOJw6tciTAQXI5DtVXoQUC
         6kyck7rVTD79i+ENptgULHe5GDZoYLqsi27xPy8Ek/JYWJSCRt+BWApbBH25y3emL2jD
         q12iY+CMD41E8CcBVSe4i3RmyJbOcvQopr5SDQcNEH3xoK9F1VPN3nyJPcN4kaKGlhEb
         ZscBCDHNYSunnNqAw1XK/Tkl+e00O+gGXz4V9GNSpepIanmIP9pQRlfFF6gfFx8fYoa9
         vuAL0bl4TCZkt5zre5KAodsZIPDdnSOXbvQ6oooCuQPYcZx7+RelDt+g0i6lAGLBEpS9
         z+Jw==
X-Gm-Message-State: AC+VfDytXbbAGFU2PoTV3SoXUwMlXKl9YqUXD+VT7KBiY8PBZ/nIZxTI
        432j9hLsM1MMSyyY+lv17agAgCbrdFQ=
X-Google-Smtp-Source: ACHHUZ7m+xQcbaaGrCapaXBaL+68//v4vIMc67+ieFzpk1c8egQVeIBYlxVloIb6Lt9khiY/1ER3QA==
X-Received: by 2002:a19:2d17:0:b0:4f8:55dd:e726 with SMTP id k23-20020a192d17000000b004f855dde726mr3895472lfj.12.1687122935062;
        Sun, 18 Jun 2023 14:15:35 -0700 (PDT)
Received: from mobilestation ([91.193.179.15])
        by smtp.gmail.com with ESMTPSA id eo13-20020a056512480d00b004f84b7541c5sm1316726lfb.3.2023.06.18.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:15:34 -0700 (PDT)
Date:   Mon, 19 Jun 2023 00:15:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 2/9] dmaengine: dw-edma: Typos fixes
Message-ID: <20230618211531.xyempyr4yfrram67@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-3-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609081654.330857-3-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 09, 2023 at 10:16:47AM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error.
> Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
> bit is already set in the same line.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")

Good catch! Thanks for the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* It seems to me that the DMA-abort path of the DW HDMA driver hasn't
* been well tested.

-Serge(y)

> ---
> 
> This patch is fixing a commit which is only in dmaengine tree and not
> merged mainline.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index de87ce6b8585..da8663f45fdb 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -231,7 +231,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		/* Interrupt enable&unmask - done, abort */
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>  		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> +		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index a974abdf8aaf..eab5fd7177e5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -15,7 +15,7 @@
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> -#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
> +#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
>  #define HDMA_V0_ABORT_INT_MASK			BIT(2)
>  #define HDMA_V0_STOP_INT_MASK			BIT(0)
>  #define HDMA_V0_LINKLIST_EN			BIT(0)
> -- 
> 2.25.1
> 
