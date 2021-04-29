Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1702736E5E6
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhD2H2t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 03:28:49 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:60609
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231528AbhD2H2t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 03:28:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFKjeEbE8HpjpjamHPiXbNWax1NY5UTjjvmh97CTj4z/kp0RFC+3UA+U091bgq3tee0sme13i3tiKfvS+R6/Athh+dyGStgFZL2ABQi8/MJZBJBsgiu1Oo0JcqOUuXRq4gUcDz+FJ3v3NJcrEEi2OotdxM3VSJGs9X6OiphCnuhv/1CqJPnp+V5X7Ftx1gYy8vF9zzuTPnABILXg/xZvv8snpKwQWiYIyJXEwzRsjGGakcRJRXmZmDulbUmJQAuKXCuUJTVsrZPzEk0c3uavoE0SgkogoeRpXx+lDpsa/ZLZUTLHYpxnaxXMldr/n55rLzNVp3gQKjLbp8XdKp2A3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7M5BwGtc+TGxk1+g6Ru77Bm1u2VBpxv+oxxYW/INUw=;
 b=TIM6l3ChT7OupZrFdU/h73UNVHrkgK2cQgy6mlXQZQia0n/Mahc78awJq5kSog+QafJ+0XeuNEuHbXWbZHJov6DphwIrF0ng/H/S04tIj6vi788NWa1hpcnOcXub8fF1o4PATJdO2cyR7Xz+6zypb3Lb5cQRRqDXr3bew5eJagKifWiJgVyJEkCNeCAQj/RHujFI2x8lRIIxX1Rui+85X4/DvZThe93D8tcNWTOerSFmx/mhuu5M1AmnH+oCdV9gcJdNHwEoIk0hK+O1/gaCENGQ0USSc2eOoJrsD4kyMfWkzDTL9SvvsTNoFNKsvsGBIShrLD3C7aX5FBRWwFCOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7M5BwGtc+TGxk1+g6Ru77Bm1u2VBpxv+oxxYW/INUw=;
 b=HvedZG3Z7G8HLNiwXMgfNXxOCElIJntYYuYC3SKAIq3UBo6ItCm9cLA+JwwqO4L/50y1uigPU1uxq6v/S/8lx1/vMDq3T+5vL6Hiznt3DNuLuecOvGCd/ZFTcxwdJ0Px5vOMmaxwikAD/gyti1tVeWAeuBoA7AnoW006E7/314o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7552.eurprd06.prod.outlook.com (2603:10a6:102:157::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 07:28:00 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:28:00 +0000
Date:   Thu, 29 Apr 2021 09:27:46 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YIpf8p45giN3+yQ5@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR0P264CA0241.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::13)
 To PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR0P264CA0241.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 07:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7c6af0-8f84-4ccf-6c0b-08d90ae05162
