Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF306DFC93
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDLRVV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDLRVV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB9103;
        Wed, 12 Apr 2023 10:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B22D16114C;
        Wed, 12 Apr 2023 17:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58756C433D2;
        Wed, 12 Apr 2023 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320079;
        bh=COLmtFFFGXo1TEHuoUhMSoBFRy+/CMiAjqIRNHb1FSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxw94zsuuI49tRofTO5ZzeKeONQqQBjSsxu9lKNJNtRtbOU+C/XKrMP/1+fbEVfa1
         SONEudEhTB/64a9pPpan0kJ8PWfLMYWgwQzuhRPzFgNhJcIauaJcx8TomwxkqShv0y
         2Cg7eDvM87lkAagRyKQ3TZ/C4+UquWyBvqCTJJWyAfM1CNOMnmHw5CT23dB5/ymKnT
         pSCLiUvMnP+oZx1j0eA1xXYXVWnmJwpZOOsgi5SnV2ddJCKJucA/2l0Ts64FAt+bTu
         PkfzJeZoBjKHDaBB1lkQkF06cbDVCQngPHFXBNRHtXE8icXcY31tEl+tQdgd58BSVx
         WSDfYA3yuizDA==
Date:   Wed, 12 Apr 2023 22:51:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: dma: Drop unneeded quotes
Message-ID: <ZDboi8vByBkrziF3@matsya>
References: <20230331182141.1900348-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331182141.1900348-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-03-23, 13:21, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.

Applied, thanks

-- 
~Vinod
