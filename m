Return-Path: <dmaengine+bounces-1292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E27875542
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BA0B24D73
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7D13175D;
	Thu,  7 Mar 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PIKj2kD0"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030A131E28;
	Thu,  7 Mar 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832803; cv=fail; b=gIZ4yjinsjFe5adZfRUqkwM2++6fvqb8M6nxRVKwrWoyEfRDsTpZiD9gbpxZerOCTH6KPryxMkV9p2xsE+MUGR2OzxIJnwXDRrnlxsWHFw0WUybQSrjfixdu3Yjm0BWG6vGOFqfeqZHXV+vEfYhEcJz9M55jv7ltlrJ97wQHRpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832803; c=relaxed/simple;
	bh=aq2/ULP0Acqkl5nMyq60djlyfH/8ofMH5hwkVDWJ9JM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WVo/AXexcw3qevEp0v+THmJoGF31VMUcbsiya8PEtDz3syu6k/fwTYGSA+MtnBIdeZmr75h1dl2lm3lesmQLIXFgJvELT1KUo0ooRbtHwo/+zSyDltnq/6f7CKxkJwun/BVhH9dOMZNeGSKbeNlwS0f4Z+vXMPEqecfTqAfYwEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PIKj2kD0; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEzRHmAu5Oje3Tc72UHwMczc0sIPkj8424hqtAoBeADsjVXdZgkybx1vWD+CMU4lVdQTqjaqXDNpfVM969UeRPJHFBy3l+0rFVrABzTmGU/IFEWd42qEA6koQXiPxvqoYFa/qheXtprIo7R8JEqom8T+fVnXaWC/aG5Xd46mVtGjqmgmsTZCJIpjEDw6jFpYMJq6W7Rhj7XysXfjdD49FxrK3zqKVGNSoV0BxbxQQm76aQMHjQtg/Tncq19MkQYJOfGtgaPHI5WL7KdY+02tyH/1ctqQzaIKzBv2rHiMlFqXod4Khee2l7YGvF7Os1geDM4Z73re5BrykebJbJBdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=BI/ftbIkCZFDMvteffGCJGIrGO+xaeyT/mF0Kj5K7HwCzfpDzWh155t2NDqbEp07WMrXAXkXAC19uVe9Uc8nXKagaqf8pSmZCKCMep1EF6Dat2f1JCHH+BGG+VqgfwxLPiKt0OJT4lRo9W5cWHf0gUSMG7VfVs8ahsJSmBb2oXwY9rQJqvNcxeUqTDyYkA6RWyT/gAv+y+j7S4dKrf9XDqXjoO6nhCjL5Rt3OrtDoWO+aJfq6GoKJcQYulHEs3KlQnGJx+5wAQttAw4eKpcDXwjvEDJ9oeBWAJiShuYQQtu4gSnVFzOixuezqECHMJPabrg7E32y0L81DY+6EyKC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GroNJye/Yehgv2tou8mx9qaw1VtXSIYv09vStwtBzqQ=;
 b=PIKj2kD0qY4D/jdnZbWxJiADccOLuRQckyDfMV1MX2h08JhVaYjAusfmOoXA6w9W8MaY0+6wcu52Pm/fva7nnbp2+C8utO+YCDy17Dcix+6TQp42ot/ixCSrGmp/H3V6zGQT5k37n56WzFVANDfDTPyBZTqOLILERyvrcK6gyCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:33:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:33:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 12:32:42 -0500
