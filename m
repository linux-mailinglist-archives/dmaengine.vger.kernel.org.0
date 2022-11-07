Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086261E937
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 04:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKGDOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Nov 2022 22:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiKGDNb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Nov 2022 22:13:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D1DFC5;
        Sun,  6 Nov 2022 19:13:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D783B60EA4;
        Mon,  7 Nov 2022 03:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840DAC43152;
        Mon,  7 Nov 2022 03:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790781;
        bh=zJz8FXiyz85WeV/ndJos1BET1Ymzq30jhygc/w2GVHg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jAsK7Jxnio9ZMS0skyX386lKSU1uVc1qBChnZiLZi4gUTNtosZjaiUBiWsFRh9tYY
         yj3692sis9uvpdicfWa6OgatE46YdcAKYsQj2nsPgsgADeGGMPSDm0ebJ1Q7KZviWi
         R+twpTHvd0wSC/5mAHDwkO7w0+M9vbYKmv0MSTOBmYr49pwhDzgELv+kmWvgq5CapS
         YKykbltiRKqCkz8yrY1ep6OGN6H6S+f6I7Ur2vxMbtSNbgGX5EYABXSk7whlNHAwYS
         DkepFmLyLZKpC6kD0yXfXEBQEGdz9dcrwP/vnxe85o8/oRU0p3hhjs4m2+zTdMQRK1
         IiJrglgCPUYxQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 0/5] dma/arm64: qcom: use one compatible also for 0x10000 offset
Date:   Sun,  6 Nov 2022 21:12:19 -0600
Message-Id: <166779074259.500303.12000707570977357151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
References: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 18 Oct 2022 19:03:47 -0400, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Rebase on v6 of Richard's patch.
> 2. Add tags.
> 
> Dependencies
> ============
> 1. DT bindings and DMA driver change depends contextually on:
>    https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: sc7280: Add GPI DMA compatible fallback
      commit: e9f2053b7866ac09f2acebbe65056204ef3fe67d
[4/5] arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
      commit: b561e225dee5412609fd98340ca71ba0ab2e4b36
[5/5] arm64: dts: qcom: sm8450: Add GPI DMA compatible fallback
      commit: 19e67894500a8a038cb103e7267da5e64bcc853c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
