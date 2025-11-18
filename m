Return-Path: <dmaengine+bounces-7240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8AAC6828D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 457F128D40
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D82EBBBC;
	Tue, 18 Nov 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PixrYYwQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402D2517AF;
	Tue, 18 Nov 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453661; cv=fail; b=MvEvYNeeiYEcfzqPdS8te+BkgWAf+Sy7efIZ9oZsH8S+t4q52d3Sz7Nr4LgcS5Wrtj+dQQHKTSlIOkP+UbTDEVWngGWrG6M9gkon8SZQ7PPKkMuFRUJY5oU51MvNcErh5s6/MvXU9BXOa4bSG1S3s4ywLSCJw1JBjgon0Ocgjms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453661; c=relaxed/simple;
	bh=rKWFekr44WUvtDZ2+JJjpejzUGpPscoLupstxB79810=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ntBR+H3ExqOjHXKlmYfE7RYp46xUQH4y0In/AufAkoMNwbQNCPb1ILIZt8aTzPS0o9nEQlY7joZ5VTcJAsqqYbW1xLNycHMfCQ+kfQHfZFIBe83kI3Da77dMv4QgeuUWTYy/eorATCRy4OKDzBea6fhQtUUHzznfQKA0dpWDuG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PixrYYwQ; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8Btxu3362734;
	Tue, 18 Nov 2025 09:13:54 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ag6nwar0j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:13:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXDQBEpsu1b/I4MFn6xZH9MEax0aAwVT6Yw/AF5CDBeLTM8fydMH4YZtN46vVEHhuu+WAxpQg4fjMJ4wUtwc2imRy3VCZPNYQ9O903mFuBe/HOWZlKkayJEdfT4IMrCRAzTYr4F00rgmzBxT83UExO6rQcPZXuM/LFBgzDymO0hKBJR63bvfpQSW16aeGxmxVDrlBXQRhp9Abfhb5j4GSDWon767xnVtdVhdqorUiONQF2X76wuOnGQe64DXWLekTLv+kxe3Lyn26sglVAS5cU/2j5j1zbImijjMQ4sPksVnRwXhAvmtwEzQhoqqq1TJAtCuFXXB1YwNhowC8AUJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrbX7C2OM2DIlus/x35fTn3yUwGF76bi/8MZVCv7MBU=;
 b=ddFpTwG7ppVQ5g8VREa6RXy8ZHXL3mz2mBDMIZOPgObSS7TzeCvs013C/65XywdWkQXEi/LNw1222SdnJr8CZ833CFi+1ZDkmVVEDAfCgq1czH084YFpweTz0it/WXa6xg07RZryLRPeQSHiTKqUgHIF2Q5hDerEqq+4YEHIXgohUN08+hvTAkoUDV27uJSYpgfv2zqdA0Pf87ZIQBr9PJzyopQCldEQkO/myhkJp/jVQzhF4FBlYqsasG7FyCgCmALiVOmJMLpT+PGVbaPg+E8MScqUfV3YlH4y7ZOVzaELetN/yxrQ/A0jpT+QyXfO2FPoAVMK9BZ1dMekUvTBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrbX7C2OM2DIlus/x35fTn3yUwGF76bi/8MZVCv7MBU=;
 b=PixrYYwQHizVrKe83tjiK3c8Cs0d07X6I9MYA5LNPfuz167PqfsF0y5MkEQZEcuc7kkU1NB1ehfZG6CtsmDCHTP1lJuCpsOiquaIjIPw50LEy6IWieHxPHV9N3NllO3Gj9ZDe7Kz0NqvXGEuTg63zcysr++65GEd6VaQVDq4atXu3j8jl2+7msNA7LFTXHxZoXzroU2w7QDvCkkJe4ZSPcRMmz4LjVdnhGnXOhseWLTI8HMecJnSGo6JxLwlMUPjNpuzNA3kzPiOho5k/Blh0bekz7upmBraUC370NA8XrFjQvD96+UPSsSl2uWj6k5MtjaQ+ix++onFUHR4JCN8oA==
