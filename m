Return-Path: <dmaengine+bounces-7047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35FC2AF66
	for <lists+dmaengine@lfdr.de>; Mon, 03 Nov 2025 11:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05707348AF9
	for <lists+dmaengine@lfdr.de>; Mon,  3 Nov 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95D2FD1C2;
	Mon,  3 Nov 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BSo+tHIM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B22BE631;
	Mon,  3 Nov 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164949; cv=fail; b=HXQ81ML11ygUEaa5uZFH6jkWCNziCyKHb3yJzyBkcvn48FOSudeSzRmhIE4L/hBkEQpt4n4+wfHbI6ldLb/Vg6LwA2hVqPhZgNZFcp5LvXvzyIHU/vL0JuaOtFTj3FddzbLz63R0bdrH07ioMZ7vrwJ95B8Sq2lWhRr7zbwWFZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164949; c=relaxed/simple;
	bh=1+qv1f5DrIcy+BYE2rvZi0qTtFznKDwet9+Ef7xIZ5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OELk8UWFzA8IsmwEV81ARTdsJYPGqvHD2RqH47v65L00vnpxvTl24uPUwnmrNP/tx9HR0Iujrd79/JInC1hsQmo6eGOLenz8mNRPig8trTpQtsvOwM201w2Lv23G42kfZc0Z2mqWzbqG8Dxn6JE/U2GOL9+TMuLzuQ8g0CHyK7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BSo+tHIM; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A39eEbe3085733;
	Mon, 3 Nov 2025 11:15:30 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a5x1pvs3c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:15:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZImz4sssYW7cRMNunm8cYt40u///taYBVhHT0Cn0yab035kRTH7C1SUR760aKI5Lqm328z1rAC8x9BLlssiuzTnDnGzST92UqEFXvrmvY7qqG/Fcj6BUoRplXVberaOwBxUzSnNm5oNIhHqM7Zyei1brQwm0ADbCdMM9FP/jZU1Xx7A8+RcpNjHL6FIcGttVxCsM4aHmAUIhH1/OpCK0vYH2nNGx27Ws/NC9jNAVBNeU6RUeC39SR2KfygSINKKCWTCc4PXG1vMxEfkab9d1QIXf/VFrBes6Xag1Bw31BPJu5ASDrhs++iM7WhmM4lJQjeb7vVYUSFlz8pGS6/J3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5CPpicLB6syX8ieiQaFnM8h5u+i6mxI5fEusx0878k=;
 b=tHOiZzDfxngRfSArxkN+Q79Tmfn4y7HQ8SBd8852ayoM9oupCh+8pY90CTZMZXHkCdqVs3CDCAaO+zA8xG96rdoN/9AkpJ95cG3YCXjvDg6PLy9T5jp+QocMK7+M5NVlGtAb/T1w5y1v3YTHp/7I6z4WME4LYQtfR4RvgFBsQaDZTCOYQ8H65ad0MOjHIL1MgV3yCMjtIhmQ1tASi5p75R6j6u8Bspof/ya49sG0rgNun3Qfu0OXqFEyqSdkoOd72cp/Ehv0JiddmpGSUPZih5W0PyowQ+IRZ63fBNRJOHzp8abrjbDTPf4xw33kspu+4ey0U5HEx6AkPtxXMJVGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5CPpicLB6syX8ieiQaFnM8h5u+i6mxI5fEusx0878k=;
 b=BSo+tHIMsoAVC4o3+hzOP0HGd8mRfFVsebnOV0vi494Ox8S11a7Oblmdmyp/hSkf3AJ+relEvH0OEoMi3RZn75oQC8npdDP+pSNUwmLyo11F2IP6YXiApvNkJtFDzOpebs5Jw1939qAn+5FPoo4jZWt1N7/gKW92UwyeltjXbYds/ett24FhMPbQs4sMsXJcszoFv1SjTPm+lKQSG+ka7GReT8sxXGTJc3zRMublbz2WChvY9iId0Zixlu3mUQcqaVJR2khBsQXbsErnaGfH8bSOaiWYjNCqnKSOkT58ryEXZYuv/5KTW1T6X9XWXiDK8644PWba91Cc5jj7SQNCQw==
