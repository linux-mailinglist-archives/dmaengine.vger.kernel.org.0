Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF37B1BBE
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjI1MIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjI1MIJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:08:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD774122;
        Thu, 28 Sep 2023 05:08:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7506BC433CC;
        Thu, 28 Sep 2023 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902887;
        bh=bLTi58mxVFlKGFAcTubys3KnVF+uKf+DzNo2r7H9PaE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oyBbzhT9sCQX+q/pJiWa+uz4kh+0XkbK7/0vggm4qa6b64Pb0YQOoUO3L/gcR/vZH
         yaUPxbd0mUWJv8alpRRt8gBEhl+/UBkDNFVBFkxioCYIkFaJGo8quixGNL4KxWsyR6
         PiCbRXrYfqG8qrfeH9vTgujj+uZ9BYb1ZmYMDPZ7gOhdH4QwKSooaSMIBQFyoMaRnq
         p1YLKNaBIDY7PIJ0+fO80L5lZmfl6jux/WaWj+IQ6vrMLuC3Iwp8Xc46fq/CahmBvd
         5uCFCCqLGWLOiRdMu9PHN5lF0N/9cEqmF5GpRqxVBQmRpl/CbBhuPCOCDv3iZLVLaN
         wf252Gew3n92Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        frank.li@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
In-Reply-To: <20230823182635.2618118-1-Frank.Li@nxp.com>
References: <20230823182635.2618118-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: fix edma4 channel enable
 failure on second attempt
Message-Id: <169590288411.161554.4755205256529438708.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:38:04 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 23 Aug 2023 14:26:35 -0400, Frank Li wrote:
> When attempting to start DMA for the second time using
> fsl_edma3_enable_request(), channel never start.
> 
> CHn_MUX must have a unique value when selecting a peripheral slot in the
> channel mux configuration. The only value that may overlap is source 0.
> If there is an attempt to write a mux configuration value that is already
> consumed by another channel, a mux configuration of 0 (SRC = 0) will be
> written.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix edma4 channel enable failure on second attempt
      commit: 3f4b82167a3b1f4ddb33d890f758a042ef4ceef1

Best regards,
-- 
~Vinod


