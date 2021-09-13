Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38F409FB8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 00:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbhIMWfA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Sep 2021 18:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245114AbhIMWe7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Sep 2021 18:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB8B610F9;
        Mon, 13 Sep 2021 22:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572422;
        bh=KcQKMXCHSf32V5kefUSAG6IKXTR47MANSbljlgPuYF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A33jJeyy0ZbcTm9VK7RBslEku2imnWYpqPs/WX5wHcGRTHRtVWG85aQ/heCvLtH5r
         88rRz0c9DtFCdBfGlPDBMrbnSsFWKEWJEWAIVq+GUGNHbY+/OE4YzfdePDVW+ZRGiS
         7vDpZwF5x/bup8vM2ufXsawhmRNWrGsuD3B1dr0yfNMtt/ymPZPdR9hfXciWdMIMGP
         wAmnzyMyVZJStR6DgF6lICBrJdetLMKkJV69/TgDVgUVV+ieKvVJ1U2cz9OwvYXC0K
         2V4aXSdKRCgGbR2fQFUgcLTC783k07C9s2lKiajHMcV6yifPkPZNnjoZnznqaQLyj+
         lPuzw/KSPEwOg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 02/25] dmaengine: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Mon, 13 Sep 2021 18:33:16 -0400
Message-Id: <20210913223339.435347-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223339.435347-1-sashal@kernel.org>
References: <20210913223339.435347-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit 4faee8b65ec32346f8096e64c5fa1d5a73121742 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/1620094977-70146-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sprd-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0ef5ca81ba4d..4357d2395e6b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1265,6 +1265,7 @@ static const struct of_device_id sprd_dma_match[] = {
 	{ .compatible = "sprd,sc9860-dma", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sprd_dma_match);
 
 static int __maybe_unused sprd_dma_runtime_suspend(struct device *dev)
 {
-- 
2.30.2

