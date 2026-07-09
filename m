Return-Path: <dmaengine+bounces-12182-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DcIHFitT2pomgIAu9opvQ
	(envelope-from <dmaengine+bounces-12182-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:16:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB873218A
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:16:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=qo5FK8ae;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12182-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12182-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCC7330D7D90
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416F421F1B;
	Thu,  9 Jul 2026 13:59:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5D42314E;
	Thu,  9 Jul 2026 13:59:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605557; cv=fail; b=MCuPBTKCZWwKdYUMYLgY1aN2nXCO8XchMRYAM5caWswP5TymtVh5Rie+PFq6+s2Xyeu5aPPlgp+8qL1UowpfylM3F81gIDnZMToHFsLhwN12PiwFDrgEIR1zadK/9yuZp3KsdtfSjXOPdFxokruZLuj690wDF+dVbRDBMBxPcXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605557; c=relaxed/simple;
	bh=qOy2mmSp5PK42bNno29AX9xkS3/AMKGnDBx0GX0qnHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6KgR6Flz8FP7m+6Q3QQFNS5o/5qd1MHpJLkIbw9uY0IemLlLagclx9QMIyphndLaNSID0kcH2ixOuYgyckS1W1C2AwrOjbCmJa1x+65v9BKCpEu9njkW5SRmdR7K3XyKVc4g3E+M/M9VTPyGF/vlQoVDO3SMExySKARSihfPY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qo5FK8ae; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/X7JGvrWF6ug1DJPbFvyhvISrsI32iSt1hCWpPkBlaApLg9ktNHi8FdU6RsbNuwFPrbpFHJqGTdOSVYEd4awFD+DHAscvcpZwwUjbJOPtFSFDK0KGlThT44K4yEcRbsrpRqE+ll+oOUFbLTh/Mq14bOZjaUjx3hlTYNxCrQeKsT9wpiihUoeOGCFW8iq30PYflhuSAT0VRIJ1Xa1X4FouEynS+m0yVYrHkrCTuLwlgoULb/z0snNke+nOO+Xg8xSLndqctH/A+NXnQ7vIsxGmH07ggetXCUWX0oHj7u/qcDO0GAGtXmZpAefPZQvBX0Imynp1Hjusr50Wz3sWWhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ7M3uKYtMiuMbu6lqMpsFqdaCXS/eyC9qg8HYtrPQc=;
 b=qghuTs2VFqX5iEqOApTZghrx49tYNDdNgfNfUcK/VkW0o/1WZlkL9UvMaSc7wK03tsKk8AadSrbJxIMPygv/XK8aWH1fnK4MOY+nVcHGECT3Q7ju0wZUuHVb9zJJqTCgrP99QLX+ZYhPgurtxf1jlvy9IL0OpPOw7XKQu3+QpF9CzHhjQlFtZzq2N29F9MYN1BzgF/KtePHnRmSjFXYCG7TTQXpdSE+B27XZbWCGlOFwILa36YV6cB1QiGSNkZ9iqNSSORcaF3KbkIsljyqBR0C4fapsVb+LR/vbyo86wyFF7MkSojDNagaPM8iq1271DeVsFyRzyk56JfYKbO9qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ7M3uKYtMiuMbu6lqMpsFqdaCXS/eyC9qg8HYtrPQc=;
 b=qo5FK8aeEZu1WTH1eqgjZ00D7apxzepjjXZBjZ5wZb2udjM8vJTVDKuCVfl2vzzOzlpmlh5SjU3AfUV1/IfnrbY0vnMwZesBskHcb4CgxFMZ/HowPtCMlNtXmKWc1oKdF9WGwoy3u4BR8EdOUks5E4Z1mINLU9ZqaXoLOOaDViXX4swX99U2Gc6lR3PPELo8+ytWSPw4NQmhdR3LR51kmZDSOVOlGbsw9C0kwKK4HM4d54n2WGKAHbUj9QZLenzMwJXixDPrUDr7gP0XN1/9CuKipiV7lfl0mZqAQkl7EJrP9RhIPOH0A1jVdQeWemlaNdWBRe9fr1GKwCdpd83TSw==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:08 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sean Wang <sean.wang@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dmaengine@vger.kernel.org (open list:MEDIATEK DMA DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:MEDIATEK DMA DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK DMA DRIVER),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 04/26] dmaengine: mediatek-mtk-cqdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:08 +0800
