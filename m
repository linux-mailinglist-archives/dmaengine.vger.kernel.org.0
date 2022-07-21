Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5157357D6BD
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiGUWQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiGUWQc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 18:16:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB4715A3B
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 15:16:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1542083wmo.0
        for <dmaengine@vger.kernel.org>; Thu, 21 Jul 2022 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ecbf/P3CduU/YXdJfd7fPC/TGMnD0SWt94NF3vpr9EA=;
        b=nVCGadmq0Nb13+gtLOLrUjqN0RcYRuJjnv5Qzrys06chh9q23A7K2nn8QTrUwFPIiP
         lTRgCPwvymS8eDMYGgZVsCZbrTxjULpjAMcuqUFDFxSOx2/upVMHVjdGRujYGD6wtNui
         OS0kZX3nYpRcsLFN7LRySXdSmp5hwMk/zcjuTZEDB21P008yDsmTqJ7TxXkgPwler/nE
         DkaM8kKL4sSdTSIfH/a/U792CZNWKF43jbiz80Y1cZIHr4M7ZIOQaRMZHOhOZFaYSWig
         QC92hNKFzfh/6eUd4iuQvdINc/k7P1LRXj+FqT8z/AoDfdQ0wyvGknaVHcAqYWw6CQSS
         3mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ecbf/P3CduU/YXdJfd7fPC/TGMnD0SWt94NF3vpr9EA=;
        b=xjG26ScEsx8/hdoeIg6YLYkayWeJNL9E6U7BIEFv0fIQQLIm22kVx9SwCSp9uEfFcl
         lfpSKymEsIs7I8Isjd4orca+KqZsxyTsMAT1+7HVc56IeBYk84fzKVjHcwU6FzCD4dHA
         d5l3tXqzM/HMX7qeBwxiNV2xM775uA2DFK9iiOhx3t41COBpsB/UbFJ+vTJ9a6b5/CZ8
         NFTifIzwYJMh2k0CK08DwhOV84e8XC6QXHzhNTyWZXJGQD3jZSdA7lCkZHcezzHqjGkR
         3Rzn3jvLadmDJpBCnEYsubuqqn1y6MitO+4bKW99nlA4ZRLWshyrZOS8/r0RVf2RgPcd
         i4hg==
X-Gm-Message-State: AJIora8yUtGP2SmvsROh3kAMZCBaxZk5R4CXcuyL7oZtxxsSKfLkSa78
        rsu1Px5TDhP+86SdZv+j01XKRA==
X-Google-Smtp-Source: AGRyM1uj0+oTfPJhOJiCkfqcZNambR9C1njfGUueRfDMQoYE9QVlvPRv+1DEpFM2wcTAiCIRsSDVJQ==
X-Received: by 2002:a1c:ed14:0:b0:3a2:b91b:dce4 with SMTP id l20-20020a1ced14000000b003a2b91bdce4mr10073965wmh.22.1658441787831;
        Thu, 21 Jul 2022 15:16:27 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003a046549a85sm7273837wmq.37.2022.07.21.15.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:16:27 -0700 (PDT)
Message-ID: <97c24824-d487-e377-3ef6-287bc5e0c0d6@sifive.com>
Date:   Thu, 21 Jul 2022 23:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: dump channel registers on
 error
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
 <20220708170153.269991-2-ben.dooks@sifive.com> <YtlG6hdTJPIDBk9Y@matsya>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <YtlG6hdTJPIDBk9Y@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21/07/2022 13:30, Vinod Koul wrote:
> On 08-07-22, 18:01, Ben Dooks wrote:
>> On channel error, dump the channel register state before
>> the channel's LLI entries to see what the controller was
>> actually doing when the error happend.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> index e9c9bcb1f5c2..75c537153e92 100644
>> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> @@ -79,6 +79,20 @@ axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
>>   	iowrite32(upper_32_bits(val), chan->chan_regs + reg + 4);
>>   }
>>   
>> +static inline u64
>> +axi_chan_ioread64(struct axi_dma_chan *chan, u32 reg)
>> +{
>> +	u32 high, low;
>> +	u64 result;
>> +
>> +	low = ioread32(chan->chan_regs + reg);
>> +	high = ioread32(chan->chan_regs + reg + 4);
>> +
>> +	result = low;
>> +	result |= (u64)high << 32;
>> +	return result;
>> +}
> 
> Better to use helpers like lo_hi_readq()?

Will go check on those, thanks.
