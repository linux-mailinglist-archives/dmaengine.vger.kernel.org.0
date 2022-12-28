Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4A65733B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiL1GaZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiL1GaX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:30:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC3CE0B;
        Tue, 27 Dec 2022 22:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38434CE076E;
        Wed, 28 Dec 2022 06:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B22C433EF;
        Wed, 28 Dec 2022 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672209018;
        bh=1/0Qo7uZdBg6poAyG+gq3WMWdGUTd5TU0DqGYCIMt5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCdRiF0STMeexx7+ooaCKIe1tyJnShm01+HzVlLXU3sr+XoZQHayvUf+mARkboCMO
         TX3meeWrRZ9zWRSwPEKIt4TduGyMo/T5s4fDxRVQSMxTc8zk7tLIlTKPHepNkguV9H
         HxugcirSguVeH60RifAfTa0/bUXdptQvlEmtgHrghzcZC+L/T+X3ulvWKgZ8VRZTHp
         QRhhKVb8Ws7q9oTNNhS0b9LiUN5kYB/bgwke8XYaA033ELa4au8W9y9+w9akyOFiuu
         OQtNhvZjE3BGJghcLKCeG+075geslMMfOn7PP9IMUbN3Kq7Msf//hXsIUBl1VoYfWO
         Vq/DWJqpnPqog==
Date:   Wed, 28 Dec 2022 12:00:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
Message-ID: <Y6vidV6U6AkTcwc1@matsya>
References: <20221219093713.328776-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219093713.328776-1-marex@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-12-22, 10:37, Marek Vasut wrote:
> Convert the MXS DMA binding to DT schema format using json-schema.
> 
> Drop "interrupt-names" property, since it is broken. The drivers/dma/mxs-dma.c
> in Linux kernel does not use it, the property contains duplicate array entries
> in existing DTs, and even malformed entries (gmpi, should have been gpmi). Get
> rid of that optional property altogether.
> 
> Update example node names to be standard dma-controller@ ,
> add global interrupt-parent property into example.

Applied, thanks

-- 
~Vinod
