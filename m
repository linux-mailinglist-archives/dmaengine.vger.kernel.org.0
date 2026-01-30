Return-Path: <dmaengine+bounces-8598-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNmOCv2QfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8598-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:07:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA7B9C98
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3284A307C315
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FAB37883B;
	Fri, 30 Jan 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D3apgi9+"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E230378837;
	Fri, 30 Jan 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770970; cv=fail; b=EKIeJuxyO9cvuMYA2+1MyApEI+1dRuecjPkt4gPdyFvr6bbh9A3dnMhue+wNiof815FGmSXqNxWmc1CH9BZa4u+ZgkyK1Gyot2uTZPI91D9R04Of4E3+fYRmQz7NIlzgf/B9eqHMa43/0GV6muweE3TtOxlYAUEW0M4w84W40ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770970; c=relaxed/simple;
	bh=68gh7ZStYt0XUza57ju+vopZkxGb2+esdgKOq/17Fto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTlj3eCaOn8JMEJpLhQ3KengQ8Dc+Fafg9GYyxdKWUWaHsl+85rtcujX68z3sEKKueGwirhqS1eCxFM+A92T2ewQKu0jty3TLQ+iA/ZV+V3JbPu2ZLLW6WVM6riU63YY7mQt8DIF5DeNnKUsm5Nsa0xqdbmzMUcj5N8qXb7P1So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D3apgi9+; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNJbv/UNgsO/K/stA85ju/qeZ2kZ8zvCTuzxo/JyRPuNUgV73SHKWI2ZaE5neQaXblLWUOVhn2H0Ys/gVALGuTQ3HASzz3nubw2jnpy4vbUIeyi5kUXwXn/HBO8n2mjIl1CH5yLQfNwQiOac1sxL9rBpLpjM+W3dgnpLNy4CnoQgxscdzJoOZLk6ttd3oCrAslIvbSCO1I+23/D4f+EJoe4nhHqWav6GjB4U7Q3HjV37zYStztS8bWQ/wV5THY5Wwjj4YSYZpQ+hYMeLos7e/sC6+8qU+SCtwztSW7fSJt6h75EG9/8CZ+H9HMINSMU08uXx4eoYzyAl1xAcl+OOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUgOZI4KuDRaK+I7FYlwDvWmH08roVidaCqOCfHs0OQ=;
 b=arniOweAPr11+8TTEJm9SXWoKMN2r+g2q9RZO3BfQKf7CCHMZ1MX0RGiAfk04H8y7zM2rZ1C6sz2cZ72MjRjE24FDP4Dg6Tjs6X875immMNibrpYCKioA6vBxE1ypzTX2PzjGmh0Kh9OmevegcOe2eVTtr99GQbITLPq0rOkVzolP8BeKONbuzCpzg1t8eGp3Ql2O371YcHZCaJzmxthHXKZkEtD8+IuuKReoh+i1GcVwaVM+DN7sdkqMP0vbX5AwJN7qqqcCW8e0az7yHkPPTXM+M9Z+RdNBR+oKgPRIEZ9TW61ZRp3vrvGErlbuuAsA6jaUN/nmZv7j+P7gRhOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUgOZI4KuDRaK+I7FYlwDvWmH08roVidaCqOCfHs0OQ=;
 b=D3apgi9+unhQvgKPvTVKV6J1rY13qRmiUHd2N2CgMGJsJCjFJkEHrwbttWfY/Vhq44a4o5jrcwAv2di+AVaRSeTJpsQZkxGragFiv759oNYdX0m32Urn4FqWG6WhAEjR+19EZbbpeQhW4LH+YvxELJrjcedoscrIpgh/chF3AqA=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by SJ2PR10MB7809.namprd10.prod.outlook.com (2603:10b6:a03:56f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:02:45 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::49) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 11:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:02:44 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:35 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:02:35 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBg1204392;
	Fri, 30 Jan 2026 05:02:31 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 03/19] dmaengine: ti: k3-udma: move static inline helper functions to header file
