Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1D3ABD23
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jun 2021 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFQTy4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Jun 2021 15:54:56 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:48448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231513AbhFQTy4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Jun 2021 15:54:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ELhySYS43DZGzhVOmTeoEXgT7GP72FnCItwAojF57V+gc7V8A/8I13iEGM7NKG3dIhZvcMavl6eBmiSnIJN77q3yeg6DSqoyQIWVfag0ki6GpXGZ6L1lA9kA2iwY+IGvLpJM/ckOaY8jc6d/bCyXueT7GevUoziUtipRt7APtD3qUIgX9/zGlLg+MhoD9LvaY1i2ACsAIgucK3zvmExG+BGhqPdnMZ/a5q9io3A6uqGHLHzxLjcPe2+7gBzpE3QeHZG5rFm0lb48wJP+lSvcSkiKoWfm8NKY3fUTNIILPVuRqE73/HiFcNbdBPJ9j66+oimvqIS+WkbvizrMZbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUrZ8/k/slv87enkgVUXLzo+h7IrxQp0cOi4b67Wixc=;
 b=PA8SrNOCd28BX8AofgkRriW229fnVt6i2r/l+JSyxFACLEb4mmaVkP6AlHFFuzjBijn1YYq6+FZoWGIIfXMfDVY2S7eX7DPVvBcGndskHMAVb75KjCHx4tRKj/j3gBth2uLISl1N2KjyvTbMr57PT3iHb7Fvl4WkIsAedde91JlZPBx6mgRLRNIwkbPUjwX0uJEfmxMWABGSloU6ichaGcUTHRxXLopzabJ9TFnAFFAeGJpjdUpmnZXCQ5OJOyIQaKslpUrwXO/w4LejW2+9xMcjQCKIjb8kaevrJeHp80Dzz6n/89rY8W8xihSPIidTXX67yoXYe1pcFeqsVdcpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUrZ8/k/slv87enkgVUXLzo+h7IrxQp0cOi4b67Wixc=;
 b=jcIgIGWLe07iYrhrAeK6g59dfdY5dOBHcQHut8FHNGk6NYhtI7/nFX101VJ0sDwQ7lh1fF4oqgTOPcFNunQgRx/oFqrya+9LPXKXqGJU9IgvUfmRdaS18cd8/We478OgDY4j9BkUsSEpKledLBpFQ6LXymSDg6lM4iT0Wks+h8U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7710.eurprd06.prod.outlook.com (2603:10a6:102:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 19:52:46 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Thu, 17 Jun 2021
 19:52:46 +0000
Date:   Thu, 17 Jun 2021 21:52:32 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: dma: altera-msgdma: make response port
 optional
Message-ID: <fb28146a23a182be9e5435c1d3e5cac36b372294.1623898678.git.olivier.dautricourt@orolia.com>
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623898678.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:188::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 19:52:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a39565-7860-4d16-e130-08d931c97a89
X-MS-TrafficTypeDiagnostic: PAXPR06MB7710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7710AAAA85E55FA7B526E1588F0E9@PAXPR06MB7710.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Vfa3tmxBgC3Z3Cqdfd2vNNzxVwVC2OxUcqgpoFqcgP/z+pc/3ChVT+Ktmgj2nEmx1aRwLmAQwCQ+KKC3jqGF86spzUGWxUBki0r1vyc11zPfCNb2Yks1MUfGJd2+70lFsrhb2EgIUhZrFZCiotxCr3f449u1j69ZbGFOKUwy8gNvsUW5doyiIASQ2jyrXbKJSLENlc335LuSNgCv22G6QbjdZH04AjVVNZWDpaivFpNwzzS4wpEMViYHonpVSqDiDh8TTsE88FGjJ6w8dJVy78U+dSK2QpqPWj3VTZiID1tPOwf3g72hYLHpX67AhTZomqJDSNtAAVezYbV/nYpT+Pm6mHXbYRxWC8dTxFKN3VS35cNCCOxPXplGpFfTc7TSVqyZ+CpDOcMnbh7VO/8WmscFv/xsl8aS3qXR5g7JTFsHXhaGMI5JtjNySfa/uI0Y1mD7I0286KkfzccnL+yueKx5fm+Xc5ubHPc7xWCAUUrdwkgwuP9aV9XsztceLX9q+0Rbr+Q6gzj+EAiyLuzJWm3b1GfWZOZxPA5759Ke3+HIckf/29l4D590qHVeQzjBMnZn6GTUP/gxYFqlwdDVK18oC7BwYiYFCO2cDO7v8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(83380400001)(8676002)(86362001)(8886007)(2616005)(478600001)(55016002)(36756003)(4744005)(38100700002)(186003)(4326008)(44832011)(16526019)(66476007)(66556008)(6666004)(66946007)(316002)(110136005)(5660300002)(8936002)(7696005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GS7NWlM/9wGk/+WyRJ3GBVOsaIh0MzS80b9ld2KQHxQc5geT18Ze6lUKpcyf?=
 =?us-ascii?Q?UKXApvIzjlXYtGgH6Yf7t8rBjocbFhqoywbhaOMd+WyMqKRE5EMiosj9kVuO?=
 =?us-ascii?Q?kCzcrZQj/70RppoktneYMSldDqrofsvLl4OJxZw4N5FSKH9oIWgPhF6G0nmY?=
 =?us-ascii?Q?7jIRTBKnZy+fesyamWSKj9LqsVg1VL1afuSfl4mKRPO5xLHXB4qKsqr6xCyr?=
 =?us-ascii?Q?6jTXuP2u4ZuheJlGmSdxPJzDtdnMa8gHenZBL2v4ZUrzh+43VTTpOq0nT0qG?=
 =?us-ascii?Q?+tdLff7uWv+sKZJZMTyRPf+8CtgmL1s2foBvkadedUqnMSqbOz1zJMDZUxXb?=
 =?us-ascii?Q?5LKFAay465daRCOOeFhCpaCYDKs+ovUPeVHTkzrcJy5W5dBAlzVSDfhaNyN9?=
 =?us-ascii?Q?EPiGGU0+ePZtPmCX/Zx0+hwOWH9CModyN1Omb60nCXu5u46uFiXUNuz7K31x?=
 =?us-ascii?Q?Iq5sCttEyB+AQPRZUBL5DVHZZIB3v1OhrKUIQX2NcWW3jWM+xXdO+hg5/Z2i?=
 =?us-ascii?Q?D9rJ1OIQxtEix8HM/n7xJXNDAsntXR09k3fw9W0t0/F+dyDOXMhhnEZQAGnt?=
 =?us-ascii?Q?4i3G9jE+b4dQU3WyPnYWZmdlRIcTJn9RVBzgkMn1OV25XFJhRTd3hhe/4N4H?=
 =?us-ascii?Q?+2fwB2Xef8pIqHyWyKWCCLiFgrZVxNzFtEeZE0rhUjypmqug+LZ+Z3HppOL2?=
 =?us-ascii?Q?kbBQw5ui0ihnLlOgmFkymn6ZjpBmOXa4q0W6EZG8G3/glQCb8E5aTys5Uetc?=
 =?us-ascii?Q?RYEshHZHnlMCfAKP/Yn57Hs0IqkIYYvEEweABaYa16ikeitjOzAUixcbkt1c?=
 =?us-ascii?Q?6m7dD84OsvXS7O1aPTVmhQZ1haBAaKMAd5o6mZwiJP9PALbwL8nXsna42NXY?=
 =?us-ascii?Q?DcvlQpB5QOXfV1vyjBsR+GlpzlADkRKRF0fbAPfhTfeZ/ZIhr9Yp0ddqwsqX?=
 =?us-ascii?Q?rtsH5ZyTYnZ6gGjAoxMFTfVMQm0Pbtjb/V1+qelpxJGyxDGcW0aUp0VeHWYg?=
 =?us-ascii?Q?ihc8q/T8RB/h1PaG8HQaRvl7NDXUlrq+pzae9RXyj+zscS3cR76fPpzhFqqO?=
 =?us-ascii?Q?08sUYfY4e7HsNA1Ay9dBRnRYL3vGIne/cY+XHwRoVLjb+camXoasUNJXNWhC?=
 =?us-ascii?Q?rBJkLc/qimDxn186ap5/QS5ft4b4JMQKk7FR+c+z2wTssZpS3kUm2wXZ+4cV?=
 =?us-ascii?Q?B1eplulHnVWfpH7z+0fqeAHcx58oi++Y5CP+UhBEZDsEWYmOM3fe9bjaWaXJ?=
 =?us-ascii?Q?sVozMW6Che7pIsQKfPZhDazSqp7oBQrNfWedR9YT0l1OLtc6bRFEm9Uq6Njq?=
 =?us-ascii?Q?LepgGIo/w32PkbkuyyM9h1dLvqQp+aGjHcBvwZNoeL3iRLqgDngcgAUOkCNi?=
 =?us-ascii?Q?ZhbLMIHyUUaIORX/L2A6ouSxAp4d?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a39565-7860-4d16-e130-08d931c97a89
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:52:46.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAFr03B7scWwiAStLdnWRMqyKTiCfCH1Ej4gmU8m3vDKpL6Y8fKLgwGMqJPRCzSHEY4fH/8l3+VC21tLwlobJv8U/tWMAh57TDGJM+H/7jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7710
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Response port is not required in some configuration of the IP core.

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
index a4f9fe23dcd9..b193ee2db4a7 100644
--- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
@@ -24,13 +24,15 @@ properties:
     items:
       - description: Control and Status Register Slave Port
       - description: Descriptor Slave Port
-      - description: Response Slave Port
+      - description: Response Slave Port (Optional)
+    minItems: 2

   reg-names:
     items:
       - const: csr
       - const: desc
       - const: resp
+    minItems: 2

   interrupts:
     maxItems: 1
--
2.31.0.rc2

