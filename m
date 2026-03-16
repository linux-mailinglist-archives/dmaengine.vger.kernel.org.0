Return-Path: <dmaengine+bounces-9443-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGZwLd88uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9443-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:24:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74A29E1B7
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8693008D13
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EB3CF68B;
	Mon, 16 Mar 2026 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQT2NFTO"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FA3290BB;
	Mon, 16 Mar 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681578; cv=fail; b=MIEPoOEgW7W1Ga/CZG8oKteOhjKUfpOtCyro7UOw2b7qCtcJZq9016Z/G4BhY9FBjniIG6BMnILMfmfZspJfYmrikmqFSBLVJGMAaDp3BY7lMsB7oUoriIye5eUXBvTyc5UTp6feMjQofBxHSR+fHcJ0disCZmPW0LZjOC8CZsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681578; c=relaxed/simple;
	bh=NW3LFnfARBV6Z9JNTVNgSDKjIpRNZkZrBIP0qAreNIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEyeyUaIUDT8u+NMJ+PN0hYXfJ0UDuib/BtN1hyI9Ng/USwu4dkFoqTfiYiL+oY50OTAqRhxwVIlW24o26titcEl9gwWbOuatPIlK/5BX3Sjw1tXa1yQFvvLidWl8FLQ+TuF4SFQgDoOvb3Lh5Gq50eoCWR6A5OM14BI657fnWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQT2NFTO; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRIQJbEPFtxzqQtnUNBjau+9XTireJlb2zzoPnLW0DG+nKvIuVBGMcD0hGnmoEFlcQ2N8S56OvhmRfEu6pM5nucUI9itUW6mrU2PInwBwkbhU0WAjzP9LHnnCnz08cCHfqzLHEFgZTzqaNkA3cPVphp3XOweehhg0ZxIY9tSKAG4DtDtqVcY4RjYQ/5ARUFJPMo3tpwywC4rlfVTH5CgrvrG0pwZybpCPJ4kD5BPLyIyjBAX3p1P0mzfxdna7glMCMKjyA9yBXm1oxoLfw+yuIpyBNdokx/QQoqj2z5+w/uB1h9ntM904kVQ0IB/nam9iJ6P2GA4egJFbRxlpKaiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70TOn8z+tsHL6OaMSQs5jk4BcYOiaPEp3H+EG8THy4k=;
 b=dDBQ6HJg3F+CF+73cKPaAXI+5ttjW23C0xOyCn8x7pR8uMc0xV8zG6pei564KF0U7/tPuFrat3mYK6LEZTwiPZ54s/jy/0pONoqgxpU5+RTVfNjt9DAH5IoyGsQqoo+s4eMY2TblOY5vAoq3HK+bjwOLUqaAqkhCHbyQcHsCCOwMhMb6NbZ//N9MLsv/gaqO48kbTo8yEIyoFNdhtFVv3rOxH6CS1TFU1lNxZKDKdYAFywjl/QHut8sqDz50D8ZrxCpK4Ki2ilnDerJ19qUP4RCC0W/otYVm2sJz4J0M0A9IjHqiWB3I/3GzcYIF82yBCE6+7/D/jngKnhVa09YVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70TOn8z+tsHL6OaMSQs5jk4BcYOiaPEp3H+EG8THy4k=;
 b=PQT2NFTOiehg5xU0hbzZAP5EAq15QyJDWDNyP9uy46RML0LetGJ8QjuvJuUFdg17MkVZTIPa5Uaw7mcAF7tQAHlrlJlSh49CD478uI7fJEDSY93U2Mpi9Kz0Xi/5JuGuL9qkKyyMRTa0IR0LXe3Y8KEP45pcx3AdFCeAejWu6Y+BxY/srwbHJAbtv3sgZo9Z/Peb3ZfWD97/U2nmrO0S8FO0jOqeppJYa82mNzfX7m+ARohkItEf7mkZ1Ku4yLgAyfjleWWoTLuV3l6FAdr5efB/MBmWUkPvTLMj5WII640kFpgf0mVcWd+z/Vfvzm2seTUPEszr4jF41YWs69vQNg==
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:19:32 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::91) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Mon,
 16 Mar 2026 17:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:19:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:19:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:19:15 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:19:11 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 2/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Mon, 16 Mar 2026 22:48:16 +0530
