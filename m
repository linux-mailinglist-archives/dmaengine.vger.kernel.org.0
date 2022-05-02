Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20E516CD9
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382231AbiEBJGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbiEBJGG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:06 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF51D0EF;
        Mon,  2 May 2022 02:02:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 607AE419BC;
        Mon,  2 May 2022 09:02:28 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Cc:     Hector Martin <marcan@marcan.st>,
        Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/7] mailbox: apple: peek_data cleanup and implementation
Date:   Mon,  2 May 2022 18:02:18 +0900
Message-Id: <20220502090225.26478-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cc: Anup Patel <anup.patel@broadcom.com>
Cc: Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
Cc: Sven Peter <sven@svenpeter.dev> (maintainer:ARM/APPLE MACHINE SUPPORT)
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io> (reviewer:ARM/APPLE MACHINE SUPPORT)
To: Jassi Brar <jassisinghbrar@gmail.com> (maintainer:MAILBOX API)
Cc: Mun Yew Tham <mun.yew.tham@intel.com> (maintainer:ALTERA MAILBOX DRIVER)
Cc: Chen-Yu Tsai <wens@csie.org> (maintainer:ARM/Allwinner sunXi SoC support)
Cc: Jernej Skrabec <jernej.skrabec@gmail.com> (maintainer:ARM/Allwinner sunXi SoC support)
Cc: Samuel Holland <samuel@sholland.org> (maintainer:ARM/Allwinner sunXi SoC support)
Cc: Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)
Cc: dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)
Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/APPLE MACHINE SUPPORT)
Cc: linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)

Hi all,

We had to implement atomic mailbox operations for apple-mailbox, and
along the way we ran into a mailbox API issue. This series attempts
to clean up the problem first, and then adds the apple implementation.

The mailbox API has a `peek_data` operation. Its intent and
documentation is rather ambiguous; at first glance and based on the
name, it seems like it should only check for whether data is currently
pending in the controller, without actually delivering it to the
consumer. However, this interpretation is not useful for anything: the
function can be called from atomic context, but without a way to
actually *poll* for data from atomic context, there is no use in just
checking for whether data is available.

A more useful operation would be one that actually *polls* for incoming
data and delivers it to the consumer, synchronously and from atomic
context. This is what we need for apple-mailbox (in particular because
the upcoming SMC driver needs to be able to talk to the mailbox from
atomic context, for reboot/shutdown requests and possibly panic stuff).

Over time, various drivers have implemented this with "peek"
semantics... and none of them have any users. Which isn't surprising,
given how these sematics aren't terribly useful :-)

There is, however, one driver that has instead interpreted this as a
poll operation: bcm-flexrm-mailbox. And, in fact, that is the only
mailbox with a consumer that actually uses the peek_data op.

So, it seems pretty clear that we should rename this to poll_data and
fix the documentation. Since the existing "peek" semantics
implementations are unused, we can just remove them. That leaves just
bcm-flexrm-mailbox (producer) and bcm-sba-raid (consumer) to fix up
along with the rename. This series does that, then implements the
missing ops for apple-mailbox.

Merge notes: it would be helpful if we could merge this via the SoC
tree, or otherwise I can provide a git branch so you can pull the
changes directly, and then we can merge it into SoC as well.
The upcoming SMC driver needs poll_data, and that will allow us to
merge that with the proper dependencies without waiting for a merge
cycle in between.

Hector Martin (7):
  mailbox: zynq: Remove unused zynqmp_ipi_peek_data
  mailbox: sun6i: Unexport unused sun6i_msgbox_peek_data
  mailbox: ti-msgmgr Remove unused ti_msgmgr_queue_peek_data
  mailbox: altera: Remove unused altera_mbox_peek_data
  mailbox: Rename peek_data to poll_data and fix documentation
  mailbox: apple: Implement flush() operation
  mailbox: apple: Implement poll_data() operation

 Documentation/driver-api/mailbox.rst |  2 +-
 drivers/dma/bcm-sba-raid.c           |  4 +-
 drivers/mailbox/apple-mailbox.c      | 64 ++++++++++++++++++++++++++--
 drivers/mailbox/bcm-flexrm-mailbox.c |  4 +-
 drivers/mailbox/mailbox-altera.c     |  8 ----
 drivers/mailbox/mailbox.c            | 25 +++++------
 drivers/mailbox/sun6i-msgbox.c       |  1 -
 drivers/mailbox/ti-msgmgr.c          | 28 ------------
 drivers/mailbox/zynqmp-ipi-mailbox.c | 41 ------------------
 include/linux/mailbox_client.h       |  2 +-
 include/linux/mailbox_controller.h   |  6 +--
 11 files changed, 81 insertions(+), 104 deletions(-)

-- 
2.35.1

