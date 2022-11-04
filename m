Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA66198D5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKDOIW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKDOHt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:07:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3E25293;
        Fri,  4 Nov 2022 07:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7A1EB82E2D;
        Fri,  4 Nov 2022 14:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BC0C433D6;
        Fri,  4 Nov 2022 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667570861;
        bh=Mx3AtnFY604JKK1WPDqMahtm/YkhAAFpFwyKlU7F/v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCPoMVYPPn/A0pG9R2EQNPz+tsk7N/7jJ2SH+msmHzWdttIE5BktJc0inXZzO9gyV
         qqoWbJ6s0kmUzVws97ebf/v+WDO2ljz+t98KU7DZmwKszzxbXymvHz8BphABWnH0dv
         h4V7aHne65RzUpMRTJL4jymO81c2btBnBSlL7nhONEj3LCtM0dscx5YLzbF9z81Auf
         2I1dfCM5elKXvyNER+T7pSAMudjI4UX6ljhvec2SFFoT923iwROZMKocRErEimYqiI
         vDQ9D5J1t17e23JWqX6j/5jCSclExvWesJPULJkt7UleMOCwyhfQlg2ElYRJTkP5Kt
         xAxI0cCN0ZFxQ==
Date:   Fri, 4 Nov 2022 19:37:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] ARM: mmp: remove custom sram code
Message-ID: <Y2UcqSPuo3AljUAA@matsya>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-10-arnd@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-22, 17:49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The MMP_SRAM code is no longer used by the tdma driver because
> the Kconfig symbol is not selected, so remove it along with its
> former callsite.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
