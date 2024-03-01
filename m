Return-Path: <dmaengine+bounces-1219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D995586EB5A
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6528F2817C9
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABA58AAB;
	Fri,  1 Mar 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3PEYOr7"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A757322;
	Fri,  1 Mar 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329558; cv=fail; b=hpU/qH5FGywnUouhfbJvFDbZw/U9AA4hlT3fzRxcMyYemKvwss4aI3FY7JeECvnGoUqAafjQaiQJ4Hu6J5O+ewSc+2knI9EOSbUNhpub0DKb/Mt1uYZUbopW9yI1wiyl/VCzH9rvFY9AppuJPrhgWdK9+3LJfBwGgJXJakX1QVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329558; c=relaxed/simple;
	bh=9EgtrPrxGLs2HMh8bIhlgb2McwbviHT24n46A0XbOcc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EmtrZ6MDurpexSwZYBHmYK2LtvcCaJWcVmTxX3ZzDFXoSWsk6Stlh3h6W4LpQlxIJdJ0Rh83nro3PFFderr0PyynDT/hn2NtnCTLctL1UbCDKQJLZS9SUcPDnK8h42Yfrrb4LH9OicHL4JO2jXlj2Xics+9veJKG895vKmJcaX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l3PEYOr7; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqZxld3nF0UhawYn+pS/cEi+Dq3U9JTV3YV2woPLrO03zoncmZkByZ7gXWivsGluzp7RbErK97vraf499jL2+vSQ/rILgn2fKdwBjLsT5ljqUKDuoC9piilB4PG3MQO7mJfB91FtZjMOJDoiWoTj1YSJroQMAVvXTOXNAgD8BTqFOBJ+kq09wIWGJpXNv3G/itJZaJzF5I0Huh7jCMUTY0N0X44lRjdgbzzq+rZWgjf+PmPeXEDYC4IEOFlFoxlK8ZuCWK+Mg/t09aJG6/7OfRtbyrkQzUdCvcX30mJid1fGY9FMdZIDFWx4BlDlR2A/hpZn1B5UfjDWcOZCnxTMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0rmUiI3M2k33tiHD+U99zQ7w/wTje3oSyYWUXSRa2c=;
 b=WYUoF19dpKwGLzaDvMSrZ9WHham42TLn9vPemZhajX1RWH4/06pMpBJs4Lq2J4zg/EN2QFek+NEiNpctNGYqYGJdVw4HnANTe0uXQ2EgTHrDjRVh0j8T70fiZEuS/9Nod8mZJ6H7NiGYXh/oVPmjwfxrELvgma9SNSTbMYmALpO+ZhLG7L2iJ7cM2kIfNZlGKgsQ+VTqfr5LjmfUITs5xrkkgh5fs/64f1iQDbowcOmEmXr5/VGJ2EXddEUlkVvcvABrHO0d3vGerjbH4P3d1VqP6CtiE4nXFU6bKpFYTHk6c0J0limjs/Kx/15h+1FPLlpfrDBQ2/wLGwekgNTfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rmUiI3M2k33tiHD+U99zQ7w/wTje3oSyYWUXSRa2c=;
 b=l3PEYOr7bXxCmNqLCgIfWX/E+TrzVjlRsOhPMIRPpYY6jeI19JBfTOKPQN6D3zuR1O9hxpShffQRdxaSxIZLA5muGDSF20m2pb8DF+F9uSih3FlTfct4Da428OFre/ZjVnUuqqDecq4sz1xyhGHcJL2LhzcIv/siQEmoBmEDaG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 21:45:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 21:45:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v2 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
