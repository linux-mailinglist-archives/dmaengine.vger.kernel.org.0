Return-Path: <dmaengine+bounces-7046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A2C2AF75
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41904EDA3A
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375752FCC10;
	Mon,  3 Nov 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XIB7HiwT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8381C8606;
	Mon,  3 Nov 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164949; cv=fail; b=SnrTDgZAIYALSqtKsfC4OEzvlyLih1JoIbc0thKmgnNw9V8/Ft2ek0fmBla+wSkSYFvcHM/Kk3oAeKsETEasEeUf6SxXTyVSn2SyFTHht//WeEEKZm5G1HlKCYw78WskNIMP4sbA+c7zm8fU5Y4j1rYbAFcfRYfnqBF5NGYzGUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164949; c=relaxed/simple;
	bh=7VQedHRMZ7s+QYQQPJs7skkz/tGAGxHFxNQoWzm8+xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pOt0S92izzvQqou4JjJGYXj3OHAsAgM7AWyPF4UPSzLAQcmd4T6Pxwl0VZ4aOYUzyIFXsVh8yAHRl3+q9vaI3MNmAI/rnlAVCOV5NPSTqtSfwYi/pnsywHClCyWIHENTs2pNAafy8OuoV5W2Lfolorzk2VP96pc6gNG0fHoaBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XIB7HiwT; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3A2I8q2980030;
	Mon, 3 Nov 2025 11:15:23 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a6sy909jf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:15:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8C1SZgMKkE6QHVQTRm/BTqaVATifEPKRgk83nAo+NoJmH4A00owrNQ2JVaEi3Pa7j/AsJ79uXAlUEf2FP3OnV8HKZLdvsfTfZQWZkz9mGrzmRabhQo7gg/2akiffpdIhTRd1g0ziRGX82gC6FPX/eiwt2Lrh8QznYkT0dOTOZbDca3W6lYjI+zH56VKbtYBPn+Pmk1Ao6weiQC0bnqLtD+UWZJho0Ni+6Gh14qSloJ/cRCnLlnomAHnESmBEIf/pc4u0Gu1R6CcwHfdb/+bAywUF6/Rk/OeVDc8331Ld1WYzLEBbroi52zZPsMakfXcrFEvJv7Fw04KYyS1uiIoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C2QTeR3cQQEoE360avKsictL355g1NCYjLzLxkW0Jk=;
 b=eTeglhuLkzofYDeitZf7rneljSgPLIh5Dbh6n6wCPFKa0cHH4TuwuBNI+j1mm2goH0a9rK5xNXYiE3bkAi2aqhoMjWsYVHYwSFBCAiIWq7YSDe6ElrP3nwVZnaBr4AKu0gMgwavxpBudIE9y9wyJvRM7Ui/yNX/C3b/s7A1sVHcuXbjqsEs+BQenMT/sGVhr69eBaZAZracLHghRZk46Qs29FjcxcVq7iu6BJmR1LnCG+vqgycxoiBUb7SkQib7509APl4fwPFYbyUzSDP6/GPy3YlOZS4MboAE16K2ebpulDlW5i2d4BHxsxTTXBu34a7I/MyEUN2/skrbRxY+XlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C2QTeR3cQQEoE360avKsictL355g1NCYjLzLxkW0Jk=;
 b=XIB7HiwTmftLASHqoaKAEnbLISwWSFN4FzmLILoXcnJ0zkKzv79iJlcf0QWZ0LGAsixpizZQ13elvMCKmjGQ20TX3oUb158hX0fLUayGhaFfZgTmDl7rVCy7iTvd1z3cniRbghnmSl09G5ST/TjmlICWdfMXWROvX3yqePrCAjS8WhNFWW8sygttGLK48Ti0VsoWBeqwHfYdpHK7A8OXE+HpmcXg5h6dyeUOuHooqSl23mJEPqWoCmFL3jNTteceiJQ5N/YAPMwRg4yQ4KtrPDuVEHgONK9GhTtKS8O3HNSSG2MRjcMm5NCLfoYAm2If8x2W0KUPfpAGElykl4guXA==
