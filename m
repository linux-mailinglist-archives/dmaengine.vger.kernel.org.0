Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115666D1F93
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCaMAz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCaMAy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225641C1F3;
        Fri, 31 Mar 2023 05:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFF16285F;
        Fri, 31 Mar 2023 12:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8642FC433EF;
        Fri, 31 Mar 2023 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680264053;
        bh=4CHG5vt6TOeT/RE1wbudPDLGK5MgDBpoOTz3UbJbYOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeV9jIe22FxmRbvOeUgXXVKuRggzEesd+DQ9UQFQXru69pkajKdwvmbLhKDPt+fGh
         E5eBdMfX/9Sy6sa64UQhwLZ0hcO7O5meRlmAeLDjKyhfUCZYTf85yQPG0SLg+qsbXf
         hwOVTKGtvqvzU3rsoobqqNKx82AZG6YjycNUeXJ7CY1Q89zRi0t6I0Ckx0HbVfnP/m
         qzMHBlSYJ2iP/4wQTK3B1uBSbBcmJeVeTsUxybPZMKFTi+nPEn2hzEPMdNIvLejTQK
         JguuvXrYj1DQ35yh//OjKRLNEgmtJZmdKCjeCq7NV+Z6TJd1v7eBoV3kZ6yjEqwT59
         TBhcT1aTe+5iw==
Date:   Fri, 31 Mar 2023 17:30:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Remove unused
 rz_dmac_chan.*_word_size
Message-ID: <ZCbLcDXmLXM2X++X@matsya>
References: <021bdf56f1716276a55bcfb1ea81bba5f1d42b3d.1679910274.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021bdf56f1716276a55bcfb1ea81bba5f1d42b3d.1679910274.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-03-23, 11:48, Geert Uytterhoeven wrote:
> The src_word_size and dst_word_size members of the rz_dmac_chan
> structure were never used, so they can be removed.

Applied, thanks

-- 
~Vinod
