Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09C52DB46
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbiESRaE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiESR3y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:29:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8134F129EF9;
        Thu, 19 May 2022 10:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3451BB80759;
        Thu, 19 May 2022 17:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7D2C385AA;
        Thu, 19 May 2022 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981294;
        bh=i58f70PRuG70kdoWJ6gO7NBrQrIhf+BpMs7DWWoeHj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNaeEaA2Vm/ZX8tMZkuXJRN5T7+gyfGc/mghxe04HWGrgf1Y2FJIPsxwjDhOrz+JA
         2X6eWq18n4NKIkCoJcl7McF5W/IvsGNnjVROdC1ni13Q+ZAaTu37NUR+G2TZG7fbHA
         2cgrZdZIBLdf+BtKJeh3sXB6U+AT15R+TtXejt2I3h2VhoSyT+X8syIUH/SHyOEjnP
         8JLuYd38H+TFgKyIH4iuNYG7K32i8/8BltbHpkU/aEuuW781MoGwu+PJ4QzH2M6pgY
         +oAq2apJ/khmgoO2L3YMwC6z4hlANX2XXEVwTNrBYpLHfI6Adk7HRhMxxdoqNwQ8Jj
         5pVIkP/4hWb/A==
Date:   Thu, 19 May 2022 22:58:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dmaengine: ti: deprecate '#dma-channels'
Message-ID: <YoZ+KmEQTBMuxkAb@matsya>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161126.647073-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-22, 18:11, Krzysztof Kozlowski wrote:
> The generic property, used in most of the drivers and defined in generic
> dma-common DT bindings, is 'dma-channels'.  Switch to new property while
> keeping backward compatibility.

Applied, thanks

-- 
~Vinod
