Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9A7879CD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 23:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjHXVB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHXVB1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 17:01:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87719BF;
        Thu, 24 Aug 2023 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Fl4eLz5lzAqdsfi+t5jmV/ItDNikXzAC07w0ACaPhec=; b=GPHn5098lZiSjTzuo3IGsOnJNk
        qP73ttw0VHgGqMzH/iIiNBWV+fcJuQPZH8dPNTH5XtAVh81T480f6FuXpviXDeibvvf2UZns0RZx9
        sDNPS1KjlXrZdxhkluzYLuUzhPUCZJFAiJA0iAROcD0JTfGWi9+ejji9Elr1a7IDnfqwQF9BlKVGx
        7Aned0DSUddatLZ53TBpwtaH+FaO9PCZsRnckMiYdNwv9yohkH+gPiDieFCol1jT8pSxeHTFm8N5B
        IN0NURRkb7LuBfrWH3sY/aX/3aZuOh9J49Um9ZflAREyXb9tpyW4Y4zK22JZ5JjAlorIlaLykoVYQ
        vpkm+lpg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZHSG-003n2q-0r;
        Thu, 24 Aug 2023 21:01:24 +0000
Message-ID: <b1c5ba0d-748f-ae2e-4a5f-e1e853161d16@infradead.org>
Date:   Thu, 24 Aug 2023 14:01:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
References: <20230824145834.2825847-1-Frank.Li@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230824145834.2825847-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/24/23 07:58, Frank Li wrote:
> Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for fixing. :)

> ---
> 
> Notes:
>     Change from v2 to v3
>     - Again, fixed order
>     
>     Change from v1 to v2
>     - alphabetical order
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23eafda02056..c1c7a9ae244f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8236,6 +8236,14 @@ F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
>  F:	drivers/spi/spi-fsl-dspi.c
>  F:	include/linux/spi/spi-fsl-dspi.h
>  
> +FREESCALE eDMA DRIVER
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +F:	drivers/dma/fsl-edma*.*
> +
>  FREESCALE ENETC ETHERNET DRIVERS
>  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
>  M:	Vladimir Oltean <vladimir.oltean@nxp.com>

-- 
~Randy
