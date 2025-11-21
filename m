Return-Path: <dmaengine+bounces-7285-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24254C79A64
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 84B1032998
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7B34D93C;
	Fri, 21 Nov 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MVoyBQa/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1D34B1B7;
	Fri, 21 Nov 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732237; cv=fail; b=gcZD+zn0I+hP4rUuV+se4yAV1R2AAje/GOHk/bOV4/Yqyc5s9Ib4G4kdWe+WPrujnJ46AcbRxGHKuweCqK9W3jicjQ6kb8cPpXELhwuUgWkS0CiTF1Z592vOHn5N4sP/h8SwPH5ZKamqP/1k+ySK0nagpbqlMPrEvw9MT6brO8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732237; c=relaxed/simple;
	bh=1+qv1f5DrIcy+BYE2rvZi0qTtFznKDwet9+Ef7xIZ5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ijj0R/XNGtL9MzEsB9rOjrWgFcvJfnUBD8mSWz4V2ArLaqhugST2deKk59u5Iyrtom8mIMnxKIAH4y5Izgf2MtFzoKMEgUlH/VX+B5zFH2Vp1SB0I3wQVKbFBSSsYxOTuUDkjCEvj5xXCPx83YpiXVQDYq64i86OVsm+MqFPM4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MVoyBQa/; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALDP1Yg3431900;
	Fri, 21 Nov 2025 14:37:04 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ajnmt8x2t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:37:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyFMYqKTbKmtKLj3zJZ8cs7L+bj0s6BFrixymSL+J7BEYoTEnpqQfri+1D/4r38lSqs5Kxt9Csp7fUMPm2ppkQZzNXPYA123MCKRG/yU49gWsfI/Q6+uN8YuTIL5NAEcO6KKxgQKgTtbwkanoY7xS5tJLXT8wogK4og4ts4LXgLU9TQZ6ZbTSt17zSj42oepeqK157dwdK8ToliU4mWrYV8lEr69/vNSpq10UbmdDFpXTQFwpVzrUQqdlrtSrqgkkhs8DeqVZbiEgwCivqVHgYZdNvlYTDbIoeGO1Oqbu1kACFoOULruX/tiJKJ44qnLFOZMKP0BMMwGUI+6uHFwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5CPpicLB6syX8ieiQaFnM8h5u+i6mxI5fEusx0878k=;
 b=LAGEkd93YvfL6obY5C1mdgLOSTSBGwQlr5npL0tueNIeVJiwHxNyEadCIg8p80cuWJxhNcBLOf8hTjkc+M6U/LcrnXpt6TxL1tvLJ++u3QqOgmPCSS6lG0DLTvhkwRZdVffNc0sjUOfAX/PclzC21feGCak7DMYFAwMrpQTkXUVR2I802Bcwb8dq3jayqpFODq7RLMFyZJUPcAVEEfG7iRbDzZ4H9zQezSr90whNzFUXyznoInequkBfcUWWITLSlJdJHfC4Zi6Kb/cXSJYzUkj39tWSrjCe8KCrwrEyxoKgwY4AM3MTu6HWx7xIrGuTMeYC6CvtEjy+8vZzAzobAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5CPpicLB6syX8ieiQaFnM8h5u+i6mxI5fEusx0878k=;
 b=MVoyBQa/yjfydgXdooqBnWl0HDT0y0QSsQxAMl/y/CBoOtH1E88Yog3GSHIt+kdEvpQELijCVaD40qFE0BquvBj9WImc8XAbSHgQiCkLwODUgtTyW7l1YtxNPSO68Mzcgoq9VTMFKF2tL6tZDP0vQwf4gP4KfnhFTQJxSAcjZgeh6krSxzwoAe/3NA+vFfMlb5mg5s/D70mnuY0GkJgNZZU2Vw71gNqTwzICz/NXWLYdIjrlQ5EYHe2q/6HHDrAT8BCOQN+84SyZo/i9ofDPzvfSMuSuswivajNu5tXHs8ch5QFK6CLlYGmLye+ucMTlRSKDOEbIJZxOdACyG1wQag==
