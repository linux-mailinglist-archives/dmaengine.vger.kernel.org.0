Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B24B62FE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiBOFlk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:41:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBOFlk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:41:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DD19C0B
        for <dmaengine@vger.kernel.org>; Mon, 14 Feb 2022 21:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13F27B80C6D
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 05:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C45EC340EC;
        Tue, 15 Feb 2022 05:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903688;
        bh=oMzKEO9SgTtRx2QztLCi5bVx9C5sNTWGysYCXmBkTQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmq9YKPqo+VBeqY4aLeHvwgWr36Rtn4YVfizCHab2MOrOsohuS+8s5N/3ny1Q3Ewx
         nT2coWSxO58U00vWn4ed0CA//U9nio2/i84NLDImQyu5sW2+wKBQj+9xmYf1n7JSEx
         JSMp2tdrnqFVD9jv+UipaC7SHmXX1Q0eFGUYpUDuvegWhsUlegEI/saoaON7nE/8kG
         SHuMOa58KCQn2J1Had5ycuWbBfiQldla36MFxF2tRgPLpuV4wLWk0GO5aCCVSvsmUg
         mjhH8lXvA+u6jkR+adnbMQ4QzyURXlsMVUDAm7Ig8bvmNoV0eCxSZAHtAhd86OtG4Q
         2ON5MsS97+pHw==
Date:   Tue, 15 Feb 2022 11:11:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH 1/2] dmaengine: imx-sdma: restart cyclic channel if needed
Message-ID: <Ygs9BNzoutsDEfP/@matsya>
References: <20220117091955.1038937-1-tomasz.mon@camlingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117091955.1038937-1-tomasz.mon@camlingroup.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-22, 10:19, Tomasz Moń wrote:
> Under heavy load resulting in high interrupt latencies, it is possible
> for imx UART requests to completely fill DMA buffer. When DMA channel
> is triggered and no SDMA owned buffer is available, SDMA stops. Thanks
> to the autoRTS feature, there is no data loss due to the SDMA stop if
> the UART is using hardware flow control.
> 
> According to DMA Engine API Guide, DMA cyclic operation is performed
> until explicitly stopped. Restart the buffer after handling channel loop
> if the channel was stopped by SDMA.

Applied all, thanks

-- 
~Vinod
