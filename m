Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061135AC54D
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiIDQLa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 12:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDQL3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 12:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443527CFB;
        Sun,  4 Sep 2022 09:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7026C60FB4;
        Sun,  4 Sep 2022 16:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75A6C433D6;
        Sun,  4 Sep 2022 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662307887;
        bh=W5jC5lmvoC0fwWqeCsAySo1juF+iQKGfgng0RMySoHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+/zyZ0ioCQrJo7u/MBCJT3iNdByo1hQ+oPdK2L4VKufZKA4PzLjzicxaX3U40FTh
         PAcTxxW7xl9GyI/BnQp1hda0q1ycDESaULr55EiAKE8NSskR5LBH5aLLDwvCrz1d/V
         VwBhjfOoDtUQkdOrn9VRzF4jAR5KrTXO4UXTt9QX+vXekkt4XGi12fpMSe3f3uBE8+
         0Jxu5MIgEdtvHUssi910gzzmwCv7v+OIRDzntoot4qEONfEUuii0qYHMGzn+s7vY4F
         m/EPcreQFytWp9vFz9x7EIS7cdJdLlk9uskD81Xcqd/dc2mSLMn+ek/+n9VpvbxmFW
         nj1+mi8YWC21g==
Date:   Sun, 4 Sep 2022 21:41:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: arm,pl330: Add missing 'iommus'
 property
Message-ID: <YxTOKpCm6uYVKLzL@matsya>
References: <20220801210237.1501488-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801210237.1501488-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-08-22, 15:02, Rob Herring wrote:
> The pl330 can be behind an IOMMU which is the case for Arm Juno board.
> Add the 'iommus' property allowing for 1 IOMMU entry per channel for
> writes and 1 IOMMU entry for reads.

Applied, thanks

-- 
~Vinod