Received: from DUZPR01CA0266.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::29) by PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:277::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:15:21 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::7c) by DUZPR01CA0266.outlook.office365.com
 (2603:10a6:10:4b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 10:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:15:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:25 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:19 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 3 Nov 2025 11:15:11 +0100
Subject: [PATCH 2/4] dmaengine: stm32-dma3: introduce channel semaphore
 helpers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-dma3_improv-v1-2-57f048bf2877@foss.st.com>
References: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
In-Reply-To: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|PAXPR10MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 4255fba1-e325-4f6c-af67-08de1ac1e501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blhCVVlrRS9ESGN3SHpBMmJGQ0QyS2xPZ25MdkFibWJQb2lBbDZzRjcvWTQ2?=
 =?utf-8?B?bS9lNFJPZXd1ZG1VOWEwZktlTUFTVTBlaGRnaHpKY2tXS3J6KzkyY1VUaGNI?=
 =?utf-8?B?ZzJFN0UzVEg5STQ5aE1EcVg2NXN6N0xxWHhYWjZIaThwRUFsWG1pMzBpazd1?=
 =?utf-8?B?c295WG9Pakc1cmVtRGxabHlGelIvWmtZSG80QXRQVTlnb1A2NWpCR1RLMjJy?=
 =?utf-8?B?aDVNMUY2RzdSVS81N2JCNjE2ZVFNQXZHVmZ5TDRBZXVaSzkydE9ENG40L0po?=
 =?utf-8?B?b1lmdXZhUUFTOGhlYWkrWExVdmwyVm5HNHpvVnk1NGJwNy9DVlVIVmpMbVND?=
 =?utf-8?B?cGlVRGMxUHFOUTVkS1F4SC9PQjRSOENhYzIvY0wyd1pwWE1WTkl4ZzlTMkhp?=
 =?utf-8?B?bUJydU1YMUtseFdNek9qc1ZpTUNOOC8zNGhJOWMzYVdwSFdQMWd1MlFNdXB0?=
 =?utf-8?B?a2JQdmN5ZnFwb0gyWmlxVk0zQmViWWlQMi8rMiswNkVBMTVJb1dRa0UrSGRU?=
 =?utf-8?B?NHdqNnpvZGJhYW5CaUlnRERBK0ZzelBVdHBKb293YWx5bW5xYzdhY21PRldB?=
 =?utf-8?B?N3VxdHRvTmVONVQxejQzT2hCTmFreTAwWlNpYTBkNGdyV1JRT0hwcksxQzc1?=
 =?utf-8?B?Z0hXeGViMklldU5hd3dXbFdDNVRFMmhxOUxUbzM3Q3hPSTd2bERMQWNMaU5V?=
 =?utf-8?B?YXEva1R2dEVPb205aW5PQmFwVGVEaVNDV0ZNKzVoYUQyT3N1V1Juc3ozVHNu?=
 =?utf-8?B?Vm9Wa0k4K2M4Z2FRWTVuU2lwNTZZZnF6MDh5MGlqTnhMbTZVakhnRUNJQjNy?=
 =?utf-8?B?dEVpVkZ4SG9mbUFqc0o4cVVsNjF3dENWZDUvUlpwclVaYm4wYXJzT2xSeXZZ?=
 =?utf-8?B?NGFJaGdTRkh4bGxRUUhBbGw4SGpqWGw0WStWZDR2K0FtNTdiQ0Y2YVNDTHFq?=
 =?utf-8?B?YmRyWnp5SGdINVNWNkFtRCtHTERtc3VMYjNBeng2Tnd3Qkc5eWNYVlpyaC9k?=
 =?utf-8?B?SVJ3aFZ4T0dOQ05KVFpBQ0FKVWZKUEtRR0dmTmxnTGsrVGcvU2VkL1RJR3Y2?=
 =?utf-8?B?UkZhU2MvNVhMdmw3SC93OGZUZ1VxQklaU1d2V3ZBZ1kwUUFhdWgwenlCTDRV?=
 =?utf-8?B?NkZVdVRJK0haSWhwRGs4SlpvUEJ2cFhBbEJDTmQ0RFdTN0I1cngxWG1hQlNo?=
 =?utf-8?B?ZmUweG01TjlLTkhVZFFIMWhrWENyek16ZE9pUTZheWljN040U2tJWFQ1U2g3?=
 =?utf-8?B?d0c0dVZBN0FzK0VSUGRyWEc4ZDJDNFZGSnZhN0tDQTdud1pHNFhnYlZ6SlUz?=
 =?utf-8?B?RGlGZVFsWXR4WkNtTExyQ2RsVFpVbDA0VVNueTZYMkd1TDRaVlFEN2JpMGpH?=
 =?utf-8?B?Z3JvN2JBS0hBTkxxcUU3WnFjbzZpL3lRb2dKSDJOTXlycE4xVnNSYm1XWFVL?=
 =?utf-8?B?aXY4QWNZZXM2eHcxcktySzNGNkVqV2VuRlNoYTJOMlRWQWR1TjF4eW1lamRS?=
 =?utf-8?B?ejZlZHR4d0ZnS0V0NDNkTE9CbnNsN3FnLy9xb1BoYmx3Y3V2a0FFOHEzUWt1?=
 =?utf-8?B?SzFuN1FsYXFwRU1FZ0I1MGttM01tTDduOEJuN3ZSYmJWTlFrOVpwM1BnTkJr?=
 =?utf-8?B?ZS9xNXMyQXVkeWFrOExHU1d1QklsVXhMNDVPTGJpTWJSZzB1TCtnZWNWU3U5?=
 =?utf-8?B?UGhGaXFCWFN0RnlVMDE1ZStUTVNYeUF0NWVNdU4wTFZTd1JyR3dWVzRDWk1C?=
 =?utf-8?B?eDR3amh6Ym9zNWRiZm8wbXdvNGNraTFwQlNWN3kyUmVDbWVyOTNxNWVyblcw?=
 =?utf-8?B?VHVaUUswQ2xKTVlDUTBUOFA3dEs3djI0a2dWeldZT0MwVEw3YWk2VjJlTlkv?=
 =?utf-8?B?R3Q2blFWZWdvOHErbkhPTmZLNW1Nb1huWnRkR09WajNlSEd2dDFOTWhzaFh0?=
 =?utf-8?B?UFNKQ3JXZTBuZTh0ZzdaZG9iZDBkaUd2UDNNT2s5cjJPUHRmSVZoWHRPTW1m?=
 =?utf-8?B?a3ZYTS9Bem8xN0R1TGFSZjQ0NEkyRGR5dGZTMkZVK3NnMUNJRk5jNFZRWHk2?=
 =?utf-8?B?eHBER3RvbjZIUzhPLzE5U2xRMFRySUU4WDBIbkFYSUdyMHltTlljL0w5YUtY?=
 =?utf-8?Q?Iaj0=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:15:20.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4255fba1-e325-4f6c-af67-08de1ac1e501
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5280
X-Proofpoint-ORIG-GUID: cAecl-EnpZZiJv9hNcEnyJgL0C4aBYol
X-Authority-Analysis: v=2.4 cv=MZVhep/f c=1 sm=1 tr=0 ts=690880bb cx=c_pps
 a=PbTrrvy6TquqRfd5lZmsGA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=IQHcLSFj4Mn2yckHXKoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cAecl-EnpZZiJv9hNcEnyJgL0C4aBYol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfX6pfd+DiGbvhU
 B339/UKIFMhbsYv8HOr2OZECBrZ0vvok6S1KSQSzOwK8iT4t8PkFzus5ZiEYj1TJyyPjEhUeaXS
 JkOzQrOVqIUbhSZiT6XOOS+gl3oNwGEYmLzjPd5FzqmLsJGmlHzxyDwcFE57FpX/flQ7/m6Jlxg
 zayqMmxMmKSy139NROlaYVR10YUThs999i6JPh8zYbMdYDuDazb2I3NYek8FZzgvert+Oc0Sd5P
 V1A0ugSBpbtrVrA1Qp81PAqRbIngpzEBMutE+DMJbDqrHIEk2rWLOJDmcm2UchzybiBJXhVYiR3
 7W2VgveUVeUybs7+2xX3B+pT3A4e6xo+y81aGn6sz4hFNjyvM62Djz/4Bqi/JfpyKNu9TcotNfb
 TQ/iUzI1X3nPynLLKwjoOu7POlAT4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030094

Before restoring semaphore status after suspend, introduce new functions
to handle semaphore operations :
- stm32_dma3_get_chan_sem() to take the semaphore
- stm32_dma3_put_chan_sem() to release the semaphore
Also, use a new boolean variable semaphore_taken, which is true when the
semaphore has been taken and false when it has been released.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 55 +++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 9500164c8f68..a1583face7ec 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -288,6 +288,7 @@ struct stm32_dma3_chan {
 	u32 fifo_size;
 	u32 max_burst;
 	bool semaphore_mode;
+	bool semaphore_taken;
 	struct stm32_dma3_dt_conf dt_config;
 	struct dma_slave_config dma_config;
 	u8 config_set;
@@ -1063,11 +1064,50 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int stm32_dma3_get_chan_sem(struct stm32_dma3_chan *chan)
+{
+	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
+	u32 csemcr, ccid;
+
+	csemcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
+	/* Make an attempt to take the channel semaphore if not already taken */
+	if (!(csemcr & CSEMCR_SEM_MUTEX)) {
+		writel_relaxed(CSEMCR_SEM_MUTEX, ddata->base + STM32_DMA3_CSEMCR(chan->id));
+		csemcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
+	}
+
+	/* Check if channel is under CID1 control */
+	ccid = FIELD_GET(CSEMCR_SEM_CCID, csemcr);
+	if (!(csemcr & CSEMCR_SEM_MUTEX) || ccid != CCIDCFGR_CID1)
+		goto bad_cid;
+
+	chan->semaphore_taken = true;
+	dev_dbg(chan2dev(chan), "under CID1 control (semcr=0x%08x)\n", csemcr);
+
+	return 0;
+
+bad_cid:
+	chan->semaphore_taken = false;
+	dev_err(chan2dev(chan), "not under CID1 control (in-use by CID%d)\n", ccid);
+
+	return -EACCES;
+}
+
+static void stm32_dma3_put_chan_sem(struct stm32_dma3_chan *chan)
+{
+	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
+
+	if (chan->semaphore_taken) {
+		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
+		chan->semaphore_taken = false;
+		dev_dbg(chan2dev(chan), "no more under CID1 control\n");
+	}
+}
+
 static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 {
 	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
-	u32 id = chan->id, csemcr, ccid;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
@@ -1092,16 +1132,9 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 
 	/* Take the channel semaphore */
 	if (chan->semaphore_mode) {
-		writel_relaxed(CSEMCR_SEM_MUTEX, ddata->base + STM32_DMA3_CSEMCR(id));
-		csemcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(id));
-		ccid = FIELD_GET(CSEMCR_SEM_CCID, csemcr);
-		/* Check that the channel is well taken */
-		if (ccid != CCIDCFGR_CID1) {
-			dev_err(chan2dev(chan), "Not under CID1 control (in-use by CID%d)\n", ccid);
-			ret = -EPERM;
+		ret = stm32_dma3_get_chan_sem(chan);
+		if (ret)
 			goto err_pool_destroy;
-		}
-		dev_dbg(chan2dev(chan), "Under CID1 control (semcr=0x%08x)\n", csemcr);
 	}
 
 	return 0;
@@ -1135,7 +1168,7 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 
 	/* Release the channel semaphore */
 	if (chan->semaphore_mode)
-		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
+		stm32_dma3_put_chan_sem(chan);
 
 	pm_runtime_put_sync(ddata->dma_dev.dev);
 

-- 
2.43.0