X-MS-TrafficTypeDiagnostic: PAXPR06MB7552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB755260454014FDB856863D4E8F5F9@PAXPR06MB7552.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVqHJJphg8ZwvqMrO/tzSGBGu0rskwdj4DYRYEfm9gWqvZ/vExbtuacf4M4/t+XhHS6eR7ffDWL/YGktQE58s67+0jk07jSOD521AXuEKy/+KWZ3RzcMJ5sbJk415AkyUj/jas5oUMu3mA5nxYjE4Qa3Jd+eVa/qLEsQanHxKNeZsSGFggo90YjcktazNzUSU+GTQlnLZlhETVKgB4zQ2beNk1qBXwX/pnQfddNJqo+W2QBXh/RsKE6DzQXWDPTngpGPN4bAp217wh01RN14KnugW42AYixYGE4NCAVctvC8/ct2W3+NRexHZwx6rYvH4oWFr7Z9tTFn2wr/nLlhttbV/6dq98emGMXrwi/ID6CJo9AwhwIz107K2Wfj3zrvvpZg0JofpVAz711XxJsLCPyr7yzK81U5D128KLHIAbtxC8wCj9lWBRAeuH0N+N2Q2LV7HI9DT30CNdup9DVXHMGXdFq2IzYJb4ef39MsajFD1seiiIs2qUrH18Vwlwhd0VYNRs2Dl4Hsm1cG1T3aJsIokaAiNTnbav6Eg8LgfJJB7BIIs8REFajmQJBorIVVu5bABRAGBS4tw4jc7OsV7OU2q4A+d3AiD0M19pLYExOACblk80PYpZU2qSogEIqNGTTwRJAT1meGnumHLL176kmjUnuv+Jk9+mr2sH0V3Zzu1nhT7ZTzg6puIG8Ns9BeDuliKz4mnKojIlFnM7UzwTF2MQlfpch++KQswtioXUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(136003)(366004)(376002)(396003)(38100700002)(7696005)(186003)(316002)(966005)(5660300002)(66556008)(66946007)(16526019)(478600001)(44832011)(8676002)(55016002)(110136005)(66476007)(86362001)(8936002)(2616005)(8886007)(83380400001)(6666004)(2906002)(36756003)(4326008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWNEeVd1ZnNsYzN1c1VUZEpQT051cU55VW1JdWJYOG1QcnZPazYxQThBRk03?=
 =?utf-8?B?Rm8wNGlRZ0lIVVY2dkl6VHB1WXc0cjJzcHcyM1BmcmYxSDgremo1R2xOZEdR?=
 =?utf-8?B?WEJOQW9iYzhEbVY4Wk5LQU1vUVgwUVRmaGR4U3Zta3M1QVpMTTFhbkR4MFdn?=
 =?utf-8?B?ajhJWWtRaHZXdzlXVU1FeS80UjhjYjRSa2Q4ZzlvcEM3Y0ZkeCtIakNKMGhX?=
 =?utf-8?B?N3ZiZ2N0V05QWmhMd0tJeThQOElXZVkyajVwdGZNUjFaN21FM1lsWVBqOFcw?=
 =?utf-8?B?cVJMNExhTGtmK0JscEZlYStLRFZhK2xrUjhIK2hKWnYzdyt5cERHSGd1citZ?=
 =?utf-8?B?bk5uZFc3VWNkVHZPWUw2Y0ZEVE9FTkpvOHdNdFhJa2JoSDFLTU5CcUYrckpu?=
 =?utf-8?B?MHJrZEg3MDZ1LzVXYVNUejV2M1Nzdm9YUDJjT0JabFo1NDNzU3JKWVZEeGZj?=
 =?utf-8?B?dTF0M0FKYUxFamtPQ0hYVFh5VEVJVS9BTU9OM3ovRW5KaUpKZmF2S2RhRTdx?=
 =?utf-8?B?RURuTlNIbGNTaTdEanh6cSt4L0hySDlVSFF2cElORmdvemJ1ZStrbkZNdUVw?=
 =?utf-8?B?cFBEZ2s0Ymh1eW5SR09nRW5qanlwMEJnTmxUTEdNZkNHYW9CcGhmUERwTVBR?=
 =?utf-8?B?UzdIYU9Xbi9iUFltdDdKbG82Q3lJa0RpU28rWFRYam1wa2JucmRnbHZPZHV6?=
 =?utf-8?B?Q3pvUEZBdUQ2WWE1Y3lRcFBYblRYeGxMU29Va1piNktmU1JVU2kwdi92bzM4?=
 =?utf-8?B?RUtGTXltRmZ3L2xZcWxsUFJYY1F3dVFVZTBjMlNhcnBLa0hXVHk1S2NtNWpl?=
 =?utf-8?B?NHNrbXo1UlBid1lyVXVpcGl2aW1BYlNTbkcwUWtCS1Fpd3M1a25mV3FUd2hi?=
 =?utf-8?B?d1hpYnhTNEhTZ29OWGkvbGRGb0pucWhpYStHZWZpQm4vR2tHY1dXUjUwQzk2?=
 =?utf-8?B?Zk45SzBXZWp1MEhOMHVUNHMxZHRwcWFKOGcwQllpVHhFSjRBVVY1eFZQcHFp?=
 =?utf-8?B?djNDQlpMQkNyOFo2SDBjM2pRTG43RCtmWWJPbWZYYTg5M3orYlQycnpDbno3?=
 =?utf-8?B?WDArL3R3eG9hVng1UWxsWVhpenh6R01XdjRCVkY4ZVVkN0tzU0xybXVjNWw0?=
 =?utf-8?B?aXY2bTNoNWc5eEwva3h1YmpQdXgvNXZFVUZmRzh5NDA2WVltc1UyZC9DTUxq?=
 =?utf-8?B?emdqZURxeitEcWJyTHN1QkUxUlF4dWRRd0dZdkhjMXN4eVpwdk56TzhzZ2tw?=
 =?utf-8?B?NVl5bkJoMmJCb1FJbElYMzJ0WG5KSEQzN2pMY1NCemNSak1hVXhsTEtXVGsx?=
 =?utf-8?B?aVJkM3Y0R0tXVmRLVCtxWm5GQXdxM1VvUjRDUG8xZENHR0ZDTXdtbm5rOFo4?=
 =?utf-8?B?Mk5LcVdQWHZjL2tXSHpMVlJGamFxbVV5SlloYjgvdWZCb3drZ1RYeHlHQXJY?=
 =?utf-8?B?YnkweWd1citPS2MrdlZxN0lHeENLK2RqMXF2bnRyMzZ0QzdlU1hKY0F2TXBm?=
 =?utf-8?B?SXpUWDdLWFdubFRmYm5rcTNSMHYyenpUREE3S0VQalI4VG1KNjQrUTV0azd5?=
 =?utf-8?B?NGt1WEpGREFxOW5rMmlKUlV3aWpva1dlSUtmU1FSbHFNSk9vbXVSc2FHaFV5?=
 =?utf-8?B?MmZwQzZ4bWQxbVArS1RxWlN3NnRwamVqK2JVMEN0NHBPL040bDVqTjBKUTVk?=
 =?utf-8?B?QkJpcGcrdkorQUVTYnFYNG9PRGxpMVl3ZEJaWlUyWEJPMWVESnNzUy9Pc3Qr?=
 =?utf-8?B?ck9qL1lUYWxyTmxrYlpuQVBEbVJ5QU5PVU4xWVNGZUtvOTU0WmVyRFBuVzRQ?=
 =?utf-8?B?UzRXWFBPZGZ1SDdzU2kzekVjNEZGMFlnN0YySTJ6bCtFYVk1QWdFbjR3d1Ru?=
 =?utf-8?Q?bgS4gYk+t3W/p?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7c6af0-8f84-4ccf-6c0b-08d90ae05162
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:28:00.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5lOou+6rSS/OqsFm2qgfpikW1yyLwGVNDqSkXlT4cvDRAINm5SR5jnSrKY11irsiOiYlALLeDGlWN0gN49X2HqqdHHNQsfSBZQlbBBOqWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7552
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

