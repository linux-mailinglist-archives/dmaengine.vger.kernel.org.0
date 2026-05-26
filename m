Return-Path: <dmaengine+bounces-10934-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvXA42CFWoSWQcAu9opvQ
	(envelope-from <dmaengine+bounces-10934-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:22:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE95D4D07
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C29130037FF
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A18352018;
	Tue, 26 May 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SiZHT9II"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0C3DF018;
	Tue, 26 May 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794379; cv=fail; b=VUeThaGoY9pK6xTxxBGXqTA4Jar8I6uew8OnuarKI3hd9xyvtg8wkENX4lUZvnzHNnRP06WAIEmCOjtWUrzdPX5jNmREajhBExc537QDOD5ato/g75QzXroyH5HN8Tnoa5VnT5ZmLrB5ChwruhQ2TRbKm5pQKbeLuegFLxTBnQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794379; c=relaxed/simple;
	bh=IIRAm3nH0VNqq84mi+5KkRX9rVqcc3PlvUCrh68xyMM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QDhi5/VxYKTa4gKqENKYGPlVxSaRhsnjVSLN6GdOhHs/eYX9rMvYV45jEloQhrTgs5tPRjNNZpHn0dhMuKz7ORTjSG+yWqlSkkiCxTpMhzOGnILpEevkvsXhiLEqVhzq3w7EQIHs5R+6WioZUfLKQFHbreDyNG487sl2ItUItxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SiZHT9II; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh45ypvsaYB45VjNuvJObmJZlmUVz1MnbwkMSAmZb6BCS8GV4rO0b6ERHwVusKXLGuS0SCQype61OSrnA8ap7EIboazLCS62BrFCSFqK4JWDuIr//XWq8m0CNCeKzCTCbcMw9gP0e3aMRXAzZbP2ZOmxpZvh19VvOz6eZdWBckCtN6hn6d6Bwj8knkvRaTOELXrOM/gY7we9WjFBRshY1FC0nXdjhTeAdkEpDcADwniEvwfIGFaOAr5tGjB3pGn7nc5++xyKmYu/krvTiGxUK2fZly81HgU7bcsX/f6mYae3LvROiyBGoPrbEAuaDhZ/d0eeSxloK1HVvc352TI/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw+uQvfstbnq6TGh3eRNXVt9vQmCYPcNeYYgfH5IFuk=;
 b=DRUYmD7WmrdPWVZuCbZXOe4eXkrsVmh4FDJOTnQo38fjw0KP5whzsDXMgRyd74vWTOER2xVwZ5Uzyd3dI0SfQ7sp+ZvoxQRRyBgs9lYHqTqFXW+lYYQmXNtLJNgVoi/gzHG8I8pD8Cfyhj1s3F5WJiZF9Y/7GSbaIOFQEM/hwP/SSFbPjp8MU4v380jYa4FTuQgnpp02Pm5Om1kpGVHoeSkFkFu9UVQrbA464XDUNo0YnkO72ss9yue6qwhZ46f1WmUTWUbDJ7sFgtmWXYvYdz7RsLdGsGzzdp/AbMpvOPN0nvISAXcEbdhQ2RYC1skuShzJ0IeI2XhFrWrttwfrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw+uQvfstbnq6TGh3eRNXVt9vQmCYPcNeYYgfH5IFuk=;
 b=SiZHT9IIRpCTvB9ysd0v2GMbTM/fv4RlCZ+Rdat3hfg3gZOfaGKYUrJK/TNr0bar35Mb//IUEfUNu57IlWaXddhwGARyFyXKsMTQbzKSas/WLg1a2QHxm+h6cxKT+Pskp5EutKTo7SLVbmF5YJRYaDh4c1ALsx7B0g63CtxQQns=
Received: from CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:19:34 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::3) by CH0PR03CA0312.outlook.office365.com
 (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 11:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:19:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 06:19:31 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v2 0/2] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Date: Tue, 26 May 2026 11:19:17 +0000
Message-ID: <20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWBFWoC/32NQQ6DIBBFr2Jm3WmAgNqueo/GBciok0Y00BAb4
 91LPUCX7//893dIFJkS3KsdImVOvIQC6lJBP9kwErIvDEqoWhjZop8thZED4SvSgANv2Dglbe/
 ETRsDZbiWgrdT+uwKT5zeS/ycH1n+0r+6LFGi9rVURuh2cM3Dzv7aLzN0x3F8Ad7l+tWyAAAA
