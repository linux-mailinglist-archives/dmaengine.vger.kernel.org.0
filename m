Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1101780457
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357513AbjHRDXC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Aug 2023 23:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357595AbjHRDWq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 23:22:46 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4B3A99;
        Thu, 17 Aug 2023 20:22:41 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id WmuJqzgHqfaVXWq4PqUdec; Fri, 18 Aug 2023 03:22:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Wq4Oq4JDg1rJFWq4OqIcJT; Fri, 18 Aug 2023 03:22:41 +0000
X-Authority-Analysis: v=2.4 cv=PYPsOwtd c=1 sm=1 tr=0 ts=64dee401
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8
 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=L0NDqeB7ZLmQzAogN4cw:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LYJTSI47qRI3iyXZkZwZcmiHPpw4Jzbz9dSwhVVOo70=; b=JUFI8Jbz5GelUOAfC8SooMKQ/0
        IhFjC2k1xiHiDBKyspCVjL06H2zueFbYAc/AtH/PW18pTrMuSf83fSTnCDN/twhokYogq0UvD1z92
        3qnwG1hTyTgA7S/uul0YYI0w/w9g9icexLbvZkD+vGEGrEaoV65nRFbjzQRvStXBI4WHlkpRUa2gs
        tQgfpn67Z51mgq1lT5CxRxfDDHSQPzGaDu3a3Eg+SoHpAVFJ135nog4fP/Q9gJVI2EPnkYG4Hf4zy
        dGVvmR0bdzEbjIUDL9zHjKgqB7BFaEhts5vB0FW4caFmE0m+/fQQGBKcH3C1hBMFuRVr4f5keVpwq
        0Bqhschw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60882 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWp14-001E9O-06;
        Thu, 17 Aug 2023 21:15:10 -0500
Message-ID: <7cd8357b-c35d-a279-c510-11883a7e2eb7@embeddedor.com>
Date:   Thu, 17 Aug 2023 20:16:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 20/21] dmaengine: uniphier-xdmac: Annotate struct
 uniphier_xdmac_device with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817235428.never.111-kees@kernel.org>
 <20230817235859.49846-20-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817235859.49846-20-keescook@chromium.org>
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
X-Exim-ID: 1qWp14-001E9O-06
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:60882
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAN/MmCDWXcngMdb2ypuH7Wfz2tjh6GsAOOeFVrrGzvmuSKMUgATqqjv3pzQ/LYDSU7X/yaiIkRQ3QPH+akOpuVeFpJYf/4WbRawkVozrZ5ATyihPSDU
 MbfCp+J3skxwz0qeSckMbVRlZq1YEOcgSiHodXTtHYf3nQmim3BYaO2wZK5Qc3fAcWtJKmWVxbZB/2z16W4f8tQ/omap3As0ofu0TU8OzHfZckAdT4o3q5Mg
 QXUHMTil9NhLiWTUgCj5G8Sdu0AuJicRMitgIj0IZCYiB4Bbk2vjiPTAHVDUM/0179hs3uLoI/8iDs2JhK9AWrSvkFpi8DrGAYpR/LHEnv6CWpHH6tQgRVuG
 gkTYmiE3Ctxe2XxoZj2wxjkzezPNm6ICzU9TdGtdhfO4fphH4DU=
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
> As found with Coccinelle[1], add __counted_by for struct uniphier_xdmac_device.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/uniphier-xdmac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
> index dd51522879a7..3a8ee2b173b5 100644
> --- a/drivers/dma/uniphier-xdmac.c
> +++ b/drivers/dma/uniphier-xdmac.c
> @@ -97,7 +97,7 @@ struct uniphier_xdmac_device {
>   	struct dma_device ddev;
>   	void __iomem *reg_base;
>   	int nr_chans;
> -	struct uniphier_xdmac_chan channels[];
> +	struct uniphier_xdmac_chan channels[] __counted_by(nr_chans);
>   };
>   
>   static struct uniphier_xdmac_chan *
