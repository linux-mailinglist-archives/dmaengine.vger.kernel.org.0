Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D55EFAA2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiI2Qcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2Qcr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E514FE13;
        Thu, 29 Sep 2022 09:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3412FB82366;
        Thu, 29 Sep 2022 16:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0165CC433C1;
        Thu, 29 Sep 2022 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469164;
        bh=VIMjoNsZ1R5bxmbTVz9djnw60i0Rvm/58ieLtVcVJbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwhBgkLROAitAXTogrkNO7oUdZbfUQ7tY9b3mSgyzXcJSR7S6XwoNEqC1gQXm9i0V
         UuSWa/vjkkqaocAt4JRr+iZSBKtmkOGvL7q+AywjBewLdIsHnfWcUvXodinTENqN0M
         DMceY6ck/NB8AzIkyvfwRVqROe3oLnaz1DLZ0UD5rT0pGQcAftm8ACN1R4/o9bYleR
         rvz8D3NdPwxhc9zYjlwyVs5QpoCfEnTLSgzvzjOI8fJ+xIijpjoBEWXEjgNOEvnRuQ
         KHy9wjTPLIEB4LWhUuZlEY9W3SJ+a0n7Snk+oypw/nYt4oQiuwCobCSY5mU5QoAdJK
         4mZepHI6gtNvg==
Date:   Thu, 29 Sep 2022 22:02:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
Message-ID: <YzXIpzwMOWSpPkuq@matsya>
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914140426.7609-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-22, 16:04, Christian Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.

Applied, thanks

-- 
~Vinod
