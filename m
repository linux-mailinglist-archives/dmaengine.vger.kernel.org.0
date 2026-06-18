Return-Path: <dmaengine+bounces-11611-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qtntLS+aM2pXEAYAu9opvQ
	(envelope-from <dmaengine+bounces-11611-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:11:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53E69DFDC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:11:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=kEDlrq8H;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11611-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11611-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BC8303DA8D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F943264F4;
	Thu, 18 Jun 2026 07:11:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C13AEF30;
	Thu, 18 Jun 2026 07:11:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766674; cv=fail; b=efrwdaxuAZYMnKGGzWTWeMnhkcHOfcJcSK0vBFemc+lA1h8tDvPIO5RYLXWUzptx6qwRGooUQWEAZa9RsHHPSWpvqww9FZMjthV+7ZrHijXeyUyVajKbeF3JEPJa42h/H34nkZSDlmY/no4bbKYZcjf8xMKSESxSPUSHBLo2v7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766674; c=relaxed/simple;
	bh=I+QISvZIzQOatmDoo9djaLZbeVd0wYhRnvAQaN+hyIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GO2Cu0OwRw1mrb2tGmG3OGpoPA58borr3/J3f8Qd6fmdVbVyB2DV43SVP5qRqxMUxZEJkpn0wOZw7nDSTb+lPseNPNP9pOXWzHEceuv0AsHH0Jby8sOOsMhMjwC0QFO81ul+mAauS/DKJsiIULIX82iobf74C0QZcv5LnFs2uVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kEDlrq8H; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMzKAxZFaZnIKYgVESX1IqzO7GGKDe3DyoykurqCKqMVgjNmK2m9XNTvmJuV9HphI7X8AhC4nFzLBtnt4f4Cq5Fpla9I7U6a35eWnZvuvnSOMvgf+k8EiqT4YxXl4rsYUIbyJ+R/5Wkqgg4QWk/uvdp7TLGaVTz9sa3EElwEdOFk+w+LY/HYHmMMk99tbXlOFM0p/wXFua7J7mMSCVzQuyasU1bLuR5bPCUvyChuDh7hOiIYziZ/I1CHZm1em/kYO37aRKye/BKl4HEAsB9OeIW+cR3K5dB2yW2lcKRJ0wRcf4Qx9wuOwVzZzK4kzB6iuz4aFPpZ4DvkwuM9C8IlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SUIPw3uRSPV0LsL14eHJ/vGa542eKOH9eK3Bp8b2I8=;
 b=ndWoWFxuEALSNy3JMcc60EBcCQzJGvXMHSVDmSiTPEusyR/cv70xPBvc6/nur7TtWseNb1N6n5tXUuxer1p5558FDMxaSeFzOZ+0OdYliiVcs95c/yAipRH6daKXuAlueey+7nwa/9tSCiLhh96nOGa2B8fS0GjxJZGQBJExcZEnVEmJ6DeRU/2r+DF4E7KHecRGBym/bvHD0ywVBaqHFkF1p2RAjKhYqlFOKAVL6nKsezl/vOkyvBFF+Yez88PQJOxK+E5JsptMho7P9HYC+qyPKqn3yFsuJkT1noZVxBNJ7tqVI5cV24f5sx59QicOSITOKxKN18ZyaYHQeFosMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SUIPw3uRSPV0LsL14eHJ/vGa542eKOH9eK3Bp8b2I8=;
 b=kEDlrq8HqKdApbrhdrngwKWH5J3v5XTVXWyXV107lR0ah+eWprGMekhDvj3O0/22odRhokmzwlDk3eCL1eh9x6NGOdrznY45aX+3Wv4n2PmOukLz7XAEmUZOW99aTFHVCttIWB+JUeGh34P7lLsrb8tLFGohS9Kmdnf2FsRXGWc=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:11:08 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::7d) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 07:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:11:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 02:11:01 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 02:10:57 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nagendra.golla@amd.com>, <jay.buddhabhatti@amd.com>,
	<harini.katakam@amd.com>, <m.tretter@pengutronix.de>,
	<radhey.shyam.pandey@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<sakari.ailus@linux.intel.com>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/3] dmaengine: zynqmp_dma: Add per-channel reset support
