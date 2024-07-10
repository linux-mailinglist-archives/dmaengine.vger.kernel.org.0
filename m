Return-Path: <dmaengine+bounces-2669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F492D493
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B842851D7
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08E194148;
	Wed, 10 Jul 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VQAcGjTz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DC19309E;
	Wed, 10 Jul 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623263; cv=fail; b=YT/UMQq/5hUpam2OmpzY8+9i14umHywyZH4gHo4P926xQX4NTqUt/PgbnXUcKLsRnXWnes72imbaXspfRhIMkIk5AYmdT4yenKI0bPpjaQVgMI4qsPNd4jm9mcYB3ywVluUELIO30HeKxBBsr2DmA02mWgvbmbd6pc3/Lqvda4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623263; c=relaxed/simple;
	bh=C3PzfaOQJGUFOBldgQemdmIO0c0/lTsPAt/D6aNCY6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BUsK7J9YOAvVdR3pU/Zqwv5g+mrOnhSTT9ur3cf4GbymUJ0JLHC8OOE2PoOtv/VPRnS3XODWsItJ8B4l520kGRxRxPeopYcMlwD8TePd0HoESirDd8VwXtRPOK8zf9JdbcoOf6GJR87dvbnxu+0HPkBVQ4Css+3/x2PNnWQSc38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VQAcGjTz; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSSeIk9e6x2k7a9AnFs9xV4Us/ktlieqzPD0DqXF2NqlYB3TgxieE356Eqd/ok8tmTYjSJvJZFOb4BEdr1Zrwx8EDKhTcYqy63Xys+g19qy1hfBb0Z5K38K3PuSlCVWAiy/v66OeAFuzVeI8hAnGaT2UHqHVzEe5Tkuh1aBc3PpeOrrJP2nTWXD6PBlOwF0Euqr5XGU6AboI4+MCZgx0n4TTRuST69dJd58xKWLy6Ycn9Ibj+XVUiWDhGd63Blr9yp+ipTEKKJBnlis9AE0pGoGBbfQCA6i3tGeId7YOOEw5ROZ6hwT/uCPmZzEo5FooHMV3loQJhganUp8/+gUm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XvLBkVMDyO8svN4ixXHHWA4op53EpgWq9OYyDb8YG8=;
 b=A8h5klK4vbLXqaZpiFz3Ujua4EGqYgVbzNpBGubXa3650zbZzzDC5kdpCNYM87ykCohUoGkxVzdNxvlizbZSIIIwmk41vo5z2XEsaCDFOsVDWSvRRaTZrXuJD/8nD/sb69yv67T/HDHQES1eu7f2Xb3BRWLPgMQWrOvGBRw5uJkg18AJoxbk9yAv/N3VbkgwhEQf9SqlhiW5HZy35baQjYMwXdGbSBuDORjZoK1NQSZeWr414+8E6hEqA7Rxmipj4Z36ZrUsB2AJHI7rz7Yuo7O3sIRDQU4dtECaMV6cT58jskTZK5xDhghRNUod4ImCdEJ2Z+xFfmDIfkRT/dQ61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XvLBkVMDyO8svN4ixXHHWA4op53EpgWq9OYyDb8YG8=;
 b=VQAcGjTzjqaxAnTtsM+fAXtTfJHt19D9TZZmtR281drRZKaY26HH/jDpFwza0ocCUS+51J+WDlGGqUO0dnSHzC/EhcgX8FHg9xhkgkUSrNBgIVrqyMN5FdvB03LtGoZklYxzO8w6NSMLvpemAbSbS5reFLUONra7o8u5b219btk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 14:54:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:54:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v4 1/1] dt-bindings: fsl-qdma: allow compatible string fallback to fsl,ls1021a-qdma
