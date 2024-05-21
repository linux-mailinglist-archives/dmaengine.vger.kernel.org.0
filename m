Return-Path: <dmaengine+bounces-2118-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC38CAAE1
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823431C21AF5
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB36CDA8;
	Tue, 21 May 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MQTn2NSp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405F6A332
	for <dmaengine@vger.kernel.org>; Tue, 21 May 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284195; cv=fail; b=AE9vP/MmHejz+GRF9uY9ZFOugUjqZU+su+bfSd0sNeGMB4d3Y42yqFAI8aHjASqL4vBTNkJ1M9rJNGGL8zeBQiA15FD6iXEDpY0jrMob3/9E60PH5hjSl8oRaM/i5JMRzizh8D+sHmGK1ExDFjKlqiYRmyhsatVP17vGl6Hs7SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284195; c=relaxed/simple;
	bh=iILUOCVu/PPaitWXG6K1fbdheQf6LVOuxnEwO8og5uY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmMrwT2MeA+BcisqmXLaFPEvXEGZH1yYhRYKoNnD/HezT5/wZNWM9TnkDZNsv2nitttrFh5lwdpR7/XQ5MkmpbInhLv9INQMUUlfBIDbnGhOry797ij2GVWrrzgoKmgqV0hAmCqXNrCDYObtkRx3kx61MPa6Yy6ms8V8e711a/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MQTn2NSp; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+5vBSJHuhQ9XoV1z8QlxghC7MnexJJlEmBZrSgqiwwopr9G+XzmDW3ujhdP5z9KvSfFscfkiAv4YLR1jxRos4d2gWzUrSXJeyRee00QHLWDTFmNem6E+hL0RV9yen2YAD8OPO9rtafozwVB5Dg62od9zy8nOgy+T8iW3+JZYGEJGLRyB2YV6eVRK9K4mRlG4zVcup+WBl8JEs9BwXU5gPXTo9XrtZPMun4skqxwrUhq6ZS4EZYX9ghJgnAZEnIh6WB9YD3VNJMssuVlJuRN4tA61bYQsNuAnhoT0l+2b2ZrYyjiLvFS4wV8qa3Eq5+/9NSDmOpUbnEDpzMsKm0Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/FN69arqHBphllQ9TxLavGqIkjWri0tIR9mtREbn74=;
 b=LWp9E/VybJBi0z48n2k4LmQH5A4r3Jk1paLw86yGA4bSnpJ7NRtCXN7Sk58Su8VEZyL4AQ7mpij5nJhfkwRla8IoXdvmN1zjieqLHuub0DaJD3YnnTiejWc+bKU5I7v9V1c9+CdkAWbYUz0aDQwtxZHdAS72VI6Way/JQRO5PU+DNr1Dc4Z74O0C6jZ4XFCLKKVIpNdEBtjXcTc0piqcDVAmEWCK9UJvIPgjUep0HfWDICTmz+Sn/UaZOUJIz7oUoyRxYIJDXcgg9syxKMxfK8pa2qaBcV3uHDb+X+Mvc907VVJDgkHPeIjC8TDw8ToqBqqd1/EWbOa6a/DtDGy+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/FN69arqHBphllQ9TxLavGqIkjWri0tIR9mtREbn74=;
 b=MQTn2NSpTowIfvhpLQnhOfLStoZ1WKkT1wEHAjSh7qfNaC7RLU8VxJwTr/SgyE1Hz4ZHpSezO77WFKy5xlfgzYfw+bg10Yh5pmwAdvRenOrxksvRL1ouTOfcEPyWgwoI2RqcWCkjMFMRiSkXoSAlKVkI14xk/Lf6JTzbrJK92cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 09:36:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2e13:7e7f:4fc6:2fee]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2e13:7e7f:4fc6:2fee%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:36:30 +0000
