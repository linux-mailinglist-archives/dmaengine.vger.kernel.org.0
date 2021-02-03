Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16730E5B3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhBCWGp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:06:45 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52552 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233015AbhBCWEp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 17:04:45 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2EDBCC0115;
        Wed,  3 Feb 2021 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389824; bh=im9YPeIOIOX6v4VKPr6LIGB+a/nLiNTjVu6zUPMNTcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Hedfy4pgRdNXMH2l3sfmFdQH+ESMrAXn1eMy0A1r6AuyAwjiIKQSwhBjS2r6GaM52
         frpfVYCEXXxcaTUBwFJaAHJREVo3kiWErSGQfvx5IwhAqyJ8S/bd5tGX8r7GSIh9Q/
         csBLoB6gBVEqxB8jx1X4r+2fnkyhheJ42lHQlMFBptW7ggWY3NoizmNwjBdjno9L2p
         I1u6YwxtKEvAScmspXkuxoMP/ZWEZNsgGbYYj/FWRDO3JQHOD7zKXorVM2YctQ1Ok5
         Q+1MWqHTeNo+/ekMDe4fWZTviNdKHCEsn7PGy3RiFzZWjI5DwJiPED9+EFzBhHzdZh
         wLIoTjLTB96Fg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 00546A024C;
        Wed,  3 Feb 2021 22:03:43 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 6/6] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Wed,  3 Feb 2021 23:03:30 +0100
Message-Id: <45f0701b523cda52b4b7f42351b63d5a0b6040b6.1612389746.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch describes the sysfs interface implemented on the dw-xdata-pcie
driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata

diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
new file mode 100644
index 00000000..a7bb44b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,46 @@
+What:		/sys/kernel/dw-xdata-pcie/write
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/write
+
+		The user can read the current PCIe link throughput generated
+		through this generator.
+		Usage e.g.
+		 cat /sys/kernel/dw-xdata-pcie/write
+		 204 MB/s
+
+		The file is read and write.
+
+What:		/sys/kernel/dw-xdata-pcie/read
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create read TLPs frames - from the Endpoint to the Root
+		Complex direction.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/read
+
+		The user can read the current PCIe link throughput generated
+		through this generator.
+		Usage e.g.
+		 cat /sys/kernel/dw-xdata-pcie/read
+		 199 MB/s
+
+		The file is read and write.
+
+What:		/sys/kernel/dw-xdata-pcie/stop
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to disable the PCIe traffic generator in all
+		directions.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/stop
+
+		The file is write only.
-- 
2.7.4