Date: Fri,  1 Mar 2024 16:45:35 -0500
Message-Id: <20240301214536.958869-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 480e968d-eed5-48b6-e64d-08dc3a38f7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g89f5dqj/VCJsBpoAJo5iz3jvBHVcA5SGIEWryjIYcPpIk9k9DV8OCsol4i64/RKQA9QI3a9KEURWKGlH5vwAEb/EIKfQ5Lnbc5EiJBL8boT/ynzoFdh9pZyf+0wiyN3qGTOSv7j4tQkRFqgU3k3Z/r1/PCJr4LLzzvESXsxdD+mLUz6hP85XM+bthnGK5nMSmOLHbkSmGtAbv3e4bz9XPXrNwZw333GivYUtd/aXvOznMS62cTHopETriQCFqVRs4KCxZLp2tgSBE844zP4l8PQShJPAWKFnUb1I1Fgtghv3dy/IzCAcW6Aoh7fyTTLB0E5aHj1MocmLMFc/lYbqqRQClCTrkiSuM4Z6/oCIMhlUjcLm/VL9SvU3jlxI5NvJ9XjH7DbEHnPJR5meXMT7++Rpl7k5CF0e3qOECE6q0sfPq/ubQfvQ9FWp0JDB78njmfr8mDm/tx6KDQe06KnlOpGxlbTJy5nfoRIBRVyjGc+/SmIM8VWi8r1ZyXsxczNS9JKbBjqV47M0aLJ4XQqYY/eMDY0qrZJExfBT0f+NCmWAyJsoXXk6CcJ4ukAWExYetRZ2igW9GqVDCJcfN8g5phxWNndTDSvt/37nBV1sjPYjkfbIdtMG1I0S355CseZrr6fIXirltmQJJ+x+cRSu81FRAPzt7g1/gzddKAes2fJXiVeoiOGvU+Xu7taelD8TBFrbEUK4KP7FHT+7Zba2nOurIgb8ULIoUiHXUId24s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uayJ9wYbuKXBCK/QV7QUIoi9sYC+jRLaz+H/lOjxozSHmaJHBuOR/8c16dkx?=
 =?us-ascii?Q?kyhtKvZ5m8wzySWcfhaGtOdb+ce5KfbUOxnRTK4S/3JTBGiU7F4dB1BASarE?=
 =?us-ascii?Q?LLI4HaF2qyMZQgCQoXHsUYmE9kPwBjMsUrKm9IdEJIenOsu+yOd8STnCi6YN?=
 =?us-ascii?Q?qQBdaDcWiJgnyp6nG3spS+HkrOvhmSZBmhpp466w93N5TPg4ocKyom8Ie5em?=
 =?us-ascii?Q?OYYnDjIeaUOk4H9YnixVqWIbUn/8YsJUo7U6Jka1/poqgwBxBFXYD6UeLHxg?=
 =?us-ascii?Q?Tio1kJB9vMsauidqYNVVIzjisHOzS1G6yk6BQ05xUzyEVCGrIseIzhPPz43u?=
 =?us-ascii?Q?Hpiur/TQJGKTzbJlh3izeX1gU0gUp6CN6cVW3iYUbU7GRK3DP2+xKmkD53gT?=
 =?us-ascii?Q?/59yJehJvn097XI4tkAC8mjyBUZ50Sl25+nYvBfg0VHJMfmCohWm+yOdpEI4?=
 =?us-ascii?Q?BMqVzrk3TWbiFAUWdTgoVbBNM5BmDgt8LWL7mGqCRJVOQCr1ODkCY5fVTjmQ?=
 =?us-ascii?Q?UaZsVRFLo8Nz0A2lPnMgAouBC4gaaIw+CsxrSBIi+Z3qU6koZEA5jxwp2Fey?=
 =?us-ascii?Q?k8THZl0/QAQKKKWBBxhL/aOfjb7Pq/VkBBCzvP3hNjBti53I7yo7fLV16nfG?=
 =?us-ascii?Q?SF+dL3EA9Wd/5+p5yje7NNiAKOWA8d2CEmwXd8bzFmB2qzm/X1K0mhP976E0?=
 =?us-ascii?Q?R+b85diBU5QshH/iwqa2tDnASAgavQeAvlTHbBXxOzyxHuzJ/k66AeZMLt3U?=
 =?us-ascii?Q?R3bfglZCjKYOqfNwe+3hjuztNzLN0i/LLGmGZEFCbxjaldvz4g6w3mqaGsbJ?=
 =?us-ascii?Q?1kUkdWinSMbr87tfSdKxV1yhCMnWcTp/BBsIw1yijpFRBLqUjwh5LopGiKAS?=
 =?us-ascii?Q?DfDo8edv9ULWUHNxjLWP5gt9meK0Q8mhuhHP/STUSHgy5G8s3g1rYwvDunCB?=
 =?us-ascii?Q?opcsiIcRfR4Iw6Qi+4SrkEsf28Ut22i9Rmp9IMnJFlfWpOrhptL3DbO4Im9H?=
 =?us-ascii?Q?8vvWeKB+v35jnjkGf+4RmlmztAEhROeNTHcIXOLaFE2LrT9CIlwLz0eMfAJW?=
 =?us-ascii?Q?Mm/hEAoA0UYyhkQWixmzkRZS8SblXxQ4G6zKUd61ZMrMDYy0aAcsJqAI8/YT?=
 =?us-ascii?Q?aUSnD2PY4IW2Wz4Iok9tkS/Vb/Uh6oZy1LOpguWDL4eT508+InbPSFh90FWp?=
 =?us-ascii?Q?roW/H2k3GaqHUsCEmlr+/7TQem0mlAbsibSCRTxf3VhH4XHpFbigMDR43a0E?=
 =?us-ascii?Q?0+C5a6hY1bIYBlrhIDK3sp24jwN3R/xxrIHE8Y+6jnqsto8Ddd7EClei9klm?=
 =?us-ascii?Q?rBI3eHt6GTLzbKYNQqEHiWv/NilrY+lbrxDqM69QOp3/LI6WbN1Bj9B0uk+A?=
 =?us-ascii?Q?Xs9VNtnrNYt+qKS40hXC3Bwh0CL6q/vJgAvF5JZwAxT1dcHxbMni8lnEtsMb?=
 =?us-ascii?Q?rKptj0fKh1S0tDjNeER2hohjjAQ3c81su59VUcdSPAJccQVKOBk54Lp6C5nw?=
 =?us-ascii?Q?GpzIlq+ph2rsWU9CVx/LTpMtC+XoVWC/bp0rv4nWjUIYW8NWOwltAoI75DqT?=
 =?us-ascii?Q?BMztKr51GhoWbHxxgRQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480e968d-eed5-48b6-e64d-08dc3a38f7a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:45:53.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7Egz+mx4AiQtP2sOrayTHZ4O1WXV/smJpFtxBjUG07n74O9Vk9Ok2cU0K9S7y7o+7q0yuqGn4mSX0dU1TdlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911

fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
required and add 'if' block for other compatible string to keep the same
restrictions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - add Krzysztof's ACK.

 .../devicetree/bindings/dma/fsl,edma.yaml        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index aa51d278cb67b..cf0aa8e6b9ec3 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -70,7 +70,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
   - dma-channels
 
 allOf:
@@ -151,6 +150,21 @@ allOf:
         dma-channels:
           const: 32
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,vf610-edma
+              - fsl,imx7ulp-edma
+              - fsl,imx93-edma3
+              - fsl,imx93-edma4
+              - fsl,imx95-edma5
+              - fsl,ls1028a-edma
+    then:
+      required:
+        - clocks
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


