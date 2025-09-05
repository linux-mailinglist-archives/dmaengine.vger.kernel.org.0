Return-Path: <dmaengine+bounces-6397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF5B45ACF
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2387C522E
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D5374265;
	Fri,  5 Sep 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OH3CxHkS"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA63728A0;
	Fri,  5 Sep 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083508; cv=fail; b=YN+A/aKMS2Dsaj3JriTJOLLgkM0i98z0I43YI245CgNvEeEaxm0VAhaHaMibB51aiNLkD4es9Ua7c55z9J2lZoaCtOKgKsuZc96A8NLs5OYXIb0tffK1/gtlaa2CxW+SNcy2HiqedhmbCoCSaUU5cYSQ2ipQLrwbawV8YpLn+RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083508; c=relaxed/simple;
	bh=LPVAXR+IhpejfYVA7jcP4vowGBfcZuSs8m4S9NGerGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W26oXxfqurqaDJ9j3FeFA+6mKKWP1gl12+RKYh04Kx6QGfBINHsQjed3inXs8Jgx23kOsdbzZWWlNDtAn0SpzMB/RHS9Zn7BYTClRQyDUtoCAuF7YdSovwetcJ/plJ2IcH8oelPbPb2SOVdbyDdZZLW2AfOroZuWk3nkNRitXfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OH3CxHkS; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy2N9Q7guFPguCiJPOoocug2VCWtC9PfKKxBrurPlIkNzPXFvb9/emCBNt41MA5IH7v8DTG8vYQrP95AfI6oewElzbfQaMHtGpeimycJPOkvSuo7nHb/buZMUwVMaokScsdDWky2qw5/IZf3I1kk/NO+wUx1DxdOh8TC7MMOskNpwaKBDoDuOPm7vabeafLx0d9FZ2un7NN0PxhtjWQDxROjtGhkvUYEWltOVzNA9Q3roZkW1Ik+flwv5VgqWE1Y8aK/8+169W7/zck29YD5toNYHZjvtocvhGKq4/M/YjLUtuq5zewlavqhtJlu0BL/N33dQREzVzrGi0JETecKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c26Ct3Dny9tcvnroG4QK0MtfZvAmKWnidYRpFm+gLk4=;
 b=bY3CeEaEC8UccAcP96rK4Zs1CXMUHR3lGtFiN++Hox6cIn/BNQCCMdqJ8Q65adot5Ij2oHIR1u95uljkDLDCjTyA564pIcbihFs4VSK4WjHwPd3OoYkfa+2mi8GIaajmPWzsXtER8zzlymm07MapZt3xAonq/V7H7NErG4Gvaa9HgKipGqpno7yTWMzYaalu9Gso+Juu5xZi6Y1ZWmHLL8uc47MRkz9rhEeogW9yJDhPfF0tfBM/1LwMQS3L+q1h7ID4IMStVGUNAhvTylAIMVC0r/M9dZtCVUlf5fWfE/aYao2LYy3N0vKPucIo4mrKlg2DRfHNDiYyw3UmpCjSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c26Ct3Dny9tcvnroG4QK0MtfZvAmKWnidYRpFm+gLk4=;
 b=OH3CxHkS80KClhZqcfQycuqcEv/e2HWbjvny7fsS5ryJgRQ0KznAhnaYufgWHyL8tRGzFgEDfrNR5QaOs6pwDy6ZESbmj6IK6XQvhkB/mHPXtWKiHj1ZmzPDP1MJ4PhJxBZUQHuojxAKRj0G8p4yxOBfVXWhtnWR8JzM6nTEMhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB14067.jpnprd01.prod.outlook.com (2603:1096:604:364::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 14:45:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:45:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dmaengine: sh: rz-dmac: Use devm_pm_runtime_enable()
Date: Fri,  5 Sep 2025 16:44:17 +0200
Message-ID: <20250905144427.1840684-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB14067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f67d080-1ca5-488d-55f3-08ddec8aca7b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a29bcPHzfygI2u4LR9Rb4YkOYRG+b+usOSptzC+uVgZKnK/zNCgVw8e2ru/K?=
 =?us-ascii?Q?0SntisN838TzKaX7S3U0WDtiT/mEWGq2q0V7+56LDR1Ebd+MDwAbulpa9hU9?=
 =?us-ascii?Q?7vvKQO6fTg+iJcAArmtuAV4fgM6LchxxmFSgxy99KkcjDe8PguqPgE2JlTw5?=
 =?us-ascii?Q?D6nlBpHcKTSAB3qsESJxK6AfOWD7rvrlpYOVxTrYtYTtEAffMoPqF8kNXpWb?=
 =?us-ascii?Q?K4+Zs6+LgISuuk66JDzya1XcwcsFWatJ+LmI0/DZs/3CA2YWVdKXKGfEcF0E?=
 =?us-ascii?Q?a57CWH6VcJr/PxQU2Rb0sjmaiGHM9R75bIzdeWQyIseb7iNU662IaIBDHBMz?=
 =?us-ascii?Q?W6QeA/VUSiPu1x2dB94/0MYdBXBvZKDrXBaV47Q7sqALvWfhdI4R1xDG/NEi?=
 =?us-ascii?Q?Rp4S4hE5DyQuAtLMWCrVnoU3Rd2o7cb31Pl2wRDBcUAQJQleBwuzDODc5ruQ?=
 =?us-ascii?Q?wfoKG6sjSYo9f9DSIAb/Zi7ViUNlswAryh149RoGNuz9BRxdwEJ/HVYpfEfq?=
 =?us-ascii?Q?e5he6RnsDeghAuMURc/uDPHupwTJSwlLx+LK+uut8sUKbimN6dJ7TZdCfMBp?=
 =?us-ascii?Q?WIJ7Y/34uih0y84Bf8kt6LOZMEI0wXFdNMZumtjvSjWTzISlW9/j0tHhE1qF?=
 =?us-ascii?Q?Qy35EFGdGhwLbd2glDrTf+NuAaFaPjuE3PDU+Mm2lplkqVyQ8+W4P3ygnEZu?=
 =?us-ascii?Q?W1outFiNF2KeCRzquk4XJ+GCITN6/WIorvEtZ8oCuvKfuxpO1hyOMlXYtFb/?=
 =?us-ascii?Q?/zRijFYf5n4V9FOGgztAYg8+iH+KPjh/mTW7BjAMOPxnVFu1sDrqsSTitoo7?=
 =?us-ascii?Q?f/LZZSWHgJgsqwAz/TZqREQ9+pwXEgUra97r0anb8ZVImic1ZdBdFX5e53o/?=
 =?us-ascii?Q?g1VnRzFhr8RIMBLkq4GMvERtQsTfBENeq8WCVOH6YmGxaylJx/ypAlHCl3qh?=
 =?us-ascii?Q?OebJ2cRitwrQVGqJegr1vpGEJwpZ1xiu2dFJqpjB9mBpAaVQo3msGlyITIh7?=
 =?us-ascii?Q?wHzTLSb88K6NnKjZrlG47bPndkI52QFZoLo1f4IWLpaAfnpDKgqgsi496aNv?=
 =?us-ascii?Q?BcH0ztPfnM1kXZvmPDaK2Y0OKAeHECAa8H6TZFYao+Ee3jnjdePoWutJS0gq?=
 =?us-ascii?Q?odj5tdBdRD1ixcAaU1ITgUejsD6jzk+Y6s8mGRvm3OdbzPs44gYw9UK47CQ5?=
 =?us-ascii?Q?/812JaDGoCq6aspPbii9q33JtCQJgJfiMGAvJolKvwpjbkH+LRcaIZkckW0O?=
 =?us-ascii?Q?xz/XqptwLKuQq+SwG8+iu6X3lb8cDNNJQhRXurqJqk7hVjJPcTcU2EKEeZrB?=
 =?us-ascii?Q?b84ihD/49UOg4Y33QfbjrdKXR2vpceQ2e9DCup1XUfzJ0HLr3wisxY1/GEqe?=
 =?us-ascii?Q?lpq31D2LDVJvlE9TY38gauyKcaJrHtCMz8T+ZRUlcvJ04DyPWxFZRBYsljXg?=
 =?us-ascii?Q?u3YBzAJxJhAdwsVVU4phQau+Gup6bjjX8wg5rwxQZ/ytJXCq4VhrHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXU0neuOzKyYJR/3s2Canvx70DcNPX1+ITazJNoXiNlEzmx6ysrJvAJGHu+c?=
 =?us-ascii?Q?DQP0B8NwFRZayM8aVyLn9xAr+8id7Pha1GoyWBFaojNwoR+Tk26GAlFOQEwg?=
 =?us-ascii?Q?jfZzb4xT4TAcJMImU/rql1+Bu2SXgKje8Bg72M8AtBmaqNswhLb1Y/Rklaty?=
 =?us-ascii?Q?hYsd8UxP9poCEol8pOuxh4ivoWQ7JWe+njIXsdfzMBHtRG9N8sMO6g1KPjRi?=
 =?us-ascii?Q?umjkYntwqLyfwov2roeC+Y0nmUgpR0yjnpkoeKxHldt8o6PNpqggV21kX34H?=
 =?us-ascii?Q?wIRKbcSmdAhJiFI3WERCxEy8D5AnnrC58cePG8yMoRpLf0gGBVtIoX0ndVDu?=
 =?us-ascii?Q?KeQRJztIa9ax+4RNXHAY5MTk4aIiNWNxG1nDMv/VNqm37bu9ACe7WxfKJzI4?=
 =?us-ascii?Q?wlE5qAr9VpYY9YlC/eUuRNATQs8K28JDZsrtB8yrmdNoAyCOEpnzLPcslCYS?=
 =?us-ascii?Q?PXSj2l1Pcz5c//+4Jb6L5Bg35nWefkyIxPi7wtjg443SJqlzMO2+tJNSo0pm?=
 =?us-ascii?Q?MjvieB1wm8ECl7ptBW37yyaUmYl9K+Cjbk3sWVakfKSrJXfGhQR7PjI/7a+U?=
 =?us-ascii?Q?AzavoO/AT4hDjFEhrqME8hCROMJLC4rXPHGItfxuWKiO4lHe8CrzdVuDaylV?=
 =?us-ascii?Q?DSETMB1GCBdowboVz9FZwElV47lHgsBVJwMbxfPfGfelhCOOlCFoixCKcXYr?=
 =?us-ascii?Q?RY9KNsA6hbleQin0oz4jvWaGPxUJfgEPXdtAs9cTtzJ298cC4l01O682t5O9?=
 =?us-ascii?Q?Ah5/Pnv0jGQYRR31PZw6kcdVcn4sUdz/DWKYZKX0BS+elwq1YJbYZBGrvi8U?=
 =?us-ascii?Q?Yv3UzfcKpHyLRF27yZA1n5gZoRMXEYze9UX2QbObKGfRcyUAKTTi1wUqWf4t?=
 =?us-ascii?Q?PjADXiPYdIcSN37TgPPs24cgJWmi+nnv7ZyXAo8DAmmV/fpygRCJNAmApZ6a?=
 =?us-ascii?Q?DJ0QcyIU429TYzTjH7HtF3aHrXiHjyPclQLsK8V1bD/MhGbGllMpU0pYSII2?=
 =?us-ascii?Q?zvgrcLBK0b1QjsXhW9YVxgwUtxEEYi+q6PItoO5QHe9JflhVmwZ8i5iRcVea?=
 =?us-ascii?Q?NgPS6eKHTzFJKxZzEqwtQPfeYNb0GnN0WsNneo5cEMQnPD2cP72AEUY6Rki1?=
 =?us-ascii?Q?N3hzjPziu+UfK6LkFIjA2wboZWPG93IoC3IitXJEMvPsKQoU7nhV/B43W++N?=
 =?us-ascii?Q?r0P0GacR9ZZZEGJSHBwDaoq6tBUGJ0imAaW5z1bugS/WLJ8y7N8650adH0y+?=
 =?us-ascii?Q?OEbvJLP/53+XNzJoeeKjvA7aiUne0w/KjKyCmpfQ+kPXNQx95dNOOoDQuinC?=
 =?us-ascii?Q?txoSjzd0RtA3iQfDQVHayVdGWun+UohrCcYQJwmd+l+iIbgbg72Ztzj7tQPM?=
 =?us-ascii?Q?W2dqAb3J2s+IsWKgXZKWxtswnfN7fjnjZSI8+NqwD3Qy/Ll3r4KhlBYm/8nL?=
 =?us-ascii?Q?MkJZvRAfOMM6OG6Ux8g/NSAPviuO6zF5Ddztm5Gz2DuLiFDZW4h0b1ycaRHn?=
 =?us-ascii?Q?/SJMgLXEef/eIsa5e0LNZeDLHK7Di/m0bxrChCalcl1MPqCD4Rf53HZ/KMDi?=
 =?us-ascii?Q?Cd6HQKZaxHWpIVEeI6hP4ZE9UrsZMzHPrH6U8eQjj+AHH6E099ciiozulQYU?=
 =?us-ascii?Q?uCFKPdwbdmDHwQTXTgmFOpI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f67d080-1ca5-488d-55f3-08ddec8aca7b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:45:00.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehs2JdAytklR22+qdTu5mrhzhDMOxsmejMs2iFl2PEi6zBelS/Ma0l1+EtC79YiC/Cgrw3obguGpiVjATsZNgDtcyoKyoSGaNyHmKaQoqD8BYh+DAGVx2sZZkeBhTOTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14067

Use devm_pm_runtime_enable() into rz_dmac_probe() and drop unnecessary
pm_runtime_disable() from rz_dmac_probe() and rz_dmac_remove().

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1f687b08d6b86..0b526cc4d24be 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -963,12 +963,15 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to enable runtime PM\n");
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed\n");
-		goto err_pm_disable;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "pm_runtime_resume_and_get failed\n");
 
 	ret = reset_control_deassert(dmac->rstc);
 	if (ret)
@@ -1031,8 +1034,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
@@ -1054,7 +1055,6 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	}
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	platform_device_put(dmac->icu.pdev);
 }
-- 
2.43.0


