Return-Path: <dmaengine+bounces-4516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A8A3A2EA
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 17:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F8C7A1C94
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E414A4E7;
	Tue, 18 Feb 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uj42zqpw"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74B1B6D18;
	Tue, 18 Feb 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896341; cv=fail; b=hH3dLb+QGwOsZ0aS4b6mDO8UJG3MZCu/8v7/0auUoS7HUABM7tP0XAkt6Hck9L+rP4gkfbrI4AKCo788wnLCJZbathAymYyRF8kJsEWlusCVqmBmQC+r8iF5CmXvSJDzSMdOWwhFJWyekwMhQ/qv31NpY1IozFZpQ7bXcI3p63g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896341; c=relaxed/simple;
	bh=1TybwHJVwH7AFzb08NcPQZKLWiF8n5iFGFZCQmRNRb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IupEIS6ntvcnsyppnWgw7oWqODxE/VhDVUVl/I8ovsVWwi2eYOA4j96W77LTObxcFvYD7jZyOWjDzJhKJKDFztfAK1Z9knUJFgaIbN+xte9VPidX7LI9CBMTe2oUl4yCQvd5q0gQ4Yfj5NDAQ1JTyJxjTNntA/qMOMOZBZ5mN4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uj42zqpw; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvGlliyh/J0ZSivms5VvOaVRdF7AyMcz6051uAf1cJARP0HezU2gwwlXfP4T5cpNm91Fy94BSJVS7aGPndgrF4I/hiQZSs6hQmROyybfgOk8hsubTfMUoT+o8jUJBsnMsPou2/V97XdaZcjiAK72V1unSNedXN7HIyvST1Mll+u6iUdlG38SdraEUU8/BhDjW9HJjAtaA4wmnH0qmydDIVmyIV16maDM3/LNSAy5I/KFN3ldQaEt42Bhc5dVKoWPlx6dBMxdOIlrnArS+kVcwv4Mk2Pn3k0KECyTLfdhvkqY6YEmOufzrOGcRzsV+cYDnzEF1T2BmvOT3zugHMaSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBaVycugh+G5J/pTuXjR4fYZn8mHUBq6vdFfhYsxDug=;
 b=YrSdhsLOvIU0jMLLXys14t64Jdrsyj/vFNU5ud5pH0nuiENtpA2mtsywvD7fSHlSxhlj2kQL4zAAdYqNvsNfzeASTFn1yeN4hA4WJij14EFxP7Bmb82i2pyAa9sM7qiSma0CCcWGw1uCP8oSXVY3cpf17Sq7KVHc3B0l6wwmmt9+6YqcRxdYdnTBhTLmmImZhodd/D7Zai+H585bRBAlyPYUPkxymSUOPbhhtgC0FYnRLnSbDoFDwcflfuWBqdlUuHhks5JWPNDMXf67Pj1ls/G0Dg20Q9bJix0SmgzfMoDgXkE4R8EzjCIG71I3q7nQKx3idbYsVJuQwAGBirLKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBaVycugh+G5J/pTuXjR4fYZn8mHUBq6vdFfhYsxDug=;
 b=uj42zqpwMHbq86waT4oNMFL8xAYEOEoff/ZqKGM8aLjVN3rVAcy0keLxju+j6EdOmjuUyIdB+4paoJNm984ldLbTOR+QK4lAo8p/I7qi1OfFnxew/tNXpXO2MDyRWLpFArRy2bLvBST/B2JHqI0FHPAld3nX0PZQuWw6bRRX9pUoRS0Gnkf4Vlcz5NS5LTrHLNXvQ4gFT6RAkNd0pmbGU23scUqBgxw48Kf3/CknDu/h6OnP8Ogv7r0l/wOBGJ4SW+21MgWXvRVbAEFYzKJvXTkxKDk/cy0UEOt7/niI4dDbuWlvlaYIzZC4LZbwOmWwXl1IIaNx5P1NngksRSmf+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 16:32:17 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 16:32:16 +0000
