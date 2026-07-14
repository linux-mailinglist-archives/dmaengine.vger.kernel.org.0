Return-Path: <dmaengine+bounces-12512-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQVEFzSoVmo5/wAAu9opvQ
	(envelope-from <dmaengine+bounces-12512-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:20:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC9758F17
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=aqO61bWi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12512-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12512-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C27F312E197
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAC429CD5;
	Tue, 14 Jul 2026 21:20:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3842701CB;
	Tue, 14 Jul 2026 21:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064025; cv=none; b=ipkCSQEsKd7uKFC4e+rPXkMoMld0F0p0ZeR3OFy7tmwXZIg6KyNfNHtqjnUuTXPvZXL9AVw7xcBPlq/3bDVgTB5PRflkS1tVR8fVS3iAW1LIH/vOVEBQtIuHwR2GPyZ0hURoePYi5UAwPaYSfD8Qr0gENMqNi5Dxd8D+TBtvaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064025; c=relaxed/simple;
	bh=CdZnZFphkNp1YYqrIsvGLAO40Yy/hpFwGZB9OySp8wM=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=E0/33gfvnQNtNU4lf3N6kqZEevUX6z+SKYtDLhRX9Ow3FBxddGkCAQfRjQFrR86nyKuRZi3c6hPdZRMqVMPMQNAtDVbPh4sSED+6aLUw1vnobtoteCQolH0Jg7ttG9VfKrQXLQJ9RoX7bIe4BZ59QK2OmUpyO4aZ3LEk9RAk7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aqO61bWi; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=YlRvQkFmo2h5DWERnI0RBhwdJH2WAHvxSJcGNqwuKZs=; b=aqO61bWivtZtpFT5CetA8WPoAA
	My4zXS3E4xx7ID21MlcvQ3y1ClbIWtHbJcKu/PuGEw++SwONLStljKAbt1Zx7tx6yNuoCYtL5fSX/
	HFTfyLpWrnFcUMqZUOTsz/e8yvcphPexwlCLPCeoOV5fAVrNv3p+DcwmtITlhZXI5+EJziT7h4hIm
	trRbAx/FfVkvYc6fACGkWdrzENq3DVfDwKw88cJGdiCV29wzjDJzWMROHHToXrzmpDgxnAwLRh838
	O8JTAyuNuM8xcydioIKFotsZXrS0Sj7F4zmSsyqubWOb+a0McjIEpkbicsUtEvhFsrvtV/Thiz3uI
	+dUyTClQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY3-00000006f2R-14oC;
	Tue, 14 Jul 2026 15:20:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY2-00000000xzs-09Mw;
	Tue, 14 Jul 2026 15:20:14 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jul 2026 15:20:09 -0600
Message-ID: <20260714212010.230606-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714212010.230606-1-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 2/3] PCI/switch: switchtec: Add PCI1008 device ID
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12512-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:bhelgaas@google.com,m:Frank.li@nxp.com,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[deltatee.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACDC9758F17

Add the PCI1008 device ID to the core switchtec management
driver's PCI ID table. Without it, the management endpoint on a
PCI1008 switch is not bound by this driver, preventing userspace
tools from configuring or monitoring the switch and leaving NTB
functionality unavailable.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 41fc4b512708..5711aaa5df11 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1874,6 +1874,7 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1008, SWITCHTEC_GEN4),  /* PCI1008 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.47.3


