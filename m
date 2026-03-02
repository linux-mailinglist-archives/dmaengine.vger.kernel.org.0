Return-Path: <dmaengine+bounces-9165-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BFoEUOFpWl+DAYAu9opvQ
	(envelope-from <dmaengine+bounces-9165-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:40:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15C1D8D36
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA3F330073F9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66AD36E46E;
	Mon,  2 Mar 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olVx266I"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6C36D9E5;
	Mon,  2 Mar 2026 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454886; cv=fail; b=UtctnYaa3MckA8t5HXG8SpDMULdVhJOj5LF1F4vEEyY+Il/DHgDg6UV6RNlWABDvw1eDM/9V08+jrbiif1FHuHJ9PJHIMcugFRMhyG5Erf8ihnGgH2+wGCdGLafFFq9IZZXG3g63aiMwUiYHc9Qxq8SrV7qWUoSgmsV+TcKiL2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454886; c=relaxed/simple;
	bh=jKNTfHDt4wvIRrarrfULGWwYS88U6f9I2nFrxRzAdFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=er2jLHAkHM8GzC5b7Z7A5vR2ei9I+2BSl052DwYkLRV49w/9W5Zq3QQ5YZJB949IwBvtkDG9gyZa3rRVKnBRae4ziKP6fSmjxsaIIKMqhpvIw8TQzesXg5y2DArjf6YuxWU7ZXBPTJTBmosC+yIKbXkKTJRSG723IFMWhl8rqq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olVx266I; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ4sNP/Jtbiwp0GgPax3qzSSNIFIpU7oGmHbgTwfBs3/bEhAv+htX2/swfi/++CYzn3MZXnF+FwEVQzNoVEQ29OJ3pl24Hdk7lxVih2m870kZkgT+OhiVlOncxiDhCVAffPJ0eA6Vsx8bMv8nDUAyoDnb4iLX/FqqOY6OLWUdlh+eJop6AO8a79H1BZcckdXdGrXg9ECY8PrmuQUDdm+T+ypA63oWGGnmQBUXyDcSzLVmfQOk3Iml3yWqM/pdzznWpLmU9YRf8FPlx5IAETc05h/xGmlRtUbO6TCAeILiHcSD0AXGuG3kVAZDvq26JAeVl0uZ93sqF8qlB2h/z+fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi87Rw7JQty8qZ9WxqXNLLL9uTgvhauG3q3H5roitYQ=;
 b=zSVgXsofi0KARstJR33D3eZKb59rVC3tdhr3SHrZhZUHmlFOSQbNWY54BsbWhC030VhWUTDbl5hDXtiKbC05/6VdorZkzFMA3Or2YdezILB0S874amTj4mGW7agVW8jNmyQFDnzJWjdthOGTeinSlsJmC164YrcRZtYXx/a58b0aSMxRdswMM2KOnjldiSG/7qsN4BboYI2QbijIPhx9CrvBNhduO+uIlIhs91JtJucck2JkOqRkPrtpaAlX3HYu70ypOD016lIJyDu18BhOLXmqxOcuzlZezTd+YlFMxlWqXSNZE13Z5UieYC+Vip8RwDBBgWdNKq6wmLdXdJ9GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi87Rw7JQty8qZ9WxqXNLLL9uTgvhauG3q3H5roitYQ=;
 b=olVx266IQB7m97pszKrjSNr/Xk6QI04dh7zazuawqE80lcY+vw/H6pi1QRq7NTf4tC4K8m4UYdLGhqJYBK/kNcH8A6bl+65eGPzKI+wZyvQjmwBmdXvNyJZXGCVUPpKTJDq1BO3LyV6i2vT8wbDpx490fDP1AvGqR+P8BH7A8Rx559IJVaBHBpracEpEW21mmsMQ84CX4s4vwiLjob9U9oU5fhxnmx0oNtA3A9l+iQze5Ut22DAnMF4yK8y7M20pp+/ccOUM21K0m5eUqOYyeeoCh2JYJVWPNzfYsMYEa1hbcoZ3dQvimbJ2+1X2tSQvnH8cm1UZPcAtfsatDG5o7A==
Received: from SN7PR04CA0180.namprd04.prod.outlook.com (2603:10b6:806:125::35)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:34:39 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::96) by SN7PR04CA0180.outlook.office365.com
 (2603:10b6:806:125::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 12:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:34:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:25 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:34:20 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
Date: Mon, 2 Mar 2026 18:02:32 +0530
Message-ID: <20260302123239.68441-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 7549b414-0b5d-4b9a-0312-08de785811cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	qCGiAhd17lx9dfu2Nt/kbVYpdza8KfBIncE9NTQvrm88V8qH6QSajcCq48/veB/wreZIDRZGjSBcg6MqSp5T50/9Eu/VbFbqyA6shd1kg2SRSn1Ste2dwJnmKl8nrOgnDo4qaBnKRBya31LUqrShrNFPEufkjGmSRHkZ4ohiGJwWGhy5FbL49RoZHuPIC9GuPuk21iw8gj9XAOQGHrFWli5DbQ7K1dr60LnTh8vQNc/vxunjfev3DTuJppsUO3InE/aQ5PULvB1xxYkQrMf1v/ag9eLd2x0Oh568IgKNjV2F8hQw3cTeZ3UotiKTFpDfEzEVNqpd73Uq6ZRsb/jzRswEXZuJzN7uHoeDvcC+8oP1/QoS0gk2WV5dMeGlVBLgSlfDe59xMIP/S4FPHpaqEmHcf8Wc2viOsSWNfsW0W+JshUOuBLT+U1rE6dKg3DTAi/kmSHwOyrbvNmp7Rdu5Fvms9jWopM4Lk9jr1t8Q4jusgMzQLp17QaK/9Y5Kk0Hyh3cgGr7DBV1pAb/HaFC3j3yYNgg5UKcc3Z/9METhF2C3ZjzYlFIHazaEHHueGfmc0x8uanJUvXNuXqj6/jxrZpxeschl38/2Qr2gnDYizKgr60EI0EzqzkW+Fg/c5VOwfn5fu0nWqZnmjlHFyKtnwfF+ZJnjZjsjRDmMnGlORPQJyTQVhdIYpVLEHguBqVkjQImFzWSRkjFF661pkGLwzC2fq5IOUMee6WFaiAMTH/dT0XwSyc3aa8H+y9B+OuUnj1Q34tqiM1yd0TmR50q30O0PVj94UFgA4JBmRGGZXyM0vuQ3y6e52nqeDrGyMcn7HRVjL/0T1GjST0EKlp8LtoE/mbJHaXs+9vJ/PHl+/iM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gDi7r45Qiyuyu2nFwJp3WvjSxgMYvdXNoPboL3FoReKisGgLgHlu0eOnozoDL+tvB7tXUwDriTb+/kFsH+WJqUc9u3N445Awz48FgdZG7vP3O+6ny569V/4QF+jhwfva3wI4u1seqFEI0adxY9RDSeJD4ZlJURd7en/SVZMiUf6KoJ9Oa/Gy2BokYTtOwb2MwALhapJli1eQYyY81zu3Nz1lmuQN+haa3WpAjvHQVQU4A3TOem5DQkxxd08h+WMlJCTYbqTOdMlVthAmVEt4UX7JgeX+YoSmaLnKBOv4zdyyl19a5bQ1g3uT6k3JCGIamTfRXCWLyTkVIQpF3t/NlZvC25ZGM07cAxjuT+uneJMtSqSpWxnK3HvfaBIIvhWX2MD9jc8bLSSpIBBzqZZT0HczkMcfY5y8uYlKdxiFvjS1kHRbfGyEFGE//4LLobap
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:34:38.3058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7549b414-0b5d-4b9a-0312-08de785811cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9165-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EE15C1D8D36
X-Rspamd-Action: no action

In Tegra264, GPCDMA reset control is not exposed to Linux and is handled
by the boot firmware.

Although reset was not exposed in Tegra234 as well, the firmware supported
a dummy reset which just returns success on reset without doing an actual
reset. This is also not supported in Tegra264 BPMP. Therefore mark 'reset'
and 'reset-names' properties as required only for devices prior to
Tegra264.

This also necessitates that the Tegra264 compatible to be standalone and
cannot have the fallback compatible of Tegra186. Since there is no
functional impact, we keep reset as required for Tegra234 to avoid
breaking the ABI.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 1e7b5ddd4658..34c9b41aecfc 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -16,16 +16,13 @@ maintainers:
   - Rajesh Gumasta <rgumasta@nvidia.com>
   - Akhil R <akhilrajeev@nvidia.com>
 
-allOf:
-  - $ref: dma-controller.yaml#
-
 properties:
   compatible:
     oneOf:
+      - const: nvidia,tegra264-gpcdma
       - const: nvidia,tegra186-gpcdma
       - items:
           - enum:
-              - nvidia,tegra264-gpcdma
               - nvidia,tegra234-gpcdma
               - nvidia,tegra194-gpcdma
           - const: nvidia,tegra186-gpcdma
@@ -65,12 +62,25 @@ required:
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


