Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5C4F967F
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiDHNQA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiDHNQA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 09:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A7EA356;
        Fri,  8 Apr 2022 06:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CFC60FA7;
        Fri,  8 Apr 2022 13:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2550C385A3;
        Fri,  8 Apr 2022 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649423635;
        bh=I/sH4Z0xGBHI7ug7PEjQLDL6PwxzNs+O40t2lamCdAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paAnEef7FXGw6SkN1DeZazjXUrTrWnlbuIJA94cEwMqCo1IXh+54ziV2wF9jVRxkh
         2rtH68RCh5WkgigE98L/t4ZJkq84YuezuRojX3GjZzmehMFAcbTmN2mdVhKZwF9Os9
         NI2WOlC5G0TEEzbflWsHJTOUqXReVfLCHZAzrmSwBzdpiQP4d72gD+3phSXPOnRjfU
         HrbYWXk/ZxNoD1MyIuRfJztA5O9b5uijKt4qrLAb1Q5AiGEvy/CAiE021Xd5D6+tva
         gZqPI2C763XA9HDx7EqiIlFTD0nReUXKhM7znAtF9MyX/BAxZajj5cmDGBPoBiNuJ2
         9pJ1Pl73QIyzw==
Date:   Fri, 8 Apr 2022 18:43:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
Message-ID: <YlA1DwdIMoQ1dXZS@matsya>
References: <cover.1648461096.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-03-22, 17:52, Zong Li wrote:
> The PDMA driver currently assumes there are four channels by default, it
> might cause the error if there is actually less than four channels.
> Change that by getting number of channel dynamically from device tree.
> For backwards-compatible, it uses the default value (i.e. 4) when there
> is no 'dma-channels' information in dts.

Applied patch 1 & 4 to dmaengine-next, thanks

-- 
~Vinod
