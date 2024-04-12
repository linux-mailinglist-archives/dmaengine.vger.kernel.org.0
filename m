Return-Path: <dmaengine+bounces-1827-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0C8A240A
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 04:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AF11C21FF4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 02:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD112E47;
	Fri, 12 Apr 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HXGILCvk"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32217BD6;
	Fri, 12 Apr 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890663; cv=fail; b=V+/NneaOXmmziup4zsjT7BaoIOLn93qNj9S7DfSkcsg/NaKDRJwu+9d7Ucv06XyPdnBmePhZ9jhOKSg/cWXnub+QPwSHUz+PusOyA3O3PvLPUdB784laSsV0cPHWkrQUs9+Qem6f+bwQAJSfXVpjwiUnHQLSgEXfT7LHM2DVBSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890663; c=relaxed/simple;
	bh=gqbRgdvhQyGZvrqwnp2MQdHowJE1ux3GuZVWqXA6tik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dfed6lecMB+qOeo2kNXzHF2cfsCYProJ3fwxdpMUzvvPR/zCqD/N135dJGJFhybt7dGtvQ7pTSu/oKriJ49owrQWIMvHwOEh9JIYghVrWuAMqnhshIW1+3cCdKCmwpxbQvp89LGdrO4c8KlgjAVW2lX2pprV1SSUUspyaE6inGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HXGILCvk; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzLWcdwEdJNHhwlPhVzWraHB2wII8cQ1TDeQ/5fQNuJNpTIv2loaOjG44vlFv9NkkYQpAGQVfyTIX42m3/dkW9CEz2rbX7A9gUmVwrokSrqDdUJeDi0E+jH2fC5pI5r88tvNgEGAlKg3HmEw6TOu6/LSvOb/ZL9FMMo+y2OTr819Ezy2NVgwKFxxDzEeTt2LEw7WV5OG5CvLLL7hqNxNsMwOaW+MCBi7/5dt/0JURFY9y42RbXrR6uoWdTTm7u2wafDFf/CPsDT6euUhWuZVY1SRcogvDLinbgTtS7x+rB9MI5I2DxoO0IRx34mDzZZVIt3la1prRpTfcapnKgiQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsppEi0deHrcid2d/QjFhAIcwNbRnc0FEtKYxHxa0JA=;
 b=EDMQUJ9fNleE2AyZTrp+7m/eLNMHzSqS9t90h/Q2QYxWaewiLgSSp4TeLNLBtrkX8sZbQnt8P9yXXvIDEdp9o/KIF0Rc7z5GxQZBJ6FW38W0/jIkgsAfvF283g+PWxtJaAO3XW+ogmMsN6KHyV0AC8bmS2s44E/V8eA8A8m4xLwy/LeFSv2ZU6KDw28gT2ZYJv20jO59neoeJ71remzhcGxb/JXeeD5BSqVh77ITJQa4Ox8tXi240BM3mNDBqSFJ7eJcsX8S3OOKSxmH/foyNjmdwmzminckbpAz4yrEJm8C7tubfSr5c6LjX4nyEHSy1l1D9/BXWrRa1a/OLX9t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsppEi0deHrcid2d/QjFhAIcwNbRnc0FEtKYxHxa0JA=;
 b=HXGILCvk3oY2Z9K3xtRtAx+90ErvHhR8CxxGWT0Vd3zBMZD305oYzNNaCBObYQplt8yVdG+bAIYjCoqb1pR75p2cym6lJzMaVL3CiSEdYaXB/paa0/pv+9EpqnXc60T6Oc3precmOjBYonWttHugzPShOEEeEqClhpqEhb1VvTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 12 Apr
 2024 02:57:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 02:57:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dma: dt-bindings: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Fri, 12 Apr 2024 11:04:36 +0800
