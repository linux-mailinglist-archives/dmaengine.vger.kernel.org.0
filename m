Return-Path: <dmaengine+bounces-12183-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gk5iBqOrT2rsmQIAu9opvQ
	(envelope-from <dmaengine+bounces-12183-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:09:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC78732034
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:09:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=RZJ7tLnZ;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12183-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12183-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C883143D80
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652114279E2;
	Thu,  9 Jul 2026 13:59:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA842669C;
	Thu,  9 Jul 2026 13:59:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605559; cv=fail; b=gg9yFvNc8H2OHnxoEUZjdBP/cAyJ97yweVDcukiS1bPtRW6/tK5FQyRLpLNmeJpXmzxm+MbNW6FY3CFOMukJTqJxRgdn5Ym2I/XTWMOo6dKF25+jw1mTwpkbT1Qnu/rW8h2LHZmXYEeunRBJvP/eGv6EUus1xAq1zLdd1BDoJsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605559; c=relaxed/simple;
	bh=iAwqR5vmOYQFGIbK59iyWknhUbUY+Me5CcFLCEDECe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlPx9zsVyfxmmxVs7raFWr05V1j5GJV2jNJLHnVfNGxcaxiJDbAeUSsvo1fOAJd6Kcv+oJwH7fux8dKNbCyApgnggpuKGF3/P+ZIocuN5AhCTIYqknS5Abco9w81m96HbL2PFslguwdRGtC0NKcF3G3b7p6M5vfbV5DRrHH0DyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RZJ7tLnZ; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEi9sE9oNave31GeRmts9AxGWFoNmVURBV3l50GUX+p7BgUC2o1hj9HkBCoDJhWUYjE6/jjZC/oo1e1fRnIDk9B91ICKnd6cvZdiARLN5PUeoNZIyJU9pXVNafqYPu7irBT4g7eOWf+ZuhddG4ZqNg5KuUXeagcZuCmN7vSYss3qBhraMIdlJ1l6Lzg/pzNwQZt2tnMs6YD7tqz5KI6oq0JRDZUO11Bcd1OQuKeukXib4ylSpylJuG/OPRnRhALSdufhjTomPQAI4h4Lt9luEgBeorVRIMRjJmZxfGVd83WI3QBNkCrGieyIxPD1gdOIVPjI9X9tovS3ke/F6Wyqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODA/f4z7zt7qKFNm1vceoYw/QU4HYWrxEao7viGm+Uw=;
 b=ayNmBRTeGGFXYnnmO4iZevQhS8+lwy+bXCvl0CgtP2NBSKpSx5ugBSrXylqBSpc4NuPDojax1rQ9rD7YceC9clcFeWUXIzjPHs1yp0ZiIFFcZ+LXn8oP3EOJTBhcIS/9uLEWbDG6V5DSuXFAejEgGbbPGRmVklpovvaqD+FJDkSnq52nCaWZ6KVJPHuoIBdFmZqjGC0KFArItOYoOW6kRZ2IjbpW04hit/+nBntNZxlRDQn6OVlscG1iDnc63V76aL7g8erQW+w4A5NXiAe/cQR5vGCa2zrjJa2FGznRnSyWNL0yQVtSswEWpcAhmH8wswMAFpqWLyhak6ePt3LKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODA/f4z7zt7qKFNm1vceoYw/QU4HYWrxEao7viGm+Uw=;
 b=RZJ7tLnZf028oP5smEfsr8zh3bjyVWwHAaKXcOkNCJZZoY2p6A5dml5FSKeRqDoBBxOzV37irOCgwiDF28NxVBqLIATMpI+4IkHEa2SZGULBdOLk+JKCYCaTLLYK6GDcWZ704sXtnIzhNvZI/9AFIijaL1ytz5WKt49u1hBxXzzRZnSL9SKQr2qxvEpXyJ/j5JxeJ4FVyqakW5FAXgC+WMumEVCeSiS4REVOX+vWSrjZ8vMVB2P3IvMm4z31baIifLvFc4uXUua72Re/eeam08g/OXM4fV4jXk/mTg1jQ0riDXL6sucL6r6IPNHpFCyxwgb3F7FKkoqa+tDjEQZg2Q==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:09 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:09 +0000
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
Subject: [PATCH 05/26] dmaengine: mediatek-mtk-hsdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:09 +0800
Message-Id: <20260709135846.97972-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 148427b7-5777-45f5-433e-08deddc23f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Q39AcxEh7yUf5KjTk0VgXa/MYP+PHNJrthjvO3O/QXe5p/eHljPP8zEBB13kDBimFhSSWNPSjvctrQjAUeOP4naEHQi7esJ3NJfHQyP1TLEQ35gC/0+lvgGOdsxOb4FPtO9u1HmTVaEiUOSzWvUEdz0kzR70zABUJn2s8PeNlm+PWvTP1E5K46Z2JGDy6/f2jIs0tu7n115eFOyZ5PmQMnu6QCaHLMCEEwV8o+rXeN807iJUTRR45Kbzxi+a1hrveQ4eRzZBGTpKSy0Yi14jG7bRrgHF65LYAPmw3QM8Fe9kcjnNcO0n2tBf/KERS04EQrfoSO5bjmlXVfANAO5wuw/r/iLpDTsktn6z+TobuuA2CkV5KVwsmtn7b/G2g9KRaQahVw5KfsBC1SLg/HBLDdh1sgnt6FiFWeYpjhmLzqNJHrbLagi8aFr4q86BMt9ZMm/Zox9mF4R0cSF7Fh3UBJMFn1pSaWPEh4lE2ZYH8F3D6bJ7/rBRN5R03PA42GdsHBGO+o2JFU4a6kZFlO1i0cPC3qgh8ZWDE3S4SCzzpAQoUSr1eoxhxgFkeg6yjvbgaR5aSipFBja87MIl+WAMUf/KjRUtvnEZqUjChNJ8Qtvi52GKCTKQJ+CgMTTK33FKbj4O0GEFOJu3olUuj0LwgsYkOomwMlICjMWK0gsy7R3OV9enHs30nKQVuYI+IdWQJ8ar9dS5FZzBb8FWBV3KR3xI1F/x8Oez6bYgmPB4Me0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aij94grthyP+R7M2AE4bnumvLpllwYdnpTj7kdB0Gm0zBRdglm0eLD5/wxGA?=
 =?us-ascii?Q?gBT+7Zq3k0KNsm0MKmiOrHhUn1xnCzQZ0VUG0vv1+qYyQvXjrGRV1dniFgRM?=
 =?us-ascii?Q?jZisDmvCWkOQrmIMf9rFpobn+snYtowCWw3YiYYM03TRG9DP2HQBZ3eG+U+x?=
 =?us-ascii?Q?fObH2hjmt+vrZ4qeiL+snx+ryWTZeOfcA1wRmJnulwrlX05NdYQlA4ZQ4Eyc?=
 =?us-ascii?Q?vDvhBbMfSuK0en7kJKzFYc80YN86i4QOgMKanz7KlxY4U+mb+WbfhYftcX+T?=
 =?us-ascii?Q?pzLEgOfTNnXyM8m9qdgd68zfDQ7lHkLMu4Sh4Xirs9rr1QnfjXvCYRRc77sd?=
 =?us-ascii?Q?NH8jUWUihPGNHKO/Zb7l9S64Kz0n8jf4S+qtLY/xpMS/m5zgYQ3RAA+JFvGe?=
 =?us-ascii?Q?AGMldw6u0VgFqnfewxMy2Vn24zK5bm+OAWUQW8H/FY5yqz+zwcfThTFc4Qru?=
 =?us-ascii?Q?Lo4J7oE257GljFDpDj1f6aysBdOEW20yQfWW+inrLH/cL2o4vP6On+bojSee?=
 =?us-ascii?Q?8NWCVE8CU6e0SsGvFhOsbbdV6NZkEEM6GfTDZbNgaS+vuuncRbQ+Frz0CgE6?=
 =?us-ascii?Q?qDMtjaSiOG3hajnW8rTIvq5zaoGCXoC3BuZJfDImGfcM1U3oqpIe842g3g9K?=
 =?us-ascii?Q?tqxrTMKJWPb12YGaHh2rjZHK2D1kDIrPB78HndGRzWpjI27IrbH7R2PX3btj?=
 =?us-ascii?Q?bJeDK4/uuLCbLauJupr/Y6Ol02H3MiNhDJnNiQd0WGAI/Yk9OY1VeWgWE1hd?=
 =?us-ascii?Q?L0km3CdNP3S5ywcgXoXprfKBnFikhM5c4wzxSu8dwyv0y7++3XUUQDs6yqEM?=
 =?us-ascii?Q?/4gKQH0rFr+OOEk7IjBSLtUZjbg//xHxSsVE9I1PFZ3f3QQaG/hEPhnGzp47?=
 =?us-ascii?Q?OZT8vZjTZ8oLqQw7rtUxW+dz5SvJCGvLmCy60v5vPs6eIj8AU9zv3I7uB7Yt?=
 =?us-ascii?Q?ExhHvOaS6EKjmt0oNLLM4nMtSWlsB0YfZ5wlluzKCKZDI8OJqFhmTZYsElxt?=
 =?us-ascii?Q?nOdZCm1TI9AGplaESTdb7VvndJ0XPaPMy9ExlOxqSwj/6fPqV7sZajeFJm1F?=
 =?us-ascii?Q?JHX1GuamE0mZ3ZOTDzNh+pBcJ/oFZtlCJej2eN3ISpRc6LNCn/YBFMPo3AFj?=
 =?us-ascii?Q?diinmebwyIhTHeCoQS0uQtjRrF9RxIZZ2otvUH+s9qpLg1NVoLnnwfPs5of1?=
 =?us-ascii?Q?cV8cT3DuBNqxbggGtxl2UtXAt6Omi0F4ESBO7N4WoV/LsPaHUyzOh3GW9kjQ?=
 =?us-ascii?Q?f4hqBxBBBj5Kufd0I5xTXqaqHLNpaE3QgXa8BLgvratXXDo0PpHR7OdCtNin?=
 =?us-ascii?Q?moNDp0uBRx1ORYuSA1m3FvdbAj8wvYv8Eq5fWjMc5C0Xj/dRfEuaKru/aIMl?=
 =?us-ascii?Q?zitsiN4iR27vXZOdnp2TFRzOidjRAaRRrcmuM9H1aleLLVyv4JDdMdsNJJCV?=
 =?us-ascii?Q?hYHKeENtA7vYCiEygYwZpbmfyA3dWInL/v6BSaL8bvIVozj9amglqcd+DXuq?=
 =?us-ascii?Q?ZuB95V5WOnQQaXsqthqDu0jLxLSiKQiwlCKanT8ig/C6h6l10lDePWYJA5P1?=
 =?us-ascii?Q?aHmb4UqeY/xOkQFenkoBKDNvxMTbjVV4JKWDJBNQCsKr6bg/C3vM1MLrxxFH?=
 =?us-ascii?Q?5OHQ4222KMMKJcGGqJJh+sT5u2Z+SgwRoESgX9QefEyOOIGB7cW758UOMDUY?=
 =?us-ascii?Q?bStCdkfdCw/3PfGizfTcEDPsc/Nhl/xJcuzv0eRWCD/wonxrZy0B/NBJ2qB+?=
 =?us-ascii?Q?RknPwewc2A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148427b7-5777-45f5-433e-08deddc23f9d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:09.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSjnzeKESwIQ96UasZwvrZjDNYlEKMPfhX/ccO0a4SMX3v+ClHLariOucR7/plS7V92/YN1z49T2A3AneXpJ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12183-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FC78732034

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/mediatek/mtk-hsdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index a43412ff5edd..6ee8911c12e0 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -988,11 +988,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	err = devm_request_irq(&pdev->dev, hsdma->irq,
 			       mtk_hsdma_irq, 0,
 			       dev_name(&pdev->dev), hsdma);
-	if (err) {
-		dev_err(&pdev->dev,
-			"request_irq failed with err %d\n", err);
+	if (err)
 		goto err_free;
-	}
 
 	platform_set_drvdata(pdev, hsdma);
 
-- 
2.34.1


