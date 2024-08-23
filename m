Return-Path: <dmaengine+bounces-2940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17C95CA53
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A1F284113
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8C185B68;
	Fri, 23 Aug 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jM4h0sVP"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC818308E;
	Fri, 23 Aug 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408401; cv=fail; b=TXx1hgVcVwOSpxlO3KGhtiG4sps1WUNzLyNdHfu08eJf10z1VMfcyiuELJ5b+jZZho3XE/yKFlhFrg6aBqwd7HImwlxalMuKd3W1yBRrviBUf10JFyYPBwSB6XEvgGyWorRii+ATIfDN8wTdVXXlQzDBQtIQ0ka3WZQ/gYwmDVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408401; c=relaxed/simple;
	bh=Qh7j9wmhX5g2OIvoFF7BzUrtY5MnqnRCX/Ycy2UFfJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BDsZDDwYjNsx6EEGE8IlSJ/DRXP8TJtWk7ha+Rox07hRBDE0+trXDBxdmP64pmTczbXabAJdF5V1hyZQcLn5c6QjPhTDwIpvuUjzE5weR+upiuwc+ZzEhrO+wqtihZ8vzCeRpBS+6jYY6b5rWWZUlqGoWVL71WqiiGO3YuKTO4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jM4h0sVP; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Ya68rCg0XEMFcmoZazRgq/olbe1KogU8RNduvk/ofgcz2C89D77LDF0VUgxzdR1L6l6mMH0h0q6N600UHochgdli618FxrCCNWHJdzbC7FoBMlVULo3QqEpESgOY1LK8n3EZCFkhXt/SC3uSu6oL1BW0n3mENk+VuUuTN44pmAYif9gQ7XJ5o7xMrI+0616bbuJHJlTBD0vgsKkH72VhyKoRzJYXUyio4Todt7+qVkVOzih35Lse09Wfh+M3dgrIcfDJpVQqKC4A6Wo36H2Gfjd0CLk7D0/7jBOwtIsDoHDsnWP9tt+i560yOG3RXjqBGoDmRY5/kQ7lU+bvox3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSflPk0BFm/B9lDS+zKq7lNbv3OAyQZkdwzDG4lbNz8=;
 b=k6rT/FkweLNowznkg7SjjI8nRXH9J3+7OvHAaHkDcPGDSI3BWZ8dofkRGPKGhoBRvzlGAG+Lvf6vNxerdQqKd/CqGbL45N9AmN7ht1oa0SK1ys/zbdP/beXA4GyKNqjD2C9Rv9jI2IeBLiszeXBeNNDGr/cYfuZmuNdMst0RFusuuMTKLvXTYDoykh53yP1aEY1b/zD0cd6cnw4ZpHKpUPim8H7hwmClKj8L7v4LFQwVy32fgXhhfSeSatgd0QIPKAqzOW18Gauz2cJPYwv3Jfoug6OUsJSiqrvYP+1yvohNj08lz0QF2C39xdqSGn3BAwWhmQj/CfP0BYgAVryxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSflPk0BFm/B9lDS+zKq7lNbv3OAyQZkdwzDG4lbNz8=;
 b=jM4h0sVPM+XP6le8dTrIMdC/EUednUhB9oRh/foCXsj10+QwHVD1z3JnI/U+QDxE31+B+GL1os1WFMVGJ0nRJuvfhn7o/zVAvZv8XlO5N45fQoGpKWv45LqCyeKdhMazPDTo4kZatrkWMtMzfe7sys43UrpalrbXG587L7UDg04vlg94v9n++n2fkVc/dB6b2ObZFVk9sBZVDuEefvSLq8ZiN1pBsG52nkrTPP0X1MDZDGIrHt3p0vH0v1OqEEKCY0qSHIDkT/uEC1m/+OP+eYfRMooFni4gS/D+d7JT4YX55JrpfHRFHKyF1LbKEevmmFQed1gFcPuQIWCyh21nFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:19:56 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:19:56 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 2/6] dma:dma-jz4780:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:29 +0800
