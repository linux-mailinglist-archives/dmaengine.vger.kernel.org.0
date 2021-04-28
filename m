Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2089B36E246
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhD1Xun (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 19:50:43 -0400
Received: from mail-eopbgr90058.outbound.protection.outlook.com ([40.107.9.58]:36512
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhD1Xun (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Apr 2021 19:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpilTOQQowdIpE6EUhgo2tGPTGrzZ9LL/WfLIZGWP1remLzV7oBSyJPD3p9r4GGhMG1bwUV8li/0avZS3apaMbA7FWBpbMqA666UvHPA1ewBGAUvgD9J/CMWVvld8ef/wOQdfx8xCoCCRSDLqTcKmhSWNqaBMN9kq0EC1a3SUUS3MBN2mDybPLMjr4tCoMCLCUyeDNgv9ZEwUyQ6d+FkQF1mMnQK+9llMrjTnZLAW9J8xEPoBsU9Qtp9AdrrA4qDviXEv05H0wmbVVvbKkldv+2TCypPK69pSd0UBBLD7bnJk8zsAoqGu8ZUMQToYk60dpEtASJ6JJ5vo97vnsDcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZnklvnwpaI3nFp2krmCnLkKM71g7yBIbRETWJT929g=;
 b=f+1PJrWljsgDMZfv/UOriIA5+Vsi5JA/t+Mic2fl+Iw4fHcWOpXKAu9gyJ85wbK+0iPTWpjy4pG0Q9+DeD9wf5k8viQ/QyQkSFwFZGQ8ls6h3vXiZxCiPwIP4IJCBeyxyzIqXzgz15hOWRSP2fD09mmX5LvhBW/2MDFLEoueh7OfXgGWL+O/91dNWz8NZvgPsSSVazNyh9CwPtw7sFwQNIh7Utzf0yYwioQ6upgdiV0t9bGaGhNyaNMN6Pw9axtnleweiEY8QbeQmXxqIRloFZuv4khNcdS0gL4wCpYQwBhE9nGCTYOpS3oqejJ4DDBivVd2TF/11m9p9K1VBbuVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZnklvnwpaI3nFp2krmCnLkKM71g7yBIbRETWJT929g=;
 b=cGkInqTsyJ0ZJGYdKvRaqn/P1DNwDMzIs2mOzUAqn2hgwGMz5ge3hyy9Gc/72T/GIK5qH0gEwCXOE/7ef/NrWLPd9KhiduSuiyPb/RLHxyMVRpZ9fuu/IIuf7Ui30GffFoo/J/JwqbtFvMzzEjy6CXw+o1sod9s8NEiyLyi0sGE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB6073.eurprd06.prod.outlook.com (2603:10a6:102:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 23:49:54 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 23:49:54 +0000
Date:   Thu, 29 Apr 2021 01:49:39 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YIn0kzqO9iSwrHuJ@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR0P264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::35) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR0P264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 23:49:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669170b9-bba0-42a4-ff01-08d90aa05219
X-MS-TrafficTypeDiagnostic: PR1PR06MB6073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB6073BE33500ACDBD9D81CFAA8F409@PR1PR06MB6073.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PdIMh4AZ8y1jMC7heHnq5ELlLnwVrHaNwhGB/9Oa1BzKEwfFga/Hs1X0G75L81lnEGO47MFQz8BkijLqFWNx8vuEjXXUg6rFSwMzLk+nz7qvAdOQv9eRZk/tzf0ukassIW1ocyGgkQffOPc0vmp48hPmyl7bROil5h+ItJc4CMTQyzl0Keej+rwLvRZvol2R8GhVlmI0iHwdZpPotO3O3zKALOgVSjtAOOxMw9ktoefJKCOLNRRLYKahbmh5xPVtgXwTlNPJkZx8ZFS1adKatZ22tspptiMFMjz20EjqDHUNQ13OXmy1yLgEw+O8OSbFNagsRgCxbOYPaIaHPQIlR1jhnHjuX6bK5h8YDvJkuMAw94ZInL3XWnVah9J5CEdpv7Jnvg30HuhWoj0n6MnhPCY3niSTT1jNYS4triisAT0M20aj6bcNOwHCnIhcRuPI+Pe9XPqKQIhjLVT1s2wU0qiBVVpYCvsJ7gTdPJIhkdLFPJABRgx2xo2tivFTodCXppbHnwZHhejm+NoGCJe7NDTi1tkbcpYj9Q8/cRsU2GF2XL0d+dzdjqIHsoeUD5bq7AkUDx+Ii9xITTooosgsN9W9guB4XfUF4EAmsSAezX8nAU6MzVZj3F37CUnTkkDCK6W2vSBSL15GREeaR38WdOdYCCI03f5MZN30SA4fvW3VfHkntZHJJ5jscWs/bDc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39830400003)(376002)(55016002)(8936002)(2616005)(2906002)(83380400001)(66946007)(110136005)(8886007)(5660300002)(478600001)(966005)(36756003)(8676002)(6666004)(16526019)(186003)(316002)(38100700002)(44832011)(86362001)(66476007)(66556008)(4326008)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z043R0I1US93VVNhTjN4U1BPU2N3VXJBcDhQNjNQNzYyS21KZUdkazBLNXl6?=
 =?utf-8?B?RHhBZVRUN2V0NjBZcEF4bzdSSG1HLzBhdmVRREZSWEFEZ1Qza1VkL3hSVmc4?=
 =?utf-8?B?QWlYVXdMNjdRMDIxdEh2Q1ZramUzdmV3N1FXK3d5VHFXcHRDTTVoZURiakpW?=
 =?utf-8?B?TUhydlVHMitrNFoxNmg1RzcrUGJQM3NkUHhzeVRJY25aaUVjZUszOENvK0xT?=
 =?utf-8?B?QWxvTGNueFJUOEptR3ZZOElmQVpxaG15OFk3NFJydnBaZXNodlhITVkvR2Yx?=
 =?utf-8?B?SkUzUWRUV2ZsaFFQa0t2eXFyOXUycmROVjFXb1V0VDI0RVhSYXR0QUtrNm1I?=
 =?utf-8?B?Ly8yVkhNKytvUTBaNUw1cDdJRzdtQlRRUnJFUEVCbGZxbjZGVlYrYk5IQUlJ?=
 =?utf-8?B?WFZHUTZGUnlrS1pmYkU5RktHVUZVb3VmVkVqUEt1Wk00ZDA1REFCSUR4N2pJ?=
 =?utf-8?B?Umhkb0JPV1gxeWpIcFphL0o1emgzWmQxTkh0Y0l6TDR3Q1VGY2N5d2wyZk9X?=
 =?utf-8?B?TmlZSGNkdzVGWXJUVVphUHE2NDRxK0lodXJBbEFteWJnUjJad1duS05nUXZv?=
 =?utf-8?B?Wi9ESUo2bVk1VDI5YU5jVzhYWS9SN1ZLdUZIMjZBbFUxdkRoS3BoZEpYMGpH?=
 =?utf-8?B?RkQ3eUpoNHR6a1B5SEFUb2g3R3VUSGEvL2RTRzdIWXU4ZVo5STlaNGVZZWFB?=
 =?utf-8?B?Rzd6TkJ6eWJEZ2JybVYrWHFlelhBMittell5d285MU1VY1ZEN2RKYlBudXQv?=
 =?utf-8?B?bmFubDNNRlIrSFRSVktRKzBJbGZtWnN0OFMwT29pcmZiMWpqdmZBNE82Y01r?=
 =?utf-8?B?Wlp0Wm9jSERNcXh1WmtZZ01nWUpENCtrUmo0Q0owR2w3bTY1WTRRbThCMG5T?=
 =?utf-8?B?cUVGWDZEMnFZVUVOSVdrUG1PZWwzMTBqMTd5WDdUeEFNTVlwUERkZ0kwbm9p?=
 =?utf-8?B?eVNtOXRLTUhVNCtmS2FBaHl2T0p6WjlTY0Z1MUpsSHl1c0JuUHl1bDB3OFNo?=
 =?utf-8?B?c2xIWDhmeDZXaWxIZkNJMUZaUEs3NURyQzY2QmthYTJycis0NmJHTHAxcURM?=
 =?utf-8?B?YndFOTBJQ09VV3ZaZHdCZ3hNd2M4bzZPOGV0SEI5bEJ5dnhZS2hrS0E5T0pY?=
 =?utf-8?B?bGZLR241cWthZUxoYklmdjF5NmZ6K2FjVEQrK1ZOSVVBY1I5YVkyTWd1b1JZ?=
 =?utf-8?B?ajdaby9WdStud3RFYkhyMGs2OXdaS1ZjUnRRVS9hUGRqTDRqVmZuMkx6anRs?=
 =?utf-8?B?bUhBalkxcm16RXR2MWNDZ1dyUk1sdmZsVWR1ZlNmYzZJTnY2N1hTVDltcmRZ?=
 =?utf-8?B?Ri8zZmV4cmluVGlRdTYzSlRIL3ZWODZsZTdxTWx6b1I5cmgweFhiQmYyck14?=
 =?utf-8?B?bE5YQVZvcmhGSE52c2dhTEExYXM2andBamdKUE1uam1scVRLRFdveGlKNUZJ?=
 =?utf-8?B?Mzd0MkRRTUxQS0x4b0dKeGZJNFJhVi9RNEFLRHVkRjlxZHd4K2VFb1JzRSt5?=
 =?utf-8?B?YkJ4U2w0d29IWlFMSUEyeTF4WmljTkp2c3EwNEF1dFd4VHZVNE9ZL0k1bzAx?=
 =?utf-8?B?OUlhUGZCc0phVnpneHlsSHlCd2REWHptZUpLWEF6VXkyN0lYZk1LZzVQckRP?=
 =?utf-8?B?L3dqL0RqbEdKSGVWMm91Q2RtN1lSQ21zaW9uUkg2cjhTRUlBOGlWaFZUSHFR?=
 =?utf-8?B?YTB3bE9yRjRTeTRYZkNVYlpYY2JMUGt0cTNheG0rajdNMjZNYzJJb01INjJF?=
 =?utf-8?B?OTdkNE13eUswazRWT1lreTBCWVU0K0lDamNQc1FyNFF4S2MrT3VMZkRHRW1P?=
 =?utf-8?B?ZG9rMDhlMllPMzBncUdQQmwxNkFlYUFLT2l4VXJZVmYwNDJEekoxQzV0T0Rz?=
 =?utf-8?Q?UNGXsHJluGDME?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669170b9-bba0-42a4-ff01-08d90aa05219
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 23:49:53.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuGqfo8NYNuqJvptld5v7Req86Psooo0yJQjjsG0m85kMxZd4r2wuaq0Arp92Fj5APOqVj4p5+cocJloj95d1vrlGfyP+9xtJTM0HXYpm/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB6073
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- add schema for Altera mSGDMA bindings in devicetree.
- add myself as 'Odd fixes' maintainer for this driver

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    Change in v2:
     - fix reg size in dt example
     - fix dt_binding check warning
     - add list in MAINTAINERS entry

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
index 8f4a072f47ae..464af1b210b2 100644
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

