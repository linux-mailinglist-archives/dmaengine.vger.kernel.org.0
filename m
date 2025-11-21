Return-Path: <dmaengine+bounces-7286-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 723ACC79A6D
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3DE0032AFC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33D3502AC;
	Fri, 21 Nov 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O8lyxsdd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69C34B415;
	Fri, 21 Nov 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732237; cv=fail; b=lRbbqOjL86bkSz2Ha/3h7X7b2MB3nYRZDe9CV/1VIAC6n+zd9k1YDCc9uYC0vbXTJix7K7mV5dZsvCMKwYxz0ch37zse7VQasyBYhLqX1oFPvICAroOu0X+UI/HVi9tWdEjb/aXemBhVueimhRUGH7cFE8wdEs2Uqtzhb3NAzbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732237; c=relaxed/simple;
	bh=7VQedHRMZ7s+QYQQPJs7skkz/tGAGxHFxNQoWzm8+xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UYQW0TfzN+D+1dlvP28O8yJXLn4n5daOfhVTwMs5uTixtD525bXLCktqzjgTm0IZg9IpcKN6gpc5bqM4LvOn4ZVxmQJ4MPY5SL9k3OqsAZcwWaOVlF04fFec02O3ujXlJfh7ql12s7RvrWaCkc+sS/cfaQKeuwYMDr76ggC9bMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O8lyxsdd; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALDZKoS3611604;
	Fri, 21 Nov 2025 14:37:04 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajr6pr6rd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:37:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO61bcHK5LltEEN/T4Z4jGXMod1JTl9Ro/bfcfdzv22cfrK5+ORY1chIhKu42p5TGlmGxnFmeJGwf6UoolqMWKkdA0PJJpZZkL9VEhQO6jSPbaTlbVtdudkJ4yWF/DR6mJVtd9AAatEyqBNvmDhKTjGKk2NAielIf0Eea93HVQT9Mi9TgYRtVmEtOKkrqp9ctrAWuYDBOxUpvguCei36tgEC7XF10kFvVkm+L9s0ZAeI9FF8hVJ7Kt9LJMLejd9cwotZWxMvggp3Y+qz5ct4wnBSxnGqAncvGqW0SKjpq/kLdi3IeTwhky67/HEWd9fKBBezVAxxovE7QH4uJDQQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C2QTeR3cQQEoE360avKsictL355g1NCYjLzLxkW0Jk=;
 b=jYsn+kbOxnBO7Iy+wUNbR22BukrEC/uOzeX7BxDzNDtkEmI9gPtElhQtz9D9sCn6/sO8k9aDzgst/xsD0Inx9Zp4QqVEZIcKy/hImaCPYUwDK2N9HpB1QF+/Lm093r00I6sTUdPi4rySXaEL3EiQqp6umtAyxmV1+QGmsNd2EIEwtUZFMOT1oHNkObsElK/Np2TRWxTsQRilakJ5sgRQSbm6M6lkfbFp5lpcXd0YHOtWwIyLhZ5l7ua0vWeVY2+8EQxs4jE0W6hXzhDf+SrhwGsTSnAQWjcnmh6oNhekbck88nWk/msc6ELEObKWS/2YcZGd7+kf0fXZa3Wgtqs+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C2QTeR3cQQEoE360avKsictL355g1NCYjLzLxkW0Jk=;
 b=O8lyxsdd8pSAljRV8ejqWm9HerEIuYM78KQOA1rmxoKvo9o8larRK723O+eduOQEX9ChrpiCixa9gGAo9tT+6cbxe69nk7egKaLRpVWgLzoM/vBt2zqbynmvNrYruLd29JkNlR0z+QlVihJ0D++dgj4g+ei1VON/hGtMG03c9RhsqSfSXDFwiE56py7/Fmun6R0VndSBwBNAbuv/bZ+IGoV25gDaOhFTL99vY4nWjmPrXkwQYEzqHUObrUNwwZsuM3GBiDdBDY6L+CjJ1X1o2cQVwhb7YjbijCXJcs45YW5Md1U4ah4VfE3YVNhHi3p86mijcX61489sQ0PmQy+yGg==
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by DB5PR10MB9193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:36:59 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::2e) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 13:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:36:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:37:22 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:36:57 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Fri, 21 Nov 2025 14:36:57 +0100
Subject: [PATCH v2 2/4] dmaengine: stm32-dma3: introduce channel semaphore
 helpers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251121-dma3_improv-v2-2-76a207b13ea6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|DB5PR10MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 506c60d3-3641-46c3-10d2-08de29030c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTM3L09jWU04ZWNVZUlaR2Q2aEpvbkJ6eEdOUlhuNklBV1dXa3pERkZNeWtF?=
 =?utf-8?B?UjVLOGczenN2anNobFR0ampJSmNFU1ZnTW1WYTZrSGJOV2xGS09nY0Juakdz?=
 =?utf-8?B?ZlNMWi95YUxDdHZDYzc3Q0VidjFid2FrSCtCb3kzTHp5dTNXR1dsOGt2aGhP?=
 =?utf-8?B?azZEVndwNVE2NWQ5b1A3TE1ZWmY0aXRlUThmeDlRdDMxVXRhb2pGYzNtRjFv?=
 =?utf-8?B?NXA5LzRCejhkMENaTGYzNDNoZXcvY1d3cGdCekk2S2gyMDh3WGp4aFZuemZk?=
 =?utf-8?B?SWtGSEJuczBpd2xsbGFGWGc0MHBRL0J4aU8wV2Jua3VJZ1crMWNpcGxMNHlr?=
 =?utf-8?B?MmZtdCthaTIwckxENjZvbTZ4TlB6RkxZQnpDbVloN01tYXR6ZGNReDBQVzBE?=
 =?utf-8?B?NjNUdEw2d09BK3pSVlUrakJKL0ZSbmU3MnEvL3lXWHJCeW9WckRkMTN1YzI2?=
 =?utf-8?B?cXJFTng3b2VqK0lOYW5CZk5UUHg2eUwyRFp0L1dsVnlHeGJSK2VvYWdnUmNQ?=
 =?utf-8?B?OTZSU0ppb0NIT0htZnYzZEFmNCt1NExxUXJJMk1SaWNYaU5KYVRYMytsRklv?=
 =?utf-8?B?dUludy9yWlp3QUNMclZkd0JXbTI2TXphajJpWXV2UE4vMXVXRDVseGhuSnA4?=
 =?utf-8?B?MlY0N3BvLzluVVVPMWk3cGh4TU5rODYxWDA0QmxlMDJTUVp1bkg5T21XWThj?=
 =?utf-8?B?K21Dd1oxa3NwRDFhTW5GbzhlTG9EaWhyMVkySEI1ZmdzMDhqdGlGcFpDNEsv?=
 =?utf-8?B?OVo2elF4OXN3Z0l5eGdnYXpzWXM3ZVVnS2F6NDlmek9xMXVlYUhQeUpiUVpq?=
 =?utf-8?B?dnYvKzNUUmdGOVdDM3lqTENDQlJQZjNEK0UxWXhZNi96Q1VKdFRyM081czBR?=
 =?utf-8?B?NElqUnBKQ0JwZmszaTlSVXEyblY2bGg4TkFqUjRWVUcwY3daSmpPaUxBVEx1?=
 =?utf-8?B?b0tMRWpCVmpPejBoVkRnU0I3RWtOSml0Vjl0eFN6UDhCOFIyQkx4bU15N3N4?=
 =?utf-8?B?eEFoVUJhRFhCNTgvVTlHdkRDa2RiTzh2Qms5SE5Ld003ZDE5KzRBbXl1M0V0?=
 =?utf-8?B?SWJXSUFNZEQraXZBRGpFeWJZY3BNRDFoYXQ3dURhNW9NVGhHZ3FpUTFNK2xY?=
 =?utf-8?B?aHdYcVlCZmdJZkFhbnNQZURWRHlYL1QvNWU4MWRkMEVLU0Q1V2VyWWhBYktH?=
 =?utf-8?B?SEs3RTZvOHRNcUZoeU5aUm1ORDh2dzEyK09JeEZPQ3pFdGVCWTArOUdNbG4r?=
 =?utf-8?B?STQ1WGE4aURadm5RbmFZOEpRR1l5V2FVV1pXVWZ0L2FyUEdkZEdLVUttdDFv?=
 =?utf-8?B?ZUdtU2ZCbGs0OGlac2ZIV1hiRm9hSzJDc3dRcXpMSm9KNkFJcEllem5mem0y?=
 =?utf-8?B?MHlVODBMMDBRTjRlTjZPa0M0L2VzNTEzKzlybTRITVloY0tCaW0zODQxcGs1?=
 =?utf-8?B?cFF4dVlYVDNKRVcrQ0ZMVUx2SGsvYUd5YzdVNCtyMENYUmlkWEMwcURJSzJI?=
 =?utf-8?B?SE1udW9nZjFqby85R0daQlVGYk5hcWs4OUNzVG0rS2RLUjR4VElub3lUZ2Q4?=
 =?utf-8?B?QnEzUzJ4bWZvQ0hFNENjZkZZNWw4b3VyN0hWZ0QvSW9Wc09tNDZEeFFwVEFv?=
 =?utf-8?B?ZXcvLzNWVlY0dllNbzdrNjBtakpKUWgxYzUzYzRBL3hjdzkrWEs5OFZ0RC9a?=
 =?utf-8?B?UitqNWRCWXJYemovZmlML2xjTTRCbVlSZUo0YUtWM29XZGFWNEVUc1FYcGNx?=
 =?utf-8?B?L3NhL3NXN3d1bE81dDJWOU1wV2l4dVNUSXlsdXZVRTU4eURPdy9sVThIdExq?=
 =?utf-8?B?VjdDNU1MY0JmUkljY2pNY25wRlAwZndUWmpEY1ZrbTN6UmRxcElOVFRaUklE?=
 =?utf-8?B?SWJ1cFU4YXdhVFFFcFBNNE5LYVhBWDlSbE1KdnR1TEdIY1BGUEVxRTRtSjFi?=
 =?utf-8?B?WElnM244SzBqYkd3bVBEUHJRL2FjUitUMjRNL3dJMTlrUitQbG9YbGVKL0xq?=
 =?utf-8?B?ZlhlRXV1b3pnTytCR3NqbkhuSE9yMGpHc1paR2RJdC9HRnpmR042bkVyZlFw?=
 =?utf-8?B?c092WUJaT2tLUTVTbENMVUpUZVYweFlFWlNqT3FNeERnWHFhNS9leWkzc3JK?=
 =?utf-8?Q?QQJg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:36:59.5205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506c60d3-3641-46c3-10d2-08de29030c02
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9193
X-Proofpoint-GUID: NWszJs1F1d04DedvDNeuDLDyrkx_ioC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5OSBTYWx0ZWRfXzyT6VXR0hiUK
 LjQiYUmNLbMmlk6QH4DD03fXFDuxeG+Ryot12GJxCDh0wCnWRoRFfbJaEXz0TljGnd714Rd7TqE
 ekpeAGXNpQyPD2JPg1VKLpDdrq7ZruBMTbOTZNy0PMrb45cUSOlVpjELKCOnQnBPAT0yXw+oSIF
 ZikwHXDfdQqyzhmeyeYsjUgHQwmgE7zB8xcSuPsWEufcV479E6mjLX4JkMO7ZmX8qcKziD5JYzq
 9TND5GtIBJgDZep6+mmzotIhWslpJTr/LbRInSTLczUI6wEyOcYy7iKkl/eXKveKzCnPY4Yi48z
 8vfb3GAeGTY6gjvVteYH0aWaUG1jFFd8JN3VvxdhwOOxKBUcIX0UF03TgH2B5EHkhI0SFM6oR2G
 WNzPc2hlZsjVViPH5h3nlk+d37SStQ==
X-Authority-Analysis: v=2.4 cv=J+inLQnS c=1 sm=1 tr=0 ts=69206b00 cx=c_pps
 a=gkXL6sAu4RnYAcgyXzJ/6g==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=IQHcLSFj4Mn2yckHXKoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: NWszJs1F1d04DedvDNeuDLDyrkx_ioC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210099

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


