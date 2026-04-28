Return-Path: <dmaengine+bounces-10174-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E8NMUF38GlgTwEAu9opvQ
	(envelope-from <dmaengine+bounces-10174-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:00:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D1480C91
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F206307A607
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474053E025A;
	Tue, 28 Apr 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v9tsyCg6"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78683DEFFA;
	Tue, 28 Apr 2026 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366397; cv=fail; b=hz4y3nKPm8ICaV4aAo5+VoNR+n8NZ4V1hU8aGcWe465N9/yA/DQCIaVz3KZbRjhx0TBr6d2l5fuhZHVnSSNcWvLnNMHhqtognq2s49Ntlu1BQ4X3tgDEb+SQsBBBiKB5cXY2dsS9ShVQBPi+bublvNWKNhRrjD0pyqzfGlD0lQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366397; c=relaxed/simple;
	bh=umwpW701IjAY92td34goO9XpgZGiffLNNoCb3kEnN5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/WKyGx5ZZ2o2YJRxEcNEK8htr61/Env4+a1SaONnN5aczLj4MFwf5J1ghw19s6f9YJmsZMl7VqiWUGJIGjZECZN8zRp0/uVFGHsOzmG4MM8kRao5KEK3Smoehu+lrMWynw/tmXiiY8YiUIEreeTtAR1NM4UHA/deGMr+WD0smk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v9tsyCg6; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVU9J/d+IwuYTk6tWB1uBdf0LD/J78g6+6hMU8oht1ac1HCpDw/aTLCWG4sMKep/eq6zSl2uYRkjk7RYEy4DGohWvupQ3XHRNNY7yGXhJaOihJS3VejH0QpKhDaEflX7DSzOBkv6bhnBarAyMLq1YP9/ARrvdYgsUqA2N2ngi7lzDezT514XDz34F2aGxFhLYZ6r98fOmRG7W/AByYZdGFihE0nTKlu8YArpzTH2PzqRs67gksjqi8lIXvRbtCt8TTQs+0wimZ9AE4Ty6VaUWKHK0H3TeO+soCcVHY4Itm2fP2iNmsN2KfKlkXY7IYDlrRR0sEyCVOQlF8ukL+H2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTytVa4bNZiYGWAnVQ1DtFr3lqJwt/SysrwGOHCAreg=;
 b=NmUhZvDriR6c+puQ+7qf/26ZuK59hkgcyCGtS5+VXO/ZpZy7eEX3qVxNWMDIbLCq06iPnLDHyNC2GzRWmBgoWmsE4Uvx2OyzcYKH8wJJ++0VIiEhAe+UIfYKB575nmeUh1bn/NEM57JDzBXD8at+kVjprCbyz1yHxi6riRKRkTdqIsb+FtUX2PM0gUw9llbuzdkD5mA5DRxy055SPEKpg1YV9JlBJwVHGb4RFeM3cOaeBAMN4Wlq491j4bwIyfJKBZgAXFHY9/0hpzHKFrMFLigqqT3nwaoeuImZdV+lSRHirdw65lYli/94PwU8orz2DhBAOOx15cfaUEHlJYU1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTytVa4bNZiYGWAnVQ1DtFr3lqJwt/SysrwGOHCAreg=;
 b=v9tsyCg6Hnqru6VNkStx1rXQVuSQoXEq0ws0G6kiJBZ8cNF7hMcZccn9lsBLInn4rK8EvWSIabuaUiHUBUzFUqRor707ZD3EyMOWiw1s+8GRg9iEGbQwdkzy/gtXsYQcIg/9RZYbNZAw/cO+26Zr9biBO5hZC0ZjlXKyqXjmLBw=
Received: from MN2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:208:239::19)
 by IA3PR10MB8590.namprd10.prod.outlook.com (2603:10b6:208:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:53:13 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::bb) by MN2PR08CA0014.outlook.office365.com
 (2603:10b6:208:239::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:13 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:12 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:53:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:53:11 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MV623293;
	Tue, 28 Apr 2026 03:53:07 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 13/19] dt-bindings: dma: ti: Add K3 BCDMA V2
