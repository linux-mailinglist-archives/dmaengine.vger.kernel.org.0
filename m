Return-Path: <dmaengine+bounces-10935-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N3gL6mCFWoSWQcAu9opvQ
	(envelope-from <dmaengine+bounces-10935-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:23:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE25D4D33
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B1A301572B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDA3DE450;
	Tue, 26 May 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwkquiU1"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD943A7F60;
	Tue, 26 May 2026 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794385; cv=fail; b=dwXMejygK3ULuJiRLUOLaZmNdd9G/khEsXAI7IT1NsXeK5NjZQspwwUNOTxykDI4sTBlaXP7RhXEzWPSzgM85FgCNbD/reCjHvtGuw1t4/ZhDkntKggsXJzUB3rspgEyBh3keEGck3dp1yYq87nobrN2V+5AGaPfjwfhU08e8K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794385; c=relaxed/simple;
	bh=S7jPn4eLW7QV7h1BORZdJVl+A7q43dw6+GTWPNMkk2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CCVtAVbuVvBSH312d3/TP2EHN+BrCF0Kmz+5oXUIMUqH4HZNwQFWd3baqhpf54NBGB9aildgFdolzO0rIUbRVCAjyiWhx851mQwi64H6VSOh4HzoV2GgpNCrPJtnECe6joWYBxMHg7p183f8Woz6GPakoxQklHVQFjE8GLIW0K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qwkquiU1; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6vmer7RMuPHzJgIQvW42yYtwuHRxf7qa9dDx5Y+7bW65MT1QX4/kEo1YJu8lYbf9giPgTUztDVSRwrfdQUL4eifFRhjQ0z/N+CSvbB5NBWXDmPWjcZ+QJ8ZF++ZE+G2YGlyM87YsMzRoogKNvuRlpwqzA+zIQy38VHLl7gDg2sFb/xK9VDFGOTC16Z1kuKPeimVL45jjTYoY2ng4f8ZwdWxYp242xz1W25i1/MpG8EQGOQmIoSyyVt584QpXXzTS/ZZsUci2JytDAwrUayc/Wrq71NHnJasPmSdnNQdkTBua6t1acO0hrzigKpiV3dziuiCkR2cwkEIZbsmyBSUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbRjhFap/Ga/am2GDbOz5PYJJoDoxa8hWEcR/8QRYbA=;
 b=oIuwyB2uqy20y8ZNiKXByAVWfK35rd5LJhMVTiJxJms95tZaSPCjDDjcVZpGbBxpX0HZ0hOD9aMzF1hoxjmcmEsAvm0g++R2igfmnjLJLCP3n8+nob3++WXZ0eQPcQyZGE95ndL+252QioVGxl0BxHpJOGz0/f4ECopiV+hlWf50rBgA/LzcoD7gYzlp0AwZ96ZozNnQj2jkSzm7WfeYnxxqAGDc86cb6ounb00bNfNCD4NA704fsV/E5HkHy2ytj6NESfGXBn6RiPohSivCfkcJL65T40E9v4ogLhlQYTz7Z1HUphxlzILrhruuWOF3OhYpfw/ZkTv8oyBRUUDMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbRjhFap/Ga/am2GDbOz5PYJJoDoxa8hWEcR/8QRYbA=;
 b=qwkquiU1zajcWm0u/T2gkVSbnDkZQxxKyVknOoIA3VvNzeN7Ab4U47p6Go0vr1N85HucpPVb+kd42X5wEbpePutzk7C6xVbH/rW82gVAHQfzqMHRqjoe1k4gV6/M3Y8PX4OYTrL+hWkeUee/nzRq+YBh5IZucxpjf5R6H3XpN+c=
Received: from CH0PR03CA0301.namprd03.prod.outlook.com (2603:10b6:610:118::11)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:19:35 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::75) by CH0PR03CA0301.outlook.office365.com
 (2603:10b6:610:118::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 11:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:19:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 06:19:33 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 26 May 2026 11:19:18 +0000
Subject: [PATCH v2 1/2] dmaengine: Fix device kref underflow in
 dma_chan_put()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260526-dmaengine-kref-fix-v2-1-3df60afac01d@amd.com>
References: <20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com>
In-Reply-To: <20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794371; l=1583;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=S7jPn4eLW7QV7h1BORZdJVl+A7q43dw6+GTWPNMkk2c=;
 b=+dyII316AwdkjnpJaxzRxBc5mt2pBPDUKFn5XPl5NL0Xiu35UcxMfbSPSbxJUC4yNbCP/Fd18
 6jiDjCiJ+RuDUJkbFxVsAXD5X26nzUmfh+z8dJ1xANV+hfO0qL4bZ6p
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 07711ca2-f96c-4230-1262-08debb18ab2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qyIGFwULs7VVJh8MdvRwBUTSvrHKDOmQYX72CBE1o5gN37D+UFEF3QLbTjufie1e+UV1LliXdXT9Uv9870yENugqP/hnj+9rk3TYiTRM3PjQuJUhDpvAzw2hmA4JSceUgn+wk4Y2P9OiNppms+ZQosHyxU2joBbh8EDI2Fqco68JUQmQjmJfnk/qNjiGBII8dLF1S2neFVK3G8wasbNaB1ZxxIV9Z+R/3imsRXM8q7HojLFAVbSZSRK5U6VojJ6REO/QmSor396Fle0BoUzr1tYzcharDtZqQzamlHaL7Vma7EII42DbGy0nKhnaYG035+i3+ZVKDNs/sd+sR3vCTg9adMrjjSH27ZFu85C068PKHYHdOhHTd+Fo4rs9u3TwCJYkH8m5o6vgKDpsCo50OLnCMnb3gySjRA4QaQwpKO5ZIyXWIiO0rUdti1++lymUL4ps5UdBxM56sr6fYM21aJrCZsYMdSfzJdwNQh+Lls2DRVLJVqpnAI1k8ZF8Z9wgFcXE/4wW8NR+zOhTmKd428O8TD3TiPPVVDeoLi/B2w5Vlb+XLYqCQuk8l/wDYgxxuPa3Nex/A28Y1EF1riAKahhBf9s0sGpYmQd1kZJ0Ubbxo+TfnT83nyHsLlfxZn6/kWxFG/yPF7IYnjZyzqRdCJ1hg8wd9Lcq89adgLmgPGGrbK0Qx3WgMsGzeM2mvzatzkL7pJR6gsvO9hOPOhlIMDUjo0f+urC847RJXTHF6lw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fYyZjvk8qmO/NYtynmenOl5xR4782Cr12Q3Xb/Vp39u4kIZfp4kBXSKC2t6Srx4axhF5C9yRMd5bcoiO1kSq852a1xJkYfg74io7i3V84zbeq72STjEyyDj1WkcaLlKeW/LDMXvsbMQI3DrU1Ymua0HTZnfG2xF7qdO2KzhN0014j9xwjVQg7NfB6gbv4fU0hVc3T8JXx4djGzsVvTcb9KwgVHS/tcaqX3j6t/AYLLX/H67LBzYBN8YxFcO4loGvGlrVZHlyjp6Hc67tpStz5sFv1tDG1pFMdWS6Hmmp530xDQs1hy8Ef3Do831/BZMJv+pq0iICYrG2BaGVbuvuKPnA/XrErJj4NumeSNXVE7yVe2/8Of0jmtnmHYR6M62xTJLBvEfOv1ksl1a39MokFFi6B1AV0qg+bDHVxh9gQDXpM7Yc2HYuqSpqYDlRvsTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:19:35.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07711ca2-f96c-4230-1262-08debb18ab2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivankg@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10935-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 2BEE25D4D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_chan_get() takes chan->device->ref only on the slow path:

	/* no kref on fast path */
	if (chan->client_count) {
		__module_get(owner);
		chan->client_count++;
		return 0;
	}
	if (!try_module_get(owner))
		return -ENODEV;
	ret = kref_get_unless_zero(&chan->device->ref);

dma_chan_put() drops the ref unconditionally, so every fast-path
get/put pair drops one extra device reference.

The bug fires when two conditions hold together: a non-private
provider has a persistent client holding chan->client_count > 0
and another client cycles dmaengine_get()/dmaengine_put().
When the kref hits zero, the subsequent dma_find_channel() returns
NULL even though the provider module is still loaded.

Fix this by dropping device->ref only on the last put, matching the
single slow-path get.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..605bfa477a004cc0b03957ffb85a52308f903441 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->route_data = NULL;
 	}
 
-	dma_device_put(chan->device);
+	/* This channel is not in use anymore, drop the device ref */
+	if (!chan->client_count)
+		dma_device_put(chan->device);
 	module_put(dma_chan_to_owner(chan));
 }
 

-- 
2.43.0