Date: Fri, 30 Jan 2026 16:31:43 +0530
Message-ID: <20260130110159.359501-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SJ2PR10MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 76375687-5b99-4a40-906e-08de5fef1878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/pqYHCV2wEEeUq5ilJK4Mz/C5uweYAgxyg1PMcOPhOkZBLYsJhD/qv3hFsu?=
 =?us-ascii?Q?z2r1+7jDoSZNFkx+2lyuaTSEBC46ddFrNj6/eZLJTwsTK0lLSWM5YRddjcXV?=
 =?us-ascii?Q?qxsVwIx1hwrCCGtS9PrBBsSdUR26zkxuDy9omMLOGI6KD8H76+nl46ltYWGv?=
 =?us-ascii?Q?orH2sKm4rjltV1aGzhkXbmAom7BhB66FygvuF5lkimXumDSaKCTGAWn3vrZW?=
 =?us-ascii?Q?PEcaYDItmp8ldcUkt2nnMCOoK54L7RKZW2VhSDC24Mmwrs44mqELUKWZa+xR?=
 =?us-ascii?Q?9/ts+bQmTCqOctPL6zc/TgL+eAn5aCTsJwirIBRw7NJtNFcOSM/M5KYCXKq6?=
 =?us-ascii?Q?m354o/dqqefhGF7PMvsX8IGHIesFWzEUMlQAevw3toJkYnoxBe42HLQmVP4Z?=
 =?us-ascii?Q?DAMVg2VHamJpAfukE/fKJuL8o1GPdqvbtEC2gv4UumwF3FQQwLR+KYW0NftV?=
 =?us-ascii?Q?Z6GdGTBT09cwVKRxvnVpngo2+P8MH6dJT41RhH5uhaw2ai2q65ahEIfCqK3i?=
 =?us-ascii?Q?E0ca+6eoX5UkqaFXb8svQwD4Cg9zLcq+44I1nXTPs1mLheIBwEVYowK3Hgc9?=
 =?us-ascii?Q?CbTdGKdC1rbvKxfutabVr4CkE9rdAxV+8bQvRb6ECbUIWPco2jEdjknKNk+B?=
 =?us-ascii?Q?mLdop7jSlsvK0lgmy2ojkbw6mgOkTvZ1LH0uoAnDJIMln2tiA1YHsEH8OBNb?=
 =?us-ascii?Q?d4KNWHee0xElTZGLyYGTokeqM17G4V+bwhN/qtMIb9LirDMgi6/ruyHloJwj?=
 =?us-ascii?Q?sEUrITRszZMMxbsZZ0MtDuZWTaV8KcJ6ZKyXWjkHw6KhUMCc6hGVdftYlUv0?=
 =?us-ascii?Q?BS/lHIO0nAFCGMns5oZ4+YEZ3kh0rayWIrOZiJv4jWFVGTiGNPkBvgSThaiv?=
 =?us-ascii?Q?33GgoPQznBgLd/O9GltT4Kr6pxVAb96eRDpKlQTxCnAcRczqXvpAbKoy1Xff?=
 =?us-ascii?Q?n/kdXi1oQrqz0kxdQur43Pb3+QVvzTurX/u1xR8y8rSEI5+NoGVyXDX2fmFY?=
 =?us-ascii?Q?QNdK1i/jWRkw1s8djgWs/GvMPnZ3iZ/5gnCRMpZgYGEvt/Xi0iEUZkdCuQ++?=
 =?us-ascii?Q?TO5vBmrhq1JfsThYE8d7oh91pSsMflwE1muaATAPszko2hocLtAIXhusERP3?=
 =?us-ascii?Q?U6mNXTt4wVf2J4mjnuXlxe98aKs4nGQokTzPY8BtRLlE1NHvqxIpSGZrVGJB?=
 =?us-ascii?Q?l0DuJ7RNqgTdOafLdzJhe7WfCoWZYCB1dpm7WrYmSZ45S4Cs+FwQ5lktz1KY?=
 =?us-ascii?Q?EiMQoTQ1DBEb4N+88GPZ2PhwQBCB2JmwiNaXwnUXcMrw6hBaXoioZMAZ0zta?=
 =?us-ascii?Q?NkxxGkiL8ADPlej8LC6x+QIsqAO+RDaZCoEQ9mAqSpxG9DCPsNVHg8usapSK?=
 =?us-ascii?Q?vg5tnBks2udaC21fVNOPpybnsgBqi2y85tDYQIaqmRUQiS7bknKLZ95ayDkD?=
 =?us-ascii?Q?0H5CI9Oc3u4bTzRZ11O5An38j+OnG/ixmGokpeJy0PBYdC7McrfWV2FpGmLw?=
 =?us-ascii?Q?OYL05dlb/CA4pjuanCmyFSfum+K9om7YzRmBy9GO6rtYaY6wokxrI6Io0SUm?=
 =?us-ascii?Q?2zIwf+wAVY09Lw0kyMUVdj7YKVI6YiIQ5+VWTi8IItwhdBm4gJtxZsf3lFma?=
 =?us-ascii?Q?u6cGRUIXQxBW+wNiSU3jOF1t3pVfRsbm4F+7A3QDxR+HT7bOlfIJChdwCc4T?=
 =?us-ascii?Q?Y/DlYUumMAXRx3rYxyIv+59b2WE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VdRsnm1xIPL/NzkI4VNYcL9TozFhWwIvU0n5eb6JHCRXE/v17fG2FpWGvdJ2Y/rOmVvh6D9/IGRBUb/iFg1D/urVGMUhtFciBoyQ8EE7N/4YZtvX0ZA+g+rJfaKcWwmtSJ+R4TBKCLM+U6azZKzgHyZ8G4nkmkZdCrYAVYpwAHMUS58LjmVG5hIVeAh5GqixJswbQvP1tYMF+tYUmllPgboTzxvhGX3A2Cj3+C74LM8ksfQPZHf2SSStXllBGxmjymxFgPjBJnbA7HIw3dz4WlPeVWcnvGN9R/x6v7tuPoJQ22qBiQkvDUEi85B/YquONWL8XTEDcuUAGQEgF5/NtA01wmfAsy4slmNUGVwNWDjTG6qXBEepDTHgah+31WE5Bo0FZf251IHB4ArqFYwc2kebL8nr0AVDKkT/sCpyfSrQ6Cv6fD+xK/5IaTm8vawz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:02:44.4281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76375687-5b99-4a40-906e-08de5fef1878
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7809
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8598-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 77FA7B9C98
X-Rspamd-Action: no action

