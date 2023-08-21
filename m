Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2DC782AEC
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjHUNwP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjHUNwK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFCF114;
        Mon, 21 Aug 2023 06:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F271A637D9;
        Mon, 21 Aug 2023 13:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DF2C433C7;
        Mon, 21 Aug 2023 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625923;
        bh=FNmuK1sgj624/zn4stTMHoktVRF83Jut32vM8m/P8BE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QiLllycgbMtH0tpb+jwPpG8uTEh0ijs9JEggsMmSDG4q4JZ91+NsIJ1jegtDtu7q/
         nzqgbUyPAmH5PIpfGpzTUVfF09LQ+pO0Mj3O65comTXNLZMrBrEN75Wk/B7RhzbiXl
         r4FGa39ec16CwIWHU/mAxUjzd7xO37OGQpPJbM1ixyNKI7ZLS55E6bmKbLspOndm17
         hC3qg5ITrx7lTBCxll5v9uICVQxwjXjK8AixFrrfgMv1rDofuoDf7jaZZfWBfQB7Lv
         TKywoudcSpFvjlX8SocpBO4ypDNECvPqf51poho7oI6PW/2fEVGN3Kz7L3laBcfBUG
         +S6NZxswI5f8Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230815072346.2798927-1-yajun.deng@linux.dev>
References: <20230815072346.2798927-1-yajun.deng@linux.dev>
Subject: Re: [PATCH] dmaengine: Simplify dma_async_device_register()
Message-Id: <169262592209.224153.5682663111349993321.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:02 +0530
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


On Tue, 15 Aug 2023 15:23:46 +0800, Yajun Deng wrote:
> There are a lot of duplicate codes for checking if the dma has some
> capability.
> 
> Define a temporary macro that is used to check if the dma claims some
> capability and if the corresponding function is implemented.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: Simplify dma_async_device_register()
      commit: 81ebed8aa2c213939a4670f508031a57d4ecbb70

Best regards,
-- 
~Vinod


