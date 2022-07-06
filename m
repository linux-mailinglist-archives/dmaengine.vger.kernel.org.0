Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281F45681A5
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiGFIeT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiGFIeS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 04:34:18 -0400
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 01:34:17 PDT
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:101:465::204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2E0240BB;
        Wed,  6 Jul 2022 01:34:17 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4LdCNr02Qxz9sR1;
        Wed,  6 Jul 2022 10:28:28 +0200 (CEST)
Message-ID: <d860aca2-442a-8583-e39a-1fdc2a5945b5@denx.de>
Date:   Wed, 6 Jul 2022 10:28:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] dmaengine: altera-msgdma: Fixed some inconsistent
 function name descriptions
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        olivierdautricourt@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220706082605.114907-1-jiapeng.chong@linux.alibaba.com>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220706082605.114907-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4LdCNr02Qxz9sR1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06.07.22 10:26, Jiapeng Chong wrote:
> Inconsistent function names describing msgdma_chan_remove() and
> msgdma_dma_remove are modified to msgdma_dev_remove() and msgdma_remove().
> 
> Remove some warnings found by running scripts/kernel-doc, which is caused
> by using 'make W=1'.
> 
> drivers/dma/altera-msgdma.c:927: warning: expecting prototype for msgdma_dma_remove(). Prototype was for msgdma_remove() instead.
> drivers/dma/altera-msgdma.c:758: warning: expecting prototype for msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead.
> 
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> Changes in v3:
>    -Modified the commit title and message.
> 
>   drivers/dma/altera-msgdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 6f56dfd375e3..4153c2edb049 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -749,7 +749,7 @@ static irqreturn_t msgdma_irq_handler(int irq, void *data)
>   }
>   
>   /**
> - * msgdma_chan_remove - Channel remove function
> + * msgdma_dev_remove() - Device remove function
>    * @mdev: Pointer to the Altera mSGDMA device structure
>    */
>   static void msgdma_dev_remove(struct msgdma_device *mdev)
> @@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
>   }
>   
>   /**
> - * msgdma_dma_remove - Driver remove function
> + * msgdma_remove() - Driver remove function
>    * @pdev: Pointer to the platform_device structure
>    *
>    * Return: Always '0'

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
