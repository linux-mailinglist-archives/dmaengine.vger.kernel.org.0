Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD47BD32B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbjJIGNN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345252AbjJIGNC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:13:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95479F0;
        Sun,  8 Oct 2023 23:12:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF9C433CA;
        Mon,  9 Oct 2023 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831975;
        bh=jn0sUbgd2EJPBzkIYTs9bpjsHB6DVkAX2SQb+8D+QWs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r3n9yVnBe/L/tg8bcQsQQ/nxNBtLmuUgAkCToHhr/yGVMMvZWRTCfg2beB7ruJMqi
         rtiIxfQRxnZKB64q9vx0DoPKIGaOGN7yXyhQhdxqlSIXxwFoEXva4v3bGQx05MsKiy
         WufOlzR1lk4sceEDp+FYImZjADeXF069ln2lvX82AiVKv4yxkP6wvCEDPw1iIqmWco
         Vz9UoAyVXO4AIBLjc9PMOJMpnUwBSsZFDmu6xTZsEtOwpRIVjwTNN/poaJIoSMYniS
         5CAFZRqG67UQNu0ZM17F9VlcQFQY9uXTdf9NcTR9OlryN4EaYThpi+oVtb6nM4EEf7
         zWP5Ey3JiEX8A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Frank.li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231004142911.838916-1-Frank.Li@nxp.com>
References: <20231004142911.838916-1-Frank.Li@nxp.com>
Subject: Re: [PATCH resent 1/1] dmaengine: fsl-edma: fix all channels
 requested when call fsl_edma3_xlate()
Message-Id: <169683197316.44135.5111296120983470256.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:53 +0530
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


On Wed, 04 Oct 2023 10:29:11 -0400, Frank Li wrote:
> dma_get_slave_channel() increases client_count for all channels. It should
> only be called when a matched channel is found in fsl_edma3_xlate().
> 
> Move dma_get_slave_channel() after checking for a matched channel.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix all channels requested when call fsl_edma3_xlate()
      commit: 3fa53518ad419bfacceae046a9d8027e4c4c5290

Best regards,
-- 
~Vinod


