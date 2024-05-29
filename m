Return-Path: <dmaengine+bounces-2204-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A78D34D7
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 12:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE21F2533F
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821EB17F376;
	Wed, 29 May 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3RHRsZzG"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB617B4FB
	for <dmaengine@vger.kernel.org>; Wed, 29 May 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979477; cv=fail; b=VjTm0OXBEF0JiSTfKhPTQr2Qhc6OibKARV+C6zhz3G8WIVv3l27WNdVhwY3XtOmcpRjI6qSTy5tYkjfZ3NGSUL0mjuqKCTMo/mlkT/uLujuLz9hiHBd+PKDn2UzADdwGVWuIkx6a0zAxunXT5mMxsjgihJ1G9F/qX2WE+oWDi78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979477; c=relaxed/simple;
	bh=K91wnJPfWTebyhnT6hvj57CCSzlb7IoJavOxxZ/60ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhZn9jNqn7RhaHkuCKoc59rRIDreVLe+GssQ4gqcXYAtDbbs2/cny20UXzJ9KdO49436M4syJZd7Y1d+doHNUwaamkjPcgl5NqZ/H5s9wPDdJY1eunKQMuM797v+tcMur787TJynwSYRGfnA+yYxQc6mnIGOYfhfQCSQtKhJ5Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3RHRsZzG; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNshRk65N4LIIcWAXTSDi/eNzTwBQ58ZXytwHKkxTGv+ntS/NCNGBO/OwlzTsGkJq2wL79oQCcagBxBukX5BALUdt5Y6zbmZdI2Uc5PJODnx6rSqBF/JMhoS+9DMrnHwmwrRMztVP1hVEiNEGHp3l6NzVxJMczkZLBDOJd84tVsn/kDQTrDG8dyQaIcbXGy5ejj5AuiaNyLoHdaXKB+TKZLtuA0MFLwG5LFa1ue+ns24+swPR5H1i0oqwxbOfb/IbmgNKc0kT/VYbt5s+Hk3z0iitn5c7oDyVq5sQz22AMtB/sbPNfQrkjnpO9/zgjE0FW/NmKy07nTstTE7YZZajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOF42EmssIb/YB2U+AvM2OtX4KV7pcJpP8rW4iwTsec=;
 b=g5rOrdm/PiD4mrj+SH8GsfCwwdHXzG6z5GhlL0EvBjWHRikOM09/ZlPB8smolzlC0jo5O0786plGdAKcvRtM90J92GLOIVi5PtqsGY0Vw0lVNRRZUMgB0jcLJmnVDCuMT4vLVgZJgB1af1WH6UXIbnaoz//OzxhZT9A6RiAjEb1KZvezrPYltawUKWT+KyGR7A2lQZNrzTUD6QN/9Ls3IvRmn/IH347Xj7kA8/NzUV51Pbiw5CUBkT7eXILa+bFLoFUPh6mYf67Dx222NWL1xgurbvERZBkzijMF/9j//z8YoqMs818A9jyLU9s4vL9/gySNPJxG5OmXNo9o6M9naQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOF42EmssIb/YB2U+AvM2OtX4KV7pcJpP8rW4iwTsec=;
 b=3RHRsZzGuIdM6rNec5Q9vC7ks5UMcmDQKZLqRfPbuq7huSWezqaVGSce9KLrId3d8y1D4T099Fq+5DvMs/npjz0zkP929FfFAiCx6lowEOj6QHa4bhO+rbl95Nc0YfJp9GvM01PUKScRR7l0FygqXUvqTIdNKJI9uoPnyEggWBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 10:44:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 10:44:31 +0000
