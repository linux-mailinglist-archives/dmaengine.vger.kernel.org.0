Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4246C198673
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgC3V1C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:27:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:41450 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgC3V1C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:27:02 -0400
IronPort-SDR: MUoy9PvJ8BKQmGQyQbsEW0lg7OFJoAjobQAsfh/wYCF/bPAknTBIDyORQ0rCgFE2kSinkJy3wV
 N0sFUTUp5RTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:27:01 -0700
IronPort-SDR: olP2QS3KsmLaFeNlsXhAiE1rO0ai1i7Lm/qWvwgWcEJZpaTpV61AdP4RVCqIEg4a8YKxDMyA05
 BuP8MrUNS6Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="283774254"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2020 14:27:01 -0700
Subject: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:27:00 -0700
Message-ID: <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since the current accelerator devices do not have standard PCIe capability
enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
been added to struct pci_dev.  Currently a PCI quirk must be used for the
devices that have such cap until the PCI cap is standardized. Add a helper
function to provide the check if a device supports the cmdmem capability.

Such capability is expected to be added to PCIe device cap enumeration in
the future.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/core.c    |   13 +++++++++++++
 include/linux/device.h |    2 ++
 include/linux/pci.h    |    1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dbb0f9130f42..cd9f5b040ed4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -27,6 +27,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
+#include <linux/pci.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -3790,3 +3791,15 @@ int device_match_any(struct device *dev, const void *unused)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(device_match_any);
+
+bool device_supports_cmdmem(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	return pdev->cmdmem;
+}
+EXPORT_SYMBOL_GPL(device_supports_cmdmem);
diff --git a/include/linux/device.h b/include/linux/device.h
index fa04dfd22bbc..3e787d3de435 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -809,6 +809,8 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+extern bool device_supports_cmdmem(struct device *dev);
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..0bc5d581f20e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -422,6 +422,7 @@ struct pci_dev {
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
+	unsigned int	cmdmem:1;		/* MMIO writes support command mem region with synchronous write notification */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 

