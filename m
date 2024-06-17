Return-Path: <dmaengine+bounces-2392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7090AD2C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75575B25267
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AD194C76;
	Mon, 17 Jun 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VsSIBtJ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAA19069A;
	Mon, 17 Jun 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624432; cv=fail; b=Nz6Rnvw7N2OdG6mMBYOXacbJ5qpLdD95eyI99HcACzUqQvah+hFvwWEREiRF9M0wGQ44BpQsUW/BDQxroWrqBpdXrXGZ4JCMdqD086+1oFAyFEO4H+3y1MRwpoIwPrq6hkqKi9TqTJ7qXYXJxZpYZfIW3DxKrxFPKdrjMpcC8CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624432; c=relaxed/simple;
	bh=lFWiF5NpVbLEAWDZDJqJolOccEcjAfenXYUpsUJZzRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GewFETWftTrUQGcO3vK2wBdCWXNYlpDoa98/fysF6l4ueK8D3Q8+cusPaue5dstQKwlPUOr1GlbbNC4nlMt0JiyRINmdhQfR5GOLl1qqqVT9lJOvcroSPcAh1xJc7PB3q5BJwze84b4kXz+EcpGM8+5bZlAsp5DN2cVtVMGXMuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VsSIBtJ6; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUBmgLZM1DFZJn0Gru60ebPX4SWMcCn//USYhC/XwGD0EehvjrLMjGOFNZFzei4jzM2LuvOqg9dzdyG4sfgQcSwDZds94b55n0wIMjU77O2Ls7AWLKhEuULv1A7Tw19PEaC+50aaHiHcC3HhUu6Kka/nvKmhZGv30XHbzDSFn6kT6xbAsCX0NCD02UMaPolYChJDWv/66ejwo4Vm+WmdUO/95mQNu1BOAK5wZsDRmgbdqpdG0vfwyiec4OnMNjD9oyQWnck4OYBJz1UsVnl+IAuhgLeQwbo/h7J6Q0vOWqCNF3WMWmj50EBauDLwbSTme+2U3lsqDmWmOnv3A2u07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMrHCGqcHNLXJ0FFC3T1Q0U50+6M/uDliqc7SlSkXRY=;
 b=XxEeZi0S997I5C7guUVZe4SZL54tJ85GFZlocy8KWcuaUNQ5OfIp1kguEsHgKiunDnS+R4LIcS/Rb7IZcP+eWKkIwixbeeyJ3otn6pGz6Q468UIaEyiE/uj9EKUhKcO4PTL5K3SThx34rpztZ3eZt06coSGlFrJaTiiIx7hqvDM0vBvsPzdMUKRuJXlFa991OG1+U+rAn7Y16813lkCZqdLe1vGlNR2zmN2/fKixWwiyH+sjJbHdiTUFEG3TMFf3qmqDiT3N2dNzg+3OZ7s6mISPtN/pGd57TO5ufG/0dKnI9irf0n7FTy5yN3Q+meHvAUFoLaZ/LkT1MNzAhGb9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMrHCGqcHNLXJ0FFC3T1Q0U50+6M/uDliqc7SlSkXRY=;
 b=VsSIBtJ642auhKhNN/5gLS4qDvrAQOCZf9SwM7ZBqi4zZtgtmn4m9/FSVQUWFBDPXM27hqXUlx5F2lEZOSb6UYY/gMj3zb0WZvKJ2KEShd8A2oJNLp75TpRDVxLykBEhAysOQ7aiwfEvbwQxyUV3tNY51cIZWgqmAqG6f1+d8oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Mon, 17 Jun 2024 11:40:27 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 11:40:27 +0000
