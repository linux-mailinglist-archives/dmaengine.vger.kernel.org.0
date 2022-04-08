Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3254F9C1B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiDHR7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiDHR7j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 13:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB113C730
        for <dmaengine@vger.kernel.org>; Fri,  8 Apr 2022 10:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F58BB82CC7
        for <dmaengine@vger.kernel.org>; Fri,  8 Apr 2022 17:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3040CC385A3;
        Fri,  8 Apr 2022 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649440649;
        bh=K3GZSvBjcFi78ocYOTBtgsoc3V/9nhVRa6y2KLxPda8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUnuS5z7eWZ5qCKtmKf1Pmhmq53LuM/uEt7PODoNyDrG0AntS22QHIfwA3f9b+FUR
         M+ZcUR37qpb+aElxN+W8TYMTamBGaUtG/tB1pIX6k0tzaWRvCsnVDDIQSkd0CEi/VL
         a+Iz+Jcr7ESKibSLhKFb5Dv2kQMLrRBYJUKAn0ILecyl5h3fLxuFR3qIobdxVY5m/W
         YGd7Mcq6uqeq3cq6HqM50ec373VUeIroNsMvNcrXzm6+2QggmiVL5Z0JgDSkoCaCpZ
         NRl3g/OzFKDbt0fyTJCnrWFwe51gBc0fH5bFORzHGY+iqovTtBPO++rfrZRt7mrWX0
         XzIEY0i5X4vuw==
Date:   Fri, 8 Apr 2022 23:27:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tony Zhu <tony.zhu@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix device cleanup on disable
Message-ID: <YlB3hZUi2gvJ+IHP@matsya>
References: <164919561905.1455025.13542366389944678346.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164919561905.1455025.13542366389944678346.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-04-22, 14:53, Dave Jiang wrote:
> There are certain parts of WQ that needs to be cleaned up even after WQ is
> disabled during the device disable. Those are the unchangeable parts for a
> WQ when the device is still enabled. Move the cleanup outside of WQ state
> check. Remove idxd_wq_disable_cleanup() inside idxd_wq_device_reset_cleanup()
> since only the unchangeable parts need to be cleared.

Applied, thanks

-- 
~Vinod
