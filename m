Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6174F5E4
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGKQpF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGKQoe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23EB2689;
        Tue, 11 Jul 2023 09:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C459D61575;
        Tue, 11 Jul 2023 16:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B4C433CB;
        Tue, 11 Jul 2023 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093849;
        bh=G1DK5ii1NUQUnYeNG5eFlZHFIReCO/TJbMdGrps8Hws=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=T3sfQcWHd95jmg4/DJhdp1ZirvRO0inDATn2LnjpFim7d/YeferpcrjCP1rf9N9jl
         Y+R7+MTj4x7VFfn2b0JHaKpV2Sy4EEljt9GSJZV3w2LNouTNNTe2xG7BmzLR6zovk5
         yHCxhv8IoWdzoZxCddk4DowxwCZLj0NUftIEHklYWgZiUFMAp0htEQ58b0UXFy9isg
         6Thk+EhHVLvCVVLQ+gshT1yuQN9PhXru8TYMVoPjze/GuQuiPx253vqk3WMQ1KN16G
         mddnXa3NGu8l65UL8dGyi3pMT5tLXKzJNsv1pXcG/SqMyhXcn6XS8o5QMtOl+0Eo2A
         giUspka+VN/Ww==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626145645.646136-1-krzysztof.kozlowski@linaro.org>
References: <20230626145645.646136-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam: require one of control
 methods
Message-Id: <168909384531.208679.1905953213881782947.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:14:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 26 Jun 2023 16:56:45 +0200, Krzysztof Kozlowski wrote:
> The BAM DMA resources can be controlled remotely (e.g. by trusted
> environment; needs qcom,powered-remotely or qcom,controlled-remotely
> properties) or locally.  In the latter case we need to provide its
> clock.
> 
> Require one of methods of such control to properly validate DTS.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: qcom,bam: require one of control methods
      commit: 213d8e122f2d9e2c9bdda6b804cf1082919bece3

Best regards,
-- 
~Vinod


