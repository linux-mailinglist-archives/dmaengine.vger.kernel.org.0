Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB66CD7A1
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjC2K1e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2K1d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 06:27:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE3125;
        Wed, 29 Mar 2023 03:27:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so5799772wmq.3;
        Wed, 29 Mar 2023 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680085651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bf3058/knQ0tFWmfPZfCyE9CWSx0vTUnHs2fjB/KymA=;
        b=SRm5l+xoouFUwc/HhzgIa6DAkMoKhJcUyDR0D0R3x+zdtiAfng1p+AO/dWn/e+9vNw
         /SaomAk8+yu+hwqM9AtZcEUf3H/w5Yqdj9XpyMUaQUu1DRoyjHQQDjFKpVVpDl90qCCN
         5ghgcfI3oZoA2jfuNt//uMd61CTsm5EysUWqBrBcf46l0/m+K0/oK1Nz5e3f/iJXIx3q
         Q+BWHcfkwqqrkqg/ukt9w0nCypdxVl6uCRqaoxuzKhMHM3EuW0+oYntXLCnfEAKIgRN1
         D5Xboz3IxJrtsVEaPVAl9H2I1J2j0LuWJEoFdwLKTv/pd5b5+4r6bEOVFZOFhHbunKhT
         ahgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680085651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf3058/knQ0tFWmfPZfCyE9CWSx0vTUnHs2fjB/KymA=;
        b=b0f84KKgb3kqc5fpzCAMlTLaeIMW5ymsH4chc7DIB2iqDkAs4/0wwA92sgXYK04lts
         t841IHQ4wlnUFZovZ9zYgKnzbGbsmvieTGkoIx+9dRZbGHJyQmZW+5aJjU8Uj0pjdy1F
         d+2QdX+HUAJu6ICfVqTr4SG1JA7r3RTPW7vMPnY26yxCsUQ4FQaati2Aw9FovoPvvIRm
         fg9wq2s4E1sbvnP/C5ttgzzP5Nsb9zy1X2H0E3tNAJN8xfV9Z+T/qvk9+pkhO9v/xL9S
         db6NlKNZ/V9VdhFvsbmteH+LKt5zMYVxiafl2sTnyamB7j+iA5ji/FPHQTqiPXqvJORz
         /lmA==
X-Gm-Message-State: AAQBX9fswi/FgR7ev6pLDMPGV7aiHMN6XLvpQUbN+v3IxAzXX26LLSLl
        AjknBEb+XlAEilbzvzNqRKQ=
X-Google-Smtp-Source: AKy350aGhZYrMYVU5tSUM4mkZxfaDXPRFSfr27ptUeJw0v34q88f53TVJeg9baQ9z6YwvA49wTCBiw==
X-Received: by 2002:a05:600c:28d:b0:3ed:3268:5f35 with SMTP id 13-20020a05600c028d00b003ed32685f35mr1426339wmk.18.1680085650933;
        Wed, 29 Mar 2023 03:27:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003ee8ab8d6cfsm1886094wmn.21.2023.03.29.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 03:27:30 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:27:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mv_xor_v2: Fix an error code.
Message-ID: <16cfc681-7a08-4160-bd69-4c8b59774688@kili.mountain>
References: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Mar 26, 2023 at 09:06:37AM +0200, Christophe JAILLET wrote:
> If the probe is deferred, -EPROBE_DEFER should be returned, not
> +EPROBE_DEFER.
> 
> Fixes: 3cd2c313f1d6 ("dmaengine: mv_xor_v2: Fix clock resource by adding a register clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/mv_xor_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index 89790beba305..0991b8265829 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -752,7 +752,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
>  
>  	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
> -		ret = EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
>  		goto disable_reg_clk;

Heh.  Looking through the Smatch results, I don't think this actually
affects runtime because driver_probe_device() checks for both positive
and negatives.  People shouldn't be returning positives, of course, but
it appears there is a work around for bugs built in already.

regards,
dan carpenter

