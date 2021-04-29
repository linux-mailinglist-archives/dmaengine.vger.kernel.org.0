Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805336EC37
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhD2ORM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 10:17:12 -0400
Received: from mail-eopbgr90078.outbound.protection.outlook.com ([40.107.9.78]:43728
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235277AbhD2ORL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 10:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfYc5wL+ryoNOg4AdWsuEbqSwzK+WBYj7OfibKpN33sQSUuE2B26LEok9n/wVzSUUHQniNe8iQwQWImUCggfphJwEir+IVx1v0SCAQNgIyUwXL9BjySSuPoj5mT+idePJZiC9FEvviTnCRqwXoAvz0TTanKPhayC6fue+w0fgoOEP6HWpvhaZVy+AUTKiE43EEgSqHe47ma5v6VXt3+Qm4S93euIF310A3P6fCa6ZW6k+clk8/KFMOd+rvZSYC5qnRe3RiRIjiuI528RCJOq3aH+svGgoCcuP/9dr5kJoKirHgpyBLdv2aE/TIoJ1x8RJqBIFhWQLkfVh9z7UpiP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIlRAc/PKxBS06pt+h2Wf74lRAt87X5opB+DutgyMUU=;
 b=O2I1uBIMBqPAmerTo+0mZbcSC+MMTA4KuBp3c8Ep8yD27+p89C+Y5V6bjgSNJqSNBiQfjfImjhEp5PQevonANjCMMbWXGNbeWlUf31t5jPsOwTcMMDC8pJ+uh9H8NUL1Wi6/010pmu24rZ3c50SPdLWSVu0onSN1gbuFLB6t7W2SaPtxOEcefP4jxY0Sxjv1z2eRyKRLcWNLf49Qa+r/AiYsUu6w6vyVA+suV7QV7XJvt01xNVgxu/YVooWfj0nRf1td0Mh2/5aultjlPmRBZf0n+vZfUuHkEPjhm6rc7SL22yt84KXYuozf8c6HGjpzFftQ9sfs0nv6jcTuKjIfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIlRAc/PKxBS06pt+h2Wf74lRAt87X5opB+DutgyMUU=;
 b=KgdOCJzCNVIgoJ6m/cf/Oko4ctZLCwaqQNVYgh3BmEvAhXgfSo6b0b0RBwF9Z3s/QuFrCgm3r7GN/8szemr4i1yXlU+mibm3X1FZWEKw6m5QDnZMEDZQrgmmeVM+bl61yvJrcu65fRaV4IsR1zuJqY04JNrbBj+AOXCIqUdGmk8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB5578.eurprd06.prod.outlook.com (2603:10a6:102:b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 14:16:22 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:16:22 +0000
Date:   Thu, 29 Apr 2021 16:16:08 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YIq/qObuYw+8ikxg@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::22) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a6fd62f-06b4-459a-31d7-08d90b195dc1
X-MS-TrafficTypeDiagnostic: PR1PR06MB5578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB5578EC5018C9CC85760BEAAC8F5F9@PR1PR06MB5578.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f7NQ9rKAUmcf3d1Pw+KLS6ROhjKusv1M6Mq1utb4L0ZxTY2svlMDV7HI6qaSVUMTrNRrhL9UC4VU9qsaaliWbjnNczzYQsvpD8YCB/fHfIw/sN9J3FL3qy/t0Hool8PRPv5d84MTX8JlTaUnIwJxs78DWRXMzb0f1H0dAaZDM2tsQksGADOrkpDUtmgwwwh3A4PaPvKSes9nWl3vI9f2LplzqhZCbdZCOE4OYKKsqNlGDV/EkmkWZ4OmuB5eQoKzpvMgspSeNSHPDlnKvueyCrx8V3XI97JcGziGkDxiTjA31h4bc8neyE8dqRWcFyYg3k59sparDstwyuqWTiufumzVasfGXQDUkRdhlzsJae+9UFXFtnJucnSCK935iMRt1O4pWcK1UhGdXqcIc/ej+fDB5u8gFDGsYaBacNFaB3oWezSokTEKMhGeUxeNA7aoSGLfK/oUV+dECSF4+tOX9s6JA9okdnzPPQDzf51+qgaY+jdE1FXqVSdabDFDqneBA3Ign/qEUYIE4/WFOnAsXH2XI+uyVaEVMMtnwr9VtTfEBN7yvh+3Ds4u/Di6wLJ+PH4VRdr+jp9HiRCtPdCFI5OAqo2QGrz4lhlTWEcidoKwVQ7y795VfhGGAlLKtsYpC4589c1RGxyI/mk/vSg7gqmTDDML/7jEwXUEsQ7co/6mxCo8L64yQe5YCFecDN3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(396003)(136003)(346002)(86362001)(966005)(55016002)(2616005)(7696005)(66946007)(8676002)(6666004)(5660300002)(66476007)(36756003)(8886007)(66556008)(110136005)(478600001)(8936002)(4326008)(16526019)(83380400001)(38100700002)(2906002)(44832011)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVN1NlZtN3kwT0UvWmJvSUNaSWRHbWQwNjhXUU5GTXR4V01qWEp6TW13YXU3?=
 =?utf-8?B?RjUyUHExU1djWWR3eUVPbVJPT29zVVgva1V4OXhtd053S2hGWTdQbi91T0RL?=
 =?utf-8?B?ckF3V3BxdWNBK0Z0em8xaGlMNWNINEVBQVZmV1VjUm5FbmF1bzIvNXk1dG92?=
 =?utf-8?B?SUdMZFgrSmxFVzlXOFJDY3FNMmN3REdBQU05bEI0blhzV3AyTkMrUHp3cXcw?=
 =?utf-8?B?ZFhBbDVJZ3ZkTjhjTWxQTnRnVFA1Z3VXWjlRTEhpdnV3NG5ucmxjWFEwbS84?=
 =?utf-8?B?SjdlMmE5dVBnNzFscUZVemYvdmtST0dGSVlsSjZ0YnpzN1hpelUycVpNWG5M?=
 =?utf-8?B?UnhvcitmdzFYZk14dkNMZlZ4QVdHY3dSOW9ubW84YnFQR2cyZnltOE5jSm90?=
 =?utf-8?B?OS84WXJucFpYZFh2bU9oZExVUVBJUmNndU8vZ2cxZUM5clovOFlEcVdTTHNI?=
 =?utf-8?B?cG1DT0E1MWpBZm5wTFlZZDhZM21BN3lhbU5zSUk1TG5QYkRKUVcrWG9LN3hB?=
 =?utf-8?B?THVSMkZzckhvUHY0ZCsrMXVqTUs0d1pXdkJpWkhUQndpOWNnVUFjdC8vbnov?=
 =?utf-8?B?NWNLVXh5cjVjeDVVZW12UiswTDR6QUM3TFFDZVBJRC90azhqQTF1VlY4ampY?=
 =?utf-8?B?aVR0NFRSS0hSclZiRDJXem4xemE0WVMrVXM1VEEwTHBnQWtvRWVDM0E2YjBs?=
 =?utf-8?B?RU5Ienl1QllWQlNjRXF3OE1QSDQ2S3FyamJpSjdmWnFYWWNxckN3RlpxZ1VT?=
 =?utf-8?B?Vk12Q1h5V0E1K3N3Sm1seWk1enpEQWdyNXpHVWVZaGIvT3EwTllibHQ0MFli?=
 =?utf-8?B?M1ZqT0tyRWNkUW5nS3dqQklKZFdBTHAvbFl2WXhhd1IvLzdTZzYwZ1psRjg0?=
 =?utf-8?B?cU5XcXJVODhNVFpOTUtqYTc4WWloUEFJaUNzcG1mNy9La2Y4ZEdReFVCNFRQ?=
 =?utf-8?B?dVZoWkUvTWZjKzU4cTJKTTZoSEJScTBQVW9HQm9PQXBFTnFFY3J0UE5FT3Mv?=
 =?utf-8?B?ZFo1UVl0NUFxVVg4Tk5OL3lGZ0pyem91c280NzdDMDhPT3d2U3ovVEZVL1ZZ?=
 =?utf-8?B?VjRZYTJPQ0NEQlVuRDZUNmxVVFdIeFlZUE82Q0JwTktsUUxWNmVaTU9jZVBW?=
 =?utf-8?B?RW01L25mM2xFTFgzTzlNUlhrajNRR0VLY1pQZHJwKzlVUjhNYVg5cTgrdWxs?=
 =?utf-8?B?MjJTZjRpUGZNb29COC81V21OdXdHeG9YR2pxSWFsV094R3MzN3NUUTFtTEdj?=
 =?utf-8?B?YzAwdUI0bXRKdUlXTXVVa1FYMFVTdEhqak1ac2NYOXdxaGtvanpxQWJ5dDIy?=
 =?utf-8?B?bjRXQUJMUytYMWZCb0JBZHRWK3lXSTRNa2dJYUFGOEVDbHVUZGNTQkdOaVR0?=
 =?utf-8?B?NG0vZVdmRzNxMXJKNEJOWVJYdTAxVFhDME8wUXdNVEpBdWNmZHlEdGUxYWFh?=
 =?utf-8?B?TmZadkhpNE5wUWordGMwVFM3YkcrK0VFMFl2alRCMXYzWXpiL291ck9hRmY4?=
 =?utf-8?B?VW8vWXA2TWpSL2xNVUFOVW9tZEtnajFNelBWU3AzUnF2MjU0dVBMcTZJRGl6?=
 =?utf-8?B?M3U4ajdOditaQXpjM2dFU3Qwa3lpbjQyOVpNQWFIY2w2Si9YL3R3M1JpMTRC?=
 =?utf-8?B?b3Z4VHZEUlp3NEV1RCtmOE1IeTVNMXFmSFh4eFlNb0psUHZ5SnZZeUxkZXJB?=
 =?utf-8?B?U1pNQjV1NWt1VWVqb3ROSHlQNnhWeHZQQ011OEVvMi9KMU5CTjNCcFN3TFh3?=
 =?utf-8?B?Z0cwc3JIT0x0QklSR0xyY0N0cTFOQUlhZVhzNWdXdjAyY2sxV25DRXlhUWs1?=
 =?utf-8?B?WHJNR2h3VjdNUkJQTmt3UytVVmdEcmExZHdQeDFIKy9NOXIvOVV6MkgxaDF5?=
 =?utf-8?Q?mh+YMBmBRTWyx?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6fd62f-06b4-459a-31d7-08d90b195dc1
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:16:22.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlbTosUbK4bge+3jfKG1YS4prLY+yume99OKj4i1lyqDl8QfR4/EcMyM9TkAGXp0HcSO2Q8HcXzk+FfK/zufv1uZEkIQQNy/sCgkLjT/a80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5578
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- add schema for Altera mSGDMA bindings in devicetree.
- add myself as 'Odd fixes' maintainer for this driver

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    Changes in v2:
     - fix reg size in dt example
     - fix dt_binding check warning
     - add list in MAINTAINERS entry

    Changes from v2 to v3:
     none

    Changes from v3 to v4:
     none

 .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
new file mode 100644
index 000000000000..295e46c84bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/altr,msgdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera mSGDMA IP core
+
+maintainers:
+  - Olivier Dautricourt <olivier.dautricourt@orolia.com>
+
+description: |
+  Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
+  intellectual property (IP)
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    const: altr,msgdma
+
+  reg:
+    description:
+      csr, desc, resp resgisters
+    maxItems: 3
+    minItems: 3
+
+  reg-names:
+    items:
+      - const: csr
+      - const: desc
+      - const: resp
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    description: |
+      The dma controller discards the argument but one must be specified
+      to keep compatibility with dma-controller schema.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    msgdma_controller: dma-controller@ff200b00 {
+        compatible = "altr,msgdma";
+        reg = <0xff200b00 0x100>, <0xff200c00 0x100>, <0xff200d00 0x100>;
+        reg-names = "csr", "desc", "resp";
+        interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c90148f0369..359ab4877024 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -782,6 +782,13 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c

+ALTERA MSGDMA IP CORE DRIVER
+M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
+L:	dmaengine@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+F:	drivers/dma/altera-msgdma.c
+
 ALTERA PIO DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
--
2.31.0.rc2

