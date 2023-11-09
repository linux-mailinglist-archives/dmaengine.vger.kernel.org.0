Return-Path: <dmaengine+bounces-63-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77F7E7387
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87A228145B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF86374EE;
	Thu,  9 Nov 2023 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEACC52d"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B8374FF;
	Thu,  9 Nov 2023 21:21:45 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519253C19;
	Thu,  9 Nov 2023 13:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoOC3rXq2h88gdwfQ38FRYcSkpFRu0qXQDJu1f9HsIbtgoGJdxYu+OFr/c3Uuc2XwHIMdCutNJx4dTMick9Z9A4o3iOcfAGEd71b2t8cD9UElq71rqviLYfH269IJiIW6TFBEiwao0vBvs2bGyfizlSdyeTRmzcItQ02WRoBj7hyJ3h3qy5acHAmiRAnKdZBbAIOA0XFZwu58t5DTjHr1si103lLpf0gY7Yo1Lg7ZbMijC6SBxpPD/d2VJWEo6L8jXO1J0a1D32fnDrGcBPQBlLI+R7ESDfJnt/Z1/qDjzLu2QFvP8EvYhO7GZQtkzZruOcDuwNcxdHMQZfkGB2w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJn9rPmEqPh8qns19uoLafsVSH2809OkuewFxQ1wgEY=;
 b=ZKhL9H/c+DjawhcYTksaNHhWIq2XsStkJxJMf1ejdYms59XvrYZUZzimW3HoYNIK/iM9kw9UcQ7XbF7jZ5wLEfkE5YFEI4+pquQPIeHhY3o43KL9TizNv9bWNbHLQhxqT8SJ7AfFqsHGL1GVxFBhhwVoGdwuvCXKIfVj625MgmOknG7brkVj7+0qy5ESi5tV0yG8nvNRxTfxr9M31PjHPzHPriS8Mzmhyt0+fFIuToGdMVTT41pnyeHP3KlIBnZ+qyJLKP8u92Y89+4JhLF1B2YYz8OVQYaTYFjcR7PGnIKXTXfN3lfFNab57lwJVYlGM89Mm6Pg4biGYfKod4QCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJn9rPmEqPh8qns19uoLafsVSH2809OkuewFxQ1wgEY=;
 b=VEACC52dLwrQuRsabdc6dAm4SArQ5PFpTUd9lJorH8NmEkyRVFJEF3tKfTabih0ad7DFRKTnhV88Y4PCyPIIvvdCLOy0QHNQcJjPJxZGUXEJYEyuSoY7e4UAAlIck3/vlMd3Am7WThueW+EzOHLIScGXiP5KFvb0pXOiyg4jT/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 21:21:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:21:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 3/4] dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
