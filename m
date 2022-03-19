Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178324DEA81
	for <lists+dmaengine@lfdr.de>; Sat, 19 Mar 2022 20:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiCST4r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Mar 2022 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiCST4q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Mar 2022 15:56:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06321760C8;
        Sat, 19 Mar 2022 12:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5FF1ACE02C8;
        Sat, 19 Mar 2022 19:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CAC340EC;
        Sat, 19 Mar 2022 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647719719;
        bh=uj4MoN7wLRxHPnrpjOAR9P4RjaXPPxcItDjnxxSh7Cw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tPONuXnoCi8KQRX7JcDsMsCgDDufn3i13p+NVHbCfqOenZmE8yBhIdEmdWdf27nth
         L8diqg8F46NYMxzNcVeV31yh8PIG9n8vqQ470pQ3epDL2QpmMxEbSY+D4KZIahM477
         Eki96j54uA/oI5fg6IInWD+vGghADCzKf/t/nDmDiN4wJYHJGKz/vpKGeeqUI5WTm0
         sIRtUkVSMWPNm8q0kCssS0MnPRBAFaV5Ro48kZOlgPWMYbF9bLMwLdpMzeMDsR7/jM
         M6eDKdlWxg8L1PI+z9wAPYOVtEotkeQPA1dzHeaKatR2j2wfmEzGWWMQPgbAtHn3ft
         dYF5rYuzFnrfg==
Message-ID: <8a5fdf42-d457-7f47-b66a-8447fb297be0@kernel.org>
Date:   Sat, 19 Mar 2022 15:55:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dmaengine: qcom_hidma: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <4deb32b0c7838da66608022c584326eb01d0da03.1642232106.git.christophe.jaillet@wanadoo.fr>
 <ee43d68f-000c-6513-38f2-877b9018ab22@kernel.org>
 <08b7604d-f528-ecb7-a8b2-7c9c36518143@wanadoo.fr>
From:   Sinan Kaya <okaya@kernel.org>
In-Reply-To: <08b7604d-f528-ecb7-a8b2-7c9c36518143@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/19/2022 2:24 AM, Christophe JAILLET wrote:
> Le 22/01/2022 à 19:05, Sinan Kaya a écrit :
>> On 1/15/2022 2:35 AM, Christophe JAILLET wrote:
>>> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
>>> dev->dma_mask is non-NULL.
>>> So, if it fails, the 32 bits case will also fail for the same reason.
>>>
>>> Simplify code and remove some dead code accordingly.
>>>
>>> [1]: 
>>> https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
>>>
>>
>> Can we please document this?
> 
> Hi, the patch has been applied, but [1] is sometimes given as an 
> explanation link.
> 
> CJ
> 
> 
> [1]: 
> https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033674.html

Sounds good, please carry my

Acked-By: Sinan Kaya <okaya@kernel.org>

