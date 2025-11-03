Return-Path: <dmaengine+bounces-7050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48216C2AF6F
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D3348B13
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308322FD692;
	Mon,  3 Nov 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Mg2h7G21"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E52BEFFF;
	Mon,  3 Nov 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164951; cv=fail; b=VITtH0BKeqi5b+QvsTOKmdh7NBdZAsOVEnuaASGVkSYzJCN93/v5Wd071TqtTWNRu/3jxUHLnpa5wDe5neTPnOUPZ7LHMH7CQwoESXa3bQDjX+FFIfnD4JogSCYVBsGs92LLzutSrXb8cqADQvcbpqy0fnbZ5RGkcvwehWU/dEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164951; c=relaxed/simple;
	bh=J3WxMecJJ4bhWvStrd9xBw7mToG79XNiaSes2E/tCBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JSwPVsiGCXyo1MUM8KAX0uKPbxJ1XhXAQIdlP9nWlrYx0vuUaRxPNSqBhGpC85zGuKZiwXsyjctGVc6kioFx9DOCpNLvJ5J6m1dmbJKm/9cNKHJYbP2fLnahy7xWtp7jPPw1mXu1BfJNwTmE+FrB0hFU7g8vU2GCfM+2F/IIrn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Mg2h7G21; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A39xBEF3121009;
	Mon, 3 Nov 2025 11:15:26 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a5x1pvs2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:15:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn9Mar/tM5hyahiXHtQlihIiqG+zC2gBF5ual4bzTvkPeG86j4ymkWhQStHO14I7F+w50YA6RoCgWWdfyzueT+vnaiEncqQv+GyXIWAWL8LkK7Bq7pGNBpjAsvOT4tTMZrH5ZJ6PTWAgSMsMpxLCAhIRpR4Z8o4RoKNGilZUxsazTkBUB3eCwQ516jyLZA6nCXY1+VmjKQg6fHyyTauhSkos1eVAF2hqWT9Z+IRf7rVslrAb3CR8d0hcRai2ocVyj5bsjFOi+xPgp4vwbdt2/yHYpwnpAmAqNahIbf4Mgj9VDOKAhYvxHb4ltLbXyl7OIX4FMlNyCYF1h74vvakSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjIU6dtKzQnv8gl6lgFFawjXO+GC4vRpdEIgal8lPfk=;
 b=kTj/pDropDsEpTwEXpSGoKxYwqsBd7D0amRDayQZgkXxopRug9kS2ECpVLBARwVrsnmh503RO9IA8hHx+4MxJSHw0LvmdSmf4QN+LoLyPPtsoY8Rq+GgVPhNHyCeX8scMvsnxaK4EpEJrb4+ikbzC+Dn38ULtZMuSXb3kPCmF/sG8mgoPTnR6dsRnPJ51pv9d6C+OkCAIwjG7r7ZgXLO23wGiU8NZM0V7Lu0C9NrFAZqert6adsp7QOCI/DIoy74bpDqt2JrH4v+j4f3oGG/7p8HV61Ck5kDqeercB582wnQYyqQnW1kOBmwVyarLLZlQPlTVu5IIyDur1Vg7pgcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjIU6dtKzQnv8gl6lgFFawjXO+GC4vRpdEIgal8lPfk=;
 b=Mg2h7G21inpxgLxBjy8tEFTOMYkcvW3j4Z5gShcltg3WPWzMvZZHBpwvJQhZpFnRkLS5PKEoRZPe+lgqZACKMpuee6m+9tT1a+0UHtqeeGniwIWzKLZhGXi4y5sjWqfNeR0g5q5yDuXxiwBDQmPhV126wB5JRhZj4TBeuPMb6bphF/sKaYKjH/SNWTOeRrOf0vbmzqnMKb8orlKqnfZ3+/Ixqaq6nZfd8L/kCWbbgWEzNTe9UDcety+xcD5zycnJTxSRK0UxShp/fky14SAFilY7/DsWowtyNch3unHFTB9/MjZ8Mn56MGHGrJ9zatiaPNqB6pwDIpkiXiaHMwikjQ==
