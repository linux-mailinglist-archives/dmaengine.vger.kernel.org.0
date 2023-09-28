Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C67B1B75
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjI1L4M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjI1L4L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED3121;
        Thu, 28 Sep 2023 04:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F42C433C8;
        Thu, 28 Sep 2023 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902168;
        bh=umejUMgPm7hQSvbguU7InU7vlny4ZXlUrT+SUg4am80=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LQxjzDxKmAunSYbhSXfaf8G9h8maUd7Vm9kKSXGi81quKnNNMwwUMg7KFXjC4+0ER
         F9zXfUPuINzcWexgEk4sQpY+UQrGIW53UAB+E8A1/ZmempRcxPKhWSGds63hRD7zvw
         I+J1Imy6BBF2SNNM8mfE9PgvoKD0hgr7yH0yBakj7RyC+NUuOelCo2qF3ADYSKknSJ
         o+pArb5hdWnqEg680LnVMyn8mN6bJjqKJWcjPT3EWS+bphDeaYfejAoxJSrKkr2HdM
         1m5LLsOb5adFKlwRtI+SHVSFJOkAIBveChAXMaFpFbo2MNxoB7blOUDvK1d3A2etww
         y1rW0rY06DZ7Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230924152332.2254305-1-j.neuschaefer@gmx.net>
References: <20230924152332.2254305-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH] dmaengine: hisi: Simplify preconditions of
 CONFIG_K3_DMA
Message-Id: <169590216593.152265.17257846354425757473.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sun, 24 Sep 2023 17:23:32 +0200, Jonathan Neuschäfer wrote:
> Commit e39a2329cfb09 ("Kconfig: Allow k3dma driver to be selected for
> more then HISI3xx platforms") expanded the "depends on" line of K3_DMA
> from "ARCH_HI3xxx" to "ARCH_HI3xxx || ARCH_HISI || COMPILE_TEST".
> However, ARCH_HI3xxx implies ARCH_HISI, so it's unnecessary to list
> both.
> 
> Instead, just list ARCH_HISI, which covers all HiSilicon platforms.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: hisi: Simplify preconditions of CONFIG_K3_DMA
      commit: 65b87548041ad70a8e26af08c0dda0b5893baf6b

Best regards,
-- 
~Vinod


