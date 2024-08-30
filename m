Return-Path: <dmaengine+bounces-3040-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47696965D34
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67720B24DA2
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C417B428;
	Fri, 30 Aug 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pM5Q+5Of"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505817B4E1;
	Fri, 30 Aug 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010903; cv=fail; b=UACONf/J4bOOtys8ohJYC8DBk1p5yNdoDH/th35PTbYHOaULAyFl5PnJ55xz2WTdCdpQg5nst7VSE7QTvoK7sX7+/3agdfsmhXZ6PrIdcBfVx/7WXVkIxsIjcjwJZTatsxGJqJ5EqXdjhdgG+Ntq7SqPTGbNc03UcMnyQ9YcUAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010903; c=relaxed/simple;
	bh=Qh7j9wmhX5g2OIvoFF7BzUrtY5MnqnRCX/Ycy2UFfJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PPmzJZ1H0fi7ee4uYdjZmZ2GFbTd07RhpdkT+Y1mVYJRTLDv4rfod6Opif3R3iyHDQPI+XleV+lIYWDAgNgGX5bOmU0xN+o9yH0qAtG6ScU32G+v4rgTEVawc4bsPtM8MRwPcdCgXs2AR0wzy58SmH34QPzPLLo/b7QNlZioBZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pM5Q+5Of; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD0HRwYPDa4EzguXEqEjtNmzCkDaJK4kXfcZDo6ryj9t1xlHhRT52D1nh1LfSyaTPoGMck2ExWJD8xGPxUVcrLgWa3A8dvm8E1iI6tGLZkOK4aAkBCgWq9lJTUlT4/TheMr60adWvrAtaLm+i7dv7a+MgLmi0gDUM1igVRVHZuLAX0CVFgpkoCxtxzjnpg1XP0g1B/+hIGnn8IZxId3qw4aoSzZwnllzZH9L9J5oaBrwZpPDU7JPKowQbvTuWOFhvC8+caC26abFc5sD23YpHveBwzth6z3CUkGteA0loa9fjH1acdiu1EHhkylVk/vh7OK+kCTk0ouFn+uikbW6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSflPk0BFm/B9lDS+zKq7lNbv3OAyQZkdwzDG4lbNz8=;
 b=vAyN7CDlUK+/x0damW0hkpoLYU5sxnkmk2NPUTRKbog3pKo2hx28fhixrqdO7ANJP/l9RfgeMr1nmnrVJzcavMoeN06k6iKPNhgaTuVBh1RvXjjLgbTRAbOm6Ehqt7K7h5pWibUST7JKldTaZJXfCXIhlXHic+anPZ9ecEI7cZDDsW/vlCRdyxt8EtPTtRwShvw8Yw/wz5d6ppOyUkHIIEj5N06G+bTHDXwbmUgtj47u9fqarmj+uEwnieGS0MO0fkv+Ds34/NUDZs6y7dSKxi62UobEn/RHIm7TbaOtoPthk7X3Xd7VKtmNnuP344w6AOqrO1ZJTZIKSmcK0nRiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSflPk0BFm/B9lDS+zKq7lNbv3OAyQZkdwzDG4lbNz8=;
 b=pM5Q+5OfSDpkiNeRasec7Tdl26B0qGI075GhVEh06LsFXnHOupTL1XXt0WOJS1vFwlaLgRG7S7kGSGFZEBlzlJAP1vpitls0cBe9JSvPLLyEnM1jqL+aHfSwZvcST9w5LfexS1x+e9U+EDxeo0Z1uSap7/fs1E9tcC/ABTU7evQdxZTyKbFvuVj6c4kUabAuR14OduOT0SjExKoj6nOCFIHlYWTaDJquXRPYcplEB0h8E6iqnUBHLxDDzQ9zmPEqLNgrDoNv2o9rrSPTttrqiH6f5UtMA3VsT+K96pD4I3Z0QGmUl0Zl2IsDwzxkoE69TPyiJsN4QOx071A+rIMdBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:39 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:39 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 3/7] dmaengine:dma-jz4780:Use devm_clk_get_enabled() helpers
