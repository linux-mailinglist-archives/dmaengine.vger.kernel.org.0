Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4631375DCEA
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jul 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGVObh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jul 2023 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVObh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jul 2023 10:31:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F671FE1;
        Sat, 22 Jul 2023 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fr2ejxWFvKI7dAiO99Gso+JFxyl8RnMHEndv9Ot3w78=; b=E0d08ih9jQN1qmuqfs/B2uDTMU
        yx0CsdxnFwOmXsLV95TYJg6iHsSj10dFQcunaIGhdVCOadUk3Ut9jg9a7MkXJnHzv1+mfIdDx7tir
        /eKX9shjqV65jkZKT0mNMZjOmJLO8ogoHUxG0ynHtesj9CWyLYLlosYByVT86ee9bM07ugY5VwHf9
        8O/khQqMhDBid3dWbfcfX3OErMH3olU90KGuD9wCwJjk5hTgF/Gwb6xu4ojz2h4pEQcc7CeAa8+Sj
        g3bX9Vf7Hsw+mFKD6gOPv+ezZxsLkGFGutWbwdknN+lsy5a9wqFMRzrq0U6zrvzaqNLy4lYdsQ2dL
        1Zta3GBA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNDdp-00Gr7T-0I;
        Sat, 22 Jul 2023 14:31:29 +0000
Message-ID: <8ccab042-e24c-c535-fe32-9a2062ba1bec@infradead.org>
Date:   Sat, 22 Jul 2023 07:31:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] dmaengine: owl-dma: Modify mismatched function name
Content-Language: en-US
To:     Zhang Jianhua <chris.zjh@huawei.com>, vkoul@kernel.org,
        afaerber@suse.de, mani@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230722153244.2086949-1-chris.zjh@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230722153244.2086949-1-chris.zjh@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/22/23 08:32, Zhang Jianhua wrote:
> No functional modification involved.
> 
> drivers/dma/owl-dma.c:208: warning: expecting prototype for struct owl_dma_pchan. Prototype was for struct owl_dma_vchan instead HDRTEST usr/include/sound/asequencer.h
> 
> Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/dma/owl-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 95a462a1f511..b6e0ac8314e5 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -192,7 +192,7 @@ struct owl_dma_pchan {
>  };
>  
>  /**
> - * struct owl_dma_pchan - Wrapper for DMA ENGINE channel
> + * struct owl_dma_vchan - Wrapper for DMA ENGINE channel
>   * @vc: wrapped virtual channel
>   * @pchan: the physical channel utilized by this channel
>   * @txd: active transaction on this channel

-- 
~Randy
