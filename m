Return-Path: <dmaengine+bounces-10861-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE0dEZopFGrfKAcAu9opvQ
	(envelope-from <dmaengine+bounces-10861-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:51:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFE5C96FE
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CFEF30036ED
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE82378839;
	Mon, 25 May 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITYB4/wQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE673E63AF;
	Mon, 25 May 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706259; cv=fail; b=i20+AFBVYen9GDa0gOd86bUKBKVqiymagEJ0Tu27ck6ALK4Id30SZsrirKKLuvag09NqZzAJxC9M+5eYA5cwDgUZ2kwEYq/F+0r6hHh0By70kqTd0GvYG0WZufI7jfOUUpG/89Vw9NqJwuKp1q+neQh2AkPl4l1lAZrG01smaJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706259; c=relaxed/simple;
	bh=Vn//PcFOaGsEKR+SKhlPlBRpsZXJYsAUp8vvaxiOfG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy8lvj/zi5Hwt7L3irEm+7qFJWIOXROy5LX12nHSgnYv8H94PwGIisOZrRS5RCT2yOYKK4jbwmETiy3psdOSKIEY5GGujFhAYgdPHtvlU5HNBBdHdvE3PAsKahfs8zcTJRhLZlJRt86VLsZ0Cpn/DTownJH3FbuHh+S+mXGWJzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITYB4/wQ; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWopx/P7X3tPeAjLq2MUu8eqwjJ3DeM9EcqqjjFxjDRZmUa6P7WAITMnE9pJqxGvRR7dsEz3bZ/tSx1TCQpgg9IFMTiEQ9QiWRdAdpT2l0fg7JMeLLXp75gtrjfJEalBTqmd/f8rCOLT8zCrc778TTfOD0f67CpqQz6dpEQ3LTAJy6ZcL7F3TLTI3zI3NZ3JXk3NzveaCdkl80OPviKrEVeg6z555T52HRedn531grp+vWfqg2ulLWo69lY+HX/pSrBeV1otaJPjNpSHqxo9JsOogCqkMMuq1R2VKoDl3SKJNnzkDptcy7IpdliHrPK9szFZ3BMEqtpquwzu5dJVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnP6fu1gIF8/BeJwmQenLDKjaBsUwE5zDv/qSLU/so8=;
 b=OkBRmAMnl5aIKpGPrm9puixp8Od7pSfw6hDLzw9m6wf6g1ilyKlADdaG9pdW0X8vNdj753rEYP2f5rBst1jUZNHJ3yRertUWIRygRb47v2aSeNnj9STTYkWH7hLziIpUwg7t/poQxKb+6E/KnzZb9ixmrnbK2xa0vxmJcGbzro69MBV6KxAb+XsZFrckqSr6s6DfuOQDbleWANvRqLOgKDuxRg4Xl11pz+nPS1e82VXmDhvFIAE6azW1rJz5+8iD331oQgn8T+5Iqk2kIGy4Qwq1FVVNl0HSO7m5mTBmeZ108TLSASUmAoFFsnDb0XZF6xyYvzMZCNCO+MR6SaBobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnP6fu1gIF8/BeJwmQenLDKjaBsUwE5zDv/qSLU/so8=;
 b=ITYB4/wQ93I1aoxt7c27sGQptGqlKtg3dG8xn9W7lPPue6dv4hUP2UiDf8aZc1ISyojph9s5r+OTyPs/x8WBHrnH+RtLges0zVK3QxXbu48DDy4MK5rWKYJuCCnEfy0Mp4VC520Q+ZULo3GMER79LhTEIk2Jyp6Ez61abq6+fdY=
Received: from SJ0PR13CA0156.namprd13.prod.outlook.com (2603:10b6:a03:2c7::11)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 10:50:54 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a7) by SJ0PR13CA0156.outlook.office365.com
 (2603:10b6:a03:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.10 via Frontend Transport; Mon, 25
 May 2026 10:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 10:50:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 05:50:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 05:50:52 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 05:50:48 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nagendra.golla@amd.com>, <jay.buddhabhatti@amd.com>,
	<harini.katakam@amd.com>, <m.tretter@pengutronix.de>,
	<radhey.shyam.pandey@amd.com>, <abin.joseph@amd.com>, <kees@kernel.org>,
	<sakari.ailus@linux.intel.com>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets property for ZDMA
Date: Mon, 25 May 2026 16:20:41 +0530
Message-ID: <20260525105042.2249542-2-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525105042.2249542-1-nagendra.golla@amd.com>
References: <20260525105042.2249542-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2b8730-3d57-43ad-c6d5-08deba4b7ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|11063799006|6133799003|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	40uMJoUmT5i5EgTUhdB0VutulGuZJYmef9tENevAr4L3yRjl59ViquKsK4NfVxe3cXH4QrMEg4hvkcpqGTpKUXSyUZH02/QJCnmckfu9aJOfmo0RGhVPUE2m+MTScfddrQgpsz4HKMufL1kbA+ntC2I0pJ6aFVLF3fhV28m8QCDW/ebOAcYyoYuQ94R49DxApEdna1jFJka9qgljeo00buW0vtAtVqR7OUWlJolFLa3za99zpiQuMCYF+6jVJzYsxroujSySkYyOWtFT/zNmlcT5Tyw4ZyQS6+O/g+PcpynORCQ9qHvsOTe6Uai0OWpUku6zJaDMfCT/+tosaz4md4kfoDKfTXx38kteNImgDu8xvv7/eQmSIywAjOJ9rMzCJJjwmu5Blvg5OZhSVH/YQWSxQPr+JuL9yu5Q88munHnHU2HQDpmUVmbnZ93ZYS5LYeUoj9SjETReZuuj9TLSj2EWqpAHqfXy731U5V9hXgBny24NlV7xANYuz5sMRF3f5c11UDuE6qfOGQFjzs+3UyeHM89x5baQcv6wJ2SZ4R2invX06ssi7tCXRtoxVgzW7zZSSraFtr7AtZW6Xb3ZNraMyh7qIxyWhBPKTr/F8H9zakzSgqEzMnYzmw/qK4agf9ZT5+bGwqa3IulQyP458cezXLI2tdW9WtklY4ybAIiSSYj8qNRo5u+2sfRvIloi1fYP50GQMXhxXEdk07FYm9jr8tSQX4wvRf+YqveV4RYwiXMMh2vuOcIK5b/cStdDZMsjDi6bJeR3ch7h31+A/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v9kGM48VHWIlN7dMGZjBoLdgyQXmgKVkwSXHVHescIB1DqQa2LFK9SyMQ0SLcPkvlOWrdqM4xjZZRJVYwRUfdt7EoN4KSPmTSaXfaZzBvdtM4ewgmYKzoXQORnA0VM2PTtk+8Er6Zflv+EBze6dFR1eyYZ9cjLBW1p1Dkke2nnZ1X66VQ7hfc2Q001D6D1H2WS1s36/4h55zei3vUMvUCawImzdEqUDY3wdrIMZpJKcd3G2tsidZca2/HluNdjDVPksWUY1jUplIV+hneaqb6+lQNVjDljcQG9u2yGUzcF+uS1aG0pbkeZlSNECMMIARzYRB8Cpv+ANnB5yz50dt6QsjQ4Pf45SIjg7Sdzcm3j6NkFieUMqssn9MQ3iBBKsc+j3xpT7JhHS+HEDYlqYxfFkzpbZj6+44BIijrXR4kdP46UF7+HdE8Y7G4Sd4GSm4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 10:50:54.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b8730-3d57-43ad-c6d5-08deba4b7ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10861-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagendra.golla@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B3FFE5C96FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>

Newer SoCs such as Versal Gen2 and Versal‑Net expose a reset line
for ZDMA. Older SoCs do not have this provision. Add an optional
resets property to describe this reset.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index 2da86037ad79..dff16763e11b 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -56,6 +56,9 @@ properties:
   iommus:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
-- 
2.43.0


