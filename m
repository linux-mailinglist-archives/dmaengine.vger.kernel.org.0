Return-Path: <dmaengine+bounces-7284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154DC798A7
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 486572DB1B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2934AB1D;
	Fri, 21 Nov 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="etRObKoh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96731355B;
	Fri, 21 Nov 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732236; cv=fail; b=Re54JUHH9D/1jKYxQ/9E+PNFQ7hyWJfN2IjRkrJov+35eSpb/WiPOBb5qIM0Gju0fUJ7BK2ANbg6+vJqC90U5N99qeh19C9SiY01J2oHHheXtGOQ7xpv3swrOXnmKpytKWK3u4Y304CdtXJJXVarIckxpA3NyAY1bBCd2o67mv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732236; c=relaxed/simple;
	bh=6oWlJaJJXF27zXkiVodpcSZ6IVOovjjfMUAPUZdi4b4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MZs6Wqc7fe2dbqvz7IYY2Ju8gmay94yNHekHiRYX1eb+/tWGCpIOIdacgyoUMgRzmmVKR6EEQlbDo9YdmqA7cnNhI3mGxKd2ZbwFrqV8LEJQDb0iqae7dFF+hv/JYiX1Qw7yzwMX3hY7r8IEyrbas1sypNjTFFcFQFEwE//uZZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=etRObKoh; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALDZTJc3452033;
	Fri, 21 Nov 2025 14:37:00 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajnmt8x2e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:36:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk4FuvFyA3CfA4xt6VrZl8aod9GfgVOMe/CvyiwrTb4tiYFvcFHyu3ffFcbi+Pk6oR7R/YuehHZDRq5eQbxCz7dhwHc9IFe9t0WBeTMmFxOeujRXtxN8Z7I6uj0kdjZNo1Vq+YA/KLlDEXRsr2BWAV8X0d8UeJkVWYrT6RDhMq4CUR9ZWDsCaZE169JFG6pgnQyAj/TxQ8dNPLAYI8wOc6TZgn0pCVTG40LebPKmXieZ3/cTDpGKgk+QCizT+8B0kr4v/kkIffQq87PBbEmX0WjQukN+L1v4hzkT62nJkvuSGmQOfI7X4dMmuOyumIFdvhC3Wa7bOE9K/ix/LMxtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIgyY1cZUOKzkjJfdY46tZkGUtEuln9bC+BdeZLrX70=;
 b=yDSRvwboqYlb4xnjXG4pvsRorLVSnF3cmNDdaArjEbSm4YtCkYIVvVq1p3HKdUBnpT03Ndzi1qt+p7tcdwVcAh+x/Bd0iy+Y9aApFcjf0nMSR2jhRjm2ShyO74xkTLLivcEuKM3hkJ6y2BaPijIVekuBnFEtZljh6AQDZ7JpyIGXVg/gNWpkbIakwk1a52sAKVoC6cyn22LxCWsF9C5TVx/NiYUm5GyoDCeBgg5cQ1jQnLy+b9zLU8STkIUQv9Y7XL8RCy9JM/NWBRQKvChj2ryjWa8rp6sD+UxMSaRc4fW9l8snLaZO2EuE6FYf3EKOTrJUNARJrOgOBYVxQmE4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIgyY1cZUOKzkjJfdY46tZkGUtEuln9bC+BdeZLrX70=;
 b=etRObKoh+1Yfqh9gEa65k91J4MdMYYpsLjOeWJwC81YJ7IMfAOcl4RvDUUtPNG+BKxG/bsNPXxGXDz6+RatBnigZ9Ef0oM9entC269BKf4OUWCUsOUtPxRf+tR/4+XTL9lFMB80lFH/dl+SvMqjUBxjjaCXuPdlaCxF9cFME3MWFcve1wu1ywP/LLt+XwzLDicaiTlLNjsWqrCi/KT+5LL1raTCtYZelCAe+GO/9EqqrynIYj2cqMWkXFOBk8aSksoFCOWoBgpEijuCz67GaOol5ePQI1RjzsZMXlUlNTbfxSXynIqL8mKi+5BqcbZKoSiSwoXQV+Rtv/BhINa4s0Q==
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by DU0PR10MB6019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3b1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:36:57 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::f5) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 13:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:36:57 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:37:21 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:36:56 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/4] dmaengine: stm32-dma3: improvements and helper
 functions