Message-Id: <20240823101933.9517-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-1-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYUPR06MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbcca87-57ac-4334-0632-08dcc35d2307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JvW9lSdXOP4ARRyIF8lwIEhyj1ZdRE9wq9rClDnJ9iKyc/WbaSFQESSuJU/b?=
 =?us-ascii?Q?508lxtlvyAZRmr48SPpnMtAca6kxsRatb0TZ7FEQoyevFGtHmRrHKzTo/9uG?=
 =?us-ascii?Q?sKADXqRtp8XE2V/hzjWgpej5htrSFMPji894hm101uI+12cjqhG5YjRIG3B9?=
 =?us-ascii?Q?pN7Bu260HYjpC+tG/tgaYB+vyQhHCYHsLwq7CGOi/B4XOTKmf1tgyCD1rjDZ?=
 =?us-ascii?Q?FEY9O5UFICTRfZoFNL03zrEWx7EWkBR8xTIhofs9DAB38wMCEgGCZMY8zQl8?=
 =?us-ascii?Q?0xF/OhdnCAptjMsFxcPQNwrG4GQvLJZIywT68LGH7f9QIxUkhk8aC8DOG+JJ?=
 =?us-ascii?Q?EVuHT+U8+S08Cmu7gG972mTsEQWmnf6rtRXu5tNDwYigFC2XWw1uSEgjnAr6?=
 =?us-ascii?Q?ZM343+eaEqu+mZvF7Vc6VSUjZtN/ybHcg3Sw4jx48NZiFPS6DHIjRWjVPIfv?=
 =?us-ascii?Q?7aUwbhSYfDJuD3DFAP8YKWaIN8+e0I2tEf9qDBjJvuJrtFSPhsWk09XsOa0y?=
 =?us-ascii?Q?6qkgqFQnwDl/SOwu3Y0N2oYhC0VrxvdHOdSGQz6kr1pj4nfW/tuW6AOH9nTZ?=
 =?us-ascii?Q?tMPtiHAZJSjNPwXBOXyaL4kajxfPq2qOCMDTCfA5obLyQLMZ0yQfoMSaMJEU?=
 =?us-ascii?Q?bQoRDvxtj2Y/+zYT5tS2Ct8emYELMPtuQIdEY5rsN1KzgaosqUgp5cv75Dyq?=
 =?us-ascii?Q?jhfFNSPUS3n7YXicJlzYhG3rV00pWL8xhYHqI7Lq4bN1BJxKRX760R0kwP3p?=
 =?us-ascii?Q?yo925+6zNDTFTwOUIyt/8QaS2SJSnGMjLiKxQRxlINK+uNKkAhmau9Xye/9N?=
 =?us-ascii?Q?2/uj+bgbH2K81/QHBCbHPpA6IXsG0Ycf+HfgpuRpwNiTNXPPkFqd5EJzGFed?=
 =?us-ascii?Q?J0wrieLJuOOnmacPF/tMHq5ohrrMIEne+GK2yHIU64N4+h49GO7kPuf1C9GW?=
 =?us-ascii?Q?2yhZLkaSxvWxxSHQRFNtY1zyHlwTLAWTuAG8kwvDHpivriPjPCiPJSfmxgND?=
 =?us-ascii?Q?k9AJN97S274KYtD7ZX+hc/zyUAub3P2UxmNntn8CCL0IlJsvDDmVhnDpirvB?=
 =?us-ascii?Q?ii9dsvKX9UONTXuGCxCGSsdjP5oaEhS2zH9TIqDgf+ItEdOaHm2O/wz8v4EJ?=
 =?us-ascii?Q?JZZR3QvjQ7hC5XtasAKHN+u+P4aDP0E0aYcbPFOQhHbYGvRVSN5o/hishVFs?=
 =?us-ascii?Q?ESCOIr2rjI6DpKT060WpJWrs6ezhe3YAYMVH6NT56yWgmiG4h0yu0/TovLIl?=
 =?us-ascii?Q?Y2h3DeYyi+0l3vwEWBsqB9au/M5Pjg4EmCYAkaFNt01uXY89WoKLbprsSPje?=
 =?us-ascii?Q?kGEJICFn7uB1BERycQZEOK4bvPZwdOKbzzrihmAF0FO5iSD/h9ZV/2LcvlHT?=
 =?us-ascii?Q?DKWRrtEdq9jj1ZTBQn1ufTTiwqeK3hakSXVuxIxFDsifdNLG1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfonzicP5ZaATNsYFL1Hxsr4IwiKDWMIf6Z5MZinRy3yPPf9u+qDqAQBMCaZ?=
 =?us-ascii?Q?XiJsRFWQsgHPT8OiSd4Xst86qX8zwuhcToCGtx2ReNMQ7XXT1tJZ6lhRmKB3?=
 =?us-ascii?Q?03M4IJU9qkYj9JXtUeAzDKM7HGhnD3znGmPAsrPPJJOk4lJEkBCxWKIuJ3TI?=
 =?us-ascii?Q?4hmhiVwcsKgAIJAz8jN/wVXNrV6bbArJc03PEvyDp5YWbvwalYL6j8mg9eRy?=
 =?us-ascii?Q?cDIR7jJXkOerx+B/D5ZSjoovShVTkb+/uU5EJmCOPqMD0kL3AYpsIo2vFJ0S?=
 =?us-ascii?Q?wuE/Ykiqul64hAxC21GFlsCI0xTBc6AMvZiQkrliQr8Vb2C8AsIILeA/hSVV?=
 =?us-ascii?Q?HzDXtSqkKvwIWn2w6pBY4JQc9cNhENjyIKGF6zoWZUNU8gBDlBsvKxBdQ/+E?=
 =?us-ascii?Q?m13Pjsjbpkleq1jlp2z+WcIhUML3dofTTl0qexnSNp9KD4FObG5WORTX8YUh?=
 =?us-ascii?Q?Y+03Got+lMVyZdlK8S/l28vKNxOGDPNXyRvhuBMYOAwrzoIOSQHbh5KfLgyw?=
 =?us-ascii?Q?g4QnqTQKeUtY66IZ27Atc0k8iKmOH39Df27rAvSgzsemEq2yvl4O1cyVO73i?=
 =?us-ascii?Q?lkiVxgFfP7nz51zTAq7nuDFPcdWRc8Vcvei+VvZpmvb8QRS1NAsXbHSLgxym?=
 =?us-ascii?Q?71LZjWsIudpEu3xZqg6pee/jPvmiggfWd5v5oPhzB1LPyux+IPRmoF5R1Nuk?=
 =?us-ascii?Q?hJIRMMb9JRPjPUkpeaumH/s2ui2GKX4ovpgA5wJl65ih1YENfNC4VdBCzLSj?=
 =?us-ascii?Q?8gGdjFkf6NMACTdF3ZtYxto4T2EhHkH1HsfCbUeklkSUD+yHdHIq9JgVvmj5?=
 =?us-ascii?Q?sTlKDOckpoSU6K2Hxqbyr0nRC+TVNyv31fePl/pndO9y1s8y1+EpnO1N+VwF?=
 =?us-ascii?Q?PFNT9pTW2XPIwN55yMl/yhkW740Gtus17Iis+QyoHFArGFeSX0TitskdQS1c?=
 =?us-ascii?Q?nzRXBaCbXbVGZaaL5k1PMntnJqSdLwea2z8BwkreLPOGsoG0Ln2TiuUe+LKI?=
 =?us-ascii?Q?3mEtx8p9ceO+4z0N5av/3qJ8rRqqgWk0kwR9ronOf4U2e2i7S4so3gCY/d/k?=
 =?us-ascii?Q?AevseFFss3B+0eavfH9RRTwZW8xxr7ZOvqwnEXFEIBxj0uSAxK+XsUwR6MYh?=
 =?us-ascii?Q?48o++Y9zJmRJO0bEuDLs7o5ItCoj0pwmMsJVN/7CdFUoYWWPXpAuTWeLWaoT?=
 =?us-ascii?Q?vTYcJ/sCnaIW+JMFmgEbV8AY1yrlD6nxhXqColCecdPiIiA2qDHxP/1g1PHO?=
 =?us-ascii?Q?n4+Ysb0J6dity76L6bR1RVQHvv2ylNJABNCB9GIz0tm1ywXgDJIE6/oMTmor?=
 =?us-ascii?Q?6jvszm3uNW3vWRqqYgUb/1ORYYH4NF/TQy54VYBxy2eAvInld+K5pquXNb1F?=
 =?us-ascii?Q?KsDmemgvB0DiwUYaRNkRGkMOu2mejClrar6XKcjCJ2t4/2fBgd7UubUkGKsv?=
 =?us-ascii?Q?+OCoOYXklNtto2taQOt6pEKaIlKh/5s8/KvHLMwedytYuduuDpI3LVn7Ofyg?=
 =?us-ascii?Q?xNmNfN8XsEWBSQ327q0W3HMFgwK3Vut5BXqt+oBvE0gc3bAwg7pxoOnO6L8D?=
 =?us-ascii?Q?lQJ6ra+VXJreD13XlFJiXusqFFCrezdyOuYaFjba?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbcca87-57ac-4334-0632-08dcc35d2307
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:19:56.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbnKWWlRzdWZYUZlSBBSVA+GaNN9XPKgDu5oMP3kNgm/elNVfYIBTyvdtHcpmHUEdmDIR6hDnNFc4UVc/o0N6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

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


