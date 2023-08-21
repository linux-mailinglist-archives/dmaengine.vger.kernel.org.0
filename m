Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC2782AE4
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjHUNwD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjHUNwB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605CF3;
        Mon, 21 Aug 2023 06:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E90B61E72;
        Mon, 21 Aug 2023 13:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02B8C433C8;
        Mon, 21 Aug 2023 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625917;
        bh=Oii6ZWL2DJswaewz/N9ajHM6DX4Q1SQAhJWTcxJBbh8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=MRawBO5SbdSQoXQ1tTYL0sxhsed22on3u1+I1Mt89wH9HxDf2gPdEVKx3KGO9G1ZN
         sEy/fth1MXeQa2fC/NGIwRR/CD3CwbZOkSaHJ/5jzzYTJQcpeBnkcz7ivw0jWcj9Lp
         vBOcLRbRaj5EDyOAvFXfwaHP8WtE94pWpF0exE5vQoMv/mn/O0b8QNXtPo7zFOZpG9
         u77qBxtNIngE2dzhdvUifD9jMwzVl1Wc2F+Uz+aXQoaCZRyrfLa0cIeZstHk2KUINU
         Eg3WXUg15hzez3aG3Dbcup/jJc1BlTNXAy8ClDar9nXkRi11Y6SvYLhH3EGlbfGhxU
         TozyRGLOrqFIA==
From:   Vinod Koul <vkoul@kernel.org>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, srinidhi.kasagar@stericsson.com,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230724144108.2582917-1-ruanjinjie@huawei.com>
References: <20230724144108.2582917-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] dmaengine: ste_dma40: Add missing IRQ check in
 d40_probe
Message-Id: <169262591454.224153.953781278570181769.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:21:54 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 24 Jul 2023 14:41:08 +0000, Ruan Jinjie wrote:
> Check for the return value of platform_get_irq(): if no interrupt
> is specified, it wouldn't make sense to call request_irq().
> 
> 

Applied, thanks!

[1/1] dmaengine: ste_dma40: Add missing IRQ check in d40_probe
      commit: c05ce6907b3d6e148b70f0bb5eafd61dcef1ddc1

Best regards,
-- 
~Vinod


