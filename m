Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6614B6A90
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 12:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiBOLVR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 06:21:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiBOLVQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 06:21:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211910819A;
        Tue, 15 Feb 2022 03:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70020B81897;
        Tue, 15 Feb 2022 11:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538EDC340EB;
        Tue, 15 Feb 2022 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644924061;
        bh=zD0KcG3WVsVW8SnijqwnkAIV1vy0CeKOVswvBGb/SfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqTw22UgLjKXV1OKyZd8VKfIV1ywICbAXqRRrNxi+1uy5mKgwfY1ZkF54M0xhBcsP
         DLemD8FeThImoD0ZxD7c3T/LDfEg+h/iJ3X3sm4tlVKBidFY6lQN1g+onI92QLT04x
         dZAnmr418sxPReZ/kJhU6wlAO15Vy8XSAj4fNgusDEnzUPkgrEW0ZuhOOez0ERZSzk
         fjrTMAAWKSf0xbNLFK2qEVJlo5NxjBfmUrYMlHbQzKnsgs3MMqnYXwxhbF5e9PHfW7
         pQdeea++IADbHWmBcUJ56RY9hozaxLNNOV1R5CffBYoDY2Ta68eaoMUaeUQwcjyTGQ
         5zM4t6WmfU7gA==
Date:   Tue, 15 Feb 2022 16:50:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 00/11] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
Message-ID: <YguMmSMnh6G121HP@matsya>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
 <d4242317-711d-23ce-c63e-7d355c8c0e41@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4242317-711d-23ce-c63e-7d355c8c0e41@i2se.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-01-22, 15:08, Stefan Wahren wrote:
> Hi,
> 
> Am 27.12.21 um 13:05 schrieb Stefan Wahren:
> > The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> > to access the full 4GB of memory on a Pi 4. This patch series serves as a
> > basis for a discussion (just compile tested, so don't expect anything working)
> > which include the following points:
> >
> > * correct DT binding and representation for BCM2711
> >
> > According to the vendor DTS [1] the 4 DMA channels are connected to SCB.
> > I'm not sure how this is properly adapted to the mainline DT.
> >
> > * general implementation approach
> >
> > The vendor approach mapped all the BCM2835 control block bits to the BCM2711
> > layout and the rest of the differences are handled by a lot of is_40bit_channel
> > conditions. An advantage of this is the small amount of changes to the driver.
> > But on the down side the code is now much harder to understand and maintain.
> >
> > This series tries to implement this feature in a more cleaner way
> > while keeping it in the bcm2835-dma driver. Before this series the driver
> > has ~ 1000 lines and after that ~ 1500 lines.
> >
> > So the question is this approach acceptable?
> >
> > Patches 1 - 3 are just clean-ups.
> >
> > Disclaimer: my knowledge about the DMA controller is very limited
> >
> > More information:
> >
> > https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
> >
> > [1] - https://github.com/raspberrypi/linux/blob/561deffcf471ba0f7bd48541d06a79d5aa38d297/arch/arm/boot/dts/bcm2711-rpi-ds.dtsi#L47
> > [2] - https://github.com/raspberrypi/linux/commit/44364bd140b0bc9187c881fbdc4ee358961059d5
> would be nice to get some input aka gentle ping.

Somehow patch 10/11 is appearing split from rest of the series. The
series looks fairly okay, dts needs more polishing as Rob indicated

-- 
~Vinod
