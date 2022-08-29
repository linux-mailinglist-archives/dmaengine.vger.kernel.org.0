Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D35A57C1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2XqV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2XqU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 19:46:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F598588;
        Mon, 29 Aug 2022 16:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FEB1B815A1;
        Mon, 29 Aug 2022 23:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E13DC433D6;
        Mon, 29 Aug 2022 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816777;
        bh=+VvePBFLp/LWmK5hX6RIjAP6zHRRsMudqWZ6EI8ufAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEUFplEohMizRY5cMmxOHX5fEqyEQp1OOmKmxtPpmCx/tDNAJRtzpsc3cnZ6Zz9nt
         NFeXcVoAOSpjyB3BN4Tn669fMPUe7CRfsrTq0EJglgoSO8V1UJce1rc5QTl2d0YEik
         1cxbbMZ1dm16q+rZzR7k+izR1LqEi5aTHvPx3E7Tu8fFfAgv7xOEVCBYPHFgLG4yPC
         xlI66+r26noL8Wo9denx0EXkWNsVPwfg1gNf5O8cv/lmzktFdH9lccrcTwX9ipbRoA
         LMa3PIaOd+stnvWxcLv8shrEP3l31Wu1lBl2AalOkd70k0dWRxnFgVL6M2dMwlhkSq
         cY7NJzt/xL3jw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     a39.skl@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org, will@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, iommu@lists.linux.dev,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@chromium.org,
        loic.poulain@linaro.org, rafael@kernel.org,
        dmaengine@vger.kernel.org, bhupesh.sharma@linaro.org,
        phone-devel@vger.kernel.org, robin.murphy@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org,
        emma@anholt.net, robh+dt@kernel.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: (subset) [PATCH 0/7] Compatibles for SM6115
Date:   Mon, 29 Aug 2022 18:45:38 -0500
Message-Id: <166181675976.322065.5888575144597732401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 15 Aug 2022 12:09:38 +0200, Adam Skladowski wrote:
> This patch series add bunch of compatibles in preparation
> for sending device tree patches for Snapdragon 662 SoC
> 
> Adam Skladowski (7):
>   dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
>   dmaengine: qcom: gpi: Add SM6115 support
>   dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
>   cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
>   dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
>   iommu/arm-smmu-qcom: Add SM6115 support
>   dt-bindings: firmware: document Qualcomm SM6115 SCM
> 
> [...]

Applied, thanks!

[7/7] dt-bindings: firmware: document Qualcomm SM6115 SCM
      commit: f2567b732b0aa2160228a956e0c2007feaeb4b64

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
