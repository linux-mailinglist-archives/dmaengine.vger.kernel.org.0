Return-Path: <dmaengine+bounces-2575-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3C91B205
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 00:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093041C213F0
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E81A256F;
	Thu, 27 Jun 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1vpCf+x"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A761A0B1B;
	Thu, 27 Jun 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526357; cv=fail; b=YHC82HfwyW6WHxIKS1VeD5W86LmhMo9Ac5jdB9CcOEzIwAK3Vahn6539PH3xEwAkqMsGn9DHtOhQsN7aG4AufugBtemHvafqRN+aq9llg0m8+lhgrcjK7dyP3jxezbm4Okb6PlDoJpg+5RswNra2u4L/8xM8r+zoU4x4/6oNNZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526357; c=relaxed/simple;
	bh=UXqEKmSJMUlj5L8ljYJ5AKLTAiugzRVcg68YnPoDyC0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NMjPBQ+GlWFacLSogbXOHKTsS2rXCSDmoPe+YDUpdY1aoPxql+HkpjdtA7hVS9MvMao/o9pntlVQpifYa6rPaB2ld0hOx0CWiVxW0PdJ/A3yEbZcg7T3jo2VajsIW/o+c9sFgH1n23zrUjkZdkbGtYU5MoN/277WCKo+9cmhCwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f1vpCf+x; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnwOWNYMEjQcalV96KjVNy5sXMThLDx/gzG6s44i6kQnvxh+GWzfoiujgd/fxP7Y/E4ptXtguSbjpMdUGltOPCyJBLwBtPZ3mhrnNLGLWPdANjwW3a1UBX8i1fA3MY0Nxmhltmi51ncW3FIoEaN++So6p6Z9k3Tlvl7fFyss4BfWc8FiFk5t70nmFlwG4KTn8dYj0Vu6QTkW9Mf4oeskMnzZbJnZgRiT5sw42j6fE/equB5ER4lwSmrg4alnpR19aF0h1ZB2jj5Q3aI+UQy99Smo0qoxk3yf8LePZnLF7X5cx7qlP+03+YW330W0lM0qcBimV6NdSkLfCz8YYSAAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5W0/bYK9MHZPlqJAlOg1tm5NWM+AbK5la/328tL8+k=;
 b=IU89vf7z1PuSTfed3nXQlRqIYAjdyDFvYn5VJijwBxrCJzPntx8eg0lD0JCYr+EzCXhaoG6ZdJpvIigwh52yaAs6Gb71GvovYzyOukviEAc0ZZAVEybxjxHynN4pVf/LRRhxeoSyNBZiJREC61EMnnkkaR0PeBTyBDA5llQJcGNK1LPfz2LU79BZyKZAIzb3odnECt/MqWwHSmcNIZSnmx+hSHKbfCJZ4KeesVcW/hFUXHoC4CZidFE7dvd4SNtEpBhhnbdTR9YxOOrhD8SOoiZlDCn/F9AwrF800Sm+btZaPNez4OBob1G+apIYEzwOqDyk6tndWaDIE0f2xGLJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5W0/bYK9MHZPlqJAlOg1tm5NWM+AbK5la/328tL8+k=;
 b=f1vpCf+xuR4C5WKC39p6HT2ftGP/uOb/REA1vrFcfgBukMU+ic+I+KKpWuSKq4GE9VWuNrhcIZYwoCeKOek+SR99LwzLkxUxBmCEex+5zX9nx5EBRB8C4KIZopT3bk/eQdmsaZfkUO1SI9x4KVNFziqZxxklsZtYSmzmSftyCmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:12:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:12:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: fsl-qdma: fix interrupts 'if' check logic