Date: Fri, 21 Nov 2025 14:36:55 +0100
Message-ID: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdqIGkC/23MywqDMBCF4VeRWTeSm1W66nsUKUYndRYayUhok
 bx7U9dd/gfOdwBjJGS4VQdETMQU1hL6UsE4D+sLBU2lQUvdKCWNmJbBPGnZYkjCWWeuiNootFA
 eW0RP71N79KVn4j3Ez4kn9Vv/O0kJKZrWS9s5r7u2vfvAXPNej2GBPuf8BX2vVR+oAAAA
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Eugen Hristev
	<eugen.hristev@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|DU0PR10MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: e97a7f69-2db1-4614-d08b-08de29030a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHMxYldPbXVQWi9zYlpWS0NDUEZSbUpRbXl5b2FpT1JuUy9vUjRZZmZuNmhE?=
 =?utf-8?B?SDNLTmFMaVdGT3Q5MXNzNHptd1JuOHVVVHJ4TkJPL0FYSEJyUDVEa05GUE9R?=
 =?utf-8?B?V3JWemkyN0ZKa1FOaGEzdEpVcVA0enVzdTE0UE90dnFYV0F3anowMG9XR0FD?=
 =?utf-8?B?SkliUWJFZ1pZRjRkNEpIeVdjb2dKTzBzcXhZVm1KNlI2OGhjVm96MXp1Lzli?=
 =?utf-8?B?YzNuMkw5a2U1ZHN1eTNBOWZoR2s0cUFwZjQzZmpYbW5BWlpmNWs1TXVNWHVB?=
 =?utf-8?B?NDhqVjBWSjk5QWtKQ2FvOUJvMmFJajAyMmQrdklla1hENTVvcVRlNURsSTdr?=
 =?utf-8?B?em45aUFERFVQN1V3NTVPSlJ6OGlITFloMU13YXc2WEh1SnVsYWRTamdMZk16?=
 =?utf-8?B?MGs2SjMvZU9jQ0drL0hFS3F4aFJDMDh1aUJWZHA3bUlJdVdXSHNISU1jblRo?=
 =?utf-8?B?ZTV6dWlKTmV0NlY4am83Wk1hZVRETWVTbTNTSjRuUEhrei82UW5NYjVNOEQr?=
 =?utf-8?B?ekN4Sk5uT09wZWY1MkNNUkkzNTJEOHJQMG1UejFQRFRpZDdrTC9XVUI5VVYx?=
 =?utf-8?B?LzBzaXdSUVhFUWNNcmNPc1dNblQvaWxSL0dNK3FndE9MQUp2aFphRjNxdHN2?=
 =?utf-8?B?ZlZtaG9LekRPaFdxaXhmempzNndFWHdSVC9rMC92QWE1eVVKNm5JZVFuS0hu?=
 =?utf-8?B?VFhubEdLZ0J4cDFmTE10cittVnpVRXU4WFQzRUpSQTd3SE1vdkxFaWxJQ0NF?=
 =?utf-8?B?bUI1NFBWUU16Yk82L0YyNjVTYjdFV0ROTUgwTEJhRWdOTzZ1QWhwc2RkYlFo?=
 =?utf-8?B?N3hlSTN2MFBML0lPZjhONm1xak1GMXhHQ0hGNTNVKzdJUHVVVHppSEhHcCtB?=
 =?utf-8?B?a3NnL2hSc2hrVmNkRTFjU2JhZnkzZmdaVVBmeWI2dUdQcDE2THRDU0phcVV2?=
 =?utf-8?B?bWtRaldubUdTUDUyeHNQUEdQNCtaQVM5RVU0R0hiL2NDbFVhT3hyS2FML01w?=
 =?utf-8?B?T1NiaG9Sb255YmdhbFR2Y3dWWGhqUjRlbmFqdVhkQW8wczlwa1FmU2Z4Ykhm?=
 =?utf-8?B?NjZUT0pLWG9KQ2RveVhqbmdlRm5oM1MvT2FxV2szUy80QlBRalVWbHN2U1Nm?=
 =?utf-8?B?SmtVV3pYR2Z1c1NDRk9UandObjlVbHlrOHRTVEdRYnVyS3lZT3l6dFBXY2tG?=
 =?utf-8?B?cnhFR25LUnF2blo5NDBMTlh1TC9kUXlBUXUxR1RUOHM5b2x1RkRWTk9SQlNs?=
 =?utf-8?B?djBUTldwc01xMTRFcTI3UHl3cEhHRHNoeGRiU3hSVWFPWnlBa1JFc0xuVmhD?=
 =?utf-8?B?TThFbkpyQzlZQTd1TE56WEZMa0Q2OXV5ODMvSko5RS9YOTFsS1dZSEJiTUx1?=
 =?utf-8?B?WklLR2EvVy82d2JlVTZ2TGNrM0VFbjlxZFl6ak4yaHRmYWZoS0pOWFZvTVBR?=
 =?utf-8?B?UkFWT2grbEY5akt5MVZWRmNNVHE4ZmZuZEpsdjJHVkM0NGZ2bWxCU3lmZ1N2?=
 =?utf-8?B?Rk43ZTV4elNMNWpzRFFzVCtCcjlGSFQxSkV4d0M1eWYweUUrQ3pqeXhKL01G?=
 =?utf-8?B?VTZTQW9aclhiYlRKSjRtV0FkR1hObXVQd3IzckhSVGVxY3pQUkdSZmR1RVVG?=
 =?utf-8?B?clhUR0doVWJIU2tLTUllOWxhT2ovZyttTkppaVdMTHQ0YmRxRWYxamxsUURz?=
 =?utf-8?B?eitJbFp1NktCTHJ2Z1N3ZGE4d29EUmprUEJHdUw5bzViVjhEdXBZTmYwQnNu?=
 =?utf-8?B?eVZqWElVcTY4aVlaT0hEMlRaMTVWNkpZMm9lN2M3QUYzSzBUN2pJTXIrci9O?=
 =?utf-8?B?QjFqMWV0V0ZRTHVJQlhHV2hybk1PeHVLOElFMFc1czNEcGJwajVVaFJMUTlN?=
 =?utf-8?B?YkdiWHJsUWNaZ0VjdEZoMHZiNEpyOFVIbHZzY082WkFTZjZ6UUt4UU9qZEpq?=
 =?utf-8?B?SkhvSUZhVURUdW1nSnovOHdSV0pIUlF1TkFDU0VxRHB3dEh3MFVTUkxJMkh5?=
 =?utf-8?B?UWY4RHluQzNFd2dLSzhQWnBSYm5QRE5UU0dUZFZGNXRkaGpvNkhReHlnRkUz?=
 =?utf-8?B?b0JnK1hFMUZabTJFR1VSYjlvaVJXbnI1ejd1WXZsaTN6WVd4SGNWOVlhemFL?=
 =?utf-8?Q?RBJYZ3X2adTvK1kNh/0ni4PLg?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:36:57.0085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97a7f69-2db1-4614-d08b-08de29030a83
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6019
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=69206afc cx=c_pps
 a=H8i1M1V/suqiaFjUero0jA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=FnA8CDKvPw8sk-bsElgA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 0dS2B-euAi0koSuZFiKMWLQnLLESmXFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5OSBTYWx0ZWRfX0OrTw26uqoYB
 fGZ2V5V9KlQ5WliOwDclaV/emOeMduBxpDQWIlvdut5QtgR01nUPl4LRfVRUiTQm3ciEo5Bf1G6
 gxj5K7ms1KGlTpbjL0zy3NxhObMks3Z8xgnu7XyZkXfw5aXLcejNji3g3EoBGwdX0hjW7AEmZf0
 pAUK2VfY2o+4nlSDBeJiBvwkAPb4tSYEFoXMvNGWeEsHmhkfnZeIge1wYk6mSxG7AwY0OqnqQlK
 R7Ry9xibg0GWdLnmo0eeKPildrhZ5L6qXLXWf08lpnwbSAnVDzx/jDKtDcCjRQh8ZPn1a6Fzgyu
 jsHjVvUEdLZjzut26zTV7BWDem3ouThBTcO04keWX8QpMpUSabI1gnB4hPsVycJjvPJfGnj7Rs4
 dvpVXeM/2Q15ae10nl3bfP4qmJReAg==
