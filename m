Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C95ACA8A
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiIEG0U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIEG0U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819031FCD0;
        Sun,  4 Sep 2022 23:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103F4610E7;
        Mon,  5 Sep 2022 06:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AC6C433C1;
        Mon,  5 Sep 2022 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359178;
        bh=J1sCmTfRKxfRS9ujjevBR+nlz4HWtgOOY/mt28Ykx6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWjPF9CaSUoZyPXSvZwwJ6pjjt5WB/EVtodn2Jstkug5qqUwE9OhtlxvptEmvQEzA
         P9dBlkErQI6ySB/jL3ZFLjcChBOcMz0C+EW+KN6jcp6+bDau3HrayXk5zNMYfzr1Fs
         g6v/ix7n7vxTTPxma7QpfjTUYDCoYUqUIVpCmTe57/Iet75fyR8EcY93Htw3rt13d5
         LgifdOyyw/O9XtMcU1dodz00hufbkcvI34XEYSA1JyQFUW5A3kXzuXrfQCBSCa+qzP
         eMt2GPufO2KbDkf87ADdXMiFbc1PX4d8oCYP0FUPSSjRs9+58ATFe6XXBDzPcypgDy
         MJ294qb9H4J3A==
Date:   Mon, 5 Sep 2022 11:56:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     michal.simek@xilinx.com, m.tretter@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Typecast with enum to fix the
 coverity warning
Message-ID: <YxWWhov7bjz2J+Ur@matsya>
References: <1653378553-28548-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653378553-28548-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-05-22, 13:19, Radhey Shyam Pandey wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Typecast the flags variable with (enum dma_ctrl_flags) in
> zynqmp_dma_prep_memcpy function to fix the coverity warning.

Applied, thanks

> 
> Addresses-Coverity: Event mixed_enum_type.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> NOTE- This patch was sent to dmaengine mailing list[1] and
> there was a suggestion from Michael Tretter to change the
> signature of the dmaengine_prep_dma_memcpy() engine to accept
> "enum dma_ctrl_flags flags" instead of "unsigned long flags".
> 
> All device_prep_dma_* API variants have ulong flags argument.
> So this is a wider question if we want to change these APIs?
> Also there are existing users of these public APIs.

It would be very nice to do this change but users would need to be
updated as well, patches are welcome

-- 
~Vinod