Message-ID: <20260316171823.61800-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316171823.61800-1-akhilrajeev@nvidia.com>
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8651d0-18c9-4294-e599-08de83803085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K+oJgRqQQkGqRhNreQ+tiPV+ph86JzCmf0XZwbgxemDo844MkQCT1Z5Mu5hTcOP9y4GIvHrNu0NEizJMQFxxbss0MoQNCA4gPycwA8/iLf/fL5YueWUuzEPPDWlyHh3oAwfCNynQCHT7MmYKoRbqE7Mdo2n4tUc+reWc5YsWP1dphCNFM7KRNn5dvEceoD3+xEw9cRwN0jMNrwOLRUhIhRWp6866/008SD/acslaj5YpnH2HeinP69RJZl2JQXTRKvt4S6HxpnzY5LqieW8Y+tIeDmtA6+PLxt1Vjz/9Oaz0iljKVeivQnpy7d8uglsGnMqiRexW+yHcscGDENnIfHoaCiSVlE/pMJ2sK7cDOyGLO8gguruCwI0RdvLwy704xw1yfdiEqZ8Qp9ri0SGjOZytA0VtezhTh1EStwRyLknRYaaLaOQo2/ZPtZvtqzHZAXpQBghkmbUplyIUCZetzZh14DoWENuwr8d+FwtwMG7r3B1YMRWepc64wg9rA9mfiKHQaULidSys1IoKatpbiOSBzul/CIMBnNLAWSNFUWxtOAj+2i/3+ribyruhQws6oCOc+b/HaNxfdYQRPKoPBwKDokVDsfRvF8Qoym+sEhxUWlMtHCRTi5VlBfa76elEQeEox4E03H7Stak28y/OdZNjtazEsftp1vjMfKerfaf/1uT/m3aSmRxW7kKEniXNlYBlMgqD9N6++JiQAVU9kscsn8w3eOonaWarknPuH2UnlmcMYOpV8iDmg28WaZh1hxRm1bHZtKZm7qQ8+YIEoA2L7/vU9SeMQMcMkaWHcgYNhlxmC2yZp7yGlODLPt99
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L0DOUfgcNETClOwp/5vzVFZXxqxzGWAEnwmdgExnPcbhlag2DcHd4jOIXQGd0HiKwfipdnnsEKBXW6tdhGHYVNjNSthzbTJTgt/nhtxsZJX3MhccDZShGn+V7Wq3Tm0tMqrjH0Xl51kArP/FKY1RV504wRf+O7UNmDBiwTqouE6doWUUBlI5yYardOLhttv+tzLApYwL3FhwPgc4gB31sdcCLhX6N/TRWJhRVfHXk0gj2n4QO9c4yM1cxAWXxvRqFD5I5VPKyj5pTNQWrlNgzeaJN8KgJhPqtiDVlDYfd9StouGOccCmenAzZTiEcrHKOUr3ImLDlLSViUJbHXrUDewv4Q7tKSzhA9bgXiJBXB00z4OXVcN9ennOSld0DQbQPZscamh9gcMR73/mRDb5cSZBIQqKIoQnUrxZYgPw3/aJjvkSBbGZ+ZtmvyTnK9rA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:19:32.6092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8651d0-18c9-4294-e599-08de83803085
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9443-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1E74A29E1B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, GPCDMA reset control is not exposed to Linux and is handled
by the boot firmware.

Although the reset was not exposed in Tegra234 as well, the firmware
supported a dummy reset which just returns success on reset without doing
an actual reset. This is also not supported in Tegra264. Therefore mark
'reset' and 'reset-names' properties as required only for devices prior
to Tegra264.

This also necessitates that the Tegra264 compatible be standalone and
cannot have the fallback compatible of Tegra186. Since there is no
functional impact, we keep reset as required for Tegra234 to avoid
breaking the ABI.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index b5d8fd0b281d..b849d4cc2901 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -16,16 +16,14 @@ maintainers:
   - Rajesh Gumasta <rgumasta@nvidia.com>
   - Akhil R <akhilrajeev@nvidia.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
     oneOf:
-      - const: nvidia,tegra186-gpcdma
+      - enum:
+          - nvidia,tegra264-gpcdma
+          - nvidia,tegra186-gpcdma
       - items:
           - enum:
-              - nvidia,tegra264-gpcdma
               - nvidia,tegra234-gpcdma
               - nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
@@ -69,12 +67,25 @@ required:
   - compatible
   - reg
   - interrupts
-  - resets
-  - reset-names
   - "#dma-cells"
   - iommus
   - dma-channel-mask
 
+allOf:
+  - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-gpcdma
+              - nvidia,tegra194-gpcdma
+              - nvidia,tegra234-gpcdma
+    then:
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.50.1


