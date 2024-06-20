Return-Path: <dmaengine+bounces-2431-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF690FB40
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 04:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CACE28364C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79191BF2A;
	Thu, 20 Jun 2024 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mdGvX7N8"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C11DFF8;
	Thu, 20 Jun 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849908; cv=fail; b=ZMfLyfJD92/iFMuSP99MBA5KfoufEbZEhuBGOetbjHchTwNjKO7KCEI/Av7G6ue/5sHiP+xbrqhoWSpmJl7imA30lAfa3kvIM/sa/r5Z3DGOFkItzHnNWpZGd/kaEb/KgSSrP9p9MvoNcnphMin1cTV5cqb1vQ0POL8L1205Vhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849908; c=relaxed/simple;
	bh=6oNmqmMMMVJ59ph++SL6ikSD7eiLS08KPLUkZYp6sLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bITxFJOroJnzm0V1jjL02YD6AG4a0iGcZ5x9wAttdflIuUIseGWKdrbtPUXOvqRS974LCOoleVu1bh0kDXH+RcinfKGQ45w0tGWofMGpZ7wKneFy7VCqvrUc7E79+P+viyQ8qvzdnX6x0zSt/K4Vdx4j8ulZI/mbhPKpV5C2Xek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mdGvX7N8; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7ndOcEY0wAgKkt60z0Q/xwQhKBZn6E6Nz0oIfyk7R7RtjzuHUVQyVqTWF8jIg6PldmSyPKWZp5NGwbkj61/tnWG/Th0ClAuOIKL3/fdb0xwhaMpWPIF/lrkJ/ffUiVBdmJ+oLB09/izdWDoejajsrLvkQxIggBeSIP88f6N25+sbJY+mFCfp+kTsl2kvkdaaf4eFsfLG5e6L61+OaxNIcxUFXWlccmKvCfHsvt14U+Ewb9HAKzlKyMyx6byH7wrVBpXLpgA8ExoRCBFXoS7QD4VV2QivyDImo+T2o/LGmugqCV+Q51QHzxYEoELLGicw+GeLGMwyF2slmnkvTAnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyQRJXSevNy3WeI+6fTnDKgsXlubSgAzB0jomW3+M/g=;
 b=hARW1E0JAioPHqoAIKIrU8G4NT1RrqD/2dWcVxlFfAdzyXn31vI4EcynknZAVn5bQEbLrZa3Kioikf3KYzmO5kausEFOXBWaNCOdAYlOaGfChChWbjKMiHSJHzDqguzyxdxvGQPy5kfMb+yw9C1BCgAGh3vZN0wLaM6LMSGaCakbeDb3r0KlaIQRm5x5kWmhXiuwY6523VOgpSgoKmTcjy9gacai25aQbTRdigGloXCAaKUwDrCnjXahJVJhanpr8JZ7xp/RU0jUjDgyrEPViTS7DkP7CLcdlHnwQzRhVs0I/92aLopidfvOVWWK0/FBF84QetqsRFfCpqX0tsYSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyQRJXSevNy3WeI+6fTnDKgsXlubSgAzB0jomW3+M/g=;
 b=mdGvX7N8eoQedObo4iamYDF2pkrfMh7TDq6xqNOogW9fn/HfFnAJBGD84wxAmn2PGQqJC9E9ztTejZxHKkM2sQikXmSjx4pEyUZ9h31YnxcGju6ljTXQXj08SxBMzU3TtY35li6vIGyv+H3Kpzn0gSauugq0KCF157z/JgVXabQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 02:18:23 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 02:18:23 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: imx93-11x11-evk: fix duplicated lpi2c3 labels
