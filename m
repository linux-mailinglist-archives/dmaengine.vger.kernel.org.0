Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B942F101
	for <lists+dmaengine@lfdr.de>; Fri, 15 Oct 2021 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhJOMg7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Oct 2021 08:36:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50054
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235596AbhJOMg6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Oct 2021 08:36:58 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5AC5A3F10B;
        Fri, 15 Oct 2021 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634301287;
        bh=O2/ljvaTb7ZvVN6KnRS0V+ry4x/Qg3DOm1K7QLfboYs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=m2DmQgB4NcEWjr0VFVA8fv8gUbv27DIkCES0pbDdCs6L1tu2xRwasURsWVF2zAIYQ
         m5oLzc8GeOFjwaAC8ivnox0x2gGcYs7Mqqc09qfFDieux4PVCHPVCWaunCuQDrr1eI
         oaB3J+M5FKkj1Y6An9wIxk1L7Y8oJBVm0Hdc0XP0k3Ddgz1tZsFrxL34JtfvHUyqWM
         RNuJg/WlhzqIIxYmPq1m6WkPO32zrVhh25NJgYX8mZeaACO8RlNFPYn6PQCyd9T5DP
         otHTyqgvvOOjy4+bsIRHWkFoxFAL3rCfVxD0Y1dH/P5PfroVrEeH9aIQ6QZ1otpRpn
         ieFDgPNg62g/g==
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: Remove redundant initialization of variable err
Date:   Fri, 15 Oct 2021 13:34:47 +0100
Message-Id: <20211015123447.27560-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed
and move the declaration into the local scope.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/dmaengine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index af3ee288bc11..d9f7c097cfd6 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -695,13 +695,12 @@ static struct dma_chan *find_candidate(struct dma_device *device,
  */
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
 {
-	int err = -EBUSY;
-
 	/* lock against __dma_request_channel */
 	mutex_lock(&dma_list_mutex);
 
 	if (chan->client_count == 0) {
 		struct dma_device *device = chan->device;
+		int err;
 
 		dma_cap_set(DMA_PRIVATE, device->cap_mask);
 		device->privatecnt++;
-- 
2.32.0