Message-ID: <cc21bc36-fc73-431c-a1e6-0587a93eae0c@amd.com>
Date: Wed, 29 May 2024 16:14:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
To: Frank Li <Frank.li@nxp.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
 <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
 <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
 <Zk+87eRJBvbO+BhG@lizhi-Precision-Tower-5810>
 <6d8d996b-1732-4e69-95e5-af4673d24908@amd.com>
 <ZlX2kEaTMFlLNO4S@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <ZlX2kEaTMFlLNO4S@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 9425f46f-3b77-46e5-df7e-08dc7fcc5214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGFnRGtLblE0S0diV0grcUE3cHJtM2RnM3R5bVZ5ZjZyZHg4UnJiRmJkYld6?=
 =?utf-8?B?THE0Zm9iWHJZTkNpWlRWWjFQUkxnVWNXYVdBTmh6Sm1zKzVGVW9vNTBWZFh5?=
 =?utf-8?B?VXltYXd6QkNWa0lPcmc5YnhHYjRyZ2NVNy92T0dzRkpBQnBsWUNscWJpbDE4?=
 =?utf-8?B?bzNVc3l5Q3BxZCtJN3NMRy9SdXVHVmRJVG4zRmpxeU9LYk55OGVGdWdJOWJG?=
 =?utf-8?B?djgzeDR0bDFzZnhTYVNXM2NwSEthNUZLYmNpRE9OeXVOY1NnTzdVR2NuMnM2?=
 =?utf-8?B?WjZ3SDdVZVc4WTk4NmoxV0w1YXUrZmFCSmMza21XTnIySUx4TUdjSG5aNjNx?=
 =?utf-8?B?UC81NzhUd1pSMFZNQUhDZjN6L3ROdndxMnhhYTFGUWxFQ1RGNFRDbmlScHJ1?=
 =?utf-8?B?YnZheitnV2FTaVFsaW1xZ21oMnR2amg1Q3BzblZ6TzdGZHp6NTBVR2wzckVn?=
 =?utf-8?B?M0VTQkloaExYRkdpa0FqbUt1RkZ6MEd0bmtvNnE0MVJMWXpHY3NRWjNLVkF0?=
 =?utf-8?B?TGtRYXFYdHM0Y1JpTEVlUStGaWFKR3NFNVI5SHNIVUpUUDNxNTNaTTVqTGR4?=
 =?utf-8?B?VUhBNzQ2ZWRtZ0t6eXQ2SWRNT2FVQ0dYQnhwYVZpRzNyVWwrSDdFbDBiVUV3?=
 =?utf-8?B?RDI5SjMwZW1oSityUGQ4UHQvYUlWTXBVcS8rU1RkWTVKT3dlcWFNNC9KZUVm?=
 =?utf-8?B?RHNXZUNrZTFIUVl0NHczc1lESXBRbm13UFlJb3c4akdUeFJEaGpmZDNtUWxj?=
 =?utf-8?B?b0tZS1VTRlEwVDNFMlI4SXNDMmhFc0N2aVZLNlZqNk8xVSs0VHZxMnp5Mkhz?=
 =?utf-8?B?bk9ueUh4MGdCUjlqckhoa1ZzWnlkcWp3NTJYS1dXUWdJa0JjSDI1NTIvR2Y5?=
 =?utf-8?B?ZDVGWWhCVE5ENFcrVlVvMFVuVFZWaTZHbnNMMlhBY1NvUGtDL2dLd3VMT0No?=
 =?utf-8?B?MlVRaDZnOWk5WDVuTTJzeGNsZU1kTjlWaENvMzRFKyt3c3VFVy9PajBLOElE?=
 =?utf-8?B?VnR0aGcwRHc5U01LZUpBVFZkczZCS3dCVzNQdmp4SzUzUjcwcGl5dVZPRm4x?=
 =?utf-8?B?Zkk1bEIzbll3dG44S1VrV05zRGFuaTNDd3J6dkRkYUs2bjdFcHl3Z25wT2dt?=
 =?utf-8?B?ODFCczZUeDRHdkVISjF5WDRaSHJ0WVhlc1ZONkpqME4ydk9MY2hjMGVlY09O?=
 =?utf-8?B?VFJRWFhqTnp3ZDc4MUwrR1RRRk5PSUtKNUU3cENYVVNidStOaUh4Uk54TXdG?=
 =?utf-8?B?Q2FIbWZYa1NmMENrVys2NHB5UXRIaTN5NzNSWW5aNFZ4S2d0S1hEOStLZkw3?=
 =?utf-8?B?RTRTYU81Y1VtMmo1ek03cjhoTGVPZlcrN0plbE5FSlNSeVdGTUxncVhjRDFE?=
 =?utf-8?B?L0UxZHpqNGNQS0RJcWdMWFVOVThyK0pZWnhvaHJYVjRua1AvM3VwK25DZ0E2?=
 =?utf-8?B?VlMwSEdxZWZLcUxMZDlzbW9ncGc0dHJlTXUwM2ZjTE04WnRxUWZZckFjOUpY?=
 =?utf-8?B?bytxMndxejg2bnQ2SVNWbCtQenZSREcwZkFNcm90R2lDNUVWVXFieFdpaDla?=
 =?utf-8?B?cFVSczdMSThHL3VnRS84ZVVxSS9ReU5CTEtKS1FBOUs2MFJsN1p6U0FPTmVY?=
 =?utf-8?B?L055L3FHMFppZlFKc0JBekhPKzdOclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFodGRNcHE5WGo5T2paV2VPSC9iV0luN2xqWnRwWGt4QTZUWUk0ditaSmY2?=
 =?utf-8?B?VHNvQ1ltZ2ZVSWwvV2NXaGMwM3l3bE8wOGtGMC9NUUVOaGJtK09aeG5pSWJI?=
 =?utf-8?B?eFluYzR3bkhWUFpjcC82UjhqSU5FZEs5dW1DaWlKZ3EyTE42Z0pyMkZFd2pH?=
 =?utf-8?B?Qjlvbno5aXpBUWdlci9TVWtBMGNzVnVWVll1UFRBYTlHYW1tRmZQQ3Z3eS9C?=
 =?utf-8?B?YVZaMkN6b01aNjNVdU55K3VpcmViU2p3cW5uNndybFh5MXZZQksvb2ZqSFJz?=
 =?utf-8?B?WE8raEFmQXNBdkdxNGR2V293SCtmaVRkbFBhQTRaV1prUkVMQnlVSFB4ajNY?=
 =?utf-8?B?M0loZWZDZE5CN3BWc01JbGU3Z3FneWZ4cjZsSWJaT2hLb0licGdNaXNXYUtV?=
 =?utf-8?B?cmk2c3hFR0hoUGlXMW1NcGFGR1h4MXdJTE5yNkFlMmFDV0VFU0FITEh6c1BK?=
 =?utf-8?B?emdXaXFsQjRhOSthbEJoS3ZHTFZYMFM1Y0E3VG1kNy9FbDdPZXNkK2hZTGpQ?=
 =?utf-8?B?VEUxRUswSkZKR21ndXcwUG14dnUzQ1NDZmJ3TWlJQitRd1VXU0ZHOUlrcjNW?=
 =?utf-8?B?bGdDdi9PcFM2N295Uk53VDNEVzJQV0pscVBkWnZjOWhWcVcvMU5MNzA3RFBK?=
 =?utf-8?B?dDlLWTlib3FKR0JnYlErZlE5Mm9pckRvVkgwaEdWSHA1NGdkYjg0eHhGK3A0?=
 =?utf-8?B?Sm1JczZXdVFlUjVLSTdyakVuQUkwV1FCOE14dGRFMHFCOHpjVzNIRDMxZisr?=
 =?utf-8?B?R3l1TUxhY3VVaEg4WkdvQXV6ZEVjaE1CYXJEd2FmanFRN2ZPU0crM3R6OWlj?=
 =?utf-8?B?T2JGZWdPUGU3RFpmMytuOXo1MFYzYitNMGFicTZWN0JlVFM4bjA2Ly94ZE9L?=
 =?utf-8?B?c1h1VDk1cFVUNjhBWW1IeUc2KytBb1pXd3I2TWJIeTZSbnptVGVUdmFGRFJ2?=
 =?utf-8?B?bjlIa1NsTWFZNnBuUUh6NWpBS25qVnVkbUtPcEdtd3RCemtZbzVjYllmMloy?=
 =?utf-8?B?N3lzaWcwN3Ezcy9VZjhhSERyblFxOElKM1B3elBxNnZpcFB0cnB4cWxFdDNZ?=
 =?utf-8?B?ZXJEaVY5VlZFenk3MHZad3FJNUFvM3RpMkZnUlVjRWo2VFBxQnJIazdNakJH?=
 =?utf-8?B?WmM3REZGK2p0NlRmTDV0cm10Rkd2RU9Fdm5vOXZBSWNpSXZITzNvZW1rZlpN?=
 =?utf-8?B?STNmTnBmSUVxdHpmYmdtZ3oxcE1BRFJPdlIrTUtVRDAvYkU5dzhVdlRuS21X?=
 =?utf-8?B?VEMyaFB4dkF1UHBZditsSjZrZXlhUUhyazZCd28yTCt2Ly9Kd2lmRU1SYy9v?=
 =?utf-8?B?OXNhSEMyaHhFZExsSHZPbUw4QnZTSThMK2UrRTRCNzk2c05lekF4TXBIeFBo?=
 =?utf-8?B?QnJicVpQM2xHZHhveXowZ3Z0MFIrTkVCejBkMmhZQXV0NENzbCtrdjBpbk1R?=
 =?utf-8?B?cG5tVnpCYzl4byt4K1haUlkrQjRGQ0x6b1R4NUd3RDBHZ1Z0RXpQS1pDNFRH?=
 =?utf-8?B?Y3dma3lVWjIzekRLaVhVRlRXV01henZ4OE13TllwUXk0anpyem52b3JjRmJW?=
 =?utf-8?B?TVV6dFhGdU85T1IwdHc2cStUR1IrVDRpN25MUjBXa1RFSVRzSXBFUy9kSXVL?=
 =?utf-8?B?dDJEdEdkUDZBK1NPNEx6ekQ2bWtaWUNqVVZqZnQydmdBTzNZM1FPOWZlSSt6?=
 =?utf-8?B?bk8rUmlEVlB4SFc1L3NINlRVME1Ub1Y0TnVUbEMzUDY5M05adHVqVTRteHB3?=
 =?utf-8?B?ajV0MUxncER2V054b0FmZk90alUwU1gxSi9Ta1ZnTWppaDFjUjRaSDZGcEp2?=
 =?utf-8?B?RjNUY05sTTIzTVhieDk2ak9Ba1FZMCtOQ3JwZzRGOVl5aHBLMk1DR3h0RVBv?=
 =?utf-8?B?ODQ2b3ZZSVJZZ0hYZEIyNkR1ekVjTHdxMkMzSFFCRW9KU0pveG8rcUF5R05F?=
 =?utf-8?B?eHl0WTJFSVJ4aGhpMlFqeTU0Y2QvRzhENlZaZVpZZWpxLyt2QTRMUzNiUDhi?=
 =?utf-8?B?WVZuSXhSS3hCMFNwVGlrL3NkZmp6c2g0M01HR2gwby9jYk1jZXUwcW9GNjFC?=
 =?utf-8?B?cFJ6MFp2SlpSbEdLb2tLOVpRVGtPOGQxVGFDVkRJWmNIY0dFcDBNcm9PTWxZ?=
 =?utf-8?Q?EZnuzB6ukTw8GAnAhmHkCwYF/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9425f46f-3b77-46e5-df7e-08dc7fcc5214
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:44:31.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWd/GIw7MeQOj+lAtlrZOFp6fMFc0Xy/uzafeiF9kyVR7YFPsuJ2a0OH5D7eb4zuUdNz5sMQFVAODnmHQNJKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640


