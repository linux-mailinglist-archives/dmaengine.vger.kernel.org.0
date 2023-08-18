Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27F7804EF
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357763AbjHRDyn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 23:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357810AbjHRDy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 23:54:29 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D135BE;
        Thu, 17 Aug 2023 20:54:27 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id We1mqgRQ5yYOwWqZ7q2Wu1; Fri, 18 Aug 2023 03:54:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WqZ6qcVbM234eWqZ7qOt0Q; Fri, 18 Aug 2023 03:54:25 +0000
X-Authority-Analysis: v=2.4 cv=cPzzD3SN c=1 sm=1 tr=0 ts=64deeb71
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=7U2zQXYeb2txnVgCXwAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eQY7eDC80m9ueawTIc2Di+0+U+AtfXqsds2PmKWodwA=; b=qXEgSDyhtTdCPlGtX0luTEt9uK
        XAZka4p7hGGzJ5GQdnPwFYEuneC+5kN8psw04dH58nimNsYOLizuwvbr6tJ6RakZjpeq8PcI1/vPR
        cXms4asLXn1M+82iPQvYbiBiqsek2qnboH71bvR7y52WRheZmAYU51y1f04Ozxh8iOvvFSzxOR6qP
        eyAklbAm3XMskNcThFzT+jQJxIe31CCPAFe3iuiA5dnK/BcBlwwxCUgXWg3uI7/dXyurlCZSjNHSJ
        2Vm2tjSdANuKidDa0b25tCVEaHS/te143lRFPXk7iXBDBJjvvXCJ2TMV4z4CWMK5Bjjtq1zsrXDRB
        Os9SwCTA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:54772 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWoze-001AjK-2G;
        Thu, 17 Aug 2023 21:13:42 -0500
Message-ID: <eab36e1b-94e8-a78a-f240-56414dafbaf9@embeddedor.com>
Date:   Thu, 17 Aug 2023 20:14:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/21] dmaengine: axi-dmac: Annotate struct axi_dmac_desc
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
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
 <20230817235859.49846-3-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-3-keescook@chromium.org>
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
X-Exim-ID: 1qWoze-001AjK-2G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:54772
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOSZsZVeaumByXPYsV8jWYfeZlhupJpGfbxOFdaem+Eucas/oSLiGhtpwWUZkoQ1gJUUHV022xPM2vdJMokqfa61qrKX2HaZ+s//JBvKsZhW+vqkJz90
 1IDbnoY83Yl+5QJ7jJ3Ihn2E6maodrJDdbmh1l/cdXdpwSmF5RTnVfAhwyQ8xWgwJvO2bL0hlFfixiT+kjsH/4kb1+I1t+KGJcIqkPFiUScg+9YUddI1/lKN
 aJt0229ArUrAZU6Xh366E3tE4pMjSh93VMlgj8VsANwiYtzLr8nLrkPWPvRLUGq/uC3ukFrJwo2yfg4Qh6fPhXI4/Z8s7Z1qzNOtMH6fYnVRnxTe4YewFK5l
 l7oWmJ7Jfvz9/mmUtlq7O8pev/ft375KuslmzXKQ6A7464ictts=
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
> As found with Coccinelle[1], add __counted_by for struct axi_dmac_desc.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/dma-axi-dmac.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index fc7cdad37161..b9f85cb20d3e 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -117,7 +117,7 @@ struct axi_dmac_desc {
>   	unsigned int num_submitted;
>   	unsigned int num_completed;
>   	unsigned int num_sgs;
> -	struct axi_dmac_sg sg[];
> +	struct axi_dmac_sg sg[] __counted_by(num_sgs);
>   };
>   
>   struct axi_dmac_chan {
> @@ -484,12 +484,11 @@ static struct axi_dmac_desc *axi_dmac_alloc_desc(unsigned int num_sgs)
>   	desc = kzalloc(struct_size(desc, sg, num_sgs), GFP_NOWAIT);
>   	if (!desc)
>   		return NULL;
> +	desc->num_sgs = num_sgs;
>   
>   	for (i = 0; i < num_sgs; i++)
>   		desc->sg[i].id = AXI_DMAC_SG_UNUSED;
>   
> -	desc->num_sgs = num_sgs;
> -
>   	return desc;
>   }
>   
