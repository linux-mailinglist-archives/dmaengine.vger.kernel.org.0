Return-Path: <dmaengine+bounces-7287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA666C79AD0
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 106B935F9F7
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE5350D70;
	Fri, 21 Nov 2025 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fVT1HXY5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA82350A23;
	Fri, 21 Nov 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732244; cv=fail; b=CwO4YqwMxwGqpQEKXfZk7EXOhNyzQeLCTig/Ec3C3TSTenNIrhyVKnHcMpPLxE6LErQt9QVOWPrmuL32JIH4fvaMzioh4DNj6QPSELuH8MZhKxcGhTlISlcBuSzZsaiEOKjL7rCrDxJLJY5TraM/vSJ96ZRwL03fmGDiEIJzhdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732244; c=relaxed/simple;
	bh=wFYf8/N9nd4awyz4VibJijF2nPUw7ECQBdh09BgQoq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lhWIR+7fs4a0P1h9ujYRbH6AmXvnG/nVOhb9UoAHIrH1d3P0nBWrerzhJ23PuT7ZuWwrZaa+UaHyJ6zeq7qUL7st8heE/cawuV8/QwdGCP+57EkuTnWF6XahotE16bcug6j/BC0R39Qrwzg7O+OLG636BKsdFujjpL4rRAXOLGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fVT1HXY5; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALDWoeI3499046;
	Fri, 21 Nov 2025 14:37:02 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajqucr9ts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:37:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xazzgj/jVbxohYTYNfoSESEJ0HAM3XgM5kCWFDSe+uv8pazV3xoERx4C13Vfm71NeyfpyOLv/ik7AsaHXtHrli6nKYGe4pfAIlwtbSpo9GXE8r35hfMto6X0GeRNfBgl39tV8hI542UensB0ZmLMKn5hLpIbQ2efdAEHh16d8h7yklDDiAw5FJRmqQ1nkIIH3sLcZp31vw9Ku6bqse7PUTB+o/rq5rXp6y6rzvs2nHX0S8t/vEeNNjk4Oz/5eQMqUl0U+0FtluMskUAVeTsnRNHPHBedGQ2pE/XNUIARUJ9fQzJeK6wYOyipgjBpMKDEpWg4tt+ZXp9dsr6h0mo78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgFbhaNHir76wQoaKCmmuBRi93QAsTWShBx2lfqsshY=;
 b=cDFPuJEAcPOlQErhncGNssu9JGkXW519D8bmobW2qiwqfhxIg9WCJLWgS5CoKWJgLog/npBDxosxkjnPAjPMnRG2mN6Cw2ZAeKSk9cY7FRlQUFekQ0xGNVR/Tg7XYjLHsJaokymGn4VW3jjtd/R453KXQmeU2tE5Q/RTsb/oR6n2pHp7qt7xLv+eyG87FSh9hUz711fsgKYd2lo7XgFwX5X2bhmU02WYnNHxr+CwW4fVv49q/NWwDZgTq8Um+cAVA8L6MsXvhUuxAnHEM9FiY+36Uh/yeqMcY7Uy6YXP7020f9eoSnkZBqjt4CkK+BJvLlyFd1MVnDX585RHgMBmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgFbhaNHir76wQoaKCmmuBRi93QAsTWShBx2lfqsshY=;
 b=fVT1HXY5x8sdsY9xYs8do21KjLAFAvM8XbfDLlZRwGbyhoJNibLvKTNd6Bn+vsmnZCQSXltRvIIW91Up7k5Z2uC/pjbUB+FgdzpcntkbS2TscBvZRwJY0/95YZeBbbpQp1bOas8/TrC46jDf/hx5Bx7b3X+u5FdM/eULw1LoHmaAYcuReFp+KneH6SJnYvj79PuL0JzCVrWChUQzzhPTjxgCPtVBq/JU+mGsCD9Gso5YlSo2Z/iUT3Lom0rVQquWI+cjLUVhS5+rJF7u4t9cM56qixIgseAR2pqR8Tj5HSLC/LZYrnjcbMRyKLMKGgNhXCRLO0jjDu6eSRjShfR0qA==
