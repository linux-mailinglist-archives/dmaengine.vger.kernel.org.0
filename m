Return-Path: <dmaengine+bounces-3057-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D3967FA5
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 08:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6518F1F21DB7
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63858152E12;
	Mon,  2 Sep 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EI+Rdkh1"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250313C80E
	for <dmaengine@vger.kernel.org>; Mon,  2 Sep 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259682; cv=fail; b=bAAPlA78B23WRsgj4+bnCR5icYjp+EbicDi2jpcepUJmenqb4NTzLmWrNvuM+VsgxTwu5ejSyvNJP/afi4zxJTsB3iNOqhMnCS6hNXr5nDmGchFOotFpLVL5AWegeKt7/9ZWFB6u2xW1miU4Xv/KKKMATxHa3m4+RHpQUFRvkIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259682; c=relaxed/simple;
	bh=9tStYKTclTTUdTfvmPe+WmL/IxwOJBFa3KqQrgXYTi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tY1D0/mBp8wFLT5Uimp/1yBKDunW2Xee3b3/98HMvHBdIXVstupuTOCJQUFrzyMJl6/AziEacfPfVZIltuZOt64QAitItXGaIhSwUPyeuA8XM92mG+SzIcqnk98pM/nwfSXGMELE7W7HNaVlprEpd8ncFPL9tRhFgZ9DQRooWWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EI+Rdkh1; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjJEZbKgukZHD0nwHlVMPNXGkzpkTL/aQhyOJl8Rial0h6A68YSo6IzDYt8jbbn0C5qQYLHCZZqdeNayYX+hSDdNWRVwStvj970Duz9w0CxxpHtB7eEgSNZ1gpMbD9SKTGSRDutpKVt6gfxtVaCH0jGwuFCXPT6uHl6kKLy9kEVaXCDEbJ/bspXqywhUjj0CDzDeHTMLjfMg4ZlPQocqAwU5nPweV+Ft8oSG0E5HWQ4L0tRCKR36cw2Mfpft0JKJOPO82gXQ90T8pEBEX4ngvcseMsZeknoT/RyFIlBENXH7TaOiYmQ/R399wAjR6DdCM0KvAJNAIvgiZ2d3bCNNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=270MK4inEl+4LRDqnrLuZgzy7D1a5NUg5rwJYere7Ec=;
 b=PkgF+pDPWF0TVZLjxjNsgYKiDiuOXsPl6tEd6KhWmyCpMFjm+pgbhaDY6ONIaIErDMjY+MiRDBSmQAbunAKfpCjvMgLG9eGM7ljrS6jROyd52g0drSpIVKQxsjsPn3lctZtKSumc+UqLekpFM2XJku0XpuU921ILuVX/Ds9oQjEfvrJwGx5KXOlbGdI72In83Zxzr82DS4LstdoOoojhlY7TgQbz8ZGN7Sv7rNt6saE07o574jfBS49BxvGF4nj0xeO8BTuHsV9FJpBOKXohWyGMD97gKCjqSfGP1kCNJfDaqMQKv5CZeeZV+TQ/OAaxtV0PqrVy3BLTroQJWUw7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=270MK4inEl+4LRDqnrLuZgzy7D1a5NUg5rwJYere7Ec=;
 b=EI+Rdkh1jU3mS5OT1ymNMB7pB4rGxBupNufuQigWKMq+sNOOiyS7XNfvlvLB4z74JfZBwXcyP/6v8FVFISIECpEU5dOybB6PzxsplQ+m2puCve1AT3Tg6FPm2lnWUa9IyM4IupBJ1jW61sqWyvKCAxx8NEbLCLipYyBrsRalwS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 06:47:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:47:56 +0000
