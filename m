Return-Path: <dmaengine+bounces-9012-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMALLkWrnGklJwQAu9opvQ
	(envelope-from <dmaengine+bounces-9012-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 20:32:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2836C17C678
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51E730774DA
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762436C5B9;
	Mon, 23 Feb 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zqtn5zf/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m9351.xmail.ntesmail.com (mail-m9351.xmail.ntesmail.com [103.126.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845F261B91;
	Mon, 23 Feb 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874876; cv=none; b=GmQZkIevCY8a71gMKiJnREZct35U3UZlB5jYKTAwEAzN3LRzki+qjOP4aJMPdMCAWzkOLvq5ms6zmQ4hqmhSLx8ASLfFY6JxqG0FBAG1e5b6enBSvPLMdEl6EEAaFYBoEPsiNBpBFSpLtWlYoQhLWonR5k662XlAv3agvIDiG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874876; c=relaxed/simple;
	bh=2L/FKh93MPV5kGophg0C6pX8MLANlFL0f10yaTy3C40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pM0hUIqLsLzDzgWkZlOmts5pCezuSGm6bS5WjQrqgfIhs9H3NzlqrNMQ3bfRV0cQLypMwsrZPXLXB9nlNbA8PFD2iVb92DnA96w2pHxpaLm7wbxdbu6Bnutu9IvJ/8z/iYalh41kRfwmkv44yhPFwI9AiCO1r6UxFYeQTXfHqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Zqtn5zf/; arc=none smtp.client-ip=103.126.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b40464a;
	Mon, 23 Feb 2026 23:58:34 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 31/37] dmaengine: hsu: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:58:29 +0800
Message-Id: <1771862309-90704-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b394c3409cckunm5e636e1c988147
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMZTVYYHRhDSUsZQ0gZH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Zqtn5zf/3UWyvO7kuknzAY2sx7IQpF35TqXSuB9In2S2hHnWURZkjbmNjJMGATCSPYaLYFziBHVRbtqLEyOmeSqDPFaQWnxRelzZf1nq4/9pl3PVG+cHoDxGLPiPOl1RM/DKBPm2Zgo63n+eEhbagD8z1VcOTYmX1XKxWOjyf18=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=LfBaF8G6Xu45gPriRlnFlplC/GTc9R466EcHXSZhokE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9012-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2836C17C678
X-Rspamd-Action: no action

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/dma/hsu/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 0fcc0c0..2a306c9 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -77,7 +77,7 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!chip)
 		return -ENOMEM;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	ret = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4


