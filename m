Return-Path: <dmaengine+bounces-10180-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAheJ21/8GnFUAEAu9opvQ
	(envelope-from <dmaengine+bounces-10180-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:35:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E848188B
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50C0339BE2B
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEE53D8127;
	Tue, 28 Apr 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M52iA5ek"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB823D5672;
	Tue, 28 Apr 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366433; cv=fail; b=P7VNOpEMsro4xKgH2O5SMaz8hFK2rZL7S2kHbXzCoa0U7I5ygQrFoZE25tXLKsCdAWYtUG+mcoQ1qo2GSu16DLwf0wSBfSHG8Hqtxp5Xzs21ei3lbv+V7G1piiznJmLqy0YTZMlpLPkDJ8Fx5JsaMp//7vsScisJHLzqCgvoUmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366433; c=relaxed/simple;
	bh=VCODBUcFdR+m4d+/qRMOdhUyDpMyO4qviqghUs4jBUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ergrQFosONIJsqgqoOi0Io4N5DjPyN71g+hV9327u4hHrpxzVX6psqmvZ3mU8zZFnTI3iUhc1NKdZjjCUG7x4gYv0a7m00pQ18LjsjmxQCA3oGRbBv19qVcJLytJjxdtUfbcV6Z5O/IUFYGGCj50eVXg+BTUvnnJXtCzuyYX0dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M52iA5ek; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUjG8g2ymZTTmNFx3Tn0fmkWxy8Kk5UCuF1aC64odMqvF4J4wc+ZqERBqfzRRsqX2YdCUG/E5NMU0AqWcgfQZmt5IWqobXbY+rwhGDYol23kjj0ihFWFHmqy3A9O59YwaQ0JhgN3gIh+sVk54ra0THPOHLbPHkh+w6Ms0u21Hccf/OI3ezknkAvg+PD8rSByGdU7GytiwP2ljLWDArjvOEsmLH3CbdJH5Cl2JGArz8o/TuR9OqLecv6ed0XNHACCHVvkCvX3fuq0JTi4XAfIJ+wrTszWdmPmmEebqBiGyeQ+YbFyeQ0O22hGDQVFlitGQaPgD+uFo1LNZqTmh28wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNvSzmo8PxtYDxH+iUZiaWOO2AJ7iRrwNgPX/z2xyYA=;
 b=ySiiljqGm1VUh4UTmOYZa/4Lyf3qk68ke6l87sz3S1K17F1I12UnSgknj/z6C4xJv4iz+HJddeRtESfJ4zsoq1aMcCI5JQ1WngGPU580T+RJPRITtXda8FOHD39HkmeiBIe39WxyngeWC88vTYBVYydSEtLS13cJ7SnLbZF1SOdGSn97gnfQFHTzLB31HN2QMR6S7dUvaK2kQeaggnXq6d33sSjjtirdcqJnWK+OHsXy+Ku0eZPj85rkhuvRj15VOskIWYvgbVkCiUgHCXYSzpWtMlF2j2hilrQOnOw+Ywx2YhFgWdPjaHmSRMRLcUM7aPSh0j9Mg1MGh1PT4nLL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNvSzmo8PxtYDxH+iUZiaWOO2AJ7iRrwNgPX/z2xyYA=;
 b=M52iA5ekDS6qSGpJeNP/JUJJILayNfzMI4RTZIz/0+e+r79t2f9TzvWW5KP39ENYXy7oN0qkk5kRxHyDXHUOthsL9WanDvcLmZ7rZXxRxX1tTTMHzB/z1aXzDdFcjgaHymSUqHrs67kp53w4ib57n9JhmheBhdFw4bJKCkw4kis=
Received: from PH8PR05CA0020.namprd05.prod.outlook.com (2603:10b6:510:2cc::27)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:53:50 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::19) by PH8PR05CA0020.outlook.office365.com
 (2603:10b6:510:2cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.27 via Frontend Transport; Tue,
 28 Apr 2026 08:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:48 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:16 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:53:16 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MW623293;
	Tue, 28 Apr 2026 03:53:12 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 14/19] dt-bindings: dma: ti: Add K3 PKTDMA V2
