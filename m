Return-Path: <dmaengine+bounces-7288-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCDC798CC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C73C04E932C
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4A34DB4B;
	Fri, 21 Nov 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IsifIa2z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF4350D5E;
	Fri, 21 Nov 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732246; cv=fail; b=p9RWgQ1Idp+9v3vTGzlwdpWHLAgVNfcFrXkM0yxNt+2eB6AjKHYhGurAOKv+q6CtfA9bTkvtuktziaGxVGP1Hj+nKkSOOcvOBORTkM4zgao5jxGN03I2RLhLHVQsNnh/G21OUrNQ40N/kPLP1I5iX1xRMJvTc6/7EnYxB9LJ9d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732246; c=relaxed/simple;
	bh=q6zvVI1FBYfnS4jPQlvT4PIc7R3WaSPn/nFJ1spvX+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NN8mlZPu1Tc3JH3zTvPkfmSHTRvC+iPyECTrqLwlYl9x1/KRJhR1RqrsGfsPKigiaE0xckVMip7dwm3BPcOF30blYv/hbcODdydB23u/9hONjHb1Es+ewkyOCvQL2oy+OaGMVBzpuAU9rJAcmzv4z8Ed8HEjavOmBcxHY4D4I4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IsifIa2z; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALDP1tA3755298;
	Fri, 21 Nov 2025 14:37:04 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajna5s12c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:37:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYdh0GQLbaeGjc6rSG2/HylXad+g9Eet5pb4qQIbhMwAonhn8sxUQkECRT4OPYRpx5XB4HuAyx/VEF643cahRYnUprBMqWVlzCpvMkhgB/vOKBdP8XzkPe/sgc7hhlKo1T8vHBg7NCmcxSojC771xMuVZk4PH6+t/N0oj/WMwurrpmWtwiI2dX1dBK66acQn8a8D7AAAyvt9B3ENHBihTiOCrbfOwgvr4woMNGS7IwMYxbta3vCzwqCHhZkkny+ILNi1zg33G5mCAD1L1r1b/nernjO4jVFnuoJCXIgK5WrwMuwlB2RXeJFUqeSBqIagA9Vmy+4v87ofxFCfQLUxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjYBgcTcnb2XTdgoCzHLv90ebNazMCij/1AbxUshzzA=;
 b=upOBkTp/D5BGzTMNxAOLrQTspi3V+UyDcau+/TWT+QWysyY/XAqvXYYPocWUJhJbRAYL0jtGWtbUOFY26N5QJRri5l3VqAeP4P/i8ln9xrecUCuTKhZCjyyohqBzP8rg7BDkUMAdQkJwieabioS3LY+7Nnh5D9XDlE0kX1MJY/tcguodBW37wzHFWKCxaf12JnVXer/cE0ctTSjPFfgVcdcImGQt2qs8Hnu80W69/HLMKR+s92fBfOwiBWs1eydcpGoi8BImwdOF4Zj2o3l/Sg3yTEmzpoOqQYKXLlOGn593/fBJHrz2SRFPN0HL0lQZw+WXWh08Q2tbzhri9GIdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjYBgcTcnb2XTdgoCzHLv90ebNazMCij/1AbxUshzzA=;
 b=IsifIa2z3CK2ptGkgl2LEUY4yuasut/KvV9bvHyvFsgcJVExNnVkK8XaQTu2S5GbLL05VCxG8hj8lA6vTgRjcPEhe1BLiFtPObgH3vTmqTdMoOE//bypK4QUY3ZzTgzQH1RWvoQGf5M2ucfO+gySSkKX6gCDMKb+QudX+nEUaQXNGxPvuP5Zvas2bhQnVpt9h1+MsX39xqMD11yCZ94WDEPGD25rJrFb8AUCSRkHBISdm9adEEhYk5XrF54zqH+Onk8M1XrRgo98QBQvLSkH5zSeSTrxcdKAlJqvjpWSP4G6y33nSfHZmi/Pl15o/E+Oh5+0KIFei2bo93FVUTQD+w==