Subject: [PATCH v2 2/4] dmaengine: imx-sdma: Support 24bit/3bytes for sg
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-sdma_upstream-v2-2-e97305a43cf5@nxp.com>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709832785; l=1279;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ve4814/ESKVFolOyuQukJbgmItKlbc7RUUIpEOw+Jo=;
 b=oiSNAweI9pK5PjDsiEYAfea6educhkAluVrdg7wVZ6flvR/h2YaJrZsErH1nmDDhHei4VJP9V
 Tdtp/jdQxKtALbDb419l9RFE7cSsMuxk1CYAcAaStp/MsMVJVUSTDD+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: f2473f0a-ae7e-4a1b-a87d-08dc3eccad1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MgT584bJs0rJgBhSRx8KSgUDTlDzmTtHX2OUXjmSurLBI255gOHNAG9m5Qb2x4yD/pmNjdTzjUNrHRe8Ywf/KX3NGqenoQ166QCJ6BzqU8q0zH6/PPxli91AFmqoffrHIyTvqpG2pO4bQRq4+rFIUqH0AAD66zaIxXOW4IVGj7ZutDSjkzRSGqnQyr3JHItbkKZmrj/9AMrz2UV4YsijCJULIA/EbmsYkSRaWwPPbadp8uT8HYmHDPPtkoBqEbYl2Nsrg+7WILm7u5O5+YbAk3ilJ4IZvdWyudyLMaP2/F371YIuHMfAVxmrkeRGFrJwA4Edec7VaU6XMC3Y5Edtg+KRaKPf5SP9HrPGkZmkFqjUdecFUv48HfxvtkG6J/kfpWeOCk6zJmR7X34UWQ8PPl5R/VSJ0kxRl1AKSjvKaPd8LXwGAVTIpt6BK9qM6ROcWTITxY+5mI85qtbk2UYTcljy24IPAiya6dN3J6wKWAGlcfSwXHthKi2opLtl9EjGmjOGIYxg7wKbRNUMxaeOr6yKhuExsN5SkFiwoIsJ95RPURG75UFnXdYhTi5Ta4XulAUKiVhK05uX/HdZxuvKFioxZ1rj8c+akTN/aRnpar434JK3rEjpD8bpqepCAtP1PYy3a23H93hyPPNg2Ij1PGP0zC0uCeMXpcUyh3WWQFxYkN2ONTbZzDlXIna83yADJAQmrBkRbzmYAlzULmK/B1NrE2SRjwQPpccqQo0HlK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlkOFM4MlJ5VXNHTUk1Qmd3aVludDU4STZpeTE4ajhOZVNkd2U3RDRVaUFJ?=
 =?utf-8?B?UjFrWVNaOHJVWlZ6N3dOcjRXQ0E2NHhCUitCdEZXNFZxT2xzVS9zTUh5OG1S?=
 =?utf-8?B?cVg5aDgwaDhQMW9JQUtwdFl5clkxN2kwNGdDcUNqMzFUOTdzaTgvZzRxcEdh?=
 =?utf-8?B?NGZjM2x2RjhTdldFY3JDRmRMcHBLYzRSbThoTE92QkpscFZ5Y0o5VjZQL3NS?=
 =?utf-8?B?QTBRSXBBbkE5cGNkUWN6NytzZ2lJaFlaUTRsMXBDU3EwSFVmUjhnYktwUWdi?=
 =?utf-8?B?b1FQSFdlanB0VHl0a2ZNSGI4WGt6SHFRTUFxdGxoQ21pU2E0Q1ZHRUJsK0tv?=
 =?utf-8?B?R3AvaVIyZEJpK05oMW1kVGNXSVdkUHBEVjk1aXBqR2dmdmhqTjE4eFJRSld4?=
 =?utf-8?B?N2I4NlVxWVFjNXBxUllJUFFoV1orbDNUVlR5ZWVDOC9yQ21BWGQ1SFFsWWZC?=
 =?utf-8?B?T2J3NWEyRnNJQkJ0bG1xMmJrVENFWktjWUIxQVdsaERQNjErRUVmdDd4M3Nv?=
 =?utf-8?B?ODJ0Q1pTWjVQMi9maWYrckdLVDFCSUx0U1N0eEVDT1c0R0RBMkFPUmNUUHVW?=
 =?utf-8?B?VFFiN1RCUDczSUNIb2dORHpzbnBpc0dNR0pnVDlTaDJkRGUraFZNeFlKSjhN?=
 =?utf-8?B?R0NoanU0UnRJSmQwWlFxZFRTaEJUdVRSbFppbFgwaE1PTEpnVTExNWZQMHE3?=
 =?utf-8?B?YzRQQVFnb3Z1anIzamFlb00xQ3VZcWpCaitmOUpJRXF5RXdQMzRvSFRFdzZw?=
 =?utf-8?B?dzdwN1V4WEY5QjhMMlgvRnNPa0dBSFRYQWNDQndtMWlMTG81dVJLNTlqV0pR?=
 =?utf-8?B?RzRxSmpJU2FMTGJCMU9mK3FYbGdDM2FBM01QbUxObER4UE1mTnhKd1piTjEv?=
 =?utf-8?B?ek5lRUdQNW9QOFZncDR1dmZQRzg5eHJXVUV1bDlUeVMvMVpzQUt4cUUrWEJx?=
 =?utf-8?B?SzFhdk1uWUR5OU1Dbkk2aGE4dzVFejdYL0wrNXVMZDBBYk9kUjlyeDkwb0Nq?=
 =?utf-8?B?TGNnMC9jMnR1TFh0aFNQUll5RllBN0ZRQWJnZzM1M2xHcXJURm9DTDFwZ0hE?=
 =?utf-8?B?QTFYSjRRUnZlRUR5eEdSWGRQZDg3a0VLWDVlb1ZoellOcVdIMWxFaFFXTms4?=
 =?utf-8?B?eVo4cVJ1di9henhsUEZ6S1RRU2NNLzZrbThTVW9ERHdNNUEvTTBNUDk3MThh?=
 =?utf-8?B?NXluVHBOMnd2L0Y4WXQ0b2tzcVVxT3R3R2xxcXJYeEFOTnM4NW5LQXRvSTlP?=
 =?utf-8?B?ZGx6ZUUvb2lVR0NBdXJCY2NBQzBZQ0hIQTFvZFYvcGxHZXRMTktYUVpxNUt5?=
 =?utf-8?B?aUxJSTFDeGtjaEZsbTNDY0JPNmhxWXY1R24ySms1V0NpT05oQWpuM0FaM3py?=
 =?utf-8?B?TWNSWkpYUGxSQ05BS1pDL0s4Mzh6SGlIWVI3SFIxbWh4ZXgrMmpwR0lmeTEz?=
 =?utf-8?B?MUJaSVdCbGlEZlRmSFE3NFd3c082RFZXWGhBNEtubzRSVXFvYU54ZTJUT3di?=
 =?utf-8?B?ZkhjM1lheTVjRFVaenMrdFpaeWc3bSsyeFdrM2tsNzRPK2gzcUZMOVBCZ0VQ?=
 =?utf-8?B?TkY0K0NUSHdVcEsrOE9NZGJJOGVVODVqOS9GYktuSlhlU1VBdG0xVjZYb3FK?=
 =?utf-8?B?V3Fhc0dpbFVBNStWS1d0SVc3RzNleTVUSHBWbXZoSUY4d3NsVERqUUt3L1By?=
 =?utf-8?B?S3FXUkdoRUJJekRJY0hPdGFBNlh1QmxKM1lya3ZoaGVWcTFnNTFMNG0zbFA5?=
 =?utf-8?B?REhtaUFGUUpPaDczT0tLR2trQk4rbHpWSXlaRmtaRHBuM3lNTThDc2Q0QTNC?=
 =?utf-8?B?alBtYmw4TWtqcWcvWUEzYmJCSGFuMG1mbWcxcnUxWVNGeXVYZWMyRkFIUmdo?=
 =?utf-8?B?TnJpZE5Sd08wanFLakRQRjlBdXN6K3FJbnluREtaaml0Z3BGc1AwRTBHV0RG?=
 =?utf-8?B?TnBURlN2SHF6QUYzQU9ka0pvVEhnRGtIQ0cxSldNSGJ0VmRmeUJ3QWM2SUNp?=
 =?utf-8?B?dzVjbmtCRDBMN2g2bHRGZVpGQVdsZEwzSFVySDBuTkcrQ2E5QzJHWVB0dXNH?=
 =?utf-8?B?T25mRW8yY25UVlNxOCtaL2hZUldsK2l4bHR0aDJXd2s1TGpSc2RCSEh3UEVC?=
 =?utf-8?Q?mKnpKuc/OONoJArxl54UAfTmy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2473f0a-ae7e-4a1b-a87d-08dc3eccad1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:33:18.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g1pEho6wjENpIbklSP1JJJiRywSbvdyNvNIr+Z6yO8koPSS2A8jh1mkcNHYcdW3ORcjAjkzgIEDpgRMTPIxow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update 3bytes buswidth that is supported by sdma.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
Acked-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4f1a9d1b152d6..6be4c1e441266 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -176,6 +176,7 @@
 
 #define SDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 #define SDMA_DMA_DIRECTIONS	(BIT(DMA_DEV_TO_MEM) | \
@@ -1658,6 +1659,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			if (count & 3 || sg->dma_address & 3)
 				goto err_bd_out;
 			break;
+		case DMA_SLAVE_BUSWIDTH_3_BYTES:
+			bd->mode.command = 3;
+			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)

-- 
2.34.1