Message-ID: <9ea69b85-b58a-472b-b802-2e71fa640438@amd.com>
Date: Mon, 2 Sep 2024 12:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
 helgaas@kernel.org, pstanner@redhat.com
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-3-Basavaraj.Natikar@amd.com> <Zs8kwwveNCTvHnvX@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Zs8kwwveNCTvHnvX@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e60b00-f8eb-485e-2356-08dccb1b2d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1RQejV5d2k1VklKMnFGcytZL0JaaGVSRnpEVjg2MHk3dXBQdXNpZzYyQ3pw?=
 =?utf-8?B?RHAyNEN1VmJlSmE1L0h6NnZ5elJHd3I2bXRlK1dhV1cycWhOcGVyZVlqeXpR?=
 =?utf-8?B?cDIrTkhCSC9DOVRER1BIT0U0UGFic3ptWWsrdUZzcTlwQmo1YVF4Wk1uOHhq?=
 =?utf-8?B?WUZDRlJCSkRqa2tBYWoyckNkY3lqbGkyY1BjUDlSdU95cmRpS1NvbmY1WnYz?=
 =?utf-8?B?cHpudTdTUjFTUURWMUw4NFRqVWpSNDZTZWdFMzVuc25tNHliVVNlbkhlWk9P?=
 =?utf-8?B?WTBtMGxYbXcxa0NWU3pLcVFHMzN1ck9qYWxhWjJpa3J2ODRuZCtweHA2VVYy?=
 =?utf-8?B?UGVYaVZoeVBFUXZoZHEwWHc2UkpwSytiWHE3NmJ5N2hBYjc1eHFzZUsxTnFG?=
 =?utf-8?B?OSs5TnFReEN4STFRTDZOS0xsNzNMaE51Y3ZZU25vbVJtQTJCQmhIc3JvcGpK?=
 =?utf-8?B?WVhrTmRLY2JvTnRoMVluTkhxdXBRUkVZYVdEWW5ER2lBcjd3WFU5bGJDd0Fy?=
 =?utf-8?B?aHlxQmdycnk5dk5OcnF2K05OdmpIK3pYM2p5SGM3YXJjRWgrb29PUnYwdUl4?=
 =?utf-8?B?dWVzTW1lbHVxZXFrRkhqOEE4cEdGYnM3MzFXR0t4OFBFdmczL2MzN0hBbWov?=
 =?utf-8?B?U1pxYUhxSDdmTlRNMi9TUkJnSUxra2NUUVVvTUFkYUNUNzJzVk9XQzVLRkhV?=
 =?utf-8?B?U3cxN3FabHRJUmZPd205N2lRSUlNV3BSSGp5WHNjcjVEV25WSGh4cnFRTStN?=
 =?utf-8?B?L2hPSk5QUEltQ1h4L0dVejg5c0lyRldnbTdHSWpzUlRtNW11UmltR3MwWHZI?=
 =?utf-8?B?YXVKR21EemdyK3YzaWF1NEFxcmtzVll4bmRBUG1MeDFna3Nob01nU0lZSGFk?=
 =?utf-8?B?dXAzQ2VQV21mdHhhQ3dHTXpzZ29qLzJRbW1iOWovOWJJVUVMMDFkeFpHVXRy?=
 =?utf-8?B?b296TDhKSHBpYWhQMzJqK29jTC85VXNaUkNYTks5eTF4V2pmeUc0WTlhYVkx?=
 =?utf-8?B?Vm5LUWpHQVZUSjZBbml4dUNpMk1BVUhlOEFwY3R2Z3VWdThGTDMwdk5lcVVp?=
 =?utf-8?B?T0o4aTd6cG4rMk9YQUhOdS9FRE5TQnlMOFVqTEZVem15Z2FzR3kvRlQxdExN?=
 =?utf-8?B?MUE1V3JDTXNyWVgzY0oxYkZ2Vms0T1BkTVZBUmVPQVIwcHllR1IwTTRaZjF0?=
 =?utf-8?B?MVpCWk1mNXFnb0JidytuWGxHOXZIR2JtRFpUd09PWFMxR3lUbFlyQkpWWlI2?=
 =?utf-8?B?S1BEVnl1Q2w2RFUzZWVvcXgrODRKN2czWG94VGtFWWs2amdSYU9rTXUzRGlH?=
 =?utf-8?B?eEwrNWpLSnZma3RGeFpVZGFRUWliL3R0NFhSTlE3M3NEcUhVS2dMWjRJRGRP?=
 =?utf-8?B?VkRHbnpmTnRsMnBxbzBXRFNBbVptOGo1K2owalU3cnlXOUErTmxtcTZhUzV6?=
 =?utf-8?B?eDlIUS9aUlZUekFYT3Fvcy9ZbzVZVDhvYlp1K2xkeG1FNEt6cFc1TDdWenlo?=
 =?utf-8?B?eG54aUJTK2VESjZsalVBaHdqRit6SGVwTVZWMVJBL0VpditzelV2ZndyMG96?=
 =?utf-8?B?VTdtWUNXdy9CYnNQSHdieW1YbzVxV1o0U3J5T21HNnF1T1plZHdLclhWRWli?=
 =?utf-8?B?TEVYZXV2eEpKUGNWUUd5YVhzQnlIUTZaT3dQUHpUUmQ2SVh4SWhYSzVQcEVQ?=
 =?utf-8?B?TzBJa2FqRTZiM1krYVJrdldhVEEzWnFxaUZLZFFxVG1SaUh4S050Y2t2RTFn?=
 =?utf-8?B?Nm5RNWxUL1pSdUJnNmFrMno0dlgxVjdFdzllallxSjhLaFl0N2lKTTRQc3Nq?=
 =?utf-8?B?dHdrUmVNRENJeWtVRStsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDJxMG0wYVRZU1RWemdlK090cVhnM3dmaEUrWVg1dWJtcUIzWWEzd1ZSL3lJ?=
 =?utf-8?B?VVZPdGdmUHJEU0wyUnhub3U0bGorZXhHMnJoK2dxM2hEQXo4bmZUVjhzM3lv?=
 =?utf-8?B?Qmd1TzhKWFA1U0pLVFRxL1VRY2hiRHVKWEpVSm5ES2M4dXJuZEs2REtZMjV6?=
 =?utf-8?B?ZjNYN1BaTWhjN2RiRm5BU0VRU0VLd08vM0VHWGFEbDJhVVpObStFcndDMVBt?=
 =?utf-8?B?bU9Edm8wZldwcDFZQVJGTURydXhPVDc4YklhLzJpVEhnNHgvK0lzUWZHYldC?=
 =?utf-8?B?Y3lYZnAyWmZ4T25HNFJRZzFJcXBmSjNEbFhraHJmU2VIeUkwcWVYTytzYWdl?=
 =?utf-8?B?VjhCQURwY1VBSDBzYVZrSDdJTFhUVkdzQmRybmpaRVVGUHZPcmU2U0gveGpN?=
 =?utf-8?B?YUl1TXNiWTZZSDdTaDVNTDJqazgwS3dMNDcyRXFxd2d4cEFkMEtReW9wQkxX?=
 =?utf-8?B?cnhoV1pyYnEvZFY2OUhRNWdzSWNIZHRmTlZCaCt3UDJKYWlVMjAxUGhlL2FQ?=
 =?utf-8?B?QzVnQ1ZkMlBRUy85OUJkVTdmSXlzMlRFNVN6MGZlSWxRV00vczVEWEZOY1Zt?=
 =?utf-8?B?RGVONWgzVDJ0Q0gyRExTUU4vZG1ickRJT0xBbTl0TVArNVZWQ1lYV3prbHVn?=
 =?utf-8?B?aGJOZW9JZGxqNjMxQnpxSWthTFljZ0NoSDFod2VZN3kwN1FXTk1uWXdkc3Z5?=
 =?utf-8?B?dmY4MU9FVlVNVkxsV2JONW5QT1ZiV0dYVUJHUDRkYm8yVGladXhEa0RvMVJG?=
 =?utf-8?B?L1lYc0ZEa0lRWG5FT3R0WnEvQ05JRjQwSEl2NGROM29GT0t0OEJ2aW9oa1VR?=
 =?utf-8?B?Qlp0bkJjTFNZaXc2T1RDMXhWUEtST2VJL1ZBcjNZamdiMzRna1hzT0pKencz?=
 =?utf-8?B?U2o2SENMRUNWZVdRTU5jQVZMUkgzb3RFRTZGT1htMm1ycVV6SUk4V2s5VlFa?=
 =?utf-8?B?OW1Jb1ZHL0pjYmZPSVBMQUxZRkZnaTVwaUZrS1YwWWdlZXlKdXNvWjdkejhL?=
 =?utf-8?B?a0wvakhWM0VBYnRnMEpINEtYYjBkN0hUaklIbHRpYzNBL0JwNmVHR2d2L2Vt?=
 =?utf-8?B?RTBtOE12dHczUGdPRGFmOU1NZmgzaytJZzF1dVk2WHV6VHVCY1VMSDdTZ1Vj?=
 =?utf-8?B?QUFoUDZaSjBYbEYrSE9HUDdaMzNYMmpVRXV2dmlnb1hlOHFGa29qOWZuOFhk?=
 =?utf-8?B?WnczTXpPRnNIY2FpTmhBRjh5RktSdmk5ZTZ4MGpxNnZlcFJHaHp0WEY0ZHV3?=
 =?utf-8?B?dUhhTlFHcm1yTkVFb2xtSWF0QTJHUWZrNmpzWXZOd1YyYXJWenNwNlZNdkVl?=
 =?utf-8?B?VWoyMmtGdDRORGlDeHJmekhTNWFTTlJkaVJJVzVzYWlIaXBtQlBrT1V3a012?=
 =?utf-8?B?N29hOUdYUlJ2WmZ5T0pidnRXSTlxdngwNjN0SEVZUnYvR3I2M1Y5QXpqZ3l2?=
 =?utf-8?B?VWpJdlc1QTZzNVJtdVdhTkxEcENhVHhEaWloOFUybWpNaU0zejNob0R4eGZ5?=
 =?utf-8?B?VDNjMDMySEFDWDRpQ0lYZlRmdFFUcE03NGNkU0U1cWhySzVFeG1CeWY1enlU?=
 =?utf-8?B?eFZBYWRBbktSQ1E3ZUFyRVZvNjU4SmdXUDhYTUZucWhWOE1KNy9BWGNmTUs1?=
 =?utf-8?B?Rm5NOGFLOHZtYmNEdTlaeXNlZGNNVXdubmlYeXZMc3E0ZkN5YjhTZ1A4NExq?=
 =?utf-8?B?NjdiUlYyYmNmckFSaEZUbEc5TmV0YmI0WTFvTnF3VkxGV25EMXYyc1RkOFhw?=
 =?utf-8?B?Q1VqOWxnSlNpZ040S2ZUVWgyRE42MW5Bc2dYRDNYNElJajNpOVBDVmNCK25K?=
 =?utf-8?B?M2xVYmlXRG45eVRvVFBTVmN4ZGUySENjZ3B5WmdTSS90cEVSd05tRExJK1RM?=
 =?utf-8?B?RzJ4M2V0TStUaXZpY0pHTkpHbkMyWFpnN3VmSlowUW92RmFqY0JhQW9mSTZR?=
 =?utf-8?B?dmxYUTVOQ2JsT1crWEQwYWNPcHFWK1JTbUthWkt3K3MzQ3JkQ2JrTU1JQVBG?=
 =?utf-8?B?V2hlL3BwREFXSnJGd1hjQkVPQjh1WXdtSWpublhUOVFVZ0piOTluaG90eDB2?=
 =?utf-8?B?VDRZOFAyL29OUWJWSXIyMG1VVTNod0E2VmovWmFLZUMvb2N0Q01PU1hZRGdj?=
 =?utf-8?Q?bHJGcdbSgZ/L/w8dQ0xW3E9gi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e60b00-f8eb-485e-2356-08dccb1b2d21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:47:56.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntM+SlbQUjDEbx0r9PuUAKcquM6xcpbFbJS/Z7HCmWTNYt1JDXDxI+WjQX7wb9YoDz2N9Shd/wrI0+etsW+Lfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270