Received: from AM8P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::20)
 by GV1PR10MB6562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:15:20 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::dd) by AM8P191CA0015.outlook.office365.com
 (2603:10a6:20b:21a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 10:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:15:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:20 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:18 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 3 Nov 2025 11:15:10 +0100
Subject: [PATCH 1/4] dmaengine: stm32-dma3: use module_platform_driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-dma3_improv-v1-1-57f048bf2877@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|GV1PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce6dfb4-593a-4fb9-c007-08de1ac1e497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnpwOGdrVzgvZ3Z0cFRNdHJwTnh6eDdCK25NZzFPT0JCdGxpWU5sL090bW5a?=
 =?utf-8?B?cVNDVUZ3Tmw2Ri9HeHlPSE41Mm51Nk1xWENld3lGck5KTGxjU05uelZKYXhi?=
 =?utf-8?B?STg0MTF3RVZad2pkU3Z0R1RHajdTS3FURGMrbkR2V0NpeG1YM2lPVTkveFVp?=
 =?utf-8?B?OHpibjRibFJhTVJQNHpzeGFjWTY0NWtqVmFJSnNMNWVrRGNyUGwyV25LOEJP?=
 =?utf-8?B?dDNReVAyQ1Ywak1nSmZrd0QyajZURGxLeENFQW5lQk02WGZabzNuT2VDMTJm?=
 =?utf-8?B?UGZGWXl0S0RnSGVITTFESkJmWFBBd2xZOFB5ZHRBc2tENUFVdDNHNE9scEdl?=
 =?utf-8?B?Z3Axa0MwTVZESUQ3VTNjVDlYeHdBOXBjdVYvUnpOS1NDUjF5RVMvQzlhUk8w?=
 =?utf-8?B?KzQzTmc0KzlCaEVINy9xZEhLQStkeTZhaDE1eGIvQ1BKU3p3ZGdhbitra0Mz?=
 =?utf-8?B?a0JYaHd1eXBpcHh1T0QyMVNhMTRYd3JHSk1WTXFGa1VuYko4aFJ5d1Q0T1NI?=
 =?utf-8?B?OUx6V3o0UGpFNHY2enlYS3h4R0RkbkNFTjRKcDBmd0pNSVJvWEhYdUM0N1FJ?=
 =?utf-8?B?bDJzQzcyemdqV3lvL3FEeEZrUnhwY0hYc0hIWjRDSytqYWtBMVdFOXd2VlNh?=
 =?utf-8?B?UWtVTDQ4NW5FQk1iSE4yUmVRbWdCS2xidlVMYkswVzVBWHozYXIzcFRhc0xr?=
 =?utf-8?B?Umt5QXBtcmRiSXlWYmg4OVR5V2RzUTNRbXFlK0IzT0NnK0JtYmVOdWo0MVVB?=
 =?utf-8?B?OE02SWNzQnIvQXNBRmxlUFo3Vk9aWlpzalFwSDd5RkZsbWloMkZNcVFlakts?=
 =?utf-8?B?KzBNSC9ObE5FbzZVNUprVUNTeHdVN2RGcXdtWk1uaUZSZk5jVVhob1hNMVFC?=
 =?utf-8?B?dmRKZk5jOGtvR0hVTnFwTnlLaE8zMGZ1MW8wUGtqZTJWRng3eHFBdUZYSjNu?=
 =?utf-8?B?ZitXdjVMNVIwV25CTWpNNTFEYUpxbHlHQ0NEaXlCOGMzWnplZXZKZUNYSlJa?=
 =?utf-8?B?NmMvQjBiaGlpNnpjaDFSOEY0bElvcStPZkVHRWc0MTY5MFcyeDdkWk14elRR?=
 =?utf-8?B?dUFHTjBsL0VBTTBGeU44dXJGQ3o1NkNNTko2enhLQXpFVGRGTUtGN3hoMVdC?=
 =?utf-8?B?SUUzY2RhcG4yMjBDVjlEMlhTZ2VERmw5T3g5Z1RLYnpQeWFsT2NqQndveTJS?=
 =?utf-8?B?ZEw2UDFxMUprbndZdlcvQSt3VnJSZktJT1BnaFVjSk1lN29tblJ3MStJRTMv?=
 =?utf-8?B?K092Y2ZqQU83bnpiQXRzNzI2Z2FpWVZ1bDJ5QkRHQi9hT20relZzN2pXYnl1?=
 =?utf-8?B?SFQvc1FDN2JYRVFPV0M3czljQUM4ZTBiUExkRTFKRFg4WFV6WkpRYWdWdUNx?=
 =?utf-8?B?U1JXQ1c1TG1yTlB5ekdoUEdndklCSHZhWXovQitpbEdhNUVSMjZkSFBVNzR2?=
 =?utf-8?B?WTdxMlY2emtiUUpYTzJwMU50cjZIcHZUbTdNWkp2ZnlvNGxSZ0YwUW1memhY?=
 =?utf-8?B?ellicmlqemM0OENrU1lvOEkyemd1U3JKWmVucy9QdjBFL1ZyWlRVMnZ0cDBP?=
 =?utf-8?B?QThCc3c0bmt4RkRkcGlUZFhkcVhrTW04Mjl4ci9VSFJRaDd2a25odXNOeksr?=
 =?utf-8?B?aGREdENLUjFVYU9zYXZMVStKekJtQnpId0thbkwrZFUzcGFQQysvNHZhN3ZK?=
 =?utf-8?B?eG1zeVVKSFk4ODAraFdxNW54aldhVFlLYUUvbTd1Smt0ZldyZGIwUGxLaXpL?=
 =?utf-8?B?TzNabFpNMmt2OW9OUENjcVJORHdwMmd1ckthNnFWV09iSmlqMjNCVTZVVWFF?=
 =?utf-8?B?NHdtTExYTGx0SzA0bjdhN0dJWHJUV29tMDVKdENQdkZjcWV1NkZ3QTlHOTFR?=
 =?utf-8?B?aDkzSXlXcUYwVE5teWJhcytOeDU3TmNzTWh1KzRmenFJOG1FbzFwOWhwRGlZ?=
 =?utf-8?B?YTRBbU4rcnVJR0hDdkVpUzFKRFJTRnRwdGlKUFZyL0lBYld1TXp1M0JxQnZh?=
 =?utf-8?B?R0E0ajNuOHRGMmZZdFdOTDN3RmtOY1dTMGR3Z00xLzJuQVl6amhOcExwZzNk?=
 =?utf-8?B?RjFob1hUMG90em1rRkYvTERuTzhya3g3ZTdQNXFPUWdRMmE5cWQ3Wm1YS0hL?=
 =?utf-8?Q?Z4Xg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:15:19.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce6dfb4-593a-4fb9-c007-08de1ac1e497
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6562
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=690880be cx=c_pps
 a=TR6k4uXGNafvMVVnxx+vUA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=B0u0qpW-aHUTvGdyuXcA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfX2/AnjRehLt74
 29PqRzHKEHB/TnDtBWBJrbO85CBLdX4SWdT561yRaxp5Xd4gjC6BOgO7k6IbvDAj/NhRS6n89Pv
 0rGcOqoAgjGuI3Rwls0y9LrnYMu4qm/dbLcEt7Y0K39z6o/nnAWE3wbiAGNHDr8bNmeb3KUtrl5
 wgzHGBgwnk7iNsKl6pHfz3CfTQ4+Y7Aw9yxVxjomsVs5fD9rgvkW52x7H44VvXc+pnBP/LZ0uw0
 YoCf7b6iJBKlfzg7nmSANr5h0qWY+DuI1hjnIQEWhN93HjLZndXbIxXEI8NFcHEuzqnYIvUMAAy
 ajkTJk2WitKDOlnQhBFqDy3aQsgMf3n/7r7bqacR9rXYEKErJFRbKEfsmx2oaF6DjNZSPUFBh/I
 nJkwwwFS4jqc6g7sr/+15UUS1ag7Xw==
X-Proofpoint-GUID: khRBZcv98cUlVGZ-darwDZZXAlLjlYh3
X-Proofpoint-ORIG-GUID: khRBZcv98cUlVGZ-darwDZZXAlLjlYh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030094

Without module_platform_driver(), stm32-dma3 doesn't have a
module_exit procedure. Once stm32-dma3 module is inserted, it
can't be removed, marked busy.
Use module_platform_driver() instead of subsys_initcall() to register
(insmod) and unregister (rmmod) stm32-dma3 driver.

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


