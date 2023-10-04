Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7F7B78C7
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbjJDHdJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbjJDHdG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663C98;
        Wed,  4 Oct 2023 00:33:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4E4C433C8;
        Wed,  4 Oct 2023 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696404781;
        bh=Q5Yvrxk9uP3w/sec70NuRnAW8kUBSmlRnZ+J/yHoJLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNE+PJI5CYiE/MZbcfodrX7lU2FEsLx6aiKFdFMJemCoOos8rIn6EzEYFa0+Q2JMR
         srgMsQckngMh01CLwvaI8LyaZoUmD/+XY9gyq/H9b3D+zCZ055CC/ZebiJOKylcq6d
         VIrKpAeN3akIFJethC/sxpwi09LzgLJlIQUBlOHjgZnOuqEGdt/9M9YOrdUuFJs8/Y
         QfN2HtxrzzQ6Gl/8S7Z8yZZ68ZLom2auGJas79szmhRw5FAZkaI/Bs59GmhfaPQ+oB
         0bKt7HQbod4ZPf1iQVgWJZl2av25NTDtKus+k4SOCompBykDl/S0jggC87tV/wwubz
         ugO7ObYqEyNQA==
Date:   Wed, 4 Oct 2023 13:02:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     "open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
        "open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: fix all channels requested when
 call fsl_edma3_xlate()
Message-ID: <ZR0VKS2VoocrTzWY@matsya>
References: <20230914222204.2336508-1-Frank.Li@nxp.com>
 <ZRWLSkl/QzBtls+T@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRWLSkl/QzBtls+T@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-23, 10:18, Frank Li wrote:
> On Thu, Sep 14, 2023 at 06:22:04PM -0400, Frank Li wrote:
> > dma_get_slave_channel() increases client_count for all channels. It should
> > only be called when a matched channel is found in fsl_edma3_xlate().
> > 
> > Move dma_get_slave_channel() after checking for a matched channel.
> 
> @Vinod
> 	ping

Can you please resend

-- 
~Vinod