Date: Thu, 18 Jun 2026 12:40:53 +0530
Message-ID: <20260618071056.2024286-1-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ac8a26-6751-4980-eec8-08decd08c4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|18002099003|6133799003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/idZklhEaEfMrSc2QiSrL7YO/1pKxdnmtX3YUkHNE5z+ipmWNGuMHLa86DKGRhil1t3X2Dkvc4Aa+UyLC8XkKS54AQWcxlAvq8Sc47IbVgp0bs4/o3sYV6osFXwA9+sfWWE4EoP+BoZN4dxFfzDIJr2Y+RU03yAYqjboKBGRdLCtLv9SwC6sTI37A+rCtfX+CHjrhp/DFcEgwcdL6fIgFHfCo9MZpQA2xtrIRMq48X0BMQowNM8hvYY9Tno0OCgSvO80Se5uFYYWJo/8nm+TVKJ8aS6aiPtFlqd0JNPjILRZ2urzDPS6LZAlmCqZJScTCTe8FQcr+u1LqAobpzFLBxm0rzG2m5hqczgc8akuRMEZDhtRPKjv4VvTrgI+cGUaa4M1wEZbo/egK3HJDC3J8MuxwUrRXBcE0byhGjMhyPNVl6Gc/C0gnd2BovmwXbK1Wy4WOjVtobYFoPL5mS+M332IYfziC2QUkDj6lZrCHOZZ1B9m1ELUPbPlFZ/bWEDIocHGCSLUxvz7KCHytzecYdIM/DwugUe7x3jFZygfeVu3yCBMJuLEXXn1Lx3nCj2sSJN9WpXGUIBD4JyoP/U7c7SFHrprlNiSkzBSGBRdh36QPYmDtnD9/A1qdS3lBuLvQKB7DWY3DPtmS3wUmm2wIQ8z1tAshj5oBp/0kzcQrDsKnyurlFxyzyWkvjTcSlovHi5yaPtGv64pjDsNrm33YoWPuPkAq+ckCN1GXIodlTSSrr+prhURDgxBdxQKU9uMXElf8aOEiBMAJ0dPpYzC3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QPyJCZGyNIfMlm3YVWNQs41TCQJjPhSauurZ85Z8PRGZBI/ReLZW70sU227DCjCWz0s0vOEBsqfdgEdsO3wZsiAORJXonWcOWuCQTV0fNRxRFxu1GNdo7YgswcJee3xAgke03KRkAiLYr3pV/wAdZOsHh/U518gLnS6Atw+wxwUWCBaayckDRJBM/n9ZDMNirt492aeH3fNc3cbTDLP7q5VVO06U3TaVpkIrMbXZt5mQO+ykPyvbFGlPj1KbYQ9QLGzcDmlROIoiP2VlSCfUSDtMHxD0MBY+gfg9X139bChZAvJtqNigdOcnYqPf4QvOqh88xJdBpnWl21cBj5+omBBTJPUlaxcrBghN14VkoiTvZMQRGKhsU26W5ZBpLHaQy6sjSOg/S1nV6/xYOpcekxJqEBQ8gpn8cqRIU5vWCJK902Tan4uSQLWkBdRvqeUd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:11:07.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ac8a26-6751-4980-eec8-08decd08c4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11611-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:nagendra.golla@amd.com,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B53E69DFDC

This series adds per-channel reset support to the ZynqMP DMA driver using
the generic reset framework, along with the corresponding dt-bindings
update. It also adds a runtime PM guard in the IRQ handler to handle
spurious interrupts safely.

Patch 1 adds the optional 'resets' property to the ZynqMP DMA dt-binding.

Patch 2 adds reset control handling in the channel probe path to assert
and deassert the channel reset during initialization.

Patch 3 adds a pm_runtime_get_if_active() check in the IRQ handler to
avoid accessing hardware registers when the device is runtime-suspended,
which could occur on spurious interrupts.

Changes in V2:
- Added patch 3 to guard IRQ handler against spurious interrupts

Golla Nagendra (2):
  dmaengine: zynqmp_dma: Add per-channel reset support
  dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts

Jay Buddhabhatti (1):
  dt-bindings: dma: xilinx: Add optional resets property for ZDMA

 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml     |  3 +++
 drivers/dma/xilinx/zynqmp_dma.c                      | 12 ++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.34.1


