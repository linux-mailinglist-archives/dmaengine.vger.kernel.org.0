Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761B7C017A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjJJQVL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJJQVK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 12:21:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E98E;
        Tue, 10 Oct 2023 09:21:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60CAC433C7;
        Tue, 10 Oct 2023 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954868;
        bh=AbYACsFpW/kkxdoM2rLrN81FheyXlXCz2ZwahMt1rDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWg1QYQTVuWLt7aWSi0f4bHdpASD1VwnZQgoXsIphm7L+veLhRXR/F2N5OZPGPmJ4
         4w4SNb5TU1uCBownhL/bkX6LEbbRWhHe8gjJXCEm3zxQhBCoTgvjdLhHTGVFxlNHC3
         j+UWh2TpmROCZQBGczKNlHqO86kkKCexwWK6ZDlo74mJplU+h2HJNvOZdiUp931wAa
         2TR+qoK54KT/eeB6bbPhcDsc5jFjNVURMsaRAXundJNJ+hfo1gM/dHusqqU8y6KSvv
         KE2CeuE8yLBkkhnQkgjajC0zms25DOGvZEdBi+EiG3OAHHFbdhXijAI+Og4NyGt4Jk
         PZKe1ft5Lu5tA==
Received: (nullmailer pid 1005366 invoked by uid 1000);
        Tue, 10 Oct 2023 16:21:06 -0000
Date:   Tue, 10 Oct 2023 11:21:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-tegra@vger.kernel.org, vkoul@kernel.org, ldewangan@nvidia.com
Subject: Re: [PATCH V1 1/2] dt-bindings: dma: Add dma-channel-mask to
 nvidia,tegra210-adma
Message-ID: <169695486646.1005310.17540883158492688989.robh@kernel.org>
References: <20231009063509.2269-1-mkumard@nvidia.com>
 <20231009063509.2269-2-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009063509.2269-2-mkumard@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 09 Oct 2023 12:05:08 +0530, Mohan Kumar wrote:
> - Add dma-channel-mask binding doc support to nvidia,tegra210-adma
> to reserve the adma channel usage
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

