Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D152668D
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfEVPEM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 11:04:12 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:37442 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729778AbfEVPEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 11:04:11 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4BBDC0B9D;
        Wed, 22 May 2019 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558537457; bh=t09mOKp6zomxOcwr7TOxs1PVVJy1JEOml2G4iqt3ihg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JsPvb+W1nxTBU0FRLoozzGs/+mhygoKsDHdfou+274Rfr+mNXtA/It9Ldbq4yzmwl
         8aGOS7dTBsevpXXTiUrcRzhBl3ZXKWxKQZhCYn/uQBAvDv5cedpzV2eWsZZjOLZVxP
         r1wa+a4LRqnzEh1m8ePySl2p6f+IWxM0Iaw/6eRB7hTGx92qEGAYqV9qenDwbKfOV2
         1M5KIppusr4DTkmUXl0tgOR7HZvUmZHt6eBDOvLRLtHgoy9ABjj4Dnmg/zPQhHBhfg
         3BYIi6rA9Km8AILYOZNu9DWVRGMP9T1uZLsQW2rajUVmD2L8jbTmGCgY6xAUmzGVCT
         FgwaSUeyI0f2Q==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7F984A00A0;
        Wed, 22 May 2019 15:04:10 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 1854D3F06C;
        Wed, 22 May 2019 17:04:09 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 6/6] MAINTAINERS: Add Synopsys eDMA IP driver maintainer
Date:   Wed, 22 May 2019 17:04:05 +0200
Message-Id: <1ecc786176baa573adbb178794a4578aef977cc4.1558536992.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
References: <cover.1558536991.git.gustavo.pimentel@synopsys.com>
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
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..32222b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4513,6 +4513,13 @@ L:	linux-mtd@lists.infradead.org
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