Message-ID: <f44a4303-d106-408c-ba59-911fe7b9a290@nvidia.com>
Date: Tue, 18 Feb 2025 08:32:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: e02d0374-9a28-4fae-8f81-08dd5039ce8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1o4TUZMNC9DRk45QkRTM0R3MWlOUTVxU2lzbi9ORWZlc2xJVHR5Qm9IZjJS?=
 =?utf-8?B?dGpUaHo3RzN2VEhodkd1R05MNDMyODNldXFWVnJkTHBvSVVPaEg3aWZ3WTNW?=
 =?utf-8?B?UkRYUVk4TW0vYmI0N3REZWxVNjBJbnF3Wk9ZdFIybU1LcVJ6RmlUU0xxbEdZ?=
 =?utf-8?B?LzFCTitaVnhRbHZWZGFCb0F5TzVUWC8vTEpkMDMwbFArRVFHdmY5emNwRXNM?=
 =?utf-8?B?R1IwWk15eHMzQ055KzRuc1VrdWg0OWY4Z0MvV3RnVzQvTXhWZTBQUkowbHJj?=
 =?utf-8?B?RFFNdWtkNHRTY3ZBUUhjMzFNckJxMEdNOWRjclROUkZjdVpPQzcxMFlnOGtn?=
 =?utf-8?B?dlNDM2dwRndiWEdKamtDak9wc3ZhR1lObE5SVjg0YmwzYVdjVjQyMEROSElV?=
 =?utf-8?B?ek0vTGhMVXNOajRDOUd2d0lQcGhmRkNlcitzWDJSVUVFeldIL1BTZkFQelA4?=
 =?utf-8?B?a2luUlk0QWhHUm51d1ExYlJOV0RxL2g5Z0IyR1ZtQ3MyVE9hcDJHVW8yZjB0?=
 =?utf-8?B?UTV4azhNQ3lUcEtnVElYbTVmTXNSdG45UlV2Z0NLUTUweURJY1VRL0swTFVB?=
 =?utf-8?B?K25vR0RxcksxZTdIZlBMUlhmbC9KeDk3UXZ0U3NGWVcrMjBOTkZsdjJxRkNt?=
 =?utf-8?B?L2xnZXZ1bjJDQkhVdEpKWWwxTTFvSWlWSnpZTXhVajI4V044emorTU45Vm42?=
 =?utf-8?B?M2lUd1huN3JvZmlKNWRkcVZNS2xzRTBpdzQwZmIvMDFFcTZNdzEzTjFYZ2ww?=
 =?utf-8?B?MEhJM2ZQencva3NVUXk0cnFkWHhTQ0FmOHgvSklVSkRwaTNvZEFPN0pBSDRM?=
 =?utf-8?B?b0hFNzJPYnVPVC9CRlJjZUduVDdSNHNJZElUYkIxVG04dHFmQ3d5eExBTlBT?=
 =?utf-8?B?dVJuVlhmQkZlQ2IrUklrMW5sZlhJWXVETVpxSnpNQ1FaeC9JZU1mNnhoUnFu?=
 =?utf-8?B?S0UxUGpIZnZ3ZCtrY0s1MTZONnZUTkE1R0VsRTE4QzFoT2pSc2QzeWpndmd3?=
 =?utf-8?B?MmJ2UW5nVHdyamgvMHJpS3NOWk8wYjJ4Y2ZSUGFtWDZYY2FHZjQ0V3NXVG5O?=
 =?utf-8?B?NW81U0FRMXN4U2pzZkQyRDU5ZlFvR0Z1dnM1M0p3am1Tb1V4QmliZm01QWJQ?=
 =?utf-8?B?U2FXbngwN0ZpTkwwWVdpVUVWVzlBOERjRVpiVUZWKzN4RjF3amJEYXl2QXpQ?=
 =?utf-8?B?aWtuc0h0eUkrV3BhTFk2V0FYVXdlTDQvdXY3WjNjTDdjbFNDTTlkMFRZTVBr?=
 =?utf-8?B?SEN2aVVBR04xY0I5czFCYzBTcTVFUmtKWkk5dDVYQTRJVExjK1Npamo0Uzdt?=
 =?utf-8?B?QmxuUUFmU1J4TWxHV2dGRU1QSlFNRXVhL3pDK01sdUVVVDlxd29XT3dUY0Ra?=
 =?utf-8?B?SlFNcXViOGxaTG1XYzNaRXdrUFZVOFpiOVBtRlMvSEtOQjdGSHdBWlVHeUJj?=
 =?utf-8?B?V3h4dmQrS1Y5LzMrN1Rtd21QQy84OEdmeW9oNGZKS3B0ejE3Ri83MitYZGE5?=
 =?utf-8?B?dGZUeW9Ob3hYbUxnV25yZXNTZWl0NldNQi9lK0M5VzZtRkZRZkFMSllXQkdl?=
 =?utf-8?B?T2pUMEM0aC83aUhTVjd3NlQyWW9jSC9HUWxTTWd0Q2M3U2o4ZVFDaWlyVEdq?=
 =?utf-8?B?R3VXNC9xSWQzYWE1U3ZGU2dvTzlPUkZTNFBDSk0wbmJLT1RRcW5ZaytXK2xS?=
 =?utf-8?B?Ymc3ZnptcVdYdnoyeStCK1M5VkFxa2prdERsekEzUmwxR2ExRk5jZzVvZlEv?=
 =?utf-8?B?MlBXRHlSeEdhNUdtOVdGMWhaVFc0R3J5eWRESDh0UUE4ZkM3aEgxUS9oWFNO?=
 =?utf-8?B?cGxFakR0NmJkbVhvc0RmOFNqMkNBOGpZS0o2a2c0MUVDU0ZtLzd0ZjU5Zk9C?=
 =?utf-8?Q?/5Akk8I1FqLPq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGpYMHF2OWp5aFR5VHZrWGNIOUNiRDZwdWdsNnlkdmdVbFZrMzlSWE9WWWdp?=
 =?utf-8?B?UGkvZmp0c0p2eHhwUnREejg1RVRYL3ZtODFVQit2SlhPSEdaNlZ2dllUVWZF?=
 =?utf-8?B?ZitVZXhWMGYyQUh1VDZ0b09FYzdYc1JmVFlnNC9lN3U4L0NxWFl2NkdMcFBB?=
 =?utf-8?B?NGhBVHlQM2c0ZStzdkdSeWFBSVVnMEI2R2t3OW12R2tsVXFLTVJhRXUwM1pu?=
 =?utf-8?B?SG5nTmZxRzBDcTFzNHE0cERNWjgzWVdZRENuS1czVW50T2RaNVBuaDBkZW1q?=
 =?utf-8?B?L2ZqT2tjLzZtdzZCV25QSGlKaVZTbTIvVEFoYzZaOHlWQUpaS2VpNzF6WXFN?=
 =?utf-8?B?eDJPa0JjUG8yZ203SDRlTlEwTlRTZm0yTFF2QlJOcDRPS2tzVTNTT0ppLzNv?=
 =?utf-8?B?TVBXa3NkUDh0Uk1lM2x6c0NvVHZQU0FXVlNwVkxEUWhUYWlRZWMxbDhDNDhI?=
 =?utf-8?B?ZXZ6WlYvNEJQS0xZV01QeEorODdUQk1Ib2psNWRqZG05MXVleXBNQXcxZ0dX?=
 =?utf-8?B?ZGd1dERveDdORk41cG45VUI5MHhWajJTOHlGaml6QXE5V2pYNDExY0RXMFZP?=
 =?utf-8?B?TE1vOGhwbUFuc2hzakQ0N0ZZbnR4cXA1ZUJnQnB0U1l1a3AxZEZZNlR6YWdB?=
 =?utf-8?B?RWpsRTRsTEdQalFLa2kvbnN1Z1hMTVZXaHpnZnJkeGxQU2thVi9TUEMxLzBq?=
 =?utf-8?B?M2dQNkd6Z1pFUWVPWEZOVkFOM2JIRXJZMXpSdTFPck9uTXdtVVcvMDRLUDBP?=
 =?utf-8?B?VjhieDhVbkREVnJlbGUzc0ZtaGdWMkV6SWFsODkzdVFiQUIvQ2NuRFNLSm5Z?=
 =?utf-8?B?alhTczBTUU1haWgxeXUzc2tjYmhZOXpXc1EvelVjdWJ0ZEIxYzYrRm8yUUhW?=
 =?utf-8?B?VGhFMytqVjFWc3lqc1pabFZleFpOV04xQjZHRU9kY0ZWNUYydWw5aVd3VDVm?=
 =?utf-8?B?ZWllUGt6Vkh0Y3h0bUx1eC9VZXJuS0tleE8wSGxKVFRybWVMenNXRUt3cStQ?=
 =?utf-8?B?SDNkWWRpd1ZEWFNZUzlRU3dzcGxJTTJ3YjFlSEJSckxoK2s0RjQzYmZMQXZI?=
 =?utf-8?B?V2JQbjlOMjd1QUZUcU5tM0duT2pIS2ZoU215azAwN2xlSmI0RDBrZVZuY00y?=
 =?utf-8?B?aUl3VGNtbHN4eHViQlN0aUNPY3l0UFhETkRsZXc5RG1QT1VTWkMwOG9WdURH?=
 =?utf-8?B?ZWc4RSsxMmhoUEdzUytOcmZMRjRtVkZXOVRGZ1FHOWRvS3NydlpYMkFrYWlH?=
 =?utf-8?B?aEljemk4bDIzaU5vb3dzc1o3SlBtS041MVpubjNocXBWaERpb2NFNmpLYmx5?=
 =?utf-8?B?RGhURjlIUDBtVkJJR1dTMHRjb1dUNXA3T0VZakVGMnQ5bFBNL3JaNFN3N2tv?=
 =?utf-8?B?YXpBLzZPTkNWMHM1bXdKSVNveEJoaTlTR3V2bEtVcjNhU2c2TXlETC81UnpR?=
 =?utf-8?B?SG4ybG9UZEErQndWanBUVFIrTFR4OGx6ZUJYV3VJaDNEMFFKaXlrRkJhendi?=
 =?utf-8?B?SGxDWHN5NUwzRVVuWm9LZHNNNlN3QTR4NU1ubUlLYWgrZE1MZHZIdEJsT0xi?=
 =?utf-8?B?ZjJqZG5qK3B4bGp5M2tKWVRFRGZlNGhiem5ER1ZkdyszUm9UTTFDWlhuTUZ4?=
 =?utf-8?B?a0ZjWlV1V1p4L05pNjF6VDZUajRzZGk4eUFKNDBnUnRCcHBJUm9TRVBDazBu?=
 =?utf-8?B?dDlIWjh6b3czZzFhL2NydktUUDVqcndSVHo5b0JIanNPZjJrNm4yNVpEMnVC?=
 =?utf-8?B?ZHp5NURtMEJPMVlDSk1VNDFKbHpqNlZ4SE1sNGhYNDU1b3FobDRjVi9zd2Ur?=
 =?utf-8?B?aHNTSWEydDEwYjhPUXVQMFoxaXorSUIrOXQxUHR3dDdJMVFrcVpXMXJpUDJQ?=
 =?utf-8?B?VDdrcnExd3ZtZDlkT3RMVVVlMCtKMWphVWt2V3l4QXhVOHh1N1loZWVucXVE?=
 =?utf-8?B?NXE3cFFhYWhaMGlJZTVicFdxTHdYUDV0MUI4b1NyWnRXbGN6RGwzSXc4OGNz?=
 =?utf-8?B?NkkxZU5nS2dLSUhnYkRJT2JQVGthSVJWSUdsUXZKdk0xakt1UkJMWW56N2hC?=
 =?utf-8?B?Q3NQV1JETjJFdHZQWjRpMUhyVGlLSlJCYlp0Z0hNd0R5UndCVWNacWpGQnJW?=
 =?utf-8?Q?q7jkmQLXIMP7h/SLJgOk+m2/y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02d0374-9a28-4fae-8f81-08dd5039ce8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:32:16.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXCRxVdoH3+QC/qAOT5Qhihsb7qJdDfxL79K5CqkKCvbN+QgEkBqaoYw02O1LyjsRc99c8NZ8obd84xf/NOh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

