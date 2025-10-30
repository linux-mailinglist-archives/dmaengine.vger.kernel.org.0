Return-Path: <dmaengine+bounces-7039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF1C2003B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 13:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CE31A20B64
	for <lists+dmaengine@lfdr.de>; Thu, 30 Oct 2025 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6C314B93;
	Thu, 30 Oct 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DeGtoW2G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE831062C;
	Thu, 30 Oct 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827219; cv=fail; b=TyLSu6xAnrl0MImVF/HHHZXPWpJJpBra1sCOasN0sRE1kIGM2XFqpy0/ELFNKU/6FlR+im93sJxsqoYlB9eQc2S7oQRRqZl4KH8vjfQkBiCqLyEVW6UGVjUhClD2sM15TNDNz/6QAMHy4P+P8MU3/KaNleaaYpzYuLS4R9O67Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827219; c=relaxed/simple;
	bh=KM+i6xEJoOCH8eBmTIt5MhjFVMuvsiapE/3gFaXXw3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JP0/BHMmRnwVMBp8rLN5Xv4cjgX52605ahXcNqqd5QMdBROOlSBQkDKisaBSYMzoxT4Lszctm647fTGH3GP/y4GgDNm2SsPCaFop2oi3U78FZ9n9Rb41B0kX+U0TyRSX3/fIf+psiXeBw/yiVaIHzj40fXEFUrLbNLSG1V6KZjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DeGtoW2G; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UC8BVh1825044;
	Thu, 30 Oct 2025 13:26:45 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a3be3qh67-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 13:26:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU3LvOoTF1JkxPiArUe2E+8FvMpV8QE4uvImi8OOtlQwRHt2oh/JRW3bSA8LuPvjHlLbvLRM2covrVXe8KHZz6EauxiJqtHsP5l62R8kvc2SkeSHvlUXqgR+myqY5ZxeMML5sdMiyJxFoBe3AVyy/5XNV+S4PHDxoN85q47dGBrddKz/eovjLuzLQuRSAn+It0vfxpaDng9945VJbspc/0HEVazOGL2MzL/RQcZUZqzr/Ye9dj41V6KHAH/csTpMuAJsllTZrjMI99gS3rx1MGsdWa+YSCjdXDs+kGlYSN7TJgMuc6h9Dla3iqjI2hU7vx4xV3uTPfaY7P3OCrYs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsQoCx8oTUPHeqax0ODr9uNjGbyB7JvqMYpIw+LvLAk=;
 b=y4AB298WnQgvHRvwDEb3+DiCbQpMlfk2J/Vrq00RMVAlE1L4r96tqgMm7Mwa71q+t1WGzv+DAkfMgdiCNnQLOrwtKeFGRoEj8kekwjxX87nyB0Huy69Vwq9Jf3cV7I71xqPAVdYcIW3MbL3Vz2h4r8TU8WOeeIWF+BSTlC6ocNHm7Tmww+3i1vsBTcx65eK2JoNEHFMqGJUcDO/WzBbNA7JM8eZp6aB7HTaRCJZemO7aqVRcHw+kORikJOC5gIt0uLV5TZWyuGw0/CqhDFOgDByNNIPFm+8IUr4eLg+q/v8TUY6ne5WYTSmJlHlcOko+rqriI0KDuhdhftFrPrq2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsQoCx8oTUPHeqax0ODr9uNjGbyB7JvqMYpIw+LvLAk=;
 b=DeGtoW2GEMtwm1NszIDurIDigcqmYN/0lep3yDfYOmWvaGRd2Rx6bmEbmPtvdp6GnvdgdnL5mPtW2U5vdM3xsAJJMiY2iG7PjD9/t6dIHb+TNoU8tL6lAeN1YjY5ZdbkKXFexJoLxjHojx6yBrOjoYW7YF5AB4mFpvW98Oq9JT/w8sjjpwTCnDEzPUJ4+uawNFQq6o48URfasn/OvHuyOGWsx3wUC2z9Ew2CFr2sZQmHvT7VLx84EuVabduP5112TrG55zutxUs+Y60V1ZpoH9BBkzy1APsqOyywOKJB5w3gEJdq9k1y48KNSS56CmM37RfxptRTPmrw8pZBGCDUVg==
