Return-Path: <dmaengine+bounces-10936-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMfsGdWBFWoHWQcAu9opvQ
	(envelope-from <dmaengine+bounces-10936-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:19:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD55D4C81
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49887300EDBC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E423E00A7;
	Tue, 26 May 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j3b7ja6e"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F43E0232;
	Tue, 26 May 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794387; cv=fail; b=UE/SF/8Inn+K7/Z9gwlBqgde54DYDLKMbavlArKEv2C2r1oVSKxEZs4cvP1Lg3VQSVnBiOUsyNW08Rfvw+/Y9SjGYkOoTHgsrlI4TCcZkpXo3cqVs7Ultw+T+Iz1yFgWfTYdlMimYi9LbFmbpFZRdhnmYiIMlZcbTR1MRX0s6SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794387; c=relaxed/simple;
	bh=C8Hk4R8wBGA+tsWYpl8pAFMytjunPfJgVbxd0M23vxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=therkrlp1fM61TLK9QQlwYL0C33IHv4TBDGa3fU1qu860D7poGGxtugrX4ueZqXcc7j9sk/XmtnZqFK9nj52+LFHdTx0t8scFQgl9XbdXLAA/MUXRHbdHp1V5pmq1y+3H3ZD0E3gUDDPJwJ8d5vm68+FDJXpnh6ygR94acNmLlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j3b7ja6e; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXM+463REhno2BErVlFEKK1VwQydYBdMDxDkih9nXvBgpEkjFBc5lJve7HGdhrvpl/AtqoXl0B6xm3SiM5wYnu3lmVSRG+E75MxwjkkdHw/XRLkQs0w+Y7Iu56lRaMhITZDtk9Pz89gn79jIe5mE5sUJ6ywNl760q6+mB2l6RWbuOhFLGjCZq1r++8bqd3AoeECtiOsQ+YC7RD16gm3G6LoCYIXuApimL74DDO33auq57RB40n8124V9BBgwC7N0t0EbaES8uO4+tHKgShVahu2AoO7VKOuJqY9wbGMnqEFm2n5I/EayAu+7AX1iFNYKXuy0DmGXMMYvz6SM5nJa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/bkA5J5O3NEArqBbuti9+xEhNmQiZ0piEYR5LfNFjE=;
 b=cbVYF7O9btCbqDlINVxysvYzU8HcsT+E+qgogVlIU/sTOnqVMLy+rXv9ATgQw1o3GiIGaXMCDnKcD0FVTglyqGaSBEZlDB/ffUtl/GvhBjoLTKp8j1+MVw03lv+DQEcSldii67YrBZ7jz3WtnrHHmzQesvaxsRmmDo2MWc5M8cmVFV2jzDW6lDSkfCnmkk6CCPi65vMQCJRPnRFQjtwbeXwxACQiXOLWtE/vecbpzynvVwwBWVCK4pHO/rs41u+qpsj1d9pLe2uVRGvuhKTr6dOY8ly6HWZIMMC1VFoDH5ynPNh3QOrJ6ib8EQWIJYYR39ncYJ7zbtzL1CK1Lrg2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/bkA5J5O3NEArqBbuti9+xEhNmQiZ0piEYR5LfNFjE=;
 b=j3b7ja6eCXZ5HjEh+iJ1T4oig7zMh/ufF6wmlLJeyW926SiYxSsBgrUn5L206nwYNauD2HUAz5Q5rWsptjIAVRe1R4JP62Bxzr0gWciyqpwz5XzUA9gQthNem1UA8GGs20/dVilRBW0ozgpr64QQ1+bXvLFm4NiotvCtzdejTzo=
Received: from CY5P221CA0162.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::28)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:19:38 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:930:6a:cafe::9) by CY5P221CA0162.outlook.office365.com
 (2603:10b6:930:6a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 11:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:19:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 06:19:35 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 26 May 2026 11:19:19 +0000
Subject: [PATCH v2 2/2] dmaengine: fix use-after-free in dma_chan_put() and
 dma_release_channel()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260526-dmaengine-kref-fix-v2-2-3df60afac01d@amd.com>
References: <20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com>
In-Reply-To: <20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794371; l=2820;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=C8Hk4R8wBGA+tsWYpl8pAFMytjunPfJgVbxd0M23vxc=;
 b=n9RRJHTQc4LWyeTKIjJZ8aXhyDavq4i72BGoxj9Xa2s2U4GCJBzDptrGOIeihnqPcJ94/Pien
 pN6v7lYT0iUCMUAi4H/lm7hXQ2hBlVs28LxhUyWAVjWJDwrSE9mnirQ
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 488e3a2b-b8f0-48bc-2898-08debb18ac93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|13003099007|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SklYBFgoCbft84GOJzIviUBVyaYh4CzwqZAtCuRjab5yDr78zSXte1bbRqRahJDDSSEaABm5V4tfcfJ6Zs+sfX0scCDY6nhDPTdDMHBAdkKdrzwZ9VSICQ8fYm9YjqNOlLqWIcV/dKutrMdddoXS4KfAOnEi2Nu2XfnjIHEkRf4awDWz1pEu01cn84Qy3rTMf/slWRCwpm2Cr+AvHddAS4PlDXuXWSZ21clO6McEG1TAARkmKksgcAI8GiyRsDIFO8ywvrLq4SMATHHulSE0IfzvStZjLqrN0bpiyVSHBbHEUwoOVrFlR/zzhZY+bjoQMphIx5J+ebloyEA6Txpiegdma7wYWoR/S2en6mFTF34WcI+hXCNrioKopbOFFch4Ar8zQyWO+4UiafiCdPf2o8DFkZFc1zeSqp2y+IbRGSTI44AsezsbGcS6jtdR9E8w3PyFeV90IqZiP5Ns0PpyqXqIsw/AL1GpseYDnL4Spyxkt3JEjDMC+SH+cVOT7/CsMSq8jLhq3+1npuTUldQs3UYsomUcvO0+eDTHBpWDL9fnCa2EXO8QHzKBoO7bJBzB1Ohu9Im/ugACu6bFDpG2zdDRqGS12itKl4uA5gZngmGNUcM1uqtq5jfxQIk4MCbFK/SCmvenF0erly/pYeW+WNs3DQOyqS5apNtYRMq0uT4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9268ngMYhYH87r6KHGSg9bFICbluYX2pJ1RLjMPQLjs4EHJbJX8rqjtNpdF+7Ak62JcAiEx4G52XrjdsOxZr36H+7QLRIhCWe10hgtH8btxbShEwhsNNFdi1zF0VGufeTuqzIDBZsNy5sHVICG9qQDQiWke5xFTDhv1E/SlVMtiZN7hWeHpruPlpv2F9cABMf990BXm2R9tWDOXyOpkshKBh8V2Ne9bhKlZcIkAxO76urQmlQnFBwNb736wzb4yIy+ulIkYzCbjAWvbmSMXAMw8q4fy4RlrXpOiZ9MwDmkskL6YT8ODH5xKv6xHj5j1PcNRR7quOCuu9KCmDzVAcbcR5e53yAIIktNpCyD9BqcXwYy97Wu+wWoiL9NCR5chA4wXWWXPIRcIxGMn76ndY3J2pwpnMjhXepkXkPIEJQ7iWg/rFV/pT+kLVChNWd/ey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:19:38.1799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488e3a2b-b8f0-48bc-2898-08debb18ac93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivankg@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10936-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 05CD55D4C81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dma_device_put() drops the last reference on chan->device->ref,
dma_device_release() runs and may free the dma_device along with its
channels.

Two paths still read that memory after the put:
 - dma_chan_put() reads chan->device->owner via dma_chan_to_owner()
   for the trailing module_put().
 - dma_release_channel() calls dma_chan_put() first, then reads
   chan->device->privatecnt, chan->slave, chan->name and
   chan->dbg_client_name.

KASAN catches the first one:

	slab-use-after-free in dma_chan_put+0x3e6/0x4c0
	Read of size 8 by task insmod/6319
	Freed by task 6319:
	  kfree+0x225/0x470
	  dma_chan_put+0x395/0x4c0
	  dmaengine_put+0xf8/0x160

Cache the module owner in dma_chan_put() before the put so the trailing
module_put() does not need chan->device. In dma_release_channel(), move
dma_chan_put() to the end, after every chan/device read.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 605bfa477a004cc0b03957ffb85a52308f903441..9c4e206f246864ee185e8d9df96a89014d9e6edf 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -495,10 +495,13 @@ static int dma_chan_get(struct dma_chan *chan)
  */
 static void dma_chan_put(struct dma_chan *chan)
 {
+	struct module *owner;
+
 	/* This channel is not in use, bail out */
 	if (!chan->client_count)
 		return;
 
+	owner = dma_chan_to_owner(chan);
 	chan->client_count--;
 
 	/* This channel is not in use anymore, free it */
@@ -518,7 +521,7 @@ static void dma_chan_put(struct dma_chan *chan)
 	/* This channel is not in use anymore, drop the device ref */
 	if (!chan->client_count)
 		dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
+	module_put(owner);
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
@@ -907,7 +910,6 @@ void dma_release_channel(struct dma_chan *chan)
 	mutex_lock(&dma_list_mutex);
 	WARN_ONCE(chan->client_count != 1,
 		  "chan reference count %d != 1\n", chan->client_count);
-	dma_chan_put(chan);
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
@@ -924,6 +926,7 @@ void dma_release_channel(struct dma_chan *chan)
 	kfree(chan->dbg_client_name);
 	chan->dbg_client_name = NULL;
 #endif
+	dma_chan_put(chan);
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);

-- 
2.43.0


