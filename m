Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D89F7866B8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 06:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjHXEc5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 00:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbjHXEcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 00:32:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DAE68;
        Wed, 23 Aug 2023 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=746orTGtq/3Y4FFyVls6ol+pjnoLhQd/B1cSyG6hngo=; b=GmLqESQpDwGOLvhhspZHmweiqe
        nPoM7KU80gpiIJ5CCCosuOrnYEUV2eUV9cW1SMq0BrnAWj6S0X2p70EhWF1SMgQ0kxASb/e0Kv4HH
        Rlej8/nVUGXDlBvrfSayQ/weW8Z1Hmr44AxyPr1GrYyDcAEYsoSU9qc4L7doLS+qM1hvt/dX0nwLu
        wb3maWMAoLUCRsSrKVbOxeHPnPeclU3powJb+NaEzEaRKzW/KBCY6VQXJMhJntYUKrrU3EG9QcjqH
        fV4k15uxMHyloa/sTl1v/lqocodq1cYCznCJyruaPDPODSkpjcIqQqHoBxMjvb57/be0IvPSQh9cO
        IjIeLRag==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZ21E-002992-36;
        Thu, 24 Aug 2023 04:32:29 +0000
Message-ID: <2f664575-b821-2d10-0f0b-9ce443ba47a1@infradead.org>
Date:   Wed, 23 Aug 2023 21:32:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com, vkoul@kernel.org
References: <20230824030454.2807336-1-Frank.Li@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230824030454.2807336-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

This is still not in alphabetical order.

For v1, I said:

  This new entry should be after the following entry to maintain
  alphabetical order.

  >  FREESCALE DSPI DRIVER
  >  M:	Vladimir Oltean <olteanv@gmail.com>
  >  L:	linux-spi@vger.kernel.org


and that's still the case: "eDMA" should be after the "DSPI" driver.

On 8/23/23 20:04, Frank Li wrote:
> Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - alphabetical order
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23eafda02056..fbab3c404eb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8215,6 +8215,14 @@ S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-mcf.c
>  F:	include/linux/platform_data/mmc-esdhc-mcf.h
>  
> +FREESCALE eDMA DRIVER
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +F:	drivers/dma/fsl-edma*.*
> +
>  FREESCALE DIU FRAMEBUFFER DRIVER
>  M:	Timur Tabi <timur@kernel.org>
>  L:	linux-fbdev@vger.kernel.org

-- 
~Randy
