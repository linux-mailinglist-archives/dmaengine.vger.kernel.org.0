Return-Path: <dmaengine+bounces-9964-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMmwITH22GlJkAgAu9opvQ
	(envelope-from <dmaengine+bounces-9964-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:08:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82D3D7DF6
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DFD4302DE11
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647943A5E9F;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRGKWaj2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93738F24D;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826470; cv=none; b=Oegb+CM8Xh8EQs29k5wD6eg2cEbrlUkxzfFM/seHqqME3ydWvab9Zxl8TQluFS1JATrgm8CjMm2IPS09uOjK2PIZcfm2KPO75TVsXdv0JM1RcqVz2/++y28JwLr7gsw9Lw31dVxMTD8/CBmHBiNBbQyo/JbvCnbXm8Q0cAAj334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826470; c=relaxed/simple;
	bh=V269iSWamQ+V3xAvUpVPYoSFAHipEOt7nBe12tvebDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a17rHpRDucM9Fh4qbN0fbQRTchJQML1+COmTRsuCdKp2sz9zU8GNwfwrRIW2tGkIe9WAmLLh6DQ7wCovuoDcOaR4PQRDbMkx3a2Oszh0CLnphpYlFONjfMW7JjLMFsSMOtE/62Kljp6n484Uca62U5OeZpzJiv5nIgcoZw39tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRGKWaj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14C56C19425;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826470;
	bh=V269iSWamQ+V3xAvUpVPYoSFAHipEOt7nBe12tvebDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aRGKWaj2FrTRTP20mqOTeI0dgl8qk57a8yGgLw7Q9cuc5rurpI0N6HuqHeb4a0KWp
	 etLvh5etLSsqBI0lr2VkSoXv6UcjZVQfIWTzg+fXY4IJuFx0mCHDl+5TcxRxiaxXhk
	 1Qfp8Y5nFbeNex3tOsprEy5rXA94op18Y07tjjfJq2rpQa301Q4BNd3OCwDmg+4NJr
	 E5FYQx0odMgvvU7Dhi5wf6I7xXDfE4OnAPPg41F9AiMKjBKB6TThdKNo2JA002mdZQ
	 A7VifAKEpIbZ2oGE++12aXgOGH4IX5crd7XY4cxblsgU91cP4nQscdHGhwntco6kb2
	 Xib6F5q3CpSlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F5F44858;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:19 -0500
Subject: [PATCH 09/23] dmaengine: sdxi: Start functions on probe, stop on
 remove
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-9-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
In-Reply-To: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=4243;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=tB3lqNofDjvSRvVs4sn03HUYBVpXqToogjCQBXepPAM=;
 b=b5aLYMANEMiSYqDAU4NLy+2HAooZQ0C2iqepz1Ikojjx9AT7Fb74R8g9wi+JuP/T0Da713jc9
 dIsCjDhA5gnCofDaMil2HHZzDQUIlR6/RknaonzuUQpSxTa4Lm6rT89
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9964-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com]
X-Rspamd-Queue-Id: 2E82D3D7DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/dma/sdxi/device.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c    |  6 +++++
 drivers/dma/sdxi/sdxi.h   |  1 +
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 636abc410dcd..145aa098c269 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -67,6 +67,49 @@ static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
 }
 
+static int sdxi_dev_start(struct sdxi_dev *sdxi)
+{
+	unsigned long deadline;
+	enum sdxi_fn_gsv status;
+
+	status = sdxi_dev_gsv(sdxi);
+	if (status != SDXI_GSV_STOP) {
+		sdxi_err(sdxi,
+			 "can't activate busy device (unexpected gsv: %s)\n",
+			 gsv_str(status));
+		return -EIO;
+	}
+
+	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
+
+	deadline = jiffies + msecs_to_jiffies(1000);
+	do {
+		status = sdxi_dev_gsv(sdxi);
+		sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
+
+		switch (status) {
+		case SDXI_GSV_ACTIVE:
+			sdxi_dbg(sdxi, "activated\n");
+			return 0;
+		case SDXI_GSV_ERROR:
+			sdxi_err(sdxi, "went to error state\n");
+			return -EIO;
+		case SDXI_GSV_INIT:
+		case SDXI_GSV_STOP:
+			/* transitional states, wait */
+			fsleep(1000);
+			break;
+		default:
+			sdxi_err(sdxi, "unexpected gsv %u, giving up\n", status);
+			return -EIO;
+		}
+	} while (time_before(jiffies, deadline));
+
+	sdxi_err(sdxi, "activation timed out, current status %u\n",
+		sdxi_dev_gsv(sdxi));
+	return -ETIMEDOUT;
+}
+
 /* Get the device to the GSV_STOP state. */
 static int sdxi_dev_stop(struct sdxi_dev *sdxi)
 {
@@ -197,7 +240,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
-	return 0;
+	/*
+	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
+	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
+	 */
+	return sdxi_dev_start(sdxi);
 }
 
 static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
@@ -250,3 +297,10 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
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
index f3f8485e50e3..8e4dfde078ff 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -67,6 +67,11 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
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
@@ -77,6 +82,7 @@ static struct pci_driver sdxi_driver = {
 	.name = "sdxi",
 	.id_table = sdxi_id_table,
 	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
 	.sriov_configure = pci_sriov_configure_simple,
 };
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index bbc14364a5c9..426101875334 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -75,6 +75,7 @@ static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
 #define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
+void sdxi_unregister(struct device *dev);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {

-- 
2.53.0



