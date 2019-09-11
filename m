Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44151AFF4E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2019 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfIKOzl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Sep 2019 10:55:41 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37206 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfIKOzk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id A80495FBAB;
        Wed, 11 Sep 2019 16:50:00 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 0/4] Fix UART DMA freezes for iMX6
Date:   Wed, 11 Sep 2019 16:49:39 +0200
Message-Id: <20190911144943.21554-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For some years and since many kernel versions there are reports that
RX UART DMA channel stops working at one point. So far the usual workaround was
to disable RX DMA. This patches try to fix the underlying problem.

When a running sdma script does not find any usable destination buffer to put
its data into it just leads to stopping the channel being scheduled again. As
solution we we manually retrigger the sdma script for this channel and by this
dissolve the freeze.

While this seems to work fine so far a further patch in this series increases
the number of RX DMA periods for UART to reduce use cases running into such
a situation.

This patch series was tested with the current kernel and backported to
kernel 4.15 with a special use case using a WL1837MOD via UART and provoking
the hanging of UART RX DMA within seconds after starting a test application.
It resulted in well known
  "Bluetooth: hci0: command 0x0408 tx timeout"
errors and complete stop of UART data reception. Our Bluetooth traffic consists
of many independent small packets, mostly only a few bytes, causing high usage
of periods.


Philipp Puschmann (4):
  dmaengine: imx-sdma: fix buffer ownership
  dmaengine: imx-sdma: fix dma freezes
  serial: imx: adapt rx buffer and dma periods
  dmaengine: imx-sdma: drop redundant variable

 drivers/dma/imx-sdma.c   | 32 ++++++++++++++++++++++----------
 drivers/tty/serial/imx.c |  5 ++---
 2 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.23.0

