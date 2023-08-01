Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9B76BCC2
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHASow (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjHASot (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B7DB;
        Tue,  1 Aug 2023 11:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE1A6166E;
        Tue,  1 Aug 2023 18:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E7AC433C8;
        Tue,  1 Aug 2023 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915487;
        bh=DRxWFTygMykPzS+u0aRxWGMcCjJeKtuRuzBbySHBU5I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QQOAFDd7DTGBA74KyCm7Lv0X+7bIoULBGm2o6Unzv4ZG7NhIoOv5hXtyRHcAYWT1Q
         494/05s3o08LGsMoIqomSXRmZ3VI9T1sUmmPO3R5dDBwkFAPy1GMghNa1whpQLrxfR
         QnD6V39fnaOI3ds9b02HbnE2GDZU9pVqlyN7Qu74lTRpL4Vv5xYjgAtQlejE66otVv
         6tMK43DvX6G3jq+gzv/xWG3QP3H1mle6qit/aqxQdst497hAmKhy98XSmkQHQqpgd2
         Z7DUmfYIuQHVWLw9fwlosT/GUmBCuqDeXnsIZFy6/HBs3Ws8V9+UrZdca8H/IOZT9k
         Lo/H6nmlhODsw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>
In-Reply-To: <20230712193505.3440752-1-fenghua.yu@intel.com>
References: <20230712193505.3440752-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Clear PRS disable flag when
 disabling IDXD device
Message-Id: <169091548499.69326.2652739076387643227.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:14:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 12 Jul 2023 12:35:05 -0700, Fenghua Yu wrote:
> Disabling IDXD device doesn't reset Page Request Service (PRS)
> disable flag to its initial value 0. This may cause user confusion
> because once PRS is disabled user will see PRS still remains the
> previous setting (i.e. disabled) via sysfs interface even after the
> device is disabled.
> 
> To eliminate user confusion, reset PRS disable flag to ensure that
> the PRS flag bit reflects correct state after the device is disabled.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
      commit: 830883a4bc012a118f3b74889292efa21799bc94

Best regards,
-- 
~Vinod


