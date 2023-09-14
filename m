Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E07A09FD
	for <lists+dmaengine@lfdr.de>; Thu, 14 Sep 2023 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbjINQAm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Sep 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbjINQAj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Sep 2023 12:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615561FC0;
        Thu, 14 Sep 2023 09:00:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ADDC433C7;
        Thu, 14 Sep 2023 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707235;
        bh=LcuB9zR375+7iGkeQHoDASa4rDIgGV48HpSpQaqIAaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9Y16kT3WenNTuzTz3vmI65HUvSDGe+Vkm8urSaY4/qyFmeYD669MYzV+vKImSjF8
         j2WwrX9EEp5AwhKHrwGwdx5q9lEQrDGyR+LuooGHJM31W8lVaL5syA1rf87HxWhfca
         x8fKBjglBjf941YxJ4NT/i+d9ep2EyNDKosn+6baQmgITl6dZ/pivmItsi+MLgpVjB
         05TV7OJpLsEjsAu+BUPd/qI0xJeuAtMasiPs/Mzk0yG0M8jGtXNHAoBbV15u3So8l7
         tuZJscn5jDhG3e9SGFbOhLLhEs2WAaeAg8pMu+xQCK3UKZUIJwtJTIHhM47wCHGbh+
         JCxbuH5eStBww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: (subset) [PATCH 0/7] 8550 dma coherent and more
Date:   Thu, 14 Sep 2023 09:04:22 -0700
Message-ID: <169470744881.681825.862550509087910761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 30 Aug 2023 14:48:39 +0200, Konrad Dybcio wrote:
> Qualcomm made some under-the-hood changes and made more peripherals
> capable of coherent transfers with SM8550.
> 
> This series marks them as such and brings fixups to usb and psci-cpuidle.
> 
> 

Applied, thanks!

[2/7] dt-bindings: qcom: geni-se: Allow dma-coherent
      commit: 274707b773378f4ce8ba214002b3d67a4d0785ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