Received: from DU7P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::18)
 by VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:37:00 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::ff) by DU7P191CA0011.outlook.office365.com
 (2603:10a6:10:54e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 13:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:37:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:37:23 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:36:59 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Fri, 21 Nov 2025 14:36:59 +0100
Subject: [PATCH v2 4/4] dmaengine: stm32-dma3: introduce ddata2dev helper
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251121-dma3_improv-v2-4-76a207b13ea6@foss.st.com>
References: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
In-Reply-To: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|VI1PR10MB3343:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a87863-2e82-4ee9-1b50-08de29030c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFBXNHczY1grdXRlK3czT3NYem14MklWR0J5SFJoOG9nYTdiVS84N2p2aUVX?=
 =?utf-8?B?NStuUWJjS2pVRm5Bb1RiamZpS29iS1hnL1pseWRnMEJzK2pIak5zTDBuWEtL?=
 =?utf-8?B?QlE0MnUrZGRJRG1NNkpYOEVpbldURTlublNWcFA2Zk1vYmZWU0ZWZW9Cc1gz?=
 =?utf-8?B?V29Pbm42ckFoSHM2NE0xMTJxM0M0Ujk4UjJaYU1MMFNON3dsUG5SczFDRUhu?=
 =?utf-8?B?c1pDZ1hYNGRWb2loMTVFUEpheVA2bGYxdCtWWkErVmFsL3ArZGx6NTBmK25N?=
 =?utf-8?B?a2JFYmtSTUxMUkl4VjRScGJyNUVaMTR4Rm1UWTNZUHNPL2x4UGwyUmFpN0tU?=
 =?utf-8?B?RHkrZ2FEUE1DTU9ib292WFJGZ0Nzb0NFOWt1WmdIRXhKQm1mTXdvMkNWOUhh?=
 =?utf-8?B?REJXMG9xWXpmK3oyaGJ6Z2pxVm5OZnBSRG93YjAwVU80WUZoMzc3TzR0VEVx?=
 =?utf-8?B?QXluSHk2S3VrUVF1UVlPNFJZUVFhdmxSeThEVnlTUmVRbFlQSGxQUVVUemFj?=
 =?utf-8?B?MGpCMDVMTmZxd0VPUjh3MSttTnBlUXFwTGZlOG1FTFpFTFJxMWNVNTFTenFl?=
 =?utf-8?B?THV3MktQdUxSeHZheE5qcHpBaENRVytHV25hb291L0tDK2p4QlhtbitnaWhT?=
 =?utf-8?B?eUU0L0VveE9PWG9MUWg4ZWszK3hMSjA4QjNxWGx0WjNVMXdUUUUvMHRCaWNo?=
 =?utf-8?B?VEI5QWcxd0hzOHNmVGhzNzZkaG5jYjIyRXB2NWZKUisrdmRRWGEzc1BHRW9F?=
 =?utf-8?B?S2xMYUZnYnRYaWFuZVFsaC9senh4eGJWazB1QjhLVUZJNHRjdERjc1dUUWJx?=
 =?utf-8?B?Qy9JOFhtcEZuL01XOEFmNXpHdHk5bElGTmJZMmU2bHZpZUN6ZUE5ZmxFMFhL?=
 =?utf-8?B?YjUrcXhaSTMxY0pHQmxVZXI3QkZjMGZCbWNHMEJhUjVidDhXUFlDeDY2Vk54?=
 =?utf-8?B?U2ZoLzljNzNPRFhYcmU4WHdYL1ZJZVdjQkovUGxwczJnTVI5NGlmWTRjSkpE?=
 =?utf-8?B?RHVlNnpoYld5cTJMUlZkZ2xrVWN6bGF2WlBrbU1HaWFKSFBUUzBlQlh0Ukc5?=
 =?utf-8?B?aElpS2dOeXh6MzJ3Y1hPampVTStkcFNKVzNmMXFvVkZFUXVhVmJBR0U2VnRE?=
 =?utf-8?B?Ry9iWHhReGpIVlNFWHUrYnN0VFV4Z1l6bDhZaFdybThrVHdqV1ZKdXZKMEJ1?=
 =?utf-8?B?cTYrL2p0cGZ2R3hzM3FKaUc4VDE4Uk9YK2RsM0dCaVV6bFhLTjFnSFpFN0xk?=
 =?utf-8?B?K0VPS29YOE8yZVJqUkJSSk9MUWVPOG9CYlZIVU13dzNrQ053ZS83WU4xZnBl?=
 =?utf-8?B?UVFLODlhWS9zZDFKaFlid3hIaUZaWUxnQ3NUeUNCRXM3U0tSVUhuRnFLMDZH?=
 =?utf-8?B?T05VallnU0RTeEltR3pvN3NOMytjYUppZnRpYVB2T0dqTVdtMllaanp0SXkw?=
 =?utf-8?B?eFk3M1AwaWdMM3RZeExjVVJyM29lZ0QvZXNtNU5BVjdXR0pSTm12VGZYOERq?=
 =?utf-8?B?N0hCR0M2UVdyYTc3NkpsQ2QxcDFvS0VFOGlKZUNlTGZqamhOS2MxUjdWZklO?=
 =?utf-8?B?NHhCNE5Wd254bHhqbENEcmIwUVBSRGo3QzBvQjRLK20zSEFWZW9kSlNMSjJH?=
 =?utf-8?B?YjlzZ01JRjd0aDc4aTVwTVFVd3ZiV2hXbGNVdG5nU0h1NUhyaFhQbnZZTm81?=
 =?utf-8?B?R1lhRUNUUEdsMm15cWE4RDZlRk03MTRuVnZmdzcxK2UvNmJPZVNvUUoxczJh?=
 =?utf-8?B?VFJBL1VqVDYxYlZrb1RGbjdHSXI3b251NHg5UmNZelZQZzRDNXhsR2lGSEZk?=
 =?utf-8?B?NUVPbFVzSk1PZGNlRkFYUFdMcVFDb2syOVFBREFSdmpJeVNWU1JMV1BqcGY1?=
 =?utf-8?B?LzJuREpEVENjRGVsbjRiS1NrYm5QMHQzSGVBYXFOY25GTGtidFd2bDA3SW5u?=
 =?utf-8?B?N2pKa0RYR29uYlFMNmUzaVpOWlNtekkyWElrOW1qaGNBNnIxcmpaRG02YjJC?=
 =?utf-8?B?a2xiOW1paStQZ3phN24vU2NCaTZxdnJLd3FGSXlBcStYM1NkSWZ2OHdad2Vo?=
 =?utf-8?B?SDUzWjB5OXN5MEdhWlk0ZXNWSkQrU0FuZWVnSm14a0FFSkxnZ2t1N3BXRGxz?=
 =?utf-8?Q?03lM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:37:00.0399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a87863-2e82-4ee9-1b50-08de29030c53
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5OSBTYWx0ZWRfX5qttP84FGHID
 g3Tf4QZLCJCFHFrszc3i4Hfkit6qlkui9oQySK2tJPL1MAI6+z/xiL8jWdl5AIjUzUXUs/8yGcg
 R/3hesqZcdvercgNYLIgrsMHOkbDL/a0VUFCpS2h86GYXxnWvWatnIen0Ag4b/mcipdvWm7sfmG
 VbYT5gy5fm84PGJN8ns6Z3CGUlPpPNRp7mik5G9i7CBeVbxuS9V1P34RhJk0luRS+dHS7XQqgoL
 v6peYLsOqem0rKBeX0J+EtwzOTdJckegOU8I6EaBuydc68s92XjxK3eZOrLG5QaCeROBvHz3ZKT
 NU9YT2jxodJmUUTtV+t7jGGzd+phkukmSMAkhs2zV+H4KZJ3X688M/pIxcFq0UKfb1lQONBLQc+
 fdgx90cA11s135Fk6odLG3S4tk2VdA==
X-Proofpoint-GUID: 1zJK8M_AFFOxiwKU5Nclh5sMM5NEU5SH
X-Proofpoint-ORIG-GUID: 1zJK8M_AFFOxiwKU5Nclh5sMM5NEU5SH
X-Authority-Analysis: v=2.4 cv=YLiSCBGx c=1 sm=1 tr=0 ts=69206aff cx=c_pps
 a=v0EG2prNrbZAmvYa4Zp51w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=KjfASy0ghDGyr30XYOQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210099

The purpose of this helper is to 'standardize' device pointer retrieval,
similar to the chan2dev() helper.
ddata2dev() helper returns the device pointer from struct dma_device stored
in stm32_dma3_ddata structure.
Device pointer from struct dma_device has been initialized with &pdev->dev,
so the ddata2dev helper returns &pdev->dev.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 29ea510fa539..84b00c436134 100644
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
@@ -1110,7 +1115,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
+	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
 	if (ret < 0)
 		return ret;
 
@@ -1144,7 +1149,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 	chan->lli_pool = NULL;
 
 err_put_sync:
-	pm_runtime_put_sync(ddata->dma_dev.dev);
+	pm_runtime_put_sync(ddata2dev(ddata));
 
 	return ret;
 }
