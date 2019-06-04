Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936CE348A6
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfFDN3d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 09:29:33 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:53128 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727276AbfFDN3b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 09:29:31 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 138A7C1F28;
        Tue,  4 Jun 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559654981; bh=btCZZ0h8M5kTUoE5AOEub5awszvJpIYGtMYk7CIYpTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CBd04fWAPyEP0scRFgvBymXBUBND2AEsjFwescFsZGhC3rZt0keEW7Xt72SCSnGar
         0h4xBaCN+hEdYT+8kdiJ5bMaII7K0+9MQB4MaSy49ViBJali478ymQ8ZfjzEn97Uyk
         HVxwGN2JbfK3QV8O7CAd9S9SdGHLILgGlkFMY2HK96lXY5e3avN+Tslyz7vl7gZY1m
         DlFHHEWwXAYiIP+wOoMlNNWdP0Vk8Ie4M3QgSuulobXt7KHVVljOBGL8QrniBRGcMj
         RU7edwO334NxZrrTxYmC21L1Toyg3DKImSnAAUzLTo8LJ0FpyUjHtSSZDbDoWygkh1
         wtvFelUgmbbKQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 772AAA023A;
        Tue,  4 Jun 2019 13:29:29 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 5D72F3FADB;
        Tue,  4 Jun 2019 15:29:29 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Tue,  4 Jun 2019 15:29:27 +0200
Message-Id: <948658fbd5c28b62ca70e9f8fd8fe756e2b7aad2.1559654565.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys eDMA IP driver maintainer.

This driver aims to support Synopsys eDMA IP and is normally distributed
along with Synopsys PCIe EndPoint IP (depends of the use and licensing
agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Joao Pinto <jpinto@synopsys.com>
---
Changes:
v1 -> v2:
 - Rebased to v5.2-rc1

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..a43f960 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4594,6 +4594,13 @@ L:	linux-mtd@lists.infradead.org
 S:	Supported
 F:	drivers/mtd/nand/raw/denali*
 
+DESIGNWARE EDMA CORE IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/dw-edma/
+F:	include/linux/dma/edma.h
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

