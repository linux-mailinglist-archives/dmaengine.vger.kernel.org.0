Return-Path: <dmaengine+bounces-9006-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGmJOsp6nGlfIAQAu9opvQ
	(envelope-from <dmaengine+bounces-9006-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:05:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CE17951F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCE913037990
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544A2EC09B;
	Mon, 23 Feb 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UTpZqEwy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE71EFFA1;
	Mon, 23 Feb 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862644; cv=none; b=G83kz4P/HMytp/l3FrUaKsIfzTmdbMLFucv3e36FcA4h4zgCuNwunCa5yHVg4iQOpQCiQmRtRtgOxi1yaQv+SdWJe+2pAGbcYmO8mLQswRcTzW4VTxZiz6Lnf+lEoRf2dHp4g7x4bBTque6eRfmbs58K3tbU6PGH6OdoFxwy08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862644; c=relaxed/simple;
	bh=B68G3eOnyOqxTj5AA/8XvZLmahMD3o0Ff92FbJd3ZnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oP3CEmB67sGhBj5h0RbetkKUMHHRGHtta/jNvHvTXeZHN1jsw1lr2QsqYUo0ulTKT6H6MBkLmvCvB8biB30heXzugzMnoo4RAAecNSVXjeLdMaUT6iWyhaENV2FoDnwbGA7r/XP2sMpnaGleahjBjh6gJbPrlQc+99Q1u+eOtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UTpZqEwy; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b404651;
	Mon, 23 Feb 2026 23:58:49 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 32/37] dmaengine: hisilicon: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:58:44 +0800
Message-Id: <1771862324-90758-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b3987ec09cckunm6530222898817f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hNQlZDTx4YSx0YSkpJHRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UTpZqEwybR0klUNx+gUiKRAOsLuHtfGyw7UdZmhPxSmMYQcfnT9+b16kdR3mpp9JLF4sNG4O+aHKPJ6jdAhVVA9mw8QB+KJlF4ZmB8w4s4NSq8b6q/KFX5F38EldbaKN/EMv8XwhcyNJGrihH50Wq3LSkfHIlKlKadDTSLokn7s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=eThU8kDk2ctXy0Q1mnJ+q8MBJiveuGeTtNhKsUAeFT4=;
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
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9006-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D9CE17951F
X-Rspamd-Action: no action

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Zhou Wang <wangzhou1@hisilicon.com>
To: Longfang Liu <liulongfang@huawei.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/dma/hisi_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 25a4134..d35c5d63 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -997,8 +997,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	msi_num = hisi_dma_get_msi_num(pdev);
 
-	/* This will be freed by 'pcim_release()'. See 'pcim_enable_device()' */
-	ret = pci_alloc_irq_vectors(pdev, msi_num, msi_num, PCI_IRQ_MSI);
+	ret = pcim_alloc_irq_vectors(pdev, msi_num, msi_num, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(dev, "Failed to allocate MSI vectors!\n");
 		return ret;
-- 
2.7.4