Hi, Shuai,

On 2/14/25 21:44, Shuai Xue wrote:
> Memory allocated for wqs is not freed if an error occurs during
> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/init.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b946f78f85e1..b85736fd25bd 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   
>   	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>   	if (!idxd->wq_enable_map) {
> -		kfree(idxd->wqs);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err_bitmap;
>   	}
>   
>   	for (i = 0; i < idxd->max_wqs; i++) {
> @@ -191,6 +191,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> +			kfree(wq);
>   			goto err;
>   		}
>   
> @@ -204,6 +205,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>   		if (!wq->wqcfg) {
>   			put_device(conf_dev);
> +			kfree(wq);
>   			rc = -ENOMEM;
>   			goto err;
>   		}
> @@ -211,7 +213,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   		if (idxd->hw.wq_cap.op_config) {
>   			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>   			if (!wq->opcap_bmap) {
> +				kfree(wq->wqcfg);
>   				put_device(conf_dev);
> +				kfree(wq);
>   				rc = -ENOMEM;
>   				goto err;
>   			}
> @@ -225,11 +229,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   	return 0;
>   
>    err:
> -	while (--i >= 0) {
> +	while (i-- > 0) {

Why changed to "i-- > 0" here? Before coming to here, the mem areas 
allocated for wqs[i] are freed already and there is not need to free 
them again here, right? And if i>1, mem areas for wqs[0] won't be freed 
and will leak, right?

>   		wq = idxd->wqs[i];
> +		if (idxd->hw.wq_cap.op_config)
> +			bitmap_free(wq->opcap_bmap);
> +		kfree(wq->wqcfg);
>   		conf_dev = wq_confdev(wq);
>   		put_device(conf_dev);
> +		kfree(wq);
> +
>   	}
> +	bitmap_free(idxd->wq_enable_map);
> +
> +err_bitmap:
> +	kfree(idxd->wqs);
> +
>   	return rc;
>   }
>   

Thanks.


-Fenghua


