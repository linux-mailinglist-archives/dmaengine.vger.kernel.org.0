Return-Path: <dmaengine+bounces-7049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4229C2AF6C
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 11:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35E2F348B0A
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9452FD661;
	Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fA4vzBYQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34974299937;
	Mon,  3 Nov 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164950; cv=fail; b=a2LtAC5xdX2kx4TEJt6LIyDRrVb2qbOX+QtgeaHx7uKzzY+AB+DplNUk+GliLyLJQkH9Le194znkgz1phRUdSlzGBcmht3GIg1f8/2GrTCckqgPyXyQueUqv6H3ZO+GcYRN5bluE1GOygOXG+PJ2wb3nsCAMo4rdLKq0LFgK9ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164950; c=relaxed/simple;
	bh=JhAblUzK/lEjzUqJrvBqNuXdqBNifyKatkN3QaQ9vK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BFYxhpMbTySWBCHpJrhFrCU9tQoc0DhVqUTRdepgt2b82MH2jKOs2sVOKlKJnpdWeEyMiX+hoD/nt4IYyAZOi9tq/sTTgRh9zNa7RrGQkS0DCemoxiSsUowzdFH6SAcHz5jevTE2qRkWLjVwnawqQqzsHGcUG4z8ZPxXuMIVURQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fA4vzBYQ; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3A1cXU2940238;
	Mon, 3 Nov 2025 11:15:25 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a59yh7500-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:15:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKixfN6obg/kpJ7hptkWsLzRgUd4eRFKVY2DZFBfmEuwkFPA4ZsUsXcCYbKenDvYuuSKTUfrAzSRLecNPFNnckVcbviHm129nA9z/YGvCXpxlGAb8Huar+YsHPetswWr9cOBsnU4HHojibsfxTfKyHOGITcoE/dCt21OOO5aw/pcSKm5O8F8nqDKBtrgLECdh5T6fwqEQDZAanQC4ZfYnuu/sP6QxrtCSFr5CUuk13khlYmyNCip7wOmqI7KnfrZsm/NoANPinJkFWYrcXdv3AzBGJLnZC2wK/wBCCtunIdXESqgt+yXUdigSvrRGy268lJiGSw3EAb1pSS7TFAuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEMvfbw1YpaH+jlAV7LMPtiMc2am6IELehLiW859ycY=;
 b=UA3fUwW2I3J98LntQnvb1ECEQOigmu9ANzabH4kUd9oGhfZXnCxIMDQRdalOxDPlMr3xcQQ3UuXV0PKD/nW6PUmOTnaukjlboIcWypXA98dm0X+FjyhfFYIZ7sefSDahgI4wq+as9cj7+GucAVapIIIzEDPgeMJNGmtH89tpJWAR9ILwy+v54zrnzMmIxLkSz4lHymmWVk8qimoec3yOtLppOtANmyMJ1B9SwyIf0jRiliBBiTBm4bPEybn8BYhzbIyncnV4b5K1LG6Y+jE1Lqy+ydglyMUiYIZGiXJ6gQ1fnsIQyx4VMShZoRLQAddsJp0yieez0/6YQEfeo400Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEMvfbw1YpaH+jlAV7LMPtiMc2am6IELehLiW859ycY=;
 b=fA4vzBYQEn1e9DoCpGV1RC26km2PMRn/3YNm5OethElYun3VAZIbcpy/mfT9bvzkDbwZ+0s/25He5FO3nk8e7aAKFQ2isbgro/20H92+XC37b6YY18vEMB+50TC9M6HOpIpGj7xWArgTMZGtEtEWwBsY0ZWJ1N5SNTkzFp4pBLFTxewp+NlSg6v89QaBB1qzEsFmYmtQv6q5VFJNrTi2btj2H75DQy0UQvNLcc5liEdREVHT5/N1UmEcf4Whc7RDlSX9f5rN1hrATWv4qR5TAiyxsuLEmSQYR2JaD5UI84vGdA+ikSaJmngEipHwBa42mTD6oxgCDo7b1ipD0q+MBQ==
