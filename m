Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE8671C3B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 13:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjARMgi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 07:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjARMfE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 07:35:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFDC530EA;
        Wed, 18 Jan 2023 03:59:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3261B81C66;
        Wed, 18 Jan 2023 11:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AB4C433F1;
        Wed, 18 Jan 2023 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674043149;
        bh=DXryLGgtuhYqmo2Hh7zk5xP7fKXA7sTKzjQ4V0b/sEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxq9MXqMK71ExRqFp6K4J3xnnU+5Z9Tz7MorYKaxNTCi1+hpR5ie4SQCXMK/EwzCC
         tpTYTz7XrNQ3dLuiIphS1vMln/Kr3Q0wj2umuHDlryrH8+dMAG4vsterIkguS3y6zy
         50In057kS4fA1wbDigxCjXB4nwWryCiKGBWnBLp1FYrQTl3KwKNHSFoSTdo1mU5VWC
         MoTCei8cba6gn+dDT4RGBgAc1DRlmSYy3I8iXyaYxenCLBn6NGA2BH98JR3OJc/rIM
         pMae84gXEc0o15hLHB4qF2DihHbvSvudFwyH9wUevpn4XKsCgEuuOgXJ++ZSsdRL6u
         FCeOUHxwoQWaw==
Date:   Wed, 18 Jan 2023 17:28:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Cc:     Eugeniy.Paltsev@synopsys.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaowu.ding@jaguarmicro.com
Subject: Re: [PATCH] Add exception protection processing for vd in
 axi_chan_handle_err function
Message-ID: <Y8feySvkvxFENnx9@matsya>
References: <20230112055802.1764-1-shawn.shao@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112055802.1764-1-shawn.shao@jaguarmicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-01-23, 13:58, Shawn.Shao wrote:
> Since there is no protection for vd, a kernel panic will be
> triggered here in exceptional cases.

Applied, thanks

-- 
~Vinod