Received: from AS4P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::12)
 by GVXPR10MB8613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 12:26:41 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::8f) by AS4P251CA0025.outlook.office365.com
 (2603:10a6:20b:5d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 12:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 12:26:41 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 13:24:25 +0100
Received: from localhost (10.48.86.127) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 13:26:41 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 30 Oct 2025 13:26:38 +0100
Subject: [PATCH] dmaengine: stm32-mdma: initialize m2m_hw_period and ccr to
 fix warnings
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251030-mdma_warnings_fix-v1-1-987f67c75794@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAH1ZA2kC/x2MQQqAIBAAvxJ7TtDSS1+JCGtX24MWChWIf086z
 sBMgUyJKcPUFUh0c+YzNlB9B/thoyfB2BgGORglRykCBrs+NkWOPq+OX4FObyMqLQ0htO5K1PT
 /nJdaPySRE/ZjAAAA
X-Change-ID: 20251030-mdma_warnings_fix-df4b3d1405ed
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
        "Amelie
 Delaunay" <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|GVXPR10MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01f23a-52e0-4b7f-dc89-08de17af94f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdFSHhmWFI0TWpQczRtOTgvSUNpL25LUjNtcnZuSEhJcGlTSnRzSE9tb2Jl?=
 =?utf-8?B?VWhURmVJaTN1RFZNVXJZL0lYV3dWdS9iY3Q1Zm5vdU5ZZU5OUCtrZWwrZDZv?=
 =?utf-8?B?Z0xONSswcVIvOGdQVGRqWTRKdWt2UzRIU3lENXplYjJiREN1U2g2Um9hSWZI?=
 =?utf-8?B?V3pNZ1h2ejJQYk9ZNng1Mk5nWGFtZ2NPcXdKOWRKb3VCQkI4ZEF6ejlRalBs?=
 =?utf-8?B?M00yU1A3b3BoL2dQdGFNUXNFODFaZDg3SDJsMklxbmU2ZjlnZi9vUC8vZVcz?=
 =?utf-8?B?cUQ5bnltWHFRSDE0R1hkU1hjTWR5cktWNkF4TUh3eXRsL05XK29vQjEzMzdk?=
 =?utf-8?B?YUY3TVdiYVhUbkZ3WjFHREJVZ2FJdzUwKzV4aStkRTJnRTNuRmtvVDhLdi8w?=
 =?utf-8?B?dDFOY2VUQTBxSENhWHhKMWFsMGRERFRjMW1SWVNob0N0MHdYemt1aWREYk5P?=
 =?utf-8?B?SXVaQWpCSTMzYXpza3NvakxNNU1rL0RBRm1tbVMwN1JVckV6a0syR3UwaHB5?=
 =?utf-8?B?NGJKa1BzeTZxTXFkd1g2dzNWcSt6c08wS0VSU1k4L293cGs3aUpOclNZSHhY?=
 =?utf-8?B?b1pKRk9ZWDRwMGNDYmtROGpsVXRwczNuOTlOamI3SWQyd1ZiSlVqd0tTOCtO?=
 =?utf-8?B?QmVJZUJkZUJGR1ZWcjJpNnhBZ3MxWjQ1eUxHeXIrQlp4LzRwSEtTemVJNk1h?=
 =?utf-8?B?UkFmMGpBTmEyNUtEZXlndTQrVDYyQ0RRQnc2ajB6TkEyWXNJVjV2Tk1ET051?=
 =?utf-8?B?eXN5L1VpTFhsQmJMWnNXV3dkR2pDczJzUWNTdVMyNjNrSmhNM1JmSEZnVk11?=
 =?utf-8?B?c3ZLWm82WmI0TUEraE1RSGNQUlJlSFpYc0RqVUhqUnFML1pUd3ZxNit4U1dv?=
 =?utf-8?B?UEFIRTdCSjliRTFmb1BMalpSSUVFRlhIMjl1S3RzcllhaWFvcGZ5VWRJUXdL?=
 =?utf-8?B?Z29EbjMrS0ErREVTV2tiY1dNRFM2UlNrMUdTdnBkNENMYjJJUmhDZWtSTHBp?=
 =?utf-8?B?ejNpWEplaEhjR3AzZDM5SnFNMmljOHgzVHZxMHNIZnI0N1BweGZzWjd2Q1Vm?=
 =?utf-8?B?clZqSUl4R2tvQjBiUlJVQ0VIUGgwRlh5NXJDdkd4U0xuMHcrSUJLalFtNkZ4?=
 =?utf-8?B?NUlMbXZtQ1U3YXI1V3JxVW9OT0FrdGVqeWJFdy85cmhqNGhVQS9aS0ZnM3Ns?=
 =?utf-8?B?bGFONUVQanJZTmx2U21tT1VsOFJCUEVRWWI1NXlsb2l4dTRHeERJbTNwSkJJ?=
 =?utf-8?B?cEZmTklORHlGNHgzaGZRSjhac0dIVU8xUzFzTXhZbzRvWnNwNWZlZTVITksy?=
 =?utf-8?B?Um9jRXE1Z3BlbUw2UHp3NjQzQzgwTU9lUVdGZnJER0FmZCt0aE0rUlZVMUZx?=
 =?utf-8?B?Qzk3eDdrc2dNZjIzSkRvZFBuV2NWQ21jaU1GcGRzdktCYUZhSGViTUViMmxH?=
 =?utf-8?B?aWxjalFHWWIrRjI4ZmtQRFd4eW1IT3dDYmV5emtYeHM1RHozYzJwbjVZb2FN?=
 =?utf-8?B?ZFFGTkRjSkhPcktyT0lrbEQxU3NySEtaNlJTNXhXV2dVUTJucTZxanRwa1Fo?=
 =?utf-8?B?QmJHMXE4eGZBNGgrQzBhc2RPSnoyV25UQjVRM2lpSTQwZnkyWkFVMXRFNk5w?=
 =?utf-8?B?T0xyNVQrV0xVdUtvWkF6VGtCZzFxMWdJNGtXQ3o4NjErUkZoSDNCanUyQ0JW?=
 =?utf-8?B?dDdyT0tLeHR3b0grNGFlaXlBcHE1MnYvbG42RitjcWsvemxheHovL3NQajRU?=
 =?utf-8?B?RitEN2lOZnBaOTlMRDBSSkd0MVFQK3Jxb3MyZHJidU11QlJCMGpBb0cxUkhY?=
 =?utf-8?B?akdteGNzRmRCZHRKL3Jvc1FvWUNqU1BSNlhydkxKZjg3VERTTTIzdi9HL3My?=
 =?utf-8?B?OU9ndjdjWmFFMnJXWXdkcFpMc3V0MGVlU080a1ZpaVh2a2dyNEsyZm9aZTd2?=
 =?utf-8?B?WTlzQ1o3Nm9KREw5RGowRFRxMDBmK21EZjkzdXVib04xSm5WRTlDOUFaTzRu?=
 =?utf-8?B?dEFCS0ZEc3ZZM0xHUklRTUtyankxUjFQQXZENVFNVXFRc05ISUhnL1JlVjFV?=
 =?utf-8?B?bmh3UEFBQUJnMlpORjBSbjdhbGE5aVRTOGhBdVk5UVlpQUFoWW9JNkxWdkFI?=
 =?utf-8?Q?8oMc=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:26:41.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01f23a-52e0-4b7f-dc89-08de17af94f2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8613
X-Authority-Analysis: v=2.4 cv=JMU2csKb c=1 sm=1 tr=0 ts=69035985 cx=c_pps
 a=g4uZeTjY1y1IQa6Zs0r4CQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=-EtSkIF3whHXnZY0vQ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1Kow1_-CRHzvGoQU3nGgmbAZrF5C2rqi
X-Proofpoint-GUID: 1Kow1_-CRHzvGoQU3nGgmbAZrF5C2rqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMSBTYWx0ZWRfX87hLxVksLBRH
 3+UFMddiD7/miCI3vxYUtXChkNQHWi/xMTgovCDQ4G5e7RdG3lY35+NxSb4Wuy+ArGHrJcoDXJl
 yJYoYgeTsm57Y/MsjWvpP9lQYr+mJyuEp/sBsDLk3x0bRy26y0ZhvoCaYASzbVUcB2M3Gv5C40V
 4iofTWCItph1QRDUPR3vvmhi6xBWJ3xN6uP44psDrolS8EZ162wrPrkmMBDhEi2PUULRE43lNBl
 0K9erFcel8JAHteMe17Ymy28GnR0iykM9T6Rct2XIzGzI57o7yNUPGy0yvFXAh0nb+i9sazDnPA
 0vpwN7Gwr8m1rLV3ALQw/FpuxEbIkh8T34I6F0K+cE+BahCXwdzsvBk267vhuU2Nysds3PHSrLr
 CdAWpruBL8spPAh66Ri+Ia3RsL7spw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300101

From: Clément Le Goffic <clement.legoffic@foss.st.com>

m2m_hw_period is initialized only when chan_config->m2m_hw is true. This
triggers a warning:
‘m2m_hw_period’ may be used uninitialized [-Wmaybe-uninitialized]
Although m2m_hw_period is only used when chan_config->m2m_hw is true and
ignored otherwise, initialize it unconditionally to 0.

ccr is initialized by stm32_mdma_set_xfer_param() when the sg list is not
empty. This triggers a warning:
‘ccr’ may be used uninitialized [-Wmaybe-uninitialized]
Indeed, it could be used uninitialized if the sg list is empty. Initialize
it to 0.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index 080c1c725216..b87d41b234df 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -731,7 +731,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
 	struct scatterlist *sg;
 	dma_addr_t src_addr, dst_addr;
-	u32 m2m_hw_period, ccr, ctcr, ctbr;
+	u32 m2m_hw_period = 0, ccr = 0, ctcr, ctbr;
 	int i, ret = 0;
 
 	if (chan_config->m2m_hw)

---
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5
change-id: 20251030-mdma_warnings_fix-df4b3d1405ed

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