Received: from DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) by PA4PR10MB5611.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:264::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 10:15:22 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9e) by DUZPR01CA0265.outlook.office365.com
 (2603:10a6:10:4b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 10:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:15:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:27 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:21 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 3 Nov 2025 11:15:13 +0100
Subject: [PATCH 4/4] dmaengine: stm32-dma3: introduce ddata2dev helper
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-dma3_improv-v1-4-57f048bf2877@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|PA4PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 03411391-eb68-4765-80cd-08de1ac1e5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGZCVEN5U1RqSjNiT2N3MjRacW1DYjJvb3VCSXN6M2dQQWJFNGVZY0RBTFhy?=
 =?utf-8?B?VS90QzJ3WllnTURSSzA0Myt0VnFwSXBib0FBNzh3RDRtcVpxdlA2RG9IQlBC?=
 =?utf-8?B?dXZ2cURvTThzeld0bWpZamZRY1VPZjEvMUQxNE12K0dnL3BUVUtkMGlMdW55?=
 =?utf-8?B?WnlJL0w2cnVxYS9nMm5QSG1uTEZsTkU5N2RpRlZOQUlOa2tqTzgvYkxBUjBo?=
 =?utf-8?B?L2JYRHkxZWtKMFBDeTg0cGhScGMwWUs2elBrZVpKYWJRdmRZU21yMzg4NVFk?=
 =?utf-8?B?V3BkbEQ4M3hnMU1VR2tiaDFSeG5raDJzb1B6L1VXZXBVQ1VqNUpJNjlnYUZE?=
 =?utf-8?B?ZGZNdXh1MVp0ZkNLRmFnN1VhaTVUN2VGQ0Job3VKSUVqZlJKcHZnYWh0dC91?=
 =?utf-8?B?ZUNPSVRVek54NiszQXNwOHFWVXdlQnB3a0RQK0I0ZktnekFPakZHTm4zZ3lW?=
 =?utf-8?B?elRiS3h4cFRWaXJjWWZPV05naEM4TWZtRWNHOURIUmFTblVVcUc5MVBiZFVH?=
 =?utf-8?B?NHRmdFRkZkJ1MEYzUGlmOU0rUlNsNjhKUkQyZmRDcWg3RGdFa1NaLzlJemlD?=
 =?utf-8?B?VUVIS0ttdkZOb1BjVVNDaHpKTmVrV2FPNnlTT0dQYjZsaXY1S1NITUJYMjZV?=
 =?utf-8?B?RkpUcGdSVnQwdnZJblR0Tk5FblI4enJJRGRvRGVDQUJGYU5US3M5Y1owYzFo?=
 =?utf-8?B?YWZFeHR5MHZNT0syQjVYMTE0SUhTb2lUYWk1RUFhT0NkYlRXZEZGUGNudlhJ?=
 =?utf-8?B?cWxmUWgyUnNEdWhnV2g2SGRwN1l6QjZYVDFtMmoyeTFVbTAvU1BYYURpcHRD?=
 =?utf-8?B?UGJSQ0VUQ0o3ejdOSXA5ZTJZS0ovSEZ3a3ExR2NQQmZSQTMxbkMvQ1R1RHlC?=
 =?utf-8?B?ME90bEt6VDY4SDF0dEpSSFZtcEhPNFkxWW9RUk95a3NPcUtuWEJkTlM3dktZ?=
 =?utf-8?B?YmdodTNlMVlVVjlQRlhBRGF1K1lkSzU5ZXo4bENYeXF3a21tQU5oUitFOFNH?=
 =?utf-8?B?RG5PdmkxNTZubVErWUxNNm9uZmpjaGM0ZVJKbUpESFBUMG9mblRUSVRMM2Fv?=
 =?utf-8?B?Y1NDZ2QzYjlQSmtWeVYrdHNCc1ZsZVA4Tm9kSFRyVkV1Z0ovWmRjZDM0YkxD?=
 =?utf-8?B?bGhSeWlJYmR3eGJzRG5XSjJudmt4ZnJXZHFUVjBRaE1YU1A1S01nVG4vQkNh?=
 =?utf-8?B?VkxSR3hqbFlZUVVXMFJXUlAvNmJmM2FFTk1adjFURVN1NFp4aTNBUWFPVkJz?=
 =?utf-8?B?ZkFkT0lhcDFiNTYwU2ZLZWdNSkJFZ2w5QVdBd0FuMERRYzVCRE40WjJSTTZO?=
 =?utf-8?B?eFR0SkhNeExoSTUvRlhUVGllSUZCYTZXZnF2Uk5vZEg4R2NKWktybi91NGwy?=
 =?utf-8?B?d3l2R0E0azYzYUtFazhoN05pdEdMaTVKUjNCa1pGN08yYWkvVGJBRDR4eDRj?=
 =?utf-8?B?UllNQWlyRXppbWtXNEJSdGdSSTl3dVVrV2tJZksvR3h3TkhyZVBmbXlSMmJo?=
 =?utf-8?B?S1YvdDljY05velBjQVlOOWl4VkdBVWJ6TzFJQVdQMERDdjR6QVVKMGF3SEk1?=
 =?utf-8?B?QlhCTmNDb1hrOUhWYW1ROEVzbUVuR1JWSm56N3FndWRqWFQyaFB5L3dFTGlB?=
 =?utf-8?B?VWZqRVY1Z1J4REkxWG1PL1pscTQ3VEFkOHB2ZmRwS1IxcnZWSWdRVDNlbFNS?=
 =?utf-8?B?SkhzTHBwbWtRTENjUnV1OXR1cEEzNkhkalh4Q2t5WjZpdzA4SWk4eEo2ZFA5?=
 =?utf-8?B?S0QydDlFR3BJQzhMb1ZYaGxwZmpTeG56MW5TcllteTlCU3R0Uk1LeW1zbkFq?=
 =?utf-8?B?WkdNZkFBZmcyYnFMZHpGVjBiZkVzNXJmUlVXUGlWQnVHbHRHaG9NcnNOV2o5?=
 =?utf-8?B?YnU1YWJoT05OOFFVd2FqQmtXNFJtRkRqWm5mdVFQU3V3NldqeVp0WVJsYk5E?=
 =?utf-8?B?WFFaa1YvUDMzVlVYNk12QXNFYTJYT0ttVHNFS2JIaE9iSW0yMk1WMWY3N0I2?=
 =?utf-8?B?NU5EcTZCejhIMVBlYzRuWTdwSzFGVFhydTNGdGk1SHBZdmdQR0daU0NHelN6?=
 =?utf-8?B?c3ZseitkSTNrVGNtSmdmWFFMZDlOb01tOVFpY2U2UDdBNzV6NlJsc2hhRkdw?=
 =?utf-8?Q?Dajo=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:15:21.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03411391-eb68-4765-80cd-08de1ac1e5d3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5611
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=690880bd cx=c_pps
 a=8eICi0T5piXUlVsTGmI7Kw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GJ4-7_mLddwLbvePw_MA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: a_QYeUtjh-aHzTa0AZFS-Bsf63avd-6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfX5NHqWC3cz0fr
 BkrAnVpWtLtEZ0gBPM06ZZ6FQBIrQow7QDRbdgcatpltQ5qVeysQCCrMDh7YzaFh2LtSLUeHP+N
 UqhLmChjEEZ4ZsZVjACDVABXHULYN+RumaP9hQ8md+Rz/yczUHyQn29TXRPFCm+K1wyTdGjpNIK
 9cLwlwHppOYiJMy+u7BAej599sIOV7U+ZKCtMqADRVlVHhI4yJFbVwxnpHD05YSGFdITAalYB+U
 1Lkz9wOr2Q0Z/SoTtJmSa4gAPI4AkzRaGODC5kH24kCb2KHPBBXbVrk6COIspAlGPacBCY3F+pi
 aliKUP4KmMPlCiYd907KzltFcg4VARmDrMMTLH4VsTYmwCdFZDPUxGg5EZ/Qu/SZrYyHYmeN8rW
 5SA56Gu/0JgZfdM1hPDWF5QrM6zk4g==
X-Proofpoint-ORIG-GUID: a_QYeUtjh-aHzTa0AZFS-Bsf63avd-6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030094

ddata2dev helper returns the device pointer from struct dma_device stored
in stm32_dma3_ddata structure.
Device pointer from struct dma_device has been initialized with &pdev->dev,
so the ddata2dev helper returns &pdev->dev.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 29ea510fa539..9f49ef8e2972 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -333,6 +333,11 @@ static struct device *chan2dev(struct stm32_dma3_chan *chan)
 	return &chan->vchan.chan.dev->device;
 }
 
