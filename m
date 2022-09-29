Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336435EF991
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiI2Py6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiI2Py5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 11:54:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE5356F4;
        Thu, 29 Sep 2022 08:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49124B8250D;
        Thu, 29 Sep 2022 15:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55446C433D6;
        Thu, 29 Sep 2022 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466892;
        bh=/PN4K3EjRMmVp85rxA2QdctvwZGPI/Gy/GPbtyFC3eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO/v8rpQqzlHJzW1/MrkFeXBijGRlHtcXeqhRdpscRI7lufMIX2baOTlz24LbsWWE
         G7Q6H6OALHZH9FPxh9O37NPiW6vLwPhpGA3h7wsMy3BSIHBZirhGZaOGkqaY1C29NG
         dlCuE1LvhDBmMieaDGJQeZA5VPnJO5xyuURbxeE8dMt5m9iOT5XwDlRuMd/JYmXpM0
         o0IDXFgWOIvr/GkRjW+2yeYLZdtKpkKECBAsP4rxKMKAjithDLflUS1z1h6sPn7BpJ
         WAYUCxQ7eDbkvlHkSFI3p8rxniA4dQKz6v5O57WRu2kyDi3Pj0IpZF2FH5AamM4aVL
         xK2tGhVJTZs+w==
Date:   Thu, 29 Sep 2022 21:24:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        agross@kernel.org, dmaengine@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: Make minor fixes to qcom,bam-dma
 binding doc
Message-ID: <YzW/yOuokAJjxFHb@matsya>
References: <20220926112200.1948080-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926112200.1948080-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-22, 16:52, Bhupesh Sharma wrote:
> As a user recently noted, the qcom,bam-dma binding document
> describes the msm8974 BAM DMA node in the 'example section'
> incorrectly. Fix the same by making it consistent with the node
> present inside 'qcom-msm8974' dts file, namely the 'reg' and
> 'interrupt' values which are incorrect in the 'example section'.
> 
> While at it also make two additioanal minor cleanups:
>  - mention Bjorn's new email ID in the document, and
>  - add SDM845 in the comment line for the SoCs on which
>    qcom,bam-v1.7.0 version is supported.

Applied, thanks

> 
> Fixes: 4f46cc1b88b3 ("dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format")

Dropped this

-- 
~Vinod
