Return-Path: <dmaengine+bounces-11514-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WdjZIBfEL2qkGAUAu9opvQ
	(envelope-from <dmaengine+bounces-11514-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:21:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10268504C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 11:21:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11514-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11514-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526563034E30
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE3391E43;
	Mon, 15 Jun 2026 09:16:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCC27A10F;
	Mon, 15 Jun 2026 09:16:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515015; cv=none; b=QBIJiyi/Bf4nqzDhFfWEIS/bCbIEJXF6xuN9Ffk7z6LD4uyD/h5wtZzvVFw3fTKSMts472YighO71f4NKx2frYNvmjdVITh+aSMV+R+1HkXqFYJBA+bh0E3H/usgMuRf9CCf2ii/0707PqnUYPI6Qk7x0458HstbGkKdrhtrA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515015; c=relaxed/simple;
	bh=2xRjKSXlyH6YqnWe6SV1jh+WbNeJ+lkhOaDslZCaxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/v2uQItDxOXSyooEEzx4WEkcszoGhmZVOx8FCO2cW6FPp9nSbfL3DIyuSUNNgOqHL8ssZyVWz9vOpBUds76wabChujb5Ypz4qfSuWpIVR7ZOO3T7ZKbYhb6RR9JBaaOsVjwdK5AWlluIUJbbw5+OtN67st6ebQhABFolSnfdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAXN94Cwy9q0IHLFA--.1549S2;
	Mon, 15 Jun 2026 17:16:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] dmaengine: pl330: remove debugfs file on teardown
Date: Mon, 15 Jun 2026 17:16:45 +0800
Message-ID: <20260615091645.28878-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXN94Cwy9q0IHLFA--.1549S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxtFyUXr48GFyxAr48tFb_yoW8Aw17p3
	WDGa45Ar47ury3Way3Ar48tFyfW3s5Z3W3G393Cw1rZ3WrXwn0qFykXrWjyrWrXrW8JFyI
	vw45tryruF47twUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11514-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA10268504C

init_pl330_debugfs() creates a debugfs file with struct pl330_dmac as
private data. pl330_remove() then unregisters the DMA device and frees
the PL330 channel/thread state without removing that file.

Keep the debugfs dentry and remove it before tearing down the DMAC state
used by the debugfs show callback.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/dma/pl330.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 25ba84b18704..6214d9000db8 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -502,6 +502,7 @@ struct pl330_dmac {
 	struct dma_pl330_chan *peripherals; /* keep at end */
 	int quirks;
 
+	struct dentry		*dbgfs;
 	struct reset_control	*rstc;
 	struct reset_control	*rstc_ocp;
 };
@@ -2952,14 +2953,24 @@ DEFINE_SHOW_ATTRIBUTE(pl330_debugfs);
 
 static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
 {
-	debugfs_create_file(dev_name(pl330->ddma.dev),
-			    S_IFREG | 0444, NULL, pl330,
-			    &pl330_debugfs_fops);
+	pl330->dbgfs = debugfs_create_file(dev_name(pl330->ddma.dev),
+					   S_IFREG | 0444, NULL, pl330,
+					   &pl330_debugfs_fops);
+}
+
+static inline void deinit_pl330_debugfs(struct pl330_dmac *pl330)
+{
+	debugfs_remove(pl330->dbgfs);
+	pl330->dbgfs = NULL;
 }
 #else
 static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
 {
 }
+
+static inline void deinit_pl330_debugfs(struct pl330_dmac *pl330)
+{
+}
 #endif
 
 /*
@@ -3204,6 +3215,8 @@ static void pl330_remove(struct amba_device *adev)
 	struct dma_pl330_chan *pch, *_p;
 	int i, irq;
 
+	deinit_pl330_debugfs(pl330);
+
 	pm_runtime_get_noresume(pl330->ddma.dev);
 
 	if (adev->dev.of_node)
-- 
2.50.1 (Apple Git-155)