Date: Fri, 30 Aug 2024 17:41:14 +0800
Message-Id: <20240830094118.15458-4-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d5a50e-d530-44e9-93bd-08dcc8d7f27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmbDlkjnze4i4scuK5McV3Zh/AR0O45hr3HxGVaIKNpQn8vZ73khYI65TMeo?=
 =?us-ascii?Q?yzUxDYpOimTUIoMgX9/FCvEl1XOgka9zthE8q/euZlH8ZanK2LPu1Am6wT1W?=
 =?us-ascii?Q?gh2Iafn/AODJ/Pbd+ul+HhdUfkSup4xZRu8Q5XVzNaMMIh2ptsT3XP9aAumJ?=
 =?us-ascii?Q?1wfIU5lvVhy3e93FtDyVrBn+mv8FUa5kmsfFnVq/0ikqrfpZG0Wqjg0n83tA?=
 =?us-ascii?Q?kKsLPw/y5Pr4I+lLU9IfUxXjHoXWhzijXmvSG69umlh36HeuptX+cXmbLz84?=
 =?us-ascii?Q?qI26K20Vb4omW85ydwnMPMgdRapTMBs7NcqAy0F8654JKfuMsKHDx1FFGn4T?=
 =?us-ascii?Q?BBfhixhTNlhnBOWO0CWzzeyafcziALIfUX8o150w/uz5OWi+qqp1s4VOpOXK?=
 =?us-ascii?Q?0BC+Mq/F1k3pGj1XjsFropVwfxk51PXnuzQx2NAT0mq6KqwWMtj3nlMEMpIg?=
 =?us-ascii?Q?rPoOy252MKUTNsLqj2wh18atPVQj7LZ0kijzMhgDUvOBU1WYBLJZ0legerk4?=
 =?us-ascii?Q?kpwpDzu3s4mOy8PCidT3Ig9GV4Xl7eN4y/Bhj+PHbLNxg5GOJMOJiuLsnNX6?=
 =?us-ascii?Q?fLMkYOH9vaZbH8Aw/zuB+/QriLCzDy/1MQ8+iGNrfuX2RWcoSnmpL5ISV0mE?=
 =?us-ascii?Q?BuFOGahn7kMLfgx1F1sd8H7iySy4D6p+KaWx8fXzoE7lIk5sGYLtfYrCOHNq?=
 =?us-ascii?Q?Zj5bqr3EOZo2+q86b+pWqS9/9YeqFMOh7BusETasYOzynxAwB3/Nw3QFOkHB?=
 =?us-ascii?Q?jWE1/le1c77Td9p3Th9vmaBZ4lpicFCGDxUf4mB6X5x6qMkl1XJPktQESDVh?=
 =?us-ascii?Q?8uuHlONYbQr/gLETP+EWHo0rHuBG+ucrmu/u83/36DUCL+xhxLsqu/edn/rk?=
 =?us-ascii?Q?YK+tNFfKxaC+99M5Ppog2FGhPXZ5dzC9iZpxRFd8RmohgJEP4Bj7SDSKncEP?=
 =?us-ascii?Q?kEYyhMdCBzDQwg6Hp+uYoLBhgjMGaaI6yLUmgcYAH/JAI24TnuOBLmliaDAL?=
 =?us-ascii?Q?wKz+Tmmcr8vio5AVAUbYHyj13nCdCIkK/LtRg4p8NxeVtrEwfwVapJi8OZz9?=
 =?us-ascii?Q?fyqEDEbJMwfSpknVb9rdgqGeVH9nIZACbRD2ed9bb50oAUFjGJipbGtGNUSL?=
 =?us-ascii?Q?pBulvmHI/Bu1wFYDoEUsApAbGdD7AXFJ4q+naJunPSzSDZdOzqrAdlJmeGqb?=
 =?us-ascii?Q?0Z9mNbxTziZdX0SQgvDYKlAjyJy32AzUuYGd6457xyndEES1Ds8X9ILyhxcQ?=
 =?us-ascii?Q?azY7uM37/iCkZpEnSlm4/ducgvCucFom/BsfjXlJX+9ICLo13NDwJxOr9hvP?=
 =?us-ascii?Q?RObIBUmRZgtcMs4wXT/IpyStRdtufPg3OfTiA1PumP8pEaPavG0tZrOIUf0c?=
 =?us-ascii?Q?25ME4pjwlCdD3x1oV+gY2RQWcEDYZiS92p2C9ZqFPwNY7xJ+uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DBK/pjBI6M5XI7/HAkUn9Qj1QVTelcPj3iTbHZfBqiWddrLxRDKfbn6KpaK?=
 =?us-ascii?Q?Pg2U3LUMwveqT9J/0k8/k30bOAhS5opM+syfpoDeq0pqQxelHfRG8+u4UaN8?=
 =?us-ascii?Q?nmJs4AMR2RrY6aLzTz45dshRxczGhgiDLSN00KK8I3RJIb+4K7Ec4oJRiFKB?=
 =?us-ascii?Q?kJolGQ3KakJD4/y2xtvLD4H1tcnzT0cnLzn2O6n/nwAMNht5+fglZjk95nRp?=
 =?us-ascii?Q?RkXrR95Z77pPpma8WO/+hg2QdvcmcVC051idtTpqNpNlLuQknhWKjBzEk9L0?=
 =?us-ascii?Q?idI/7szdrGdldeEcMxC4N+2h9XhwVSw/i0ZlINw+qtXKDWqgkuMAmfD1A1Zw?=
 =?us-ascii?Q?cZ0LnTX3olVtcgi2u2Xn0dZfS8KjjtrO6FBOX6SbnDIn8iUB1IhV/XPDjYX2?=
 =?us-ascii?Q?hCKwinMANdaEp7qcQa/QyjP/SgWiqu39uVs1m9QLcfBJK13engl0AZ5z3gwL?=
 =?us-ascii?Q?zhRW6qHODTCZNu/Bljag+RNtzjnmrWARRc1GRKvEoDJ6H2V9+ll85lM1DtfK?=
 =?us-ascii?Q?iVq1JXjBgbIzt+/UNgguG0a7sajW05pEgtM6UYHZLboJl9IPplzm5slW/SJ3?=
 =?us-ascii?Q?LVAxXvj22tcG64TgpJCu2wt+CzeqJ9gnbW3JWLj9nvKqKh2Xc9/38qIk3gFf?=
 =?us-ascii?Q?CGXyHChY0BRnqjzqMhC9SMPZbbSJ6TxoaxBwha95heafuN6pj242Y0Aj3fMc?=
 =?us-ascii?Q?SAk+GrBd1y8GGq2+IKcYKes0mtieeJyWakM9wMy/CDpVg6ADQT5aN4rQviP8?=
 =?us-ascii?Q?S60hNXCyFKURL7jPLW8tScG53ijI1ueXf/gj0aZJ3FhK8DhhL2Y1wo59igiN?=
 =?us-ascii?Q?F0kQJx47+OC+XHI7CtBQ95/nMjZXrb+qmPJsXI68Wpt4S3d32OjXLYOwhZD+?=
 =?us-ascii?Q?F7j6wJdJ5iU0D6rdSr7jeEDm4c7wzlD7zQbem8m8moZ7wKaeRyRvsJEkq1Bz?=
 =?us-ascii?Q?87kpVHykkhmJFhd/EJzo76XkytbXPhd+1n35TP1N+rtYuqT/87xnmAUTGiuU?=
 =?us-ascii?Q?FvodXo4nKXWu3wXsJQhYyDzWoMr0wCfALGo1QJWzqgL+c5wFUmlU00T/vvCK?=
 =?us-ascii?Q?8de2DM85B4pX+p4oOaOVVI1xT3aIiC3DcoouV6QJ2BG656LFgaoiP23FFe/M?=
 =?us-ascii?Q?Lh9oxwVtHoFXVF8kyWooG2EBnUIgonuaX47MS56M/y60h1Y4kNnJP37RFr4R?=
 =?us-ascii?Q?DNSuYpfSrEVJxvpv+t9HND2YILmvuMen5vQpMcd3mPrdhfOb3b7thaIrWceG?=
 =?us-ascii?Q?+UXQZ6JEQ9Fqqbn59NUDDE7Gr0gHEiEDxshTMacpGco0/VjqSmzNWhtMvCTV?=
 =?us-ascii?Q?bswk99VXcR4tG1oOxAiLb8fgmfCV0nltHbx5upyBzatZ9YfH82j8Wjl0iM0Q?=
 =?us-ascii?Q?G47K5ZftcN/vdjunk5I7NJv2EHEfFK7q39ndJrnRpOGTYvypym7ZfsNKKVx/?=
 =?us-ascii?Q?ZYqaEMmqP3ZbI0+dZ15HWvITbYY3jR+CX2IB2zS76BjuzJGmI6UpER5kFx0e?=
 =?us-ascii?Q?SgD9tGNmuLqzz7MaqDM7MsEVGt51lgOx9QwdfjIPo7kbduAvOWa2WX0qpKYW?=
 =?us-ascii?Q?Smgx0wWxnP9koOUMMHPnwm9RLsP0j3io7Fx89+jg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d5a50e-d530-44e9-93bd-08dcc8d7f27c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:39.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TuISufff5lBeq9ZVZIkTuHqmS38Q7RPgIP0CZ8Gcv+gL/ZzbeD8qqI6qOqEufhDkGOP8EBRGe0IQ7NTeBLTuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