Date: Thu, 20 Jun 2024 10:26:36 +0800
Message-Id: <20240620022637.2494329-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240620022637.2494329-1-joy.zou@nxp.com>
References: <20240620022637.2494329-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f162a96-9397-4666-560d-08dc90cf42e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOHnk4zH3wx6KtWAf/Woi5Q18P8s3wCVvpHKaYYR5Q7L9LZdH3flEgTVf1FJ?=
 =?us-ascii?Q?vbl5l7j/i0Rj+MhTj7BWtmyEhuYozf3pDyT7VB0JqSX1MX4FVBKG4TsOsuGC?=
 =?us-ascii?Q?AEwjiCGl5GTDM7o5rvEV/sKXdoOLGCD4XABB8cfJbQ64mg88TmbD4QXSEO/U?=
 =?us-ascii?Q?bglR3Utzwd85WnmmkHGvjV8Ltts5o9hkuvBimbud87KkYUPnnVa0xZHui4Fu?=
 =?us-ascii?Q?lvvJbfGKWx6WezPIub+LGAgR0+eEGm910W94H7YQjombQKYKl1LbO/MBCtf5?=
 =?us-ascii?Q?qTwZXlF5weCDOMxXisw8kz0tz9LXAMhsHmqFTgXV46qdiAATeZodjc1r3nPd?=
 =?us-ascii?Q?UDn4bt4pv6EQEMZoaGV2AKtRuj0a59e/7bZnhf1Q+nVz8jnjQjmB9A2wx2VW?=
 =?us-ascii?Q?4KLgRRXiuRB0BLnxDeWee1MYOtDoHRwKb1j1Z5YSWXSBF/+k1BBK1JwjOAbN?=
 =?us-ascii?Q?t2MuilqIHUA7rf1bZexVx58Fs7NQPJcoZBhUC+e+1uDRLfZghT4XhNE8iSxE?=
 =?us-ascii?Q?8cU/vH/P7nOnCdcqxJPkJq5zgg1xso163IE7+uSOBAaHH5fZlJa8Wb84NOT1?=
 =?us-ascii?Q?dEFiCCJzs3ZKgWn7ZnmtCUmWQhPwyUo+O4R3nNCcEgZz2oPZO/TfbELedBfv?=
 =?us-ascii?Q?0qC+89zF4fnRHzA92dQcSL/nViE9bMjdCDMAloy7emnsSPKfOwLTFLW/EjOk?=
 =?us-ascii?Q?IyrmyyyBssk7ArbLP2OSrQqG4uTN26dIe3VlQ49dR+3ITbKy9/ME5599oVQ0?=
 =?us-ascii?Q?JRMdZyFpcUCD0AuST7/SzSpRoGYc69y2qPORjyoJOvMXvAJxd9ZPTQ0NG8Dm?=
 =?us-ascii?Q?40gKCdtRye4lJ7bY2QaL6CnZzxncNma4ekdIqT4uFR8K6S64hskv8oof3wcj?=
 =?us-ascii?Q?TfFqwyjXzpAFGiVv17CDRwBscsZQegJ+ahpUeS8KtSUtGAe1u2R4/2a2/UA/?=
 =?us-ascii?Q?AhlQKrQWDwFOXiJ+5pkBs86cFwY5kQKskRWQ5KaDCeHz91Zj2Z0AoSASyK/p?=
 =?us-ascii?Q?lXcEG7ukMINYtwmDeY25OVQSEfIGd7J+g5ppag++HKB5gzc5aLx/ySn8OAfH?=
 =?us-ascii?Q?WygM8N9Xmu1CLnJDnjtZEO3ejRgryLZvYzWN8o1KZ74woOL8DpZlOHv+5cJc?=
 =?us-ascii?Q?chgPRAAaTyXW/ixojOagmcfZz/9v80IPi10fcoZwa2Ti9dhquL4ILsMG1eG0?=
 =?us-ascii?Q?nl933wSKX1svslbnByiC1xft1YBemcCzW1HTihtCAVHJPCa3mK3ctyeYAVJe?=
 =?us-ascii?Q?XzNF/p9FbYNX4mj9GASyrT/ClgSjrNaxLEaHgAzfZxPovblu2B7ueCS5gbz4?=
 =?us-ascii?Q?drL/x88wNBPKB3AGfZSPC0H35nkW+QxNZ/ISkaw94sRNAV+gwnOAl7BSTCgI?=
 =?us-ascii?Q?J0mVujg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/u0Q6BXm3u0P1/F3A05Frm1rVQN1VEe4WlW18UOeV3ugswA1fNtOuCRjsmD?=
 =?us-ascii?Q?+E9Nj+DyzpHJ+UAZfSWQf6n73QcJNYZP7i6ttXzLqoxmj2UDk+xe7GkROqx9?=
 =?us-ascii?Q?FgbugOgLBS+e4hRBOyo64PprMaRfA/SdK8D5rbXqlA54WTaK7SxsyYCCYA5V?=
 =?us-ascii?Q?lc/VzRXlZllK4cgveN7i58KN28YMPyHUbC3bhCrfpemBq7Sg3GEZYnu47FRr?=
 =?us-ascii?Q?SUi+AEwS96RZt/Y5hWoFfDZE0yJpQ0EDNfUOqx1AH+O/k+fN62+oaC3RnkWu?=
 =?us-ascii?Q?hlQ9PMORYvj2WMpZ//zCvuVlFgT0J6tXaP9fdPcjnY9mvvm+kNu9GwoWzpv8?=
 =?us-ascii?Q?ZDLNAQydGUaLKma8GjCsFQv8Ru3vs3ZrK8fdEFm2Oy+GvQ9i2ajk9VqqwqWA?=
 =?us-ascii?Q?SmHsggsCVav1NJsBaom6+Y6Am4V432QuNcf6ZZuscmJlU+EXsWtMTF1CpHoZ?=
 =?us-ascii?Q?BflNv+mUHvPiVqOX+J1OapAuDT3TUm32SeuSVWDojBtqjOYqSRmDHvGbc5vr?=
 =?us-ascii?Q?NlFfWFDEfIaGY2ltje3V2fZZSB/ng8iV1he1WKi2Rtlh+CMxh6ZEk1ZnSnLy?=
 =?us-ascii?Q?IXCgCUQ5uJWSI+cvVKIpmZqBqS2Z9zFHsk3h1KltTHG1oSpvFj8kAI/jBW7z?=
 =?us-ascii?Q?PzGCjTPu3hDlrgZb3W9mjMHbFnaE5qdptdC1+RQrm02snmXtsVCRv13xQSQW?=
 =?us-ascii?Q?vbhdoqntarDMYhfOkYlBclkY7/U/zkXR2pJksQSHU9Z/Nf63R+X+rz2iaV00?=
 =?us-ascii?Q?MLy11wjaRFUAZr486j9rPuRWzBEX70fa/TjYMyBch5A6GD/9UebWdiPA/pGl?=
 =?us-ascii?Q?ZzzzCKNC3VvEpQHfRrTVJuUG0tAiEgvo03FTSOGZGo3E63+6468Y/gDZtCTn?=
 =?us-ascii?Q?JoSaQD+DQIKcq/8EuAlNusHKsYv7Qhq/7ZYJ6nTZPtyVUkjX7oRLJeff0tEf?=
 =?us-ascii?Q?8BAoiUaPUYUaX6Qb2GLg1pwxcXo1lLPY5panhwXQ54G8xBGXBoZaHBgUEHt+?=
 =?us-ascii?Q?MW0hBKGbvBXkbSZDqx/dGybj3SfYfiQTfgdWmVPmaAMOPCwOFZrJxVOKoH1x?=
 =?us-ascii?Q?jllXJ46XbbHD340mtfN2b6Pjf3n9LC+CwczriuaD70ATnBNCuPhuexL+9SZ6?=
 =?us-ascii?Q?SqTrhjcH6P3XhRG7wdFbUmViC8U/5p5KYp+gaV1SCVyqScthXixOMOEzpQys?=
 =?us-ascii?Q?2TalZfNCRXcwh8kH9K47KQrx0nOBgBFILtAo9kY0sSz7rwJhCmjinkEWO8qp?=
 =?us-ascii?Q?7ZbGot7aGmYcWvsJlPCfoxOWyqZ745swl4wkrmikFVCP/Gx7cRfbyYfD6mnE?=
 =?us-ascii?Q?PkJZMRfQxJ+Tz7Cr1NTIhkOZS970BLFPGNcjgGKPawUh/tUwGhlOK0HdHs46?=
 =?us-ascii?Q?GzTL4xRsqcyoUQjRarlh8BFfKbf/0VcmS+obPadzgYc8bVzsH0F2UC5KoRyu?=
 =?us-ascii?Q?po+jL5V+tbbuclNTv3unP1/Wp+5Nddsa7qbXhF+yi1T+qT9fHL7vLfL+qTBy?=
 =?us-ascii?Q?UasmAjjlRKfjvhmvfeUKuB220MWorty5XepYc9nblLs3lS+wRzM2D0JD/z/j?=
 =?us-ascii?Q?ICA6pxPdQIkpsItpiYvkSeT82lO4R0wwmsgKrmXo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f162a96-9397-4666-560d-08dc90cf42e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:18:23.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G62M2wHVXDDQpn8UZ8ToKyH6/X/S/p6N4BB/D6QpCwLJXyQ90sLTxKZmZnRrx71l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

Move node "rtc@53" to existed "&lpi2c3" and remove redundant
"&lpi2c3" label.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index bd98eff4d685..095bbcb3b3ee 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -178,6 +178,13 @@ typec2_dr_sw: endpoint {
 			};
 		};
 	};
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
 };
 
 &eqos {
@@ -401,20 +408,6 @@ ldo5: LDO5 {
 	};
 };
 
-&lpi2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	status = "okay";
-
-	pcf2131: rtc@53 {
-		compatible = "nxp,pcf2131";
-		reg = <0x53>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-	};
-};
-
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-- 
2.37.1


