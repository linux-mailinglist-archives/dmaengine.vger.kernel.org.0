Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716297B1B85
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjI1L4l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjI1L4i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245A1A3;
        Thu, 28 Sep 2023 04:56:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE456C433C7;
        Thu, 28 Sep 2023 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902196;
        bh=MqwQqZxSq+rYV16JRtX+1VS187fbXxKqzbTAVy7Reds=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pNv37D6C1Ezqi77ncDvQK5/6Z4Yn/nLr9/qrg5XNCC3rbFlduup7DQsOnAWZs8fA6
         OXXBMVbxWJe4kwCXLfmaj6qCiu0wQCSekDH5ojmMX0WEQWaEAzteIYDAK8dYDxgWmE
         lwkgInRQJ8ZZUxc4y9dfnSL9Su+sNDjgnwh/xu3ne3iwoTDN8uLoxriq1wFGm6+wcx
         HZ8Fc/qfDrnTpCxWqSOad6Lp8DhvGytsZgyZA4oq2YoGirv//4ws56Tr4k3hYJPWqm
         SsXJNTGbg7Jz2/e3/eq7q58y4rfYnxhPCqvp3IcHD7BmQ2Cufzcsbk8FQs7+upOcL8
         6Stodsy49PM5g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
Subject: Re: (subset) [PATCH 0/7] 8550 dma coherent and more
Message-Id: <169590219144.152265.4409423880312803371.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:31 +0530
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


On Wed, 30 Aug 2023 14:48:39 +0200, Konrad Dybcio wrote:
> Qualcomm made some under-the-hood changes and made more peripherals
> capable of coherent transfers with SM8550.
> 
> This series marks them as such and brings fixups to usb and psci-cpuidle.
> 
> 

Applied, thanks!

[1/7] dt-bindings: dmaengine: qcom: gpi: Allow dma-coherent
      commit: 10c060edf581fdd0d8f23cab84e6c8546c2df8fc

Best regards,
-- 
~Vinod