X-Change-ID: 20260518-dmaengine-kref-fix-7b21acb09455
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794371; l=724;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=IIRAm3nH0VNqq84mi+5KkRX9rVqcc3PlvUCrh68xyMM=;
 b=r24m9G6zFSW6/I8TMz8etObreZIwTQsuCJx4dgMTukKS2/E9e/bFNjoi8oF6Von6jOCDl0zsW
 BirhFQo7BW1Di4PypCanLGIQdwJJ7s4dORabcFrJoBAanc8uBeG/vD4
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: a6426290-ed6c-4c94-eff5-08debb18a9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	U1Y+utdMlPNIWMr65Z6MWIUyfWl9mnNxJEfmwJTMER9J1ekRL98dxx4kGn+ZCtuWGcK//KoGlEpq1hZYkAIBD5v/xovSw3pRjytqSQhRvuiBFVPsBjz6uihzFdT14RY1VgWngpAWWXACs23izftvYyngpHqJRPln7oho2ZXzwaygMfyKoLheuZv2QftvIqYB86yN8yN9aPpCVFXtxQPbXNho1JKEgXqKENo+N5pjT43hb8CTHdI2Gwjam7mKH0tdqgBIxt7SyxYowDlNeXmyaPO6Ii+6/XYoQ6qJnNPb1XvaQb3dVw1wKRQ6zh1yUYgXFUm1DSGdedYFOJR0uGQ2hEstOxBrCqMNM8phfO2MEfISXf2GzJDBN/m6F4mKstwAufF37GawkEHMcx4rf9rE7g9n7nQWUpY0z85YQx+Ri6Ebd4P+p7zpOqavnFpGbnuTddY0zKBasULnpBqnHYl6ruCLZtd2aKPY2RgtKErQNVDcjDtGTkSDICkzY2BDlFghJv+Dtc9Gj2ywPXKthVDcqhW6ZKXwmouLRqzTfJ1e2syz2OmRzzecqDJz7RT6zhKMQV2/fAWFAzxAFdON6P+6XqJjFx5LgwnyuPV5SVyiCPuOHP7or2sefRwxJXk/MUIOB31UGs29qKOiH8WnQfWHf0M98rvg6nKxWOnbyuNrrisGXd6Tsbeoj7bHZl1k4naWn4SRuEz4sqUChJyi0VwafcVce0VyQLNpID1qTfc6iGM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	obrBmXmvynov65oiwaUTUSWYWVoDvtrm14YLHvvD2PkBFJD+XGe5eR8Vd8iQebQA3HGLnSQVSTk1tBrtnTxpOCRdht1gBmQE4sTfJlFNBAoiHhOk0V7mfhW8VvBY9DPKrNbaPGPr2u9VQthuODvAGKERGGA/N/+ntvnvjxFcdEuJix13bCqb4Mfq7juxYaAY7zt5Vv9GRwBNASJWgtCo7bqOXZFQqvHcqq7FiRnnqUkD7L+BVfTcXbZMk0/iv6tWYNaOgh1JXx4y6H3sfA1wmnd4SYehnol5VG+bNxBz03rlfCB7wZ3T9OLiB8vdxK6xJ8G3an9q/KAIue12LZ72FUPKMXtI7RjLzkQC5YTlqQK8nltYpXo1av6IJDvJBW14yV8+JEuXBpsfh0ysfEMSI2+NT9EQv+8oD671TvWpwDlwX0tbz4ZR9W18+swUCv+i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:19:33.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6426290-ed6c-4c94-eff5-08debb18a9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10934-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 5EEE95D4D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix bugs related to dma_chan_put().

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes in v2:
- Add patch 2 fixing the dma_chan_put()/dma_release_channel() use-after-free (sashiko) 
- Link to v1: https://lore.kernel.org/r/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com

---
Shivank Garg (2):
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()

 drivers/dma/dmaengine.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
---
base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
change-id: 20260518-dmaengine-kref-fix-7b21acb09455

Best regards,
-- 
Shivank Garg <shivankg@amd.com>


