Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1F782ADF
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjHUNv6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjHUNv6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1111F4;
        Mon, 21 Aug 2023 06:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6622763683;
        Mon, 21 Aug 2023 13:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65268C433C7;
        Mon, 21 Aug 2023 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625910;
        bh=Hbyy/W/jZVSIZxz8hNREGg+bVQgyuozT2jp1B0cXH+Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eFiw57LmaUvaM6Bt8/edvk6BDN/rgzxkOC5o3Fmj04MgsZnI9TZe2KXNAszc4C60q
         sobTAbSUEHhEQquw9MyFewxooGaaKZrT+DZCQSPgefUEO9NfzZGpT/jJ9Ddq6Hw+Zd
         mYsmKTV4wDw1PetF4N5XaVMTBMa7ykBv4/bPl2UmXO3ibFsEdLk7djrhRhgKfHp4hj
         dijpHxGzBy56PfiwI1kxXstswgXfPt3ukv9mF7B/nVur/8oW0ZjlTanVtN/hxpa8g5
         cfNKN2vDHvLFhgxdgjAh2S0tfJPwEzZQETsGN0dMAceVXKVOb32lqQSUD2xtjcIslW
         J3k9AGTOCVFjw==
From:   Vinod Koul <vkoul@kernel.org>
To:     fenghua.yu@intel.com, dave.jiang@intel.com,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230817114135.50264-1-yuehaibing@huawei.com>
References: <20230817114135.50264-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Remove unused declarations
Message-Id: <169262590904.224153.1527521964317716805.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:21:49 +0530
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


On Thu, 17 Aug 2023 19:41:35 +0800, Yue Haibing wrote:
> Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
> removed idxd_{un}register_driver() definitions but not the declarations.
> Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
> declared idxd_{un}register_idxd_drv() but never implemented it.
> Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine
> subsystem") declared idxd_parse_completion_status() but never implemented
> it.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Remove unused declarations
      commit: 3c935af7a8e5db7f59d65fad86add19fe558bb29

Best regards,
-- 
~Vinod