Message-Id: <20260709135846.97972-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b98cdf-e51b-4e32-2172-08deddc23eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	wmtKNl81DRBA3TTxmZCzaft5PHihY43Hms0QCXY6WCp8EB1NXUP4SK1u2ZP8PzvcpEb00xQ+HxLVXa+GSDCderbrF+YQyJL5D+JcFAVUki+gFpPhP1Ch0mQA5EnFPrdPy7xW1AafGyf/bkOZHBRDIDR6JbktnUyBP3BrzeFNs181dsaj0nrcAAAwc0oam55Twk8e5BvK6k59By9Iy3jvRvuij/SqNM3kFVfLG3Hc9JGhDvog0hLj8E/5su767tR7AiEliSdEfFSltr+2ofUPlsbSw/au7VAIumFqzvdoAptm8A1CP1ST2IG56++pse00qZTf80Xir3yFenDqknCqHCR+1VosbA08I/z4cY2npw4FVTIWhbwb5c/1ZaAZ4k3cQzf69pCd0GzDJ0pXsiJMGplws15Qpya0Fl2UZean0YeNjER0Ij/IEQnvgo0dXD3/iNuyR/lYqFyULiTE9ipgdC3clGZlxyLMJ0iUPAKiUj0nxUTm5+d+9hgCIDWgqLApJjpy9fqUzpYlJ4kSY1cDo7WTVBv7pRfiwX7NO3/d7pX2ay0kzmuDwx47FZc1TWa6BBvUMJuuGcJE4QKAAPA1OZEkCbHfwnusr4OZfsd6kOokdMVT1KsMER1EI7hfYMMAUtPwcl/C6kkumjCjsI7TK81jPI9yufsLn9CkntBx9smu9r3YICBxS8ggfjuGs0rQyczfZAFPkH5kMBFMDKfyk2MLoOn96HnsVyXfi7s/AyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QY+5pc7rJ1Xr7ELQ6C29rix8y54I4MXPacBNASUN65u3X0hUxPuTfuSxzDrO?=
 =?us-ascii?Q?jjFjfhxyOVMJueEPeEli/a8f1NMLJKqKi04Yvw2ktou+mCtYawQD7+OGfCOv?=
 =?us-ascii?Q?/wyDhAO5Yo7k7TA8bh273Z/jgB5hPIKyaPTIUoAgnKNnDYVcAzCjzXqh+Xxb?=
 =?us-ascii?Q?vRa7dwp/QmMxV7W5QD7hsUEDZHjSnDhMUuRLNsiORnvQ7AH0UWJV3GHwGJ/0?=
 =?us-ascii?Q?gDMyxiu0p87Cx17JIVu+AmWsVwQimpuoK6mvDFAE6JRfjOcULbegBWqMIv/t?=
 =?us-ascii?Q?q75D0zKyAQuo1gzaGy2pPociOpErMqsaonqNeJWA6PqbbvbOMEYoan9634R9?=
 =?us-ascii?Q?wOUK58tQvTzwj3efn97Cttx4yHxuB9ppO2m3R4hePlqoG+GDpnDR32+XyEnC?=
 =?us-ascii?Q?bE+L6zfuLh5m+4OAY2jNMIPdghWlYqfyAsI7X0Qs0ai6e4dZtRYE/M5SC9sG?=
 =?us-ascii?Q?ralfFoDwSgLu8AsB00duOdyE8mBRryUNJ7ov7urhGU0QshIBVrU3b6psaC3s?=
 =?us-ascii?Q?t9F376I9nbxd+dO6dWE3Vi2WyR/oZiKTP+PINnZW8puJFHBaIxERHNIYDmvE?=
 =?us-ascii?Q?CKFXZoeR2vAznD/M/yosOxN1nl09RXz4LTdPWm2OfTDFGMe0ol6LmSGScuxq?=
 =?us-ascii?Q?iWpQ83Om2U3t+Qzjs+TGAHjzHomzsQ1+FYiw92eISMTzfBCjlS51UckOaL/+?=
 =?us-ascii?Q?7ZxW0MUW1ciprTG2PET+jr3yv/BqlTTYn0vCX6s2Vg1Jk66wSNhMiW5EnkCX?=
 =?us-ascii?Q?KOdegjgDxQesEmLBlRBGT4l829qtTvx+k4hSA4X2XeaoCjSl3XrjG/Ky01lj?=
 =?us-ascii?Q?r3yZ7lu/kS+0WqOxWwasDqqfe6P8Sg745swRcdlkl0GITJEqqa6jyEqFxBek?=
 =?us-ascii?Q?Pn46Wv7GTR0nZRdhxevHjkCb6yDH09qkJnInZyw0xGdKJyM1THEEStpIA8+U?=
 =?us-ascii?Q?UfS8kEKLAsTmWrq6Km3ZTHUFVK42RGP+9mXDuoC9ZjvWXIiuF75EoquVOlDM?=
 =?us-ascii?Q?43yyOaziteatn9JrelfGYzTPFCyx49dUAUloa9XkbHEUnvDIyJ3WJE4g/Gyp?=
 =?us-ascii?Q?zMEikrijU0+/w2donuFWdJIjYlJ5PHHLCjEK+dp1wdAbso5HQT3plGmvM6Ta?=
 =?us-ascii?Q?HIx9qBsd8SPWyoFHy1GVVpY+kyoTPJEMwCLXjWcx85NcnJq2HpqfdksHLiVF?=
 =?us-ascii?Q?9MpAsKBJ43JNc0huHQeokeyNMmOG5dNGkEoj2w//9bBLzeZaf4QECuxF5hlM?=
 =?us-ascii?Q?DrktEGaPzOIW/hr2hTgs7jZlR2uhEfC0t6g9HmkyD6KgXpbJuwWtsnwFHKnx?=
 =?us-ascii?Q?Nz3djEo2li0ZQbmznwEUtHYwequVfR/Ia5GZmXVcgklZl6FP5q9UaQxYmGTF?=
 =?us-ascii?Q?Sd+X5P5f9ZprTgyr/ogXZF28oSh7xmLZ6DfNJRCIQzEcNuGLOqhbzL6HvL6z?=
 =?us-ascii?Q?JgY5fDZb43BulFKl6dl1fqiIL/rrk4qiHKJhMX3R/43XxJ1tW91w2ri9kKiZ?=
 =?us-ascii?Q?5EaNmaUTHczzR+gHWofkvJu2u1IdHJOuv1rTgUehO0Y38tyEf6B62hLTHp4N?=
 =?us-ascii?Q?f96Lienme3ewUyQ5ZOUeF1f8GxqKCH02CbBIv1IV9uV4N+FhmzrFCfN25gJL?=
 =?us-ascii?Q?98lIT6NS+xHz6lpnv6WgEgIxqwezqZ/tuB4KCoaS9MYy5HlfRERJAK+KF2oO?=
 =?us-ascii?Q?bnGNF0l8OkuXAI/nPMq+I6RqOkb2sjvHHIz+KtVxqxd57q811kY6THc+RG6y?=
 =?us-ascii?Q?5Mx7JbWc0w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b98cdf-e51b-4e32-2172-08deddc23eb8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:08.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QP6SG/xVxrBWVVbSoTkxXBPRxw2cL9TEAGoAmK1dMSA1QfjJIqq7QC3SMNy80TOOP+HgMJ7Ni0RH+/BMV6CDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12182-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@mediatek.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52AB873218A

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 80791e30aec2..4dbe84954de6 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -828,11 +828,8 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 		err = devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
 				       mtk_cqdma_irq, 0, dev_name(&pdev->dev),
 				       cqdma);
-		if (err) {
-			dev_err(&pdev->dev,
-				"request_irq failed with err %d\n", err);
+		if (err)
 			return -EINVAL;
-		}
 	}
 
 	/* allocate resource for VCs */
-- 
2.34.1


