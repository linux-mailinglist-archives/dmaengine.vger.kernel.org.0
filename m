Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74462780346
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357045AbjHRB0E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357121AbjHRBZw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 21:25:52 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCB3C27
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 18:25:23 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id We1Vqku9Hez0CWoDnqAtZO; Fri, 18 Aug 2023 01:24:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WoE0qqI2oh9i0WoE1qQgRM; Fri, 18 Aug 2023 01:24:29 +0000
X-Authority-Analysis: v=2.4 cv=ZMPEJF3b c=1 sm=1 tr=0 ts=64dec84d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=phlkwaE_AAAA:8
 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=PQxDlO0rh1wi_DnxKH8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=uKTQOUHymn4LaG7oTSIC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EwBdW62PPBMZVf78eVBfrCIfGvyXuF9Ofx4kjw6wwVU=; b=PINaxgXl8Chxqc5houvaG4bVzG
        KziTmKnq9L+37ydcZjmi5Az2P4nZyitbdg9RGfEoK8IwCtRVXPIqgL7AuCMPnevwzdnfu8rfp0Kjx
        UFOllsZDWvTfaa8AlsylGuKEdMMpFOJ5/01nXxZWTTr7hYqIM+Dz5jgGrkuCfmgEn9Kafr1xkwe8K
        F9v2e4iKqRl1v0Z5AhLucqAev4X7YlwK+ju2EhtgfZdyMFg73VaOGEwKn3vslu+/gZws2AOEuMZCH
        hpgY+ywIBBXq4XGyRIzjT+7NHCZWaeGKBZRFCt8THw/ZoOXDtOK2rGheOvfKhW5jLWroXKWhTjhHC
        oCAH982w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55258 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWoDy-000XHo-0J;
        Thu, 17 Aug 2023 20:24:26 -0500
Message-ID: <be53a6d3-9cac-0bc2-c659-68bea6034073@embeddedor.com>
Date:   Thu, 17 Aug 2023 19:25:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/21] dmaengine: stm32-dma: Annotate struct
 stm32_dma_desc with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817235428.never.111-kees@kernel.org>
 <20230817235859.49846-12-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-12-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWoDy-000XHo-0J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55258
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 416
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBH+SiSjEhFfVVwJWMk5WSRuwwdZYvTDLfE2m1iJasLQSZid6IxDUqRQEQVofAyWt1jbhRdAsmeL9JG501fKUtgOmo9h6erbmO8seEqzzLNzxPR3fGo8
 PIVChhlV5wn9VWUbkSmzMyX2TxeC3NVjdbtO8lpJj1rzPZ+wQq0SVL/t6C7d4ZI4pP+0eBaZtUSltQFDiJE5blO7bgNB9UsHAUg=
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/17/23 17:58, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct stm32_dma_desc.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/stm32-dma.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 5c36811aa134..a732b3807b11 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -191,7 +191,7 @@ struct stm32_dma_desc {
>   	struct virt_dma_desc vdesc;
>   	bool cyclic;
>   	u32 num_sgs;
> -	struct stm32_dma_sg_req sg_req[];
> +	struct stm32_dma_sg_req sg_req[] __counted_by(num_sgs);
>   };
>   
>   /**
> @@ -1105,6 +1105,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
>   	desc = kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
>   	if (!desc)
>   		return NULL;
> +	desc->num_sgs = sg_len;
>   
>   	/* Set peripheral flow controller */
>   	if (chan->dma_sconfig.device_fc)
> @@ -1141,8 +1142,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
>   			desc->sg_req[i].chan_reg.dma_sm1ar += sg_dma_len(sg);
>   		desc->sg_req[i].chan_reg.dma_sndtr = nb_data_items;
>   	}
> -
> -	desc->num_sgs = sg_len;
>   	desc->cyclic = false;
>   
>   	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> @@ -1216,6 +1215,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
>   	desc = kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWAIT);
>   	if (!desc)
>   		return NULL;
> +	desc->num_sgs = num_periods;
>   
>   	for (i = 0; i < num_periods; i++) {
>   		desc->sg_req[i].len = period_len;
> @@ -1232,8 +1232,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
>   		if (!chan->trig_mdma)
>   			buf_addr += period_len;
>   	}
> -
> -	desc->num_sgs = num_periods;
>   	desc->cyclic = true;
>   
>   	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> @@ -1254,6 +1252,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
>   	desc = kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT);
>   	if (!desc)
>   		return NULL;
> +	desc->num_sgs = num_sgs;
>   
>   	threshold = chan->threshold;
>   
> @@ -1283,8 +1282,6 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
>   		desc->sg_req[i].chan_reg.dma_sndtr = xfer_count;
>   		desc->sg_req[i].len = xfer_count;
>   	}
> -
> -	desc->num_sgs = num_sgs;
>   	desc->cyclic = false;
>   
>   	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
