Return-Path: <dmaengine+bounces-10310-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNmQLyErAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10310-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1550514EAE
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5396300CBCC
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953D4D2EFA;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLHS871x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BD4D2EE7;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=k8BqARy/+P27uKDktZWN0QcyNdIOA/qJWQlc8Nsy3rFUK52qQ0xqe13km02fI9P/qnaIysZJAgbqHniOB63Hs6SHp8e4TiWZkPnMs7+OyzwsI6nl4tp31zVnBGn4YxgYi5MP29W7tXUYFstdXOlsWgbJWt15sONw78ioYsvjflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=Hv18qnmVP49lgAPJzB4Ai3Se7PHw98dI7KO+ks9zLYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7LKmBETHzUnxTak2PwKi8XYUw0j6ZDe2oIpt09OAORyG2TZ7fqNqgY2KRczPxckkz8ttloyFH2sVc0Qtlh++HfdyWAzRChJVPsFHw1fBLXvacvr8QkhAZqm6ydcEnEdHIvBdsQeuRlZ47QH/wSL2LoP86foPSR5Va7E8BNsSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLHS871x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B95ECC2BCFB;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=Hv18qnmVP49lgAPJzB4Ai3Se7PHw98dI7KO+ks9zLYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cLHS871xIEmUL5T7rruuWaHRjYr+HF+N+s1ZOPK1tuIn4UmTxZ9A0wtsEg06nNc1w
	 sDYPGMLcNG4RTN7RG4vumZ/qFHdImw4pY/xbCLFD4ytWVg2gxG1eNLNhHSyQKTd7mM
	 UYsLSf1scYLqspLe2h4EpUjcN7vbrSXIVuQ+AZfxKyPfgNvXxlCZIDFsv32ebD32We
	 5wwHO3QH/eIC0cA2aNh3KnBDl2TrENvykYRPwEQQRJh/O8zdPKq8i/F4uxDhs7oYAE
	 ++6WUYCFXnQ0tGrFHulcpu4ALrxTHDa0/9kMPtyyEEiU0Ja+wjwSoxey0n/DUF8KZF
	 YfYC0oQZ2yoBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37CCCD4840;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:21 -0500
Subject: [PATCH v2 09/23] dmaengine: sdxi: Start functions on probe, stop
 on remove
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-9-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=3870;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=w38fFzvZT8cwDFoe83kJ8+kmcasB/It8RRA2HbLwDYg=;
 b=UlyvxlY9BI1oKdHNamgkKLqtbyKJqV1da+FzmaanliZSHxIhi9Nw0sV3WBDw5s9HOPRn7tXKA
 P7zBYedD6RfCSlvbVuvWKcOsX+T6k0jq4H6kNI6fbUFuKoVte7F0yKU
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: C1550514EAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10310-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Following admin context setup in the previous patch, drive each SDXI
function to active state during probe. This is done by writing
GSRV_ACTIVE to MMIO_CTL0.fn_gsr and polling MMIO_STS0.fn_gsv until the
function reaches GSV_ACTIVE or an error state. A 1-second timeout has
been sufficient in practice so far.

Introduce sdxi_unregister() to stop the function during remove and wire
it up via the pci_driver .remove callback.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c    |  6 ++++++
 drivers/dma/sdxi/sdxi.h   |  1 +
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 9d8729b62685..204841afa5b7 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -89,6 +89,42 @@ static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
 }
 
+/*
+ * Transition the function from stopped state to active.
+ * See SDXI 1.0 4.1 SDXI Function State.
+ */
+static int sdxi_dev_start(struct sdxi_dev *sdxi)
+{
+	enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
+	int ret;
+
+	if (status != SDXI_GSV_STOP) {
+		dev_err(sdxi->dev,
+			"can't activate busy device (unexpected gsv: %s)\n",
+			gsv_str(status));
+		return -EBUSY;
+	}
+
+	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
+
+	ret = sdxi_dev_gsv_poll(sdxi, status,
+				status == SDXI_GSV_ACTIVE ||
+				status == SDXI_GSV_ERROR);
+	if (ret) {
+		dev_err(sdxi->dev, "activation timed out, current state: %s\n",
+			gsv_str(status));
+		return ret;
+	}
+
+	if (status == SDXI_GSV_ERROR) {
+		dev_err(sdxi->dev, "went to error state during activation\n");
+		return -EIO;
+	}
+
+	dev_dbg(sdxi->dev, "activated\n");
+	return 0;
+}
+
 /* Get the device to the GSV_STOP state. */
 static int sdxi_dev_stop(struct sdxi_dev *sdxi)
 {
@@ -222,7 +258,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
-	return 0;
+	/*
+	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
+	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
+	 */
+	return sdxi_dev_start(sdxi);
 }
 
 static int sdxi_device_init(struct sdxi_dev *sdxi)
@@ -281,3 +321,10 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	return sdxi_device_init(sdxi);
 }
+
+void sdxi_unregister(struct device *dev)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	sdxi_dev_stop(sdxi);
+}
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 9ac94d6f8b96..0f72cd359cf5 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -63,6 +63,11 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
 }
 
+static void sdxi_pci_remove(struct pci_dev *pdev)
+{
+	sdxi_unregister(&pdev->dev);
+}
+
 static const struct pci_device_id sdxi_id_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
 	{ }
@@ -73,6 +78,7 @@ static struct pci_driver sdxi_driver = {
 	.name = "sdxi",
 	.id_table = sdxi_id_table,
 	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
 	.sriov_configure = pci_sriov_configure_simple,
 };
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index a0fef057b00b..7462fb912dc6 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -64,6 +64,7 @@ struct sdxi_dev {
 };
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
+void sdxi_unregister(struct device *dev);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {

-- 
2.54.0