Message-ID: <c024d035-dc94-4e89-a935-795ab2ce24e7@amd.com>
Date: Mon, 17 Jun 2024 17:10:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Enhancements to Page Migration with Batch
 Offloading via DMA
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bharata@amd.com, raghavendra.kodsarathimmappa@amd.com,
 Michael.Day@amd.com, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20240614221525.19170-1-shivankg@amd.com>
 <Zm0SWZKcRrngCUUW@casper.infradead.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <Zm0SWZKcRrngCUUW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c47a2cc-3dc3-4920-304a-08dc8ec2489d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGI5ZVNSRGNJckQ2U2NqMWFHTjM1dGlKOEJtaFRUN3lMN1B5U0FmNFltKy9U?=
 =?utf-8?B?U1RNVHdCZDF0cXlmUjExVFBwdThyczkwQlZGTXhxWEIvZXdPcElWcWVhWEJ0?=
 =?utf-8?B?NHVPeXorOWxSNm90NWlJSUl1ZENVMUJRaGFBeXdKVC9lNnN1bUxNRmgwR3J3?=
 =?utf-8?B?b2tZSVd6Vkhnem8yQmlSZDdzVFRncm5PYjFFWlBESmc3YzZSa3VCOHR5Z1RC?=
 =?utf-8?B?bEM1QWh4eXJ6UkZZZ3JSNy9VL0J4V1dIWnlKMXlFMEhZRldHaS9la29vSW5G?=
 =?utf-8?B?RVczSTBrNXZpK0lzdHZMUU0yWVRydXpKNE1YWmtoSFBUeGsxVm9lZlBITEFR?=
 =?utf-8?B?OFN5ODhYQnExazlnWUhXd3FjUDVMN094cVJVb2lwbnllYmFYNDN5QXZ3MzY5?=
 =?utf-8?B?S3Znd2RLZEpZVEdxMjhydjJzNXNIa1NKalgyYjdwZWc4ZUpIcmJwNURFMGpN?=
 =?utf-8?B?T1hERVIyUUJZejVtMXJUdmRRY1dKQmRQem1PRUYxMEJzenc0M3AzZEIzNUJV?=
 =?utf-8?B?UzNqRVZieFNrNG0xb0xrUXZNQUw4bUt2cEtQWkZLZ2R2UXRCZmdVa0R2STNL?=
 =?utf-8?B?TVJDQ2Roa3ltSHZRRjJ4bHRDRkZWcDhnS3BkekVrcHQ2ZnJPOXNublkvdGRp?=
 =?utf-8?B?YWVFa3poeTE4RnowSXpZNDRmem11WlBkYjZjcmpEMm9kcmk0QUMzck9LMldU?=
 =?utf-8?B?U3dQT2NWT0M2ZDlDL0F4clF2bG9lNGRHbnd6bHF2QThtSitiNTBKMUJiNVBD?=
 =?utf-8?B?aU9SUFpDWVJJcnVjekxhZytBd2U1YjhOYytFUm1hVHpUdnF6aUppMzVrbTRC?=
 =?utf-8?B?UmoyUEpNekJHcjNTbHg1WmQxTE5udmg1d2h2eDdqMGF5OWxOS1BHaFA1czRR?=
 =?utf-8?B?UllaY0d4eDdLM3FMMkRGSGZpUEhIU2Z2VyswZ0VlaHpkYTRocDhMKzczekxx?=
 =?utf-8?B?S2VZQjhYN1U1RFdvNVduSkEzcUNhRDYvTEZTWWxpZ0JySWl0RnYwK2svcXV0?=
 =?utf-8?B?M2swZ1Nkb09DUm1iNGZzVkp1dHNvdWZxeWVBcjAwelB1YjJWQ2NGZWZjMTFY?=
 =?utf-8?B?YVlRLzBjK3FYZTB0bHhhNnVTVjNiODAxcm10aE1zM3lST1NhSGdNemxpMmM1?=
 =?utf-8?B?ekZXZEowbFVoSTczZUNXM1dWbWxEU3lseXh4dEhSdTkvQnNCSCt2dVBkbFMx?=
 =?utf-8?B?ZnZCSU9mRm5leStJU2t6V1dTcUsyMW1Ocjl6NUNYeWRYcWtqaWlpeHpCQm5C?=
 =?utf-8?B?WjZubm9KN1dhVWsyNTZ0MjdiNE41MzVwcEM0YkJVU2M5a3NBV2tSZFBmcThH?=
 =?utf-8?B?OGROaXRjcmdZZUVuZlhhaVV2VjdpS3hENjUydzNBOXBIbjczNzBBM1YvNUE4?=
 =?utf-8?B?b3E3VjROZ2tEekRtS0ZKYjMvaEdJVmdZazhVQlpVVXRSTHA1MnlabGRBb2hj?=
 =?utf-8?B?cjl4NVZ3dEM0aGM2N1RoQXpmaG1icm1BSzRrV3AzcE9waDVvZXQ5bWdxV0g4?=
 =?utf-8?B?Z2V2c1BXb0NRTkVHeXUxZ1dHRi9MTUI5aUhwREppRk5WNFl2a0dtVGlGQjU5?=
 =?utf-8?B?SUZMRG1ZZDFyMU8vczRueDRoeDVjV1FPTFN0Um5UT3ZGRlovYVIvKytsVU53?=
 =?utf-8?B?VE5nSzFXSi9iYVo0NklYcklBZFNvUlI0NjRMTGo5ZWJ4M3hwOHkrOUZNYmFj?=
 =?utf-8?B?YVBMUGZ0YWVrQ1U1TzhBOFJObzdPYlBwUTh1Ukc2NFVzc1RoK2ZRR3BWSDhk?=
 =?utf-8?Q?4Ied0OBZtEuvC7B7h1it6JYf8Ts5KZmbrrcTuE3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRNekVnejE4UXJPT0NHL1JHckFCS1NzUGloK2xIWllSb1JRZURGaHhZTjdl?=
 =?utf-8?B?OTVnSkNQWGVKSGtkb1BJV2p6cjcvVUVWMVd1RXVhWEJMSXNLenVoM0xEQU5I?=
 =?utf-8?B?OUI5eVRDYmRneTI1S1BKV2VrOFVqWnFxMzJSSkNsRTdyUDhCYm5jVFliZ0pX?=
 =?utf-8?B?aG12czVwVm51U0xrZjgxRUMvWWV5dmlmNDZSdzl6SFo4NFhzL0pNWmdDWFN2?=
 =?utf-8?B?Q0RGT0dvZnJiWk04WDBOUGgyU1pIUmo5ekcvd0pwcWtVN1VkM3Q1RjZyZGlV?=
 =?utf-8?B?V0k0c0FLU0xFUFhORnlpRTJjR1p3VEZqS0pTczkvZG80YWZQZGRETEZZWnFR?=
 =?utf-8?B?R0RYYjlSME5pNEpaSFRaT2VZWGJXamg0OWFzU0E5YjNEWkhWU2pZampBYWRq?=
 =?utf-8?B?Tk5hTmdOL2xrWGtiU2lGVUNpY3BRa1Y2MThxUS8rZTVDZ2ZpOG80NDhmamM1?=
 =?utf-8?B?UTdZdVhZN05XTEtxQzJGOVRPOFRxblhPdERFUkoySHZBdStDZ3VoQnpuaEpI?=
 =?utf-8?B?a00rc2lLUk1tNndTUldsaFJCM0o5Yi96bjNDMGRYZVJxZXhsaXk4TEswTEVV?=
 =?utf-8?B?WlpWQnV6UGJVYXVaSDF6b1hXZVdwT1BSSVFmdHpxRWJrbnpmWTdydStkNGln?=
 =?utf-8?B?R0VtU1FxVmR1Ny9BRzlYQW5wWnlPcmM2Q3pzUmhRZGFFS3RVUUlOQzFXalh1?=
 =?utf-8?B?UWZHelhPTG52Q2toZ0piNFBNODNMSllubm9WT29ScjQxd1hIYjhVaHlPMVVL?=
 =?utf-8?B?dmpQZlpjL045TnFaSnFWZ0tPaXVvMUNSaWp1M2F4eEpGcU9SMFBEQ21pQzBD?=
 =?utf-8?B?SFBWeWFlQ21vdFpVZDV5cWtXaTBYbTIzaGlENjZBU0VwWmdDZmtKeXZ0c1pJ?=
 =?utf-8?B?YmNYT1lEeDVKc0tvNzRLVU1lTm9RS1VtY1lGRGRpcjlXUFZBNnk5bHNzVzll?=
 =?utf-8?B?T3FXM2NwSkkwdzI4ZDk3WnY5NG11eXNWOEZNZkMycVlaUGlqMUdPYnQwZ2lr?=
 =?utf-8?B?QSs0SnZ4eVJManZNZHFoc0xjbEVvZE5oVVpLRGpxbXA0VTlpZFczMXYxamNm?=
 =?utf-8?B?eHRLbXhRazEyd2I4UVE5K0JBd2Yxb3pPK2x2RDNQRFM0Q1pXZmdUL1hUcGNs?=
 =?utf-8?B?RlZHcG5Xa3VBZUdiSGFYN3kwazkwSFQzeTJEMSt1NHNoTUlqOTZDbDYwWUxq?=
 =?utf-8?B?bnRHZ2xxWC9Wdnhoekl1OWgxNGNrYVlLaERTQTMza1N6RVNmbS9zMWErU1hG?=
 =?utf-8?B?dlBKUWh4UnhUYmVBM2xWNEVhQ0t4dGxkQm1KRVBmRHBVdFRsbDlrcTJZZFhi?=
 =?utf-8?B?K1A5YUY5NExReSt1c3BFbGYvZ08wK0JLUG9FM2xVQUZuaXpwUFVWZkd0ekFU?=
 =?utf-8?B?a1d5d3BvNnJIcHN4VVNUc2pENXNJb00yK1JvdVhXTkNBZ3ZETEFLaDlSTWVB?=
 =?utf-8?B?My9hcUxob2FGQ3BSU1I4TUIvUWVCMXhiQjArSERaMm43eUsvVytFTy8xK051?=
 =?utf-8?B?aUU1RFF4eDZCZEJmYmwwSlVEVmdxSVhuMGhqemtCMW53RWlCMVRlSzN1djU0?=
 =?utf-8?B?UjJuME5UM0lzczVpTXl1TnZBNDhySmR2SzJXSDhuWE5HU2Ewa2tUWGFTdlJi?=
 =?utf-8?B?MFhMM1QwK2hCZzhyZHgzL1VqME1KS2JCLzhBTmNsQ1JRQzQ5c1pDdGVBcjRk?=
 =?utf-8?B?RThrenJUT0xWSkFITHFpMS9zWDJIeDh6d1dFZDgxYlh6NGRVOUh3OXI3TXFH?=
 =?utf-8?B?NTNoRVRjM1FveW0zZWFEWjF0SEV4elhwWndNNkdYeXkyVlRwbHFjM0JDV2xC?=
 =?utf-8?B?dk0yTGppb1VQSVpEeWgzMUllNFpkUW93d3JFQk9HS2R6ZHR6enlYdHZCRlF4?=
 =?utf-8?B?WUdWM2krUUtCSURQYi9wV2EzSjI1eXQ5amJzNk1rNVlCNEpEdkMvNThEaHpl?=
 =?utf-8?B?dUhzQ296d2p1c0w4Tk56dFdNK2N2bkNHenV1NlBBK1Z1TzFEejlNaThXTEFX?=
 =?utf-8?B?RUd6cmJLdEdIVktnelluWjRmSVJZSEdqQktRWWtOTUI0TzBJMndzMk5MeGRR?=
 =?utf-8?B?WHMyMnVGN05mVWlnc2ZnMS9rc2ZxS0VkOXdVWEdQaU85MkVzTXVxU1N6eTNY?=
 =?utf-8?Q?p1tu5XHCYuA/luDSh2MtG3jvm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c47a2cc-3dc3-4920-304a-08dc8ec2489d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:40:27.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqNX1QOiZ8P42o21oy934JNLLtMv+xfLY5UtpfhqQDqicmXlVbz0HZNiv/yl523Oq42bK26mT9PqrNTB6uWj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

Hi Matthew,

On 6/15/2024 9:32 AM, Matthew Wilcox wrote:
> On Sat, Jun 15, 2024 at 03:45:20AM +0530, Shivank Garg wrote:

> 
> You haven't measured the important thing though -- what's the cost
> _to userspace_?  When the CPU does the copy, the data is now
> cache-hot in that CPU's cache.  When the DMA engine does the copy,
> it's not cache-hot in any CPU.
> 
> Now, this may not be a big problem.  I don't think we do anything to 
> ensure that the CPU that is going to access the folio in userspace
> is the one which does the copy.
> 
> But your methodology is wrong.

You're right about importance of measuring the cost to userspace.
I initially focused on analyzing the folio_copy overheads within migrate_pages to identify potential optimizations opportunities using DMA hardware accelerators.

To address this, I'm planning extend my experiments to measure the cost to userspace specifically related to cache-hotness. This will involve the accessing the migrated pages after the migration process is complete, and measuring the resulting latency to read/write.

This approach of DMA-offloading could possibly help in scenarios involving bulk data copying with workload size >> cache capacity or incurs a large shootdown overhead.

The userspace cost analysis will provide a more comprehensive picture of page-migration using CPU v/s DMA-offloading.

I appreciate your feedback.

Shivank