Message-ID: <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
Date: Tue, 21 May 2024 15:06:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
To: Frank Li <Frank.li@nxp.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
 <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f59dce8-f1c1-41a7-1501-08dc79797e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZCL0dGRlBFZnpYOWg4SG1pTkhyNWo1RWFFbXJhcngrOXl3QXVvak96a1pp?=
 =?utf-8?B?U0RaTXRUaTR0cXhrWm5jekNGbFE5QzdNZHp2YzlhTkdzUTNrUkVmcjV5YTVI?=
 =?utf-8?B?SFhjUy83aExuVGZ1NDlUdXZJYnlXOU5hQW1Qa1dRYW0xay9sa0VEREM1Y0k1?=
 =?utf-8?B?dnhiNXlUUHg2L2dJY1AwdjlXdUo2eUxKTUhTQUlxM1JXOTZLSmNMbFlXL0dO?=
 =?utf-8?B?T014Vzc3M28zQ2RIM244TVo3U0Z3djhLaXJLamhsU3JaLzVRbnN4SWpaaUF2?=
 =?utf-8?B?MDZKOWtvZmNEQWRxRDE3L2VNcFI0RnM5SVMySEdHN3FJL1g4MXNEMzNsOS9B?=
 =?utf-8?B?Y2R0VGpLL1prR1MxNllkTEF4Ymh6STNmcjM1NjJmM1had3BLd3pBNjI0Zkpo?=
 =?utf-8?B?NUVkUnZwWkNKUE1iNDBKajlNSHNpOGt3aFFHdERJeDU1UmFQSnFlallMc1pz?=
 =?utf-8?B?YnRTYk5MQ1VBdUFuV210OVI5THZqV0JYRlFIa1R3U0dveXRUSFArU0ZNWWJq?=
 =?utf-8?B?Q0k3NHJWcFgzMlgvenA2Mzd2R3UyRFVSekFZQnpxU3dzK0syd0RDTjBlVnlK?=
 =?utf-8?B?bDB4NURwZnYwVWlsVU8xL21kcWowMCtJMWwwTGppaDltU3ZISkpOenQ0OFRN?=
 =?utf-8?B?ZVIxbnU0REJ0MGFGUFlXSjZQTVRMS2lKNHB3di9TTmd0bzM2YzdCSm12bnBk?=
 =?utf-8?B?QWk5bVV4dzFsNnVES2loVWpPcVVsYTBzbjVTaHFnaW1uWE5hRW1KOW0ybGxq?=
 =?utf-8?B?VXk4R2pEVER6QzFqQjM0ZVU2MjVSRGMzL2ZUbzI4M2huVHJYdzl6N2V5WDln?=
 =?utf-8?B?WXF3T2hDdFJ1VUtNNDlQV1RraHlBLzhpYVJsU3JmQ1ZGenZVMExiTDBWOGRH?=
 =?utf-8?B?SFpDZGJYSXFwbmhsdnRldmgvZlJVTjEwTHE5MlNoNTU0aXkyeFQyZW5tWWd1?=
 =?utf-8?B?OUNNUEM0TE1OTzk3Z2MyTlF0NHNXMTRydDE0OWYzcGpsTXhERVcvdXIwQ1V3?=
 =?utf-8?B?MG9SdERhVmthODFSc2tHb3BFdFUwL1RXbVRUTnpVZ3AwK0pvdlhpWHA0b01u?=
 =?utf-8?B?STZhREVBaEd1a1gxYmkwUHduaHNuUklSY1AzS0Q4cmhrOFIzYzdMRlAwVDV1?=
 =?utf-8?B?Z1hzc0Z1UVZubDF1ZmMzQmtreFZqMzRScTliSXh6UUhhdzlrbW1xMUxUZTZ4?=
 =?utf-8?B?NmFmbkluUGxzeGpvdEEvMVZXZ3ZUU3NSdE0weTZHTVM1YzkyZVdwZThmbW5n?=
 =?utf-8?B?Q3AyYVBBQ3hZTHNacDViN1ErQ0NaalNFZ1M5QU1WaS9RWnE3aE5ZQUt3b3ho?=
 =?utf-8?B?aXpNRlhVZWlvbnBhTURnTFlKMEMyd2hnZVRQQWUzdjJFMXZQeHZLUWJBS1hx?=
 =?utf-8?B?TDJRODJ4QVArYzZ0YWdoNmYzUFFjOGZmSFVOalZGMHQvUVV0bFJjbHV6TUVH?=
 =?utf-8?B?QlgzeGZTWFVKWUVqZWtFNVBBc3gxYkIzNlVUSGFjMi95bDJ2SERpNHhhVmN2?=
 =?utf-8?B?dlJjZnMwMVdjYURTcnpHZTd4SmxiS3VDUTBSak1RT0FTdWFwbHRlTVVKMlhx?=
 =?utf-8?B?dGlXbzJVYllJMGFWcFNsYXhqSTE1TzY1TTdTK0R4NnVaQ24raXVRdXNPMXBs?=
 =?utf-8?B?ZUxqUUtHT3g5eUdTazF2RnY0Y3NmcGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUtPR29uL3NCR3FBVE5ScUd1b2Q1ZlZ2aTFKSHBJUm9vbW5tNUdaL29qNEdm?=
 =?utf-8?B?K1VGSkVrcGlWemQ0aVBER2txVGNJS1pNQjBsZmJSMmlqdTRjZ2hoTmgreG1w?=
 =?utf-8?B?d1BzR3BiWVVCVC9HRTI1WDh5b3A1aVdadnVDSFFIZFZkeW9oaVp6RXF4RlFv?=
 =?utf-8?B?VGVIQjVJeDYyeExDVnBFSkRZd2pTbzRyYVRoYUFjTVYvMWg1OGtDT2ZXK0t1?=
 =?utf-8?B?aWNmdDZ3Vm9oNjhUaEpuKzF3UlphRno2L1VrOFJjVzdJQnNNRmFBVkdJb1Qv?=
 =?utf-8?B?V3BjaDFOS0k5MjNRMFhQaGppUGdXanZvTzYwUmVvU256cGJVdi80Q1JKbVhX?=
 =?utf-8?B?M2pCVzZsQTkrKzlldHptYVI4TitZY2dqSmtXcU5LNkZjNW1QSVJJT0tDeC9U?=
 =?utf-8?B?c0RkU1hwUjlpcWNzZlRzWjNuSnpJMXQzTnBMSzJPNGUydG10cVAvOXF5bDg2?=
 =?utf-8?B?dytIVmFRM2k4MTAyL05wMHRDaU8vVzdoZUxlOFFPZHRHd2JBWFV2cUwvZDU4?=
 =?utf-8?B?ckFIblNFWE5HTmN5bFR1N0dKdjJZUVJRdEdtemdIeVZPNWVzWlhkZDNtTTBz?=
 =?utf-8?B?ZUVROXJDNDA2eFUxanU5WnBYNUY3RnhKZDlyaEt3c2JiNGdKclg0UDltYU9X?=
 =?utf-8?B?MFlVbFU4bVdPUDUyaDZ3VTJ5MTFTNmFGV1ZqT0FuQkZqajFoYUJUYkdvMWkw?=
 =?utf-8?B?T1ZzRWNzM1J5NVduNFZyMVpwM00zcHhPYVBNUThWc1kvMTZIK1BZQ0prc2pK?=
 =?utf-8?B?ZmZNRDBaSFFKekVrbTFyZi9MSHV2N3J4K0ZKNUhSQXlEcVZnUkhwWlpnREtr?=
 =?utf-8?B?YnRhUFF3RzBuem0xVW0rUVc0M2djZDVJbzl0QXBod3ZXWHUvL0oveEs4TDht?=
 =?utf-8?B?UXNCY1NHZS9VQ3dmOFlGcmJCMmpCeCtOV2gvbS9JQzBCSDlNN1N4OWtiRWZC?=
 =?utf-8?B?U0ljemY5WnBSMFJYanZUZFFvWmNobndhSXAwNUROUTNPRVZsaHBrcWlxY241?=
 =?utf-8?B?ZXNPb0Z6ZDZRTlBaVnY2aTVqbFh6Y1hOaEdVK3lvcEhiZnRTdm4zdCtCdVM4?=
 =?utf-8?B?cmtCVjRDWHhQc05TbkViM1dSQXVTMHkyWFhXSUxHTEtSTDhlK2c0V2c4dmJL?=
 =?utf-8?B?L2NXUG5mRm9CKzBWcmw0cHJWVnduVjlxeUorTXAxbGk3b2pqeTc5UWdsWmMy?=
 =?utf-8?B?TmVLRlI0c2Y3ZHM2ZFJUODNJVFgxUGNhQ3dCMW1zbTc0aTBmMVRXbmRjNk0x?=
 =?utf-8?B?eFBEOGtWWFErYU81RlY1WFE0N284Vm9oaFZZVU1SSnFTR3RFeXRvRk9tOHQx?=
 =?utf-8?B?V3pENzQwL2Q4QWIvYVp6SnUxYUpLbFlXVFFadFUzTmh1QnBYUDV2YVBIS3Zo?=
 =?utf-8?B?WDBpQlVBVXBWZGlkV0VqcisvQXVPSU80NHBTN0tONktuRmdhTHNZa3dMcnA5?=
 =?utf-8?B?enI5WGNiSWRqMk9od3RuUi9SMTRFWmxFU0VsazVULzl4Q2NSL253UUlGU0d1?=
 =?utf-8?B?VDFzMnk3RTdKZjRQNGNsaEFmcmxveHVQWGRSWG1mZGFUcW5lVkJlUXBuUXYy?=
 =?utf-8?B?SVhrNFFvVTJzVk16QTJyTXFFWnFJN0V5bVZybUtNcVlJNmVCTGY0TERCVU1N?=
 =?utf-8?B?all4WWs2SCtVUURja1dsQVp2eUErc1B3aXJyMDdlTWVWYVF1U1lDbUYyMVcr?=
 =?utf-8?B?clFPbnhobzJwOU44emNnaktKSWNhdmlnZExqMEIzbjVxU0xQeE80U1V0Zndj?=
 =?utf-8?B?cWRoVFhpUEVJb3d2dWNOS2p3SmIwMXJXdmN3TnArNUw4SDcvOUt6UFIzKzZX?=
 =?utf-8?B?LzVVMWVUQU1ialkvWHltWjIvZU1qVkoxS2tSVTIxcFd1N2xRSjYzQ3pjSGNu?=
 =?utf-8?B?bCsyYUkzMGZyQkxsN2xucTUrKzZEWmUxYkVPZlhTMnBqOEpQb05PUSsvTTZa?=
 =?utf-8?B?VW1lTmtyc05lRnQ4NmFxYTZIbDNWYmFtK241T3MxT3UxbHlVVHlaK3JJbU51?=
 =?utf-8?B?N2lVSWdVeEJDZ0pkSHpFZm9BcXE0L3hvMk1wS3VPb3l6RmhGRzhSV1BvUHRV?=
 =?utf-8?B?M2VXMUVVNHR3US93V1BUZ3JQbk9sZzZoSGtJR1NPd3NBWitzVDZiR0hSVStC?=
 =?utf-8?Q?fSfNIgZu7eQYfilrXJe2LLpAH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f59dce8-f1c1-41a7-1501-08dc79797e8d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:36:30.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdvu2CAPbjHxY4lKMqHViGE+PIjUQHMWS25F+No0+Wuq+JJ7PfFAXdrrhVW+dS+dDskhw9WjXSO5D3cFttPvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409


