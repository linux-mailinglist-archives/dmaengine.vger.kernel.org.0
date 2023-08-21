Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F99782AF8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjHUNwl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjHUNwl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA8FFB;
        Mon, 21 Aug 2023 06:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38F23637DC;
        Mon, 21 Aug 2023 13:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AA4C433CC;
        Mon, 21 Aug 2023 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625933;
        bh=cvZKI6CutDqUJMhqEq/JkcDvLQxKRqv6XPP79QB6G0w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ApNztc2OWU3LwGej6PnbpU79gILicADLqoie1CwkEWOIrnYO2WypP756GjH519lnA
         1jebdMU7Ixr8HK3VIyhn+s+okVc/SfW9YFfJFTaM7sNAJBUjRiD4hELsOkBdmhUIGJ
         s/E7U7Et1jlgjY2nXamYcKR/iqZ/oI5DWdbzSn23sWUlHzV4bNVcxZaDBOkkFtp9PK
         U64oEwaqoN0pxb03tmH+v/7pPTKrQHvXz20Z2VnXtR45loYQ9SNhpcBKe7cDmLqe5m
         D/5Jdm4RVVRtJczh+SLX2fx11ThfNqNBru0RFhukUdQSPKAmA2JRmdDjJg/IMV3OQq
         aSRQFVWjfj+ZA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20230811012635.535413-1-fenghua.yu@intel.com>
References: <20230811012635.535413-1-fenghua.yu@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Allow ATS disable update only for
 configurable devices
Message-Id: <169262593212.224153.5681728730609800123.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:12 +0530
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


On Thu, 10 Aug 2023 18:26:34 -0700, Fenghua Yu wrote:
> ATS disable status in a WQ is read-only if the device is not configurable.
> This change ensures that the ATS disable attribute can be modified via
> sysfs only on configurable devices.
> 
> 

Applied, thanks!

[1/2] dmaengine: idxd: Allow ATS disable update only for configurable devices
      commit: 0056a7f07b0a63e6cee815a789eabba6f3a710f0
[2/2] dmaengine: idxd: Fix issues with PRS disable sysfs knob
      commit: 8cae66574398326134a41513b419e00ad4e380ca

Best regards,
-- 
~Vinod