On 8/28/2024 6:53 PM, Vinod Koul wrote:
> On 08-07-24, 20:14, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS                         |   6 +
>>  drivers/dma/amd/Kconfig             |   1 +
>>  drivers/dma/amd/Makefile            |   1 +
>>  drivers/dma/amd/ae4dma/Kconfig      |  14 ++
>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 198 ++++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 157 ++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma.h     |  85 ++++++++++++
>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>>  9 files changed, 498 insertions(+)
>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 33a1049fd38b..539bf52410de 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -947,6 +947,12 @@ L:	linux-edac@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/ras/amd/atl/*
>>  
>> +AMD AE4DMA DRIVER
>> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> +L:	dmaengine@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/dma/amd/ae4dma/
>> +
>>  AMD AXI W1 DRIVER
>>  M:	Kris Chaplin <kris.chaplin@amd.com>
>>  R:	Thomas Delev <thomas.delev@amd.com>
>> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
>> index 8246b463bcf7..8c25a3ed6b94 100644
>> --- a/drivers/dma/amd/Kconfig
>> +++ b/drivers/dma/amd/Kconfig
>> @@ -3,3 +3,4 @@
>>  # AMD DMA Drivers
>>  
>>  source "drivers/dma/amd/ptdma/Kconfig"
>> +source "drivers/dma/amd/ae4dma/Kconfig"
>> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
>> index dd7257ba7e06..8049b06a9ff5 100644
>> --- a/drivers/dma/amd/Makefile
>> +++ b/drivers/dma/amd/Makefile
>> @@ -4,3 +4,4 @@
>>  #
>>  
>>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
>> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
>> new file mode 100644
>> index 000000000000..ea8a7fe68df5
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>> @@ -0,0 +1,14 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config AMD_AE4DMA
>> +	tristate  "AMD AE4DMA Engine"
>> +	depends on (X86_64 || COMPILE_TEST) && PCI
>> +	depends on AMD_PTDMA
>> +	select DMA_ENGINE
>> +	select DMA_VIRTUAL_CHANNELS
>> +	help
>> +	  Enable support for the AMD AE4DMA controller. This controller
>> +	  provides DMA capabilities to perform high bandwidth memory to
>> +	  memory and IO copy operations. It performs DMA transfer through
>> +	  queue-based descriptor management. This DMA controller is intended
>> +	  to be used with AMD Non-Transparent Bridge devices and not for
>> +	  general purpose peripheral DMA.
>> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
>> new file mode 100644
>> index 000000000000..e918f85a80ec
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/Makefile
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# AMD AE4DMA driver
>> +#
>> +
>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>> +
>> +ae4dma-objs := ae4dma-dev.o
>> +
>> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> new file mode 100644
>> index 000000000000..c38464b96fc6
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> @@ -0,0 +1,198 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#include "ae4dma.h"
>> +
>> +static unsigned int max_hw_q = 1;
>> +module_param(max_hw_q, uint, 0444);
>> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>> +
>> +static char *ae4_error_codes[] = {
>> +	"",
>> +	"ERR 01: INVALID HEADER DW0",
>> +	"ERR 02: INVALID STATUS",
>> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>> +	"ERR 06: INVALID ALIGNMENT",
>> +	"ERR 07: INVALID DESCRIPTOR",
>> +};
>> +
>> +static void ae4_log_error(struct pt_device *d, int e)
>> +{
>> +	/* ERR 01 - 07 represents Invalid AE4 errors */
>> +	if (e <= 7)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>> +	/* ERR 08 - 15 represents Invalid Descriptor errors */
>> +	else if (e > 7 && e <= 15)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> +	/* ERR 16 - 31 represents Firmware errors */
>> +	else if (e > 15 && e <= 31)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
>> +	/* ERR 32 - 63 represents Fatal errors */
>> +	else if (e > 31 && e <= 63)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
>> +	/* ERR 64 - 255 represents PTE errors */
>> +	else if (e > 63 && e <= 255)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>> +	else
>> +		dev_info(d->dev, "Unknown AE4DMA error");
>> +}
>> +
>> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>> +{
>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +	struct ae4dma_desc desc;
>> +	u8 status;
>> +
>> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>> +	status = desc.dw1.status;
>> +	if (status && status != AE4_DESC_COMPLETED) {
>> +		cmd_q->cmd_error = desc.dw1.err_code;
>> +		if (cmd_q->cmd_error)
>> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>> +	}
>> +}
>> +
>> +static void ae4_pending_work(struct work_struct *work)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +	struct pt_cmd *cmd;
>> +	u32 cridx;
>> +
>> +	for (;;) {
>> +		wait_event_interruptible(ae4cmd_q->q_w,
>> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
>> +
>> +		atomic64_inc(&ae4cmd_q->done_cnt);
>> +
>> +		mutex_lock(&ae4cmd_q->cmd_lock);
>> +		cridx = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
>> +		while ((ae4cmd_q->dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
>> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
>> +			list_del(&cmd->entry);
>> +
>> +			ae4_check_status_error(ae4cmd_q, ae4cmd_q->dridx);
>> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
>> +
>> +			ae4cmd_q->q_cmd_count--;
>> +			ae4cmd_q->dridx = (ae4cmd_q->dridx + 1) % CMD_Q_LEN;
>> +
>> +			complete_all(&ae4cmd_q->cmp);
>> +		}
>> +		mutex_unlock(&ae4cmd_q->cmd_lock);
>> +	}
>> +}
>> +
>> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q = data;
>> +	struct pt_cmd_queue *cmd_q;
>> +	struct pt_device *pt;
>> +	u32 status;
>> +
>> +	cmd_q = &ae4cmd_q->cmd_q;
>> +	pt = cmd_q->pt;
>> +
>> +	pt->total_interrupts++;
>> +	atomic64_inc(&ae4cmd_q->intr_cnt);
>> +
>> +	wake_up(&ae4cmd_q->q_w);
> shouldnt this be last thing before returning

Sure, I will move this before returning.

>
>> +
>> +	status = readl(cmd_q->reg_control + AE4_INTR_STS_OFF);
>> +	if (status & BIT(0)) {
>> +		status &= GENMASK(31, 1);
>> +		writel(status, cmd_q->reg_control + AE4_INTR_STS_OFF);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +void ae4_destroy_work(struct ae4_device *ae4)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q;
>> +	int i;
>> +
>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>> +
>> +		if (!ae4cmd_q->pws)
>> +			break;
>> +
>> +		cancel_delayed_work_sync(&ae4cmd_q->p_work);
>> +		destroy_workqueue(ae4cmd_q->pws);
>> +	}
>> +}
>> +
>> +int ae4_core_init(struct ae4_device *ae4)
>> +{
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct ae4_cmd_queue *ae4cmd_q;
>> +	struct device *dev = pt->dev;
>> +	struct pt_cmd_queue *cmd_q;
>> +	int i, ret = 0;
>> +
>> +	writel(max_hw_q, pt->io_regs);
>> +
>> +	for (i = 0; i < max_hw_q; i++) {
>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>> +		ae4cmd_q->id = ae4->cmd_q_count;
>> +		ae4->cmd_q_count++;
>> +
>> +		cmd_q = &ae4cmd_q->cmd_q;
>> +		cmd_q->pt = pt;
>> +
>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
>> +
>> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
>> +				       dev_name(pt->dev), ae4cmd_q);
>> +		if (ret)
>> +			return ret;
>> +
>> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
>> +
>> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
>> +						   GFP_KERNEL);
>> +		if (!cmd_q->qbase)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>> +
>> +		cmd_q = &ae4cmd_q->cmd_q;
>> +
>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * AE4_Q_SZ);
>> +
>> +		/* Update the device registers with queue information. */
>> +		writel(CMD_Q_LEN, cmd_q->reg_control + AE4_MAX_IDX_OFF);
>> +
>> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
>> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_L_OFF);
>> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + AE4_Q_BASE_H_OFF);
>> +
>> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
>> +		init_waitqueue_head(&ae4cmd_q->q_w);
>> +
>> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
>> +		if (!ae4cmd_q->pws) {
>> +			ae4_destroy_work(ae4);
>> +			return -ENOMEM;
>> +		}
>> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
>> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
>> +
>> +		init_completion(&ae4cmd_q->cmp);
>> +	}
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> new file mode 100644
>> index 000000000000..43d36e9d1efb
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -0,0 +1,157 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#include "ae4dma.h"
>> +
>> +static int ae4_get_irqs(struct ae4_device *ae4)
>> +{
>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	struct pci_dev *pdev;
>> +	int i, v, ret;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
>> +		ae4_msix->msix_entry[v].entry = v;
>> +
>> +	ret = pci_alloc_irq_vectors(pdev, v, v, PCI_IRQ_MSIX);
>> +	if (ret != v) {
>> +		if (ret > 0)
>> +			pci_free_irq_vectors(pdev);
>> +
>> +		dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>> +		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>> +		if (ret < 0) {
>> +			dev_err(dev, "could not enable MSI (%d)\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = pci_irq_vector(pdev, 0);
>> +		if (ret < 0) {
>> +			pci_free_irq_vectors(pdev);
>> +			return ret;
>> +		}
>> +
>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +			ae4->ae4_irq[i] = ret;
>> +
>> +	} else {
>> +		ae4_msix->msix_count = ret;
>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +			ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void ae4_free_irqs(struct ae4_device *ae4)
>> +{
>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	struct pci_dev *pdev;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	if (ae4_msix && (ae4_msix->msix_count || ae4->ae4_irq[MAX_AE4_HW_QUEUES - 1]))
>> +		pci_free_irq_vectors(pdev);
>> +}
>> +
>> +static void ae4_deinit(struct ae4_device *ae4)
>> +{
>> +	ae4_free_irqs(ae4);
>> +}
>> +
>> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ae4_device *ae4;
>> +	struct pt_device *pt;
>> +	int bar_mask;
>> +	int ret = 0;
>> +
>> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
>> +	if (!ae4)
>> +		return -ENOMEM;
>> +
>> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
>> +	if (!ae4->ae4_msix)
>> +		return -ENOMEM;
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret)
>> +		goto ae4_error;
>> +
>> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
>> +	if (ret)
>> +		goto ae4_error;
>> +
>> +	pt = &ae4->pt;
>> +	pt->dev = dev;
>> +
>> +	pt->io_regs = pcim_iomap_table(pdev)[0];
>> +	if (!pt->io_regs) {
>> +		ret = -ENOMEM;
>> +		goto ae4_error;
>> +	}
>> +
>> +	ret = ae4_get_irqs(ae4);
>> +	if (ret < 0)
>> +		goto ae4_error;
>> +
>> +	pci_set_master(pdev);
>> +
>> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>> +
>> +	dev_set_drvdata(dev, ae4);
>> +
>> +	ret = ae4_core_init(ae4);
>> +	if (ret)
>> +		goto ae4_error;
>> +
>> +	return 0;
>> +
>> +ae4_error:
>> +	ae4_deinit(ae4);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ae4_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>> +
>> +	ae4_destroy_work(ae4);
>> +	ae4_deinit(ae4);
>> +}
>> +
>> +static const struct pci_device_id ae4_pci_table[] = {
>> +	{ PCI_VDEVICE(AMD, 0x14C8), },
>> +	{ PCI_VDEVICE(AMD, 0x14DC), },
>> +	{ PCI_VDEVICE(AMD, 0x149B), },
>> +	/* Last entry must be zero */
>> +	{ 0, }
>> +};
>> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
>> +
>> +static struct pci_driver ae4_pci_driver = {
>> +	.name = "ae4dma",
>> +	.id_table = ae4_pci_table,
>> +	.probe = ae4_pci_probe,
>> +	.remove = ae4_pci_remove,
>> +};
>> +
>> +module_pci_driver(ae4_pci_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD AE4DMA driver");
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>> new file mode 100644
>> index 000000000000..a63525792080
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -0,0 +1,85 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD AE4DMA driver
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +#ifndef __AE4DMA_H__
>> +#define __AE4DMA_H__
>> +
>> +#include "../common/amd_dma.h"
>> +
>> +#define MAX_AE4_HW_QUEUES		16
>> +
>> +#define AE4_DESC_COMPLETED		0x03
>> +
>> +#define AE4_MAX_IDX_OFF			0x08
>> +#define AE4_RD_IDX_OFF			0x0C
>> +#define AE4_WR_IDX_OFF			0x10
>> +#define AE4_INTR_STS_OFF		0x14
>> +#define AE4_Q_BASE_L_OFF		0x18
>> +#define AE4_Q_BASE_H_OFF		0x1C
>> +#define AE4_Q_SZ			0x20
> lower case for hex values please

Sure, I will change it to lowercase.

>
>> +
>> +struct ae4_msix {
>> +	int msix_count;
>> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>> +};
>> +
>> +struct ae4_cmd_queue {
>> +	struct ae4_device *ae4;
>> +	struct pt_cmd_queue cmd_q;
>> +	struct list_head cmd;
>> +	/* protect command operations */
>> +	struct mutex cmd_lock;
>> +	struct delayed_work p_work;
>> +	struct workqueue_struct *pws;
>> +	struct completion cmp;
>> +	wait_queue_head_t q_w;
>> +	atomic64_t intr_cnt;
>> +	atomic64_t done_cnt;
>> +	u64 q_cmd_count;
>> +	u32 dridx;
>> +	u32 id;
>> +};
>> +
>> +union dwou {
>> +	u32 dw0;
>> +	struct dword0 {
> nice naming dw0 dword0!
>
>> +	u8	byte0;
>> +	u8	byte1;
>> +	u16	timestamp;
>> +	} dws;
>> +};
>> +
>> +struct dword1 {
>> +	u8	status;
>> +	u8	err_code;
>> +	u16	desc_id;
>> +};
>> +
>> +struct ae4dma_desc {
>> +	union dwou dwouv;
>> +	struct dword1 dw1;
>> +	u32 length;
>> +	u32 rsvd;
>> +	u32 src_hi;
>> +	u32 src_lo;
>> +	u32 dst_hi;
>> +	u32 dst_lo;
>> +};
>> +
>> +struct ae4_device {
>> +	struct pt_device pt;
>> +	struct ae4_msix *ae4_msix;
>> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
>> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
>> +	unsigned int cmd_q_count;
>> +};
>> +
>> +int ae4_core_init(struct ae4_device *ae4);
>> +void ae4_destroy_work(struct ae4_device *ae4);
>> +#endif
>> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
>> new file mode 100644
>> index 000000000000..f9f396cd4371
>> --- /dev/null
>> +++ b/drivers/dma/amd/common/amd_dma.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD DMA Driver common
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> + */
>> +
>> +#ifndef AMD_DMA_H
>> +#define AMD_DMA_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dmapool.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/wait.h>
>> +
>> +#include "../ptdma/ptdma.h"
>> +#include "../../virt-dma.h"
> Header which adds other headers? That does not look good?
> Why not add these in C files directly

Sure, I will remove the common directory and include
everything in the C files.

Thanks,
--
Basavaraj

>
>


