Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B16199C1
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKDO1f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKDO0y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC623123A;
        Fri,  4 Nov 2022 07:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C46962203;
        Fri,  4 Nov 2022 14:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A253C433C1;
        Fri,  4 Nov 2022 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667571873;
        bh=rnnq8YcDa6s9xDb97Qu6StRWt8birHWJkZRHsp2sSV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HT6h8Nvk5iHN0jInMwlpceezFkiLGnBubhpuADb+1csZweBlsAnOcKXFg7xu738sp
         MEXKPOnKX0dMLOLsglrROH8Duujd6ixSvfI1KnIy3fgyZ4juY6v1m05gYkWm36HtSo
         63bUj/R+fdvGglnSDbKO6GBo1AQspt/tkI8ZraI46Ez+Tb4U7PBP4YQ/beVRa+DD1P
         M8YEBCbH4iWhaRPCNU+afqV0sEAJfWQ9Pyt9Tf8o+v5OW2eVfzS8Ys8AxfevQVpLpr
         6ws4ZghVZSD/8YeOnvXVd+QdQzCEg3fbIqBLwOj9ysCERj5RS8ZjJyG0d6vcqBJY2X
         pDSOAqx6dINRQ==
Date:   Fri, 4 Nov 2022 19:54:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     michal.simek@xilinx.com, lars@metafoo.de, marex@denx.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 0/2] dmaengine: xilinx_dma: minor documentation updates
Message-ID: <Y2UgnelN3C/9nar3@matsya>
References: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666683737-7668-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-22, 13:12, Radhey Shyam Pandey wrote:
> This patch series add missing kernel documentation for 
> xilinx_dma_device_config() and also fix return doc
> for xilinx_dma_child_probe().

Applied, thanks

-- 
~Vinod