Date: Wed, 10 Jul 2024 10:54:00 -0400
Message-Id: <20240710145400.2257718-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2ec9cd-64b8-45f6-4971-08dca0f02bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Gty5nSoq9z2gc3CG2CjTbt5zp+jFBGnozExw+L4TAnBbyCuoib+USodqMVc?=
 =?us-ascii?Q?X+E9qn/U+0GfLSY6mCphdv/7X6WYFalKWlIp0LvrjRzUnnF1TKabW8scR1Au?=
 =?us-ascii?Q?vlE7C5uHROqFmCIyOGwc+NKORNwmYHoAYTZJaJ1h9OwKs9gDEAN36V4QFAOT?=
 =?us-ascii?Q?gqLt23hUA89zCxxE85/lFLRTvjbE5UsAexxLd+jxmN+rq8aH5vxh7DsEyxun?=
 =?us-ascii?Q?QTMWf6i++xZAcDADD7N1aQqltqVg8NY9SREFMTyjgM8Fdl1wGba68rLGrZLv?=
 =?us-ascii?Q?s0UMHODmRGiYAWcXXfirVi2fwLpjTsrCpezo/zc0xeUx2Pq86BG7umAhELKM?=
 =?us-ascii?Q?AGeBaCoJ/emfvXHf+px3ZyLhUxnsC0oxIl0k1h9fZ+sZcVKmT9kCs+4iEvih?=
 =?us-ascii?Q?NhDCrpFiU6L9V9GOTwACOWIMF/2BKsQSyEOSY9mGhBkKdN2pU7l6Y6V8aXKT?=
 =?us-ascii?Q?MelyOH/gIYhYxlaefbbL/kyKUHgqda0oyrvj2+5iMfF52x5QvqZf6md8tSRY?=
 =?us-ascii?Q?Pj4l2KjyPxvZ70lk/GSbSzoaemyqbUlB8FALRwu2EsCXeMmbhpqqvS4ggmxw?=
 =?us-ascii?Q?rfwCb5dcMmlInCu/gpxmYBYVPo0yDV3Qmh7zRp7jTpn5Y7XVQtLMXtVpfbjG?=
 =?us-ascii?Q?VB28px3ami4vt8VVfIdY90kHN7Utbt7TRVzVw7b/0TTOwUNWtHSA5lgVdcMj?=
 =?us-ascii?Q?3sSVj6nKFQKou7kCCus3sdVPZZXXnnRM9YPM6U3KFLEcyrCR9llUiSABL294?=
 =?us-ascii?Q?QKCedQ7oyVvbQHar4e8zYNzcrTkYfjAVGmV33P4sxr/UUk5qSJ84UWxAhDil?=
 =?us-ascii?Q?LfnBWmlFRze4i8ID1PwlGDezKSds5awIKjCKRqVIxMiKSyZPkge7bNCopojP?=
 =?us-ascii?Q?A2YolDOp/0HB1NpYzwga0flNNyZRYQM0Q+DRWSRDsrLpeXB5TBhmrODeqzAs?=
 =?us-ascii?Q?83+VBb+O9Ru+hIbfoVKx74TBvMWtZeghg9vgKCsdCRRNVVIp/jmdAQLQ65Sy?=
 =?us-ascii?Q?ss0qwVX01+INqWhqElsqZC71AKw5UoADr3Gi4ena2iuis6IYTDBZZcMxCNfx?=
 =?us-ascii?Q?EuqqwBdLO48RU8qaCLkH+fdF/LkcN+EgQx8cCXVVatauRARN5qvmACA+/3Yl?=
 =?us-ascii?Q?0dEYUWIwn4AkmhTIrjdz8+gkHe8sZKnuGzsy4DnFg/PeK7c99Bj1uJxFTznH?=
 =?us-ascii?Q?R/SSrRAgsHRw6rbuttt+Ed5HOxLbQb/EzFIe2ZMkbhPW4nwreZQSO4n7aaxb?=
 =?us-ascii?Q?4QkLsKSQUQKEc6bcEgM9NvY7nI0V10EBqFY9jcSjzLl6TXNztR+Ka4iBrw4l?=
 =?us-ascii?Q?jeT31htln44Tg2W6YuGvab+RBVBTHunm1bWfBH7uOexR1PyZgXCCjnO6hBv1?=
 =?us-ascii?Q?oMsguVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iws4WUZiGMM9Rxzy/bwKn8nLYnrscGzy8ZTDjrqwZcGZDebpTrznx8V/zuym?=
 =?us-ascii?Q?7JY+OwUue1iqBvQq0DMqfrQ5oNst7/F76YBv3uhyDr1e7vhnNqHSRiNjbVaV?=
 =?us-ascii?Q?Sfli1n29KclgmwgzPqqQH3XP5sBD14HLDhXbpCiOWVunFhbHk/+ovkoiGgRz?=
 =?us-ascii?Q?YCqBtI2QHorLEPMhOxzV49O6dtlX3FOfidFXdnRLRSSNLXQbJlWPoYq/HBN1?=
 =?us-ascii?Q?3VnI1EOYDU76ZkFk9XVUldPweyIORp+0L3MDtnziLskmXC5CgAslns+BP05e?=
 =?us-ascii?Q?BZd/kUzFlQ7rm48D4amLMeT1OuaL1FXEJ7cOOyazSxfcGG2T/D4fdOCI+A2V?=
 =?us-ascii?Q?G3FEXUmAEeSHR381KPEBTP0IrlZlWHKnNGWHE6ohWYYa3iqLY3zsNVtgrMpk?=
 =?us-ascii?Q?Dg46bNjnaPXQMS6GL7Z168JvpjqqAkW6RF2e2sidiIwfTtPbEmoyAOIMnUKI?=
 =?us-ascii?Q?DfqzjpHeL7aq2Z8RkvOyGxudzr0ZwAs7TeeKdP2sXuG4wD/mq7d490U4ZMNu?=
 =?us-ascii?Q?8uuJfrFsBYdsnwL8bzQ/FXX+g+YD2nRghqwH7c8swl8WAqvJqhmstGTYawP0?=
 =?us-ascii?Q?KvjhhHSziv6p6sNi4qEgXcsKs0AXFmWj+ssOhxWj+uXra0MyvJcDBiIWV1A5?=
 =?us-ascii?Q?4mmYewbQxCCHlI3pbTsrfiAkydR4IfQfefLDGmBFGa6bm9kI3FivN24i7zh2?=
 =?us-ascii?Q?JJYMDt0zZTicxCJd6KQFBHG8iZ8U8FR/ZL68YAYL69hkZT0QGVmq4vzOYHxv?=
 =?us-ascii?Q?MBuTfV2qkp48kyeYDEa/4WCQG0MpM5dZIGab6+4gXVloQs6UU2MCmQdStAW/?=
 =?us-ascii?Q?FHErThjpRpHLj8gN+awX3/rmRykAI6IUS40W3QfCNeMgwpZ/bPFtZIztoTT+?=
 =?us-ascii?Q?bJwdlNs4G7+UAAtcwlHAgkD/gSwJ0HLZo3RjSrO3TkwNFUARMHInlaocXpHj?=
 =?us-ascii?Q?1x9uktbeXGZe4a1kJ+IxpGNzHWj5O+qDCvyKlpNe8AOXxEhvolTCAgal6I9t?=
 =?us-ascii?Q?1jqRjsP585uptfne+Q2C7EeVsyqKSiCmh4cIAUQ7cJZipuU1WTf+Ot6RP+VQ?=
 =?us-ascii?Q?EFYUrHpkseHYIFBFxsCGW9+O6kwfU0fwd5MmjwDHIapr4EpqjPwotRB9ITRw?=
 =?us-ascii?Q?tUc7h8PzL7n+o2pIe7SH0irMzrz7wUEVB+re/hrHT/CBQddjGbCy3/xSfJhY?=
 =?us-ascii?Q?rQ1C3uz7GvonMfEanXUqgU6Zgopp0anNGAULeMMfl/yRjp3mNXSFFcdzxBSC?=
 =?us-ascii?Q?hYITJQsi7Sz0dhuKV0HixH3tkgUD4KUjFmxld/X6IRFLBxhJaayoILjsP0M/?=
 =?us-ascii?Q?nEdMyA5curs9mO89wU88jKCiuIzjU1eZKVVRMCY7ydiXVRHPT12ALgvIlfNV?=
 =?us-ascii?Q?I9PU54n/NONXaPhkYRucrtY8NPxLuHKyZEgz3u8O6n2aNx+GPu/53rhUruUD?=
 =?us-ascii?Q?JSfG/aXDPG5IXnId8dzWchJK324cFwIDGutOJE/2usI+xnNW2EfjsfKDUloq?=
 =?us-ascii?Q?0DtFbmiUoHbmtbRUCpeRdSj+Mx+Q3/uUvBoGeXApPSGMsNPx9GP1hyv8hV8C?=
 =?us-ascii?Q?FjLzsTTgRIScaaZmV/xFn3QCPYn0irfq0ken98HC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2ec9cd-64b8-45f6-4971-08dca0f02bce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:54:16.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeeSWWTHxkedUOJGSOdtHMCx1iEhVN/QlopZ8JUy57a8cUxFRc9fihL+SJpcS24uVQnUmNMdfFm7tsePioxq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329