+static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
+{
+	return ddata->dma_dev.dev;
+}
+
 static void stm32_dma3_chan_dump_reg(struct stm32_dma3_chan *chan)
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
@@ -392,6 +397,7 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
 	} else {
 		dev_dbg(chan2dev(chan), "X\n");
 	}
+
 }
 
 static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_chan *chan, u32 count)
@@ -1110,7 +1116,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
+	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
 	if (ret < 0)
 		return ret;
 
@@ -1144,7 +1150,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 	chan->lli_pool = NULL;
 
 err_put_sync:
-	pm_runtime_put_sync(ddata->dma_dev.dev);
+	pm_runtime_put_sync(ddata2dev(ddata));
 
 	return ret;
 }
@@ -1170,7 +1176,7 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 	if (chan->semaphore_mode)
 		stm32_dma3_put_chan_sem(chan);
 
-	pm_runtime_put_sync(ddata->dma_dev.dev);
+	pm_runtime_put_sync(ddata2dev(ddata));
 
 	/* Reset configuration */
 	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
@@ -1610,11 +1616,11 @@ static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
 		if (!(mask & BIT(chan->id)))
 			return false;
 
-	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
+	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
 	if (ret < 0)
 		return false;
 	semcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
-	pm_runtime_put_sync(ddata->dma_dev.dev);
+	pm_runtime_put_sync(ddata2dev(ddata));
 
 	/* Check if chan is free */
 	if (semcr & CSEMCR_SEM_MUTEX)