Received: from AM4PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:205:1::23)
 by AS4PR10MB6087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:15:22 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::e) by AM4PR07CA0010.outlook.office365.com
 (2603:10a6:205:1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 10:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 10:15:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:22 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 11:15:20 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 3 Nov 2025 11:15:12 +0100
Subject: [PATCH 3/4] dmaengine: stm32-dma3: restore channel semaphore
 status after suspend
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-dma3_improv-v1-3-57f048bf2877@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|AS4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 87006367-d33f-4391-31c1-08de1ac1e55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHBLSVBBbURXMFhLQkV4N3ZOZGRkZ0NCalBmSS83Q1pkL2FocFNEM0NRK1hI?=
 =?utf-8?B?R1hQQ2h1bkh0L255dlFIQm40ZjZnL1F5amF0UmNaWTc5NG9QQ2RUbk5ZVHUw?=
 =?utf-8?B?bU5HcWtvV1JLNFg3L0EzTXl6QVIvRmpwekxmMGVxWUhvU21EekpMaDhZcHY5?=
 =?utf-8?B?eTZEM0MrbFYyUGp5ZFJDclIrc2E0K1hJWjJ0MXFabWJEM2ZZaUsySFUxZysv?=
 =?utf-8?B?T3hXQXFKTjhUeEl6K0JXUzRpWm96TFp0R0UvTWEzY290aENzNVc0UFJrVUZS?=
 =?utf-8?B?MUQ5aStWQ0hkNXQxRG45RWtUcThTTmtCdVExa1R1elY5L2JmdkhuZzJFZ1hk?=
 =?utf-8?B?Q092R2hLb0k3NGwvdGNjRHptVWVvKzV6TVFQeXVyL0l1eUF5YXZtam5CNDV5?=
 =?utf-8?B?dGNtbFpsRXI1ZnlBcHdMb2oyb05wMys3MGxFQ2hSbXZGNXVZU3p4SWsvYzVC?=
 =?utf-8?B?bnBoMng4eERyRWt4QlMwTUprQnVQalVUN0VoWGV4YjZISjArT25kKzFtaFZB?=
 =?utf-8?B?R2xMT0RIeDVOS3NmTnU4UklLUVlpem1OQU5oRWpLR2VrYjVZSnR3UlMyR1FY?=
 =?utf-8?B?bGxlQWIvdHV3bm02M05raEZwUXZPYVh5c2U5R1pCZHB3WDZJRm1FbXAvVkhp?=
 =?utf-8?B?cFZWeEJFb01ocjZEOUFKQkV4N1pKSkRpK01jVG1rcmJzam9vSWlIZEE1Nk1H?=
 =?utf-8?B?VHZIWlo0MUJ3WVlZNzFVZW5mWG5Cbzh1bnRZUllwZTBrNnZqdFdsMnV4Uzg3?=
 =?utf-8?B?WE1vc3BWbVRzQ2MwRk1BeEdpVlQ2c2FPNm5ZMjIwMUhPVVFTSmpwVmt4cDFZ?=
 =?utf-8?B?eWNlZmdwNDQzZGJrTWwrL0sxSmtWZm4vVW9yenNPek9Tb1V5NlJ3Zi9CNzYw?=
 =?utf-8?B?VzR6eVd4NzMyZDhFdzVLenZaZjVBdWUwWG5yc1VIbGhadk9UU1JzOFJwNDhh?=
 =?utf-8?B?VUZEbDd0SkxBZmN4S0swcWJTUWNqN2tFNEFiYmZLb3Y0bDNLU0krVUlyaUhP?=
 =?utf-8?B?RnhLSWZQQ0xYUU56WG9RVTZRVTdBQVpjNWxKU3A2dnBvNzR6TzdrellyOHdT?=
 =?utf-8?B?Q3ZzV0FUYllGaE1tSWkwdEpkMmdIVFg3bU14c2s5Tml1dC9YUUJlUmZhaGk1?=
 =?utf-8?B?SmpYYkplSWxrdzlEQkt6d2ZkZ3c5RnZVbi9wOGlVdHVLSWp5dlNUSTV5bDVZ?=
 =?utf-8?B?YnRRK25tY1BsWGRoWlovWGEvU2MxWnNyN1hneEZGQk9tcFBVaEpPMS81UFd1?=
 =?utf-8?B?d1VhOGdKK0ZCVjV5UkhZakxXN3pNTlFUUWlRaU5UTzhmRWdsMno2Sk1UeWxh?=
 =?utf-8?B?NUF5TExKSTBrTzJaaVgzaEJIdjBCcUJhTk5aaU02ajd2RElTZW54ZXZRb0ZG?=
 =?utf-8?B?TjRqTnlZSjVhWEhSek5POUIxbFhNNEI1TnBBNnMvaEtBbklBL2theHR5UzFE?=
 =?utf-8?B?NXlUZDM1TzU5MVhqVWNCcFRkV2JoMGhxOWZ5NUM4Nkp1SEFMakRrR1ExcC91?=
 =?utf-8?B?Q003b203b3ozNGM0MEhRWUdpMUFVQ29jMVQ5VFI4WXR3QVhEOE85TEVZRHZF?=
 =?utf-8?B?VTEzejY3L1BRVUtPSWdGWkp6aTF1aWpmaVhyUHhSYTIwSjFnU0RScGlLV3RD?=
 =?utf-8?B?US85NVFpNWswdEJvMWNvQ3RLUDhBNUl6U2czNm1RSEN2TVRrYzVBSDRwM28w?=
 =?utf-8?B?WlFaZkNYZWJ5SHNSR2xPbDhxYWxNMUNzMmZSMk96dVpkK1hESkpUbUE4ckx1?=
 =?utf-8?B?SlVmci9QNjBrUVE5TEUzUlhKZjQ2TVBkZVhrNVJ6WHc5cXF6eThXM05INXhY?=
 =?utf-8?B?Ykljajg4L3hNcG9nNFc4NnVMYllQanMva0Q5Mjh4UFRwdkZGalJmc0ZzcXZw?=
 =?utf-8?B?VHdsY0tqdU1zVCsvNWVNbFliQkt1Yi9OY1NyZ2xJRG9kM0E2eTl5SFBZY1px?=
 =?utf-8?B?YkxpRTNnc05TLzJ3QlZwRnk2MU5IaTJpUmJoMUdVNUIwRnp5OE5Ddkd1TXBT?=
 =?utf-8?B?UVNpbS9rTkErWnN1WWI0ODhXb2kyY09KMTlGeGt1eHFodFZZZlZJbGk4RXdZ?=
 =?utf-8?B?SnlEcEkvNXo3RXR3aUFCZ202QjRhK2tMa1RuVkYyQ2E4T0lpdmZUdklCdFk2?=
 =?utf-8?Q?wcOM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:15:21.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87006367-d33f-4391-31c1-08de1ac1e55d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6087
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=690880c2 cx=c_pps
 a=Yp2iyUs7xOh8+NVfd3nYTg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mCSX4VwkHrH6H5eNLKQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfX1v2BPfZkezgP
 BN7X8Dn0f80V8Mb1PFYVwD2VqYxljHFkHh5dgw5WJclTqNTF1Rmre39Yi/SyfcSITQ2QtMtTRDx
 mE62wlVniO2aWOTJa7XNrQ3yUqA48km/FC4GSk2n03BYDHTuO9zksuKpHqr0CVbkE69Mufkn+80
 /NNY7K5OZmKUkCMgy2Dvlwf32ixsDpdPD6Tdaz768tapVpzpduJ6cFhohRrRiVFipaG2Hg/RjPY
 aS/BfxOgWjXm5MWd6Xk0a7AqwIf0ZnXaHcJWEYF5qNdsa4YYhKXrpM4M3CHB4DgBqk6YCJVWzcd
 yhB51ke+jUyQNtx8LPdjIgLqIbZrIoaKIyB4unYlWklJi++eqy1QoLO4vflt6w6eOLx9h+/krH+
 oUywtEdxcLBjwd7127e44YxI/9G6Jg==
X-Proofpoint-GUID: phyO67ii4d2hnAwsYARtAn7zDE1F3WyP
X-Proofpoint-ORIG-GUID: phyO67ii4d2hnAwsYARtAn7zDE1F3WyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030094

Depending on the power state reached during suspend, the CxSEMCR register
could have been reset, and the semaphore released.
On resume, try to take the semaphore again. If the semaphore cannot be
taken, an error log displaying the channel number and channel user is
generated.

This requires introducing two new functions:
stm32_dma3_pm_suspend(), where the status of each channel is checked
because suspension is not allowed if a channel is still running;
stm32_dma3_pm_resume(), where the channel semaphore is restored if it was
taken before suspend.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 75 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index a1583face7ec..29ea510fa539 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1237,6 +1237,10 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_memcpy(struct dma_cha
 	bool prevent_refactor = !!FIELD_GET(STM32_DMA3_DT_NOPACK, chan->dt_config.tr_conf) ||
 				!!FIELD_GET(STM32_DMA3_DT_NOREFACT, chan->dt_config.tr_conf);
 
+	/* Semaphore could be lost during suspend/resume */
+	if (chan->semaphore_mode && !chan->semaphore_taken)
+		return NULL;
+
 	count = stm32_dma3_get_ll_count(chan, len, prevent_refactor);
 
 	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
@@ -1297,6 +1301,10 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 				!!FIELD_GET(STM32_DMA3_DT_NOREFACT, chan->dt_config.tr_conf);
 	int ret;
 
+	/* Semaphore could be lost during suspend/resume */
+	if (chan->semaphore_mode && !chan->semaphore_taken)
+		return NULL;
+
 	count = 0;
 	for_each_sg(sgl, sg, sg_len, i)
 		count += stm32_dma3_get_ll_count(chan, sg_dma_len(sg), prevent_refactor);
@@ -1383,6 +1391,10 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_cha
 	u32 count, i, ctr1, ctr2;
 	int ret;
 
+	/* Semaphore could be lost during suspend/resume */
+	if (chan->semaphore_mode && !chan->semaphore_taken)
+		return NULL;
+
 	if (!buf_len || !period_len || period_len > STM32_DMA3_MAX_BLOCK_SIZE) {
 		dev_err(chan2dev(chan), "Invalid buffer/period length\n");
 		return NULL;
@@ -1932,8 +1944,69 @@ static int stm32_dma3_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int stm32_dma3_pm_suspend(struct device *dev)
+{
+	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
+	struct dma_device *dma_dev = &ddata->dma_dev;
+	struct dma_chan *c;
+	int ccr, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(c, &dma_dev->channels, device_node) {
+		struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+
+		ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id));
+		if (ccr & CCR_EN) {
+			dev_warn(dev, "Suspend is prevented: %s still in use by %s\n",
+				 dma_chan_name(c), dev_name(c->slave));
+			pm_runtime_put_sync(dev);
+			return -EBUSY;
+		}
+	}
+
+	pm_runtime_put_sync(dev);
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int stm32_dma3_pm_resume(struct device *dev)
+{
+	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
+	struct dma_device *dma_dev = &ddata->dma_dev;
+	struct dma_chan *c;
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Channel semaphores need to be restored in case of registers reset during low power.
+	 * stm32_dma3_get_chan_sem() will prior check the semaphore status.
+	 */
+	list_for_each_entry(c, &dma_dev->channels, device_node) {
+		struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
+
+		if (chan->semaphore_mode && chan->semaphore_taken)
+			stm32_dma3_get_chan_sem(chan);
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops stm32_dma3_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(stm32_dma3_pm_suspend, stm32_dma3_pm_resume)
 	RUNTIME_PM_OPS(stm32_dma3_runtime_suspend, stm32_dma3_runtime_resume, NULL)
 };
 

-- 
2.43.0


