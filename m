Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84256DFCAE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLR1T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLR1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1941BE4;
        Wed, 12 Apr 2023 10:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E31637CA;
        Wed, 12 Apr 2023 17:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029ECC4339B;
        Wed, 12 Apr 2023 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320436;
        bh=BIUSRAdoy/Zus3h2K2WNnAQR/1nxAkSLeQxWV/R2Prg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/ioBuLjffehMYpwpQri/vITWx05lPbVtkI9SUbkww4WxGP9uVxoAp/Oha9QUBNAe
         MuE4mxx/wP+/msRhy3ZCeLlXuSlOzaQ1BwB19DH3Nz62srJH8GLazKtDMz1Z00TJyX
         ORUTZ+q0CMG1yP2htUMl3fZb/WJDcLsj+tcKwmUNeTTAf1SKm6mf26YFnYssakPaBf
         K3aSjgkTBQtQDRDdFNSf4CgdZTSNa5Sl8M6do1sYWYSW5DUGbzTGN67mCkvIYVhz3C
         HONJmc/Cw9iZoYuEve5kOG0K4kZglEtlZKUyf2KbviHlpafA8lD13nZNSAIU83ZlGs
         7DTxR7btBwh2A==
Date:   Wed, 12 Apr 2023 22:57:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/4] Add DMA driver for StarFive JH7110 SoC
Message-ID: <ZDbp8IVpIwFvNgFv@matsya>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322094820.24738-1-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-03-23, 17:48, Walker Chen wrote:
> Hello,
> 
> This patch series adds dma support for the StarFive JH7110 RISC-V
> SoC. The first patch adds device tree binding. The second patch includes
> dma driver. The last patch adds device node of dma to JH7110 dts.
> 
> The series has been tested on the VisionFive 2 board which equip with
> JH7110 SoC and works normally.

Applied 1-3, thanks

-- 
~Vinod
