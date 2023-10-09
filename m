Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0276B7BD31A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjJIGMd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbjJIGMb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD811F;
        Sun,  8 Oct 2023 23:12:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FB2C433C7;
        Mon,  9 Oct 2023 06:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831947;
        bh=Sq6ZJh6gqw8wFO0Xag+vF6BQQ5e+onzxKrg7U7zxil8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JJaQJk9FvWvhxZqHb9K7LZ5tFMmo/zXf4BL5siGEWiMn02/B8BA9GbCe+xIaxk4YA
         2vd9DVlmdZ0j+A1es3cScueuAg0IqRvFpTBypkF72sWiMa8ka5w+R3SP9tXWVaI3Ay
         OtNVjeJc4KsPYthQ/ne/F4sFSUljDz4meoqjHZzv8Hl7FGjU53zSefAbDeuakgyn8A
         DLztQxrlK40nWt89eX7Zzt8vMP+X+Ox6pjxiimuhUZ98E4KwqmCjFFspF+zthvV67W
         E6imWv0fM3COlgxFaMAf2olz/Br6pIxfZwR0V5XE1vOkWLa8mZZvFzlSZDqgba3SMu
         J7VUqjkcKuUeg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <monstr@monstr.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
References: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/3] dmaengine: xdma: Cyclic transfers
 support
Message-Id: <169683194388.43997.5725571234754060752.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:23 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Thu, 05 Oct 2023 18:02:34 +0200, Miquel Raynal wrote:
> Following the introduction of scatter-gather support of Xilinx's XDMA IP
> in the Linux kernel, here is a small series adding cyclic transfers.
> 
> The first patch is a preparation patch to ease the review of the second
> one which actually adds cyclic transfers support.
> 
> Thanks,
> Miquèl
> 
> [...]

Applied, thanks!

[2/3] dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
      commit: 0db2b6717c5ed1471a639f3af2f650eb9010c732
[3/3] dmaengine: xilinx: xdma: Support cyclic transfers
      commit: cd8c732ce1a561d62e22a9d8cf5e4737d66b7d5e

Best regards,
-- 
~Vinod