Message-Id: <20240412030436.2976233-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240412030436.2976233-1-joy.zou@nxp.com>
References: <20240412030436.2976233-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccb3a5d-272a-4b6f-5cbc-08dc5a9c5092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AlxXADmF6JrX9vb6apqVc/kkVAFagwjcDn6MqKv7TCIsrFJQThwGDkTDinSyhm6agXQ0GJ2zQgVveDCE6GearPDLKURYd+Cln3+QSEu6j6dbTuVMu5QRLdF0gZ5LyT5fZH5z/L/uFOjBkRFzxgRkdNoQXcFVxwGyg+NNf9w4Ah0t0HxfnU788tgMcut+jHpzN5ut4WFwZhsZiFIUWmQ0XkoexV9/TsynbxtUJ2a0f3sdo0pGhxY7lXhI75kersna1GF2ZpvQ0wDleLM0J7nDsbBRcZeXscKlyz0iZRa+t6kgT9du/1pwRlGsq60KPm4sLNRgWuTl4ZyfNbm9kP6MjMacFKEXjCKZ7kl9kpYjsJypmfRy7dM9J2qGm7nXvxyuRHQRQ1sKbbvt9hF0po2GJepVgZRbJ1M5y+KkUxyF+YWBjQ4apRgkYX8+0cjis8rQFmhwZ7QqU82AB2KBnQBAo74l4HwdAmvQQgglynlHndR/mwF9myFs/9fK/kdhSCf6FafpM2APY9JBG40IerqGf415raUo5vCZ5klv4AHs6poZ9pZHmcZEIk60rH4L89U2CZiIvapKuAo7Y/N2nVI3t3y4V+iNjgXE5usVltoGiBzvPlEsfZ1aZQaKz0e4kVG9mZWRAw0Puj7LaNueugNc32a6sKLMMcuJ0fSxxuxYLdq4qtKwPo38KtRQMQHj8KJWlyxLeRNB+nOcyfJC1WSo8pdpy/nP7uI0kBb1KTYSt9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/7SEHhdo45FdSKmalB9NQ2ZPG2Kbme/75cpTXVWYYx6GMnG4ErDst0jK9rs?=
 =?us-ascii?Q?J7MAwB3uYfYT8W7icICLIT57vVGj6CLybYSY+pktNlNrTJJu6NPCRio6NAGs?=
 =?us-ascii?Q?jGrdav9egFJ6nxXMQS4gWcbWbFyCtWtKAjCqIR7NjQZZ0R1ZuEOBG6T0ptc/?=
 =?us-ascii?Q?5z6tbLd9w1vxrniuKpAUzC4mVfrAj2946DnlsfmINEvfOsqXErxL0yg2TNSo?=
 =?us-ascii?Q?eZ8I7LzHZvG/etm8UDHwaeZIOy/1vkmhPOd6hCFI/lPzAB9z0wykPjPeyEYm?=
 =?us-ascii?Q?ocMnIB9UtRX1GbWm0BH6SN164aBsrw2aDndpgxcF5imFvL2S0TBeRWZZZDgb?=
 =?us-ascii?Q?tyDg26pKqcAJIbMR9tHkHtJ3lilEIfgo9c6rDyqI/v1dok9w3mxLsT14o5/U?=
 =?us-ascii?Q?al1gv19a1+wmO/mzqNjjyQs4FDa1V9GuuL07wzZaWnhtNk3MZfuKD+jJ0pQe?=
 =?us-ascii?Q?gKc4crt0OhmrOTeNYC7V7+RIYam2aFbzG9Law6zM0x5ZkIPoacjSTnhZSxSw?=
 =?us-ascii?Q?nVTIxBv7cp1E8Io+mF+3SIOoBBwCTI6qZhjfXL48v+lG/tKQve8B2zGMbIf8?=
 =?us-ascii?Q?s/831eYWlJxTIba+Vvo2mpMeIqsmQlSAmGonK6mVjFuOWBXihtV304fILnUD?=
 =?us-ascii?Q?JdUpTmM7q0YMDRfGcJqbf+8yqWcAXPFHugp3mqcn1FrUiwcren2b8G41a0uU?=
 =?us-ascii?Q?5dV9wx/ZUBbV5j1q5CfWtiFxuexsojMSfrhN0BmOHEOExsQT/I+uBgYoMUVe?=
 =?us-ascii?Q?GibCBZJb3E5ik4i1RuLoZqOdsJofBuF+SJ6xBlxgNDPgyGRoi5oFrfCsQJNC?=
 =?us-ascii?Q?RIhz7lpSdUgiR6kkyPPLATssyt+PYmifmuutC6SmkMY1ZxZXvKIBka8OzLI1?=
 =?us-ascii?Q?OnsXNdKX6dj/KPiKY6FBAuiQN/Kxdvimn8BcAi32MaBzaq8RqDGn4F8Ns1SW?=
 =?us-ascii?Q?KeLCzawS3BNRwhtjAsaytPLEhbeBgGKZNnw+OiFhdECGFLd5AuKCYG+X2ghQ?=
 =?us-ascii?Q?J1l/sv9VpJA8XA4GqTicbhGWpLx/nLPAtt+d7JLgYthR13ZqiFXGJ+o+uEjg?=
 =?us-ascii?Q?8X2SJIiZXNtMKndY044v5UxS8zJkDIFCzng+fGkvPkYS/P9Tbd3bbTagGUz3?=
 =?us-ascii?Q?e8ZDeCabNqhYZ+a3rx7aq801LWFCyruO2elVbEeGzZxx9uwyDq7cy4ysIRsB?=
 =?us-ascii?Q?8kPAeWcwnQDT/vDgMVz9587In2mwkhJqkL1wIHOOoU/jS5Srl33t2f9UJTsj?=
 =?us-ascii?Q?ecluPn1/UKP3OiTk4IKWS4MkDDycvQ2P0qyF603WdrDOZeTx1r0Kx1hBOE51?=
 =?us-ascii?Q?GxVuaPqKe4ufOLpNDgfY2HGBCmImFIYMYBShB5qYG4oa1dv+JBV70jAV6hoI?=
 =?us-ascii?Q?14L/LLMuX1t0sCxx6Zwow06R57hkyrYcYZeU74gO4v3j28TyMwVJC/pk/sg3?=
 =?us-ascii?Q?zvLbVt+lejru0KkJWVdZjxNh6R69wUQpy5E3YQ/gqEZ5fL1H4ESZ+zTKjA1y?=
 =?us-ascii?Q?YXbMoJu8CyCEB4GCB3YRfm1CZXDXhPMeMtH2nUvqqqzwQTXlPNCUEIij48ZQ?=
 =?us-ascii?Q?W14q96I5z9j7NfEnYHMh5eIsJAbMQONf4u+4OK5M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb3a5d-272a-4b6f-5cbc-08dc5a9c5092
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 02:57:39.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6jbfoX9HmC+StylIJUWMMR4/vrnLr5io06SrLlyAq1ekkWE/l1JBoXoMKVsH9ay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
The compatible string "fsl,imx8qm-adma" is unused. So remove the
workaround safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v3:
1. modify the commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..cf97ea86a7a2 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,7 +21,6 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
-          - fsl,imx8qm-adma
           - fsl,imx8qm-edma
           - fsl,imx8ulp-edma
           - fsl,imx93-edma3
@@ -92,7 +91,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8qm-adma
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
-- 
2.37.1


