Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC07B820D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjJDOSJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjJDOSI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:18:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17900D8
        for <dmaengine@vger.kernel.org>; Wed,  4 Oct 2023 07:18:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60E3C433C7;
        Wed,  4 Oct 2023 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429083;
        bh=FXyD4+3x7n1w/N5HPg9oyroR/l6ChUK4+TneZiIAQ1A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ftrS7IFBfj7lVVYiFtuEX2d2au2R7G9WmYT/22RQMfd/LcR12pM3EV753FXzwmwpY
         n3WIYkHahIued0htqRyyGM+s0DkRj2XsL3yLfFnDoqbyEyGOt0M5Kp5s0r8Y/tKU3I
         KUPnXynloN0GJqdaUZqMLDwW3u4bC1Hi6I5ch+620eZJPiCQ2lgSqC0FS3xrsDSMpo
         soymYJ/IIb6XcBakT1fdcUMacnS5+J1LvX+anfEcAPDNVF1JmGHETNz2KH6chAKCG0
         lcDybhmSadgC7JjRFtaer2LEW8PhNKO6GNUdu24d7uGtjoxKVvDIYoL8em4a2FO7lu
         bPiw5/tjCb6Ng==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Rex Zhang <rex.zhang@intel.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com, lijun.pan@intel.com
In-Reply-To: <20230916060619.3744220-1-rex.zhang@intel.com>
References: <20230916060619.3744220-1-rex.zhang@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: use spin_lock_irqsave before
 wait_event_lock_irq
Message-Id: <169642908131.429977.17514836548285391443.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:48:01 +0530
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


On Sat, 16 Sep 2023 14:06:19 +0800, Rex Zhang wrote:
> In idxd_cmd_exec(), wait_event_lock_irq() explicitly calls
> spin_unlock_irq()/spin_lock_irq(). If the interrupt is on before entering
> wait_event_lock_irq(), it will become off status after
> wait_event_lock_irq() is called. Later, wait_for_completion() may go to
> sleep but irq is disabled. The scenario is warned in might_sleep().
> 
> Fix it by using spin_lock_irqsave() instead of the primitive spin_lock()
> to save the irq status before entering wait_event_lock_irq() and using
> spin_unlock_irqrestore() instead of the primitive spin_unlock() to restore
> the irq status before entering wait_for_completion().
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq
      commit: c0409dd3d151f661e7e57b901a81a02565df163c

Best regards,
-- 
~Vinod


