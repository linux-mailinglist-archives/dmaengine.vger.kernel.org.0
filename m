Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B331276BCC6
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHASo7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjHASo4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31EBDB
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 11:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 393F761692
        for <dmaengine@vger.kernel.org>; Tue,  1 Aug 2023 18:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F427C433C8;
        Tue,  1 Aug 2023 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915493;
        bh=ZE2C3ERcygPehSiuu6qdBiIiLhuAGM/Kx+/GdYRziQw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZCC8bE7QuFl7q9x4BSskyQrHuJh6x2bAiztKD72khJJ7DxfW6tfjiWYkvz665llWr
         2+LQcv3sOvsLxm/H01K1LvQXXvJDXhnZ/QfgSwCY49xTTML4FAUD6FoSWj3WyoqatI
         G/EdSGjetb2WfelxnCsumQcOuz7uCBRDq/gZJFsdWXemJsTAzWu8bummjrtvqLvbV+
         7IxAxcl37Vt3qB9z91XiUTBHQBtJ8Cba/970XT5qg76Sg3RbVhhsFSVv9ChEuFQxjJ
         qbwVi1GBI7QKWIhwcKrH0Ih9J2dx8z2mR++epWMyVzCF370AKTn9Tv1QbNuXaH6FUs
         smov0beJoULpg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20230731101442.792514-1-miquel.raynal@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
Subject: Re: (subset) [PATCH 0/4] dmaengine: xdma: Cyclic transfers support
Message-Id: <169091549012.69326.11492636667033832683.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:14:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 31 Jul 2023 12:14:38 +0200, Miquel Raynal wrote:
> Following the introduction of scatter-gather support of Xilinx's XDMA IP
> in the Linux kernel, here is a small series adding cyclic transfers.
> 
> The first patch is a real bug fix which triggered in my case, the second
> just fixes a typo, the third one is a preparation patch to ease the
> review of the fourth one which actually adds cyclic transfers support.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: xilinx: xdma: Fix interrupt vector setting
      commit: d27a7028ba7214963eae3e3c266070a4a9f5725e
[2/4] dmaengine: xilinx: xdma: Fix typo
      commit: c3633b42923dae5c23a7fadaca6f10f8448b8fec

Best regards,
-- 
~Vinod


