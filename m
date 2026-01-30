Return-Path: <dmaengine+bounces-8610-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE9OG1iRfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8610-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6EB9D29
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A10BC3091766
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAFA37A4BE;
	Fri, 30 Jan 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uWn0aPcr"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0862378D9E;
	Fri, 30 Jan 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771027; cv=fail; b=oxpa5loYWu03gPsop+x9PTaFPFtDNgWmvs8NFdKnewCpKZeuRBy4wohRipgHJPePm0WzKvK9T9dUhUGn22EsJkL3FY/UTMYFRyX99vibWAkee2BupxtQIPCy2ehjjHBZZ9ha5QDNdi8GsIWzGpEeus+AS1MLmcavgcVX+CPq72I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771027; c=relaxed/simple;
	bh=MzghcB8+0xRSlTabjHEaILlUT3/RGuuP8WQAalGf9Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sm1fARmWhp9nE9jYlnWHX81/xQEVeV3gyN225TqXVjMlYp/eCf81I5mKD5vpHFmHV+JlEK0szA+wnD5yIYge3b6rwzjumlhdk8/mAM3rURTQ5Om3EImCQDL3Hq+p3/lhZ30px3m220JXrOVLqyZNhdFLWEd/ssHG2ERKtdUvbeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uWn0aPcr; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvpZoFLyYN91Gu0CiyU1HzCvkGye12LK3XmqlnZIHL2W9JbuIX2j5nWXiC+GnGGJTsCgTa1LykhhpTsRFPvuBNTMRXtzYZ/iUEwXLhjtuobHSw4PfXTXYwFCnTGhW80cLD03UJ7vN0SdogqJkylqc/d6gtQJJTtXIDVgN+oF9/FRme4mwuCh7nWWHHQXf0KNOLsPUlkw59Obh3/ExMNmRPix5yI/tkY02GolVN1mf1oT1P13YLnBRG3da+Qu2rWfPMmdvFbI40NIStvrfhRewWVL/+p6oXzY7WYJK5jsYsnjA1saNPtEdGoCr3aN6Az3z6k72Wniazv32RpU75+wjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQXFZROQ6hF9AaVZib6ifoo/+V5zX8dC7AyfsCk0MA4=;
 b=BKoCnw6ueQIulTaUeEU9eRpi0K14sqVqO0je5MlqE+991lFY8sBCG3+OuTaAvS26yXY5RPOg0UVb9G5rUFPnXOlPjDCGU7kHo+4cYfka2/9QrGWw1QtD9+M2wuabFm8tJscxgbSuXRKIa/IkWkG0pKDKuvWN+CcoJZZ0I3M6UIAHDcCGSWul+REMEDgDFQfDXxORGltNqBlUC9zlrUuXNv+L+tigV/o0VBEWLqouVAKsSYmwgNuq7/PxNmwLtPdnJyvSCseHzlB8wve/PbgQ0YAJEalmtkaEj4NeSwO2Vdow5ahqcoEM/tMoLdnHVFkBbXE8N34ADvD/qdAKlmnpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQXFZROQ6hF9AaVZib6ifoo/+V5zX8dC7AyfsCk0MA4=;
 b=uWn0aPcrbWDQM84DrqQeE78EGP1RicD8j8wF8HtED/ZZsn/+sLdJfTqbXr/bgyZMvajxuRZu65ZLJHeMvnJRdz6O+jKD2vLewQyjelDCRm1Xzxaqd5unF16lb+NTS0OQSlqE+4a79IhVRKgbK8OFSnPdSwiT9GKSsrPOgsxUiPE=
Received: from PH3PEPF000040A4.namprd05.prod.outlook.com (2603:10b6:518:1::53)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 11:03:41 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH3PEPF000040A4.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri,
 30 Jan 2026 11:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:40 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:40 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:39 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBv1204392;
	Fri, 30 Jan 2026 05:03:35 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 18/19] dmaengine: ti: k3-udma: Validate resource ID and fix logging in reservation
