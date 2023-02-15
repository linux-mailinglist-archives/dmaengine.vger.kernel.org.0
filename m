Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271D69787E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjBOIwB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 03:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBOIwA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 03:52:00 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CDD2CC5F;
        Wed, 15 Feb 2023 00:51:59 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F8eW6w014871;
        Wed, 15 Feb 2023 09:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nQRfhP5h3wevSsK9mj7ey/H+BDf9TMAs1fd5QoahUfo=;
 b=HfQF+XNc549cPOsVWnKOTRhkEJhwVzsWHfLeOTQZNTr/84Z6RM12oF5ZxFoe5TqAfrZW
 PaiEfJN2yntCj3lQBixl8rZfJKZHnMY9BGQO+6LXwrL9mY6837XVFq6NVxhwzCjcIEun
 YZEWCIjj8Mni8devRbE5RkuaJ9+UVIv3aupXVVwqeWQvn8RrRhTQoxOfqsOT6EvrrEAi
 iM7J1WaxTwGo556NWTJccyuCq5nEC085X9OA+/octs/pQQ2K7M8vBInPno2uks2abo4C
 x3EzpE+fw1SeHuiprLibRsLCef4lK8Lhd9ZsVmsgy3rZZU4mwNLmBSWLeRs7TBfeOQum aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nradm5e6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 09:51:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE95E10002A;
        Wed, 15 Feb 2023 09:51:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7B9A212FBC;
        Wed, 15 Feb 2023 09:51:24 +0100 (CET)
Received: from [10.252.21.164] (10.252.21.164) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 15 Feb
 2023 09:51:22 +0100
Message-ID: <10334742-2c44-0a2f-cbd7-b4ce93816300@foss.st.com>
Date:   Wed, 15 Feb 2023 09:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dmaengine: stm32-dma: avoid bitfield overflow assertion
To:     Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        M'boumba Cedric Madianga <cedric.madianga@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230214103222.1193307-1-arnd@kernel.org>
Content-Language: en-US
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20230214103222.1193307-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.21.164]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_04,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

Thanks for pointing this issue.

On 2/14/23 11:32, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> stm32_dma_get_burst() returns a negative error code for invalid
> input, which gets turned into a large u32 value in stm32_dma_prep_dma_memcpy()
> that in turn triggers an assertion because it does not fit into a
> two-bit field:
> 
> drivers/dma/stm32-dma.c: In function 'stm32_dma_prep_dma_memcpy':
> include/linux/compiler_types.h:399:38: error: call to '__compiletime_assert_310' declared with attribute error: FIELD_PREP: value too large for the field
>    399 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                      ^
> include/linux/compiler_types.h:380:4: note: in definition of macro '__compiletime_assert'
>    380 |    prefix ## suffix();    \
>        |    ^~~~~~
> include/linux/compiler_types.h:399:2: note: in expansion of macro '_compiletime_assert'
>    399 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |  ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>     68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
>        |   ^~~~~~~~~~~~~~~~
> include/linux/bitfield.h:114:3: note: in expansion of macro '__BF_FIELD_CHECK'
>    114 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>        |   ^~~~~~~~~~~~~~~~
> drivers/dma/stm32-dma.c:1273:4: note: in expansion of macro 'FIELD_PREP'
>   1273 |    FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
>        |    ^~~~~~~~~~
> 
> I only see this with older gcc versions like gcc-6.5 or gcc-9.5 but not
> with gcc-12.2 or higher. My best guess is that this is the result of
> changes to __builtin_constant_p(), which seems to treat the 'cold'
> codepath after an error message as a constant branch, while in newer
> gcc versions the range check is skipped after determining that
> dma_burst is never a compile-time constant.
> 
> As an easy workaround, assume the error can happen, so try to handle this
> by failing stm32_dma_prep_dma_memcpy() before the assertion.
> 
> Fixes: 1c32d6c37cc2 ("dmaengine: stm32-dma: use bitfield helpers")
> Fixes: a2b6103b7a8a ("dmaengine: stm32-dma: Improve memory burst management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/dma/stm32-dma.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> index 37674029cb42..e3cd4b0525e6 100644
> --- a/drivers/dma/stm32-dma.c
> +++ b/drivers/dma/stm32-dma.c
> @@ -1266,6 +1266,10 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_memcpy(
>   		best_burst = stm32_dma_get_best_burst(len, STM32_DMA_MAX_BURST,
>   						      threshold, max_width);
>   		dma_burst = stm32_dma_get_burst(chan, best_burst);
> +		if (dma_burst > 3) {
> +			kfree(desc);
> +			return NULL;
> +		}

Instead of hard-coding this check, I suggest to copy what is done in 
stm32_dma_set_xfer_param() where stm32_dma_get_burst() is also used.
So, change dma_burst from u32 to int, and check for negative value and 
failing in this case before the assertion of FIELD_PREP.

Regards,
Amelie

>   
>   		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
>   		desc->sg_req[i].chan_reg.dma_scr =
