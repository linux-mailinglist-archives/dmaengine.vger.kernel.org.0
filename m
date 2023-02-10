Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A2691A6B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBJIzi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 03:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjBJIzh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 03:55:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A486604;
        Fri, 10 Feb 2023 00:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745C561D01;
        Fri, 10 Feb 2023 08:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F7C433D2;
        Fri, 10 Feb 2023 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019335;
        bh=MxY7R4Rxp8ZOUVZ/CmwVSjIi1w4aat4d+j7a3Ft0m+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F159VEwm2/eoB/GfQfyY7D02EPevTmknMNxizoKxhLypX/dSuV/LNdTzHtsH6Ve2V
         o2gaOol/L1QzFxlZacUDVy7dtImL7PWaQiadaxv5lYpwcq+OcGA0+bU1n7HAhpGbx/
         yz5/+yEBIHKtqEIbOgZwLrkuxx+nK7luHIslV4r+hHrjf8khn1MQHbIyw0fJLepZ1/
         Gu6RjolBlUl/jEMpdM/KStCAK7eObl34Y5WCFC6oOjjRBXcywy9sLLohPCAe+LqMz+
         94Cx+NjuV4oMIaaFt0wZbndUACMR+VI7LqzWy5rbIC/FDOLMJtkNqlH/PVG8LoUOBR
         ubUUrSHeRYnZQ==
Date:   Fri, 10 Feb 2023 14:25:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Set DMA channel to be private
Message-ID: <Y+YGgj2A1XvOonzo@matsya>
References: <20230207045745.1029959-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207045745.1029959-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-02-23, 12:57, Kai-Heng Feng wrote:
> If async-tx is loaded before device drivers that requires imx-sdma, the
> dmaengine_get() routine from async-tx grabs all non-private channels,
> so devices that require DMA fail to work.
> 
> So mark imx-sdma with DMA_PRIVATE to avoid such situation.

Applied, thanks

-- 
~Vinod
