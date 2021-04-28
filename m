Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A415336D795
	for <lists+dmaengine@lfdr.de>; Wed, 28 Apr 2021 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhD1MpO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 08:45:14 -0400
Received: from mail-eopbgr120050.outbound.protection.outlook.com ([40.107.12.50]:60163
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237798AbhD1MpN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Apr 2021 08:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R99sEB60VzMKV30aB0qjmz9hnpc+Ary5lWkgZ2ML12mQL7fJ+IJjZDpvQ4JauRSbAzB6jn6S8StBSpUrvXumfiH5P+frn7mMkMibyGN7Sa55OSJLKze+JpOLm95fOWE4zBbw/xqS5hHQFtaKOe5x9uOrxgP1LN3ja5fMrnaRRAkYaKZLlYQIYCdmUMlL6504J8KvdrWc66odGFmvKeabDS+869jwsPlhG6lRx61LrZ2AYofTeCiNctLRCih0ZgBxd6I59C5o/cM/TGkbjH7AImpocbsznRu473zRkM8KAeJJilIMCZkDPe7OOIya6S0wtNb/MwzFjFZZ9OZfuakgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/zHtfvyIfGu8oMGr1lPKRGJHWg7Q2ZVlu3paLfK+kc=;
 b=chQkN5aveRpcfiwLZ8lxHrrCS3cELjpRh83I3VkSTo6w7sGfmlvyaJF+RYTplaAGNK3pLyt0J37G1XeNw6gPVuXtGprffrO9Lmvygh4wTvhlb4HBEMvrbYKuRem0w8I9MwVgdO9h2TmXafTHkeBOT3NCukWeH3OkJx+p3HEV4JsnLiJPKganArpRSVDZjBEfvE/mEB72SNq2hm80NmpY+Icyh9olPaAL8A6VWU6elVUoZkE3dPjf2QX+FF0FWbOkgzuTTgL9BCTKkY61FXisfSM9g8+WqJJn3ptIo/7Ciey2YesM1YApJFDcpgQiU8dg4MzRutB+PGxPPVZ8Y+cEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/zHtfvyIfGu8oMGr1lPKRGJHWg7Q2ZVlu3paLfK+kc=;
 b=VWzcy3PiymIdBVzjzvJyiFSepUuQFxR9YkVZ/heT8PSeSafMPfJSRH8XmY6M2nVzbOUDZuWwWsUYIkiGY2asrY27nkk74HMRFaFbX0e2vUxqQG5TQmRtbJQvRQiou3GpFF5crCq3JhSuNyzwOVossn2rPyenbPSAAFmEppQG26E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB4729.eurprd06.prod.outlook.com (2603:10a6:102:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 12:44:26 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 12:44:26 +0000
Date:   Wed, 28 Apr 2021 14:44:12 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YIlYnDBVn0fggMe3@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::21) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:102:b7::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 12:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c7c51b-1d83-44dd-a73e-08d90a435b20
X-MS-TrafficTypeDiagnostic: PR1PR06MB4729:
X-Microsoft-Antispam-PRVS: <PR1PR06MB472939C26B3B0ADF13FF638E8F409@PR1PR06MB4729.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB/gVTeRt6XZUoFLRHdrUX4kFDzsFzR602OcweJzM3o8Yoz875vy1v8lJLQLSPy+Y4EVqfKSRhhWhpsYBlDMsoozqmG4ILhZW51np3/lTpcvffnrz8qPNBQ95H+8o7+oQzDXTAn29tM67MjcE4Dv3f+iv+SHGLSLyz/cthAR2l8VkdtS3VortQ2Lr+/ZQHZ3Usjnp1xpMNmnbxpz5g/WKreX/OoRX+2Jwmnx0gz/Nv5cYawYwzqWMdtSr+UZ7LbnGniZTQGJ3WpJFliYbkBt15ny+UvMcV5KaezfVqeBtcmSxf6/uwcvau+6MVEhvBVNNpxLg7n97rqfCB7lweQMpotGlXZOozYT2GJpNkO4pnqMXmRa11U4uXivK9MfKlGPjUqjiHm1qDFW9aOoho3Pm6nqueHjORH+l40PA6K3rUBWFqsaKDaS/ZQ/xhLave0ljREF8Ji6fzmWrpHDK5VQTwUsoT10DtZIC72hWJFVKdgXUCy3iNBAlwLPziwiJMYHioiDaz1MWGZjbLVKZXsokDM4eTqF22ix/c8B9jgK0/oO8OKTdSXNTVhh1TseeFgaGG1elWMfhHt6g5Jp1ZVSbXChZch4vjY6kny4zqdn4Mrsp3EPHmpyihZanaoad+3igIjTH5iotCGRGyzY322uJru24YfZcljP5qE/cJzdZe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(5660300002)(966005)(478600001)(86362001)(38100700002)(66556008)(8676002)(6666004)(8936002)(7696005)(4326008)(16526019)(83380400001)(186003)(36756003)(44832011)(66476007)(66946007)(110136005)(8886007)(2616005)(55016002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QTRnbWx1c1QwU1RVSS91MFV5SVFVZWN0S2h4VVNlUENmMnhFTWFoUmc0ZkQx?=
 =?utf-8?B?KzFCU0MzYXQ3dTRvMkQ1QjRsU2gvUFUxeGRCUWdneE01R2ViMkNBRGFESEpU?=
 =?utf-8?B?QzFsOHpnTm1Ja2FtN29QWWVlbmg4SHNNNHg5RnlHWW1rWlZZdmRqeWpra3N0?=
 =?utf-8?B?RjVzUXNHY3FlbkVPcU5KNWQ3RCs3WUN6S29lcU1DNjFXbHVOU2FUeTNRNUF4?=
 =?utf-8?B?WWE4R3d2K29PZk5zeGZMMFJmdHdkZlJ1S25ESmFtSGpQUDBMRWNQRmJTWkhE?=
 =?utf-8?B?Qk94UTQ2bFNsUVVWMGxlZy82aUcvUWpLb0YwbUZnUnlkS2dKaHIyQS95N0c2?=
 =?utf-8?B?UGZ3YmZNQnFMVUxLM29FTVVlbTRzL04yOVYzbFVBTjBIb3VXSWMvYlJFS3ZP?=
 =?utf-8?B?QnlNRWJaaFArY0tmOGFyWEI2cEUySVNFRnpibTFNOFVCcVhYMC83cUE0a0JB?=
 =?utf-8?B?R0M4WmhsdWQxb1UwcVFTeHlyRWo4N3JFOVZnZWs2M3JtYThvY1l5K0RXSTE0?=
 =?utf-8?B?TU5lVEs4czVpVUp3cFcvZkhJT3ZXUUFLWnBZMVNEOG1rNXYrT1FVUEk3Wjlk?=
 =?utf-8?B?UnJQem0yZ01TbjNmWThLd2FLZzI4ZmNsWFVGS1dsZ25Rb0VCNUROSXA1Vkho?=
 =?utf-8?B?cjBHWFpiczA4UXZGRGtKODN6Y2VTOVk5M21NY1R1NU1jc2M2ZUpMOWVYeDBR?=
 =?utf-8?B?WUZDSCszQ3lZZ2lKWmtoaUZubmhvNEhsMWZXTDhWVUY5OUhTS3YwZkxvMXph?=
 =?utf-8?B?R1hhZXdnUm15b24zZGY2L3ZKZngzamZybllkQnYzUW5XWU9PNFJYOEwzRlpO?=
 =?utf-8?B?VElRT2VsSnNTRDlqZVNoSjRMSVQ1SEhPcjR2eVFEN2xoT0JRaHNPTDNWRWNo?=
 =?utf-8?B?NWNJUXY1WERaQWRzOTYwQ0FCVDZsZ2hzKzliTGdOdFNlbW91L0orLzhjVTB6?=
 =?utf-8?B?SW5IdHFCa2ZDSDB1b3pQb0k3Q3ZqMWI1SHJ3VzBYSGtGSUp1OEN5dmw0UEcw?=
 =?utf-8?B?cm05ZUUzTlZKVTNBbmovb1VWZVAwNnZzVWZMNk00Wjd3ZndNaHArNStwNndm?=
 =?utf-8?B?ZmhZUWJibWR1UW1Wakh4Zk5VZ0ExZ1ljTGlJRWdoV3I4L3VhYnZxSFp2Uisy?=
 =?utf-8?B?bHFhSWNyVXhwek8rR05sZEgxZU9qSmU3QU5BVS9EM3BtWm9PMEc3amtWREVI?=
 =?utf-8?B?eTQ1WStPTmpNOTd6THZPRXRlTzRxS0NjeHVJdWx6RllQQjZKaXIxdG1wc3hJ?=
 =?utf-8?B?UVBuYUcxQ3lnMm4yRlo2RjZBNmRpdmtNN2F1U3RnY2wyUmV1K3BpTFlyb1dN?=
 =?utf-8?B?S1oreGhRNjQ0Ym90bjRwRzV0bm9xbXlGOUptWG9rOU1xQmJRaDNWMWI1MEJF?=
 =?utf-8?B?Ym5TcmlDTXdUMzY5bXJ1Yk4ydkU3bTYwcDNGVnF1bWx2ZjBGSFZJU3NNN3NV?=
 =?utf-8?B?dDJ0ZFVyR1R2VWtwVWRRMkIrTUpCOXlGMEZaazhkWHNUSms1UzVEZnNQOTFq?=
 =?utf-8?B?Zmp0cHV0NFNEUElkTU5hZGV0OGw2eVoxNjFUVlNWOEpnUVB6MVZsYVZJMHBx?=
 =?utf-8?B?cXlWRlo1ME54NFFvcnhmb2w2cFB3TTd6TWtLS2R1NVVyZUZSdDFaNFlRY3pI?=
 =?utf-8?B?SmNsUTZVaTJvcHNyWlVBVS9UdWIrcEtNNnN4TFdhUEtoOHd2YjFYUjh5c0tH?=
 =?utf-8?B?TUY2b055T1FpS2ZLV0doZ2tIYnB4by9xcSsrNDIvUnJDY0NtRHA2THd4OFM1?=
 =?utf-8?B?aTU1N3crbStTMmwveWRmT205U1A2ZXgrdFVzMlJVaU5DKzY1NElpMGgvTkFn?=
 =?utf-8?B?M2RQMGJFUmtnWWhRblJUcXlkcXZLaGhPNmhtUWVOQ2NFL1BQbTg5b0RYOGto?=
 =?utf-8?Q?39nJuyZCxCkGE?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c7c51b-1d83-44dd-a73e-08d90a435b20
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 12:44:25.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAR1KW30pxoZamxSI+bubhCWmwG5xq8OsIB9511klIPfovJ09GDJHW70friKlFW1ulY8DtXGqIJ3Uxc04AaRw9Ogyx6iYuof7T3/PCJn7o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4729
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- add schema for Altera mSGDMA bindings in devicetree.
- add myself as 'Odd fixes' maintainer for this driver

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
new file mode 100644
index 000000000000..8189b4fb5944
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
+      The dma controller dicards the argument but one must be specified
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
+    msgdma_controller: dma-controller@0xff200b00 {
+        compatible = "altr,msgdma";
+        reg = <0xff200b00 0x04>, <0xff200c00 0x04>, <0xff200d00 0x04>;
+        reg-names = "csr", "desc", "resp";
+        interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 04e7de8c95be..b2f7158d811e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -782,6 +782,12 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c

+ALTERA MSGDMA IP CORE DRIVER
+M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+F:	drivers/dma/altera-msgdma.c
+
 ALTERA PIO DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
--
2.31.0.rc2

