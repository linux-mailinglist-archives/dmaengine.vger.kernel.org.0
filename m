Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44F528369
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiEPLkb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiEPLka (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 07:40:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB23DF55;
        Mon, 16 May 2022 04:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06F43B80B55;
        Mon, 16 May 2022 11:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1A2C385AA;
        Mon, 16 May 2022 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652701227;
        bh=L5E5J6zzQA1xwUAGYCTKpj4tRtQkKMREW7HnJ9e3CWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mfyad4iBN0LffO3Y5W8vZRV64qx1ZV1gUE1laCe8MTfHN8aw6yGD40pgYvagw8JHp
         RkUxOXMrkJ8ICuW66vpBXQ4uS7FNCe8q7UUmhQL3KibuZajpAQe2IsOFfeah4lTarl
         Bny6DtzYmcBzwB4VcNiofzmCxQtt93mvY3qLgwsnYKpGGjdOO3SJs6PcgcKVgpI+Hs
         vPEJM5J3WeoWFGSDCf8ZkuZ9N/wXclWb+7daC6UC6wNCjsxgeqc1j3P7A5g0NYtMVb
         FHdyB2TIiOxhJajbX49C5xCOxXAfqie/WW1eVp/kpvNf8O5z0bZ5KBztTmK48PVdB5
         8alU8QOJC0J/w==
Date:   Mon, 16 May 2022 17:10:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        olivier.dautricourt@orolia.com, sr@denx.de,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com, afaerber@suse.de,
        mani@kernel.org, logang@deltatee.com, sanju.mehta@amd.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        green.wan@sifive.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Message-ID: <YoI4J8taHehMpjFj@matsya>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
 <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com>
 <YmpedDjzZXz2t6NS@smile.fi.intel.com>
 <DA101ED8-F99F-4DCB-9CB7-370A62C44B65@linux.microsoft.com>
 <CACRpkdadjPn82G4TMKyyQtkju=oA4EX=GNxs8KRtrQ7CcqVOog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdadjPn82G4TMKyyQtkju=oA4EX=GNxs8KRtrQ7CcqVOog@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-22, 23:54, Linus Walleij wrote:
> On Fri, May 6, 2022 at 7:43 PM Allen Pais <apais@linux.microsoft.com> wrote:
> 
> >  - Concerns regarding throughput, would workqueues be as efficient as tasklets (Vinod)
> 
> You need to ask the scheduler people about this.
> 
> The workqueues goes deep into the scheduler and I can't make
> out how they are prioritized, but they are certainly not treated
> like any other task.

+1

-- 
~Vinod
