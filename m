Return-Path: <dmaengine+bounces-5969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F1B1E0EA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 05:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6785809D0
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE51AA786;
	Fri,  8 Aug 2025 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="FcDQhuM2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47D3FE4;
	Fri,  8 Aug 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623390; cv=fail; b=ERshjF1c+ZBzSHuekhIECH0Gp+s+daQdqAiQCL085M4Kcmdfw2X2YnFs4rElHK8LS+5qoEq7xLB5c5E9im2aGGsARYsfUV6HTYY+Z4Mu7l16rt7+5nY0IfyYh3hd2X+uz/uZ09+raJShUGDwn+/1q7C4K+PQ+CKyU0mt1OdZss8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623390; c=relaxed/simple;
	bh=8SbZfVjfY4SKY+rUNZ0Vgy3OUGekuW9CLdkB+C7Lbrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYU1/1laZozNz4cOwjFK/PlFyarLYmIvqkwukkW5WxahvtjCxo81YIGMM/rVVpxuzMdJOOcXO9bWGlCUFE/Lmgz7lBeQHaboHCNOtpwPQZKxSjiCCbWhXdf/ieuFMqwjuQ9tZpoUlQgxXCXj9OZSmZ2p4COgLHG5sTKLk94f2a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=FcDQhuM2; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5uCxHCTkCcTSiQzucgShX4cAXkBiniAhr0pSHdYA3s4CHo38JsjcUs0DvMt6ZKG73wAvBZYfIMlyzD/8M1CgHpr9gu2zh1380AJkCZOm52z3GxTtnXKumfQXWMNswRiIVFAqHu/TcyPUV4bi8DXeO16giewhEAjjnzme7w2NoojoND5B+m9O8POgX4CWj9ZD6V56V3RFWmY/Gcj1eIqG/N8q3owwmktpWTYFYTQ5Pmot7P9OGMPVsZeBgeSaIN0p13noq2uIWcDL68NfBM/6/HsjworZAcMLt1AHZ/fdKjbreJwc8Ne/GxTCNrLGSmCFOUZowAaNUoqIF8TqS6xvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caww8GwNOd/Mtn8YkpI3ltlzHNbM4KfiVmv25rfqzc0=;
 b=C8M2A3HrhK6Xz829HMOulVQit2F+VlswjrKT1GLaa4859E2ydYJClvmkAlLi0btGRcu5npC2qanIYA/m/z/5O9IwCmaVfCTnjO3RD78RVD2VCCFX+r6UliI4sFBO99fLqxOJL02DIAEHQUkM/YRrVSWjUtGDnyYg4bQ+nC+0OixiQaIAGmwLIHeGFiB2Yl3GCednkiplc7XU+3ho5z2QPY6RKge82pzCEaHhl0VQtf//ru/4wX6why1z6DddPqdRL52Q0zW41VbXP732hR7V5lzqkq41TJmAYKl3zalUbMMppR83aHhAo93nuMG2bXoc3dRbyxTLbiyWRNt8Iltylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.84) smtp.rcpttodomain=kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caww8GwNOd/Mtn8YkpI3ltlzHNbM4KfiVmv25rfqzc0=;
 b=FcDQhuM2ouh0Ev8+8E/svrg76zIPIHk9HPqvSa1bthlUuFc7KNPLH1vt1OEDYzDkFgNYg9DEHr+CGgA4ntVRki/a5FvKVL1gha+s08I+CG0ofnTlfw+i8SY2f8THzUe9LzqgHzKD4GbvYEtQcEpW6UIMqjQu7P/6O7UTBloSNCyZUZjuBFFdin30WgZrxcSyv4zs4g1XJpcgYVfSgMpMfDWpBFFoaOiigVCqGXqMPeC+cs02RlOpVG9dz49IBtu+jliWLX2+zbpWtYHIjqQmK7auIngPiXnRaoVF3ac9Jt7emoTR2Lx2fdYVo3CVrhSY94flB/66MxrhIYZEuiuQOg==
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by PH3PPFC1D60318E.namprd19.prod.outlook.com (2603:10b6:518:1::c4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 03:23:00 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::c7) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.8 via Frontend Transport; Fri, 8
 Aug 2025 03:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.84)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.84; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.84) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 03:22:59 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.119) with Microsoft SMTP Server id 15.1.2507.39; Thu, 7 Aug 2025
 20:22:55 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <kees@kernel.org>,
	<dave.jiang@intel.com>, <av2082000@gmail.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhu Yixin <yzhu@maxlinear.com>
