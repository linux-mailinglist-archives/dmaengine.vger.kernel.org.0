Return-Path: <dmaengine+bounces-9014-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOS4G3/DnGnJKAQAu9opvQ
	(envelope-from <dmaengine+bounces-9014-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 22:15:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A217D706
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 22:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BB7130138D2
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649D2853F7;
	Mon, 23 Feb 2026 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hesEBWpu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m2489.xmail.ntesmail.com (mail-m2489.xmail.ntesmail.com [45.195.24.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A52F4F1;
	Mon, 23 Feb 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881338; cv=none; b=XIzvgnF5YHIvLQ5rvQ2Fp6GSRNSTOuJl0gWB9tA80rI7ELoF7VP5JGCNCpwHs3mZXu/mZ5VeXVDovRe0X7fpK6fwEAQD6p1xoZigHWiFviMeXVkTtpj5AhsZB6eGNv8oV032o//jIPER2lrAMgzIyThwyzLr7uEXs9TmPcIJdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881338; c=relaxed/simple;
	bh=Zq2IirUyfEPFzMu6m9iwUulfmXx1dT5LTcM+Mxmn32U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dsFWsyABv064nHcTNUQ6KXGD+JLy6v2oGHDMVluIPYUfcq/t0OvUwiuRNhF1P+d0ysqUlxao3g9emPtNMdyj65954rNAVQQb1THqCzAnbj1w0z/wOqLoBeGofYeorsnkWCp1Qcx3ikE9PRCQS9tFncv66UvJ+5Ed1ikQdGcNv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hesEBWpu; arc=none smtp.client-ip=45.195.24.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b37f77f;
	Mon, 23 Feb 2026 23:31:55 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Tian Tao <tiantao6@hisilicon.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Raag Jadav <raag.jadav@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	dmaengine@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-cxl@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org,
	mhi@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	linux-i2c@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-spi@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 01/37] PCI/MSI: Add Devres managed IRQ vectors allocation
Date: Mon, 23 Feb 2026 23:29:40 +0800
Message-Id: <1771860581-82092-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b20e63209cckunm6946b3c7986369
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5JGFYdQhpNQ0tOHx8aQhpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=hesEBWpuUfkngcgz1f2Ig1nlGmmzRwW4WQwqVSHNJo/8mDrQHyi2jBXfpRejbQ5213Bi/x3y5ZKsO4yPdU29saCaBfjZuhiQPZrXuFi/nfbjzR0kpb+gL5Eft5gNlVXtMsgoBjIOykghNIgFG4xZvqITu8wqjNed5lf17v/+SjU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=j3H95hgVRLs6dldnhhXVuqSGrPI2yynu10KTCXrGKLk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,vger.kernel.org,lists.infradead.org,realtek.com,lists.freedesktop.org,lists.linux.dev,gmail.com,ffwll.ch,linux.intel.com,semihalf.com,zonque.org,linux.dev,rock-chips.com];
	TAGGED_FROM(0.00)[bounces-9014-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,microchip.com,intel.com,linux.intel.com,kernel.org,bootlin.com,hisilicon.com,huawei.com,marvell.com,lunn.ch,gmail.com,davemloft.net,oss.qualcomm.com,amd.com,rivosinc.com,linaro.org,stgolabs.net,gondor.apana.org.au,linuxfoundation.org,microsemi.com,deltatee.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	RCPT_COUNT_GT_50(0.00)[87];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:mid,rock-chips.com:dkim,rock-chips.com:email]
X-Rspamd-Queue-Id: 932A217D706
X-Rspamd-Action: no action

pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
pci device drivers which rely on the devres machinery to help cleanup the IRQ
vectors.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
 include/linux/pci.h   | 22 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index c18559b..2362fca 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -297,6 +297,32 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
+ * pcim_alloc_irq_vectors() - devres managed pci_alloc_irq_vectors()
+ * Interrupt vectors are automatically freed by the devres machinery
+ */
+int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			   unsigned int max_vecs, unsigned int flags)
+{
+	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					       flags, NULL);
+}
+EXPORT_SYMBOL(pcim_alloc_irq_vectors);
+
+/**
+ * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vectors_affinity()
+ * Interrupt vectors are automatically freed by the devres machinery
+ */
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd)
+{
+	dev->is_msi_managed = true;
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, affd);
+}
+EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
+
+/**
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d5ec0f8..ae58f70 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1764,6 +1764,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
 
+int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags);
+int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *affd);
+
 bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
 struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
 				     const struct irq_affinity_desc *affdesc);
@@ -1806,6 +1812,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline int
+pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+			       unsigned int max_vecs, unsigned int flags,
+			       struct irq_affinity *aff_desc)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, aff_desc);
+}
+static inline int
+pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
+					      flags, NULL);
+}
+
 static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
 { return false; }
 static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
-- 
2.7.4


