Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114697563D3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jul 2023 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGQNIq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jul 2023 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGQNIp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jul 2023 09:08:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F58C0;
        Mon, 17 Jul 2023 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689599325;
  x=1721135325;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=O5DQ9JSl1jzwQRO2zJHId2P9HoG7Jsu0sEGb288kCQs=;
  b=P541cTqDV0rzQhh/ESfcK5tRXktNemGTWHIi+IpTzkPugiaFoxEEYxrE
   cXv9TafltQS0gSDYLf/p4jwfruVKPQhdXI+eNF0Ddckvuy5t0SU+lmUIi
   zOtnlKrUKD/DfxjEmzkmjrbGZQqCFO43TaiR1Om+x6MjpvOx7kBpVS4/n
   o0Hk9jxzfoKYIhOhB9PsIDBHjWmIZpX/AHWVDqwki7eK5j/QlFRzh39u1
   H/ZKRQi5KirqcXWi5aOHVZadZDVIs1XstZNe02zKVWUWdRh8rjCtKwzbp
   2WARSriI/2CM61JoGGF0wPHlWtllDNK8nvPUp98TDuU1aUnQcs2XMK9jF
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] dmaengine: Use-after-free fix and dummy DMAC
Date:   Mon, 17 Jul 2023 15:08:39 +0200
Message-ID: <20230717-dummy-dmac-v1-0-24348b6fb56b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFc9tWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Nz3ZTS3NxK3ZTcxGRdy0SjVPNU45SUJCNLJaCGgqLUtMwKsGHRsbW
 1AG15UYlcAAAA
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series has a fix for a use-after-free in the DMA engine framework
and adds a dummy CPU-based "DMA" controller driver which can be used for
testing the DMA engine framework and clients on systems without a real
DMA engine, such as under KVM.

---
Vincent Whitchurch (2):
      dmaengine: Fix use-after-free on release
      dmaengine: Add dummy DMA controller driver

 drivers/dma/Kconfig      |  14 +++
 drivers/dma/Makefile     |   1 +
 drivers/dma/dmaengine.c  |  30 ++++--
 drivers/dma/dummy-dmac.c | 258 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+), 9 deletions(-)
---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-dummy-dmac-9a2e7e3ddb29

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