On 5/10/2024 11:46 PM, Frank Li wrote:
> On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS                         |   6 +
>>  drivers/dma/amd/Kconfig             |   1 +
>>  drivers/dma/amd/Makefile            |   1 +
>>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>>  9 files changed, 535 insertions(+)
>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b190efda33ba..45f2140093b6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
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
>> index 000000000000..cf8db4dac98d
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config AMD_AE4DMA
>> +	tristate  "AMD AE4DMA Engine"
>> +	depends on X86_64 && PCI
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
>> index 000000000000..fc33d2056af2
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> @@ -0,0 +1,206 @@
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
> Does it get from hardware register? you put to global variable. How about
> system have two difference DMA controllers, one's max_hw_q is 1, the other
> is 2.

Yes, this global value configures the default hardware register to 1. Since
all DMA controllers are identical, they will all have the same value set for
all DMA controllers. 

>
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
>> +	if (e <= 7)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>> +	else if (e > 7 && e <= 15)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> +	else if (e > 15 && e <= 31)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> +	else if (e > 31 && e <= 63)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> +	else if (e > 63 && e <= 127)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>> +	else if (e > 127 && e <= 255)
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
>> +	/* Synchronize ordering */
>> +	mb();
> does dma_wmb() enough? 

Sure, I will change to dma_rmb which is enough for this scenario.