Date: Fri, 30 Jan 2026 16:31:58 +0530
Message-ID: <20260130110159.359501-19-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b87c8f-0dad-49cf-610f-08de5fef39c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FY3xKh+1vpH/jzuSEx2+31jTYnQgpTlgqp4aerK+3sMoB+JpxsjaZFCwG1l?=
 =?us-ascii?Q?kSqcdgb9qySHNt0tHc8mE5htDqcrEGKsfA1G39GEvxZIUSeftI0TKjYFO55k?=
 =?us-ascii?Q?cdCZJxC7AK9kVcq0/fzRV0Y0bXh2DS2TgKk/iCkWtJFr11uh3KIH4XJg/lGI?=
 =?us-ascii?Q?K+xsYD0hCAJ2eY/+y3GnV72OaKTmtpippZzaDv1VWLs0FO45AWSUT2npiY3W?=
 =?us-ascii?Q?1tkX8Pjh+lpf8HsD8KBuAxwlCdD9ERAnGVr1X8gmYs1SujN95imtFdFHEacN?=
 =?us-ascii?Q?NEPQpYgFs5A3u5eb74Bi7OaYE3K5BzxpkXcKmdHnaBGZ2Oa1QCm/ze9bwHH5?=
 =?us-ascii?Q?Ch9vHejJeOBrKTgbYwZ2GyfZIj4KgWj4qZfWZvLAaXm0unIczgG3sGK11eXH?=
 =?us-ascii?Q?dG4QQFabNYOSMuY2mT8dtmkxd4FkzgHhy2Ybjq5ig4MdXIDIazYOfwRgtiSC?=
 =?us-ascii?Q?OrgDA/b85XpcQnRfNtJneBEOqO7qMPZgyagkwH3SIeSLuIkZctoBdHESLFq7?=
 =?us-ascii?Q?zrxx9StX6KbiI6F4gKjlTipWAmnYWU1v2dL4X/OVwaguzybSecmuEOC3oILb?=
 =?us-ascii?Q?fEdKQ/sB5+JM0iguKq8FSeK7IU31LuEu4LHNOPrTYryIWIbvlNYOe2pqJGNe?=
 =?us-ascii?Q?7lglX9bELQHCUcP8w51C5qXEQUqTnVOkZcI0oqZNczi2KDpl9o4arh1dYw0W?=
 =?us-ascii?Q?Y60tLI4Zbp+6h8oq8k6/zo2xmGfrKONHyS3cta7GTxouy/7I4gbsfmIsMOKp?=
 =?us-ascii?Q?Skf+UH5VTy1M8XDuNwA8owX/EJX2jITxyW/lR7hmRCHXXJqPeKEGnliCaE7/?=
 =?us-ascii?Q?FLmC7jXS5gFyxAwJa4etE14T2uYoK28aO+9vSL9ZriWO/dS6z/VV1AtkAIRy?=
 =?us-ascii?Q?MlhaMvzU4ULdu60RB6ARJOKznApu3xOQeuRCwQk0DAwiAaXJsPZ7WgHlRJGR?=
 =?us-ascii?Q?HHXndZZi4WhyufxPV26evmMv4GQ5D90tD3QD9vSgA8zuCdpyiSKqQC9DcUl/?=
 =?us-ascii?Q?zf06/rOzaCYLHSvYCD3Ie1BXPbWSwofuOvLb3+0pIm5XOgYffQQPDsVqpwr0?=
 =?us-ascii?Q?Riopvfljqs7wcFupUyKFIw2psdGHDMmYJA/CJ9OLopIyvsGBbExXemSG0SQO?=
 =?us-ascii?Q?erXmrxO19/40HHhf6LT4F33wPLB5l4bix09zzOVFi4sDiU7zqJ+eB2mGu+zj?=
 =?us-ascii?Q?em9Q6WMcHpsAor9WahvsXTKz1w2vFxUkTbquLnmLt+eHsi7s9WAK9e3BMwBp?=
 =?us-ascii?Q?G2m4mCYjPAjlgJUsyp/iJWIJ2IfAfmCmRxaeFAawDEwfkDwcEd6bfp4BOM6q?=
 =?us-ascii?Q?TZYD5fnGZ/HFBPPBfWb4X3O9G/ZHVlauXxBQqhXIlisaqK9+HlpLMPDS2L2A?=
 =?us-ascii?Q?A11huWFHzP+ZyxA7pLprVRGfbd7grs1IKriynovTV/7xoSIfq9rFVJRHObKZ?=
 =?us-ascii?Q?v2xf948U3rKCKl+Z+/WcAkyOYa0a2P/hXgZdeLYCDPAqRhndRH4sg/vwqUcv?=
 =?us-ascii?Q?dU3hNiay+P0aGkbrWNRQ1fIsIAA6UyPI7zbc8V3CsT4Af/kPTTo712/GwKKY?=
 =?us-ascii?Q?7DffyWanFuVGuAAWurBSFSsd+Rl//UhMuJld6kjew715maV5TK+HyPWWD0Mb?=
 =?us-ascii?Q?KE0ikbqUdPpBDQYmXh7l2BtFc4Q2RU/Hmo6RCON0oCYhUsJ98oYS5P3WXgqN?=
 =?us-ascii?Q?rFzEyTCJxcGZeC0HZBOXM7bKHwI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xr671OctyuSQQiyjVI2/HQt95L30eBNKKUBBbH5aMh6vJwg8OM968o0CGIkC2LI4Kd3Xp6wMt1hooThYlqYOmongWCnl+QLiZTjsJQ/dm3/60oWBMmylIexgXQPP+OCHcjCqjHG5qNR9lKKzVY9CeTcGxXmb1JHfXiSy42oEG3FjzrkISrxd8WS7iZR/2yWtl71yJY84SzF4cXH0teWUGYqULkRp2el7zgyZi27suGCeBbCTm0SFDZSRacJop6JHQhokqYNXYqdzwIe+MPMzLYcm8w1gVPxHB75So/kFc3w56irUiCSBwfu9hwx42Gqyy17DMvUWyrpnZSHYlLul5xAuOKb/Kqk8iDHt7mcOLhwpcFvjYdMk2JfIebaLRAvObt1Pn37v9qpIx0zjvLgcvwvNNe2N4IbgcNHImy+TpcnLCwU+hbVmnpW5mVQa5xVo
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:40.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b87c8f-0dad-49cf-610f-08de5fef39c0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8610-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2EC6EB9D29
X-Rspamd-Action: no action

