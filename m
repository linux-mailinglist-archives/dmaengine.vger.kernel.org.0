Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7374F5D2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGKQnu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjGKQnn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F871170E;
        Tue, 11 Jul 2023 09:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D195A61572;
        Tue, 11 Jul 2023 16:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAF1C433C8;
        Tue, 11 Jul 2023 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093817;
        bh=q9h+1MBbs2FB6CX9VNhbNseUSRhDWQ+jJkvsBWWcZhc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cDBUw8cww0H2OfIx2lYWi6nd7XTAiyT/v28qv4rb95MDvUBWtiiPLwH1BzkA+1zlm
         8ThHU4Fgjwc1n27T0YKgdUjOOGIOsBHVBJZ0DSFvOvKRuROVFYKx0ZrpWEiN8Pqp70
         mxycu8WlwOrJRaFB+ZQ21YYIPyQhc9sVI0zQXv+i1pQZVHP1TjseO21OwOt9a/p1CT
         /sgWwlZtb6FevU6QgxJW/MCXYqvFPiufK9fxcyVj4VtCgAlhiL5LVKCThCmeE2JIQf
         bcNeZ7p9OsQJyI76TsjVG6yZf4iihl2yzRlAyr7zUXB9Xn8MT9fowMAAxIJjV2U9fm
         7jW11eTP50B6g==
From:   Vinod Koul <vkoul@kernel.org>
To:     michal.simek@amd.com, Lizhi Hou <lizhi.hou@amd.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230705113912.16247-1-duminjie@vivo.com>
References: <20230705113912.16247-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] dmaengine: xilinx: xdma: Fix Judgment of the return
 value
Message-Id: <168909381412.208562.7215811041078101771.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:34 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 05 Jul 2023 19:39:12 +0800, Minjie Du wrote:
> Fix: make IS_ERR() judge the devm_ioremap_resource() function return.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: Fix Judgment of the return value
      commit: 625758896cc84ce0e5dc9842c34d4b9fa23b8b36

Best regards,
-- 
~Vinod


