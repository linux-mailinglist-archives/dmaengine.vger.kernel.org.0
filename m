Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329927B1B78
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjI1L4X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjI1L4V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F78194;
        Thu, 28 Sep 2023 04:56:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9EFC433CA;
        Thu, 28 Sep 2023 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902179;
        bh=6Zl5GUxFA2nc/y6O7NdAMik2lRzNv6/dDwBAB74Y+WU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kU1QMlU2oOcCh9DJWgxxKCGPuu9i9708CIb4rLHyv1+Ax6Boy93WAwoDcnNkK8uQz
         +Bwq9RUhYgcCqMMjsK8CaSRC5n8KKLnrrcrSxhhsIYl+PJtr/zL32i9zpOrp4zh0sl
         AiXUVhkHAan10BqdRf9m3aH92jvzO43o0XkVHNoyluJ3uf46NTm/x5puntUOxsXf94
         JL5IU0Nzba4ouykEsdYXLZrjFO+x3aocGihrmWmQq6W8AYJGTpZsve1H/9PnNpLZ3x
         Qb4G3VAnRj5oIIhqqSLTkaKHm3NAFyv350AMCtqXaxabHCO1hSxdjq69ENpWq4DqgF
         JGGSZy1WzVOkA==
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
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
Subject: Re: [PATCH 00/21] dmaengine: Annotate with __counted_by
Message-Id: <169590216841.152265.1942803099201042070.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:08 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 17 Aug 2023 16:58:37 -0700, Kees Cook wrote:
> This annotates several structures with the coming __counted_by attribute
> for bounds checking of flexible arrays at run-time. For more details, see
> commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> -Kees
> 
> [...]

Applied, thanks!

[01/21] dmaengine: apple-admac: Annotate struct admac_data with __counted_by
        commit: 83c5d35bf9112577da097c1b4fbfedef93b951e6
[02/21] dmaengine: at_hdmac: Annotate struct at_desc with __counted_by
        commit: 81cd3cb3b3dd37df1fc45c5b6443a07bc2a7fee4
[03/21] dmaengine: axi-dmac: Annotate struct axi_dmac_desc with __counted_by
        commit: f1bc0d01cb349da43d55548b57c915ef8fe024c7
[04/21] dmaengine: fsl-edma: Annotate struct fsl_edma_desc with __counted_by
        (no commit info)
[05/21] dmaengine: hisilicon: Annotate struct hisi_dma_dev with __counted_by
        commit: 7d4b82185521538eab8b0532b9bd7b8c8ca3e63b
[06/21] dmaengine: moxart-dma: Annotate struct moxart_desc with __counted_by
        commit: fd1cb31a037bf8894a710392c2354281c5276d09
[07/21] dmaengine: qcom: bam_dma: Annotate struct bam_async_desc with __counted_by
        commit: b9fe0bd5903140cc3e1ae4e542ae7ff38c90d011
[08/21] dmaengine: sa11x0: Annotate struct sa11x0_dma_desc with __counted_by
        commit: 04b5433b8c0e1b014f081f4bf79767bbc207a7b0
[09/21] dmaengine: sf-pdma: Annotate struct sf_pdma with __counted_by
        commit: 1539a22e144106eefc0ef05e7b91f68ad20a71ad
[10/21] dmaengine: sprd: Annotate struct sprd_dma_dev with __counted_by
        commit: 8360c11aef5775745fc10438e24db95ab2329b1d
[11/21] dmaengine: st_fdma: Annotate struct st_fdma_desc with __counted_by
        commit: 8279f0b476f37c51de2ed8bd70d770b2893dd2fa
[12/21] dmaengine: stm32-dma: Annotate struct stm32_dma_desc with __counted_by
        commit: 195e46df2d996ff4bbf624891b1d3ae8ea9f315d
[13/21] dmaengine: stm32-mdma: Annotate struct stm32_mdma_desc with __counted_by
        commit: 035472170a2a21fc62d8258883a9f566943058b7
[14/21] dmaengine: stm32-mdma: Annotate struct stm32_mdma_device with __counted_by
        commit: 7ba0035dc02ce0c877004dc4052c6d5f873539db
[15/21] dmaengine: tegra: Annotate struct tegra_dma_desc with __counted_by
        commit: 32b5e2d7cd14c80de1fa1cdffcc6ec211b615d82
[16/21] dmaengine: tegra210-adma: Annotate struct tegra_adma with __counted_by
        commit: 15f2c636dde8c4370db87ceabce5cc8325460d77
[17/21] dmaengine: ti: edma: Annotate struct edma_desc with __counted_by
        commit: 5f240e0cdbcb0cc60d6a75ea7d492ce93b7fd52e
[18/21] dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by
        commit: b85178611c1156deb3c09e7f8d8cdd662b8df99c
[19/21] dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_desc with __counted_by
        commit: 5a67a8f93f02027e4ac8583715d2f4bd2de20e10
[20/21] dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_device with __counted_by
        commit: 7935de861aed45f97a4262d9b215d9feb172516b
[21/21] dmaengine: usb-dmac: Annotate struct usb_dmac_desc with __counted_by
        commit: a04bbeaa37d8789de5592506fa776256e784b69c

Best regards,
-- 
~Vinod


