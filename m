Return-Path: <dmaengine+bounces-11234-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CjYXJmNkI2pysQEAu9opvQ
	(envelope-from <dmaengine+bounces-11234-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E025F64BED1
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=G9a8V13A;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11234-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11234-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0323730393BE
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428D244687;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669421ADB7;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=aXeaZbS1q2nIybVM4aSUt/MuBBl2wSny3QgpIJj2QrlwFO4FSuZ0sRFnANChYnHOHJejOblQvxTO9ETqDbAYNb5UtacXzN8cwr15+QHusNRnnY/qfOv0rX1vUxoj2+Hmal5NAP+u7k/JREZpNlrCHjfyxdQ5MxmxyLuvnD4CiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=WPoSfU5dZwZT2IZNdbcuv/ZH4xLJrv+uNXMErQMKsyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAmXXpBN0EeL6ZdC7y46eoLusoWgzbZJpgI9snw7BYc35BeQ/w29p2hB7sWFuVZeAHYKlcwleDlOptR7Y5qDfYtOxp0yNNW5exjgM9cysLbQoOAjVChTL5iIfngfjnS6yZ6uMMNI6vFTVthKu4uKRBXJwKsBDtbyWwH8SZs8x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9a8V13A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3724C2BCC9;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=WPoSfU5dZwZT2IZNdbcuv/ZH4xLJrv+uNXMErQMKsyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G9a8V13Az+EIAjhhN6gG3sXni4GAxtYj7ZzAbyWIfc5g5G0HMN7LKoXzwkt5xQmgQ
	 Q0ReJRkjDpXWo90TMR7lx9AWLkLqSGLW2mkZHC6trN/NlB/DDspvab6tyQvt8IaZFQ
	 O+JF+yz5afJP/NB2wO254lfZWPr0UDz6VPSQ95LTbl9PeorXhLwSxDKlTyegfAq5xx
	 pERINBYeyJRm4QCPYLcEHL/m66MfNTW+9eN+OMwzSQmUKIq6jrDhX6powQKIf87/MA
	 vbbVa+3ck/QfFBkxoUV8c/ySOqej5S6YNZ+kELDNf7ZjPjzi6qmRkK7X4SazMtMigr
	 eEZJBu3b64N8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F67CD6E7B;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:12 -0500
Subject: [PATCH v3 09/23] dmaengine: sdxi: Start functions on probe, stop
 on remove
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-9-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=4059;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=HJWXcsWA72TD+d9YgNYbMCtKgp6O0CoGRH3DT157Mcc=;
 b=ddgeXegAogUDZM8IolRQiz+WKYeZAUBSCUKkcdu0+1TJv9JpV+aCBwu8qucLlgssXggCygqMa
 AxX9226ioh5CZQ1dxGAaTyqo+miqWrk7KsHQYUzrrWQsMTKrKldUeUK
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11234-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E025F64BED1

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
 drivers/dma/sdxi/device.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c    |  7 +++++++
 drivers/dma/sdxi/sdxi.h   |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 4d595e79b8ce..e8f087f758fd 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -90,6 +90,42 @@ static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
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
@@ -229,7 +265,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
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
@@ -290,6 +330,14 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
+void sdxi_unregister(struct device *dev)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	sdxi_dev_stop(sdxi);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
+
 MODULE_AUTHOR("Wei Huang");
 MODULE_AUTHOR("Nathan Lynch");
 MODULE_DESCRIPTION("SDXI core");
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 42e8af008b10..4d7d6812da6d 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -63,6 +63,12 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
 }
 
+static void sdxi_pci_remove(struct pci_dev *pdev)
+{
+	pci_disable_sriov(pdev);
+	sdxi_unregister(&pdev->dev);
+}
+
 static const struct pci_device_id sdxi_id_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
 	{ }
@@ -73,6 +79,7 @@ static struct pci_driver sdxi_driver = {
 	.name = "sdxi",
 	.id_table = sdxi_id_table,
 	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
 	.sriov_configure = pci_sriov_configure_simple,
 };
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 903bf18bd3cc..a15b97135308 100644
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



