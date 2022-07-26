Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088B0581349
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiGZMml (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiGZMmk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43A22B39;
        Tue, 26 Jul 2022 05:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5E761506;
        Tue, 26 Jul 2022 12:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0773BC341C0;
        Tue, 26 Jul 2022 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658839358;
        bh=59TqfjtnYpCU/QeXEcm5b0Jz1TfU4t1NFp8IihT6TRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOXh313fbDSPcGS8aN9GctqA11PpZZiBYnaNnTnKv7PMIJe/PK4Jv0xsK723W3WhV
         EJF5i2aw86lubeEwKfpxZyZBmTFzveL6jBUt2xZZTynAbMu9s4TgBa4CEU+bZuq5K0
         Me2TV7jKq8447UfVBt/dO2dlAWdejRfBcrTFlc4zgyuX8MRBph06OMpaqYcIgisOii
         ypTzrDF4+jlnYK6+DFr2nNu0r737KLY1++CdXG8XnWCrKDM43K5+vK0cfYNs+FTDq2
         5OgjEqamkys88H7mz3paWEnrbSPRUA1bNm/sQfWv1oMs5kvgahqprRhUABUHslKKt9
         C3u3++f0Pwz/A==
Date:   Tue, 26 Jul 2022 18:12:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add compatible for Tegra234 GPCDMA
Message-ID: <Yt/hOsVwLH8yUYI+@matsya>
References: <20220720104045.16099-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720104045.16099-1-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-22, 16:10, Akhil R wrote:
> In cases where the client bus gets corrupted or if the end device
> ceases to send/receive data, the DMA could wait for the data forever.
> Tegra234 supports recovery of such channels hung in flush mode.
> 
> Add a separate compatible for Tegra234 so that this scenario can be
> handled in the driver.

Applied 1-2, thanks

-- 
~Vinod