@@ -1170,7 +1175,7 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
 	if (chan->semaphore_mode)
 		stm32_dma3_put_chan_sem(chan);
 
-	pm_runtime_put_sync(ddata->dma_dev.dev);
+	pm_runtime_put_sync(ddata2dev(ddata));
 
 	/* Reset configuration */
 	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
@@ -1610,11 +1615,11 @@ static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
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
@@ -1636,7 +1641,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 	struct dma_chan *c;
 
 	if (dma_spec->args_count < 3) {
-		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
+		dev_err(ddata2dev(ddata), "Invalid args count\n");
 		return NULL;
 	}
 
@@ -1645,14 +1650,14 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
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
 
@@ -1665,6 +1670,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
 
 static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 {
+	struct device *dev = ddata2dev(ddata);
 	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
 
 	/* Reserve Secure channels */
@@ -1676,7 +1682,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 	 * In case CID filtering is not configured, dma-channel-mask property can be used to
 	 * specify available DMA channels to the kernel.
 	 */
-	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
+	of_property_read_u32(dev->of_node, "dma-channel-mask", &mask);
 
 	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
 	for (i = 0; i < ddata->dma_channels; i++) {
@@ -1696,7 +1702,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 				ddata->chans[i].semaphore_mode = true;
 			}
 		}
-		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
+		dev_dbg(dev, "chan%d: %s mode, %s\n", i,
 			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
 			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
 			(chan_reserved & BIT(i)) ? "denied" :
@@ -1704,7 +1710,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
 	}
 
 	if (invalid_cid)
-		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
+		dev_warn(dev, "chan%*pbl have invalid CID configuration\n",
 			 ddata->dma_channels, &invalid_cid);
 
 	return chan_reserved;

-- 
2.43.0


