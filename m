Return-Path: <dmaengine+bounces-7261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD13C73CE0
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E24E69C3
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB732E739;
	Thu, 20 Nov 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXkVEW4O"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D642FC029;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639160; cv=none; b=kbhZJ9I8ElPlXs1qP9wh9nuNtufI5dUUBlNA4oHO6U6xcObwAyU1y7uv1bRppbKzPWzKGPkPQe5w4cuv6FM0hS+bLMp1PYVrqD06b6N0FWbjBUaD25WttqyQW/0gOkXLaAOx6Au+qFAUPmXfZmq6xPQhy8yh+H8yv0FaNpj6bHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639160; c=relaxed/simple;
	bh=uSfhn0UOrxGZunvnOP+5MS3YU8Y/WDpIcAh4nnJmJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By9gEgmGr4VqBUn/LUdqOFzZ+d7e2ZvF9mh8hXpxrNwsNmvw+gUmAqNgFs07P8bKzL9Lsu97cpepcj6NHRwdZwPTEwARjbscnRyT+NB4QizjyqvetC8iPzifL3HrxMfC/d/ywr+2VnqBlk9KoWbxNX4sV4SYAvlgUEwOvzuqu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXkVEW4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F0C19425;
	Thu, 20 Nov 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763639159;
	bh=uSfhn0UOrxGZunvnOP+5MS3YU8Y/WDpIcAh4nnJmJG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXkVEW4OwPM9VOMKkUYDOWjXZzqJQOKPRl5XkH0ObWw6godPx2TmLoxHR5Zph+Ngy
	 S+frhELUHSLzoLI4YWXnfZKg7DdXW9mX0TjWuveJAGSE36lMDS7uQ0eQPZ8MbpAk1F
	 CAAGxm7JZcxWZyCp5nNX5HalH1k8i9x12w4iCFNGbYTlVs5/D3Wg5U/TweNeTJBdOr
	 21l2zo0a336wFFDgLCXSjAiec6dfJTsr1wkaGskGdQ6hxFba8rCjIhcucGrwbp2IJI
	 IrvVbayep8oh2kXlL+VNPVzlqaeYUDPbQ5eTuiiUKCnwIrwe7oVj7t/VK84IEJ0Nzy
	 ZrSS0w9IhsQiw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM36t-000000002DC-3sCJ;
	Thu, 20 Nov 2025 12:45:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/9] dmaengine: mmp_tdma: drop unnecessary OF node check in remove
Date: Thu, 20 Nov 2025 12:45:22 +0100
Message-ID: <20251120114524.8431-8-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120114524.8431-1-johan@kernel.org>
References: <20251120114524.8431-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not support anything but OF probe since commit
3b0f4a54f247 ("dma:mmp_tdma: get sram pool through device tree").

Commit a67ba97dfb30 ("dmaengine: Use device_get_match_data()") later
removed most remnants of platform probing except for an unnecessary OF
node check in remove().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/mmp_tdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 6186b9dc5457..ba03321eeff7 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -554,8 +554,7 @@ static void mmp_tdma_issue_pending(struct dma_chan *chan)
 
 static void mmp_tdma_remove(struct platform_device *pdev)
 {
-	if (pdev->dev.of_node)
-		of_dma_controller_free(pdev->dev.of_node);
+	of_dma_controller_free(pdev->dev.of_node);
 }
 
 static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
-- 
2.51.2


