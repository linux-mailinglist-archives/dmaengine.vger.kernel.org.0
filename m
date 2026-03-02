Return-Path: <dmaengine+bounces-9198-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INyaE0APpmnlJgAAu9opvQ
	(envelope-from <dmaengine+bounces-9198-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:29:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F31E5712
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F14030825FF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3A31E837;
	Mon,  2 Mar 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Y+zUGUAn"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA12773D3;
	Mon,  2 Mar 2026 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489766; cv=none; b=FRWc83tEYfnwr7R6wNFPlOYR54J/reu+pqXTOuj4M4iWeVW+7F+sQTHoq9yxvGyjiIc/hZMUcmPF83w+gT7OySYks82r2aPTxurOZVVGfMpi91WgMN400KkFPBGhwCdiFGjzb6afYwYnefr2BpmN9c5o7DbGCisOTqiX6DXAhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489766; c=relaxed/simple;
	bh=8qssZhIohoDDRPi+YpLr+uyOfmbuE0gxulu87WlTB7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH/eRY9p8l0zqVDIT+uYnuJiY5CLeTJM9xuuZ9SDeApla018Ssdo4rzv8sqfom9i/lA4qL+sZGZRilH4bUNQzpTq7Ekv6SAtsavFjC1rZN+bkben/ez2PmwXTilCGQNQnRtd4BvqnsRe+rsXYffV0R0ClLp/42Y/lQlFkV7PNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Y+zUGUAn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772489757;
	bh=8qssZhIohoDDRPi+YpLr+uyOfmbuE0gxulu87WlTB7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y+zUGUAn66T8KY5lKVXH/XER7FhjZ3KNDNKMXXyCPZReIUKSa3dJMb2B0kdMYd9pP
	 5QYbRHqqFtjprGOJyIL6ny8uGw8cfkYWxWqeQUvzOEWzOXvwVryMvPyEUBJ5K9ukTq
	 6CzzSzXN/ECATCBibXbRmMPSTD5cKE5x9USdxu2Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Mar 2026 23:15:55 +0100
Subject: [PATCH 3/4] dmaengine: ioatdma: make ioat_ktype const
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-sysfs-const-ioat-v1-3-1229ee1c83f3@weissschuh.net>
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
In-Reply-To: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772489756; l=2006;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8qssZhIohoDDRPi+YpLr+uyOfmbuE0gxulu87WlTB7k=;
 b=q9lshFTjon3XTRnnsrCJWEEC8v3SCBoVYGY1TX2YjL3vxGTlnO0ZdBiK1XtoYt4upQNitfQNe
 2J644+kEoGUDh5+ztJb4a9HOQ3nQBdYlA82NcQ6MI9QO2ZIo0NbeYQM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: C04F31E5712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9198-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid]
X-Rspamd-Action: no action

This structure is never modified, mark is as read-only.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/dma/ioat/dma.h   | 4 ++--
 drivers/dma/ioat/sysfs.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index e187f3a7e968..e8a880f338c6 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -190,7 +190,7 @@ struct ioat_ring_ent {
 };
 
 extern int ioat_pending_level;
-extern struct kobj_type ioat_ktype;
+extern const struct kobj_type ioat_ktype;
 extern struct kmem_cache *ioat_cache;
 extern struct kmem_cache *ioat_sed_cache;
 
@@ -393,7 +393,7 @@ void ioat_issue_pending(struct dma_chan *chan);
 /* IOAT Init functions */
 bool is_bwd_ioat(struct pci_dev *pdev);
 struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *iobase);
-void ioat_kobject_add(struct ioatdma_device *ioat_dma, struct kobj_type *type);
+void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type);
 void ioat_kobject_del(struct ioatdma_device *ioat_dma);
 int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma);
 void ioat_stop(struct ioatdma_chan *ioat_chan);
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index 709d672bae51..da616365fef5 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -78,7 +78,7 @@ static const struct sysfs_ops ioat_sysfs_ops = {
 	.store  = ioat_attr_store,
 };
 
-void ioat_kobject_add(struct ioatdma_device *ioat_dma, struct kobj_type *type)
+void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type)
 {
 	struct dma_device *dma = &ioat_dma->dma_dev;
 	struct dma_chan *c;
@@ -166,7 +166,7 @@ static struct attribute *ioat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ioat);
 
-struct kobj_type ioat_ktype = {
+const struct kobj_type ioat_ktype = {
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };

-- 
2.53.0


