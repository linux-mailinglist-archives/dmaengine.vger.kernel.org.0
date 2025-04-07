Return-Path: <dmaengine+bounces-4846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC46A7EBDB
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0543AA1B7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DC255E27;
	Mon,  7 Apr 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQqHxKrx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EB255E26;
	Mon,  7 Apr 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049489; cv=none; b=HrgU/G78z6L+56/jjeygHivnZNXFIb/M7kpipL+61h2CuP7nxIJXUXCwMQkoZAfvSGyU60k117toQQ2DVD58RONlsKTX4op54DP6TL+oVYrHfewqF4dBrEV6CGAKqFJCj/uOTC8eSTN6Od69R/IfsVZK3P+XrV5hPScrho1aCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049489; c=relaxed/simple;
	bh=ubgTwErU6Nlpq6QQ7KcF793k4I1W9vkMulHQMS8rMqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdV1EVDT4E6fXFbGXtv1ihUwshuAcl2hqDLTWjHSCFuStnx6nx9DNNLRECmWgcVGH37VSw2rq+0iPB6VIFZ1ia2o951Eky6kMX5T6btUIkyVrDT8Y8TE45aoTIYTfjU5DLDa0pXqFHGMf636CNiZS1wHD3vOt6yBNsZNXpseltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQqHxKrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD6C4CEE7;
	Mon,  7 Apr 2025 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049489;
	bh=ubgTwErU6Nlpq6QQ7KcF793k4I1W9vkMulHQMS8rMqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQqHxKrxynEPRsyRKmiDop40+e3PWtu2k7BcsjCJaqyLBE7h5vrNTi5wEDfFjtHWH
	 uMuF08PjR6snNFa/S25PFxE0JjMBcPBvwB2MlD1HSSgc+6LmgJ2lpNj9umcOkOIdUw
	 mxe6zihCEoAMJaIxJi0LQJmMfj1g9lOnuNj6K2+dUzuyWiS2+Ob5TXF5uNot6kGGWN
	 CCBjQ1Xnp9T8Qv+jaDnsSRmxbMHVw9WAWXuo6j10NF3+rc3NL2EeUWvyX/S+ikpiD/
	 DpY897GZXRtUACtxxR/aAyrqawkrdlelXdwUIuR8NYH63kfVQfqpJCfMWkH7J/cIB4
	 0MGVOsdX4h7Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	kernel test robot <lkp@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 12/31] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
Date: Mon,  7 Apr 2025 14:10:28 -0400
Message-Id: <20250407181054.3177479-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 95032938c7c9b2e5ebb69f0ee10ebe340fa3af53 ]

The old SET_LATE_SYSTEM_SLEEP_PM_OPS macro cause a build warning
when CONFIG_PM is disabled:

warning: 'bcm2835_dma_suspend_late' defined but not used [-Wunused-function]

Change this to the modern replacement.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501071533.yrFb156H-lkp@intel.com/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20250222095028.48818-1-wahrenst@gmx.net
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 20b10c15c6967..0117bb2e8591b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -893,7 +893,7 @@ static int bcm2835_dma_suspend_late(struct device *dev)
 }
 
 static const struct dev_pm_ops bcm2835_dma_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
+	LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
 };
 
 static int bcm2835_dma_probe(struct platform_device *pdev)
-- 
2.39.5