Received: from DU6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::12)
 by AS8PR10MB7303.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 08:13:51 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::92) by DU6P191CA0047.outlook.office365.com
 (2603:10a6:10:53f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 08:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:13:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:14:03 +0100
Received: from [10.48.86.127] (10.48.86.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 09:13:48 +0100
Message-ID: <1915c7af-cd11-44ee-8de1-f613083ae8ae@foss.st.com>
Date: Tue, 18 Nov 2025 09:13:49 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] dmaengine: stm32: dmamux: fix OF node leak on route
 allocation failure
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Viresh Kumar
	<vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Dave Jiang
	<dave.jiang@intel.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Piotr Wojtaszczyk
	<piotr.wojtaszczyk@timesys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Ujfalusi
	<peter.ujfalusi@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Pierre-Yves MORDRET
	<pierre-yves.mordret@foss.st.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-12-johan@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20251117161258.10679-12-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|AS8PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ffc356-3e62-4bff-a83f-08de267a67cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDVyV3IrWlRhTjdZdTlWZld4OGVhQlN6a1ZKR2dPN1ErazRoR0JQUGMyRHdw?=
 =?utf-8?B?YStmb3JLem1rcGdjRU9qWDdlWFZ6ejVCSXFCWmJqdlV4c1pnbVZVUElwUFE5?=
 =?utf-8?B?ZEc5bjZ0di91TU16RmFDYU1pQVFOUlVmc0lvRXNDSVVVYTB5dWpNa1FsNkdw?=
 =?utf-8?B?NHVZclhmbEdLOHh1eGxmUUEwYTNTdWJTRTVVUVAwQ3JPc0pjMUNCaElWS3Zh?=
 =?utf-8?B?YWwwRktsMWNLRHozVHhtaDFLZUxCL1EyeTlVamJ2ZzZqUE1namxOVDlzbzdL?=
 =?utf-8?B?SkwvUWRpR21IVFIyaWFrVjJNdGNNRGhnanErOGZmeVQ3WUttenJwQzVJK0ZS?=
 =?utf-8?B?SHN3ZE5PR3p0V0RiYUNEc29Hd3VXR1BoYko2YWdhVUJhUmtOakxPMmlRMXhi?=
 =?utf-8?B?SkQ2R3MxdEQrbDU2SlBZQUJMUkszeUkvc0pKaE14Q1JpVnlhVEFETnhxcHFE?=
 =?utf-8?B?QkZBSC9JcndZTzBsbDhXSnBqc1VYaHhnVGFSWTNidUVnWkVlVnpEcnlUK2JU?=
 =?utf-8?B?WWdMcHBYTE1ObjNGSnRCYzRGUjFDY0dGYXkyelRYT3NYSGNOUjlmQWVHeEQ1?=
 =?utf-8?B?aDdGbkViR2MrZVgyalNKZXhpbkhKQUhjMFI3cDFHcTkyVEdZUHZWdUNxNGky?=
 =?utf-8?B?RWpGL21TT0p6WDNMYWM5WFhIdmZjdHUxWG9ndVBNVnhMdlhJK0J1TmpJSkI1?=
 =?utf-8?B?Mm1zK2JxcmVyVlI0TUw0b1N6Vi8yTGRWYTdVbTdMU0NoQVBRZXJpR04zd2Rp?=
 =?utf-8?B?YitwTVJMQkNnSHY5WTl3aWw2ajlua3QrRDZQb0tpZjZlNklCSUJYcTdFL2NQ?=
 =?utf-8?B?TjJXRWdsQ2NDOW50L0NBWkVWOExmZEVyQ2VwVlNHMUcyYTBZcEJ4cmdmZVl4?=
 =?utf-8?B?TGcyaHVZU09ROFNEM0ZOUXZkNjVQUE1ZKzZ0RzJpUDl6Szl5RXEybjFjdE5r?=
 =?utf-8?B?ZDc0REZrUUt2SUNyS1BwalRkY25CUlpOZ1hNOUlMaVdRc1kxZjhSREJNVzRZ?=
 =?utf-8?B?TmlHWE5ob2N6K3V0TVliS0tOWEhvUnJrMGU2c2pJN3dVZTMzZ3RJblBIZnJv?=
 =?utf-8?B?MDJkNnF4QmtzZTNPelRlSTBsRGsyNGFac05aeDBQY09vc1o2dTVrVnVKQ1dP?=
 =?utf-8?B?dmVCaVlwT2JYakprYnhKZVZDOG9QY2NpME1qakVWTTMxa011TGdoMnJiWDMz?=
 =?utf-8?B?R1dzdnhEeHFDcnM2RThYRnVOd0VUY3RsOVVlbG9SSlJPT0NyVHhMVHN5SThl?=
 =?utf-8?B?aysweDAzbExJTXRzeU50MVhkc05FVHFvcXhLUW1Ec0xJeGI0cFJMbXA5cW9X?=
 =?utf-8?B?QXVERUY5TUNzU051N25UemRpaXBEUHhvNzZXK2Z6VFc2dVNoSEtHVzZWdDYx?=
 =?utf-8?B?UDFZU093bzdJeklDTE15S01uMHY3NHBpOWdJRmFuaFMwd3FBMDFNSkl3elNp?=
 =?utf-8?B?djRpWjYrWWlhbWIxY1BSaDhJR2dqZ1JGYlZTTDFxZ1FCZU40dnZFSXFsOFMw?=
 =?utf-8?B?aG1HVGVwS0ZGN3BoRFZJSXZ1UlJNbldLaHhRSnZUUXFMOE1lemlhcnNFVXZB?=
 =?utf-8?B?ZGNySW1SUXQ3MnNJaDlmbTZndHl3S2pTY0NTOWY1TVg5KzZCTzZHeVNzZ1U1?=
 =?utf-8?B?UWdmRlpMdG5jaW1yMllkNmo0eGw2UW5zcmNvSkcwR1FUSjhnZnNIUVdzOHRI?=
 =?utf-8?B?VHFtcXl3Zm5LemtMaFRPN3A1akRrRzU2cHVlR2h4TXBncFlCZWhlTGYzdzBu?=
 =?utf-8?B?eVhpcEk2RExncC9nOXcvY0Z2Wm9POXVxeWpjY3hKdVBudndQbDFqMFdGKzdC?=
 =?utf-8?B?bzE1YktDamxUUC8xUDRIWjJueEJmMG4yWW1KQ0F4cjVoSHRuajlGK2crOEZu?=
 =?utf-8?B?Z3NCQ2V1U2RDTFpoZGtkbzJCK29DeE1CYUl0ck04aHg1dm9VL2FldTFWTnpY?=
 =?utf-8?B?SGdTam9HczJMdlZsSTFmQXh3ajhNcmpJUTdUVXBGaGlBeUxiL21JOGw0eHN1?=
 =?utf-8?B?TWpOSzJ3NmxWdStxcTJmeldxaTZqanlLaFl2Tnp4aDd1SHNPVktNYkREdHN6?=
 =?utf-8?B?b0NjTFFzQzArbzlReXM4bzRaWmN5dEFQMHFrMmUzNTNaK0N4Zzh0Wjd3QW9S?=
 =?utf-8?Q?fyL4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:13:50.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ffc356-3e62-4bff-a83f-08de267a67cf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7303
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2NCBTYWx0ZWRfX1LXvvg/0oCm7
 nUn2/WzhJ3O0yy2Co58dPg+A68NjGFNVZYz0YnCtnvIYXSykclCzTgFsTeCFhizhDrBr+r39crQ
 wxakomGg1mz4lWPrppfpg+hYNkylnPzkWab594tVHBSafdIJ4yf1B6sityZKre6KByah0A20OH7
 RkGUhEGq8XUIio7H1jwzVG0QycedEXPnTGnEACoLUAaP9VPQPPfRmruyv+voA15Ai0jgx5mPCan
 90gS1CRzuU6GU99x4KbISkTpIvnk4YaNSTXniu8tf2vNiSUD0aUzKf8sL42LY1CSpVQvSVoItwI
 jXrOvAHOiv3tMiG5KLBr1X7m30Wk7wrstREAxhxM8XWs6EBmNhL+sH3kin62CqX7MG98m3gUprS
 kTJSJycS9Z3M1vAfMWLj8lGi5fJDAg==
X-Authority-Analysis: v=2.4 cv=WPVyn3sR c=1 sm=1 tr=0 ts=691c2ac2 cx=c_pps
 a=58P5oL9Q2/pz3EYEt/ZkWg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=iPq3YwKX0LwA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=I6vhjKjE5Y5TGxg0fZsA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: JxpLXSnObV2PqArQCFT0PE3f1Iv5fWqu
X-Proofpoint-ORIG-GUID: JxpLXSnObV2PqArQCFT0PE3f1Iv5fWqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180064



On 11/17/25 17:12, Johan Hovold wrote:
> Make sure to drop the reference taken to the DMA master OF node also on
> late route allocation failures.
> 
> Fixes: df7e762db5f6 ("dmaengine: Add STM32 DMAMUX driver")
> Cc: stable@vger.kernel.org      # 4.15
> Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
>   drivers/dma/stm32/stm32-dmamux.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 791179760782..2bd218dbabbb 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -143,7 +143,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>   	if (ret < 0) {
>   		spin_unlock_irqrestore(&dmamux->lock, flags);
> -		goto error;
> +		goto err_put_dma_spec_np;
>   	}
>   	spin_unlock_irqrestore(&dmamux->lock, flags);
>   
> @@ -165,6 +165,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   
>   	return mux;
>   
> +err_put_dma_spec_np:
> +	of_node_put(dma_spec->np);
>   error:
>   	clear_bit(mux->chan_id, dmamux->dma_inuse);
>   