Date: Thu, 27 Jun 2024 18:12:16 -0400
Message-Id: <20240627221217.713633-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9832709c-e118-4a9e-47d7-08dc96f63c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/eTzYDFnjpUVHpqOGo7hmFa3l1FcmF4Gd9yjBQbrYgcmB7agJ48sr/bL80Jv?=
 =?us-ascii?Q?hicHE/EYo+ck+llmalG/hBHcgNED/XqXClcsCz4FUrK+7RyG/BII9MjMjUM1?=
 =?us-ascii?Q?eZhUIYZYIx1o8hrhruvp22rZ7ZQJG9qDmhRKpWWsCLlBK6tyNev5qNmPgk33?=
 =?us-ascii?Q?DLChN9tLEfxr3ThrGuEWEHX9XGmu6BtnfpL+xuVfOxgKfh02VmE17Ca2TJBh?=
 =?us-ascii?Q?rpWDgEguMdxgGkfK3JxBkBiVg8irSi+U3JlQBaH12N87DkliUANYg4UkHwF/?=
 =?us-ascii?Q?sVxs9dbUpF5PLo+VGIQr8byuiYddQExbWscMiavTxPN7yjNwDNTR6bQSPDja?=
 =?us-ascii?Q?JQNXgqDSHRQidZHk8WpFwTarc5Dcd2kXMJ6o3/8YN/Jr9jHy6UFTBTVXxJj9?=
 =?us-ascii?Q?gtk9wpYLAXeu1l//LIVlXCspsfodAEJh+0zkylD0eqGBkRTR1smKsITt6yZC?=
 =?us-ascii?Q?2Vm417SUwGUX/ZQr8FVBPTk0weoXKumVUw9wSxGyx1IlGXg7qwIf9hpj9FP0?=
 =?us-ascii?Q?BhOjh9B02fslV0GFRgScmH2ws+RSdSrQFrwolEngHKFuyoQ1Q7804XIWs4Zy?=
 =?us-ascii?Q?snqFYuA/pjro635yjwFtcd5MipFvpUCw0YzAa5mBhAoheQgrPEKmi4bV7Xeu?=
 =?us-ascii?Q?xLoLqkcH41SdOmOk8tAHNvrg3MnstcGXB9C9ZE88X+TOklLqtW3FgdG5VX8r?=
 =?us-ascii?Q?FN1EkrGEMgXoALKyaS94K3/YOjaDsXNGE8h82p08y0ryLwiXbvInKRgVpe3D?=
 =?us-ascii?Q?jrX0++2nA9A7uLonQqALqAi2YXJ6MsM3Tax8tQyjodPQkMFtoxOabMqGpC2Q?=
 =?us-ascii?Q?MWbe/X64PsvFUmFOoJgYvl3EX3YpN6SNSJzwMCIoHPkKubDmMSoL5AWCpB8n?=
 =?us-ascii?Q?a1mhf6tzOBUEb3FcvSf7fDkPCu7gDraSN4vqoDu6/2PCsIr1JF+yVLnEwa0K?=
 =?us-ascii?Q?2fyBpA1jsxk6FKHrqfHiQwUy+Ar8FHD48jg5Gbw5wzEXavyIXEjaIuO7n3fe?=
 =?us-ascii?Q?VfIbScbsMyKpFthQtgnGb1vGBbjO6xZ2UjRXenYfouYIjWK8O6stGgiYktPj?=
 =?us-ascii?Q?j0Kqt2FODIO/1ESiWEidLL2zbQbI2Am/ncSnvwK6a9C7X38d4CuaGGT1Y+8N?=
 =?us-ascii?Q?84QdyRQnHL7BS+1wPbbkwKL1fjYJ0cFOeu/3G7gpbBhlij+v1y0TulxlnRfW?=
 =?us-ascii?Q?uUUkp+DWP3fv5ifrm4S5Ti3tBHI4NC0XldoqlAo8qg5SrjEGSwkltHX6jk1c?=
 =?us-ascii?Q?WqlF/yiTV6zVD/Ibn57mTGAQJ5MvuHcQd/37vtT4963vvtxio44GfjvQGZGi?=
 =?us-ascii?Q?CG2jrIK/P1HrOUSCIRnZGkzJdtqg+WYBJKcq0CDMH4wQkk8ADJTqhGcCb9vO?=
 =?us-ascii?Q?rXlrWA3T+ULtgNAbgrNyp8DllO50LLuq9MUFGzijYh2+V7a2sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAbY/UxGVSMPhBkOGrTGItaruvovcH5k0gtGZI9ubgOYZ5Q0yJ8tuqgzc3hr?=
 =?us-ascii?Q?OkmGQmzIO+TIuj1q7W4fa7JRav0nplyi3jgdJjpFiwMqBR53XZpxbITESd85?=
 =?us-ascii?Q?sLD0eBdfJ89m8DXhjPpYWfDU9p/MdPdIbaEnGfg76HL9pUrmEo5rdJDZi5np?=
 =?us-ascii?Q?Vfo578DA/NY9Ru6WEUr3n4CukT2VIGAhthLQ1xGN5zI66gzldEu5QJogyaCo?=
 =?us-ascii?Q?FZApVxPR/8XZ9n8u55c/R1E35k1yEe+R1rk4PEm2JengsxAlpf6FSqlY7yHG?=
 =?us-ascii?Q?oMWgSK2yvehPyZr7Oc8wQKxCQgw2xK1IyTlrQzFrj3YpLldLvUOB2JBH0gIm?=
 =?us-ascii?Q?jBqdqEEzdllmo/RQUHVOEqdsapl6+lgGxPmUM6xy4rbydrrn++//k3ZwdGFN?=
 =?us-ascii?Q?dzI3MzuCZtvfNxtpWmuWrWmpVhi7wq+eTqHFoZgvHJeNesDPYK6HJfWM03d+?=
 =?us-ascii?Q?gMTXS4KP8FTWn5VTIv+uF9sul9KfpengVDBB1zAD6HEpTiml2gZ7T+tuUsZC?=
 =?us-ascii?Q?GbjnkVDz2jos6vx3AU1qMpvFGxH1zbQZiZkE4hRfzskbha91w8g8qMe/JdCQ?=
 =?us-ascii?Q?k2sZQUlEciuUv/vhjUH8NzHJBeNX61MlomI/D1M3vKAtD8yLegTtSJIfiUV5?=
 =?us-ascii?Q?CTuEZmSuNvm6RMH7Jf1lD1r2qB26PeEiNctzt4+vLyK3+307cUBrIqU7At2t?=
 =?us-ascii?Q?OL+U6Kn3ly0sRvzKP0OnZpZBGxo6Z0DABoIRM6kc1lt5PQhm6+KiZ3I3UGEt?=
 =?us-ascii?Q?/3wjNnvtv771Yc0IAfjIPt8FFbuXBqIg1amR9Xy8/9CwhFI/ECEopDwM4EVm?=
 =?us-ascii?Q?d6ohiqUyuhnKSSPXPNZq+PoaLH2sHIhiNmtf/3GHjHl29Bg19GlRZbZZVtTc?=
 =?us-ascii?Q?rjmmSZcTMOkROZqpQYvRuMyPGh65H4lpb7K+tsE9KyUYzyZ9EHNFNhmVE5kZ?=
 =?us-ascii?Q?rxyYxWZ3JQ32hZpcfN6RBf0XjiyCECoEMhjiZbmeqpPUS9sJbJivB7PJXoE2?=
 =?us-ascii?Q?+TxyjUomo5d/YrkeVFmYUMej+UXx8Bv4oW4LJfsE1pPZ4ifkSSZ3+MMv8CAV?=
 =?us-ascii?Q?XynKPmFqm++H0SWNK9yNSaCdFApwxJCvjT6TXWVAp6Ou4/icOpbI3bMIcvkN?=
 =?us-ascii?Q?A9fQAOpI7KTZfF2uthywl7+1LgInE9DWni2rcHpUQzz4VdO4xrI5z8f7C1B8?=
 =?us-ascii?Q?msGQh6LFlG5jTZhAq/xe9ie2rF0knMHLi2zUXFFiwJukuf38sxnGwF6tL8Q1?=
 =?us-ascii?Q?XimLn0DAkKsni5gDnQ6qD7sALfKPQHYCaC1SHLs0ipCWBgs77Y1jyeqiiiCD?=
 =?us-ascii?Q?/4SPV78rX1mV81PkYujD2+lMMtWXMQL4vtZCXetG4DBbzlE/QhHcNbG90k3d?=
 =?us-ascii?Q?vIWXAz/fFnPcQQY6AgbQFE81TLClx/FaiFp62r+bmxjZKTVks+XErUU9W/gp?=
 =?us-ascii?Q?bXX1WsR0AeJ9p+L+d4q2yr2l3xiQPxR99rrfCHL9nV9QybsQFdk2UXrZ0vjn?=
 =?us-ascii?Q?JDrN4jwepF7KOM4lN9q26gqzGMPlR2FyaGItb17FnGpXQLDx64rEtZSljML1?=
 =?us-ascii?Q?8PC21a3Zls3O1WE+Zh5KHL5NbfEh9YAqU6tF0a1/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9832709c-e118-4a9e-47d7-08dc96f63c12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:12:29.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro5HM0iKyeREd7LbViiH2XWeQq+tcDnczkrws9Xu2+vQI8ziSqU6My7BlDyiZnwlpDSNbej45FwkIHhCIwgqaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779

All compatible string include 'fsl,ls1021a-qdma'. Previous if check are
always true.

if:
  properties:
    compatible:
      contains:
       enum:
         - fsl,ls1021a-qdma

Change to check other compatible strings to get correct logic and fix
below CHECK_DTB warnings.

arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb:
dma-controller@8380000: interrupts: [[0, 43, 4], [0, 251, 4], [0, 252, 4], [0, 253, 4], [0, 254, 4]] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
index 25e410a149fce..48dcf1d1f25ce 100644
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -92,8 +92,16 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,ls1021a-qdma
+              - fsl,ls1028a-qdma
+              - fsl,ls1043a-qdma
+              - fsl,ls1046a-qdma
     then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+    else:
       properties:
         interrupts:
           maxItems: 3
-- 
2.34.1


