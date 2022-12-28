Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E365734C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiL1GgS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiL1GgM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:36:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C3DFFB;
        Tue, 27 Dec 2022 22:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243B96133F;
        Wed, 28 Dec 2022 06:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9391FC433F0;
        Wed, 28 Dec 2022 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672209370;
        bh=v9yQ7vc1cPOwucqe8gCK8yAT3tD8dhyrCM2k/G07bYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wvds9c2WOeqOuTAWsyFZKiPDUcgkbnWGw/Elmmh2TsxBrY7LaoE3AAaVV71FW+1TU
         psTNClULxcKQm464OOw5QRUZfjNUy6wywLBaLVxnTIVkJn73R+q3KvCe/IH3ahX9t2
         I5k3ia/hiRgftlqUhDPytLLaIAei3tmk2lpRQhq/w7gTL76LvYvd43hrIgQLZFK/7T
         5On44exOM3jxGtpjI1SCEpaDa1ecfNi9C2Q5k/FMx5nHm5wA973DBJ3pVs2Kbk3FGR
         PEYcMzx+EoDFHh+NXufs8Mr1/PwY/0aFcUG2Q+LAbDCM8HTSP+HllFix8vazwiM8na
         jLeU05AiSj2OA==
Date:   Wed, 28 Dec 2022 12:06:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: dmaengine: qcom: gpi: Add
 QDU1000/QRU1000 gpi device
Message-ID: <Y6vj1WGmmjFlbpkg@matsya>
References: <20221216231513.25085-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216231513.25085-1-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-22, 15:15, Melody Olvera wrote:
> Add compatible for gpi on QDU1000 and QRU1000 SoCs.

Applied, thanks

-- 
~Vinod
