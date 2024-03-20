Return-Path: <dmaengine+bounces-1457-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4C881801
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5BC1F23CA0
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0385952;
	Wed, 20 Mar 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZ13dJKv"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45358592E;
	Wed, 20 Mar 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963602; cv=fail; b=gLOjND5r6uxbMspfihYaKqchCqjxWNWX1lgqKoQP59UxFreyZBtsZkwvJLWyV+G9Z58LdxXWhkNY/AOzNPzPxv8bgF9LlFqIGr/x03DJvETrL9s87JihemtyjK0BfZ529m2Yx9o0mJqLbQ81pptn7sRJyiX6ANCSXonN2CrYXY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963602; c=relaxed/simple;
	bh=PM+2i/0mOaaCSuGjf/8vF0iv8tBZkwUTW+fJPBRs1I0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n/9FlWLKeA59RZBkghRbjOvm+tietu8wnptry6ObzXYoq9f+Xiue4YajT2suK/rLfwUhB9P2IYIN0g2Ly74wjlKgeUI7VdQ0wxyTsHzTR6aO7Sa9E/pW1dXh36K9MJH6i7OvQSomAvyDGcQB0uVy3i9CSEWrJdskgO2a2F3nTlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UZ13dJKv; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1yKFP5aECFksNcr2Ha1qBuPVJAk+PDy4npB0bhVyN6aNjIVovK6pnxXH2k24PHo6jn7R/bJbeGNwQdN+TmhgHXZCmnB+COiozUHL6qXADojH+tuYrzPuXhfPjCGEmHZIRmQKPDZJNlJvnPnEL2ujQ+gTMc3EVs49Tz9KJfAZgyU0J9L93S7EpGj+Kq5c2+2ZmLRtpGgKpFUq/OuNSyVfRK7r+ZabKwNNPDB3zDVoAeYMKZiTe1I7LHDglelXBD7ZO7YhuTNTzq7KdKm19MMuYbc9XLukHsalZ2GghO5LCuvVTqYcgLiaCes5G6wnHNpGKK4GdoNfhdvYWEqcwmUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti2uGerYJpXRpmSl/dtZN+v2nK4MazVUHmqKDC7W08s=;
 b=Ykrkxo4cywAXGKhAgLBgkWkox9kU0xkQ48OoWvThoP+XwrdFB2B3WRidfzPlYcX0InI/NdMqvXsrhCfOb981x1dXA3FMySTbeWrRL6arAKST9+Nr7b2XE1C4YKymLs6AxkJQv8rV1X52EgHFnE78witNlobvUAKilxoYdVvjSC0XqY98Xv4+A0tQK4Ouv/XHroCugjAM00k6yD8DZtmoxJseGKGGVfjp4hpgnyDMEjRwkDMPoBAeAYxnTs7ovgFdHfGD5IwhIVESmdXown2X2iZzlvrgR9ztIYJZa3UF4LjVRUb2wpU5COC/bzQ0w0FKLGhi+yrEAudaZghwa4w4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti2uGerYJpXRpmSl/dtZN+v2nK4MazVUHmqKDC7W08s=;
 b=UZ13dJKvGfzrOkc+nYKWtZ1LDvgTrrclJ2TwEwiQWvV7MduFdWGrrm2uz1jTpLnUAvxQzsRUMTQ/WuuAje6vJ5dalhFjw+La/zsNulFinSURCD31dTHkhNJTXGiZ+T9ULxaJvUNFL3C7ceC5y6nJjakcG+93DdvWAh45MQEMuds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10176.eurprd04.prod.outlook.com (2603:10a6:800:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 19:39:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:39:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Mar 2024 15:39:21 -0400
Subject: [PATCH 3/4] dmaengine: fsl-dpaa2-qdma: Add dpdmai_cmd_open
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-dpaa2-v1-3-eb56e47c94ec@nxp.com>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
In-Reply-To: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710963589; l=1399;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PM+2i/0mOaaCSuGjf/8vF0iv8tBZkwUTW+fJPBRs1I0=;
 b=TqoZIUsA9kvg53jtUQ6UoU/ux9iNpnUdiNAeAn0xiynQr4UaZaKbE4820PeCCY3JwRpx6oZsr
 iLtN7M+p3sjASBrgFKOt6CrPDAfYRlLDQAh9ru2umlwwLzmNIF3dDd3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10176:EE_
X-MS-Office365-Filtering-Correlation-Id: 264e8227-3b95-4006-f8d4-08dc49158592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNZnGBFRBU32OkG+UswjQSKPxiG7UcfmjgcxSYAGdxXrel47qUzUWFUm23UY+Fr4jb7W01ZwlhJri3Uun6sXtT4Ra/EGbsD/oVDhuU24x1ldCLQnqKPVApcIW6hg7LqFtxcKQEE5c2ey93TEBPLIl0k7f3TGv8ErkPXJqDFR0Zq/bimV+yMYutufzNML0n50YFCSPYi2XNw0ZAQp4LS6XGIkBwomVz6rl5+D+Hp2tmD37pAIokDEQqQXJ+ZIYdZuXtsg1Q5uVSSAUqBPfY14T/UdWbihJQmPlnPpFR8oHgy4Zl+lZQLNNocHcwgU3Z5L3xWyGXeavESf7Qj957Bj5THBGDgkUAMoG3aSeB579/Oz62K5skYByEzje/Wv03XDyFYbK7kaUD6GOL9J+JOtXF0N04PTeh/BAWqXzUvhhYCda4vSC767ub5pK+EAjyJaiNmvKWaso36hdimUF4MBZ/3kDKsgefKZ5fmWlpc9pBNyyEg58xHmzUvwQ1qJ/fkLXCIk+ep+SojsX5n5QIGPNiogs1jcdbWinZsEKXP7duTJANbd1gdyxlfK4TRLTmkid7czHnSNcX5P9VNuYK7BZ6aOERjhAmiRBHyOk3fY6FCssKdKUD6IojyOWySs80/b6jI/yavaIpSjwGaYrcUHKSbY4isu5XHtALd529c0fb3b9eGGxXAF0VhpmIA9QzNp0wshwZaMQ4jl9wY54TnaXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3AxUVk0NjkwOFVscHFxYVFDaVFCYnlJbDhoZ3czbDJHQWIzWmJJQjJQM2xu?=
 =?utf-8?B?cnVIRHY4K3QrZ1Y3QWlyRUdVbXpOL043UXd4MFpzK1ZKc0FCRmFFdnBMbGl4?=
 =?utf-8?B?WW0yUDRFak8wUkhvQlIwVU5JYktNUGsvQnVmNUZJb3J5dGRwVEpSTWpJUnRJ?=
 =?utf-8?B?WldKdFZlbzNERlVLTGlTQUxodnlNZVdQc3dhRHd3ODFwL2lTYlh1T1hxaWFi?=
 =?utf-8?B?QkY2SEdLWkw0bHV5WE1HQkdjTnhERUhXRGhXTHZUSkIwdWtqT1ludzlEM1dL?=
 =?utf-8?B?TklvZkRWYnVmeXc3cXd4VlhsVGhNZ1NFSG9YR1VIUnFTYUptUWNMdXg2N2dq?=
 =?utf-8?B?ZVNxL1RQQUp4RHhBS05zVzFxdktlWklldlBpdUVMdWd0Y0VtRXplNUpWZXNS?=
 =?utf-8?B?U2JOM2t5dzhIWktONTN4ZjlDS1NLU1g1cnYzYmNvUWQyWGlhWXg2TGxrdW13?=
 =?utf-8?B?WVlYMUJIT0xub2Z4SWt3RmxsM0dHSmhDU0hmcXRUeWUxQU1HakM4M1hHNlF0?=
 =?utf-8?B?TVVaa0ovcWNlTFRtb3F6UWtiNkVkSThEYU9TUERkbDF0aXhaMmNkcUtJYjVy?=
 =?utf-8?B?cnlpSE5NbFBUVkIxWWhzc2tiV0tsK29YYXdpb2hWN0w1aUtjSXpweXFSYUNB?=
 =?utf-8?B?eU93UDJsNVpYb0Nqc2JxYnJ4anRGMEQ1dFBranB6SjV3Tm1jSzZaODFKS1lZ?=
 =?utf-8?B?Vnd3S29INU5NL09raDRaR2E3bjE5ZnNDTkxQaHBKTjFJM2x4eGdEYnpvcHZ5?=
 =?utf-8?B?WUNBZVRVMWR3UkhmUnhaV0ZPTXRLL1JQeFdDcXJOMFlpS0M4WnpFRVJsRXNt?=
 =?utf-8?B?NzJkbFg3WkxPVTFMM25vMS9kTWhXV3VkQytpREVNNmhCcGFsd0hOVU5Fdys2?=
 =?utf-8?B?TGE2emZXQThJZkdicG96UVlYV3pmcFFvZjJUZ1BxbnVKMmRKRGxkbnBueDRl?=
 =?utf-8?B?TFlBMXhhWmZKVDVtbmViaGxsQ2JZelN1eHY3RHNncnEvYy83YWRqVms3Rmt3?=
 =?utf-8?B?eDJ2WnRkSFBiTE10WDNkZ0dFMllyK3pkaWJNNFVZenlha3RPZXcwSXYzVmFM?=
 =?utf-8?B?SSt6eGR3aE03VnNYbDBicGw5WmZudjNjWnJsdUt5NDF3WkhrYTZtUXlTNlps?=
 =?utf-8?B?U3k1b2tCQVNnWFpRcVJRMGFENisxZS9sd3UrVVRuL21Ma3V4UWltYmRPdXlN?=
 =?utf-8?B?UzY4aFFOM1NjNUlHdnJQbW1hejJ3SHJadTgzc3hyV0todm5ZS21IUk1UZHBw?=
 =?utf-8?B?STcyWjMxUHg3TVExaHNxalUzWjRwY0dlbVpXSmJoQ3AwWGNQbGRmbEQxMENv?=
 =?utf-8?B?R0kybnBsbFVtYWNaSkJ6NkZDSFh4cXFCZXJCeE1oWHBjTGVwV3NKZi9zNTlV?=
 =?utf-8?B?czdqZFhuUmhDWjNTUUV5aDNVY3cxV2Y3UnI2aCs3aVJmay9EN0JHNXRkalIw?=
 =?utf-8?B?OWtvY3JpNi9HRHRJR2c3V2tWOURjbEt2Yy9NK3djamtiZGN2YmhEektzcHlS?=
 =?utf-8?B?OTdlWGpGSGtsbW9rZ2ZuY3hIYSsycmoxMjVjZHdRSW9NUzhVemQ2YjFOY01N?=
 =?utf-8?B?UytGN0ZqSzdNcUhSaEZtdW5uV1BuQlIyRjB0dHQzS0k5ZTE1SjRyYWorRHY2?=
 =?utf-8?B?UmpTRlJpUk5yN0QxLzJOQ0tFc0IyQVVESHA0OElVNzJ0Y1RReHJQSDR3UmVk?=
 =?utf-8?B?dGxxM1paRW50RldqYWhaV21QN3JCLy9zQVh6a2YxdkwwZ1dKZHVCV0pKZXpv?=
 =?utf-8?B?VkxiQkJrQ2tHV0hBbXovQW9wcS9HNDVWb2dpNmJaRS93cDdYZ3hBMGVqOTlh?=
 =?utf-8?B?MXBucjhVb3pIaS83WWMveW5TSXMrY3c4eUFJM3IwWG8rZUxFMURLWlFEeGZ0?=
 =?utf-8?B?WldBVDdNcW5aaW1GVkVJejFOUjJydzBxOXhkSXFNTGtwVXh6ZDhrVnZrcnFW?=
 =?utf-8?B?L3Via3Z6K1JMYmlMZWZ0YzhLYXRGYk1qbHVUYTlTcnpmaUJBSjYwTndJWlNk?=
 =?utf-8?B?YWV1elRuZ0VOMUp4STBqMUlIVUMwVUZhTXFUT2ZqTFZ3V1JrdVMvTG5qcjNX?=
 =?utf-8?B?REt4YUdYRTFUZUU0ZExPVTJ0Y0pDa0l3c25rOG93QUNQR3l2VDExc0h6NUFr?=
 =?utf-8?Q?DWdzezGNUqDOSKzsHzaPkTTIs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264e8227-3b95-4006-f8d4-08dc49158592
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:39:56.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtLY4CiU9xcb5rIqUagsIB8icaRUheG6gLtEQLK7tU2oYuzmn93gtUksyNKR+wovi3zkTItfXWnT7+B1o/538Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10176

Introduce the structures dpdmai_cmd_open to maintain consistency within the
API calls of the driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index 66a3953f0e3b1..610f6231835a8 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -33,6 +33,10 @@ struct dpdmai_rsp_get_tx_queue {
 	__le32 fqid;
 };
 
+struct dpdmai_cmd_open {
+	__le32 dpdmai_id;
+} __packed;
+
 static inline u64 mc_enc(int lsoffset, int width, u64 val)
 {
 	return (val & MAKE_UMASK64(width)) << lsoffset;
@@ -58,16 +62,16 @@ static inline u64 mc_enc(int lsoffset, int width, u64 val)
 int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		int dpdmai_id, u16 *token)
 {
+	struct dpdmai_cmd_open *cmd_params;
 	struct fsl_mc_command cmd = { 0 };
-	__le64 *cmd_dpdmai_id;
 	int err;
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_OPEN,
 					  cmd_flags, 0);
 
-	cmd_dpdmai_id = cmd.params;
-	*cmd_dpdmai_id = cpu_to_le32(dpdmai_id);
+	cmd_params = (struct dpdmai_cmd_open *)&cmd.params;
+	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);

-- 
2.34.1