>
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
>> +	u32 cridx, dridx;
>> +
>> +	while (true) {
>> +		wait_event_interruptible(ae4cmd_q->q_w,
>> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
> wait_event_interruptible_timeout() ? to avoid patental deadlock.

A thread will be created and started for each queue initially. These threads will wait for any DMA
operation to complete quickly. If there are no DMA operations, the threads will remain idle, but
there won't be a deadlock.

>
>> +
>> +		atomic64_inc(&ae4cmd_q->done_cnt);
>> +
>> +		mutex_lock(&ae4cmd_q->cmd_lock);
>> +
>> +		cridx = readl(cmd_q->reg_control + 0x0C);
>> +		dridx = atomic_read(&ae4cmd_q->dridx);
>> +
>> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
>> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
>> +			list_del(&cmd->entry);
>> +
>> +			ae4_check_status_error(ae4cmd_q, dridx);
>> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
>> +
>> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
>> +			dridx = (dridx + 1) % CMD_Q_LEN;
>> +			atomic_set(&ae4cmd_q->dridx, dridx);
>> +			/* Synchronize ordering */
>> +			mb();
>> +
>> +			complete_all(&ae4cmd_q->cmp);
>> +		}
>> +
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
>> +
>> +	status = readl(cmd_q->reg_control + 0x14);
>> +	if (status & BIT(0)) {
>> +		status &= GENMASK(31, 1);
>> +		writel(status, cmd_q->reg_control + 0x14);
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
>> +		cancel_delayed_work(&ae4cmd_q->p_work);
> do you need cancel_delayed_work_sync()?

Sure, I will change to cancel_delayed_work_sync.

>
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
>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
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
>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>> +
>> +		/* Update the device registers with queue information. */
>> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
>> +
>> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
>> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
>> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
>> +
>> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
>> +		init_waitqueue_head(&ae4cmd_q->q_w);
>> +
>> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
> Can existed workqueue match your requirement? 

Separate work queues for each queue, compared to a existing workqueue, enhance performance by enabling
load balancing across queues, ensuring DMA command execution even under memory pressure, and
maintaining strict isolation between tasks in different queues.

>
> Frank
>
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
>> index 000000000000..4cd537af757d
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -0,0 +1,195 @@
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
>> +static int ae4_get_msi_irq(struct ae4_device *ae4)
>> +{
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	struct pci_dev *pdev;
>> +	int ret, i;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	ret = pci_enable_msi(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +		ae4->ae4_irq[i] = pdev->irq;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
>> +{
>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	struct pci_dev *pdev;
>> +	int v, i, ret;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
>> +		ae4_msix->msix_entry[v].entry = v;
>> +
>> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ae4_msix->msix_count = ret;
>> +
>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ae4_get_irqs(struct ae4_device *ae4)
>> +{
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	int ret;
>> +
>> +	ret = ae4_get_msix_irqs(ae4);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	/* Couldn't get MSI-X vectors, try MSI */
>> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>> +	ret = ae4_get_msi_irq(ae4);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	/* Couldn't get MSI interrupt */
>> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static void ae4_free_irqs(struct ae4_device *ae4)
>> +{
>> +	struct ae4_msix *ae4_msix;
>> +	struct pci_dev *pdev;
>> +	struct pt_device *pt;
>> +	struct device *dev;
>> +	int i;
>> +
>> +	if (ae4) {
>> +		pt = &ae4->pt;
>> +		dev = pt->dev;
>> +		pdev = to_pci_dev(dev);
>> +
>> +		ae4_msix = ae4->ae4_msix;
>> +		if (ae4_msix && ae4_msix->msix_count)
>> +			pci_disable_msix(pdev);
>> +		else if (pdev->irq)
>> +			pci_disable_msi(pdev);
>> +
>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>> +			ae4->ae4_irq[i] = 0;
>> +	}
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
>> +	if (ret)
>> +		goto ae4_error;
>> +
>> +	pci_set_master(pdev);
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>> +	if (ret) {
>> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +		if (ret)
>> +			goto ae4_error;
>> +	}
> needn't failback to 32bit.  never return failure when bit >= 32.
>
> Detail see: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81
>
> if (support_48bit)
> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
> else
> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
>
> you decide if support_48bit by hardware register or PID/DID

Sure, I will add only this line dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)).

>
>
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
>> index 000000000000..24b1253ad570
>> --- /dev/null
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -0,0 +1,77 @@
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
>> +#define AE4_DESC_COMPLETED		0x3
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
>> +	atomic64_t q_cmd_count;
>> +	atomic_t dridx;
>> +	unsigned int id;
>> +};
>> +
>> +union dwou {
>> +	u32 dw0;
>> +	struct dword0 {
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
>> index 000000000000..31c35b3bc94b
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
>> +#include <linux/pci.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/mutex.h>
>> +#include <linux/list.h>
>> +#include <linux/wait.h>
>> +#include <linux/dmapool.h>
> order by alphabet

Sure, I will change it accordingly.

Thanks,
--
Basavaraj

>
>> +
>> +#include "../ptdma/ptdma.h"
>> +#include "../../virt-dma.h"
>> +
>> +#endif
>> -- 
>> 2.25.1
>>


