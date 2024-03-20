Return-Path: <dmaengine+bounces-1458-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD780881802
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 20:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A43C2834B5
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC958595C;
	Wed, 20 Mar 2024 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMf5cx4n"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812185938;
	Wed, 20 Mar 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963603; cv=fail; b=M4Y7tuZLg+G2VSpuku7uZqG+5KCtJI0P2RpBjpP0rl5WpDv8gkKpdsSNtzPQVLDC7mBXlaJM3RnoKoCvc2fuQWjnrhJ+EBTQaARe6NmYhSqv0ewRonObuHTt1OP56jMR3Ec7JDpFFMZwRRxNUCzhNBaDKNNVShZi9pPVQYvPSGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963603; c=relaxed/simple;
	bh=ZonQkgN0drpydT9pv+4dLoZSXSV5xReCOgkLPNO8CeU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WqNOdi+ZmAF2L7n/kIUlwkyM25vyUJ1sQUl4ns9dgW3TqInJRTq92LNXO7dcbBbUtA5OaIjyKsBT7iEz5qe1ZhVBngsZ144+82riqF6NWiDrEELHWjIc6TcI6GrBP5aEPBB1qQGo14beUuhmL7BQs66XNYrP78wPHeYm9kvk2xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JMf5cx4n; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLiaU7gwRroem87dnCxkq0fxyXT/mGb+Klt1wW7XAAmldgHAFXHCAl/2D6J/jXbiUPdn7ONGDBCBPCKOpGmPmfKfM8T2AgJ3VH4VSM3E3fvatQZzA3J4myCg0GdG7lUGi36s1UqZYDPIcv76/mrS/Lj5mwxlakgEBhgs6oaJ/speqbFa/yUgXr/VwFUK8zOY60ZGUo6JLiKQRT7SQBizpP3si+IdekKMz0kwWV1a0mCEFQR3LTyH3xEoln0wzSyHGlFM3hNfm2ufmFWIF/vyZv+bO9tlIgeQlu+dB7g6NNRvoNJjyq0qdU166pn1fTFehy9jEeJRmLpAbU+iVb22IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/cOkF6AHM9J39SwutaGCwjwJBVq4VF70gA//AEN1YQ=;
 b=a2M/sZdlAvA1XTBczt6tqJIZx+is22hZHRGwAMOLIRVFMehu2o5gQ+X5i1kRgb8Z5K4f4hRPsm7OK8Qpovzo7x3MUFe35ZTmDT/T+0BEwEu71ioyUURz51Yz2oHmElTxnvtDn2Fb0uoXkm64n0oSsqOhLJkPFkpOsm8WDfJClZtMFMaWCs2SvDX8x1suvNyKtkEQ/0Zbx+i+++KxD416utDCz44yEqjFQzXp4u/dn32ox+fnMXCa8E3F8lFn35E4VsVpvhW1SPC6C07JcGD6UdZC9X8m630xRMPB4YEknQ/ef6P0FyedZx469IHmEiSjNKevz3fUzLdpwVCc6phN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/cOkF6AHM9J39SwutaGCwjwJBVq4VF70gA//AEN1YQ=;
 b=JMf5cx4n1FzbjB7T7o/esKDraezwMMxvvgsbFN1ZoUDWn21/P39M/lqSFtDbkHUHaTYIv/f198QL0S3aGwbYZC916pBdLV2UCWiSpWJaBlXvKRMBChFoj6UY3vOC5LU5mwKsluVh5QgANrcMa5UhaQeoHWyWYSa4TnH75fsF8K4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 19:39:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:39:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Mar 2024 15:39:20 -0400
Subject: [PATCH 2/4] dmaengine: fsl-dpaa2-qdma: Remove unused function
 dpdmai_create()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-dpaa2-v1-2-eb56e47c94ec@nxp.com>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
