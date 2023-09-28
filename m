Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0977B1A4B
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjI1LQV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjI1LQK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:16:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260172A2F3;
        Thu, 28 Sep 2023 04:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293FDC433C7;
        Thu, 28 Sep 2023 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899496;
        bh=Z72NaU1k+yn8VH2KLYdJDMnZnUKhBkDyH6n6KvVEpYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ou0HLEYeDRVJuqY0rrG0SmdACv18zyLqyFfvqTO08uOxosewXkrdnUsKZDt4by03d
         HoyzUC8RESyHsElFy2zn11j09IfZUt6WzHuA2oqO21Ha42SO+KKjXgm6IjLM41ZaXH
         ZwhiFHQ85UyL+kbBBWakHtQDlKvxSMcDdKQpxgpwCi9X21uHcAKc3G/bOFNdpEQoHk
         WsdW7mwVvcDmZgiZTnsgMjtrxUa+KpRrLwckKsmw0eTY9s/J352bE6VAvbfbcH27CW
         a0Gd96itZ8C/fo/0yF0lAtKeo0IL63XfzQLgdegH0q4vvzaFAgyWcriGEs8NCPla5Q
         foBo5T0e+9G9w==
Date:   Thu, 28 Sep 2023 16:41:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
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
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/21] dmaengine: Annotate with __counted_by
Message-ID: <ZRVfYzrdAOrXJUcI@matsya>
References: <20230817235428.never.111-kees@kernel.org>
 <202309151307.F3341BD5A@keescook>
 <202309221015.AB63726@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309221015.AB63726@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-23, 10:16, Kees Cook wrote:
> On Fri, Sep 15, 2023 at 01:08:30PM -0700, Kees Cook wrote:
> > Just a ping on the series... how do these look to you, Vinod?
> > 
> > If you want I can carry them in my tree. Please let me know.
> 
> I'm now carrying this in my for-next/hardening tree. Let me know if
> you'd prefer I drop it.

Sorry was busy in travel etc, it should be in dmaengine/next tomorrow.
You can drop it

Thanks
-- 
~Vinod
