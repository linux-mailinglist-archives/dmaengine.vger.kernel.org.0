Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A730E597
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBCWEy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:04:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232986AbhBCWEn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 17:04:43 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5B474048E;
        Wed,  3 Feb 2021 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389823; bh=xjFl0ry1f4kLV7eWV2SxeXcHKekFmdWi7FGEn+fooAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JjaoGBy8J9a1T1Awb6SJgMXJ9PJGBbHPFlSGvBc7rFTHt1VewoaX2GtVauly8cHyA
         foWbV1Aty4IX9WT6qxCUoD6LPFoPX6cAtp/iMv4idgoQc8f88I8pU2TcoWv11g/kuO
         glwUhceWkZ9IXniVnWbnPOhZGmJnF02kFFGfXo0+cYJon5prxxS1qBs1uRSNTDFH+N
         oltmuIBQbuzhtFHf5Ui5+MUbkuAE1v73FzOmHtQFTZUtNPJnMGBrGlFghYp1RRmGNw
         OlaXG+souNYPS8Qo0NRvrxxAiub6QtRygnDOVXTH7nZM/DSRmC4v8r9+5gOY0M2Mbp
         +rxLQx2wBXhng==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A1CFDA0249;
        Wed,  3 Feb 2021 22:03:41 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org
Subject: [PATCH v4 4/6] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Wed,  3 Feb 2021 23:03:28 +0100
Message-Id: <2cc3a3a324d299a096f1d3e682b2039d3537b013.1612389746.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Documentation for dw-xdata-pcie driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
new file mode 100644
index 00000000..3af9fad
--- /dev/null
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================================
+Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
+===========================================================================
+
+This driver should be used as a host-side (Root Complex) driver and Synopsys
+DesignWare prototype that includes this IP.
+
+The "dw-xdata-pcie" driver can be used to enable/disable PCIe traffic
+generator in either direction (mutual exclusion) besides allowing the
+PCIe link performance analysis.
+
+The interaction with this driver is done through the module parameter and
+can be changed in runtime. The driver outputs the requested command state
+information to /var/log/kern.log or dmesg.
+
+Request write TLPs traffic generation - Root Complex to Endpoint direction
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/write
+
+Get write TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/write
+- Output example:
+	204 MB/s
+
+Request read TLPs traffic generation - Endpoint to Root Complex direction:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/read
+
+Get read TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/read
+- Output example:
+	199 MB/s
+
+Request to stop any current TLP transfer:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/stop
-- 
2.7.4