Move static inline helper functions in k3-udma.c to k3-udma.h header
file for better separation and re-use.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 108 --------------------------------------
 drivers/dma/ti/k3-udma.h | 109 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 108 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e0684d83f9791..4adcd679c6997 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,91 +40,6 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static inline struct udma_dev *to_udma_dev(struct dma_device *d)
-{
-	return container_of(d, struct udma_dev, ddev);
-}
-
-static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
-{
-	return container_of(c, struct udma_chan, vc.chan);
-}
-
-static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
-{
-	return container_of(t, struct udma_desc, vd.tx);
-}
-
-/* Generic register access functions */
-static inline u32 udma_read(void __iomem *base, int reg)
-{
-	return readl(base + reg);
-}
-
-static inline void udma_write(void __iomem *base, int reg, u32 val)
-{
-	writel(val, base + reg);
-}
-
-static inline void udma_update_bits(void __iomem *base, int reg,
-				    u32 mask, u32 val)
-{
-	u32 tmp, orig;
-
-	orig = readl(base + reg);
-	tmp = orig & ~mask;
-	tmp |= (val & mask);
-
-	if (tmp != orig)
-		writel(tmp, base + reg);
-}
-
-/* TCHANRT */
-static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
-{
-	if (!uc->tchan)
-		return 0;
-	return udma_read(uc->tchan->reg_rt, reg);
-}
-
-static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
-{
-	if (!uc->tchan)
-		return;
-	udma_write(uc->tchan->reg_rt, reg, val);
-}
-
-static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
-					    u32 mask, u32 val)
-{
-	if (!uc->tchan)
-		return;
-	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
-}
-
-/* RCHANRT */
-static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
-{
-	if (!uc->rchan)
-		return 0;
-	return udma_read(uc->rchan->reg_rt, reg);
-}
-
-static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
-{
-	if (!uc->rchan)
-		return;
-	udma_write(uc->rchan->reg_rt, reg, val);
-}
-
-static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
-					    u32 mask, u32 val)
-{
-	if (!uc->rchan)
-		return;
-	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
-}
-
 static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
