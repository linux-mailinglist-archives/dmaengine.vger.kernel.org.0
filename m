Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E33879D0
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349422AbhERNZZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 09:25:25 -0400
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:5326
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244483AbhERNZZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 May 2021 09:25:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaxKckMvWsKOfRg5YmGF7RMHIzkoY6yKdqGz6f0MEvO8tHyV7ovf0ByQo6QFgzno7GK/NrAZGao7X95F8OYGBS+rQgir7LaPsE86c39dz8arZ3t8BeVFWxPa5JyTtXugB3KMwFgGt3jilVSPPce23TzY8SWF2uLpQLsS+I3MbKRbMpZooIknrbF67gQ9vyj92NqATkXpX64NqJjaUPjikjLCUuU2BGvVvtbhvXFGUND+dlZ/VOqd5cE4au186G7piulFv7XhEJN+6ifKhWNp9UJZyAU7vXhTfaz9Lwh8beDCffuLzuklLksUDoRs/ofg0aD1zLRkK/6b5Uj7eFuXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7BYelvOQ806e0DHRNY7WWJwXkoPODiFtjJOCsq5bwM=;
 b=HB0CGv/lHNmgtHBYYA1DWoT+OoxEtKR4YUG5DaJg+qtNXM70YKT/TELWncFWumb1Ve3mJQFKIBoZPg/Gsgq6okCTPwC+RYDRNEi58L/RRRpCvCAvCqPA0WK+a1GNmHFmKtnLIh3hiw+KFCnWKdpiuHn9O5Y0zheUzHsU/qg0ugjkzDmJf9tIK+UVKUGS27G6+x3yrWv0tmtH/I3g5dQduvmgAwXppqZYESDN+YqGhsbhVBsj7tW+H3b+gTx3co6J7Iw0FNliE3AyuefKu4bsPt2zN3Zvv+kq4PB2d5d356ihShoax6N67Cm85Sa9Lgce6Jw7c5arDJdso2Av4+K30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7BYelvOQ806e0DHRNY7WWJwXkoPODiFtjJOCsq5bwM=;
 b=CGu53JOr23OChH2qpca8Owyq3d+KkGX96tU5PAqiz3naAYPg02Mz/oIDxsFMDSX9+zZKOUBZ4lID1PzGALRlzY55qdv03iM9uY3+YZ4/ENxjwVbohj7qhdoNO8tpDgD5NoUv8c19aHYvLUHCilYX+NroIv63q1okR9y+mLlUrv4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR3PR06MB6715.eurprd06.prod.outlook.com (2603:10a6:102:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 13:24:03 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 13:24:03 +0000
Date:   Tue, 18 May 2021 15:23:34 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: dma: add schema for altera-msgdma
Message-ID: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PAZP264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::19) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PAZP264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 13:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f167caf5-e30c-405c-cb1f-08d91a0034ac
X-MS-TrafficTypeDiagnostic: PR3PR06MB6715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR06MB67151CA35B13F9E848B18CFD8F2C9@PR3PR06MB6715.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uA2G+xFv5xYNSheC370chQBNVvo4R1EIQpE9+UXbbn7lGTdAPQDj7eL0MVKcmBe4s7QY3jRpMXDJSSjkwMFyXBJE8Ncr+LF22TIzL8tkaAtsOiBVutlL7gs0PaTW0pASfPWcWBR4s5PKIDRiuFPrtpEbnSNxtzVqc5vy7UgCqdfqD3dJE7wnTRLUQEIwBsrxDYjTYOcxNfxcIbzYdRuun0Qb5zvT06rNvdeH9k0Kz3OnJbfDHC9QHvooKnxVbm9PSc08eM8fCLQaswFWVVrugswpKovfg4BSh0FRSWy6fki+bCqxe/BCzx5uRCg27E2KnL9lJg/2IUvHbnulMAqbnDhQwpfuxLjE7VQrnwE0D88noe/pQGsHTS3cei6zedVKxQV1x0DaAgmx5OmRhyvL1kNhovG30myyudcsv/ngXXNmENkAi7HtbyEQ5MrsVZxT/lEpeKdQKuImnHcstAsSub68wQ/gLOvT5k6GTTXNiCUjwJqk54uygbWUo0hDKedIda+B6IE+uQAO0jIjWnggWU3FjuONhQyMyYhlljxpI55msKoVA7x/ZgH7aqqP1h5ac0ci9gH2D/oVO5xiAnPrUeMCyGpa3Fb8C1k6lQWIPKVot0Pe0ZEacYTNO1AU/8nmf0LLkCe3e2e1bkloae6Ri6l/vo/t3L2TW7fTA9G7NhvqhB75QUdeM77hKJnX+fKd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(366004)(376002)(396003)(83380400001)(6666004)(478600001)(966005)(66556008)(66476007)(36756003)(66946007)(2906002)(8886007)(7696005)(110136005)(2616005)(44832011)(4326008)(186003)(316002)(55016002)(8936002)(16526019)(86362001)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tv5N7lRp/NoutotE5PSWnzr9B5E1kQOnpNf5HeHgAuok1NlWIR1GfdERoJVk?=
 =?us-ascii?Q?Ab3zYlzKnRedOMlGcZEHatEPOKJqYx6M7Hbez10wUc7AGcczjD4b0Wb0/laN?=
 =?us-ascii?Q?5eV15Gj+uQbm+/dW5WomILcgsvobcm1oRI5j8toAdqnYy/znBroWi+ns2bTy?=
 =?us-ascii?Q?9qELa2LimJx5Zhs4/XzpRlnR6DpSrLVV0TZNfdB2iI68+SKOtRNBrMLT/OD4?=
 =?us-ascii?Q?ap8v9Z+X3Ts+K/oMHpZeTuI7dA5vRlwbK1ZvyXmqvD8vPicMiKjLFTpjnDE1?=
 =?us-ascii?Q?rBXbxtpi+G9QqgpdP2rZeqhkkNWIzLVieOHY4my37vcWkHKNH1jWxdSx8rvx?=
 =?us-ascii?Q?s1sczbIS69QZFUuN51PhXaO4it+9lhK5NF1Mb/GTrZCA5ZZ1Oi3cYLWEf3Ot?=
 =?us-ascii?Q?ZeohCYFWzLzNAOtsjQRVk6QxiuIADUMJO9FJ5ITlDV+kx2v5qmOy/WRHPWr+?=
 =?us-ascii?Q?2OYI004NGP1xA3HW71Dnc1Ato3N+p9yJP8QvCfRbpfAXQ5oNE2LBgm1/w8zl?=
 =?us-ascii?Q?7G93hVETjMYUDPlkAwRzaHwJz6t6rTkc5041kMUEQg08K5TH1IH56rAybCd9?=
 =?us-ascii?Q?Ze3+S0zHd1hBAgoKfuDosN02QAtEVAUcMYGZWnkIaVi1PDTgaO7AuVOPvln2?=
 =?us-ascii?Q?vnfsonJzWit5/DjevlTWHeXxl3kd6VWEEkERpqSQdVH93ZPNg/SbwnKC4DD7?=
 =?us-ascii?Q?4ShpVFSP9GISoxUo/pX7zX+6yv6B6fhnoHRX9OE4dhf/NqJMOVojBjo3NUyK?=
 =?us-ascii?Q?8GkimS600/IO15AdEx2WWypSwGpIx4dp9jkfcc4CzjFuAKH3RM7+MrojcjmU?=
 =?us-ascii?Q?XbCpqs7Q2EpdCy4uLYQq1J+9wH2Rvzo3X8uTmKQJ0dIfru42pzKR4GjZVBAn?=
 =?us-ascii?Q?DbLVi/zDLEw9+tX5WpfcvdrO0C55mXGaOqQ56UvswCjK3CztVbCHDaVyN0pn?=
 =?us-ascii?Q?FtkLPX6CSE84SaHFnRNQJIzeBKuXlurHjnLViOaZZj592hMJ8VjEqqtiFvZv?=
 =?us-ascii?Q?g8RNtxM+DF07T7W/RLjo275TXAqOfNAu6a0pyLr0DQoi8oerbXflO4gQUz0/?=
 =?us-ascii?Q?L0WAJSWVCrk5bUSfqVhhiZQd5Zx/jM+UTAzRzZl7m6/De6uak/5PpBjrIfov?=
 =?us-ascii?Q?SS0abtu5s0jvzNc6SuxH79WMX6MLpkU64WnCV4KIYjgyDrigtkdhF9SjEPH6?=
 =?us-ascii?Q?kwT0zUtunmggeN9ab2eYYUxr6eQPYPaJbohnEu8P7t+INgkNnfjj3SCiMxId?=
 =?us-ascii?Q?DP0GTb90GegXGWpdjR23m5Lb8SveDXGNkr/2/VHOBi2Z6ghNZwLzcu0MlF8J?=
 =?us-ascii?Q?mKwBuOtRdfeKNyw8wVtCCZAdt19J1UqIP9eduD5XqbfFoEnQiwRRrbVi+N/H?=
 =?us-ascii?Q?45m6oZ2/dUlWEs9mSoucaOrCf2Cs?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f167caf5-e30c-405c-cb1f-08d91a0034ac
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:24:03.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoIhzA/0NHM6jYFt+xhrzC8SFkKtDmNVYdpS9QSwH6mVBT0NyXgsrp79LaTttdEgVGeXHG/dupLQRWUwDA5FWA7QnUA4K83rIZ6myVD+s10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6715
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add yaml schema for Altera mSGDMA bindings in devicetree.

Reviewed-by: Stefan Roese <sr@denx.de>
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

    Changes from v4 to v5:
        as per Rob's comments:
            - change compatible field from 'altr,msgdma' to
              'altr,socfpga-msgdma' to indicate that it's compatible
               with altera socfpga family.
            - describe each region separately
            - remove maxItems/minItems for reg section.
        as per Vinod's comments:
            - separate MAINTAINERS editing in another commit
            - remove description for #dma-cells

 .../devicetree/bindings/dma/altr,msgdma.yaml  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
new file mode 100644
index 000000000000..ce51531e8736
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -0,0 +1,59 @@
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
+    const: altr,socfpga-msgdma
+
+  reg:
+    items:
+      - description: Control and Status Register Slave Port
+      - description: Descriptor Slave Port
+      - description: Response Slave Port
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
+        compatible = "altr,socfpga-msgdma";
+        reg = <0xff200b00 0x100>, <0xff200c00 0x100>, <0xff200d00 0x100>;
+        reg-names = "csr", "desc", "resp";
+        interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+    };
--
2.31.0.rc2

