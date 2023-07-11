Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98674F5F0
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjGKQpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjGKQo7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A442707
        for <dmaengine@vger.kernel.org>; Tue, 11 Jul 2023 09:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9267E61576
        for <dmaengine@vger.kernel.org>; Tue, 11 Jul 2023 16:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE39C433C8;
        Tue, 11 Jul 2023 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093855;
        bh=zUK4Bz85GB2kJ/pM9JLqm311bvnmZgNJhxzEjC9W8Nc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KOAaTNfJcmx/8+15mzAtkOHJ9CvKoWY8Chkfcn+KH4W4tUKblechAm1IeZiNmeJek
         uSxiL0SRA0OoppbBiaX+RvTl6NkieyLu7R+93Sf6Dz6YMt8xJuQuEL95RZIKldAFbq
         3W5QS9yxS66yt7n5EKTSBLjmf26WCWbqfr9D3WXTeKn11CE3tuaO9xGCbvt+o/gBRq
         i0eQL0EF8qjWGiDeGwkVyfgiFGlqf6+6pZes+1sz4sZH0ordu0zF9iKvo/Xg4rymxB
         brsFHzh3pNk86n8g6ZYrJfyN12IxcMM1styeBav9PyQJMkmer3bjfj/Cl1H3QcR0g/
         gAN/c+YIkkaNA==
From:   Vinod Koul <vkoul@kernel.org>
To:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, rex.zhang@intel.com
Cc:     ramesh.thomas@intel.com, tony.zhu@intel.com
In-Reply-To: <20230614062706.1743078-1-rex.zhang@intel.com>
References: <20230614062706.1743078-1-rex.zhang@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Modify the dependence of
 attribute pasid_enabled
Message-Id: <168909385271.208679.13994148292007476149.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:14:12 +0530
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


On Wed, 14 Jun 2023 14:27:06 +0800, rex.zhang@intel.com wrote:
> Kernel PASID and user PASID are separately enabled. User needs to know the
> user PASID enabling status to decide how to use IDXD device in user space.
> This is done via the attribute /sys/bus/dsa/devices/dsa0/pasid_enabled.
> It's unnecessary for user to know the kernel PASID enabling status because
> user won't use the kernel PASID. But instead of showing the user PASID
> enabling status, the attribute shows the kernel PASID enabling status. Fix
> the issue by showing the user PASID enabling status in the attribute.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: idxd: Modify the dependence of attribute pasid_enabled
      commit: 04589e93537d27cb846e4156e614e5c73601e8ab

Best regards,
-- 
~Vinod


