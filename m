Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC94D285
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfFTPy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 11:54:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5701 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFTPy0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 11:54:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bac300000>; Thu, 20 Jun 2019 08:54:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 08:54:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 08:54:24 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 15:54:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 15:54:24 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0bac2e0000>; Thu, 20 Jun 2019 08:54:24 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] dmaengine: tegra210-adma: remove PM_CLK dependency
Date:   Thu, 20 Jun 2019 21:24:19 +0530
Message-ID: <1561046059-15821-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561046064; bh=p4trTxYVe5Y/steQBzgiLTbY4rN9syqsdZSC4zxx6CM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=gMPuK0zdrJ5NCp0TR8HWP6Uj7S5JHlxIaKWPDluXwOlgnz9jLKYxmLN+rULRKUQw9
         o5kRyDBwzaG4UGoDKP5KHSo4gNEbb2YPGyiEozBkTKNCF+1FKRX8r9wqZrzApA+oh8
         P/TdsXKdCqxSb7h4Ib7ifbc/+7PZu8NnDCLnGtzzbwFGxbi2II3DjC2RFzhXOh/QkX
         E8r/sx9i6P6LOzYMiv84dEfl94YpBcWdlKzA5Wgr3PItdb3wvvCfOnIAeqH5arnrE9
         FRqHtr2gCQfWNn5501LWp/ZFJRO9WRuIiAEyL/r6Jjkin4b9Kb2DGtMBubSxse0fTh
         anCuU/V1iT/fQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra ADMA does not use pm-clk interface now and hence the dependency
is removed from Kconfig.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 703275c..ba660e2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -584,7 +584,7 @@ config TEGRA20_APB_DMA
 
 config TEGRA210_ADMA
 	tristate "NVIDIA Tegra210 ADMA support"
-	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST) && PM_CLK
+	depends on (ARCH_TEGRA_210_SOC || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.7.4