Date: Tue, 28 Apr 2026 14:21:42 +0530
Message-ID: <20260428085202.1724548-14-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA3PR10MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d6b2ab-6df3-405f-d25e-08dea50394c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	k2Vufs1Z22aP0zmmlb9R12OmgPsHy7NgXeygkB/A2cnnwXyhesFipJy2jCkDkHroAfr3e74Fx05hM9NWEIYOS6CN0KqQZDu9qoY3XutZJNBKIufZ4XQpMAWfovA0AtUXdZrQiL5MVuMj+APhXWG1GrFlFJfLoRbwLNJG4Slod1EIy7kjszdSoI9ZZc2Vkzi1Ct3wM6dH3+LyNH0CD12enkh/1xbluZYKPZcpzlXFpZkk9LHLF0DNPJuWOnSYJtP2lCcJgsMvSaQg8c7nyPtT+vKKsC6ge4roA5gP6SERRudlWk0X0F9K0NytlFAUMh7WmmjhLESnDg2zt5IUzOvSIlab7XXKF6q6Mz8I3Y1B3/uoGwv8Nqqha7QqnkLXuBHG797/S/fJ/pZdtnj9SaXT7zlyM1PRmcw5KyHThKkEUuU1iXej+f6NdlTGPixNMKqM7fhG98hydA7pO8VN1s/JGmj31qUhoxjb/xgG6vZ7xGlm1rGkCEl6BgZMue8gPm7LspUptWVx0Hu9DdhKLX0L68gIWg+v1NzG+SiGjrnUP4TqU9WY30m0DM8/vGqhOPmgFi7yAnztHBz8Wzgnnz1e9InDoB5z8wQ7GYvr0zT2HKyMQrnEjBnV29uTiiJCCty6VfBSZA8J6fS1rXAhtjYMjwIhS7+OCKL2mv6KNWWhPKbXNKek0XzShUbKXoylgkxwgVG3h6b02dRJY+8bxs/abJDbYqBFCmOrAO3zX74Kzh0daJiVhNLnxq7y28R1aBRoD4GkNp/yNV34fSOWm2jcdg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MH2JnPEoQ+EVpdv51MFx7pSf9qm5yssqVqiB/l3+o4370gzIVOsVj1o5iqdLXgKfMUkNUZzURoGcLw8m/BAD8sqtcN4NJnKTgP8eX/Tdmcb7Mge8XpmgIcd+1OzvvUWHQOPjCVk2PekTbPykIU6rsAeHhtgIqZPVgygxQll0Wuqpk8I9gdT6QJiNxH7UEOnU7BDmuszRafQdzOTenw1YsME3AoAEvW6j2PeQfoP+qg7fhh9f6TCTW598MnDdNjmEEZwVOOh6XiCXuxhMrVfSc9/vqg80KHl8pvdmoEBOdQV6pI0r0uNkpedOAN+FvsYjV6tWbS8JGSVos9FtBY3aUSAzVyseEyZjg0/eERSBpxC8eG9lkEsI8PS20y46R02wG39wMpWGu4jNCuPuc7p//NWq5Mu9a0U517Oy4t/BQuulCMJ4xo1RxYbYpWSfZTjC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:13.1550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d6b2ab-6df3-405f-d25e-08dea50394c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8590
X-Rspamd-Queue-Id: 885D1480C91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[devicetree.org:query timed out];
	TAGGED_FROM(0.00)[bounces-10174-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid,devicetree.org:url,485c4000:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

New binding document for
Texas Instruments K3 Block Copy DMA (BCDMA) V2.

BCDMA V2 is introduced as part of AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
new file mode 100644
index 0000000000000..28dcfce5633ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-25 Texas Instruments Incorporated
+# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS BCDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description:
+  The BCDMA V2 is intended to perform similar functions as the TR
+  mode channels of K3 UDMA-P.
+  BCDMA V2 includes block copy channels and Split channels.
+
+  Block copy channels mainly used for memory to memory transfers, but with
+  optional triggers a block copy channel can service peripherals by accessing
+  directly to memory mapped registers or area.
+
+  Split channels can be used to service PSI-L based peripherals.
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am62l-dmss-bcdma
+
+  reg:
+    items:
+      - description: BCDMA Control & Status Registers region
+      - description: Block Copy Channel Realtime Registers region
+      - description: Channel Realtime Registers region
+      - description: Ring Realtime Registers region
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: bchanrt
+      - const: chanrt
+      - const: ringrt
+
+  "#address-cells":
+    const: 0
+
+  "#dma-cells":
+    const: 4
+    description: |
+      cell 1: Trigger type for the channel
+        0 - disable / no trigger
+        1 - internal channel event
+        2 - external signal
+        3 - timer manager event
+
+      cell 2: parameter for the trigger:
+        if cell 1 is 0 (disable / no trigger):
+          Unused, ignored
+        if cell 1 is 1 (internal channel event):
+          channel number whose TR event should trigger the current channel.
+        if cell 1 is 2 or 3 (external signal or timer manager event):
+          index of global interfaces that come into the DMA.
+
+          Please refer to the device documentation for global interface indexes.
+
+      cell 3: Channel number for the peripheral
+
+        Please refer to the device documentation for the channel map.
+
+      cell 4: ASEL value for the channel
+
+  interrupts:
+    minItems: 1
+    maxItems: 144
+    description:
+      Interrupts for DMA channels.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 144
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
+    dma-controller@485c4000 {
+        compatible = "ti,am62l-dmss-bcdma";
+        reg = <0x485c4000 0x4000>,
+              <0x48880000 0x10000>,
+              <0x48800000 0x80000>,
+              <0x47000000 0x200000>;
+        reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
+
+        #address-cells = <0>;
+        #dma-cells = <4>;
+
+        interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "chan49", "chan50";
+    };
-- 
2.53.0


