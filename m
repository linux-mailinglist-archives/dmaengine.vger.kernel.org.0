Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5465ACA87
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiIEGWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiIEGWp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5F2F037;
        Sun,  4 Sep 2022 23:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C17610D5;
        Mon,  5 Sep 2022 06:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2F3C433D6;
        Mon,  5 Sep 2022 06:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662358962;
        bh=2xEEEZ6CvZ2nPWQv0CH8VGu41ZEdxLRb0MFZrH6xB9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXAY+hPd+TfFiORWRJpzFbPmU6WnRKDF1N6azgqAaGu98WPoaz/pr9QFxDTtFCMWs
         J7DbZpTQ8qvOKbwHzWxNbbW1Oou9sKL0y5fT7fK/czQb40GsDIV810rGIEJ1KBich3
         vgdGsRmKxokxvV6+YmhIy6kmuLbMKCov58sITx118tNr23wskb8nlHb5D7/qidk/no
         BbJ74kkiupfZwMEWes000RhVq4PgaNOTDsSO0pbKUyxc1MPUip3EOBrJa2BJBHK925
         Awg6jtVGUuapXDRfDkGsiuTlN+31TaA6zlnTonWEN4o8Q9zJT43BfS1F0QfmcAF2s7
         1i9V5zHp/jqrg==
Date:   Mon, 5 Sep 2022 11:52:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: stm32-dmamux: Simplify code and save a few
 bytes of memory
Message-ID: <YxWVrphgXmqmsCH2@matsya>
References: <2d8c24359b2daa32ce0597a2949b7b2bebaf23de.1659211633.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8c24359b2daa32ce0597a2949b7b2bebaf23de.1659211633.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-22, 22:07, Christophe JAILLET wrote:
> STM32_DMAMUX_MAX_DMA_REQUESTS is small (i.e. 32) and when the 'dma_inuse'
> bitmap is allocated, there is already a check that 'dma_req' is <= this
> limit.
> 
> So, there is no good reason to dynamically allocate this bitmap. This
> just waste some memory and some cycles.
> 
> Use DECLARE_BITMAP with the maximum bitmap size instead.

Applied, thanks

-- 
~Vinod
