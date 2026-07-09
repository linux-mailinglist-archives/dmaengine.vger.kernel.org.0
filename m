Return-Path: <dmaengine+bounces-12178-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4VrN+qqT2qumQIAu9opvQ
	(envelope-from <dmaengine+bounces-12178-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:06:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D95A731FA5
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:06:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=QZY6+bn3;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12178-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12178-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156AF30D7476
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E36411671;
	Thu,  9 Jul 2026 13:59:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4973F8250;
	Thu,  9 Jul 2026 13:59:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605550; cv=fail; b=gKMXtUC4nYpAB2Xh2JDyG13jzI7ULbOIyhgFq6t7Ei4EGQTsR24oypEkvKt2EYC0CeoiqPRZydg0ZXOSiJ1RUCCc11ogrK3tiVBMTcmyCsuDoLID0o0acOlrf3NLl9opVtyLFInB8Sw+urayffHMYoTpq5bKAhHP59Z31cPY79A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605550; c=relaxed/simple;
	bh=P7xRtXaxvLjgSAkDqj0fKFzvI11p4ta+qnvy6Adx2l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=It5gF9i9ccOSduzS+69fhVPXcN+ydDaWYdi8MlOmI+ZnZK3wcIIjJ1DsR0K2j+7aRf3wvq2MpBG/utme9IDW2hGbW7odQvRIN7i4UvfO58tEf5QwfxrajVEiw2zuw/SS00U5hokj49cLeZnTpKr+SAOfLh+rIYJSslPfNQLL1II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QZY6+bn3; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoXxFW8MJDnQU6m7Br11W1bE74EyTXXRWEiY0G40Px4WITwfQtDez7K2ldiAvYnpGXmLLEIIk8rEd5Jz0vzZvj7zn9CSK0I72aePla59pDtLJUdGiveVdsoKDyq6oySPFKTqtUPslgnseXG8H0869OXS6smDJUpGyx1TtOMhfz8lR/G7ZvOsQkXSacmFmikFKV3UfFa+OA3cnkmEey3LEFY/VFlJkbl8IzXnWVjcHJzksMcXubvy9fxwQWlUWoiQlrnkrL7WwhJNEzvO22D5TpNMO9jYOavcH1Op/cucAxzx9R5eGri/96UhhPDL6qW+XLTcc8CZy2bpwJS9/eSBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRVmYLEemak0mgUs6j7oxQc/jAulWHC9Rp+dOVbsfS4=;
 b=wS8VIR/L+k6J2oob/nYIkwqJS5LinIx8wcaTQHB7M1oJf90nWE5+p2SN4NudcFAT+mTxpLAuvVaYoA1mEiJ+Rb/DnwoelRnXhwq+4ohYLWSkPWGCTQKg07X6vFVPZ2+TlnlddOcQ0UZ+9X74rZOZJpnzznADvfoAkSHV1v8VSYoeNNABAvfkO489sEJkx4OHdVQhjoBWGWms85FX7EdH6myoryXfPRh8dUhQo7wnxVsb/W+Mlp07wzNHgs9D7r4B9hik1N34RVXPO8kX3SuIR6OKJ/XexmDjyGh45M+ZXoA/L0KRomW7BmE4pZ7zii+gxq3Iar2ie5TNB+IlqF1nCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRVmYLEemak0mgUs6j7oxQc/jAulWHC9Rp+dOVbsfS4=;
 b=QZY6+bn3SW5kQJMijLtFtLuPdl+bwLP2soFTiD3dweuBpjvmW70V+aARtCmlg5iP9jCpsmDj2J/uQXCIiJZyrtAOJ7erJlUhWFhNUG5tVWJeMgABk1q+VK/ftlOxCOoENVDNAKwhyPJ9B8JOjXSG68jbA9OFO6Zwlg2Lx03s/cFAWWLn4zMNqbWbPiqKi0SzxouC7ayDwbw+mvs0fNIt/36XZ29nYaYt7AJDM2N+xKs5N7Y+NcQPpgZPDATFTPE3Js9TJTHMc1BPFt9gz9Au+CfbvyJUM3Pa7aZR6gKuVs4EmcQoOYra1U+puEB5PktFixRQMIzW395e/wDnTIsq8A==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 01/26] dmaengine: fsl-edma-main: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:05 +0800
