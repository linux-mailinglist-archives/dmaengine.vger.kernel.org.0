Return-Path: <dmaengine+bounces-12076-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ApWUJ/ctTWrfwAEAu9opvQ
	(envelope-from <dmaengine+bounces-12076-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:48:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24D71E00B
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=ZrES2Itp;
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12076-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12076-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E932304C076
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854C26C3B0;
	Tue,  7 Jul 2026 16:45:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AC3EB0FF
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:45:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442730; cv=none; b=Bd+PwWhyhHLIMyXv5q94IYvx5xqDBuweeEd83S1ZSs5N5GfQBvPphKXOJ2EEy2lZJUdqhGEBgLf42LK7nK8Cl5S1VoMGx+Dfx6QwbKUByASbuDTwmxbffcW6NmS2R57KWwDFEOj5nadQw7NnWfZwtBZw2ZXTNgcIT8dPbbiAYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442730; c=relaxed/simple;
	bh=69IkVR1obmhAaLPy1Xz5K8VkxegrHP8IYcTfO+k/oOE=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=YQaUpSry74h4hY/2v/c0/2dMKe9pj0yDn4+8USdg/lN4vAry2+nrOtCUj41KKwVioltttBeDsfKGtNAHuXAiunPh5lF5qLc1dc/Gkx605H02He3yCREp4m2UaK8mB1H1tYw981CjRjKGoxutbVzSAV6DxU/nfkukkLuDvbkXeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ZrES2Itp; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=cPWIxRsF0gFTWfsrJMJIFFkkBkHrxAI7oqsYsUar8rM=; b=ZrES2Itp7tLvbJ8BHSeZuWJK4W
	Go7KhT47qLpkWxWVzMFwnLKqzT8alytFsUv/R+sVSw7tG1QHeD12u5wZgQLYISVDttwjAV+qaRwTZ
	y78q+lLwBdw5l2uwKjEeTXsgqYB/kygLNk1B7iynt2TdSzjYBuTeiNg9RSG/SGOkR8iA9c4c+54bf
	/bkU1wGKRIRjfBAnbFa00/PNj/Qt4KsdQNFE5oPlDQZWncXuZ3XjF6C7YHUg/PkylCcIf8xcJV4xW
	0TofdVpR0E1OLU34VBDdSm5NUmBbZB3D1ncXpsmoDJtm9dI47FWlZVf2ZG5/4KL7hskB07BWD2EBL
	TcBPI6/w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8vI-00000000o7p-1A0m;
	Tue, 07 Jul 2026 10:45:28 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8XR-000000006EK-3494;
	Tue, 07 Jul 2026 10:20:49 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Dave Jiang <dave.jiang@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  7 Jul 2026 10:20:45 -0600
Message-ID: <20260707162045.23910-6-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707162045.23910-1-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, dave.jiang@intel.com, linux@weissschuh.net, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 5/5] dmaengine: switchtec-dma: Add PCI1008 device ID
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,infradead.org,wanadoo.fr,intel.com,weissschuh.net,microchip.com,deltatee.com];
	TAGGED_FROM(0.00)[bounces-12076-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.li@nxp.com,m:hch@infradead.org,m:christophe.jaillet@wanadoo.fr,m:dave.jiang@intel.com,m:linux@weissschuh.net,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD24D71E00B

Add the missing PC1008 device ID for switchtec-dma.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 2ac43eb58995..0a268b6a3ccc 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1764,6 +1764,7 @@ static const struct pci_device_id switchtec_dma_pci_tbl[] = {
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1008), /* PCI1008 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
-- 
2.47.3


