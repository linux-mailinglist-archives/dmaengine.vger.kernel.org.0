Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121045EFA00
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiI2QPQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiI2QOv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB71B784;
        Thu, 29 Sep 2022 09:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C43BCB81E59;
        Thu, 29 Sep 2022 16:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3966C433B5;
        Thu, 29 Sep 2022 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468080;
        bh=N/dxcUsikEjlv9lELYdCoUo6xsUVTNhUjYMniWeGUlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JL6YYK+kRd+FBXxO+1TFstS9lD1vl7jXboq9MO8AuSpc2uBNAZpgzwap787vx/Dl0
         VqL3KLSZgNf5EPYTiDhdDMFll+98CTM1gEj2m7VQqGMmkDukEmU7sO72B0jKlEFD7J
         ApMdpyn7F9idP0xe/QU3y4CV+rsrpeaXGYyrIHmP/V7uq4S02+ls9awsTX8hfJNf1e
         +Qn26Z4Vn8uHtOXx4kVQNF96pYrc7AE25rLBbiz7nIEVj0ALruVJ7xPxMaesClkVKC
         Vce7xMUEK/eygKKq4eMbenzCuhskCVSnCpXqCSUirluN5GCERvcVgOHlSHVzlFiZR8
         SVWqAkXQPoYmA==
Date:   Thu, 29 Sep 2022 21:44:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: apple-admac: Do not use devres for IRQs
Message-ID: <YzXEbI7D+Z+YzwDJ@matsya>
References: <20220918095845.68860-1-povik+lin@cutebit.org>
 <20220918095845.68860-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220918095845.68860-4-povik+lin@cutebit.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-09-22, 11:58, Martin Povišer wrote:
> This is in advance of adding support for triggering the reset signal to
> the peripheral, since registering the IRQ handler will have to be
> sequenced with it.

Applied 3-4, thanks

-- 
~Vinod
