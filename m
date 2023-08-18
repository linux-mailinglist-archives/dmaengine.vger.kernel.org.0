Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12F780328
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 03:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbjHRBY2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356991AbjHRBYK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 21:24:10 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F333C17
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 18:23:36 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id WcM8qWzEcWU1cWoCSqSQZW; Fri, 18 Aug 2023 01:22:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WoCRq6zKqoeMqWoCSqsPmN; Fri, 18 Aug 2023 01:22:52 +0000
X-Authority-Analysis: v=2.4 cv=F9xEy4tN c=1 sm=1 tr=0 ts=64dec7ec
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fF3hnykDlOGFPwkIEyewUVhIxtgTu0SczeFdKMI/qh4=; b=lD1crn4CtDXv3+aMF5M143w4Iq
        DzjrkR3K1fDAyWjg3iqfgmi0NGyqbmmi395Mj9Pay6ogK9tEIqEp76oXasM0zQdm0FcTM7Zf66G62
        F5Wp3CcoaYTA3O6tF0j6A56JworWR8vtK+Nb31MGK3oOL3fb6YiY4E0NY4iwoHFozQx6L+jpXsQU9
        Hcirv9YgaAf/G9oW9OAcqA3MBldiU6I6CkyKFmRy+SAJ3J619A6TctnKbrxtJWi76O4QR9QSPZFOy
        R+mIdW3eGj6JFE+WAW7Je8tIcA+ITuzG9wpO09d4E/Wt7LNeqKdpyl0fXVLQXrRzYv+2vv8tGLBmA
        oZj65Hrw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57124 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWoCP-000Uj0-00;
        Thu, 17 Aug 2023 20:22:49 -0500
Message-ID: <e15140e7-1122-17af-8088-4dcb5043019f@embeddedor.com>
Date:   Thu, 17 Aug 2023 19:23:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/21] dmaengine: moxart-dma: Annotate struct moxart_desc
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
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
 <20230817235859.49846-6-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-6-keescook@chromium.org>
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
X-Exim-ID: 1qWoCP-000Uj0-00
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:57124
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 166
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLPy+PKPtKd31coAyQ3/vUOcX9i+FM/b4rG4tpXchDoPoBO/n2R4LlNPItY54e+YMzHGhXv0AioKczzphWAkR65eRz/3V6b+x5zW9htV/YHL8XrTBz7b
 jrcERptpt7cEtU17ceGWnry9M4YZTloYX7Y1kqZBXsLS42GBewE8nOPziHy8XFfPreUf7gpwWhOKTiA7AgWUT6OVqdNOW7zr8gY=
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct moxart_desc.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/moxart-dma.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 7565ad98ba66..c1dd5716a46d 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -124,7 +124,7 @@ struct moxart_desc {
>   	unsigned int			dma_cycles;
>   	struct virt_dma_desc		vd;
>   	uint8_t				es;
> -	struct moxart_sg		sg[];
> +	struct moxart_sg		sg[] __counted_by(sglen);
>   };
>   
>   struct moxart_chan {
> @@ -309,6 +309,7 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
>   	d = kzalloc(struct_size(d, sg, sg_len), GFP_ATOMIC);
>   	if (!d)
>   		return NULL;
> +	d->sglen = sg_len;
>   
>   	d->dma_dir = dir;
>   	d->dev_addr = dev_addr;
> @@ -319,8 +320,6 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
>   		d->sg[i].len = sg_dma_len(sgent);
>   	}
>   
> -	d->sglen = sg_len;
> -
>   	ch->error = 0;
>   
>   	return vchan_tx_prep(&ch->vc, &d->vd, tx_flags);
