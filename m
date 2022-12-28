Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F6657318
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiL1GU5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1GU4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:20:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FAAE6B;
        Tue, 27 Dec 2022 22:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3E6FB81211;
        Wed, 28 Dec 2022 06:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA9AC433EF;
        Wed, 28 Dec 2022 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672208453;
        bh=JCjNKHa2L/LD6O1qZ2+Vv4QD9BCcPkQfGN1EKNkqtCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTo6kqLzqSYEaviGJawhdGSxa5wSYZpih/7wBfXFYohgAd7uQ2Qmy/D3UrH8fn/YJ
         wtsQImjvN4cXg8dA1VyXfKbcbx9RkzQTTE94Y9xCncEhrk/QmKgPgYD1QS5u4lZl5i
         LJjg+5YqvvUX6cM1ckyvvi4clfGy0kYj7Kbr9/f4ZrRbPwLEdGpnNfPMFRHV+DKkCd
         SqIajj8zXlcnton5ypUqQWG0dVCAjc65gJSlczPOFia1aTfSasRtbzs/66jBHHudB8
         2Fz5o0kj8/Qxr4ThCWlAD13R62zuns9cgDYh8hh1CXi9WhtlTdAikzfNbf3dooSpjz
         b5vJ/6pVsv8Dw==
Date:   Wed, 28 Dec 2022 11:50:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: gpi: Document SM6125 compatible
Message-ID: <Y6vgQZLyGV0wPPDs@matsya>
References: <20221222194600.139854-1-marijn.suijten@somainline.org>
 <20221222194600.139854-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222194600.139854-2-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-12-22, 20:45, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document compatibility for this GPI DMA controller on SM6125.

Applied, thanks

-- 
~Vinod
