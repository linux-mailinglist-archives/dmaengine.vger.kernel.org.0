Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED188517E1B
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiECHOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiECHOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 03:14:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 305E5120BF;
        Tue,  3 May 2022 00:11:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B7ED2807E;
        Tue,  3 May 2022 07:07:51 +0000 (UTC)
Date:   Tue, 3 May 2022 10:11:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 4/6] ARM: dts: am33xx: use new 'dma-channels/requests'
 properties
Message-ID: <YnDViqPg3CC2Blvj@atomide.com>
References: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
 <20220503065201.51818-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503065201.51818-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [220503 06:48]:
> The '#dma-channels' and '#dma-requests' properties were deprecated in
> favor of these defined by generic dma-common DT bindings.  Add new
> properties while keeping old ones for backwards compatibility.

I'm picking up this patch into omap-for-v5.19/dt thanks.

Regards,

Tony
