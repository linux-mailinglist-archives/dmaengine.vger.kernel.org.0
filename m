Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7374F5E8
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGKQpC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGKQoc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C21738;
        Tue, 11 Jul 2023 09:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CE561573;
        Tue, 11 Jul 2023 16:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEE6C433C7;
        Tue, 11 Jul 2023 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093845;
        bh=zaf2CZqYHNb3WqOn3g5/TSKwC8Wg0LJ436Q4TrZp4RA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KGVJGsnCZruy2hUuUpH7ijZulq48NN9mnjYRkxxJjynGm26JcUksScIF1TfoPCX/i
         r6f3ggg+UqlnfDC8exH6e7PS74/XlFttq9p+kmOU9hYXf1ImUimWTMY0z2+2tj2l3/
         Jk1VB0hRL9DKcciP3cxJhjOMlekjAJH3P6RJPKHWorzn/EFP5qzmufgEyFzhTE2rL1
         89rukrhKXE24SakUpiwTCpCEb6JU6Th6JehZathj/7UQ3uIHAEQuV4g4S9FgAcVBuE
         SqvqShT6i3EAPE7sAEcTYX9r0drCG/0POAcYJRJMJYVtt5bAFNFPay3NAIxZKXTEfX
         Qpv9VDnwO9Q1w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
Subject: Re: (subset) [PATCH V2 0/7] ARM: dts: bcm283x: Improve
 device-trees and bindings
Message-Id: <168909383906.208679.14234810400324537529.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 17 Jun 2023 15:36:13 +0200, Stefan Wahren wrote:
> This series fix some dtbs_check warning for the Raspberry Pi boards
> and convert 4 txt DT bindings for BCM2835 to YAML.
> 
> Changes in V2:
> - drop already applied patches (bcm2835-sdhost, bcm2835-thermal)
> - drop patch "dmaengine: bcm2835: also support generic dma-channel-mask"
> - keep brcm,bcm2835-dma for ABI compatibility which also resolve
>   dependency between patch 2 and 3
> - drop quotes in patch 2 as noted by Rob Herring
> - add interrupt description as suggested by Rob
> - add Rob's and Uwe's Reviewed-by
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: dma: convert bcm2835-dma bindings to YAML
      commit: c60d5060b019e8095df7eebd1716747edfbd192a

Best regards,
-- 
~Vinod


