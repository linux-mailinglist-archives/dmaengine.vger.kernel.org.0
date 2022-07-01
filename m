Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8365637A8
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGAQTk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGAQTk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F63B023
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 09:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B25F6252B
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 16:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40CEC3411E;
        Fri,  1 Jul 2022 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656692378;
        bh=fiUS8VHseqWY2zMvVqaBWm48nmnXGHCgBZRdHKBOprw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mG3Oi//IvXyThwvId95J8MMv57rbZdEx4MEUoN0GPmnUlWA7xckCT112Vfa0OQFw4
         MDQfw3PE7VgxqDER39nJ4CTZT5fVLXyKUDPl377rbludzUKDZQU6MX3v/Z6MsnjXpy
         We0dw+/Bdng5sgyK2HL38TgqNkH2h9rSpoaH7EnFugj5hgMY6G8Bo3TCsHWz8gowsb
         iSHx/3cpLSt3/S6mOHS6ouy/FqvLusOoBrt385P7wSg/MWtjm7pViH8xEok1oKgtLY
         TFYfp6umd3nylnTb3so3Z1bVx9wZBV4kOd5lv89G9sGTYfHqWtD++tItNmr9V2E2B3
         75KoU3Y8CARoQ==
Date:   Fri, 1 Jul 2022 21:49:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] dmaengine: imx-sdma: Improve the SDMA irq name
Message-ID: <Yr8eltGsgCUkeDI4@matsya>
References: <20220623123353.2570410-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623123353.2570410-1-festevam@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-06-22, 09:33, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> On SoCs with several SDMA instances, such as i.MX8M for example,
> all the SDMA related interrupts appear with the same "sdma" name.
> 
> Improve the SDMA irq name by associating it with the SDMA instance
> via dev_name(), so that the SDMA irq names can be unique.

Applied, thanks

-- 
~Vinod
