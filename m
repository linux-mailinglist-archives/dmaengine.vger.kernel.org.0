Return-Path: <dmaengine+bounces-12489-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H9FEBHcoVmo20QAAu9opvQ
	(envelope-from <dmaengine+bounces-12489-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEDE75460E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 14:15:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12489-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12489-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=qualcomm.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6DF430273B0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF13932EA;
	Tue, 14 Jul 2026 12:08:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE4233927;
	Tue, 14 Jul 2026 12:08:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030933; cv=none; b=Esth0f30Fhms8fdiJr8jJfvs25TQk6P8lUl40YvANT9ULf6V9TAgv3bOUZnYFcn/vZh6qjMLG1wv0j2Ud4AykJk2MC743fBOuaarLiGST9OV9SAkRAfkNDorf74L/xYhsEHK32m3dE16ydUqdy6L4TdA1JEck13ZWbT6wfPZw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030933; c=relaxed/simple;
	bh=CAf5d0186GbDQc5vF4vjJfYbcL7CeD4WLO0TdSl/VYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwbwu0FlIF+CWfnejgN3KJzZGJBECJlazXKRpx+QQkld2pM0AF+uXescabkdR66n4S819mnM4b938dV6r6W2vxhUKYnhHAMH08fGRprI7dtmiramgVPy9fk9djsfBbmvIvP0sAZl5XVKQdCKodo+nQoiDepZhTRTB0IFsV6ZbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86981F000E9;
	Tue, 14 Jul 2026 12:08:48 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 0/3] bus: mhi: ep: Implement flush_async() callback to
 flush async read/write
Date: Tue, 14 Jul 2026 14:08:31 +0200
Message-Id: <20260714-mhi-ep-flush-v2-0-b6a9db011e85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL8mVmoC/1WNQQ6CMBREr0K6tqRthIIr72FYQPnYb4BiPxAN4
 e62GBduJnnJzJuNEXgEYpdkYx5WJHRjAHVKmLH1eAeObWCmhMpFrjQfLHKYeNcvZHmTiUwoLYu
 6bFmYTB46fB26W/VlWpoHmDk6YsMizc6/j79Vxt5PXf6rV8kF1/IMos1yKLS5OqL0udS9ccOQh
 mDVvu8fDvYXIcEAAAA=
X-Change-ID: 20260627-mhi-ep-flush-b50502718a9d
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CAf5d0186GbDQc5vF4vjJfYbcL7CeD4WLO0TdSl/VYg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqVibP3E0IwvB7PK0gHFZEL0bVG14mPKVm4SWAJ
 NFhFQ6OH16JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCalYmzwAKCRBVnxHm/pHO
 9YNpB/9qI1DuVmAm37v2h631k9/TzJHusGCT/ETqBJdj9iBhrZliu7IzuvOKIkZle206j7vGQeo
 qEt+/eJs/pPJgcw0INQQSJ6ZfJvoiIfSfoMXmONUsEZeVVotGzLTsmxbLEGNQ1L3uWIUoa0WAZi
 XssiAvWxI6Vj2HL+GPOHe5D4HMfrQRhvQcbKRU8fEwqjhBxtSvmVxU98U8QxnnXPNuiFoUsLZN1
 7BUxwAm6dGBDEswRVjenIgqlS3TdAxiLj50QWsFJ+6Yaa7Tc5xulsDCmpo4oMWPRLSdbPuVlnB8
 S6hiqHswIF0lp1TI0y0I9wOABpRTQE6xT3SLNNFdxvGv+4et
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[qualcomm.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:stable+noautosel@kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manivannan.sadhasivam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12489-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,noautosel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,qualcomm.com:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FEDE75460E

Hi,

This series introduces a new mhi_cntrl->flush_async() callback to flush the
async read/write operations performed by the MHI controller using offload
mechanisms such as DMA.

The MHI EPF driver implements this callback by flushing the DMA wq. With this
series, the MHI EP stack can guarnatee that the channel specific xfer_cb() won't
be run after calling mhi_ep_remove().

Merge Strategy
==============

The dmaengine driver change can go separately as there is no build dependency.
But both MHI and PCI EP changes should go together. I'm planning to take both
MHI and PCI EP patches through MHI tree.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Switched to read_poll_timeout() in dw_edma_device_synchronize()
- Switched to dmaengine_synchronize() in pci_epf_mhi_edma_flush_async()
- Link to v1: https://patch.msgid.link/20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com

---
Manivannan Sadhasivam (3):
      dmaengine: dw-edma: Implement device_synchronize() callback
      bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
      PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write

 drivers/bus/mhi/ep/main.c                    |  7 +++++++
 drivers/dma/dw-edma/dw-edma-core.c           | 16 ++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 ++++++++++
 include/linux/mhi_ep.h                       |  2 ++
 4 files changed, 35 insertions(+)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260627-mhi-ep-flush-b50502718a9d

Best regards,
--  
மணிவண்ணன் சதாசிவம்


