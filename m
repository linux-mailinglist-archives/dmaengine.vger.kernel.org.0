Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F380648D8D
	for <lists+dmaengine@lfdr.de>; Sat, 10 Dec 2022 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJIO1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Dec 2022 03:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJIO0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Dec 2022 03:14:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A012A409;
        Sat, 10 Dec 2022 00:14:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so10538897lfv.5;
        Sat, 10 Dec 2022 00:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmClvcZtLY6vVe4LXZcv5HXQNt4GbFAtq6k3JgK+1qU=;
        b=kQxIQHBQw4fnRaviMhpZiiSfwh6EDRBTDWs3xVUgyIHMWnb6Qs4EJ5RpEqoY5L4N+d
         Y3/ZUQLyKd+NFv5FbGsLNOUR3Kk8F7Ra5NBIdojjnthFdZBE6jPjtFhmbX/d800v574w
         Vv2U5bfxhVdm9x4XbQ+j6bZdWJerE8WqWngqvJuJCpH0QowZQNYOyao6p1MZRLmpDtva
         /+9ZRPeLmwRy6y28WljYl4+nAFKIRuMgNHIcabb45oQZgeGXKYIITAz4hdmpOO3xtej/
         BnM6ZHiS0V2IyMuSSIwaG1vR2FJTVFoZmFDQy5Znz+D+rmo1pc1FYi2NNfgRd0w4n5kK
         cTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmClvcZtLY6vVe4LXZcv5HXQNt4GbFAtq6k3JgK+1qU=;
        b=EGGWt4hJ1tKaJOWREm3Oi/Q2sYQErXloNKZHvXa6zCkZFFsZkQN5lHYNPkv6XPR7Vq
         bOoHCNqKND+XRE58jGRFVjIT9MOuyBZ2q6IArKloRtihYU4bEoXMCTdCizXVNjhUghTw
         Ar+xKJn7B5L0Xh3JAtjE4Qm0iw5oKnHidYvYth0aqw29f0qeLknrMuB0z7RvvE0RYxUp
         nbZvqkBxK0ETi237qtRHL2ZAdCYh6c8rln09w9gLvq2ztFby0HWjMtlVJm+lk34PkDg2
         03xvIdnRcN3QOOShCv0O2rXkhGNSAX7jYFblOXhBP2Ny5dUV6LfkiPC+qDwvPjxTlrVe
         9SnQ==
X-Gm-Message-State: ANoB5pnlzUaZJaTjNCXRZ6jQQfgabg2jq7iL6VRcLd8camGeBinGMouo
        uq9LmHNRbHfmXC5eOklc+uQgl+B9XU0qUA==
X-Google-Smtp-Source: AA0mqf665jfrVmswfHcYG4WMvaG6DDty77ndjL4bEkIm8gmUBQMtPi6wknRRfgxFReV4IIMU39BP6A==
X-Received: by 2002:a19:ad49:0:b0:4b5:c489:8cf8 with SMTP id s9-20020a19ad49000000b004b5c4898cf8mr213770lfd.61.1670660062593;
        Sat, 10 Dec 2022 00:14:22 -0800 (PST)
Received: from [10.0.0.42] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id o12-20020ac2494c000000b004a6f66eed7fsm625959lfi.165.2022.12.10.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 00:14:22 -0800 (PST)
Message-ID: <c56e89a3-3a35-8a5a-8f39-a4e82b19a092@gmail.com>
Date:   Sat, 10 Dec 2022 10:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/5] dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-3-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20221206043554.1521522-3-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 12/6/22 06:35, Vignesh Raghavendra wrote:
> Reusing loop iterator fails if BCHAN is not present as iterator is
> uninitialized
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..791cf6354946 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4758,6 +4758,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  		}
>  	}
>  
> +	i = 0;

I think this would be more appropriate:
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..7f8737da3613 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4774,6 +4774,8 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i].num = rm_res->desc[i].num;
 			}
 		}
+	} else {
+		i = 0;
 	}
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];


>  	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
>  	if (!irq_res.desc)
>  		return -ENOMEM;


-- 
Péter
