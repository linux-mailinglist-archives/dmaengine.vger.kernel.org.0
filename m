Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C338658FBF
	for <lists+dmaengine@lfdr.de>; Thu, 29 Dec 2022 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiL2RY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Dec 2022 12:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiL2RYX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Dec 2022 12:24:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119A15F23;
        Thu, 29 Dec 2022 09:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0118DB819FC;
        Thu, 29 Dec 2022 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF8C4331E;
        Thu, 29 Dec 2022 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334640;
        bh=F0VX9OVaVAi5UqXtbc8wTdMW41xY9SwZl+5ouw15lzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCggH+9pRcWviQVGukbO+YKB6HGjcqZc3NMYBBfK8EZjbwnQj4MdxQTTrMZdWQIMX
         aj9//GsogJljut3SO2gSDT7J1rfAscOfT3Al0s7cg/iSCSpQcU04d1P7NmtizjQ3mL
         xozIvgZka7TLZv6coqM9FYi7swPV5zynisbg3w6ewZ/9AUc2Wdvc2BB4CAinGx8KUX
         QM7QdDwB6oKr2TH3t9LOQRVX4UUmceWy4dUD8HImwFq1tak00SV7aoj+HEpzIL2kIJ
         AfY+xd5M9jtz2i9bvxwUbJqgAmesEgEsDv23GY/yJtuoGrkOxFELvUqJVJa5sY+eMk
         AgNVcL9Ys96Xg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, phone-devel@vger.kernel.org, vkoul@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     bhupesh.sharma@linaro.org, mailingradian@gmail.com,
        linux-arm-msm@vger.kernel.org, martin.botka@somainline.org,
        jami.kettunen@somainline.org, they@mint.lgbt,
        konrad.dybcio@somainline.org, luca.weiss@fairphone.com,
        dmaengine@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/2] arm64: dts: qcom: sm6125: Enable GPI DMA
Date:   Thu, 29 Dec 2022 11:23:38 -0600
Message-Id: <167233461774.1099840.1967515625455827333.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221222194600.139854-1-marijn.suijten@somainline.org>
References: <20221222194600.139854-1-marijn.suijten@somainline.org>
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

On Thu, 22 Dec 2022 20:45:58 +0100, Marijn Suijten wrote:
> Enable GPI DMA on SM6125 by using the new sdm845 compatible with
> ee_offset 0.
> 
> Changes since v2:
> - Remove leading zero from iommu stream ID.
> 
> v2: https://lore.kernel.org/linux-arm-msm/20221216231528.1268447-1-marijn.suijten@somainline.org/T/#u
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm6125: Add GPI DMA nodes
      commit: 581734f754d2cb3bd748687dedb3c4ba298d7d80

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
