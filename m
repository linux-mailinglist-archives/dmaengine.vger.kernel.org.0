Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D137804FA
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 05:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357784AbjHRDzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 23:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357823AbjHRDzl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 23:55:41 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A33A82;
        Thu, 17 Aug 2023 20:55:39 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id WmuKqfi5LEoVsWqaJqJCfD; Fri, 18 Aug 2023 03:55:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WqaIqtay2h9i0WqaIqTvAx; Fri, 18 Aug 2023 03:55:38 +0000
X-Authority-Analysis: v=2.4 cv=ZMPEJF3b c=1 sm=1 tr=0 ts=64deebba
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/CaltAbw9kXoOTkGA4OE5zZGNtQe7YqeZHvxU27zSHI=; b=VFqmbvP9jPcq9FBHlW1rFOuXzs
        4RdFRuq2koYRsFuYDT1gW+hRskGxauToUbJXGS7bg6l1gqxSnac7swgcT2LY1YO88rrKxDk9SrHtK
        YJmfIrT0+m9POf2vT+fntaW8A3jvgxmiAykLEc/XWdXWptNurdcYARUYDdj6kNhZWE4hTBEXGw7A8
        GcJ8yfJTqrVqDr8mQv7ZnZSXEKAHcR2RkXjhqZDp1huw1Ab9cKICWRU4YLFBJmJA/BG2Yvmix4cWZ
        hl7RpAwdNwdXoxnTGnxvW+0O4orZrO7i0zKMuBTpnz5ubwDz4XlWL4uxKZKQbax9TcRP3Wnu/NEaI
        KzssiFFQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:51454 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWp0a-001CPk-2l;
        Thu, 17 Aug 2023 21:14:40 -0500
Message-ID: <a21ec18e-21be-2715-f125-a7ec67c2cb02@embeddedor.com>
Date:   Thu, 17 Aug 2023 20:15:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/21] dmaengine: ti: omap-dma: Annotate struct omap_desc
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817235428.never.111-kees@kernel.org>
 <20230817235859.49846-18-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-18-keescook@chromium.org>
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
X-Exim-ID: 1qWp0a-001CPk-2l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:51454
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfND4vuGCh7HUS1msHzN58c/4pVINLIF4yrrlEuVjwTw3H2ALo2ppZmrw52trF8gP09oGFeEv/14/kv0rKHXBjWpeSM7xr2SCTKDx64uIIZlKeDr2/+W5
 oqVk4HTiTeFx7UjG/cQqoQw+bQxZlKFwIBaXePxeBdFKqN7SziTiuQZn1ASHX7eYVYuAv/ukNuhVa7ZRfMiDnihsOdEIT2aRX0pKuL5YA8v2BUCkgQ/T0Cm6
 GdSFzFe5C3QoB85l3+JbskVFgJbx0IqFpvpxbe/gtYaRhZ6E6hzD6rHtXDUCXtqU3PKkyt4iv90i0XmMxI/+csAfllILaILi0PCh28gaWMF6KNKXu/aJ0ldF
 fm96qJ/i7ZqY1GisyfB96t0kvPmV/LD+N2GkzAkKDDl7YL+81Vw=
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct omap_desc.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/ti/omap-dma.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index cf96cf915c0c..11ac3fc0a52a 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -124,7 +124,7 @@ struct omap_desc {
>   	uint32_t csdp;		/* CSDP value */
>   
>   	unsigned sglen;
> -	struct omap_sg sg[];
> +	struct omap_sg sg[] __counted_by(sglen);
>   };
>   
>   enum {
> @@ -1005,6 +1005,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>   	d = kzalloc(struct_size(d, sg, sglen), GFP_ATOMIC);
>   	if (!d)
>   		return NULL;
> +	d->sglen = sglen;
>   
>   	d->dir = dir;
>   	d->dev_addr = dev_addr;
> @@ -1120,8 +1121,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>   		}
>   	}
>   
> -	d->sglen = sglen;
> -
>   	/* Release the dma_pool entries if one allocation failed */
>   	if (ll_failed) {
>   		for (i = 0; i < d->sglen; i++) {
