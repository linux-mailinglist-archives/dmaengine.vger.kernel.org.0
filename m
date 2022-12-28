Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2556575DB
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiL1LVa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiL1LV1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:21:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6256551;
        Wed, 28 Dec 2022 03:21:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94D26147E;
        Wed, 28 Dec 2022 11:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BF8C433EF;
        Wed, 28 Dec 2022 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672226484;
        bh=7VDVSjJz7fwDRzpFrg/WXlhpt4VMyN0RmTyPNSQuJcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL/K2SyIl72nFSLBS7XUIpOpDfkK/AftGjx6EkH2AZZuK8+UpIaHZ1XXGohhzWXfT
         twMm4QznBIZ0nEgwxK9Mq49xILUV41Mlv/j7qBd11H5DpMV3LQ5XNORJ9XS/m5pcHM
         ATwfDccFnSFOGA+RhSXB79dyDuWLuw98+t5FMYAvt0kQsUJdYZAhsgl1yawcKuTauk
         kTGJMXK/QRuRCVyeXZiYJ98Zn+2E5Xjb8eEXolGSUEeHyM8pWbGBDhJNQhGbpPFKcr
         gkI12Vk/8xiRVuB1xyw2VqRrxjUCzRXcLC0DkJjZPMZXCTt4G9egtLwEY/+8tbevLV
         PzOnQ3yrgdz2Q==
Date:   Wed, 28 Dec 2022 16:51:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom: gpi: add compatible for sm8550
Message-ID: <Y6wmr5f+c9TX4g+r@matsya>
References: <20221114-narmstrong-sm8550-upstream-gpi-v1-0-33b28a227c5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114-narmstrong-sm8550-upstream-gpi-v1-0-33b28a227c5d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-11-22, 11:13, Neil Armstrong wrote:
> The Qualcomm SM8550 uses GPI DMA for its GENI interface. Add a compatible
> string for it in the documentation by using the SM6350 as fallback.

Applied, thanks

-- 
~Vinod
