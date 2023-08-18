Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F078033A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 03:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356988AbjHRBZB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 21:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357055AbjHRBYs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 21:24:48 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 18:24:25 PDT
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC973C35
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 18:24:24 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id WcM7qDcF6DKaKWoDPqIZto; Fri, 18 Aug 2023 01:23:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WoDOq70h1oeMqWoDOqsR6m; Fri, 18 Aug 2023 01:23:50 +0000
X-Authority-Analysis: v=2.4 cv=F9xEy4tN c=1 sm=1 tr=0 ts=64dec826
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rV+WYRnH5TXA/Y405RDLo11+a66UWskxwRISLK/OmBI=; b=FJu+paHXo96eE8gQAEcxG7Ef8a
        XWwtsMMaJR30bKbG+wqSV3e0xMTA2NAt8+4Sld4LWF6jKM1wknDMnEV6YjkoHaxubC5sErJgWjEWW
        rxVylS8//8+rYl0ENj0XOzUyiS2mG7ME9ZaNUDrxMgNQsEmF3E4iuxHWzbpRwWzh2nbACl8LAnBXC
        wUjyqPrnSdes293KRNE+eF3m5s4jyJuUcfhjGBWOoNKkUYRAZVjuQcVKNbmpydLNw7eE9vYLpfRyX
        Vao1iyrQRhTs8bfHGyqyccbl/2mQGZyYT8COOzwxHbTb5IxERn1JwDsBJSWwa0HGA4pL1m2tkceIv
        ObLo8hgg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34254 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWoDL-000WJd-1n;
        Thu, 17 Aug 2023 20:23:47 -0500
Message-ID: <488f56f6-7a46-b8f9-bfc8-5d1934d095ab@embeddedor.com>
Date:   Thu, 17 Aug 2023 19:24:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/21] dmaengine: sprd: Annotate struct sprd_dma_dev with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
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
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817235428.never.111-kees@kernel.org>
 <20230817235859.49846-10-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-10-keescook@chromium.org>
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
X-Exim-ID: 1qWoDL-000WJd-1n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:34254
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 331
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB/89YLgbrBQnD6Yhc+v3nKZ7hKJYHUPHknaYOKoe/PFyD2ihi/76Uo0Ba0CBA6sVS5sI0gTzOWdsuQdg3PgXnWFXKtaCodWeARnsyFqak8qBM7kyCE2
 J0WYajvoHHwOh87XQt7pdlpZuEaXjyN5eo+GpLEwcfJ1Q3Fd9jt4ddzYANmWlOo1T8jLrJshxWBqKxvRe1vzI4gk7gPO+kuLroE=
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
> As found with Coccinelle[1], add __counted_by for struct sprd_dma_dev.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/sprd-dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 168aa0bd73a0..07871dcc4593 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -212,7 +212,7 @@ struct sprd_dma_dev {
>   	struct clk		*ashb_clk;
>   	int			irq;
>   	u32			total_chns;
> -	struct sprd_dma_chn	channels[];
> +	struct sprd_dma_chn	channels[] __counted_by(total_chns);
>   };
>   
>   static void sprd_dma_free_desc(struct virt_dma_desc *vd);
