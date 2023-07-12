Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C34750325
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGLJdQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGLJdO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 05:33:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A71A8
        for <dmaengine@vger.kernel.org>; Wed, 12 Jul 2023 02:33:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2b42:575f:41f:104f])
        by andre.telenet-ops.be with bizsmtp
        id L9Z82A00U4w94eT019Z8Ph; Wed, 12 Jul 2023 11:33:09 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJWDc-001Bva-DG;
        Wed, 12 Jul 2023 11:33:08 +0200
Date:   Wed, 12 Jul 2023 11:33:08 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Vinod Koul <vkoul@kernel.org>
cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/5] dmaengine: qcom: gpi: Use
 devm_platform_get_and_ioremap_resource()
In-Reply-To: <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
Message-ID: <c3373ebe-2f52-bed7-7f59-98e1268c9af2@linux-m68k.org>
References: <20230705081856.13734-1-frank.li@vivo.com> <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

 	Hi Vinod,

On Tue, 11 Jul 2023, Vinod Koul wrote:
> On Wed, 05 Jul 2023 16:18:52 +0800, Yangtao Li wrote:
>> Convert platform_get_resource(), devm_ioremap_resource() to a single
>> call to devm_platform_get_and_ioremap_resource(), as this is exactly
>> what this function does.
>>
>>
>
> Applied, thanks!
>
> [1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
>      commit: d9313d9f1fbc14cae5147c5130bea54aa76ad65f
> [2/5] dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
>      commit: a189107deb574fd08018bbf2fe5cd86450a54b13
> [3/5] dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resource()
>      commit: fe6c2622473f3756a09bd6c42cffca6fbdce391c
> [4/5] dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
>      commit: 0976421c5a339b1b1a89cfba4471a6de761130ed
> [5/5] dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()
>      commit: b402a7eeaa35aaa3300a4ba6bd5b381112ae183c

I noticed all your new dmaengine[1] and phy[2] commits contain a
"Message-ID:" tag.  Presumable you added a git hook for that?

However, the standard way is to add a Link: tag pointing to lore
instead, cfr. [3].

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next
[2] https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next
[3] https://docs.kernel.org/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
