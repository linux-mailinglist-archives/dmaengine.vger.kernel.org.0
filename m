Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77BF50E9EB
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 22:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiDYUNy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiDYUNx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 16:13:53 -0400
X-Greylist: delayed 1444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 13:10:47 PDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.151.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A53980B
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 13:10:47 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 75A36F91F
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 14:46:43 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j4fTnWIQc9AGSj4fTnf9Cy; Mon, 25 Apr 2022 14:46:43 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gAUg/R/cVeWAnFANt9sHBSNVGqmO70rdsDy45wJTsaU=; b=nXjSnH2+B4oYCJA///AAVW2NW8
        r4dPkUjzzfe5pFyYIsoCRBMLDuIqZiFDdS5xObDi78AZXva1lu/ggOV88cwZXwl66sIiTkHrbz3LO
        eDzD1RJniTpUTwGwp2cJmllIRyoHCREO3oWmuIVVHcTMBzSatuT+r1cBj746FvoVFii8NNk+WQlZN
        ErkF4Rmdr3IEqIs8jHPDKMeMmW7T9VwpVWrAvsezIR9lOql2dA87aUs5yYE+l5BKxZVHAV1GzK4qR
        TLo3ytG37WxNYuGZtJLlxTQ2SoYZ+61vCIPZu5OdQTZYe2UoIfU86IO00ok+fB2ohDRXoo87J9Udq
        nesJsk1A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:43822 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1nj4fQ-001AN9-N1; Mon, 25 Apr 2022 14:46:40 -0500
Message-ID: <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com>
Date:   Mon, 25 Apr 2022 14:55:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1nj4fQ-001AN9-N1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:43822
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/25/22 10:56, Krzysztof Kozlowski wrote:
> On 19/04/2022 23:16, Allen Pais wrote:
>> The tasklet is an old API which will be deprecated, workqueue API
>> cab be used instead of them.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
> 
> Minor nits:
> 
> 1. Don't use "this patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 2. Use subject prefix matching subsystem (git log --oneline)
> 
>>
>> Github: https://github.com/KSPP/linux/issues/94
> 
> 3. No external references to some issue management systems, change-ids
> etc. Lore link could work, but it's not relevant here, I guess.

I think the link to the KSPP issue tracker should stay. If something,
just changing 'Github:' to 'Link:'

The KSPP has been an active _upstream_ project for about 7 years now,
and the issue tracker is publicly available. :) So it's not like a random
link to a random project. This also help us to automatically keep track
of the patches sent out to address a particular issue that we want to
have resolved upstream. So please, keep the link in the changelog text,
it's useful. :)

Thanks
--
Gustavo
