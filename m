Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2D69180A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 06:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBJFno (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 00:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjBJFnn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 00:43:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28566F8D;
        Thu,  9 Feb 2023 21:43:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1550B82364;
        Fri, 10 Feb 2023 05:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C73FC433D2;
        Fri, 10 Feb 2023 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676007811;
        bh=We6VTPEaf2ZWk5YAWUJDnW7K4x0IxSj2NkmnMga+bJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isNSxfyD3Vj1xR9AUxSGdSoqc8bif+ySfxe8nJXhymhyMC8ykzibbe2o3Q0AcPWhs
         p0m4Z+zquHwWfjx5Thl0SeQsLjrHhjTJYa/hXFx36oPO+rFnGihHfAoR2AEKovSlNe
         Cp2dG7xfiNIgLNutbW1Cvpxe+7x9osPw/XIThbHZzc6MqtunlCbpwIdWckQ36PChZJ
         eMg87T/rAXOdDHxiwbY8n6BptVjhL+vAEL4mSQ1T/Zx9OjQ83jHWq+6q18lb0AeXD3
         bY5LA3OVQYZEazs8i3CTubH/JTiEtUOBFM/j6JdDgap2RPyU9ecFZg09JYnqoD++6k
         ogd98nDU5/oEg==
Date:   Fri, 10 Feb 2023 11:13:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     neil.armstrong@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Message-ID: <Y+XZflMj82Ot/UzW@matsya>
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
 <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
 <a8112f61-f8d3-c1e0-9549-a9036a7e7894@linaro.org>
 <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
 <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
 <0f16d63f-3bb0-54aa-bcb4-4c666d4b2846@linaro.org>
 <32153a4b-9974-a42a-ef30-c0bd8cbc732b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32153a4b-9974-a42a-ef30-c0bd8cbc732b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-02-23, 13:55, Bhupesh Sharma wrote:
> On 2/8/23 2:38 PM, neil.armstrong@linaro.org wrote:
> > On 08/02/2023 10:03, Krzysztof Kozlowski wrote:

> > > What I don't really get is that crypto driver sets bandwidth for
> > > interconnects, not the BAM. Why BAM needs interconnect? Usually you do
> > > not need to initialize some middle paths. Getting the final interconnect
> > > path (e.g. crypto-memory) is enough, because it includes everything in
> > > between.
> > 
> > Indeed the interconnect on BAM may be redundant since QCE sets the BW,
> > I'll investigate to understand if it's also necessary on BAM.
> 
> Since we are already doing this via QCE driver (since crypto block on qcom
> SoCs employs BAM DMA services) via [1], this change is not needed for
> sm8150, sm8250, sm8350 and subsequent qcom SoCs (available presently), so
> this patch can be dropped.

Is that the right approach, should the dma consumers request the
bandwidth or the dma driver. I am kind of leaning on the former

-- 
~Vinod