In-Reply-To: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710963589; l=3494;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZonQkgN0drpydT9pv+4dLoZSXSV5xReCOgkLPNO8CeU=;
 b=0QTdFtGEk87qRa8caAdD6r/TvwLmsHyV5DU6kgS7JTRu9ybwW/OW6wQfkMpTR+MprfazUm62W
 qun5BJu73VnCtKeCFdmadMYSHwBCFh932bCYtoXbWXcD0M3RESlyb5H
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: a45fc8c1-a26d-43aa-4d5d-08dc49158485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cNk1qszmsB1nD+yJ5b3Ud+NnGwobCJiBHn43xRuPUbcubNJBgEig7D+xrtUiNnK6ZB5eT5KXzDm3YOoa/MyFtxA9zyVlupxB9IZv+3wtdO4ZBLpqw+z681D3rsDvDVr2+TPMZv/MumL8CUinMxlcqXuUJlw6H92o+97gO0NSL5jvxbu5CsPRkPj4LV2X4qLTKisgQxWeLh2cZPa9RM2pxXDLtMIIR7yd+xS3GVgdYSTuXglE5pc5MjozDGSsl2GqPKaSg7FFLaZFWSq0glyJaM63zOeFJ+fDtkx06yieMreVgzherik5oODdCRmo3Hj2Nr06a9QVLUliYqeKkq3j9MgeyiaNhRWQBxSA7l/+wi99EzbdsuQS7j+P9jvSFzWL7nqFVr2AlEZkm45Qloyvby2cXQatEGxQZaov13U+/Vk8ua7GRqeGr2OdbGGTRYSFUwe7qd4vvnksu0mVrC+oVKKi7g9lQOjar/pihkWcYJfuK+GvBnxtn8aAD7JADQV9a3Wc1NbDUVG4LqnCr5fy7aAJwPAnj8rgtN6zCX/Lh7dMJGqu8IGr/hfUb6iSI19D4kkZVvRi3R+5UL4Vnm+B5AascVFgfN/U0PfHLAyFFG8WtmrvIbX0sjA2QWevrNkCsQvymR+28xwkmReKuvFS18Rp53PW4d+XisshVl6fP5pP2vUosIJ/ODOE0Hco5TjRxYgJf/iNC24S6AV2+1zHOD+YqniKeAwgf1UiXLyEhc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWJqUXc2WjNiYTBadGZNWTBKOHFzc2Nxb3RNTjlXMGx5V2xtSFlqTC81cXdQ?=
 =?utf-8?B?aDRuSUVkdlp6SmJNVm9ITWJ3dUtuak9jcWs3YzRGK2lPbDdzeCsyaHdlaDda?=
 =?utf-8?B?dkJweWlGKzhSUWc5UmhYL052Ly9XNFFKQW9DZkhKbUh0WlFBTUJjcml3R2pI?=
 =?utf-8?B?eXNYQ25qOHNXWkhlZldwdEhDYXhDREt1bi9ydmlMZFBKYTdTMGdYd3gxRlUw?=
 =?utf-8?B?OTRSZEVBYzlEbXU3S0Nub0VkdlZsT3lJQnQ3Z25DZkpTMkU3alpQWjQwK1BX?=
 =?utf-8?B?VE4rSFBVMm1LaVNFZUgvS3VuOEh3eldObE1GTWVxaU5pWVB3MWorVEhJVG5W?=
 =?utf-8?B?MWJzaFBJM0tUQkpBNlR3bUo1ekZtYVNGQTZvRUxRODNQdEF4dy9YNzdWT3E2?=
 =?utf-8?B?OHFndFpSUG43d1JvcFV0dFlXS2tKYW5vREpqSHJIcmtLMHJERzNYSUlxVmdq?=
 =?utf-8?B?em9hYUJqSG1sd3dONzhkem5Cek1KY2ZMU3pXZ29ONUlNa2tGY0dTQzB3ejU5?=
 =?utf-8?B?SlgrM3dneEoxZ3pLQnhOU2hrdUtPdEQwVmE5SFlQUTdjYWI5ZnFjSjc5V1p2?=
 =?utf-8?B?OVZJZzh4cDJYUk5RZ2l1UHpQZnYrRzJiN3Zpa1o4UUR0UndLUUczOUg4dlpj?=
 =?utf-8?B?ZkNjR25yL3hEQTJjMy9NbXl0NjBQb0lsT3A4dHJ2QlRSVng4aXk1VnM3Nm5v?=
 =?utf-8?B?NTdRWUxFWHc0TjlUdVA2a2FQTUpYd2ZteUlwMU1xcUFBalN4dmxsMVpjNGRY?=
 =?utf-8?B?VjJ4SWJpNnd4a1dJMzJweUl1R2I3MkJwYW56Z2kvV09XcVNpUEYzTWxSbEY0?=
 =?utf-8?B?TzdSQ0F1eGZVQlVnYWR2Mm1NbERjSnMwcTJxZVExVUZ0eWxkeGpEN0YvazNL?=
 =?utf-8?B?UHU4eUU1WE5qd1VwOHQrMGF4RDM5aFpGY3I2QW5Dd3UxeE1EWnJVV2NSeXJL?=
 =?utf-8?B?RzBvZzZaclFHVXZIM3hXQVV4OURzd09TcW1TTWd2TkpMNEZsQmFUR3J4T1dy?=
 =?utf-8?B?TnlFUWQwYmR2RXJlVmxaMEdGSmhuOTVmZUpmVGNkTHZGYVJlWjRib3pacUsw?=
 =?utf-8?B?K3ozb0VOdi9NOEk4VzJ4ZFZqUlY1TUdnRkIvNmlHOHMyRzR1VHpNSW9QZElS?=
 =?utf-8?B?ZFFFNmJZbWhCdW9TeG5QQmFKWm4zckVnM3NnMW5IbjIwdmZPTjZGY2wyc1ky?=
 =?utf-8?B?QURqenFXNWhSM3dlVlNJc25BMzZvY3dPTmhpMlZmMXdUdCt3eFZPZlQ4Z1FL?=
 =?utf-8?B?Nk1UamsyLzVTOHhsMGdGSTF4d0hScFluNlUwVXU1RVMwWlpiNm10YU41MjFo?=
 =?utf-8?B?Q3o0UkJOcVRMdVdweUY4MlIvc0VmZjRUa3VabjVtZGhMSFpPU1hQUTlBaEVQ?=
 =?utf-8?B?dVo1TVI4NUh4WDdRSnBxYVdmYmhuU1Zvc05hWFVTSnE0Yk5QbHdzV2lsNzFq?=
 =?utf-8?B?c1J4U1hSSGhVNkUrOXltNjY0d1BwNlVwOGJTc0hBRFNuRGljSWk4Ly81bmxj?=
 =?utf-8?B?SmVMSzl5ZFhEblQ3Q0ZKRzhpRzlCN3hsZDI0enZRdHh5QURoQXZubFlna1dX?=
 =?utf-8?B?SGdsZWxJOWdqOTJ5WURmbDNDSUh6WGhWVnM1SzJsWlpEU01OY0ZONEtqRE5I?=
 =?utf-8?B?UnpML00xKzhOdll5WUlBam8yZFhnbHhHek1qbmJueW5MTHQ5UVBHdmhoOEU4?=
 =?utf-8?B?cWkrMThlU0djVTkxdy84bHdOQ1J3NDBOQ0pnUk8wU1NJR3htZjNEVEV5R2Mr?=
 =?utf-8?B?SVVDMTJMVnYzRjhyczRoNGtMbUV5TDQ0OWFVUFlyQldSZUNuWjhta2hOZHZR?=
 =?utf-8?B?dVQrTFFzZ1JUNHd4SDBOVGx4OUlyeExkclo1M3dWNWlDbWdpNjFYVjVGTmRZ?=
 =?utf-8?B?TUh0WGltbFEzajg0MmErcnk2UTdoTWg0dlhHNFNWeHVKREwzVEZ3SUJsZ0ph?=
 =?utf-8?B?TmdjcFVsbVlMR0I0WHc4NC9IL0tVNnVUczNYNFFvMThDYmZJazgzR1BTZUov?=
 =?utf-8?B?KzdiRi9jU1ZVZUdob2lXR0ZBYXJ3UXlqenJXMHl6d1A0OU1DV2tBL1kzQkJQ?=
 =?utf-8?B?SUIvZ2N0bWIxQ2F1SGdFKzdCQ3pVaElraUtFUER5UWZ4R0hYZG5UdVczM2x0?=
 =?utf-8?Q?bf3DVrvcKA20QxxoPVMpMi8Zy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45fc8c1-a26d-43aa-4d5d-08dc49158485
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:39:54.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNVlOZBrcJqUZMXpdeIAkY0rS79Q2rplqityxbtXdTxavrkbMMmiCazi9tCOkH09exnx/8SLQuYy6T8McR7pSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