Use devm_clk_get_enabled() instead of clk functions in dma-jz4780.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/dma-jz4780.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index c9cfa341db51..151a85516419 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -149,7 +149,6 @@ struct jz4780_dma_dev {
 	struct dma_device dma_device;
 	void __iomem *chn_base;
 	void __iomem *ctrl_base;
-	struct clk *clk;
 	unsigned int irq;
 	const struct jz4780_dma_soc_data *soc_data;
 
@@ -857,6 +856,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	struct dma_device *dd;
 	struct resource *res;
 	int i, ret;
+	struct clk *clk;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver must be probed from devicetree\n");
@@ -896,15 +896,13 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	jzdma->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(jzdma->clk)) {
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get clock\n");
-		ret = PTR_ERR(jzdma->clk);
+		ret = PTR_ERR(clk);
 		return ret;
 	}
 
-	clk_prepare_enable(jzdma->clk);
-
 	/* Property is optional, if it doesn't exist the value will remain 0. */
 	of_property_read_u32_index(dev->of_node, "ingenic,reserved-channels",
 				   0, &jzdma->chan_reserved);
@@ -972,7 +970,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	jzdma->irq = ret;
 
@@ -980,7 +978,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 			  jzdma);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ %u!\n", jzdma->irq);
-		goto err_disable_clk;
+		return ret;
 	}
 
 	ret = dmaenginem_async_device_register(dd);
@@ -1002,9 +1000,6 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(jzdma->irq, jzdma);
-
-err_disable_clk:
-	clk_disable_unprepare(jzdma->clk);
 	return ret;
 }
 
@@ -1015,7 +1010,6 @@ static void jz4780_dma_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 
-	clk_disable_unprepare(jzdma->clk);
 	free_irq(jzdma->irq, jzdma);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
-- 
2.25.1


