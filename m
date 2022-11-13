Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88D6272F2
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 23:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiKMWbu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 17:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMWbs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 17:31:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DAC645E;
        Sun, 13 Nov 2022 14:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F37FFB80CB8;
        Sun, 13 Nov 2022 22:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58C3C433C1;
        Sun, 13 Nov 2022 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668378704;
        bh=1skuSJ8eRAuOy9JAgFPMViNgy7WJCNC+CprUK+YefZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fix/Xn9WP8OuzWskBHITC99MWVE0r7EjmAX++Smuk5Vci4iNZdBiYMcf2M18XhYs8
         YNSf+LDm3uf9cnihktXLNASzOiJgLZ4/5e5c4BtuRCSTGfCCtzzikPbudPAE4iU1sO
         mdUN1ieQ1ZoLnEehkWdZ21fAGDlue7Cz4hjuX2bvMo0r83d2RBvk0LllyP1+Um59r7
         8CtwL89a02lM/s7KpFhaD2PIP48+f6Lx1yyGI94xt5wzmaXH0ltru9YXVSp1M7WM4o
         nO3OxyyErYHHQqoAE7PIWx15+rgoEkV5XzbUHnDTcxpmT686ctdesT4zyOTL6Uf6t8
         bSOBVpfCUWX2w==
Date:   Mon, 14 Nov 2022 04:01:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v4 0/3] Tegra GPCDMA: dma-channel-mask support
Message-ID: <Y3FwTHpWgeK6x6kh@matsya>
References: <20221110171748.40304-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171748.40304-1-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-22, 22:47, Akhil R wrote:
> Read dma-channel-mask from device tree and register only the
> specified channels. This is useful to reserve some channels for the
> firmware.
> 
> Also update the channel number and interrupts to include all 32
> channels. The current DT bindings has only 31 interrupts which is wrong
> and doesn't align with the hardware. This was done to reserve channel0
> for the firmware. Now with this change, the driver can align more to the
> actual hardware. but this implies that there will be a breakage in the
> ABI and device tree must be updated along with the driver change
> for it to pickup the right interrupt corresponding to the channel.
> 
> This breakage is okay right now because GPC DMA was introduced on
> Tegra186 and the DT bindings were added in 5.19. Any products released
> with this IP were released with kernels prior to 5.19 and bindings that
> were never in-tree. Any of those products that are supported upstream we
> know have replaceable DTB images (i.e. by default they are flashed at the
> same time as the kernel image).

Applied 1 & 3, thanks

-- 
~Vinod
