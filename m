Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B527B820F
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbjJDOSM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjJDOSK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:18:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4896D7;
        Wed,  4 Oct 2023 07:18:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65EEC433C9;
        Wed,  4 Oct 2023 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429086;
        bh=1SSxbMRto1cv7K/OV22a+RO/1d1PaOeTe9kLraLmCug=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n2K5H+OVrCpg3TOSvk9GC531Wi9M+KZn6D8at5ZfZku8+V3KBicomrhMMHD/9ADI4
         Hl2WgLpo6VBJht8XBbWiVjXX9+rvyu40Hyaqr24P3RdBrGOA6TH9uNDz7aPr0w+pi1
         TlF+IrUSsIT7sjDk336bsuZsqI44BRogCP/YYePzQM4HhkWu95S0t7tsjf8IraW8Vt
         tsGwjG4hZSVyIYS6NpIFLf9NNJvZhsI1I0mT3Z9pjVyqHYRfAq220tYS/EiG+zQsOB
         5J+RF+gahYrcoTWziZG25qsOd+0ag4akGyWvzIgT/x9gRHujza9arHIOuAd34U9is0
         TcEZGLwUe3/NQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     sean.wang@mediatek.com, Duoming Zhou <duoming@zju.edu.cn>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230806032511.45263-1-duoming@zju.edu.cn>
References: <20230806032511.45263-1-duoming@zju.edu.cn>
Subject: Re: [PATCH] dmaengine: mediatek: Fix deadlock caused by
 synchronize_irq()
Message-Id: <169642908358.429977.8140374757545835839.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:48:03 +0530
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


On Sun, 06 Aug 2023 11:25:11 +0800, Duoming Zhou wrote:
> The synchronize_irq(c->irq) will not return until the IRQ handler
> mtk_uart_apdma_irq_handler() is completed. If the synchronize_irq()
> holds a spin_lock and waits the IRQ handler to complete, but the
> IRQ handler also needs the same spin_lock. The deadlock will happen.
> The process is shown below:
> 
>           cpu0                        cpu1
> mtk_uart_apdma_device_pause() | mtk_uart_apdma_irq_handler()
>   spin_lock_irqsave()         |
>                               |   spin_lock_irqsave()
>   //hold the lock to wait     |
>   synchronize_irq()           |
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mediatek: Fix deadlock caused by synchronize_irq()
      commit: 01f1ae2733e2bb4de92fefcea5fda847d92aede1

Best regards,
-- 
~Vinod


