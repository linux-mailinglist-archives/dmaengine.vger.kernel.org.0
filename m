Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133A70614A
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 09:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjEQHgO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEQHff (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 03:35:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCAB4688
        for <dmaengine@vger.kernel.org>; Wed, 17 May 2023 00:35:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so4041195e9.3
        for <dmaengine@vger.kernel.org>; Wed, 17 May 2023 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684308923; x=1686900923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dK1qv6PTlG33tVF6LejuDZcQpm3iw6AWanbA02wz/VY=;
        b=anc8ybdUeP1Ognop/ssH+1oWNTJ81X6LjRzXon+WVPLcekwvWPZLnN4EZV8NDt/KsS
         7KfKVNz63fFTPvMjSlpuNWE0cv+ux7J8BfCQ3WBkQ9gSTUFTgb3U7DoVfZyIGwPUhBQL
         kKbKYJdvfVzugcSOI8u1TcU5degGe6kUUqLuDrvAM34/X0Jhmhhn/mYHBLHGbRWtqgEK
         0B6NMDM0RsVwBxelEgXzWh3pjje+7LBiC/4AnU+Xxij0fnLbKQ8kKOeWYM5/fOzw65dg
         KQoiYvgKLjUy8KcnfqYF6ge7NyxS1Qsdc/G9RHg//3ZIflaMY6tjorniSs8UiXKifsKn
         y0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308923; x=1686900923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dK1qv6PTlG33tVF6LejuDZcQpm3iw6AWanbA02wz/VY=;
        b=bwL8TKJyWFwRXEu6hnjj58yxdNhUhchArnlWmIAMQbsK8sAAPc2/yYm/gkq20WVRS9
         XapegjYvKVzgDnYtM9L5aRZ0MzY+a1SKwwQIP3oOdQO7FeCHdXPKBk4RwcuAOMLzUB89
         2B43EipGpPe/D7pmEBpsMo8fCnjswNwO+phn1P/hWqpetzD1QeufRLqZrLckcdW7O07f
         9FfmQHdrkyoZVpNqHmwbKBrpu849sPyuc0ZJ2i8mD9PvyEIgxrVT1DJoyj9Jacb0tCv+
         R2Xrqms8/9JayWYLl+cwIuqi6/PIpFnXD1nDgsOe5Keym3S7+sWYnBAo5DbtlOI3IIlu
         D/RA==
X-Gm-Message-State: AC+VfDy840L5T/4FAYTeyP9yuwlIAmKQaFy0/keCxV6Ws8lulMF3qhf6
        hhJDGqQdkcsWfWVPe0gqhdNpTQjybamI01ZJHf4=
X-Google-Smtp-Source: ACHHUZ6H+L6QE/vULJkNVhapgIYEXj5BemZlb73fN5cX5dGG11keKU97ilhFMZCYOfACEaxTAjRKRQ==
X-Received: by 2002:a1c:f202:0:b0:3f2:5be3:cd6a with SMTP id s2-20020a1cf202000000b003f25be3cd6amr32890504wmc.4.1684308923113;
        Wed, 17 May 2023 00:35:23 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003f1957ace1fsm1269737wmk.13.2023.05.17.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:35:22 -0700 (PDT)
Message-ID: <ac65ea9c-12a9-a5d0-5023-8935d780cdf2@linaro.org>
Date:   Wed, 17 May 2023 08:35:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dmaengine: at_xdmac: fix potential Oops in
 at_xdmac_prep_interleaved()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/15/23 11:32, Dan Carpenter wrote:
> There are two place if the at_xdmac_interleaved_queue_desc() fails which
> could lead to a NULL dereference where "first" is NULL and we call
> list_add_tail(&first->desc_node, ...).  In the first caller, the return
> is not checked so add a check for that.  In the next caller, the return
> is checked but if it fails on the first iteration through the loop then
> it will lead to a NULL pointer dereference.
> 
> Fixes: 4e5385784e69 ("dmaengine: at_xdmac: handle numf > 1")
> Fixes: 62b5cb757f1d ("dmaengine: at_xdmac: fix memory leak in interleaved mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/dma/at_xdmac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 7da6d9b6098e..c3b37168b21f 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1102,6 +1102,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
>  							NULL,
>  							src_addr, dst_addr,
>  							xt, xt->sgl);
> +		if (!first)
> +			return NULL;
>  
>  		/* Length of the block is (BLEN+1) microblocks. */
>  		for (i = 0; i < xt->numf - 1; i++)
> @@ -1132,8 +1134,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
>  							       src_addr, dst_addr,
>  							       xt, chunk);
>  			if (!desc) {
> -				list_splice_tail_init(&first->descs_list,
> -						      &atchan->free_descs_list);
> +				if (first)
> +					list_splice_tail_init(&first->descs_list,
> +							      &atchan->free_descs_list);
>  				return NULL;
>  			}
>  
