Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7383F508615
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiDTKj7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiDTKj6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA93FBEF;
        Wed, 20 Apr 2022 03:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32130617B3;
        Wed, 20 Apr 2022 10:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6ABC385A0;
        Wed, 20 Apr 2022 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650451032;
        bh=n2/KXZViQ7g32t2KOrz2MRwdeYqVUXZJ0RBtcu4P010=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGHzw0S6lHf6P/MyoCpiQR/W1FvqbcvkEu4DixWFSJ05D8C++rtG4rJXVnyc4gj4A
         WRBe1sErB2pSTYKeZUjh5iCPn5laOBgT7q0PrXKQIv7b5i1Sgn2skSohvtTm/YuC2I
         rh8Ig/VKWJYDNGAKU751nKBwRcn0m1a7DS+HKvYBFvXXPcA2Ke8Uxa5b00b6R32aAf
         bxL43k4kE3A9r5mwPtyE8B5u4TcDCCs5R9Pifa7D1kxqyJC2rA1/1gh3DSPT4K6NY9
         vsWpJ23QPgvHNp8hEDog+T3K34HTC23aogmCTZXvX4o8zyCzrvEj2T8qulA/pS5tYI
         ZpoAi/A7XcuLg==
Date:   Wed, 20 Apr 2022 16:07:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: add compatible for
 sc7280
Message-ID: <Yl/iVLa0YDkUgNC6@matsya>
References: <20220414064216.1182177-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414064216.1182177-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-04-22, 12:12, Vinod Koul wrote:
> Document the compatible for GPI DMA controller on SC7280 SoC

Applied, thanks

-- 
~Vinod