@@ -216,17 +131,6 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 	}
 }
 
-static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
-						    int idx)
-{
-	return d->hwdesc[idx].cppi5_desc_paddr;
-}
-
-static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
-{
-	return d->hwdesc[idx].cppi5_desc_vaddr;
-}
-
 static struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
 						   dma_addr_t paddr)
 {
@@ -369,11 +273,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 	return false;
 }
 
-static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
-{
-	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
-}
-
 static int udma_push_to_ring(struct udma_chan *uc, int idx)
 {
 	struct udma_desc *d = uc->desc;
@@ -775,13 +674,6 @@ static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
 	d->desc_idx = (d->desc_idx + 1) % d->sglen;
 }
 
-static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
-{
-	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
-
-	memcpy(d->metadata, h_desc->epib, d->metadata_size);
-}
-
 static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 {
 	u32 peer_bcnt, bcnt;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 37aa9ba5b4d18..3a786b3eddc67 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -447,6 +447,115 @@ struct udma_chan {
 	u32 id;
 };
 
+/* K3 UDMA helper functions */
+static inline struct udma_dev *to_udma_dev(struct dma_device *d)
+{
+	return container_of(d, struct udma_dev, ddev);
+}
+
+static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
+{
+	return container_of(c, struct udma_chan, vc.chan);
+}
+
+static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct udma_desc, vd.tx);
+}
+
+/* Generic register access functions */
+static inline u32 udma_read(void __iomem *base, int reg)
+{
+	return readl(base + reg);
+}
+
+static inline void udma_write(void __iomem *base, int reg, u32 val)
+{
+	writel(val, base + reg);
+}
+
+static inline void udma_update_bits(void __iomem *base, int reg,
+				    u32 mask, u32 val)
+{
+	u32 tmp, orig;
+
+	orig = readl(base + reg);
+	tmp = orig & ~mask;
+	tmp |= (val & mask);
+
+	if (tmp != orig)
+		writel(tmp, base + reg);
+}
+
+/* TCHANRT */
+static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
+{
+	if (!uc->tchan)
+		return 0;
+	return udma_read(uc->tchan->reg_rt, reg);
+}
+
+static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
+{
+	if (!uc->tchan)
+		return;
+	udma_write(uc->tchan->reg_rt, reg, val);
+}
+
+static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
+					    u32 mask, u32 val)
+{
+	if (!uc->tchan)
+		return;
+	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
+}
+
+/* RCHANRT */
+static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
+{
+	if (!uc->rchan)
+		return 0;
+	return udma_read(uc->rchan->reg_rt, reg);
+}
+
+static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
+{
+	if (!uc->rchan)
+		return;
+	udma_write(uc->rchan->reg_rt, reg, val);
+}
+
+static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
+					    u32 mask, u32 val)
+{
+	if (!uc->rchan)
+		return;
+	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
+}
+
+static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
+						    int idx)
+{
+	return d->hwdesc[idx].cppi5_desc_paddr;
+}
+
+static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
+{
+	return d->hwdesc[idx].cppi5_desc_vaddr;
+}
+
+static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
+{
+	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
+}
+
+static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
+{
+	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
+
+	memcpy(d->metadata, h_desc->epib, d->metadata_size);
+}
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