Remove unused function dpdmai_create();

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 54 -------------------------------------
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h |  2 --
 2 files changed, 56 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index 878662aaa1c2f..66a3953f0e3b1 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -33,16 +33,6 @@ struct dpdmai_rsp_get_tx_queue {
 	__le32 fqid;
 };
 
-#define MC_CMD_OP(_cmd, _param, _offset, _width, _type, _arg) \
-	((_cmd).params[_param] |= mc_enc((_offset), (_width), _arg))
-
-/* cmd, param, offset, width, type, arg_name */
-#define DPDMAI_CMD_CREATE(cmd, cfg) \
-do { \
-	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
-	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
-} while (0)
-
 static inline u64 mc_enc(int lsoffset, int width, u64 val)
 {
 	return (val & MAKE_UMASK64(width)) << lsoffset;
@@ -115,50 +105,6 @@ int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 }
 EXPORT_SYMBOL_GPL(dpdmai_close);
 
-/**
- * dpdmai_create() - Create the DPDMAI object
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @cfg:	Configuration structure
- * @token:	Returned token; use in subsequent API calls
- *
- * Create the DPDMAI object, allocate required resources and
- * perform required initialization.
- *
- * The object can be created either by declaring it in the
- * DPL file, or by calling this function.
- *
- * This function returns a unique authentication token,
- * associated with the specific object ID and the specific MC
- * portal; this token must be used in all subsequent calls to
- * this specific object. For objects that are created using the
- * DPL file, call dpdmai_open() function to get an authentication
- * token first.
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
-		  const struct dpdmai_cfg *cfg, u16 *token)
-{
-	struct fsl_mc_command cmd = { 0 };
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
-					  cmd_flags, 0);
-	DPDMAI_CMD_CREATE(cmd, cfg);
-
-	/* send command to mc*/
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	*token = mc_cmd_hdr_read_token(&cmd);
-
-	return 0;
-}
-
 /**
  * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
  * @mc_io:      Pointer to MC portal's I/O object
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index 2749608575f0d..3f2db582509a1 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -153,8 +153,6 @@ int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		int dpdmai_id, u16 *token);
 int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
-int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
-		  const struct dpdmai_cfg *cfg, u16 *token);
 int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);

-- 
2.34.1