Date: Tue, 28 Apr 2026 14:21:43 +0530
Message-ID: <20260428085202.1724548-15-s-adivi@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428085202.1724548-1-s-adivi@ti.com>
References: <20260428085202.1724548-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dcfca8-daf5-4768-e903-08dea503a9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	2qgHDO51QND2SG3RWpQTfZxTW4t1NIcN0jx0L/cXb5AQT5Nd0ROO+tq4gT4ZI/g0OplZ7w176rQymU2SYIccEzKOPiUXh3lIdq1UHkHyR7/RDYfMuI0W5xen2hYmrs2tDzVXJ8+94aBMP114uzevSPzGg+wLFZlcach4M5KOUAmNV9/6m0wc8WSSvc8LfyLT8npSGdsoCGKIhXjSQ8MSMYb1cfUi0NcOPJIIaOL4D8SNs9RMr17vdYrzfJhM/+oylS8ZalOvRbdu4EbJVVZqnmpZtIYuhuGtYbb8gf6UpZKfZSZFmQ1mUo9Gu83Jk2dm41Zw/XpPh7e1djdHw0L09QkfBF46c3I1h+iqjTCmT91ActVsFEhOeLWbBxzJSTtwi5E3exuAf0kgNsxUkprBDp0sp9QiGocZV3Rdayy+hm6uCdKtFVGngQX+5+tu7g36eqdbcqqhWwVSNpbSnAQW/OcBZZq+Ize4ozJTYzkBSWPXEVGKz23WurqAbxvUhnXht5Z45hV2NLUig3qkIiybINmhbH5tTqDpKjpz0Yla75jrJF+o42vvrbUJhAZ5+aqDlxixlc8Mkcjnxaj4GOan9oMF7i+7n9sPdQQHjOMV69NwTohOF0hkOx44amUqKQQazgyuLhitTgMadAdLe5dzeBPq0wOXgH4WWiymt45YdhsBtW1T4d+lTm4DJ81DEz+XSbz8Ys09S6+QiBLP3xgM0JM3AgPm793B6d5ouQS7ZOrWYApz5Tu29U5MordKYufTqJrHi/W9/af0JIcW2yjnHw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AOtNrfAKW1KrMFfo9IgiXt6OCVYVzJyIEJthOoKGSyjfpyyHg2fuc4Ar/yu/EVTed7bYTa/aWRLMF0cyucaJcqIyVxWLWynH6EWH0LfhGkrOc4fymQdyPQ/eg4jEG2cX7LZIddiAuzOabFazChza+6LB0Sm5oK8AU326EoQamigQmq2IQIEKDhjGE5O9yrjml4D/hHg0iGY9oJAqKHlGgOHCC5lIBBqN2vqWjW9j4vujpUvaPxysLHhu6LDO5BiXXoEfZvw8kR3SfxxVk6dEmZ7AV/XlxTAnv/BzO1rUZEW+TCYmx+dpMdqhDZNxYBeJuggpypReHtbQ/7PmnbDM3ISHf5HKB0Kzr6/Xk2XZH/RKMbhts3B6WZiXDe3zpFszQXeokDVo5RmUVgSxNIGvSTmAb9mzyU3md3bOfp0VCc7nnDW/vUvj1Tld3ATNXkRr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:48.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dcfca8-daf5-4768-e903-08dea503a9b9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Rspamd-Queue-Id: 025E848188B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10180-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,485c0000:email,ti.com:email,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

New binding document for
Texas Instruments K3 Packet DMA (PKTDMA) V2.

PKTDMA V2 is introduced as part of AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/ti,am62l-dmss-pktdma.yaml | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml
new file mode 100644
index 0000000000000..32bcb0ba502c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-pktdma.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-2025 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-pktdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS PKTDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description:
+  The PKTDMA V2 is intended to perform similar functions as the packet mode
+  channels of K3 UDMA-P. PKTDMA V2 only includes Split channels to service
+  PSI-L based peripherals.
+
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am62l-dmss-pktdma
+
+  reg:
+    items:
+      - description: Packet DMA Control & Status
+      - description: Channel Realtime
+      - description: Ring Realtime
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: chanrt
+      - const: ringrt
+
+  "#address-cells":
+    const: 0
+
+  "#dma-cells":
+    const: 2
+    description: |
+      cell 1: Channel identification for the peripheral
+        PSI-L thread ID of the remote (to PKTDMA) end.
+        Valid ranges for thread ID depends on the data movement direction:
+        for source thread IDs (rx): 0 - 0x7fff
+        for destination thread IDs (tx): 0x8000 - 0xffff
+
+        Please refer to the device documentation for the PSI-L thread map and
+        also the PSI-L peripheral chapter for the correct thread ID.
+
+      cell 2: ASEL value for the channel
+
+  interrupts:
+    minItems: 1
+    maxItems: 112
+    description:
+      Interrupts for DMA channels.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 112
+    items:
+      pattern: "^chan[0-9]+$"
+    description:
+      The name of the interrupt corresponding to the DMA channel.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#dma-cells"
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@485c0000 {
+        compatible = "ti,am62l-dmss-pktdma";
+        reg = <0x485c0000 0x4000>,
+              <0x48900000 0x80000>,
+              <0x47200000 0x100000>;
+        reg-names = "gcfg", "chanrt", "ringrt";
+
+        #address-cells = <0>;
+        #dma-cells = <2>;
+
+        interrupts = <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "chan64", "chan65";
+    };
-- 
2.53.0