Received: from DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26) by
 AS4PR10MB6329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:504::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:36:58 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::95) by DB3PR06CA0013.outlook.office365.com
 (2603:10a6:8:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 13:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:36:57 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:37:23 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:36:56 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Fri, 21 Nov 2025 14:36:56 +0100
Subject: [PATCH v2 1/4] dmaengine: stm32-dma3: use module_platform_driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251121-dma3_improv-v2-1-76a207b13ea6@foss.st.com>
References: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
In-Reply-To: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|AS4PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c127c9-964c-4293-8fc3-08de29030af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmJ2bktiT2Y1SkUzc1d3em1NMTBaRzVrdm50ZkRMeHQzNFl3YXNaWmQ2SVB5?=
 =?utf-8?B?SWw3TzBLZ050b2xrWkhOWmIweEZrWXRUUDE4d0J4dGphVnNtVnd4aUYwTEI1?=
 =?utf-8?B?RG1EYy9NVGZObFloRThud0hQU0JyWXI5WUVScklTcy9GRkpLcndSUm1HenlU?=
 =?utf-8?B?bURhZUxkUHUxS0pLSFpsTnRQd1dzbzA5MHFsYnZCUEpWT1hFYXB0WkR2cGtI?=
 =?utf-8?B?UWtHR2c5RGtvaVVVZ0NralU4ZlNWS1JGMDZPNkpTd1o4V3VSWXpkQU9zUkVh?=
 =?utf-8?B?OEdBSmQwcytBYVptT1h1UEwwL1VEdS9EaG1ZQUVHdk0rVmN1NEdXQUJKZ1pk?=
 =?utf-8?B?aDVUeHlaRk9iam9aL2FJcEs1Ym45TS9ZbVJwOU9rby8rUDU3NEQ2UWdhNWRQ?=
 =?utf-8?B?SFAwb2R6eHB5UDBnbFNtOWdWWnFDOTE3V29DS2czVGtud0lxN3NCMy80NTJW?=
 =?utf-8?B?cElLcDk2UVhuRGxJQnFVVm90YlYwOUNBL0xvRlc4WkZ6SmZTT0pnQ1h1NlAx?=
 =?utf-8?B?c0orNXlVTzgxOVhDK0xKaDh4Q0l6OU9RUFVwd2N5TVFuVEVjSUgxNVM5QnJ2?=
 =?utf-8?B?NDlkKytSWDBZbG5tU3B6bGZJVlI3akVxR0RyTjN3azdrM2xnMVBRVk5OdHFq?=
 =?utf-8?B?TkZBbmNzblpRNTR5cW9vUDBRY2xkTXUvRkpvN1FkU1g5MUdReGVtYU1Fb2Zk?=
 =?utf-8?B?aGdWTVNsOENjbVNOSmJpdDE0NU1ZaFJnaWxaU0ZtRXpaYi9sQ2hsWWgydVFP?=
 =?utf-8?B?M3JJY0piR2VqUUx2MTJLZ0J3d2FkUzJXOWhJQ3ZKc1NjZ2g1VlRSSmI4YTJX?=
 =?utf-8?B?RUo1Si9UdjVSKzBDSzNQcW9XM3dyNWZtalcvQzU2YnJvUUFRTTNXS3pHQmVa?=
 =?utf-8?B?ME5SYUtpVDBZNTJtd2xWQW44U21wbUh6UG9uU3BseGZ3TEFFeVBtTEE1dkxB?=
 =?utf-8?B?WkpQMDdIWk9qSGlRem1jdjZyYlVCdzNRTUpJN05NcWhLV2lIRHFFTWdkTkN5?=
 =?utf-8?B?d3Z5WWpIcXJMZEk5K1ZUVXVIeUJqNTNKaEdHbGNBYWpMRVhML1ZaRWFyRlJH?=
 =?utf-8?B?K1RPQ0gzZnhpdkZrSjRVZkNpb0xJa3U1TFc5Rkw1eVA0bmNBSmZFczZzdDdY?=
 =?utf-8?B?M216d0hCcklCcERjSG5ORTRXTmRHZkhjb3pQR3VocUpGTnhCWjR4dG5RSTdG?=
 =?utf-8?B?Y3ZTSGJGVXd1U0E4VEdTK1hvSFdZS08xdlBzSElqQ2JWU2tta3VHWXh0bUN0?=
 =?utf-8?B?OGd3UFAyanZoWG5yNzJpNzBOZEw4ZWlsa21IVmwxazU0OFhKS1lIUFhvUXBi?=
 =?utf-8?B?b0tpeTZyb1kvZEQ5eXkzbHRBdDBGeTFPa2tubEgwaStKUUl6SzZld2YxZjlH?=
 =?utf-8?B?OFhiTE5seU9qd08wVmtIOU16U0FaUGhkTjhacUtGSVBJTW1WRnp0NnlKY1Uv?=
 =?utf-8?B?RlVIb2V2MWNOTmtsTHN5dGNWTWhxU0N1MjJONUJxZDlqM3grUmJZV1dETkdG?=
 =?utf-8?B?bi9qNXBHYTRRbGkvVEZEcjhtamg0UEU1MUlUWlk5WG1lYXprU3AzRUUzSmF3?=
 =?utf-8?B?ZzdEZExvVGpkZElwbzdYS2kyajkxZ01NR0Z1ckRNWk9RdCtwbUN2Qy9vekJ4?=
 =?utf-8?B?UWZFd2VaQmRwaHpWMU43RzhqTHFvVGd5MmlCaWR3b01JejlkK1F6VGJnQ0FF?=
 =?utf-8?B?WWlSUEVVbHZzTzFPWXVxRVB2ckxDSVJKa3BiWGllcTVocVo4bCszRG83VzJV?=
 =?utf-8?B?Q05jTmREWit0OEk3Y3c0enNVLzBtQTl6c0VML3ZoMVl2WXA0MVFVZFFVQUtu?=
 =?utf-8?B?UURNK0dOMkc4bks0NjVLL3dtN3huSDNUeENBS1kwS3dxWEd4d2FWeU44a2NG?=
 =?utf-8?B?WnA3K25WMlFOL2lEckF0Tjg4WmZFdXczeno1QnhBZEdOdm84dE1pcTdkZE1j?=
 =?utf-8?B?VWlkclN4Z2pBeVBmcmtxNkdDVWsxVWlyT1J3RWlJZmd6WnQvdlREUGJrUmhQ?=
 =?utf-8?B?ekRKK3F2MkhSQy9TUHVLWG1YZy9UV2M1QjBNR2VHRlRZZ2hiRVJoU0lEbXl4?=
 =?utf-8?B?b0Y1akRveWxxVWUrK0lLMzFjSmxIWm1JSzY5MW9TMzVBeEFHVklDb1hpZ1M5?=
 =?utf-8?Q?TchM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:36:57.7151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c127c9-964c-4293-8fc3-08de29030af0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6329
X-Proofpoint-GUID: DFsAbZp6WO1QOje2EYtGrUcygWqTDuED
X-Authority-Analysis: v=2.4 cv=EdHFgfmC c=1 sm=1 tr=0 ts=69206afe cx=c_pps
 a=KOiI8WV4eRqHkUZxW/2pzg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8
 a=B0u0qpW-aHUTvGdyuXcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5OSBTYWx0ZWRfX8/LdXOsqEJkb
 EhKby2zvwldENI3mY/EHOPAiwdn8Fkth3MnDJR365IoLjDmwMC+r3O+isiuiZmrq2G7xA8JOF0I
 56d+PF7vh4J8g8y9NjgQyIc7tHb/Kr2FE+9R0whPZlY5+vPrq3x0uV6rokt/0oY3yazb82CyiK5
 dHjJvBjy8APBNQ4p7Rf4L6nMmznWQtN3+GyIXhmTxXmRhlS6tEsbNFtfBVC8M9D8AoOdx04fA5h
 IVSfhe4V/aCmtje9pwPJ0Cvil4XRJsglTLXvKAyjph83T1wYGOnpLE6Z8rNj/x+Bl+ihq1DPsJV
 x31/VUUnw4Y6gPA/2GNtWv5CL4dOUfboE611xTAaqQOZ6nZMDDWLMvdB7Ovg5fvh8HH70botapW
 TxZFtyeRvAdnAt5CmdqZf2hOCNa1oQ==
X-Proofpoint-ORIG-GUID: DFsAbZp6WO1QOje2EYtGrUcygWqTDuED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210099

Without module_platform_driver(), stm32-dma3 doesn't have a
module_exit procedure. Once stm32-dma3 module is inserted, it
can't be removed, marked busy.
Use module_platform_driver() instead of subsys_initcall() to register
(insmod) and unregister (rmmod) stm32-dma3 driver.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 50e7106c5cb7..9500164c8f68 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1914,12 +1914,7 @@ static struct platform_driver stm32_dma3_driver = {
 	},
 };
 
-static int __init stm32_dma3_init(void)
-{
-	return platform_driver_register(&stm32_dma3_driver);
-}
-
-subsys_initcall(stm32_dma3_init);
+module_platform_driver(stm32_dma3_driver);
 
 MODULE_DESCRIPTION("STM32 DMA3 controller driver");
 MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");

-- 
2.43.0


