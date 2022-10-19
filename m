Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2760497E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJSOlW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJSOlB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:41:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A7118F25B
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 07:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 327ABB8218D
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 14:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE1BC433D6;
        Wed, 19 Oct 2022 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666189570;
        bh=AgWElP4HVXsEUDE9aq8TfhhY0IF2ldCtThvBeZtA1pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=taXnet5Xmq8nzmpUeInUJeoKQdKYzMmBg5KAtqvYqUU+0on7cKwfDT9an1861X2jk
         dEGFcuceJnwZgnos67PGT4t/GNb/r0Y2qQouMs0acUvCFQ60PD4JzYXRwzK1twNznZ
         dALfy+XvnBPvky56XdM8gBVSbrzNeK+Wlvhun2qiuawRowBIlRSnSBZx4CCIVU95vZ
         rBmxE/keaFGICkIHjk0tODkz0ajRntHOY5t46Zv4SbsyxgXFSC53pnmspOxOU1XdpL
         Q72r+P0FdBdzJYKANhY1agEehgGWPacrsv7EM37jy+jsmwrEoVD4PQDaIv9TBZcvgd
         E4xnnpPF15gow==
Date:   Wed, 19 Oct 2022 19:56:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pxa_dma: use platform_get_irq_optional
Message-ID: <Y1AI/g49R1hHznv+@matsya>
References: <20220906000709.52705-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906000709.52705-1-doug@schmorgal.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-22, 17:07, Doug Brown wrote:
> The first IRQ is required, but IRQs 1 through (nb_phy_chans - 1) are
> optional, because on some platforms (e.g. PXA168) there is a single IRQ
> shared between all channels.
> 
> This change inhibits a flood of "IRQ index # not found" messages at
> startup. Tested on a PXA168-based device.

Applied, thanks

-- 
~Vinod
