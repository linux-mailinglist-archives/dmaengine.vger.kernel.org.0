Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F64BD133
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiBTULg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 15:11:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiBTULg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 15:11:36 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E74C425;
        Sun, 20 Feb 2022 12:11:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bn33so11779302ljb.6;
        Sun, 20 Feb 2022 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=SFq6sQc+iZKiiOta9mApqHGHWEVz2KerGFldHdpEI6o=;
        b=fN038eN4MrR+vuieb+Y1FEexP3q89yhDkrsFtN12a5uGug6bGOfOaV1V5NammF5/+3
         WbmbRp78wjefUNyg30SUIC0181u13mNzWEOzhAsBKvdrsfRKvWrbRNyNFGuqWPTu1lHN
         3VKorRLxmey6/fdQoYowIJ33oTdbqdXxvuzGBrQ75vCD5smqPRdAVj6o+BCScodp7V+z
         xACk2UYfjBXy3lgFnxEo1hZE0j/q/IfOiiRU91lofsBn/4rxVcLnfLaHXCfyZj9TLQdI
         P+uNblKB3xapKT/36q3a/1/57WrT60Ol28a89WaAqIOD90GQSu8zOR6X75ND6CdOIrzX
         N8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=SFq6sQc+iZKiiOta9mApqHGHWEVz2KerGFldHdpEI6o=;
        b=Pb3DejUnp9qtAY+WcY6j27YlXLOZF9dJJqZY5/9/Yv6MdMAZtf6FnqTo8dpKSIOpHc
         fejrnaqZBhjAPSpykRIpfZsUssA2j98xCET0R/yd6Vk3oZtDl2bqkjgedgTzeh4iz7gj
         7f3idVPdERKBp+4FrOT1APbvBoVd/k6Ldt0eaYeyiQWrmyqfOqDd21n26I+b7tZK1XMK
         ZRWvM/ERVrosbQ7u77mkTXJ0ORG2ocLMQgfgW6RhbDKNoOMTuSh08tGABwsz2ZcEFNpT
         bGKFJGHgmxHSRHkT/mweRRCM7p5uYgSmrEk08p/Hj0/XczKFwcsK7eYioGXlixmQdYf+
         oLJQ==
X-Gm-Message-State: AOAM532meIpZJYgwNKuG+oiOo81Xxjl4DZnbh0tSN7QoYSFTlO9NoGKU
        X/qjRWZtA1vdktvAlsZD4H4=
X-Google-Smtp-Source: ABdhPJyDbNP3CPD5oGdylk/QWbLZnR9foVWRyD8apAH6z7gychYoWJbyz+uwgpdMjfaNmltSrwNg9A==
X-Received: by 2002:a2e:98cd:0:b0:244:d3b5:4d70 with SMTP id s13-20020a2e98cd000000b00244d3b54d70mr11953447ljj.399.1645387872693;
        Sun, 20 Feb 2022 12:11:12 -0800 (PST)
Received: from [10.0.0.127] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id q4sm904278lfn.196.2022.02.20.12.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:11:12 -0800 (PST)
Message-ID: <58fe0934-4853-714c-600d-9a2d86df5bc8@gmail.com>
Date:   Sun, 20 Feb 2022 22:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20220215044112.161634-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Avoid false error msg on chan
 teardown
In-Reply-To: <20220215044112.161634-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 15/02/2022 06:41, Vignesh Raghavendra wrote:
> In cyclic mode, there is no additional descriptor pushed to collect
> outstanding data on channel teardown. Therefore no need to wait for this
> descriptor to come back.
> 
> Without this terminating aplay cmd outputs false error msg like:
> [  116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!

are you sure it is aplay? It is MEM_TO_DEV, we only use the flush
descriptor for DEV_TO_MEM. MEM_TO_DEV can 'disconnect' from the
peripheral to flush out the FIFO.

I have not seen this on am654, j721e. I can not recall seeing this on
the capture side either.

The cyclic TR should be able to drain the DEV_TO_MEM by itself and the
TR should terminate.


> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 9abb08d353ca0..c9a1b2f312603 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3924,7 +3924,7 @@ static void udma_synchronize(struct dma_chan *chan)
>  
>  	vchan_synchronize(&uc->vc);
>  
> -	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
> +	if (uc->state == UDMA_CHAN_IS_TERMINATING && !uc->cyclic) {
>  		timeout = wait_for_completion_timeout(&uc->teardown_completed,
>  						      timeout);
>  		if (!timeout) {

-- 
Péter
