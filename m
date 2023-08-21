Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9027782AE2
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjHUNv7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjHUNv7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747AE8;
        Mon, 21 Aug 2023 06:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF7EA634B8;
        Mon, 21 Aug 2023 13:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE4DC433C9;
        Mon, 21 Aug 2023 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625914;
        bh=Ij1Fky1SzjNGU19dxA9VEMP/m+IgopJUmHpYOQtDxZk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NYdogs3jbqTRkOYTYeZW38QExUCqBvCA+ZyJaiEMrZb5K31onx0mb1UBwO5k5IVwP
         IT6qGW3XAth0Kw2j7EAxjLdnDge2Fi1kZysQJsY6uOEhaat8e89GmMAkYqEyAoVFIQ
         sB9BXEKd1hsXJHJGI733yUgpFnL76W7eeSVXnaXZOIJRG4n2Pi1NZIGCN75+l7tFwi
         YHmZ3+u05XVjzC3VgkXFZ5XuyOYaSviUHhfGYk+MtIak1VHu2GfHwzwVTTiKSHTD27
         hfC4QD6EEEdsz8KWx10/OH+hsePhIQrUJz0rhht3NcG+XiT/agnD2DSL/wFbAdDnAP
         fsq3YFYa4VdUA==
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230816-void-drivers-dma-owl-dma-v1-1-a0a5e085e937@google.com>
References: <20230816-void-drivers-dma-owl-dma-v1-1-a0a5e085e937@google.com>
Subject: Re: [PATCH] dmaengine: owl-dma: fix clang
 -Wvoid-pointer-to-enum-cast warning
Message-Id: <169262591106.224153.11282362277012403845.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:21:51 +0530
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


On Wed, 16 Aug 2023 20:12:50 +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/dma/owl-dma.c:1119:14: warning: cast to smaller integer type
> |       'enum owl_dma_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |        1119 | od->devid = (enum owl_dma_id)of_device_get_match_data(&pdev->dev);
> 
> This is due to the fact that `of_device_get_match_data()` returns a
> void* while `enum owl_dma_id` has the size of an int.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: owl-dma: fix clang -Wvoid-pointer-to-enum-cast warning
      commit: 1fbda5f4c7c1c8bd51cd3bc3d2ff19176c696b74

Best regards,
-- 
~Vinod


