Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358BD54439C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiFIGNv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiFIGNt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DACF4F1DE;
        Wed,  8 Jun 2022 23:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DD661D74;
        Thu,  9 Jun 2022 06:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E5C34114;
        Thu,  9 Jun 2022 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654755228;
        bh=KpbKefK6ourzxUYXVZVV51lWHAtairn5SiaPPLGL4XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmi7VywKK0YV/ABDhuODaZ56uzrABqn60IB+DgTjgZvH0FT2xzAStJ/0xHW88V1Ud
         cPKF2MlwBeaVwIJnF3hCdj7r4XYjTz9xyoTVmlpwDwoJQ5kFAkfCCtsQ1rbySsIvCU
         3sxhArExEDmCZ5fUeSJa7PX3byNNqB2cTEI+57vTydMHZ1IMXZl867UjsMdJmA5g6o
         wKEylaD5ryrYZBwhBloXa69bDly2RZD9th/aB7oZbFlYW9UknAAA7LYfVu7tfPNpzp
         jDaq+y2cimaqIqutnyz9yQ6bZd64eSQ9ljZHa0xo7BOqafUC6x+uVcT/9uRffLKqZ2
         vx1bKmIomhZrg==
Date:   Thu, 9 Jun 2022 11:43:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: Rewrite ST-Ericsson DMA40 to YAML
Message-ID: <YqGPl0vKLTn+QFT6@matsya>
References: <20220527215508.622374-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527215508.622374-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-22, 23:55, Linus Walleij wrote:
> This rewrites the ST-Ericsson DMA40 bindings in YAML.

Applied, thanks

-- 
~Vinod
