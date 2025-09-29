Return-Path: <dmaengine+bounces-6726-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2FBA8F47
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CA717C694
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A92FFF9C;
	Mon, 29 Sep 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPYgSgFB"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E52FFF80;
	Mon, 29 Sep 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143748; cv=fail; b=tb0uJvS9gCxsFwgrJMy0JKTm/NLQp2WX/s9QIuc5NtoIIfqVcHsf28585EeRmY90FhS7MCCPqf50lRuuPM6Jry6r+BBpzMYKq+ZRvj01NNAlZO4vwOxPzuehpNx0EpC0U3ml7R003Ut8fOVrUYwDzAigNFA5SNu4FsZw1bCEEmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143748; c=relaxed/simple;
	bh=+78eOdCTp7uqfv3xbb6VySS0nTYP7PIwRB6+tHGsU58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmFDm3m/RNAF0qXTkXu7c6xpLK010BU3jwon3BW3MpjQOAMoT8+eeF1XsXEM1+H1Xh//ubATxUfMJvkqgOEacyG+jkKogyBm6rT+4mulrbpFtCGUo8X0/I1KfftbHIb7u+KI30mmUdgqCTSOwAPH4Fp+jvKflrjV438yu0obJrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPYgSgFB; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doxVAkkm2eaJIRwR4BWognLbrxurgoqIdbz3A1gfWbjZPzJabF7/WRDECRrX2T5sXpsi8C2cWIJecwje1c3H3y/JFEOgIIhSSqnT+sytjdIOWk5WR6VkMxjKF9kNP8XuWQJBDH6/0ur6P/C985aZrXX3eLSiq6J46vNQnl6EOlPN0emjcVheiBe+p9vUHfBZHLl/EBEGrJXJ6XgLRezNXNmO+Un7wogdJ3GtNHXT0SuajUwJe6667xzCaHu0S5QZigGI1PEo/ezG/KGPNlMaL3ylEjXV57MMY//It6FIDv3zWXi/9HtsnRwEwVcB9l7lHFEGz5G2qNJT0zbno3hXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb79vdBkOaCXJXCWGEig3ehFtAUhwOpt6CJ3ulTSq8E=;
 b=igHMEpIlwmcJPFgNc0IyRxPkSMfQo97BaYsM2FOCznmEa73fV2Xzf4G6V4VygMICV8Fe4Ofdw5sOS5E9o8VpJDinw9PLDMVNFoxchedQysPY0gwUVkqBlTibdpraVFHuoon+LR+VjO25B98TioW2sCrmpul49pdQ3zUbg+s9bA0fBjgEGbPcXrwPDV43XTZhYqP8Esrze7OlMlWPoiMm4FwrDebyqMZsOkekG+H7UJ/4ny2UHBfICF8lxikEZTZTHghqpvqwUcn4zsvAZao7WTbb6FunepFNouuaypqAxZGq3sLn8psA4swEbjN8Z01f3NNIconsOIkUOBD7550wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb79vdBkOaCXJXCWGEig3ehFtAUhwOpt6CJ3ulTSq8E=;
 b=YPYgSgFBhLBPKYIrLaR9RQx5hmyjFclEaN95H4P3harwpIaw8MbjbNhcedbHfv57mTHwoSxeFGFrqqi3WnGSIeZbw6VSed1bthZXGiBDgAIz6+nUPyW+Uz4doyufBFqvCkQYOHan2qjLZrckPfiNkW2qh+MH+P8UEjs93LGCkgbCtv1cnXyGdCeb9d00r/Y6SnW1IyGfEAePZK5BLcY8oZAVHLSmQy4B696XLK+xXH5bMo0Av3Twm5hxWJxwwZXLZ/WGJNimzbWUPYYk2hmHgSFncn5QYqq/MM5NqmDAoQmgbCZ/wV017i4aY46+MDSYucLpGaAxbVoiQK88VHGKiA==
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 11:02:24 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::6a) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 11:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 11:02:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 04:02:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 04:02:09 -0700
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 04:02:05 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>
CC: Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	sheetal <sheetal@nvidia.com>
Subject: [PATCH V2 3/4] dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
Date: Mon, 29 Sep 2025 16:29:29 +0530
Message-ID: <20250929105930.1767294-4-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929105930.1767294-1-sheetal@nvidia.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: c694b446-e0ba-4c28-a75f-08ddff47ab30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9N9SRJK1aG1ftg06F2FEPkQCqJCnB+YPESQGdQX38Hsb9BgPpqT5po/6Aq8?=
 =?us-ascii?Q?YY4j9YGiWM3zHrxEBgT44htMuCZv92D8drSmkZ5zSEsgGQrQt3UIiiJvGud3?=
 =?us-ascii?Q?ziqpEU3y/L+K1nQw3KMcjqbAs6njqWkSIcl1k7Xiae6rKo3OJpI55JSKUdiq?=
 =?us-ascii?Q?pWaqfwMQGWXjnjxfA6UaJEm0AbuABvvHj3rvC1wKDMudL7/rJVl+opOZth5a?=
 =?us-ascii?Q?0pc0ZSFV2IGxXJUFKdYjuEShVblZ4eeM+0tiuJvRZyc3MI3iaXRYpUkgqR6G?=
 =?us-ascii?Q?GZr74tVUJxllILKfgtKKRMfKa/wxLtcJbBw4txuTlGZmnsPvzkptWwV1ugzT?=
 =?us-ascii?Q?wIde6+SwI+3lngAIKuG+6jfST4J0AsI/m9kgAlGYPgyydbppdGJ+cQyN6222?=
 =?us-ascii?Q?8c4boH1hWGps9CynDjsVMrOzT9skMPXCpQsKtUxSn4JHlCgbkMAW8xhzMAbJ?=
 =?us-ascii?Q?A/RybXVjFmSs0AEcXB2VJlSzBnnn5Fqw+40EColVxQgTjWVGOFTSl39DiWEz?=
 =?us-ascii?Q?+NYsEHZzjpr9DgoPDC3Chlg8iCwGd0v7Z9m6wesrCUdEpkyg5PtH5BjXVDMS?=
 =?us-ascii?Q?ML2vIoYqA8OxeADBhc4QxOil9VCCDId7ttA2JodMeLO5pzkNlQy8cjqmkSex?=
 =?us-ascii?Q?uMAMy+WuuGylTmqO/0MZgUy+Yj7cmY8mOntTKsT4Pw1KwXLuc/9uqzqbNRf4?=
 =?us-ascii?Q?dw46Ka71VXR4FglBVyU5sOXkqRsD7zg5bx2TmsIU+pFLU2alT4A4CrgIUP7g?=
 =?us-ascii?Q?drC0SL2L7sO6e1EnJtK3aBBFFkzv4oDgrYmNs0ajyYEutXDHN5Uz6NSJsMtm?=
 =?us-ascii?Q?5TkUTcb0AgmlrsZ19Me9MwVDMTJhRMtK8o7CDpXFBeD++ybgoMwD7HqzUvPN?=
 =?us-ascii?Q?tQvAMrbxVUPLTC7SbEngCK6kB8sRJZ4L6/H7LymHMxo+rwrf2IH2MBGruG2P?=
 =?us-ascii?Q?qcX5i/mdgarnihu3BzQ0ALLJk5gAQNBjNwvEqKiyO8L8GPm/1Msp3P1H2LgU?=
 =?us-ascii?Q?+RO8iJqXlCPLeZUhSmhi1X5I4YzDSMyRgUaaiXjSQ+rkM0BklurQyQ912ewV?=
 =?us-ascii?Q?1VoT2uI2QRkXoDLMn2fHZzup+PD+1A0ZFc5TEzfiX482bwG0fapMkFKBBSFI?=
 =?us-ascii?Q?XwZfu70FaNoq9nZRouA7kP6I4ZVbKznDtOf+yJbfDiOOa+85pf7Hzfx7Pdm9?=
 =?us-ascii?Q?oEuZ6OmwuLhh0KI6/hiTODe5NBxXWZhNaemFR95PPTXQYq1Mp/+nW7SBCTZn?=
 =?us-ascii?Q?2JAo5Uj5Bn3/fd/67ITCiB/1eHBoA4XscIeTBwdKuvqrJS2NywDg/v29JoVk?=
 =?us-ascii?Q?Um0mP1lhd9FsbSNuDk6X4WrwtG/rXIL2/ajW3YBXBu4I0odz70vNnnzBP2RV?=
 =?us-ascii?Q?qivhotbWQs0ClR1FP8VJ7cx0WbVhg1zm/uBssUfnKIMrCPvYjP7V4sktJxqV?=
 =?us-ascii?Q?U4CL+Nadh49+tXNnQ+Ri+pIwEWXUou/EtxstTyJRpBfkvwcope1uWwagP69V?=
 =?us-ascii?Q?esgjEeD9Rg4ozbH84xjavQYAmzoZ3QY9xNKtJOSPffSH/i/92CyKNs5MPV+1?=
 =?us-ascii?Q?u1sTSY3Y1QQpcR550Cc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 11:02:23.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c694b446-e0ba-4c28-a75f-08ddff47ab30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

From: sheetal <sheetal@nvidia.com>

Add nvidia,tegra264-agic to the arm,gic binding for tegra264 audio
interrupt controller support.

Signed-off-by: sheetal <sheetal@nvidia.com>
---
 .../devicetree/bindings/interrupt-controller/arm,gic.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index 7173c4b5a228..ee4c77dac201 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -59,6 +59,7 @@ properties:
                   - nvidia,tegra186-agic
                   - nvidia,tegra194-agic
                   - nvidia,tegra234-agic
+                  - nvidia,tegra264-agic
               - const: nvidia,tegra210-agic
 
   interrupt-controller: true
-- 
2.34.1