The `__udma_reserve_##res` macro currently lacks a bounds check for
the provided `id`. If a caller passes an ID exceeding the resource
count (`ud->res##_cnt`), `test_bit()` performs an out-of-bounds
memory access on the bitmap.

Additionally, the macro returns `-ENOENT` when a resource is already
in use, which is semantically incorrect. The logging logic is also
broken, printing the literal "res##<id>" instead of the resource
name.

Update the macro to:
1. Validate `id` against `ud->res##_cnt` and return `-EINVAL` if out
   of bounds.
2. Return `-EBUSY` instead of `-ENOENT` when a resource is already
   reserved, correctly reflecting the resource state.
3. Use the stringification operator `#res` to correctly print the
   resource name (e.g., "tchan") in error messages.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index d6459bcc17599..05b2b6b962a06 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2011,9 +2011,14 @@ struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 					       int id)			\
 {									\
 	if (id >= 0) {							\
+		if (id >= ud->res##_cnt) {				\
+			dev_err(ud->dev,				\
+				#res " id %d is out of bounds.\n", id);	\
+			return ERR_PTR(-EINVAL);			\
+		}							\
 		if (test_bit(id, ud->res##_map)) {			\
-			dev_err(ud->dev, "res##%d is in use\n", id);	\
-			return ERR_PTR(-ENOENT);			\
+			dev_err(ud->dev, #res "%d is in use\n", id);	\
+			return ERR_PTR(-EBUSY);			\
 		}							\
 	} else {							\
 		int start;						\
-- 
2.34.1


