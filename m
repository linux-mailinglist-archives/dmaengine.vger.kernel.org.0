Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676D538A00
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiEaCrE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 May 2022 22:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiEaCrE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 May 2022 22:47:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9396393D6;
        Mon, 30 May 2022 19:47:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so8698367wrb.0;
        Mon, 30 May 2022 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tqeh56MwCKAQqD5lEvr2lLRAypFwZalceRE/Lz3EVyM=;
        b=Qtx49yFTZR43x/hcfYEQGZNxgSkEJmE/c+koB8DxRQe1QC0SxDEdlr29I3gQmnSCXT
         r7cggj+XkDXNKUAOzJVMI4vrzd87iz9uqTCvnaCqQkMasYK5DFAYvmeVp33BLV1rZ4Jl
         /9QgwZpFtUOyv2P7NOd2m1nd9QPpNlZsWfax04RebsIqQvPwzznVyq4WtEw4aEL/HFo5
         xcKVYvjBCYokPXLt4mT3wQZ7Z2UQF5pdVzPHTpqSvC4Emi0KXNAtO78pcsmhR4MjPlRI
         L5p4FYdsGYQJrkbyddhJBRD9lX1y5GYbdCq/T7zy2v0o2sT9xb2hy6ACr/BJgg+akcaP
         RlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tqeh56MwCKAQqD5lEvr2lLRAypFwZalceRE/Lz3EVyM=;
        b=BE3TL5BbV+74awcBqUcpHUqCrorrwi7xiLeJAhH8j6VcxrCbznqdvuz86cKX4x6dvf
         wsBpguhe3PfXKNU6+EY0rERN0OiBI2XhfmmjYpo9pXmW1Do7NoDQmiZvmZkc3z9lU8P7
         86GPabeC+9Oqv4XNKdEKuAqK2/3h4150WYNHtU7Gta+gM0FbjqxxtpTo04n1d8b2oEm/
         LUz+q4ueb+fPDm0ELZyIUyaOKGVyNfzBS+QTGRauhMacxM51B9qLeHsqY8n+51LBI50I
         SUjgpkMWoDkHVkUhMQijiVSOyK58Oi9PZRfWi/iekZdg+MYBik3tGkw4LuFS256+3Dvc
         VwQA==
X-Gm-Message-State: AOAM5330chN6Yy31O/MYrMeq0Jp5kE9D9WeeJVdaLkmjRcU5yePU62lw
        ZWIy3YOUmvI4+mBhHR3RfjA=
X-Google-Smtp-Source: ABdhPJxtAFg2mBE/um+Dcc3JPU6/kkuL8FeifCL+a6G6/OVUsQSoYscUIeDS9bDu6uAFwjEZSJHiOQ==
X-Received: by 2002:adf:e7ca:0:b0:210:941:3363 with SMTP id e10-20020adfe7ca000000b0021009413363mr20049801wrn.25.1653965221405;
        Mon, 30 May 2022 19:47:01 -0700 (PDT)
Received: from olivier-3493erg ([2a01:e34:ec42:fd70:8e84:c3a8:e5ed:7183])
        by smtp.gmail.com with ESMTPSA id d17-20020a05600c4c1100b0039771fbffcasm779715wmp.21.2022.05.30.19.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:47:00 -0700 (PDT)
Date:   Tue, 31 May 2022 04:46:58 +0200
From:   Olivier dautricourt <olivierdautricourt@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sr@denx.de, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] dmaengine: altera-msgdma: Fix kernel-doc
Message-ID: <YpWBossUokIWkDfz@olivier-3493erg>
References: <20220527074008.8458-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527074008.8458-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 27, 2022 at 03:40:08PM +0800, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
> 
> drivers/dma/altera-msgdma.c:927: warning: expecting prototype for
> msgdma_dma_remove(). Prototype was for msgdma_remove() instead.
> 
> drivers/dma/altera-msgdma.c:758: warning: expecting prototype for
> msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Make the commit message more clearer,replace msgdma_remove()
> with msgdma_dma_remove() in doc.

Acked-by: Olivier Dautricourt <olivierdautricourt@gmail.com>

Thanks !
> 
>  drivers/dma/altera-msgdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 6f56dfd375e3..4153c2edb049 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -749,7 +749,7 @@ static irqreturn_t msgdma_irq_handler(int irq, void *data)
>  }
>  
>  /**
> - * msgdma_chan_remove - Channel remove function
> + * msgdma_dev_remove() - Device remove function
>   * @mdev: Pointer to the Altera mSGDMA device structure
>   */
>  static void msgdma_dev_remove(struct msgdma_device *mdev)
> @@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
>  }
>  
>  /**
> - * msgdma_dma_remove - Driver remove function
> + * msgdma_remove() - Driver remove function
>   * @pdev: Pointer to the platform_device structure
>   *
>   * Return: Always '0'
> -- 
> 2.20.1.7.g153144c
> 