The IP of QDMA ls1028/ls1043/ls1046/ is same as ls1021. So allow compatible
string fallback to fsl,ls1021a-qdma.

The difference is that ls1021a-qdma have 3 irqs, and other have 5 irqs.

Fix below CHECK_DTB warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: dma-controller@8380000: compatible: ['fsl,ls1046a-qdma', 'fsl,ls1021a-qdma'] is too long

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- rebase to dmaengine/next
- Add Kryzy's review tag
Change from v2 to v3
- previous patch missed a dependent change.
 https://lore.kernel.org/imx/20240701195717.1843041-1-Frank.Li@nxp.com/T/#u
- Combine depedent change to one patch.

Change from v1 to v2
- Change  maxItems: 5 to minItems: 5. because maxItems: 5 already restrict
at top

interrupts:
    minItems: 2
    maxItems: 5
---
---
 Documentation/devicetree/bindings/dma/fsl-qdma.yaml | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
index 1b9ebdbe528a1..9401b1f6300d4 100644
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -11,11 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1021a-qdma
-      - fsl,ls1028a-qdma
-      - fsl,ls1043a-qdma
-      - fsl,ls1046a-qdma
+    oneOf:
+      - const: fsl,ls1021a-qdma
+      - items:
+          - enum:
+              - fsl,ls1028a-qdma
+              - fsl,ls1043a-qdma
+              - fsl,ls1046a-qdma
+          - const: fsl,ls1021a-qdma
 
   reg:
     items:
-- 
2.34.1


