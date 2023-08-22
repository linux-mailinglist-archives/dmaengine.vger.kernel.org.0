Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671878448E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Aug 2023 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjHVOmf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Aug 2023 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjHVOme (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Aug 2023 10:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED86124;
        Tue, 22 Aug 2023 07:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E31628B1;
        Tue, 22 Aug 2023 14:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC300C433C7;
        Tue, 22 Aug 2023 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692715352;
        bh=J3GAhb/I7LzEywurlsumMwhnHmUV2YSx6l1Q4MRLxiU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mDEORbtq/338mS6ZiS5ys15nENs8/HqZkdSMU30/CDe+ajlaAr7V3pVjzwnECdows
         rjddvyoQe6BL3DdaSgtXt2nblg4Dc3YfZb0Ch8DEhiG5MRsf32x90ilOrjp7F6miot
         hyqhto3L4qKLIbWhVtiiycX5rZp7jId08MFvP5ue2assIXNi1vS9psRelvRv8nWDSG
         CK3+L9LWk+fw5gzE/DwYHHdAiQrLCbhQufwKBEi4oum98J5mhc8CWKyAa9StqA9cad
         pla7Se0/r2Uu+7/AGkvfJFnCXnAW1X65Jwfc4VkIx6zEH183Rq5e/3Z7ildKfdsBfD
         vM1XCoddfi89w==
From:   Vinod Koul <vkoul@kernel.org>
To:     frank.li@nxp.com, Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v10 00/12] dmaengine: edma: add freescale edma v3
 support
Message-Id: <169271534836.283614.7735690823757895003.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 20:12:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 07 Jul 2023 15:00:17 -0400, Frank Li wrote:
> This patch series introduces support for the eDMA version 3 from
> Freescale. The eDMA v3 brings alterations in the register layout,
> particularly, the separation of channel control registers into
> different channels. The Transfer Control Descriptor (TCD) layout,
> however, remains identical with only the offset being changed.
> 
> The first 11 patches aim at tidying up the existing Freescale
> eDMA code and laying the groundwork for the integration of eDMA v3
> support.
> 
> [...]

Applied, thanks!

[01/12] dmaengine: fsl-edma: fix build error when arch is s390
        commit: 8b9aee8073a5f3e0c2e418d45a7969270ea576c6
[02/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
        commit: 66aac8ea0a6c79729f99087b1c5a596938e5d838
[03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
        commit: 9e006b243962a42f6927d2d9fe1a7b0a29f45265
[04/12] dmaengine: fsl-edma: Remove enum edma_version
        commit: c26e611433aaa064691343c0168f4671eb5cfa42
[05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
        commit: 79434f9b97361601e65e0f5576e9760fefebf19a
[06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
        commit: ee2dda06465a3b0f533c829a5bdc2ff15588d8e0
[07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
        commit: a9903de3aa16731846bf924342eca44bdabe9be6
[08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
        commit: f5b3ba52f36adcda7801fba99c414975f19c85d4
[09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
        commit: 9b05554c5ca6829a60c610191d45f244d8726e95
[10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
        commit: 7536f8b371adcc1c4f7ed7ca579da24bdeb14b6f
[11/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
        commit: 6eb439dff645a1f61a710abfc0d37a50e4d43d1a
[12/12] dmaengine: fsl-edma: integrate v3 support
        commit: 72f5801a4e2b7122ed8ff5672ea965a0b3458e6b

Best regards,
-- 
~Vinod