On 5/28/2024 8:51 PM, Frank Li wrote:
> On Mon, May 27, 2024 at 05:04:02PM +0530, Basavaraj Natikar wrote:
>> On 5/24/2024 3:32 AM, Frank Li wrote:
>>> On Tue, May 21, 2024 at 03:06:17PM +0530, Basavaraj Natikar wrote:
>>>> On 5/10/2024 11:46 PM, Frank Li wrote:
>>>>> On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
>>>>>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>>>>>> memory to memory and IO copy operation. Device commands are managed
>>>>>> via a circular queue of 'descriptors', each of which specifies source
>>>>>> and destination addresses for copying a single buffer of data.
>>>>>>
>>>>>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>>>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> ---
>>>>>>  MAINTAINERS                         |   6 +
>>>>>>  drivers/dma/amd/Kconfig             |   1 +
>>>>>>  drivers/dma/amd/Makefile            |   1 +
>>>>>>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
>>>>>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>>>>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
>>>>>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
>>>>>>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
>>>>>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
>>>>>>  9 files changed, 535 insertions(+)
>>>>>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
>>>>>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
>>>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
>>>>>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index b190efda33ba..45f2140093b6 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
>>>>>>  S:	Supported
>>>>>>  F:	drivers/ras/amd/atl/*
>>>>>>  
>>>>>> +AMD AE4DMA DRIVER
>>>>>> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> +L:	dmaengine@vger.kernel.org
>>>>>> +S:	Maintained
>>>>>> +F:	drivers/dma/amd/ae4dma/
>>>>>> +
>>>>>>  AMD AXI W1 DRIVER
>>>>>>  M:	Kris Chaplin <kris.chaplin@amd.com>
>>>>>>  R:	Thomas Delev <thomas.delev@amd.com>
>>>>>> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
>>>>>> index 8246b463bcf7..8c25a3ed6b94 100644
>>>>>> --- a/drivers/dma/amd/Kconfig
>>>>>> +++ b/drivers/dma/amd/Kconfig
>>>>>> @@ -3,3 +3,4 @@
>>>>>>  # AMD DMA Drivers
>>>>>>  
>>>>>>  source "drivers/dma/amd/ptdma/Kconfig"
>>>>>> +source "drivers/dma/amd/ae4dma/Kconfig"
>>>>>> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
>>>>>> index dd7257ba7e06..8049b06a9ff5 100644
>>>>>> --- a/drivers/dma/amd/Makefile
>>>>>> +++ b/drivers/dma/amd/Makefile
>>>>>> @@ -4,3 +4,4 @@
>>>>>>  #
>>>>>>  
>>>>>>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
>>>>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
>>>>>> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
>>>>>> new file mode 100644
>>>>>> index 000000000000..cf8db4dac98d
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>>>>>> @@ -0,0 +1,13 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +config AMD_AE4DMA
>>>>>> +	tristate  "AMD AE4DMA Engine"
>>>>>> +	depends on X86_64 && PCI
>>>>>> +	select DMA_ENGINE
>>>>>> +	select DMA_VIRTUAL_CHANNELS
>>>>>> +	help
>>>>>> +	  Enable support for the AMD AE4DMA controller. This controller
>>>>>> +	  provides DMA capabilities to perform high bandwidth memory to
>>>>>> +	  memory and IO copy operations. It performs DMA transfer through
>>>>>> +	  queue-based descriptor management. This DMA controller is intended
>>>>>> +	  to be used with AMD Non-Transparent Bridge devices and not for
>>>>>> +	  general purpose peripheral DMA.
>>>>>> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
>>>>>> new file mode 100644
>>>>>> index 000000000000..e918f85a80ec
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/ae4dma/Makefile
>>>>>> @@ -0,0 +1,10 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +#
>>>>>> +# AMD AE4DMA driver
>>>>>> +#
>>>>>> +
>>>>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
>>>>>> +
>>>>>> +ae4dma-objs := ae4dma-dev.o
>>>>>> +
>>>>>> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
>>>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..fc33d2056af2
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>>>> @@ -0,0 +1,206 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * AMD AE4DMA driver
>>>>>> + *
>>>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>>>> + * All Rights Reserved.
>>>>>> + *
>>>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include "ae4dma.h"
>>>>>> +
>>>>>> +static unsigned int max_hw_q = 1;
>>>>>> +module_param(max_hw_q, uint, 0444);
>>>>>> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>>>>> Does it get from hardware register? you put to global variable. How about
>>>>> system have two difference DMA controllers, one's max_hw_q is 1, the other
>>>>> is 2.
>>>> Yes, this global value configures the default hardware register to 1. Since
>>>> all DMA controllers are identical, they will all have the same value set for
>>>> all DMA controllers. 
>>> Even it is same now. I still perfer put 
>>>
>>> +static const struct pci_device_id ae4_pci_table[] = {
>>> +	{ PCI_VDEVICE(AMD, 0x14C8), MAX_HW_Q},
>> The default number of configurable queues can be changed up to the maximum
>> supported by the hardware to achieve optimal application performance.
>>
>> Applications can utilize these per-DMA controller queues by dynamically
>> loading and unloading drivers with the desired number of configurable
>> hardware queues. If we restrict always to max hardware queue, then
>> we can't use dynamic queue configurations for each DAM controller.
> You should use sys interface to set max queues for difference instance.
> module param will set the same value for all dma device instance.

All queues and their associated parameters are programmed during driver
initialization for DMA controller initialization. Therefore, the sys
interface will not be helpful in this case.

Furthermore, each system will have at least three identical PCI IDs
attached to its System-on-Chip (SoC). This allows applications to
dynamically load and unload drivers to utilize these queues per DMA
controller for at least three identical PCI IDs per system.

In other words, the AMD systems will have SoCs with the same PCI IDs
attached to their DMA controllers.
We do not have systems with SoCs that have different PCI IDs.

Thanks,
--
Basavaraj

>
> Frank 
>
>> Thanks,
>> --
>> Basavaraj
>>
>>> 				    ^^^^^^^^
>>>
>>> +	{ PCI_VDEVICE(AMD, 0x14DC), ...},
>>> +	{ PCI_VDEVICE(AMD, 0x149B), ...},
>>> +	/* Last entry must be zero */
>>> +	{ 0, }
>>>
>>> So if new design increase queue number in future. 
>>> You just need add one line here.
>>>
>>> Frank
>>>
>>>>>> +
>>>>>> +static char *ae4_error_codes[] = {
>>>>>> +	"",
>>>>>> +	"ERR 01: INVALID HEADER DW0",
>>>>>> +	"ERR 02: INVALID STATUS",
>>>>>> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>>>>>> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>>>>>> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>>>>>> +	"ERR 06: INVALID ALIGNMENT",
>>>>>> +	"ERR 07: INVALID DESCRIPTOR",
>>>>>> +};
>>>>>> +
>>>>>> +static void ae4_log_error(struct pt_device *d, int e)
>>>>>> +{
>>>>>> +	if (e <= 7)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>>>>>> +	else if (e > 7 && e <= 15)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>>>> +	else if (e > 15 && e <= 31)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>>>> +	else if (e > 31 && e <= 63)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>>>> +	else if (e > 63 && e <= 127)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>>>>>> +	else if (e > 127 && e <= 255)
>>>>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>>>>>> +	else
>>>>>> +		dev_info(d->dev, "Unknown AE4DMA error");
>>>>>> +}
>>>>>> +
>>>>>> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>>>>>> +{
>>>>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>>>>>> +	struct ae4dma_desc desc;
>>>>>> +	u8 status;
>>>>>> +
>>>>>> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>>>>>> +	/* Synchronize ordering */
>>>>>> +	mb();
>>>>> does dma_wmb() enough? 
>>>> Sure, I will change to dma_rmb which is enough for this scenario.
>>>>
>>>>>> +	status = desc.dw1.status;
>>>>>> +	if (status && status != AE4_DESC_COMPLETED) {
>>>>>> +		cmd_q->cmd_error = desc.dw1.err_code;
>>>>>> +		if (cmd_q->cmd_error)
>>>>>> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static void ae4_pending_work(struct work_struct *work)
>>>>>> +{
>>>>>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
>>>>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>>>>>> +	struct pt_cmd *cmd;
>>>>>> +	u32 cridx, dridx;
>>>>>> +
>>>>>> +	while (true) {
>>>>>> +		wait_event_interruptible(ae4cmd_q->q_w,
>>>>>> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>>>>>> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
>>>>> wait_event_interruptible_timeout() ? to avoid patental deadlock.
>>>> A thread will be created and started for each queue initially. These threads will wait for any DMA
>>>> operation to complete quickly. If there are no DMA operations, the threads will remain idle, but
>>>> there won't be a deadlock.
>>>>
>>>>>> +
>>>>>> +		atomic64_inc(&ae4cmd_q->done_cnt);
>>>>>> +
>>>>>> +		mutex_lock(&ae4cmd_q->cmd_lock);
>>>>>> +
>>>>>> +		cridx = readl(cmd_q->reg_control + 0x0C);
>>>>>> +		dridx = atomic_read(&ae4cmd_q->dridx);
>>>>>> +
>>>>>> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
>>>>>> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
>>>>>> +			list_del(&cmd->entry);
>>>>>> +
>>>>>> +			ae4_check_status_error(ae4cmd_q, dridx);
>>>>>> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
>>>>>> +
>>>>>> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
>>>>>> +			dridx = (dridx + 1) % CMD_Q_LEN;
>>>>>> +			atomic_set(&ae4cmd_q->dridx, dridx);
>>>>>> +			/* Synchronize ordering */
>>>>>> +			mb();
>>>>>> +
>>>>>> +			complete_all(&ae4cmd_q->cmp);
>>>>>> +		}
>>>>>> +
>>>>>> +		mutex_unlock(&ae4cmd_q->cmd_lock);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
>>>>>> +{
>>>>>> +	struct ae4_cmd_queue *ae4cmd_q = data;
>>>>>> +	struct pt_cmd_queue *cmd_q;
>>>>>> +	struct pt_device *pt;
>>>>>> +	u32 status;
>>>>>> +
>>>>>> +	cmd_q = &ae4cmd_q->cmd_q;
>>>>>> +	pt = cmd_q->pt;
>>>>>> +
>>>>>> +	pt->total_interrupts++;
>>>>>> +	atomic64_inc(&ae4cmd_q->intr_cnt);
>>>>>> +
>>>>>> +	wake_up(&ae4cmd_q->q_w);
>>>>>> +
>>>>>> +	status = readl(cmd_q->reg_control + 0x14);
>>>>>> +	if (status & BIT(0)) {
>>>>>> +		status &= GENMASK(31, 1);
>>>>>> +		writel(status, cmd_q->reg_control + 0x14);
>>>>>> +	}
>>>>>> +
>>>>>> +	return IRQ_HANDLED;
>>>>>> +}
>>>>>> +
>>>>>> +void ae4_destroy_work(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct ae4_cmd_queue *ae4cmd_q;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>>>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>>>> +
>>>>>> +		if (!ae4cmd_q->pws)
>>>>>> +			break;
>>>>>> +
>>>>>> +		cancel_delayed_work(&ae4cmd_q->p_work);
>>>>> do you need cancel_delayed_work_sync()?
>>>> Sure, I will change to cancel_delayed_work_sync.
>>>>
>>>>>> +		destroy_workqueue(ae4cmd_q->pws);
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +int ae4_core_init(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct pt_device *pt = &ae4->pt;
>>>>>> +	struct ae4_cmd_queue *ae4cmd_q;
>>>>>> +	struct device *dev = pt->dev;
>>>>>> +	struct pt_cmd_queue *cmd_q;
>>>>>> +	int i, ret = 0;
>>>>>> +
>>>>>> +	writel(max_hw_q, pt->io_regs);
>>>>>> +
>>>>>> +	for (i = 0; i < max_hw_q; i++) {
>>>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>>>> +		ae4cmd_q->id = ae4->cmd_q_count;
>>>>>> +		ae4->cmd_q_count++;
>>>>>> +
>>>>>> +		cmd_q = &ae4cmd_q->cmd_q;
>>>>>> +		cmd_q->pt = pt;
>>>>>> +
>>>>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>>>>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>>>>>> +
>>>>>> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
>>>>>> +				       dev_name(pt->dev), ae4cmd_q);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +
>>>>>> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
>>>>>> +
>>>>>> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
>>>>>> +						   GFP_KERNEL);
>>>>>> +		if (!cmd_q->qbase)
>>>>>> +			return -ENOMEM;
>>>>>> +	}
>>>>>> +
>>>>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
>>>>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
>>>>>> +
>>>>>> +		cmd_q = &ae4cmd_q->cmd_q;
>>>>>> +
>>>>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
>>>>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
>>>>>> +
>>>>>> +		/* Update the device registers with queue information. */
>>>>>> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
>>>>>> +
>>>>>> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
>>>>>> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
>>>>>> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
>>>>>> +
>>>>>> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
>>>>>> +		init_waitqueue_head(&ae4cmd_q->q_w);
>>>>>> +
>>>>>> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
>>>>> Can existed workqueue match your requirement? 
>>>> Separate work queues for each queue, compared to a existing workqueue, enhance performance by enabling
>>>> load balancing across queues, ensuring DMA command execution even under memory pressure, and
>>>> maintaining strict isolation between tasks in different queues.
>>>>
>>>>> Frank
>>>>>
>>>>>> +		if (!ae4cmd_q->pws) {
>>>>>> +			ae4_destroy_work(ae4);
>>>>>> +			return -ENOMEM;
>>>>>> +		}
>>>>>> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
>>>>>> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
>>>>>> +
>>>>>> +		init_completion(&ae4cmd_q->cmp);
>>>>>> +	}
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..4cd537af757d
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>>>>>> @@ -0,0 +1,195 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * AMD AE4DMA driver
>>>>>> + *
>>>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>>>> + * All Rights Reserved.
>>>>>> + *
>>>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include "ae4dma.h"
>>>>>> +
>>>>>> +static int ae4_get_msi_irq(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct pt_device *pt = &ae4->pt;
>>>>>> +	struct device *dev = pt->dev;
>>>>>> +	struct pci_dev *pdev;
>>>>>> +	int ret, i;
>>>>>> +
>>>>>> +	pdev = to_pci_dev(dev);
>>>>>> +	ret = pci_enable_msi(pdev);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>>>> +		ae4->ae4_irq[i] = pdev->irq;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
>>>>>> +	struct pt_device *pt = &ae4->pt;
>>>>>> +	struct device *dev = pt->dev;
>>>>>> +	struct pci_dev *pdev;
>>>>>> +	int v, i, ret;
>>>>>> +
>>>>>> +	pdev = to_pci_dev(dev);
>>>>>> +
>>>>>> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
>>>>>> +		ae4_msix->msix_entry[v].entry = v;
>>>>>> +
>>>>>> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
>>>>>> +	if (ret < 0)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	ae4_msix->msix_count = ret;
>>>>>> +
>>>>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>>>> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int ae4_get_irqs(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct pt_device *pt = &ae4->pt;
>>>>>> +	struct device *dev = pt->dev;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = ae4_get_msix_irqs(ae4);
>>>>>> +	if (!ret)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* Couldn't get MSI-X vectors, try MSI */
>>>>>> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>>>>>> +	ret = ae4_get_msi_irq(ae4);
>>>>>> +	if (!ret)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* Couldn't get MSI interrupt */
>>>>>> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static void ae4_free_irqs(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	struct ae4_msix *ae4_msix;
>>>>>> +	struct pci_dev *pdev;
>>>>>> +	struct pt_device *pt;
>>>>>> +	struct device *dev;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	if (ae4) {
>>>>>> +		pt = &ae4->pt;
>>>>>> +		dev = pt->dev;
>>>>>> +		pdev = to_pci_dev(dev);
>>>>>> +
>>>>>> +		ae4_msix = ae4->ae4_msix;
>>>>>> +		if (ae4_msix && ae4_msix->msix_count)
>>>>>> +			pci_disable_msix(pdev);
>>>>>> +		else if (pdev->irq)
>>>>>> +			pci_disable_msi(pdev);
>>>>>> +
>>>>>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
>>>>>> +			ae4->ae4_irq[i] = 0;
>>>>>> +	}
>>>>>> +}
>>>>>> +
>>>>>> +static void ae4_deinit(struct ae4_device *ae4)
>>>>>> +{
>>>>>> +	ae4_free_irqs(ae4);
>>>>>> +}
>>>>>> +
>>>>>> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>> +{
>>>>>> +	struct device *dev = &pdev->dev;
>>>>>> +	struct ae4_device *ae4;
>>>>>> +	struct pt_device *pt;
>>>>>> +	int bar_mask;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
>>>>>> +	if (!ae4)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
>>>>>> +	if (!ae4->ae4_msix)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	ret = pcim_enable_device(pdev);
>>>>>> +	if (ret)
>>>>>> +		goto ae4_error;
>>>>>> +
>>>>>> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
>>>>>> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
>>>>>> +	if (ret)
>>>>>> +		goto ae4_error;
>>>>>> +
>>>>>> +	pt = &ae4->pt;
>>>>>> +	pt->dev = dev;
>>>>>> +
>>>>>> +	pt->io_regs = pcim_iomap_table(pdev)[0];
>>>>>> +	if (!pt->io_regs) {
>>>>>> +		ret = -ENOMEM;
>>>>>> +		goto ae4_error;
>>>>>> +	}
>>>>>> +
>>>>>> +	ret = ae4_get_irqs(ae4);
>>>>>> +	if (ret)
>>>>>> +		goto ae4_error;
>>>>>> +
>>>>>> +	pci_set_master(pdev);
>>>>>> +
>>>>>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>>>>>> +	if (ret) {
>>>>>> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>>>> +		if (ret)
>>>>>> +			goto ae4_error;
>>>>>> +	}
>>>>> needn't failback to 32bit.  never return failure when bit >= 32.
>>>>>
>>>>> Detail see: 
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81
>>>>>
>>>>> if (support_48bit)
>>>>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
>>>>> else
>>>>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
>>>>>
>>>>> you decide if support_48bit by hardware register or PID/DID
>>>> Sure, I will add only this line dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)).
>>>>
>>>>>> +
>>>>>> +	dev_set_drvdata(dev, ae4);
>>>>>> +
>>>>>> +	ret = ae4_core_init(ae4);
>>>>>> +	if (ret)
>>>>>> +		goto ae4_error;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +
>>>>>> +ae4_error:
>>>>>> +	ae4_deinit(ae4);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static void ae4_pci_remove(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
>>>>>> +
>>>>>> +	ae4_destroy_work(ae4);
>>>>>> +	ae4_deinit(ae4);
>>>>>> +}
>>>>>> +
>>>>>> +static const struct pci_device_id ae4_pci_table[] = {
>>>>>> +	{ PCI_VDEVICE(AMD, 0x14C8), },
>>>>>> +	{ PCI_VDEVICE(AMD, 0x14DC), },
>>>>>> +	{ PCI_VDEVICE(AMD, 0x149B), },
>>>>>> +	/* Last entry must be zero */
>>>>>> +	{ 0, }
>>>>>> +};
>>>>>> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
>>>>>> +
>>>>>> +static struct pci_driver ae4_pci_driver = {
>>>>>> +	.name = "ae4dma",
>>>>>> +	.id_table = ae4_pci_table,
>>>>>> +	.probe = ae4_pci_probe,
>>>>>> +	.remove = ae4_pci_remove,
>>>>>> +};
>>>>>> +
>>>>>> +module_pci_driver(ae4_pci_driver);
>>>>>> +
>>>>>> +MODULE_LICENSE("GPL");
>>>>>> +MODULE_DESCRIPTION("AMD AE4DMA driver");
>>>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..24b1253ad570
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>>>>>> @@ -0,0 +1,77 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +/*
>>>>>> + * AMD AE4DMA driver
>>>>>> + *
>>>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>>>> + * All Rights Reserved.
>>>>>> + *
>>>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> + */
>>>>>> +#ifndef __AE4DMA_H__
>>>>>> +#define __AE4DMA_H__
>>>>>> +
>>>>>> +#include "../common/amd_dma.h"
>>>>>> +
>>>>>> +#define MAX_AE4_HW_QUEUES		16
>>>>>> +
>>>>>> +#define AE4_DESC_COMPLETED		0x3
>>>>>> +
>>>>>> +struct ae4_msix {
>>>>>> +	int msix_count;
>>>>>> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>>>>>> +};
>>>>>> +
>>>>>> +struct ae4_cmd_queue {
>>>>>> +	struct ae4_device *ae4;
>>>>>> +	struct pt_cmd_queue cmd_q;
>>>>>> +	struct list_head cmd;
>>>>>> +	/* protect command operations */
>>>>>> +	struct mutex cmd_lock;
>>>>>> +	struct delayed_work p_work;
>>>>>> +	struct workqueue_struct *pws;
>>>>>> +	struct completion cmp;
>>>>>> +	wait_queue_head_t q_w;
>>>>>> +	atomic64_t intr_cnt;
>>>>>> +	atomic64_t done_cnt;
>>>>>> +	atomic64_t q_cmd_count;
>>>>>> +	atomic_t dridx;
>>>>>> +	unsigned int id;
>>>>>> +};
>>>>>> +
>>>>>> +union dwou {
>>>>>> +	u32 dw0;
>>>>>> +	struct dword0 {
>>>>>> +	u8	byte0;
>>>>>> +	u8	byte1;
>>>>>> +	u16	timestamp;
>>>>>> +	} dws;
>>>>>> +};
>>>>>> +
>>>>>> +struct dword1 {
>>>>>> +	u8	status;
>>>>>> +	u8	err_code;
>>>>>> +	u16	desc_id;
>>>>>> +};
>>>>>> +
>>>>>> +struct ae4dma_desc {
>>>>>> +	union dwou dwouv;
>>>>>> +	struct dword1 dw1;
>>>>>> +	u32 length;
>>>>>> +	u32 rsvd;
>>>>>> +	u32 src_hi;
>>>>>> +	u32 src_lo;
>>>>>> +	u32 dst_hi;
>>>>>> +	u32 dst_lo;
>>>>>> +};
>>>>>> +
>>>>>> +struct ae4_device {
>>>>>> +	struct pt_device pt;
>>>>>> +	struct ae4_msix *ae4_msix;
>>>>>> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
>>>>>> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
>>>>>> +	unsigned int cmd_q_count;
>>>>>> +};
>>>>>> +
>>>>>> +int ae4_core_init(struct ae4_device *ae4);
>>>>>> +void ae4_destroy_work(struct ae4_device *ae4);
>>>>>> +#endif
>>>>>> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..31c35b3bc94b
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/dma/amd/common/amd_dma.h
>>>>>> @@ -0,0 +1,26 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +/*
>>>>>> + * AMD DMA Driver common
>>>>>> + *
>>>>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>>>>>> + * All Rights Reserved.
>>>>>> + *
>>>>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef AMD_DMA_H
>>>>>> +#define AMD_DMA_H
>>>>>> +
>>>>>> +#include <linux/device.h>
>>>>>> +#include <linux/dmaengine.h>
>>>>>> +#include <linux/pci.h>
>>>>>> +#include <linux/spinlock.h>
>>>>>> +#include <linux/mutex.h>
>>>>>> +#include <linux/list.h>
>>>>>> +#include <linux/wait.h>
>>>>>> +#include <linux/dmapool.h>
>>>>> order by alphabet
>>>> Sure, I will change it accordingly.
>>>>
>>>> Thanks,
>>>> --
>>>> Basavaraj
>>>>
>>>>>> +
>>>>>> +#include "../ptdma/ptdma.h"
>>>>>> +#include "../../virt-dma.h"
>>>>>> +
>>>>>> +#endif
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>


