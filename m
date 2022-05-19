Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9ED52DC0E
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiESRzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbiESRzQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:55:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619915FE7;
        Thu, 19 May 2022 10:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82C94B8277E;
        Thu, 19 May 2022 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A7C385AA;
        Thu, 19 May 2022 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982913;
        bh=aPWY8sZpDKBG9IVmJly033REednRet4biZs+QQWIXvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkHVf4qT2r2qjFXDG5mX8ODHxZ3mGWaypKoe8j3/ITHb8h5M7mxz2mF8avfePZw96
         ul+E5URZ/6RuBrII6QSKPCXjx8uBbNMoCpSBINA7VnfN9ElSSkArUPAbNJ9Ri7ZIkP
         jm5vFRvo0DL6J6niIUgTCIil7YViTMqVEEMB08p/QL4yRH9x9KoTeBnOUABukXzILd
         E0yGhYFm/q3koGH6btbdFoTvmzKWYFWYBnIOr2VJ6IElWz6V6cZNNCcsFAFej//zbc
         4afLCM15DyBuxQN/Sw8Sbkpi+48frEl/xzAaW/4Mnc6SGfo9No0OjQhrCngGzevycF
         Yia/immbVA49A==
Date:   Thu, 19 May 2022 23:25:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 0/4] dmaengine: sun6i: Allwinner D1 support
Message-ID: <YoaEfDnWD6kTOxfJ@matsya>
References: <20220424172759.33383-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424172759.33383-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-22, 12:27, Samuel Holland wrote:
> D1 is a new RISC-V SoC that uses mostly the same peripherals as
> existing ARM-based sunxi SoCs. This series adds dmaengine support for
> D1, after fixing an issue where the driver depended on architecture-
> specific behavior (patch 2) and resolving a TODO item (patch 3).

Applied, thanks

-- 
~Vinod