@@ -1636,7 +1642,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 	struct dma_chan *c;
 
 	if (dma_spec->args_count < 3) {
-		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
+		dev_err(ddata2dev(ddata), "Invalid args count\n");
 		return NULL;
 	}
 
@@ -1645,14 +1651,14 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 	conf.tr_conf = dma_spec->args[2];
 
 	if (conf.req_line >= ddata->dma_requests) {
-		dev_err(ddata->dma_dev.dev, "Invalid request line\n");
+		dev_err(ddata2dev(ddata), "Invalid request line\n");
 		return NULL;
 	}
 
 	/* Request dma channel among the generic dma controller list */
 	c = dma_request_channel(mask, stm32_dma3_filter_fn, &conf);
 	if (!c) {
-		dev_err(ddata->dma_dev.dev, "No suitable channel found\n");
+		dev_err(ddata2dev(ddata), "No suitable channel found\n");
 		return NULL;
 	}
 
@@ -1665,6 +1671,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 
 static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 {
+	struct device *dev = ddata2dev(ddata);
 	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
 
 	/* Reserve Secure channels */
@@ -1676,7 +1683,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 	 * In case CID filtering is not configured, dma-channel-mask property can be used to
 	 * specify available DMA channels to the kernel.
 	 */
-	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
+	of_property_read_u32(dev->of_node, "dma-channel-mask", &mask);
 
 	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
 	for (i = 0; i < ddata->dma_channels; i++) {
@@ -1696,7 +1703,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 				ddata->chans[i].semaphore_mode = true;
 			}
 		}
-		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
+		dev_dbg(dev, "chan%d: %s mode, %s\n", i,
 			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
 			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
 			(chan_reserved & BIT(i)) ? "denied" :
@@ -1704,7 +1711,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 	}
 
 	if (invalid_cid)
-		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
+		dev_warn(dev, "chan%*pbl have invalid CID configuration\n",
 			 ddata->dma_channels, &invalid_cid);
 
 	return chan_reserved;

-- 
2.43.0


