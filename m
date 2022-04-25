Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD19B50E4E6
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiDYQAJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiDYP77 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 11:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8287C1183B8;
        Mon, 25 Apr 2022 08:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFAE61248;
        Mon, 25 Apr 2022 15:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B86C385A4;
        Mon, 25 Apr 2022 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650902208;
        bh=aSk7K/v4xG31FFuzTn+bPxMOX3ZjI4TnLihEq1sTN0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MKGRLbhavBVnUb2+uqG0aR5DX3lviiqjDPzfFkIoG+wYCp0AQiRsqHhxuh/UU83zp
         8GXf1ejsZDnbL3SfOKBF2zu3HgK87cITu/rf3ucb+erK3NTqkGH9lBWdMOwCZ2pLUr
         NEqj5UhTaVQqItuvKZ4EkvyEkaqAhswvqGzIecAZUHKkEUJVXebewSdAts9rXKcepN
         xGeMp7SiNSzeDQ0g2WG0yyl/adhIorwF67j3IiO4Mr47eezrYXUSXFrTKFgnbjfLBj
         A5wQyun9lfTe6h4ZaIN+aUfoho3V6AHeaxl/vdNPDfz9PkphdcV8whsOg2wh/ZhABU
         GymcqbvJ0IPYw==
Message-ID: <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
Date:   Mon, 25 Apr 2022 17:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Content-Language: en-US
To:     Allen Pais <apais@linux.microsoft.com>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19/04/2022 23:16, Allen Pais wrote:
> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
> 

Thank you for your patch. There is something to discuss/improve.

> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.

Minor nits:

1. Don't use "this patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
2. Use subject prefix matching subsystem (git log --oneline)

> 
> Github: https://github.com/KSPP/linux/issues/94

3. No external references to some issue management systems, change-ids
etc. Lore link could work, but it's not relevant here, I guess.

Best regards,
Krzysztof