Received: from DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) by GV1PR10MB8417.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1cb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 13:37:00 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::f6) by DUZPR01CA0342.outlook.office365.com
 (2603:10a6:10:4b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 13:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:36:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:37:24 +0100
Received: from localhost (10.48.86.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 14:36:58 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Fri, 21 Nov 2025 14:36:58 +0100
Subject: [PATCH v2 3/4] dmaengine: stm32-dma3: restore channel semaphore
 status after suspend
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251121-dma3_improv-v2-3-76a207b13ea6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|GV1PR10MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: c31e225b-af48-4db6-27b5-08de29030bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVmckZGdkVNazFZRGxOemI2elpvNDdHSlJkSUxiN1lnRUR1em04bVNab0t5?=
 =?utf-8?B?Nlg1ZHJDOVJ2U3phSnRqR1NkR0thdTgrd0hNL0pmSDJhQjJ0bE1xR2xvYjZK?=
 =?utf-8?B?OG9IemxndXZWUyt1alJxdVU4RWJpUnZuaSsxVHBPb2lmRlAzSFN0Rk16MnNW?=
 =?utf-8?B?bmZ1eXZOTDRLWmMrR0ZoNE1laVlmbHpoL3FCdnRDd3p0ZENVb29ZN3pXbU9u?=
 =?utf-8?B?VWh6ZXM0QVAvQkhWdjJodURDNFArb3pIWUVrYXRhTSt1RW13d2VCaWJJUWR6?=
 =?utf-8?B?dkFkWmRwVGp1U0lldW5JMDlYTk5FNkhaTVVWeUh6VFRPQkNXVnkybFZ2RHVZ?=
 =?utf-8?B?VDg2bjQ5bGFuVGZ0alBEcC95Q3FsUUtpL0lQbDZYRncxV0kwUEVvampFUFBx?=
 =?utf-8?B?V000aVpxNDJoemRqSTg0bitySU9pbHlaWlV5dWlDQ2gyKzFTYjdUWlRBSTBW?=
 =?utf-8?B?UWZRT0pmVTQwUU52Y0dtUXBtSXBmTXA4REtQSkJ3UEM0Wnp5V1dkZHRPVUFP?=
 =?utf-8?B?T3lrNmJMYVdrSkU2dmhPSE5NM3hMSDQzTndaYVYwNncvWjBYNkFyRW9ibGsz?=
 =?utf-8?B?SWZXdnhUN3d0cE85U3FpMnBkVWdTbmhndWg5QktSM2FTWlVHQTVjNjk1dzlP?=
 =?utf-8?B?MFN1L0J0WElqVTVicE8rSTk5cFR1amoyWGVXL2YrYklnSjJiRWlOckVuUXE5?=
 =?utf-8?B?dk40TU5ia0VKOXpzbmdXdEJuSGYwWFc1QVZGekJTbWJDYVdPd1BxekdCM2x2?=
 =?utf-8?B?VUpaN1c3dkhrZ0ROditSRGlROHNPMWR6ZWJHMlE5YjRqY1lLbkxrU2FpNzJi?=
 =?utf-8?B?N3BYd2hra0RZVHpwQk8vTEt0SWxRMmUxbElMTWEwOE4vL0NJOElDcWtzZ3Z6?=
 =?utf-8?B?WGhMZWRrWnRmRGlFa3VrTm9LSVkwZVBsblFtc0Y0OFR0VnZxN3JZVmljdGdV?=
 =?utf-8?B?NjRFTS8zaWJIcWE2L0J0WFZQWjF2TVVobVVUZXRtNWl5RWhmS2ovSjJjQTd6?=
 =?utf-8?B?c2JpQ3FBNE5JOUl3eHE0cWliMUZLblZUa0l6ZFNFb0E1eG5Hb0F5MEVvd01E?=
 =?utf-8?B?SnpWWi9JT3VoTmtHOVIybDlvVTg5ZEQxbzloUDl3RnhXU3NzNDM1eENsRWly?=
 =?utf-8?B?RXZEdWhhYVhtUVBLbE5XVm8zRzdWUndGWlZ6Q2RERHVSVmpEaC9LZEphTGNJ?=
 =?utf-8?B?NTRjTDFYMm9CdzlNNWp4Y0tjTHQwVWdFMGo0TE9iNEl6MWszNjYyWHRZMjVX?=
 =?utf-8?B?eGpmTnhRNEludWlYUDlVWmJhaWpCYjNSVlJoNEFldkd0QVBBUDJray9KTVls?=
 =?utf-8?B?S0xERUlkYTJINmROTGNLZWIwVDQya21wdG1VbldLZ1JzY2lHY3VkdXd5djkv?=
 =?utf-8?B?Y3psQUtUWlZjNzdBNklDek1NQzR6QnZYVERMTnB3eWRGVzU1U1hjcHZtMEpi?=
 =?utf-8?B?TkdzUThMVEhzQXNoYUlOSjBpZDN5V0FYRmlWekE4dGNuSnJLbDQ3dU1pcE52?=
 =?utf-8?B?WjZHcWZNa1lqNEVpTnNDNHQxeFhXZzMzVDc1NVllZlp0MHJxaU1DZC9Za1RW?=
 =?utf-8?B?TFNUNDNRZ2RGZnNaVnNNeEhnN3JlZ1JJcWgveEEvNXFnOW9xelg2c2ZIRnJl?=
 =?utf-8?B?bTJtK0Y4THdnRDNSeE5hdzhadmNGK0JqV1VneFJEemNZbzd1b04xTEg0Tlor?=
 =?utf-8?B?MFRhWW0zVldleU85cFNhNmR2dHBRWmp6bm85TlhwajZCWVpIVlpINDkxN21z?=
 =?utf-8?B?TVgwbitRVzRYTkNVTzRaeXlEUG1TR3JiRTdoSGYwa2hYTkZWVjNhb2o3K0hr?=
 =?utf-8?B?UzFPVlVDWW9VNU5mM005YmxsaDlMZG1WSDVMTTJJMlZpYUxrU1dQVkNOclZt?=
 =?utf-8?B?MlpTYzh0VUEwMDRaZENqR1dKeUFzZUdVKzBVVXQ4bTFKM1ByOVlPV2c5Vldm?=
 =?utf-8?B?NzhLWHFkcUtZVmgyYzZBZ2ZYTHhQWFV5aUd3UC9wMno1V25jbzQraTV6NUZs?=
 =?utf-8?B?V2FFaFhLYmE0LzhQa3g5encwM3QxOUxwV29qSDg0YmIwc2xPVVRTUVQvY2pl?=
 =?utf-8?B?dUkyU1A0V3Rlb1Yyb3pnQTFlY2Y1SzN3UnVWUXNFOUhDaDZQUmYyT240YzFW?=
 =?utf-8?Q?KBSM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:36:59.0506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31e225b-af48-4db6-27b5-08de29030bbb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8417
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=69206b00 cx=c_pps
 a=jsgMSbbXZK7K/abHNvEvGw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mCSX4VwkHrH6H5eNLKQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: oP3cBlppgGX6vh_lUipXRNtvRPycVsXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5OSBTYWx0ZWRfXz2MZ1rNAFhcw
 W+0jE414zmO9wD3/fPja/6g5yay9JeGMPmgYgUT4sqUwC/tyvv6zSH0gqFxpIcwKbZtRrsKagdk
 pAR6LaQdnDlHzFZ1KnbmDLLJuDVH1v/qhdW2ftAq7VEXAEcpqHV8sRmQ+oF45tr5f2UlgZ4x/ro
 TKfrb89QKYQKNAm1z9Hi2yLLR4YHDfSuIM7wKFux4g2SWZEHNl1yh9IUeQeU/rP8UMXp1Uz2JMV
 zlXtK0IMjWK026xEGY4w9gPKAPj2vc7pQiWVQ6JQdZAa3MXIsZT+p15yT4pn/QoRRzG9SgPDLiS
 U91+LJ5qI8AONca8hrC4n1aCtXarxLHeD9BgLbcX9aIVAi5fExPPoZp68wDKxZf5ZuUIofgJeS1
 VumUCpyMGSSTORn6QMUZWYJ4CZ7ndA==
X-Proofpoint-ORIG-GUID: oP3cBlppgGX6vh_lUipXRNtvRPycVsXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210099

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


