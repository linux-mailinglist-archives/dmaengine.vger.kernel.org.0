Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE98705506
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjEPRas (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEPRaq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221AE6D;
        Tue, 16 May 2023 10:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B48863D38;
        Tue, 16 May 2023 17:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB000C433EF;
        Tue, 16 May 2023 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684258243;
        bh=QD+y7h/o+bRIaX/7p4zBhpXDILcMaDt9viGNVq9SFJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO7PUdZy5p60/jMafhJ2tYe06L2M2Cprbo9AxD2sNrP3xexPv3QttCp0xHg0tc+Yy
         MqiLwxaa639BVKzigEpAEt0gJSMkKYYnv/O+GD3GW5ITFJOpUfgXIoaO4P6FhtNtY3
         1XFMC8mzKtDrOmlVcMbUgRpmChgDAr3FtKF+zH/9c2/daoNVWIHtKgOtQ1YR2Xi8PR
         Fn8EZvzW/Wl7L0tQce1Ob5Wz+xlaguZiqw1VTOxib08hkEfW3dyalKkOK3ujEiCulw
         PCT2F40CtUX/ev+JeypVu8SKsq7Cr8LcQfPDbklyU4Iueke4P58o0kFq0SSoUXyMEX
         LhPYduS2uIlSw==
Date:   Tue, 16 May 2023 23:00:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/7] DMA40 SRAM refactoring and cleanup
Message-ID: <ZGO9vrlQlGU+H07g@matsya>
References: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-05-23, 14:55, Linus Walleij wrote:
> I started out by augmenting the STE DMA40 driver to get
> its LCPA SRAM memory from a proper SRAM handle in the
> device tree instead of as a reg cell, and then I saw
> that the driver was in a bit of sad state so I did a bit
> of cleanups on top.

Applied, thanks

-- 
~Vinod