X-Proofpoint-ORIG-GUID: 0dS2B-euAi0koSuZFiKMWLQnLLESmXFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210099

This series introduces improvements and helper functions for channel
and driver management.

It enables proper unloading of the stm32_dma3 module, replacing the
previous subsys_initcall() mechanism with module_plaform_driver().

It introduces helper functions to take and release the channel semaphore,
and restores the semaphore state on resume, considering the possible
reset of CxSEMCR register during suspend.

It also adds a helper to retrieve the device pointer from the dma_device
structure contained in stm32_dma3_ddata, simplifying the code.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Refine PATCH 4/4 commit description and remove unintended blank line
- Collect Reviewed-by tag
- Link to v1: https://lore.kernel.org/r/20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com

---
Amelie Delaunay (4):
      dmaengine: stm32-dma3: use module_platform_driver
      dmaengine: stm32-dma3: introduce channel semaphore helpers
      dmaengine: stm32-dma3: restore channel semaphore status after suspend
      dmaengine: stm32-dma3: introduce ddata2dev helper

 drivers/dma/stm32/stm32-dma3.c | 165 +++++++++++++++++++++++++++++++++--------
 1 file changed, 136 insertions(+), 29 deletions(-)
---
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
change-id: 20251103-dma3_improv-b4b36ee231e4

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