Subject: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc property.
Date: Fri, 8 Aug 2025 11:22:41 +0800
Message-ID: <20250808032243.3796335-1-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH3PPFC1D60318E:EE_
X-MS-Office365-Filtering-Correlation-Id: b971c0b4-dbd9-4625-f0b7-08ddd62ae00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQsN6VWRurwyd5pml4CIWS2BPatWedN09Pp0/iCGkDn6oY8p2hetq5GPPnsk?=
 =?us-ascii?Q?OLEtNzyvokhA9Tz38PW1c3g6geF1MURh45kwlJhRNzmE3xI3OPQQeb9Sa82i?=
 =?us-ascii?Q?OUBl+odxL/Ve98t+x8ERYTzsukUv12BrCRRq3xfCBOchZSj7zM1+e57qnell?=
 =?us-ascii?Q?A3jb5Q8/0ykwrAc+KlGNbva6gHZp4Mc2aGI54i0G3/q+AqL+2ZGKj+F9bOne?=
 =?us-ascii?Q?EPQHQ/fx8UBPs7sGKZfmoAqxQSYEj+ustu8yuUoalQLxaJae9gRdVwf3qR5N?=
 =?us-ascii?Q?z+Y/eqMRJmbrXHiNR+oaO2qwSQ5LjHt2IbdcL8ePhjkHudnS6iduuVLxr65V?=
 =?us-ascii?Q?Vmdj1kIerPa2DxID4aVQKpkTP9GkkH6e4CC7UWMkW2hdJOT4sU+vQAiloCF3?=
 =?us-ascii?Q?UsIYSN8vYNloAKZxpg1qRJ8VYzQOQu+F0/YFPSo8JPQ7n3ppUi/fm+fXeG3p?=
 =?us-ascii?Q?KW6eQwgAMXDwl+cKagsF8aE2+jncSIrcXY+55qc7tspRTTMr+NvQt/aUFe5r?=
 =?us-ascii?Q?Hdc76fw6HMYgYdrfs+12nH0c5o46RThepPxT7rTuUeps7xO8CWbTKDMEy2zj?=
 =?us-ascii?Q?6ABYHccOwKBtkFrFid/sE1cwJXCXG3ahlhHo/WN3GLF+HCT4zHtLgiVtZySv?=
 =?us-ascii?Q?nKwkIetzpytR1FWqXQbhYoGuymI7NRr5XrqMguzqywWbTI7rheZ+nMrAOSH6?=
 =?us-ascii?Q?e0bdm4/8P5d8+19hEXdzzMWli0GbsFu2z7ZviTIGgYeWmwrhYP4/WtSVJv/a?=
 =?us-ascii?Q?uGfXpIwprCSNoWVU0+cSC6GqPgBdl9/8LPkIR0+lFPwnHDuap2LV9wKA7ylr?=
 =?us-ascii?Q?3+wnhuBjJuhHW8iyHkya8qykP0NBysaadfoviXP45YU4iv6AVCm7FQNqTkOi?=
 =?us-ascii?Q?qF5APWG6ptC8EcWnv9+U3uut66S/GY1VNgzewRiVxqf8FK/pmgZsjNjtD1E+?=
 =?us-ascii?Q?P9QjYJlOsToro8TPt7MW7EWxep5WEFATENAmRmF7iiWvwJAsTSOUNgDyLWu5?=
 =?us-ascii?Q?yyfEZZZfsKXIJ7N/FOjt9+nHTYdXohm+Uh4wzCjkE6bxiIxAptSkEiXqbbxn?=
 =?us-ascii?Q?2fMRUD5WFGNzCsA1O5iyoFXxwJoYD0Yh/aU9+kcTXqL/dJEePhcj141S3Wp3?=
 =?us-ascii?Q?T12q+NUsDTgjcYRA4MAWpQXtTqW3/q9qHmatR5p9yxd+G0iW80elYFUDWkA5?=
 =?us-ascii?Q?AFmJJz4DqiWvdn4q4o06xKXbsiT6kOOYjRtttFqqQUJ3JBrektyOPZvVosnD?=
 =?us-ascii?Q?FXQCvTRbChrr70+jefQpYt2oaEPLVIxcS26yKRt1O0dd5Q/4dyprrtJW3O5I?=
 =?us-ascii?Q?iuyqm4AamNfiiwDIb09WrPFg9yAuBGEjf4sNoqSXmvEXq4qvy0lYBP6dM005?=
 =?us-ascii?Q?3dasWsY6e2mzmOsuwh7fvJyZgv/BzMl3YTIliRIbFMzz067fxp/01ZJKNft6?=
 =?us-ascii?Q?4FLQr/HQVmwbtLVM/Q7jTM2ztSSAOjgo8zE9nWHnTSWmBSjUxspTktSowx3h?=
 =?us-ascii?Q?a1F5G2cp7YOtQ/aYJQGcj414M2qU4yYuhwYPAKQeZA6g414Js6Wx9dn1dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.84;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-84.static.ctl.one;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:22:59.1222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b971c0b4-dbd9-4625-f0b7-08ddd62ae00d
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.84];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC1D60318E

If the intel,dma-sw-desc property is present, it indicates that
the DMA driver is responsible for managing the DMA engine, including
handing the DMA descriptors.
If this property is present, the system defaults to a mode where
another hardware component takes control of the DMA engine.
In this case, the hardware can generate and manage descriptors
independently, without driver involvement.

This property only takes effect on HDMA(DMAV3x).

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 Documentation/devicetree/bindings/dma/intel,ldma.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index d6bb553a2c6f..426168b8709e 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -80,6 +80,12 @@ properties:
       if it is disabled, the DMA RX will still support programmable fixed burst size of 2,4,8,16.
       It only applies to RX DMA and memcopy DMA.
 
+  intel,dma-sw-desc:
+    type: boolean
+    description:
+      Indicates that the DMA driver should operate in software-managed mode.
+      If this property is not present, it implies that DMA descriptors are managed and generated by another hardware component that controls the DMA engine.
+
 required:
   - compatible
   - reg
-- 
2.43.5


