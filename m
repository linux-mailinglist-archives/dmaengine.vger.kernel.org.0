Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260CF7B7718
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjJDEZ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 00:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjJDEZZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 00:25:25 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A34B8;
        Tue,  3 Oct 2023 21:25:19 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id npJ5qpBfzytxcntRnqKfRi; Wed, 04 Oct 2023 04:25:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ntRmqh6ODaLYjntRnqH2bC; Wed, 04 Oct 2023 04:25:19 +0000
X-Authority-Analysis: v=2.4 cv=c764/Dxl c=1 sm=1 tr=0 ts=651ce92f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ATLVwROIy0WDBtGkwve64B69YI4jtu5jD65viGC9LUs=; b=zPdZ2JL/OcajtT1/TtUCZaUpva
        GdHLlaoybosv1Lnh5O4vTVMW64GCpVP4i8XXgIY+xepNPRgsjJ1Kc+Uv9NzRbXOBxy86s3ALQ/3Rv
        aff2+m8cM1z/s1L8MZAlMSggxG5j49Hi72xxAUHdnqDq3/KgL2t5j0tMmuJZTSuTFt1RppqFzpPIg
        SyKf1NAV7dT35RDCWGXi+mjsAJ1Ly6i/doEqmDqOW7C9FQDp+f2j3MOsV/6MqsPuy9KvohinA8zRX
        Nh0X5xF0sCDCLkvEpRugg5ugNHsNdaNU8fiRQM7kHM08ovc1Gbde4+hnmeEqPyMOTpwa+rzItejn+
        ah3G/jjw==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:58986 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnp2Q-001Z3j-2X;
        Tue, 03 Oct 2023 18:42:50 -0500
Message-ID: <32b291a1-57f3-4282-eb21-f4e039f54931@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: fsl-edma: Annotate struct struct
 fsl_edma_engine with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20231003232704.work.596-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003232704.work.596-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnp2Q-001Z3j-2X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:58986
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMssYrgH2yhWgFvVPNPyD6z+JDdiogl+gCFtTl5atZBX3PL1XIn6ACUbLpoZYewzTfxlxCVKityjBHvbrxX7Lz5iXbY5k81GKnVz5GgoXBtfZZ8c/D0N
 Fuaiantb82vbMKRA20xgwo1c5CNXneoNLxsLUnHsSdAMXUQFLq7M1nkgtKIZUU9vgABQVILDJgYWUmudEE0blSihUk84zqDnUaptEgdI4bN8G+jviTq0q33I
 6MluE07L5LK08zU9kFO0BFf+TmvVqSCMOQM+3IPeWvQhqg+RUk76WyYWrhtfcxxrkdKhAna0knsumivcYK4K6w==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/4/23 01:27, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct struct fsl_edma_engine.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/dma/fsl-edma-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 40d50cc3d75a..bb5221158a77 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -225,7 +225,7 @@ struct fsl_edma_engine {
>   	bool			big_endian;
>   	struct edma_regs	regs;
>   	u64			chan_masked;
> -	struct fsl_edma_chan	chans[];
> +	struct fsl_edma_chan	chans[] __counted_by(n_chans);
>   };
>   
>   #define edma_read_tcdreg(chan, __name)				\
