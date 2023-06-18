Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610D17348B1
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFRVsI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFRVsH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 17:48:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F001116;
        Sun, 18 Jun 2023 14:48:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b47742de92so5406031fa.0;
        Sun, 18 Jun 2023 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687124884; x=1689716884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MHhQu46HJCs+E06mp8knd5RyBeyes00wowJAgVA0z4M=;
        b=Ff37c3lEnLGYe9fmRivd775l5OlE78EW8E3bSOzUIFbhV+QXH1tNIQ473f358tgfUe
         n/cs7256PlSNejIojidAEMx5YPFK7ErXYc6/NbENxfqsho7nRN0S+sFncYIEcJhc1d3U
         EmXzs78qJoJ9EOfK6nwESUih/xkYsxmEe7wPZt0g8aMbV417b1rnmJmxfb10CcLsFyqK
         dGVJbBC8ZTRbrQmDhaNOMzZ8jRN1dzEcoHNBgaQ/QDiNUIZTVsWrt0yNzEH9U7MppKe1
         JguPeUkhYpq4tC41kFrqCOKo7twwSyLTw3dUFDsexyabi5UKv9W83gWhXG822hrayiOZ
         3wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687124884; x=1689716884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHhQu46HJCs+E06mp8knd5RyBeyes00wowJAgVA0z4M=;
        b=fgJB9ytZtjewR9eYOUNVGWDdgyGXV+8LVaFwzzNPMi1Z0OHImxk6i1TQA8BV/YLrID
         5KA3ZGnGPDkVwiVPWuBtoHRzdemKZMbcFPRQJd+TzLhzq20ex+Rtf/h0bC1Yq5yg/OSo
         DxokiqcdPw51DN+7E+1ZN1EolZ0VTuj5Mka0lDH44IMi7vhvYfCt6A+LNcIO9WZ/Xtez
         L5k3euurGavmD7ilDPX6vpH5jXv5PrjPFPyz8uVo5SQRXNfRHyrJegz4J2CnNdf2DIxq
         5c3YEg/K8NR49OrHJUe+1WkGyoN4Y9fyuDJOjIvJPiQcbLf4TJDibvsy0ZslAtpCRrsO
         67Wg==
X-Gm-Message-State: AC+VfDwwpIl6nEA1iEjstgKwbSUaFp5AavwjJPzIuwL9MuwJpHju2yXj
        xQ/ESSyflrx2Ur/cKJNZjOw=
X-Google-Smtp-Source: ACHHUZ6ya+HNcdAX9cKgmmPr+85EkMZGrlJg3B5XKrkRv7tVP4E1/KrHpBrhEzRIJQSP1KGdKoNmnw==
X-Received: by 2002:a19:3844:0:b0:4f8:71bf:a25b with SMTP id d4-20020a193844000000b004f871bfa25bmr144284lfj.9.1687124884329;
        Sun, 18 Jun 2023 14:48:04 -0700 (PDT)
Received: from mobilestation ([91.193.179.15])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004f84436217fsm1655796lfg.73.2023.06.18.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:48:03 -0700 (PDT)
Date:   Mon, 19 Jun 2023 00:48:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 3/9] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
Message-ID: <20230618214800.5h4ni43vu2admho5@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-4-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609081654.330857-4-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 09, 2023 at 10:16:48AM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Only the local interruption was configured, remote interrupt was left
> behind. This patch fix it by setting stop and abort remote interrupts when
> the DW_EDMA_CHIP_LOCAL flag is not set.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> ---
> 
> This patch is fixing a commit which is only in dmaengine tree and not
> merged mainline.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index da8663f45fdb..7bd1a0f742be 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -232,6 +232,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>  		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
>  		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;

> +		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;

Seems reasonable especially seeing there is a code with a similar
semantic in the dw_hdma_v0_core_write_chunk() method.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Just curious whether we really need to have the local IRQs left
enabled for the remote device setup... The only case I have in mind is
that it would be useful to signal a remote end-point host of such
event in some application-specific environment. It sounds exotic but
still possible.

-Serge(y)

>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> -- 
> 2.25.1
> 
