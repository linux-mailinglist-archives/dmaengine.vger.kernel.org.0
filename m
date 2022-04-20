Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DBA508591
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377525AbiDTKRv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbiDTKRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EACDFE;
        Wed, 20 Apr 2022 03:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB7F61767;
        Wed, 20 Apr 2022 10:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66BFC385A1;
        Wed, 20 Apr 2022 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650449690;
        bh=OtV0bJziajsXc61CjhTcvg895CG7yz/vfhesx5zRXUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtEphXr2XrkEmgSUXgenZQFPiC+ty0Wzze+C9Ys/WHcQjp0SEk4hwQJAcg3+6/5By
         sypFyMApr0XV4YUGPOc/VkOscGqZODh3ic9ZpOzgQCRXpHnB/eWgG75ed7n6G1yrmQ
         XD6tob4gLNKlE5Ybp4nNFcYezdkGykqWvgfBFfzkSUP2PRWmLFIc/k/H51YsE4r8Mz
         1owDXhyF7ws69EUz2CiRlokjvwbRNpdEbjyXk2iBiO7Xz7g/yM+JZeUwgfJiLdS+hH
         aaZ8zMOz0MDKdsHx7PeebuFx1ZBPP7onGrZdV5yjwc0DRTKr9qxGAWYlArubg8h1Gx
         rbXIiHJMtMWkw==
Date:   Wed, 20 Apr 2022 15:44:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH] dt-bindings: dmaengine: xilinx_dma: Add MCMDA channel ID
 index description
Message-ID: <Yl/dFrejkq2OspZZ@matsya>
References: <1649939061-6675-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649939061-6675-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-04-22, 17:54, Radhey Shyam Pandey wrote:
> MCDMA IP provides up to 16 multiple channels of data movement each on
> MM2S and S2MM paths. Inline with implementation, in the binding add
> description for the channel ID start index and mention that it's fixed
> irrespective of the MCDMA IP configuration(number of read/write channels).

Applied, thanks

-- 
~Vinod
