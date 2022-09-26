Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83205EB03E
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIZSlX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiIZSkz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:40:55 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D013E98;
        Mon, 26 Sep 2022 11:40:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a8so12235335lff.13;
        Mon, 26 Sep 2022 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xyd1P2Y/O/spmGPFk/6/hvZ481hc6+ye5XlH0OFS+A0=;
        b=n437n9Xxc2dOgEc+SHZBWoJcxjWq8Nt2BN164pCPBbz45ivj48P370Fuc9g9O96LPG
         7eF+73Kx2cQQdspxOLdkp7cZY4RE863F24Y/3eMNC1FKNH6w2jDbrJHQoKKU/slWjUbJ
         CfCs7vEYEmfJiJzEmsKbt4cFw4EshJaelto3VLWIQ5xbc+jK03LSXc7L0H7ynX7XEgXq
         briqexEKAofM2meKRSX6HRm9TLJ6j8bqc0klwDoExRP9QVlqlk4s6wonGWsgXkix5r61
         9RH9MfxkVAqArGbPbkFppnsACxsxRu51YFHKPd7CgyK+y69TJq2nVBdxwL1sXxKLSemt
         uSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xyd1P2Y/O/spmGPFk/6/hvZ481hc6+ye5XlH0OFS+A0=;
        b=H9bknt72jwgMqr4LXfxDcnyfdGMj2Ea3zVRM6tB9vEiYksOvChNUwlUjGwJa5++NVF
         l8qyG7F1X7ppMqXukbzsQBHTgl0FMPPK6udSQlyNhR+IIQ26Pa9+9Au9dof530few8g+
         MCfqMJ6NEl2951CtTYDRzADXqGHejMLD0DDfez7PJ5O2NJbRlP7h09vAt0W9zLtYZ1Ou
         D7fGKR/mucbp72Yy1WFXTkWOvhwokh/ppcewrwtmEKevOCTZkWLd9mZCGd2mUQHRcqzm
         Fd8n7hRDr3MS2H7HFfajVxKyH++si2V+jNzBXILNEjGlrU8FdAL10R+E55nSB0iH1uSm
         8oyg==
X-Gm-Message-State: ACrzQf2/XAYXtqiP2Kw379gfYnsJP2r4MEhABdRCkmO6axbi0UtNYXde
        W+0JAw1DwGyojaoM+BPo9GQqUpzJmk+rnQ==
X-Google-Smtp-Source: AMsMyM68kCA8J1dzIw9AYvuVUGVseGvlnZY8Ufk8vSRTzfLHTvxxfY7G7o/1lrjdwMscQlRtAmENfw==
X-Received: by 2002:a19:f80d:0:b0:49b:29a8:db54 with SMTP id a13-20020a19f80d000000b0049b29a8db54mr9160889lff.178.1664217546591;
        Mon, 26 Sep 2022 11:39:06 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id o8-20020a056512050800b004a05767bc07sm1333895lfb.28.2022.09.26.11.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 11:39:06 -0700 (PDT)
Message-ID: <4c9f0284-f8d0-75e5-8bc9-944b040f9edb@gmail.com>
Date:   Mon, 26 Sep 2022 21:47:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/3] dma/ti: convert PSIL to be buildable as module
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-4-khilman@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220926181848.2917639-4-khilman@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On 9/26/22 21:18, Kevin Hilman wrote:
> map symbols need EXPORT_SYMBOL and files need MODULE_LICENSE.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/dma/ti/Kconfig          | 3 ++-
>  drivers/dma/ti/k3-psil-am62.c   | 4 ++++
>  drivers/dma/ti/k3-psil-am64.c   | 4 ++++
>  drivers/dma/ti/k3-psil-am654.c  | 4 ++++
>  drivers/dma/ti/k3-psil-j7200.c  | 4 ++++
>  drivers/dma/ti/k3-psil-j721e.c  | 4 ++++
>  drivers/dma/ti/k3-psil-j721s2.c | 4 ++++
>  drivers/dma/ti/k3-psil.c        | 2 ++
>  8 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index f196be3b222f..2adc2cca10e9 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
>  	  If unsure, say N.
>  
>  config TI_K3_PSIL
> -	bool
> +       tristate
> +       default TI_K3_UDMA
>  
>  config TI_DMA_CROSSBAR
>  	bool
> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
> index 2b6fd6e37c61..7c4ca85f68b1 100644
> --- a/drivers/dma/ti/k3-psil-am62.c
> +++ b/drivers/dma/ti/k3-psil-am62.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -184,3 +185,6 @@ struct psil_ep_map am62_ep_map = {
>  	.dst = am62_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(am62_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(am62_ep_map);

Wouldn't it be better to build one module (k3-psil.ko) and link all the
platform libs into that?
They are unconditionally built in all cases anyways and makes the lsmod
under control.
And no need to export these maps at all is a plus.

> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil-am64.c b/drivers/dma/ti/k3-psil-am64.c
> index 9fdeaa11a4fc..c579374feef9 100644
> --- a/drivers/dma/ti/k3-psil-am64.c
> +++ b/drivers/dma/ti/k3-psil-am64.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -156,3 +157,6 @@ struct psil_ep_map am64_ep_map = {
>  	.dst = am64_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(am64_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(am64_ep_map);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
> index a896a15908cf..10db638b1178 100644
> --- a/drivers/dma/ti/k3-psil-am654.c
> +++ b/drivers/dma/ti/k3-psil-am654.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -173,3 +174,6 @@ struct psil_ep_map am654_ep_map = {
>  	.dst = am654_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(am654_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(am654_ep_map);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil-j7200.c b/drivers/dma/ti/k3-psil-j7200.c
> index 5ea63ea74822..b7c638a5d140 100644
> --- a/drivers/dma/ti/k3-psil-j7200.c
> +++ b/drivers/dma/ti/k3-psil-j7200.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -173,3 +174,6 @@ struct psil_ep_map j7200_ep_map = {
>  	.dst = j7200_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(j7200_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(j7200_ep_map);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> index 34e3fc565a37..759e4a156acd 100644
> --- a/drivers/dma/ti/k3-psil-j721e.c
> +++ b/drivers/dma/ti/k3-psil-j721e.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -296,3 +297,6 @@ struct psil_ep_map j721e_ep_map = {
>  	.dst = j721e_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(j721e_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(j721e_ep_map);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
> index a488c2250623..fd9e56851e59 100644
> --- a/drivers/dma/ti/k3-psil-j721s2.c
> +++ b/drivers/dma/ti/k3-psil-j721s2.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  
>  #include "k3-psil-priv.h"
>  
> @@ -173,3 +174,6 @@ struct psil_ep_map j721s2_ep_map = {
>  	.dst = j721s2_dst_ep_map,
>  	.dst_count = ARRAY_SIZE(j721s2_dst_ep_map),
>  };
> +EXPORT_SYMBOL_GPL(j721s2_ep_map);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
> index 761a384093d2..8b6533a1eeeb 100644
> --- a/drivers/dma/ti/k3-psil.c
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/mutex.h>
> @@ -101,3 +102,4 @@ int psil_set_new_ep_config(struct device *dev, const char *name,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(psil_set_new_ep_config);
> +MODULE_LICENSE("GPL v2");

-- 
Péter
