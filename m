Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23348780356
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 03:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbjHRB2K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357150AbjHRB2J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 21:28:09 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506AE3C2F
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 18:27:38 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id WmuKqo7iXez0CWoEPqAuP0; Fri, 18 Aug 2023 01:24:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WoEcq6UADqpuuWoEdqvEOS; Fri, 18 Aug 2023 01:25:07 +0000
X-Authority-Analysis: v=2.4 cv=XOgj9CtE c=1 sm=1 tr=0 ts=64dec873
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=phlkwaE_AAAA:8
 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=-bvcuBnrpKmIfEhu9ToA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=uKTQOUHymn4LaG7oTSIC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f7nwE/qFZmVusLxJv+zoA/66vZW2NKiHaJWx4yhC0cI=; b=r/Wwa+KHDaHY8bcPNx4aFUQCFt
        RYaJEsoP3Pmk9Eb9/3iwlUGKrZ5FKHCX9QX11bl8DgIpseEh4WH6xGh4GW3UfezUe/v8VgjKGCz8e
        k06oSbj1xGoOgACMCmLcyLJHM+8AXI/z6otTqA661jPfjCiinzi4mFUgvLBzUxscCFS80GSgmEIW1
        hmRCIMgr24h+WOJnLwPOG5feE4dHRc0pxMHTWUSBbDmkdFgTrpjYd9YD753SxvOALk8P8h2hIgtMt
        G4OrHF8nLaEx5rU54CFQdgcHXAjgkmQau/rjBjgv93vQF1RAUk0GaGgXQJ1C7Sm4FKVu0o5N28xh7
        GaCSs5vw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:52924 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWoEa-000Y5s-00;
        Thu, 17 Aug 2023 20:25:04 -0500
Message-ID: <1f6873bb-e6d3-fdff-5e20-72332469def2@embeddedor.com>
Date:   Thu, 17 Aug 2023 19:26:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/21] dmaengine: stm32-mdma: Annotate struct
 stm32_mdma_device with __counted_by
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
 <20230817235859.49846-14-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-14-keescook@chromium.org>
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
X-Exim-ID: 1qWoEa-000Y5s-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:52924
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 500
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCjVYdG8E00AAe2AHjuOQxDAvR25a/GT9OCocfbklwqxvK6soTB50kVqmfJPlGzqlIW/kFq8WCRWn4ZvosiGGxvjKJGTjCRkA94oOmWHnu4NvFvekQNJ
 03uibW7FFHmeQC9kX1AhotQuFB8htz0TPT5fdi+7uDK+3zT6bwgWBUksfKEg+DOI5TXAZBN7KsV5b8W3MAY+Pq8L5OhqvlHJmwQ=
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
> As found with Coccinelle[1], add __counted_by for struct stm32_mdma_device.
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
>   drivers/dma/stm32-mdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 926d6ecf1274..0c7d2295856e 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -256,7 +256,7 @@ struct stm32_mdma_device {
>   	u32 nr_ahb_addr_masks;
>   	u32 chan_reserved;
>   	struct stm32_mdma_chan chan[STM32_MDMA_MAX_CHANNELS];
> -	u32 ahb_addr_masks[];
> +	u32 ahb_addr_masks[] __counted_by(nr_ahb_addr_masks);
>   };
>   
>   static struct stm32_mdma_device *stm32_mdma_get_dev(
> @@ -1611,13 +1611,13 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>   			      GFP_KERNEL);
>   	if (!dmadev)
>   		return -ENOMEM;
> +	dmadev->nr_ahb_addr_masks = count;
>   
>   	dmadev->nr_channels = nr_channels;
>   	dmadev->nr_requests = nr_requests;
>   	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>   				       dmadev->ahb_addr_masks,
>   				       count);
> -	dmadev->nr_ahb_addr_masks = count;
>   
>   	dmadev->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(dmadev->base))
