Return-Path: <dmaengine+bounces-7210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86558C650E5
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C7647289DE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF32C0F65;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBP2/w2o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C722BF019;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396004; cv=none; b=Ey8Q4GVfVZyQf6nGdViIH6rJm1LwOluH4/Te+ePYfP86ikhFoXxMqUrxrzUqquqTbyQXpK1hNDw9VSc2+E0qX3/CGtf0630v139zaKjSr5euO+xsQVQ+szqDfB4FWpvQEwgTnrDk9HX74l76edj8VLY4RKWqv/h3h+s6fO5iypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396004; c=relaxed/simple;
	bh=hazxaeYnwXkO6zV8pnL07zJLXt157fqCf1kE68DIE6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltgqwzl1jeP8FSIM0gPj9uQMnBOVPZVsfLtg6mtN/CEF4F/5c4JPvmH7XNyMgR42sLHYVVPy5zTwaOmwu/+wfU19uhkeBkfhy7xok3iQuBjM/pGuMM3/hIRLRMVO0nOXCznjXDm4PzHrJKZf/s3ZgtRUojb1E7YvtTb/3Hr+nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBP2/w2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B273C19424;
	Mon, 17 Nov 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396004;
	bh=hazxaeYnwXkO6zV8pnL07zJLXt157fqCf1kE68DIE6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBP2/w2o8ksDX2l7Bd24s/yu4AYFSv7Eh3c0c4CqwJuFGJKwdFpZKqIc3n7eHfm+q
	 OJHpB/f2bc00cxNDCQDUNzT9FlFeVSiglsyVWnyOTxlf2bewFnjXFmCx5+ZXfj7rF2
	 HL+UOKfZ08H65h3rFNjZUyVZTILuxJI24DqTAqQdg43kKpPYm3DJ8KfK6QYoDWz7qf
	 WQHE3bE2rO9enI8xjHbZf33SyVCHEIJ8e4zUHm+jcsOfVS5bIIrRXULRbMefZa1kY3
	 dDqnKxb5Vo8depiMJUHdFuE+txMO22OrakcUF8j+6HcBZMETY1tkjbw95LNmXRpxAy
	 I0i+hItvXUA6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1r0-000000002nY-211T;
	Mon, 17 Nov 2025 17:13:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 02/15] dmaengine: bcm-sba-raid: fix device leak on probe
Date: Mon, 17 Nov 2025 17:12:45 +0100
Message-ID: <20251117161258.10679-4-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the mailbox device
during probe on probe failures and on driver unbind.

Fixes: 743e1c8ffe4e ("dmaengine: Add Broadcom SBA RAID driver")
Cc: stable@vger.kernel.org	# 4.13
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/dma/bcm-sba-raid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 7f0e76439ce5..ed037fa883f6 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1699,7 +1699,7 @@ static int sba_probe(struct platform_device *pdev)
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto fail_put_mbox;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1729,6 +1729,8 @@ static int sba_probe(struct platform_device *pdev)
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+fail_put_mbox:
+	put_device(sba->mbox_dev);
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
@@ -1744,6 +1746,8 @@ static void sba_remove(struct platform_device *pdev)
 
 	sba_freeup_channel_resources(sba);
 
+	put_device(sba->mbox_dev);
+
 	mbox_free_channel(sba->mchan);
 }
 
-- 
2.51.0


