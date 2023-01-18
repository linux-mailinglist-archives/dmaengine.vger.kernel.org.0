Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59091672400
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjARQsz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjARQsv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 11:48:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739225587;
        Wed, 18 Jan 2023 08:48:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E68561157;
        Wed, 18 Jan 2023 16:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B81C433EF;
        Wed, 18 Jan 2023 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674060530;
        bh=/RbbN2yNZ5vrt37ezendcfzEpHoDc80MyVLJKX/27mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXqEdyVURePjmJ17P1TS/ISnyHnGP5GwMmWKt6d6mSTTqfhNJqEO7Er2HRx7/k7De
         AKO+O+D+1DWLnioTpL8V3gmMKyIfW2PLsHI7J0n6W8JIJYKV6baG7lqginZmnjQntd
         UdEvvFfAbIyFCuSUpOhZwRpXKVPe3Xtx4T8t7NZS2g851KMKs33BogbMNOJ2SkAvAO
         0eQ+tNT+PijEiplKBh6IJD3Y3Mxk3oy3RhXjAL395BafNtaU+IbG1AjegJOlSt2EqI
         u8w+UJqQWlgCJzBt2CHlqkSG00DibliveMFUxa7xoHsTHJ5aprufzG/8thyO9wOgFT
         oT4lMtWyDBn3w==
Date:   Wed, 18 Jan 2023 22:18:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra: Fix memory leak in terminate_all()
Message-ID: <Y8gi7YsuIy4wSTfZ@matsya>
References: <20230118115801.15210-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118115801.15210-1-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-23, 17:28, Akhil R wrote:
> Terminate vdesc when terminating an ongoing transfer.
> This will ensure that the vdesc is present in the desc_terminated list
> The descriptor will be freed later in desc_free_list().
> 
> This fixes the memory leaks which can happen when terminating an
> ongoing transfer.

Applied, thanks

-- 
~Vinod
