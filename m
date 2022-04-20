Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB571508759
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiDTLwI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiDTLwI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:52:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206041FBB;
        Wed, 20 Apr 2022 04:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECD26CE1D7A;
        Wed, 20 Apr 2022 11:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F999C385A1;
        Wed, 20 Apr 2022 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455359;
        bh=9NypnRFtmDHEIVYZtB9K0mzLsLVLYiYoDBvugKIf1ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2TEfjgVIL8TMywOaYsWvLmUDrMT2MoA+x3KcjIFu7ALui/D5hf/6IH1FKGknNg5h
         VsIRgxu3Wp7JXv/7YhTjWRF+Sk30OhFHBoygGEZHOAUoeA5FGiizpCCzw5k3cPiHyd
         FNUEpSDiqlOXhzRMpp3nB4fwm+pOtvg2b59j3KnJbawY3Lhbls+21VD874lj6g7C4Z
         NhE52wsZVGfmU1NLyW7rcfsFh/slHtqlf16duEAq9vO+PdqGP8/756pdMPrOzpmSkl
         T6yz9z9U1xVC6mFz/Gxrim8n/CKkkxcV6lFB3r3Ec82ZMx06UPUrUXw5jdeaDZL+9k
         LVuu65rVkypIg==
Date:   Wed, 20 Apr 2022 17:19:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] dmaengine: pl08x: drop the useless function
Message-ID: <Yl/zOxqlL+TFb27u@matsya>
References: <YlQ1i3DFqoFFFszO@matsya>
 <1649726180-13133-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649726180-13133-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-04-22, 09:16, Haowen Bai wrote:
> Unneeded variable: "retval". Return "NULL" , so we have to make code clear.
> better way, drop the function.

Applied, thanks

-- 
~Vinod
