Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6C3A192C
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFIPWb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 11:22:31 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:62436
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232678AbhFIPWa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Jun 2021 11:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1/O3H//QFbFuHkSjjoHlimuguaLh4dRAbE8HiluD7AInKVbfH1cuFJVN9IglXdtncwIyPkQANkjOTYtBYmT7X8OScGTER0MIJqia5Bn6N1YJlKcOq8P2vC8Q7S9C93mjtALgUdObzKfJaZ6zfsYiWQRY7dzJ5qixtIO4gkAX/RBdZfLiDbPk9VA/0Jy/fBQhz/LkxPBOFBoh5HsB6E1pa814tL/XLurPWV2nak6JMR5q9nahs1OZfAr9xUv6wnbEGeLw1hWqfSGI0JKi76mbhhxWvB6hjFXE7Tr+kBhT0mSZTFVh5UGEh+tqrm63o1NojO4j5BOahZrlydtRV70vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt5MyvW2n6OlLzUbcB4VOitJz+NraAmX6ySe9eJop+s=;
 b=fzcCy7UWNCS9sLXgPdxasSpkTGs9tGjW1NppOFmSk/iVFEZIJzpga2VHuH2lL98as1KM0dD8kDrei1P3ygeqeggUCV2Uf81aIepttKZH+1SKpWgaI7yY9A5GqGZ/G6T+E+ZUSi78JUZv/+kdqc/UcI1R24BbfWsrjHkwDcsanzoeiqzyRhTgTlIUQuq/Fo8ISsbYC5CE9vov4O5Kz7ofeiDs9DlL8a+y+Ru9MnyCkW0WwwVh7Vquq1iWfXVV4gQ62BvgoI0xFfXo1XsyWu62XcFBadbMQQE0trfsVsm8oRCoB8yerawh/ntvWS0VWAUVQEOivQNZgNhlV8Y1tMyKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt5MyvW2n6OlLzUbcB4VOitJz+NraAmX6ySe9eJop+s=;
 b=KFXaTtV6pyhpNWbOoa4y2Sj5cNBnKv+G3BKTNFJHztV61G/JK1yKKU+fY6S1DCC3VePThcyhXGb5r2tmBw/1SWJZFns0kKqZt3g1Ndy4205jvFxRb/WsnFRvYQBuCxvy3g0ub3MT8dkvSeFtdKm1Nv/rxif7qGvcG9BVV+nXt4Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7726.eurprd06.prod.outlook.com (2603:10a6:102:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 15:20:32 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:20:32 +0000
Date:   Wed, 9 Jun 2021 17:20:13 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: dma: add schema for altera-msgdma
Message-ID: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: AM0PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::17) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by AM0PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:208:3e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 15:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70021a8-98f7-460a-3212-08d92b5a1f5f
X-MS-TrafficTypeDiagnostic: PAXPR06MB7726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7726FE1ABCEB506C8E48E34E8F369@PAXPR06MB7726.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRpfmN5TjY9DtewS2Bqcmqz9JXNEfEYRwMXUxb3/Kr3D0+FXpIgwwxtUbGAVgefds2QNqvef1yoIO4V9+u8p7p9LNSlzHUB9Z9l+KhJ3wI9NzOvHkg5sQwY6/GzRu3iRUJBsukGojeorp5NIIpUZf8AzZz9BGHk38pJJzLGII4dVAHWfZsjVBXfoiZX3D5EN/ZP6/anBP/LO5j8xmV0whNna3BxFg/Nz5XfLADWb8E6fy1FSVErtDbplGzqfNalPT7wNOpk4Lbc17sgf7VxZnjyxNBp6VImTeCoR4OCRUhIhQkk4V0vF/hkGQy1W+GhfmqUIZJXA02sJKSwaCbQYpWMtckiDVVCKU2pedpPCgYqmtV9uHViR1E5QIqircZcMvUe2M3CgAMADlM8NhrHaywgNz/g4zKKaDvV1WZ2M1iRFQjrCHBXY7MOlYUrijBk1th7uijVLpfos950PAaS+F8aJv+65owu1yE9HsT1TDVpTkVLIKX+y8xPPFtsGHU/q+yLMctYdeXakvR7U14fcASGvNaG9Cqsf4WfS8k1vdb6s+OjmPFPlH4qDDQ5ZdTUWfwuzQXb7JrT++aWtRQpUh8U+xfn+38H2pc2cRpUvMVOmcX96P5y94ecDtHFP96ZJjImqxVRrB35ahffSvkzpcrqbLO6+xwrNlPjROA2SpQl4CuwKjy6H/FZDb69HlS6PeKYcWTJjlyj2fhdOOhpgSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(66556008)(66946007)(66476007)(8676002)(966005)(8936002)(86362001)(44832011)(8886007)(36756003)(55016002)(5660300002)(2616005)(2906002)(478600001)(186003)(16526019)(4326008)(83380400001)(110136005)(7696005)(316002)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aBfjFOYQW0bweuaLxAGHSF/j/Hw5P0lmE9lstMarWBZzaF9AObNdpn7Ssxxe?=
 =?us-ascii?Q?kgZ7J+fHwchToTGqde/sAjelMST7Oa7UAakEWNQrpsAfZbKb/j/OfGH7ZJKv?=
 =?us-ascii?Q?rjIQEygS34da1BpRsn5llf6uXwCWSZDK7Fr8dGbU/h+UhseKPcFEexFh1Qaz?=
 =?us-ascii?Q?eMV91aeOwuhma7flsZjvhp1sBwvP2j8qLJ0Aokof89pBQl/XdJbCvzWn+xxs?=
 =?us-ascii?Q?4M3bXuoBr/eOJBkF4n3vjbVOAPglIxjs5BpYujDoUcUCJnS0f0jbEhlnvqPd?=
 =?us-ascii?Q?ZwqQCXvoDIm1oPiyBI+sl3LN9pB0HT6hkptEMtXtqGn/NROP5Gy/8vEhDPN2?=
 =?us-ascii?Q?0pglLPJW3H+DF8iieu/c++hFKmfI3FwuZRN0BCRkqpG7e7e6mk0cQMFRcWl6?=
 =?us-ascii?Q?7CQlLKMGnJCylgpADiTSssEpAGmPov4xmLckEw8UMGrA6NzyVORRbw67rC7V?=
 =?us-ascii?Q?+4jw5PY3/uqqfWRkhPERiAdD2eqg0pTOzOwOzKuRunVGr8czUEBWHwh2hZag?=
 =?us-ascii?Q?6FUmJB6mgZBNvsEHIZNRYl8zquzplk/Thl+7888ShlaRo1dplVtHjiBAK2to?=
 =?us-ascii?Q?ih+89HVfqL862SPimvdx7oRGENocLLrI3/IvSIC1sPDoIn6/VTTMYtAyBxcW?=
 =?us-ascii?Q?wrwrzHYhgF91YPAs9FhZqK27YUoW3mG4tO6LXii6/NbA4/sF+FTwUe5xTqwr?=
 =?us-ascii?Q?qbesNfMiFnBnoWsv9MbRYh908KH7Y2ESX0k7EHIek2ccqF16CZqQQ3GJOQur?=
 =?us-ascii?Q?4Myfwje+WHXc1gkwyD3Kl213Pvm5gimdYrK9q7BnriSkHgvThP75Kr+gr+jH?=
 =?us-ascii?Q?Yuu/OlDai4P6civiJe6j0ONjcuskeNtyVKieQTywYGgsubRe2FjbFL7JqEsC?=
 =?us-ascii?Q?MEfHHLDqkkIzz6AjKwi0CZEqo2vH8dvaFtL9VozY2RSIAmNMbY7X8nzstOa4?=
 =?us-ascii?Q?AA9Q2uFKvfMP7tzB5I1BDGsUcP2zLhTpEpUVmSUB0NjE9lfvCkdnSSuAVIr9?=
 =?us-ascii?Q?v2Mp2nFxJBwWbkPapZuaJ8HSnozyidH7u8gElydRjaptVbW9SSuFou6JMsWt?=
 =?us-ascii?Q?H/bK7xnlcQfJ7P/c7xHmoWMvr5qwt6VCxEaHb+zYvP6qMt0Upd/z1VeDyaaJ?=
 =?us-ascii?Q?0UdY8MYgizfAW4fd4Sl/pX/Kj3XNd+TmNSYC01CvMdCgOIYL6mSEnmIA8T27?=
 =?us-ascii?Q?GGNKxJd9VwAedBPSG/sONKS4YG0g9+C0f4G+99SU+0LyKJ7UJQ9b9vDj1HSc?=
 =?us-ascii?Q?5Dd5cgXQ47+7FYqKdiMu4zPppRuTTb/n719LrnSFgXRXaWSCI3MQ2Djh70cl?=
 =?us-ascii?Q?1DD/py8+dhE6sabLB8sv4QtD8CJ116V9RqCvcio3HquLtGu34yc4RhrAtRrs?=
 =?us-ascii?Q?JpyxNF9XAkBmCgN4NZKIdnpxHC04?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70021a8-98f7-460a-3212-08d92b5a1f5f
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:20:32.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbmkqtPiv7hpBC60QqrbAL9CWsIHyAweeAAkc8QTwOPhBuFkBQ6fqVECkYUwozo1DQCHgfxRgjaRucPw1xeLBmS6A7KRNZSszt2WJSXHNtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7726
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

add yaml schema for Altera mSGDMA bindings in devicetree.

Reviewed-by: Stefan Roese <sr@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>
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
    v6:
      add description for the unique dma cell (channel id must be 0)

 .../devicetree/bindings/dma/altr,msgdma.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
new file mode 100644
index 000000000000..a4f9fe23dcd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -0,0 +1,61 @@
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
+    description:
+      The cell identifies the channel id (must be 0)
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


--
Olivier Dautricourt