Message-Id: <20260709135846.97972-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a199eed2-a4af-421c-3273-08deddc23c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	YLF/02rUSNy9vUBkMzaSXZ5L8rfzxDoyl82SWcbLhKPYinKBDcHD7pSxHDE5cW1xm/GFT5Lt6DZoAnuVqrWxQXV7IVEqLufW+TutJdmMLVr9yANMRyNZ5iheDN4NaQjMNrRmAiG+WUWnC12fX0XZ3oBggV4AUQhw0zL5Fc6C0MU28flWmxZG5AdvERW8eE8A14hzoyeha8yP5z7JgNka2cLaE20fS4nRnvGRkq4w5+esUuJCql9XRi0YMFNLhFuwgv8HnkVEAL4bFxrn+IozaE5dPZfVf60klofhf5sjsKWrvgQEzEYkoNzA9OjGEjAuadxkPw0TWmSu/gCTvwd0TwqMpbPGoTRnpf7LSZLCh599MwhpLZVn1A7DYQyNR5MYdbELwFhh40oCOPq2V5IeKH8+1dNJAZFxZ+1pFCn3bR4RlxYyjdZBo2rkCm3ApQwi6q0JBWlxYbhVWazLdtpWZNawpQjerm3Knv4mhfagoF4dgBcShqdXy7s4dYI3+6xWKShDuMpGfdCqeWv7VLPncixe1wQZIbPgglYjjIE1uNOJSnlyR/mt4HmpjP8LFSuF11Aa0oLOgTNVR2YdmfxUiL19vbdwLYlcNI7TA7fLxquCMJ5nexsPiWik6HGv6DW48DLEtj9Ab/hRYXCSWmO29cVugatGZ6glL6r05ggm/h3/LNXEFjIqG+u6ymDYv5nk6iKpqOT5ghJvsCk3Do8VEwr9Q4yFk404Mhw7gBx54Vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqdCc45c46mQi4ntN1UWIcn0lca3nV+HpXdIf9biVvzXovJ5Ka09e5QNCFjV?=
 =?us-ascii?Q?554WRp/Jv+okZGEahZbVJZHyhSftbeo9WJgatH6QNicb15RMlLLeHQ4av/cy?=
 =?us-ascii?Q?buSZzsZc+jatMpnW/1os+1mBr64Q2vGNtyICsmIID+TJCimUD7OKYDz3r4Ba?=
 =?us-ascii?Q?r0Myp4BiwNBJ+oU/1C2qS0iVqlu0SFgTAbeI4GNOPjDW6jE5uIUb6IW0zABL?=
 =?us-ascii?Q?K22YBLRfj6b/aK3lkaBcRZ7+fkr2JqTNiaxkd53rxrSH6jGxSPGm/4UB2q0w?=
 =?us-ascii?Q?3gnRY+dpL0vjEu9ZnDADs+pT4SbrOOqng7EpWXqi/jczJi0s3u0jDhn6MIXZ?=
 =?us-ascii?Q?8LnVUE8PO8THJDpTrn836trMFI14ABULL6kp2IGXDr8r05sFSL1rTA7JCbe0?=
 =?us-ascii?Q?4vMope1nfGFVy6+/K+ORnPHZMoH9ZV9ehd3WbDOTi2ZWz0LfLUAoJIA44BgV?=
 =?us-ascii?Q?QsC7qKfKD7gcRGWhyKjcMShIwITUDyo26c1zhHNdZxQxhSjwKlOcxzSUrbcn?=
 =?us-ascii?Q?MZLqRS3RVm0WrS2I4Xvuv1+ZZHNyC1xwaZ6PsCgp7w21DtnTKyZ7c8vKId/e?=
 =?us-ascii?Q?039ycu2zLdgjmCucbH7dVtX1/LzhQ4WiGjGDTqimcS/h5gp5HzmrB3WFo6xX?=
 =?us-ascii?Q?0rH/qjfkcE27EOQ0Zf4AJeDhDkCqv4aaYEPl46w1hyq9TeNR9sSNX+Ih+OM9?=
 =?us-ascii?Q?fA4DTbdYAF8V5Vt0FVi4Qq6C1iNL2DvczmTSPe9Mj3l9iZDlslUazInKVBgw?=
 =?us-ascii?Q?rkxvpm6Ux4O5ADKYDr3HcKxPivcKVMDGs69m2EQeOz7clD1CZCfv0yNRc8pG?=
 =?us-ascii?Q?71ogRfT4LO8ql54bUAm6tlmu/jBQH47ff5lOFiJXJ0mQHAnFyKIrJ7yqa0sU?=
 =?us-ascii?Q?V5KqdXCJl6Hdxjp2Zt/elfHNWP7EkiA4QYCO5zLS0ktLPy3SQCxUKe9zJnjr?=
 =?us-ascii?Q?8E4YCTE3J0zr8D/G1tgb3ETLqGNudmqxCYfnT+KMCmYCiZL5iF9GBehHDSdT?=
 =?us-ascii?Q?GWhPRNvS3LseBCSI1wUwfuSkkC9ufnUVrckzj5q/AcidBzH6hEY6Upd++Ayc?=
 =?us-ascii?Q?8WhATkvBOpFLXhzAYe3lkLGAD0N8X9UKLTn5aBsG9OKRnQ1VunKNcW+aWkMU?=
 =?us-ascii?Q?1LF1+Lw5oru1clM8X0f3isBfW/AGhM6S9OkWkH+5rlo+UvEUU56pvjR6H3Bn?=
 =?us-ascii?Q?sjTvL8a3Do0JsnYQkNNrdBhA1uAjiXwputdH4rqM0s19VZSoOwt//My9VONf?=
 =?us-ascii?Q?3a/S9MBE79r1I/uUa+WyO+dlDwFaiSd+a7VcgljV/oa24zSMFOEARo/5jJJf?=
 =?us-ascii?Q?3lrMBz+MxN9Hi5Y3H44jQ1n1GD6QABlqxJFmaAv8KU0BpwK9/z7eeD2yB8GF?=
 =?us-ascii?Q?bWnrObTMgyvEymF8b29Vzl12u3vngxSbYb4kxO01BxjZxBRCJHqk+jKt9AID?=
 =?us-ascii?Q?iPZ7gRyvWc4sJjzICKSWl03G/7uMOkKZ+N/360GGvo0UnW4TeKQ+Rq6OTyii?=
 =?us-ascii?Q?f+OI07GvdwuOATIXVPAvQvB+EBNZeZ9AAtfTd1u6FFVMvfSY+q/jPRnCGfyh?=
 =?us-ascii?Q?KzuL3nJCff3H4oZX/pFkaeY2AZDP7yK9IsQAhkeYtxBV/e4mrMr2+GB2nINU?=
 =?us-ascii?Q?pj3JOtCFX2GK//g20UONo9rUW0FSoR8+XMpdp9Kj/KccKDYu2vA+nvLQDqsG?=
 =?us-ascii?Q?XSYIshwBTjeFL+a966n/DYCAkOA4/+VN93azqdHJDSrBK3C5+rBRUhj26Mrp?=
 =?us-ascii?Q?AL6OYRlIbA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a199eed2-a4af-421c-3273-08deddc23c3a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:03.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5BXh2kV9ks504DB2s8mLY+TvJqoMcS9VjlS1el3HmQPLKyWl42f1rWYKSeLNMCRjisPE8GzEE8kuLMvBKpZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12178-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D95A731FA5

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/fsl-edma-main.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a..0881f4f36b3f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -357,24 +357,18 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	if (fsl_edma->txirq == fsl_edma->errirq) {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
 				fsl_edma_irq_handler, 0, "eDMA", fsl_edma);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register eDMA IRQ.\n");
+		if (ret)
 			return ret;
-		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
 				fsl_edma_tx_handler, 0, "eDMA tx", fsl_edma);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register eDMA tx IRQ.\n");
+		if (ret)
 			return ret;
-		}
 
 		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
 				fsl_edma_err_handler, 0, "eDMA err", fsl_edma);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register eDMA err IRQ.\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -418,7 +412,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
 				       0, errirq_name, fsl_edma);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret, "Can't register eDMA err IRQ.\n");
+			return ret;
 	}
 
 	return 0;
@@ -445,24 +439,21 @@ static int fsl_edma3_or_irq_init(struct platform_device *pdev,
 			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
 			       fsl_edma);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-			       "Can't register eDMA tx0_15 IRQ.\n");
+		return ret;
 
 	if (fsl_edma->n_chans > 16) {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
 				       fsl_edma3_tx_16_31_handler, 0,
 				       "eDMA tx16_31", fsl_edma);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					"Can't register eDMA tx16_31 IRQ.\n");
+			return ret;
 	}
 
 	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
 			       fsl_edma3_or_err_handler, 0, "eDMA err",
 			       fsl_edma);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Can't register eDMA err IRQ.\n");
+		return ret;
 
 	return 0;
 }
-- 
2.34.1


