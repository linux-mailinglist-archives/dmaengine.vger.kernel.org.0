Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54937BD322
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjJIGNB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345281AbjJIGMx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DAB19A;
        Sun,  8 Oct 2023 23:12:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF099C433C7;
        Mon,  9 Oct 2023 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831965;
        bh=pr62u0HW5qHE5IfyIwY45eVMSzu8gGNd0sGs/Czofh0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oNC7XF+ga8uAh3riG1zWmtrO85qn71Bsm5NQSb8p1UHavfUTVMZ1nWhhKALc2ZbWy
         XTKi9EieAy7xIj59nFY2Irgu6wu3byY8qIG2sfmHh0x3owJc00UKaaxjKTAw2GC4dA
         wgu0fX93nuqjV4eDifrOpbDF+EEswLSRw4xgafvzEslrXH1qu7g8/dt8duxvIirz6r
         i49ebfw0lXJdwoZWLxaghLbGZCwnHdLUrhrc8izMgW74WjlCPvwtY0kNZs3xpKClHs
         6c5DMJbp0hZpXs/qOkSNn8dRoSGWO7jqTgaWqwxBThzJocf4YPCiIBWYBdhOjBLWLr
         9qDJcPMXk7s2Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     linus.walleij@linaro.org, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
References: <tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com>
Subject: Re: [PATCH] maengine: ste_dma40: Fix PM disable depth imbalance in
 d40_probe
Message-Id: <169683196340.44135.12495750353784272955.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 05 Oct 2023 22:28:35 +0800, Zhang Shurong wrote:
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context.
> We fix it by calling pm_runtime_disable when error returns.
> 
> 

Applied, thanks!

[1/1] maengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
      commit: 0618c077a8c20e8c81e367988f70f7e32bb5a717

Best regards,
-- 
~Vinod


