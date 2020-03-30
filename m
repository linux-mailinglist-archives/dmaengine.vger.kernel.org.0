Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA3198674
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgC3V1I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:27:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:18793 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgC3V1I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:27:08 -0400
IronPort-SDR: +x/3hFCPnF4ATr7Erh4ftCpXwXUAcsTwzkZaekynjRsyFT5bfp81aM6DNqU5XXSyX92ytAxaOv
 NOQesoZOQwrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:27:07 -0700
IronPort-SDR: No9XJ/aA19lMcT5e++TLreNzw2vGQxPWiorLsvZA9D+PIIqURj/DaBYeEGkTRBGUs9IhIxqjgi
 dDKFjLHDAsgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="359300831"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2020 14:27:06 -0700
Subject: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:27:06 -0700
Message-ID: <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com>
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

Since there is no standard way that defines a PCI device that receives
descriptors or commands with synchronous write operations, add quirk to set
cmdmem for the Intel accelerator device that supports it.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/quirks.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 29f473ebf20f..ba0572b9b9c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5461,3 +5461,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+/*
+ * Until the PCI Sig defines a standard capaiblity check that indicates a
+ * device has cmdmem with synchronous write capability, we'll add a quirk
+ * for device that supports it.
+ */
+static void device_cmdmem_fixup(struct pci_dev *pdev)
+{
+	pdev->cmdmem = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0b25, device_cmdmem_fixup);

