Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C063330C6F0
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhBBREe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 12:04:34 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53126 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237027AbhBBQ5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 11:57:50 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9F82340216;
        Tue,  2 Feb 2021 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612285008; bh=wTDtZw8zXSiDJYCQgfDlx/77INQB9/ASV35kYlcbdFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=V5WH+bzztxQJxHdLdtlLf4L2ovtrK4RaTrE5A1xTMDC0C5vmtGPdREGDmiV63Z4LC
         4Qy2XnZ1JaWZszr2F70uopp5drUWFqXmNMgI3humqQeZhj996CAITZiC06a8d1qZle
         V/cCHvmdIDPVz4fN3YmEaWJ+TcMOsPvbBMIcg1PLAkTpe266z6dNUuhDfzXaxK7p+A
         4VPM5Vbnq4P1D0UsA+KEuFxmXfKjhI2P/Erz56lWnmnocJXapl0CWg5/UHyuGpq2p/
         s69mcuZu3rmtu6Dy18P7ZuF8o3NHit4zeFeZaKAFT8+X0E1zj28Zg1P0r4EY3ICyOB
         GjShPELxBUBdA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6DD3CA005E;
        Tue,  2 Feb 2021 16:56:47 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND PATCH v3 3/5] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Tue,  2 Feb 2021 17:56:36 +0100
Message-Id: <850ba8b075a65f753bbb802b9af23839624908bd.1612284945.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..6d5783f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,17 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	default	n
+	help
+	  This driver allows controlling Synopsys DesignWare PCIe traffic
+	  generator IP also known as xData, present in Synopsys Designware
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
-- 
2.7.4

