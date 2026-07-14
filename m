Return-Path: <dmaengine+bounces-12511-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5MgWNR2oVmo0/wAAu9opvQ
	(envelope-from <dmaengine+bounces-12511-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:20:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FB758F06
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:20:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=GGMwoOiQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12511-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12511-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C23E3056690
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA34429CD1;
	Tue, 14 Jul 2026 21:20:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3061D5174;
	Tue, 14 Jul 2026 21:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064025; cv=none; b=LR55yKo/dxnLJ6FPbNqhntCVceOMRe0+rf9iG1kPGSR+823aIxQoYsf6vNqPrsxYjWimww8tMILGWcgt5dgLiJMji9YDX6vZ48Txqco+g3nplzgYQJitr4G4ggSinD18WrO84DW0tD3qCKN+G4UkK7UkheFfx5xspo+CD7zdYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064025; c=relaxed/simple;
	bh=z9Gxuh/Dt05kJXlqMcIhnAemHTp8QVE5i0GXnQaESHM=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=m9loss8MxDVPNHd6jqHW86AyWkDHJ+YRiWqH+0eZ3x5Z/FcLuHUfwviw2XyrnFOHvz+BQtoplwTTovAY/hAw07cTOWQhoRTnXgvqS3wH2w8Qoy5Wv3ZQJqIJrsLP1ycOhGh4H9qgtOYvtN/Dxo/Nhlu1vN4gAMMSmUgEMm1ZzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=GGMwoOiQ; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=RanvKWdqE7PxDfAt0XbCflGF/7iA8K0VHBo9V/3cIBI=; b=GGMwoOiQKLYsf5wxswI6IV5RLm
	Pg1C7DHyr0SM6JtCpbmnBg8iyQRsPwauOKQqlp94XQ267gl/xwZyTo7TppXgiHgVKFZA7ZlIpGn+/
	H+Ja6z4IZlflaQJw3g7lKo5ktBMWyRgG6SfVpEICgeFvg1qUVcjFRNvSR+6NeiqpnYkHibKYo5XXq
	++3Jnpe9sMK45S7FfM/h2jGSzuX1aeYStM56oUS2nEWN6jmM0Cdbau85VDRBVPusuWJT1GMSTaXvY
	qRfFp/2ICBKLs/gbrxZ7AST33efSghcfn2Z2pUT3A6TcJELQF3YQDGPny4zjt97NOP6NyPZ7zqRJZ
	hwE9jU+A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY3-00000006f2S-14qG;
	Tue, 14 Jul 2026 15:20:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY2-00000000xzw-0jBs;
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
Date: Tue, 14 Jul 2026 15:20:10 -0600
Message-ID: <20260714212010.230606-4-logang@deltatee.com>
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
Subject: [PATCH v1 3/3] PCI: Add PCI1008 to switchtec NTB DMA alias quirk
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12511-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 363FB758F06

Add the PCI1008 device ID to the quirk_switchtec_ntb_dma_alias
PCI fixup table. Without it, DMA transactions from a PCI1008 switch's
NTB function are not given the correct requester ID alias, which can
misdirect them under an IOMMU.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..44ccee48349c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6090,6 +6090,7 @@ SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
 SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
 SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
 SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
+SWITCHTEC_PCI100X_QUIRK(0x1008);  /* PCI1008XG4 */
 
 
 /*
-- 
2.47.3


