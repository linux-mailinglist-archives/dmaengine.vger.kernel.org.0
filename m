Return-Path: <dmaengine+bounces-11835-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ZpUK84wQmod1gkAu9opvQ
	(envelope-from <dmaengine+bounces-11835-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2F6D7A24
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=TNyvYgTC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11835-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11835-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA38E30315D5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD63F8712;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848323F86E2;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722723; cv=none; b=FpCOvL62wpGoey03xw3D4lX0jggESWGHkAZH1aSPNgr+cIFg1OEJYF9km5NyHSy0++2LVkwpWimk/uDV8WT6e+L3Zvt4cak9qymd9LsMNR9cIGY5j2qiOKjnxW4Sa1/Y1vt2avfCEakC/XpXYF0lLJdxQQZO3eRRU3kRWpkNZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722723; c=relaxed/simple;
	bh=reftIFeUgKhnc1iAVbEDUSI9XjHq9Yk4tx7Q1PVaD50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB6zCqmBGiR9E/IFsfr0K831aC0lJDxe8BSzg1WarEV5TyCVkXFi35qjvFw2AWUnZX+6boLRGJHVCpj/MCX/Ay8XM58trt8Y9fejlu1Sccs+P11vM3tZ8GjuivBJdG0lNw0m4qDFf2bik7k47WIFgY8B68wnjQQRj5UmkQmFd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNyvYgTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D874C2BCF5;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782722723;
	bh=reftIFeUgKhnc1iAVbEDUSI9XjHq9Yk4tx7Q1PVaD50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TNyvYgTClqgo1j7P5Nb0O52+LdMwPVL/hV1jomvO4U2blojlZvmsdphoDNePUgmMf
	 8OiBOWUBtVCrG8+q+I1L4zC/muaIBEXko9lPu6cJ8GbfnMY5fUbJTYPkv9Qz8BnW+y
	 yAP915HQayj15cSfuFQApgN4hXo1DgZAi6cdeXLygUa1YwSwfdggQw9XwTcEy58Tj0
	 ZtDIBPkUJQIBfc5UINczR805LQokhl+hMJDZbB2a8LU42gU8A+kizjC0mCC7VTL7G5
	 tlSChLHH9rK+kGoeAIK/M8JPwX5WLk0yK/ORrHnwH9d5yU4WRBgLlIZnQAjVMo5DgG
	 dMYQkFn2XiQAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C6C44500;
	Mon, 29 Jun 2026 08:45:23 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 29 Jun 2026 10:45:17 +0200
Subject: [PATCH 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async() to
 flush DMA read/write
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mhi-ep-flush-v1-3-714e0d56e87c@oss.qualcomm.com>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
In-Reply-To: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=6kmdgZDkb501ndoKxVtZpRbgIocrT3lKCXqM3E18s10=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqQjCgg32WfkoOyQDe0010CIPW9M5xzski+VELv
 GJJE0fdxgCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCakIwoAAKCRBVnxHm/pHO
 9aIdB/4wkf9ykjwyXmdimom30TMLFiuC+j5GTn8ORd9rJvEkP2eDd4cP8QXR0Y31UxvnoTFx1n8
 UNUk3a3X0Y8nTrTemtw8r75nf/Y2UjtakOtn1ZA8cVzOuqu8ySG2dlP/SZMntHowEQwNMAufBPJ
 1MM3M44tnBIEqIn4Qce2k92HAfxsHUx0rYdf1o7kdVjdjfP3lSAIC7TENM/VXd6poQwfw6TN8+g
 XlHheC33SSKtWXqDS/orXhw2r7QLI2vIyeI5H5rPVuCENj6nOmiw3mc7uhwv1x8+x8bre4JmHYV
 ywx8Qt1fG7VAyxRetSUmJl2qq1dN0Zs4n1KEFH1AGo/P/7i2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11835-lists,dmaengine=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:replyto,oss.qualcomm.com:mid,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50B2F6D7A24

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The MHI core needs to make sure that all the current DMA transactions are
completed before removing the channels. So implement the
mhi_cntrl->flush_async() callback by first making sure all the in-flight
DMA operations are completed and then flushing the DMA workqueue.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed5..4af3689921a3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	return ret;
 }
 
+static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+
+	dmaengine_terminate_sync(epf_mhi->dma_chan_rx);
+	dmaengine_terminate_sync(epf_mhi->dma_chan_tx);
+	flush_workqueue(epf_mhi->dma_wq);
+}
+
 struct epf_dma_filter {
 	struct device *dev;
 	u32 dma_mask;
@@ -812,6 +821,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
 		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
 		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
+		mhi_cntrl->flush_async = pci_epf_mhi_edma_flush_async;
 	}
 
 	/* Register the MHI EP controller */

-- 
2.43.0