Date: Thu,  9 Nov 2023 16:20:58 -0500
Message-Id: <20231109212059.1894646-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109212059.1894646-1-Frank.Li@nxp.com>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: d88c6d73-756c-407a-4099-08dbe169de22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2jkdWpu2nVgmCB/xOrBNn2nD9+8MuFAIYRsTeV7XcvJU680x3q/rqqgyfrzySfMmbP4yTSDSWIgoeCLQ4LsGhRm3Qro07mzT59KmjZ94GJH8VAMmCto5eID0xZN9sRq6vS1930gH6nE8Jo2G+399kiBvZ+QoAfR0Ed7RA6qjm7AEixTjnM1YA4niNEzh08mR5+CwJpiiUTzMTyemke2ki+LgOBpMrtExCilTe1IHBCbBEhDmc22W6MhSNmxrkQKunS1jgLglqETK7NUzEDy++UCdipnABQOPy52GvEUXFO8LcyvkBLqg6VKv9Rt/dAMTXNUG6Ew4n9+wCfq6hCkfEsCkKCYuUNRG8zgyiZuJTqt0hZKjL7qXnBA7++IFrq9dpb7H5EwwoAuASrv+yfYfgDyDhduZlD4lS5HWtZk/RQEilXvcPBlEFjLhP3MU8YZqXdRGGs6SnIX47zkAXMHqeGsKJ3+O7jKz5vZKHqN2vTWlR44/4qCoerT2CncnonYfTzbStxY8KW5Mggfw2Vg1qgZUfdRtulTeJFHAjI+VoEc0bvRCxuGvqscK+k/TXgf/9wWeOC3Yz5p2dU49yaTvoFttFE04ptIxjLdmJ9QWo+XE+yy7Y7d5/3wxGDflWkiM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(37006003)(1076003)(6512007)(6486002)(52116002)(26005)(66946007)(6666004)(8676002)(8936002)(6506007)(4326008)(34206002)(2616005)(478600001)(5660300002)(4744005)(86362001)(38100700002)(41300700001)(2906002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qgM+2A5GApRkXmoEOkEo71oZpibbv1pH6ZG0Km19kf/3TgKySP6BrJPNASKo?=
 =?us-ascii?Q?4vLpjSWjbYYXTlRQQVJeqg/WNvhnhx4YGmNzt76GVaTtcL5mCUUQTwtmsGn+?=
 =?us-ascii?Q?wIDdaP6lg3j49Nk2O/3XxVOKZlGIlqPSyqhPzUw/q/4Mk27FVMK2mwsLNPvw?=
 =?us-ascii?Q?HGT0z0O8UtEwL/0LXq1EETvXaUSFkTxf7u+F6ZbJ2LT8qgqPBDcIx78CHVdm?=
 =?us-ascii?Q?XoG4ovxtvok5CsMbfD7rFMOI8+it6JeiLMnpZawonRa2AOdjYP0hVaUNeQIl?=
 =?us-ascii?Q?IikvkIfJOFjoyMLBC34f738+EnYN+eXDFv/P7P8x3P0jtf9AYONTEtIlPuVi?=
 =?us-ascii?Q?KX+SYfLpwHhWOgGWnGQ5++I3geimsmyAVhNMMAk8Ec8CTgVnyAHLnCiujiEB?=
 =?us-ascii?Q?5hMrQS0cdO3WZ7/U7PUVcOzkwl2M3KWGBsYN9+p2jxvR2bL3KKuyFr0mf2nO?=
 =?us-ascii?Q?Ztr83fwHHWD+fuX2c/qZlhB8CHkuXTa6V/UsuCv7rtt7+z5Ezxds5Ca/sCtr?=
 =?us-ascii?Q?XGs3Iiy+6yml2gjM6Cfoz/zijOydhyJzXHrMCV0cOLBP9r4lCMtjmnt5GRrH?=
 =?us-ascii?Q?qLQIWqKGJaeD0Mc/sKaqt9K0PPN0Bn/IKvag1u41hoGVB7G/oFdCR1amAs5q?=
 =?us-ascii?Q?12e4fi/xH+NdAZf24nUahJ8LWA+gjXnzyUibEVqmFkSyuVwybIjo5Sat76bS?=
 =?us-ascii?Q?FsgL4Mvc1XaGt9M0PsFF18RdrGokNKBQEoIl262ll3DY2X/yTMCuIUejTCbS?=
 =?us-ascii?Q?lCzJvRsmiK+M2PnD8HHzPU0A2ZH95bbw7BmcKqt6YBfGpBwR2ow0e7KmiwnC?=
 =?us-ascii?Q?0UCnCnCVbcnEWjF+SpLVsbbw9ZMP5xN2+1eWDa2urLPKY2h49SXMLZr3qY9B?=
 =?us-ascii?Q?AyvYCGRR9mB5Rqo8kp9g1qpcEPEChGAHbMVSDS0EOqwtpclOKFSqwjqCJpFs?=
 =?us-ascii?Q?72sNR0GNTA8udrCK2GSS1ZBZjBz73p6DG8E4/IVgyMg7vtJcrYOgRV97WSRP?=
 =?us-ascii?Q?Gh9OXyCSsY7wnZTjXy5qLWHnAlHjQLq4L7GnueIFRUo2cfYRKLRV/uc6RYws?=
 =?us-ascii?Q?bmr8tn5Bt5W72v1EUEzN0msPGTf1kJQv/YyFbpJyIdOPDzGyS6TImobCPQoL?=
 =?us-ascii?Q?PxaNZDc7qX4sziiwUM8BfEJ7czdCBmdaYmEsUPPgc+Q127JDa6W4YpUUz6Fq?=
 =?us-ascii?Q?mCTRNlcOEbNNe21p7JrSdRJeq1UrQ7VAX9bIT6y444PJzfCkieGcqPNDaFCF?=
 =?us-ascii?Q?ysCbXytxcgdT/7yfvJYuZoUgEq2NokLBspkG/7UV0mCiXIvLlnqsEtJ3z9Wj?=
 =?us-ascii?Q?hCjFp/WFwDc1iwBWZ0kTI4JwIUydm9rMQ4lRp1OmYu7jGUY0NNWbHdywSgaZ?=
 =?us-ascii?Q?Jstjd8EpDrgjYTh25w0FPC+FdpJI85K3FEDrC0yWfI7xl3gNOu1kv4xPeUgZ?=
 =?us-ascii?Q?QkYhTPBwOIbZRjqjHWxZ8OVX5xaIeCY4Jko81xiGpLh3FfA2HWIlJiFQPN8a?=
 =?us-ascii?Q?7kzFDCJGmEmAqmDmoTPK2MAXbcyHBLBHPZ/vYyqQcXhYAe4L/MPEloo39Nl9?=
 =?us-ascii?Q?bHJlcqhIb7DPf8zwCT2Akj3wMeEvRjI8BurQ2PNw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88c6d73-756c-407a-4099-08dbe169de22
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:21:42.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM36FdaENoulVV1O8qBKgRUaFb+Y1ziijVH9j+gUBnTKFSe6LtiPvPJDuuNiqmYgk72YBmOkSl6OBzjtPAf8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

Add the compatible string 'fsl,imx95-edma5' to support the i.MX95's eDMA,
which features 64-bit physical address support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 437db0c62339f..aa51d278cb67b 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -25,6 +25,7 @@ properties:
           - fsl,imx8qm-edma
           - fsl,imx93-edma3
           - fsl,imx93-edma4
+          - fsl,imx95-edma5
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
@@ -83,6 +84,7 @@ allOf:
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
+              - fsl,imx95-edma5
     then:
       properties:
         "#dma-cells":
-- 
2.34.1


