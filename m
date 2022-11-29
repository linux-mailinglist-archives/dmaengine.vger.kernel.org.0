Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302463C51C
	for <lists+dmaengine@lfdr.de>; Tue, 29 Nov 2022 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiK2Q1U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Nov 2022 11:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiK2Q1R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Nov 2022 11:27:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8047C4C248;
        Tue, 29 Nov 2022 08:27:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so22819917lfe.12;
        Tue, 29 Nov 2022 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDMkrZFWLrSp+7LLIWWLkTwrJI1naRVEumr5IczeOuM=;
        b=i/cWlAZEJsfRbb0Yosxun7toROgA/8k+rvCjdsiNrtyTCORTp4zP28z1iky4zZNfAT
         EWlvl7LjYIPLa9Er/dTxYsN7eUuJC6dm1nWbqoOdqmHSkAFXTylR6+aeyN3ONrZDQuhQ
         xIQf/iDvX+Lr6zuD2lftJWT40lDFj640ymKtQr4xAxzkuiKahYQOeqJboBSrLUksyWli
         h29dlgqJLEVZ5wpLwvJLAAyIBIn9OXP09kfzVzA4+JwymiPdDxSly4Gi0bcqaEqW4mZ+
         UH/zEYXt+Efnw/ukH80sLiKYXQg3HExIzq4uR8pE3PNsuuGPoJFsF/24Qv9DxEH66LVM
         5U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDMkrZFWLrSp+7LLIWWLkTwrJI1naRVEumr5IczeOuM=;
        b=grXiCsXerOjzWt0AJR+rVswNOv6avw3wMCDpw3sJuJME7iU26EBj1FKUtdNGlQw4q4
         aS/mGSQkqH4S10qdUBnk9XnMwwIH66SJvbQ/79OcfJ8MauiV88u7a/TrEZNU5R0LhPWX
         hi9uxjIX5/sDV+FSNr7C6s9hv+Nd631mmxhs5geMAQlAUJiaoKQYj5MYlYm8S8zLyYw/
         WTv41BjuiOgHMgsjeuNrQa4C/mA5VMaU7MQ6yBejAhSy6WgMW5SBkyjYFtIMeNfDJsC8
         ZqoMclAwP5S2LY+/+v20wsHrUElvvhWLoK6u+1zHCHp4P/NW+bkfoq3whrzjln8Z/bM5
         5BOw==
X-Gm-Message-State: ANoB5pkNbGTkk6WHSz5PKytil8WGviLVAX6LG+QgCJLV/aNQIFZv+nX0
        hBAXCMRo6N5GWzO6y//7OZC29HWhAY0Mjw==
X-Google-Smtp-Source: AA0mqf7n3rrKTo9grpzjUGyShBKFJXfD5LfP9vp77wPi/sSmEcuZHOrJ5KxI65xDEtUsDItXwUFo9Q==
X-Received: by 2002:a05:6512:1042:b0:4a2:46f6:6cee with SMTP id c2-20020a056512104200b004a246f66ceemr15622282lfb.642.1669739234439;
        Tue, 29 Nov 2022 08:27:14 -0800 (PST)
Received: from ?IPV6:2001:999:230:8bc4:e9e4:a37:1c80:5708? ([2001:999:230:8bc4:e9e4:a37:1c80:5708])
        by smtp.gmail.com with ESMTPSA id o16-20020a056512053000b004b1756a0ae9sm2263986lfc.55.2022.11.29.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:27:14 -0800 (PST)
Message-ID: <f954e71b-043c-43bc-a692-530497de2d0b@gmail.com>
Date:   Tue, 29 Nov 2022 18:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dmaengine: ti: k3-udma: drop loglevel for non-fatal probe
 deferral log
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221128101334.512816-1-j-choudhary@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221128101334.512816-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/11/2022 12:13, Jayesh Choudhary wrote:
> Change the log level from dev_err() to dev_dbg() for non-fatal probe
> deferral log for getting MSI domain.
> This makes the kernel log clean and we do not get recurring logs
> stating: "Failed to get MSI domain".

Or not print at all?

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..e540166cf4c7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5344,7 +5344,7 @@ static int udma_probe(struct platform_device *pdev)
>   	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
>   					    DOMAIN_BUS_TI_SCI_INTA_MSI);
>   	if (!dev->msi.domain) {
> -		dev_err(dev, "Failed to get MSI domain\n");
> +		dev_dbg(dev, "Failed to get MSI domain\n");
>   		return -EPROBE_DEFER;
>   	}
>   

-- 
Péter
