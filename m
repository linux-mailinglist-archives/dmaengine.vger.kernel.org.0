Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD673487E
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjFRVHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFRVHQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 17:07:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0D13D;
        Sun, 18 Jun 2023 14:07:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b46cad2fd9so15064981fa.1;
        Sun, 18 Jun 2023 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687122433; x=1689714433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TqjS9xJiLXvGhtETibdkReKGSufvIsySemZKUY7eKpU=;
        b=j40BNJq8D1xkLZpHX5JaopHHxGS41OFjcjqtcpcTomTqHBOemhotkScgpIvwFl5Cta
         CyKEl14f1kUM9wCvOohmi8jtQSbOcvtOPnDuNTTKtNg8s2v6GLGQYF8paFdzP/lsbKSS
         DC3vJEO2xDmXer/aPAdpemNk8uEh82pDtmtZ+KvwjmS/PlzNK099LeUy8iAJv0OawSg1
         rY3Zpr9uEXGeQWBxN8H5qqAUugBOSH8y+kjT5gmqmN1OAWhMFkECBEr8Ea871T0NVgC+
         CxGEHmqhI8bMiB4mcCzxLR5UKA7FFMh9kZBJlEq4P+0agCGy6dR1IjC/6DwU7VUHawMX
         ai0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122433; x=1689714433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqjS9xJiLXvGhtETibdkReKGSufvIsySemZKUY7eKpU=;
        b=Ez6ZEPbwVyOuApr8I5I5A5fZ8n3NYl6rSNPUFxlaRDL/N3/LYwsf48E3DzE9tP/T33
         p4F4CNIDFF15jTS61kv3SXoyg+vqlLznysHH2HgpbHwnEB1isZBdarn9G0KHwCgIi/2+
         9xZpCK4xwxRkdYUYRwsPQxN2UangJHq9t2GTj7lIQ8b9096Dpr+0YCmErXKkTQT0x1pI
         Mg/7aSHlWm96dtW3lR8xJ5h00gNVA4ptOhKZ6EliqEbq5i3V/PyFO+Vgy3m2Aeis/Tun
         M9RvmRY8d1JKcjp3xTpkasq0mEXTm9GnKive6RpLx/pJ17BXTryPKf9Tt4iUAPk/1Gt1
         /CHA==
X-Gm-Message-State: AC+VfDxLjsCRvO/sAG4Ku7BXvVIwqSvUY9BY1BsPO1fBwntVXo51Mp7B
        CgW8LnHGGCO1/65er2pEAG0=
X-Google-Smtp-Source: ACHHUZ6ln1SHB8fx6xmv6nRSuZrynQvuQXMyMI2ZagefhDwJhpXP2IaPT/BHIkW/4MfGXCWrj6AOPg==
X-Received: by 2002:a2e:b70d:0:b0:2b4:3faf:c3d3 with SMTP id j13-20020a2eb70d000000b002b43fafc3d3mr4873823ljo.31.1687122432918;
        Sun, 18 Jun 2023 14:07:12 -0700 (PDT)
Received: from mobilestation ([91.193.179.15])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e950f000000b002b1ac2bcf99sm4841368ljh.120.2023.06.18.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 14:07:12 -0700 (PDT)
Date:   Mon, 19 Jun 2023 00:07:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/9] dmaengine: dw-edma: Fix the ch_count hdma callback
Message-ID: <20230618210709.rkdjlehyhc7lngam@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609081654.330857-2-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 09, 2023 at 10:16:46AM +0200, Köry Maincent wrote:
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
> 
> This patch is fixing a commit which is only in dmaengine tree and not
> merged mainline.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 00b735a0202a..de87ce6b8585 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -65,18 +65,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
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
> +	return HDMA_V0_MAX_NR_CH;

Mainly I am ok with this change. But it would be nice to have a
comment inlined here of why the number of channels is fixed and that
the platform is responsible for specifying the real number of channels
(it's basically what you described in the patch log).

Cai, what do you think about the patch? Is it suitable for you? Do you
have any idea of how to workaround the denoted problem without always
returning the maximum number of channels?

-Serge(y)

>  }
>  
>  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> -- 
> 2.25.1
> 
