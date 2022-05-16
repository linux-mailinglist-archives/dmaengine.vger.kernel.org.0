Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201A528334
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiEPL3P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiEPL3O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 07:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9605D139;
        Mon, 16 May 2022 04:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50D3EB81057;
        Mon, 16 May 2022 11:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8817CC385B8;
        Mon, 16 May 2022 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652700550;
        bh=nJB+Oj+EMaiHtJGEgHUqqIU2EC9RoBWL+Nd8eq8yAy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMvfOMT98aHFxjccQ5rOtC4U6FS3lYCkZPilv2PAi7sDGVkVlP5lOfv/i99hMFTam
         OOdCc7Vhr3wLoYxmuj/G1uJQkwB1LNkUfNWS+b1Aa5Y+pHozEkZO384IvnpiB1QBch
         eDYqXTKamIlbLWtvuSPKOjf2opE5U2DRhtXQ/fC1EiQnZuwM6PRinF2ajbhP7EiTBp
         f12AKwjP96M3aM1cyhRqLZmxF4xVT19O+k8GYofJEk/N5gR4yjlKdCuuLFKMPYoc0y
         KCuoP/bzkF3xlHxw55strt/+EL+WJwnQV83Dj7p5d0FfXo9OH0ljmkDKesO4WbnM+K
         phBZuSpZheIgg==
Date:   Mon, 16 May 2022 16:59:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com
Subject: Re: [PATCH] dmaengine: tegra: Use platform_get_irq() to get IRQ
 resource
Message-ID: <YoI1gchpEUcqC6fY@matsya>
References: <20220505091440.12981-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505091440.12981-1-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-22, 14:44, Akhil R wrote:
> Use platform_irq_get() instead platform_get_resource() for IRQ resource
> to fix the probe failure. platform_get_resource() fails to fetch the IRQ
> resource as it might not be ready at that time.
> 
> platform_irq_get() is also the recommended way to get interrupt as it
> directly gives the IRQ number and no conversion from resource is
> required.

Applied, thanks

-- 
~Vinod
