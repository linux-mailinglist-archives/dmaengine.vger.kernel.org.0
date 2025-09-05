Return-Path: <dmaengine+bounces-6422-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62456B46357
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 21:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6295E1903
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E5328488D;
	Fri,  5 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngMLgpfa"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC2280339;
	Fri,  5 Sep 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099694; cv=fail; b=Kjk3SewWhcys+JG5ImYMY7B6Eelj1SjBwwoGLszo0xHZeRzw0vF0nEHiT93XxTbIA8Vl7Xr8ZnxOqPOVAms3+7S3kODlFEQaD74B/RlontSqOzwbB4cwqddyZo9FtPzgGu+dgtu1ENiEIbvxzygBBQF7HUEox1XHNVJtqaWE2CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099694; c=relaxed/simple;
	bh=wnwQGaBKjYvNWKKpft8Z2oDVlr2OEea3Mil155C08GU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBTbnCidcUDC5KtDFfD/Of3bkoPM6p61EYF2zTvH5tA0xrzf46T3zyZryg71py2qXBaQhnL9tQBvvr3zA9KEyqV7wBgYFZE5Lh2uVze1R0dnNxsD3sslqKikjn6dsQlgepuQ0XPmXgXGwLenrHoNMm/pGFXpMa8t3NR5GauF1OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngMLgpfa; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ7A8gCyNYkwI1NeeZgGnJZRNPchcj+XhcKByeHNfFPAZGvFGAnrOHT8r51I18x/YyR5RHCdF44BP//3OA5AGQAQZbL6nXg73uY99xQ1YmiqEZKc8/ozhmMrh0ls9/cTQJ6qX/poYS7yqaur8VdH/FvdjhkmoCsk9qv873vIZEtq6+Xg1E2aeJBXnza6yUYu6hHdB9dGuVf5eLEoAV5QrlCyOiz5uHaEXh6vYZT+KutFAJK8l7l4u+zPaGTOf0QSIbeWYJcc7nwqBGhc5XbH5aN158wzXMvr3iGtuwYVvO+LKvJVSAZjV7L4fk5difl4C7CHM3O+ct8VtaTQbQVniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfSMmlzqzhHxbEUidyW1wmrttcc7alRYwFKMgE4lcnk=;
 b=KdHTM5E4mk7sYeskDIRdrP1mAgQO3dr2XCBmi9efRN3lA+80PLJz6bhov3YwGEsGyaOEgs+6ycxdIqzULlvwRYH4Il/yWUyRbefCAoFdS/Dse/i5TeHmqB4FCyzOjPLo+oJRnh4gvJ0E+rVGEZCcj1xAo5VQW/6jcZhoHercEtRw71BMv2qcwlqdhZgA6txIPds5HtZjKY/i0fa3YC7tdbKbaFMenurXU8QPNjMGqo+N0Jdv+Ucr7jVYptYoWp7mAvmsNCMUqb4UnAMof5xv0iDZfmI1ih9kSlK2Js98UE32xIVi4w/z4QLd6Q1AJNzDNmlg1CiGSiURZGvGnRU8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfSMmlzqzhHxbEUidyW1wmrttcc7alRYwFKMgE4lcnk=;
 b=ngMLgpfayK6Yea6jthjT9u3Kh8/NS7JKhxKRfjTyAQqJtTLe+kPxa1zKTGU8mOHL51QpHAiJjujlJ9AFHC/0aeUAPfqkoOtBg21M18Ncp4v/AMiXOp4JsYJr5A5v+f2EuE1koLm/Uh7OBHYkQfcxzTu7ls28sGeQ3nugpIFOJEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 19:14:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 19:14:49 +0000
Message-ID: <4720dc80-4c30-4f0c-bbac-4e94285dc23a@amd.com>
Date: Fri, 5 Sep 2025 14:14:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
To: nathan.lynch@amd.com, Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 64160302-6dfe-4170-7864-08ddecb07ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtVS0g1NnQwcHRiNWJzQUR4R0NlLzJHN2Znb0xyVTFFY1pnWXdOaGlzdlVo?=
 =?utf-8?B?b00yMDJGOWVQYmRiS0gxbUNPRE81dlhGRmxyU1oyeUNSY2NLb0V3ajRCU1NB?=
 =?utf-8?B?alFWTEh1c2RRellkU0x2RUljQ2tuSHVleWJ3QlphVjJjUy9INjRNbGtNa0NB?=
 =?utf-8?B?dytnVlVaMW1xK3dKV05KbXgzdFdWZERaemZXTGFld3B2MFJVcmxRT21pWVVu?=
 =?utf-8?B?ak9FSlRCZ2RvYThzMGVtZlF0SWMzT0p3VXFueHZEU0wrZlhzbFJsaHN2ZVRN?=
 =?utf-8?B?K0MvWEN6aFN1U2xtRFlJdjV6a0FORjk4Skhib3ZDUnpremIwOGdjS2pJT1NU?=
 =?utf-8?B?eEd1eHF5VTJ0b2VEL09HUXhwdk9qK04zZ1Z1N3N3TUJ0UFNxa2NRYkwrd0M5?=
 =?utf-8?B?OFVBcDBvcjJPR2JLT0JnUlBkVlhjYS9zOEdTbGNna0tLL0szVU9GdWlweHpm?=
 =?utf-8?B?ZTljTk80cms1YkZ1QXhORjFnQ2xqdldqZ29wbk5FTEErSW9HTHhEejBtQlZs?=
 =?utf-8?B?aTI5NFRDYjdjUlhFUG14UG4vUForUGdSTWsza1RWc2xsVWd3TDNSbTcyanNI?=
 =?utf-8?B?cW5LVDRMcjN5MURCbUdxRVNrYW9Ub1FNcFNGSUY1bjFleE5OSTJtK2I3ZW5t?=
 =?utf-8?B?VE1DR2JteVR3WlU3UktNTkFYaEhjK1lxM3FaUjdrU29QR0JYTmIxL2R6emln?=
 =?utf-8?B?cEFUaW80aE1HSUNNZk1TOXJaYVNXaFZMRmpPMGk3ZHM3MUtTOVJZQVQ5UjRH?=
 =?utf-8?B?ZlJGUCtUTEJheHFBb2xxUzRkSC9UWE5PcjJtRWxFUVlSKzRZMmM1SFVVbm9s?=
 =?utf-8?B?NER6Q0lwN0R1alJqMFEzQmhnSHdHWmdTVTI1YXovNGUzWWFkYVNMd2srMVM0?=
 =?utf-8?B?V1F2SU5CQjJValRtN0taU1Z5QVJKdUZvN1NxVE5mZnMrQ0tWSWlrU3IwaGVE?=
 =?utf-8?B?NmEyOUw1Z1FxajFwWk1KYnhUcGFXeFlQM0ZKMDdidVk1dXBRM2pqOFlHdVJP?=
 =?utf-8?B?bitFeDYyVWpsVFdsV3dLNDJaaWNGaG1vNE1TOW9HUElaTi9YcHZsZVpWVERt?=
 =?utf-8?B?aWJJeXlEWEFmSTRUU2Z3QVByTmw2b1BHMVNPZHBKQnhQTlhscUh2ME5IeWIv?=
 =?utf-8?B?R3c3U1NSdFhJYnYwcUVvS24xV3YxOW13TG4zRE1xM3R4SFNsTVpXcGttOFNN?=
 =?utf-8?B?dTB1K3FFSFpxRWtiOGlkNFZZaUswL0pLSDBDSXJaN3BVV2NPUzZSM2JoK1lv?=
 =?utf-8?B?dDBpVVptWlhvb0xZblZLcjNibzNxTXhNYVErQ0w0VjZKT1c2UkhMalRvNWpq?=
 =?utf-8?B?RXFKQUZjL1MzSU0raWh1M0pXOXpwU1VJN1FJS0hQZzNMNXRjWUNURVIzV2hF?=
 =?utf-8?B?K1psWHEvLyt1MEZOU1hDSzBqZEVxd2tYYXNxSmo2NlYxNUFDUlU3YllLRllL?=
 =?utf-8?B?UEF2MU5tMTdNS01wVk11U0FoRkxnNm5Gb1FjUi9hSUVKT3l0N1F2SURRT3R1?=
 =?utf-8?B?OVBSVi80T1M3RUlrVllSQkY3L2c0TFhkSDdzVVg3ZFNlZmlLVVptdEsrazBN?=
 =?utf-8?B?WXRqMEM5RVZRMUE4cG4yajB3WExFdkZnRElkZWFzMzBLTFhONGFMWGFKbmtK?=
 =?utf-8?B?UVNTelNoZjJORTNYWWl6SEdMZEEyaThkMEZ5MGV3ejBUc2c0Y0ZPZ0drK3Fu?=
 =?utf-8?B?Y3Q3OGgwZTBwQkxScDhjbFUwTWVaK212VGt2NEUzL1NkWHREOEV5ZEwzZmdk?=
 =?utf-8?B?QlhteVhBaEZtbjNudXMvYUJEdDQyNlRaOWd6b2xGaXBCWDNrOGpMcnJxT1Y0?=
 =?utf-8?B?c25TWGtVTmRCQ1plczlKWEIzZHg5SUwxYzhJWXhROHg0YU1JdmF6c2VmVXVE?=
 =?utf-8?B?MHY0cWh2U2VMd2NyU2xQLzY0azFoYnBTWVRPRXNnZDAzSlh2RUkrenZLQjBD?=
 =?utf-8?Q?C9BjXaqSs1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0svN2lkQThFSlNZdkNEanRmSE5TZnAzZDBoVU53VGtBUExaQWpDS3ZwU1E2?=
 =?utf-8?B?cFppT2twZWpHbTNGbzNFSnFwaG4wZkczd0hSczZ5d21nTzBpdVRXZU0xZXVQ?=
 =?utf-8?B?S2NoN1J4N3JhTlNNd3AxQ3J3dnkrZ1ZQRmJ3UEZPZXlHektwRnJ4OHBNejYv?=
 =?utf-8?B?ODZFSGNKV3dtcXVHN0tzN2o4TFRKSjFwd2hIbkpWK0xOR2xKTitJTkx1enI4?=
 =?utf-8?B?cGxDY3BmUmNMSlhjbkhETThyK2xiVXVxcmIwK3crU0ZHTkVhY2tyNWc0TjFk?=
 =?utf-8?B?b3RVL0JZUEtJemJHSkg5dDFuRXFzVklXTnF6OCsxYzZJZ3VMQk5iMXNuakNL?=
 =?utf-8?B?a3pkQTR4Ukl1MHRuMUtrZ1dIaERrUyt4SjZnOWVrL2YvcE9aZ2s5ZDhwZGMy?=
 =?utf-8?B?elNOUFBuWTNZZGZSMG1iZ01Fa2pIdS9Vb2E1Y2xpVE5aTk93VjlZWEorOTVu?=
 =?utf-8?B?Q29xR2dYdkRGVEZNRDl4MFZLaE04Nit4d1RWSWhtZVRaeU9WTmY3WkZaS0lu?=
 =?utf-8?B?RVRHKzF6UXJWRkFzREtWbUtQWDdHZTYzbFpaU3F3NXVVM3RaczEyQXdUUlVj?=
 =?utf-8?B?NkxXcDJHSnhrNHVyNE5QVW14VmVBNWg4N2hRMTVBTTFtN0JzWjV2dFNvUlNF?=
 =?utf-8?B?WUFjdCtVTDk5cUY2czg5cGxCMzlVNWVVWTlGazZ0MTFJa2xJUFVGd29vaWRw?=
 =?utf-8?B?Mk5aeDVKTElXZWIxZHdTVFJaNWRBd3l3bG5TS1RWS1ZzTkhxdDRqWnZFTTEr?=
 =?utf-8?B?NUhKZ3V3akZnS05vUWR5TytDeURHTUhOcTMyb2tWWDVaOU5peGsxbVV5RDhv?=
 =?utf-8?B?S3BUYUt4ODZsNkFtVC80MnJYNExiSWJPN1czdTlrWTJoSS9JclpwQ0VBLy9p?=
 =?utf-8?B?UlNRa1VVaW9zbUMxM1pzT3VRZzBwYXhHZm54NEdKRDg5R1Q3TWpnTDVsbVRt?=
 =?utf-8?B?SHRjTXZ0a1VyQ01ITm1mRlhvK2JIU0ExTjFaNlFFMVBTZkp5bVpUczEwakdN?=
 =?utf-8?B?WWplSFJXS1ZZa1BZZFZSQWdtQm9zVDN0Y3RXM3o0bkFQRjBZcVJnWWI4T3Nu?=
 =?utf-8?B?aFMwV21pSkVQazFWaFV5VHFsR0ZsTlUzeHlwRXpjdjFhRFBid0ZmV0c2dURs?=
 =?utf-8?B?M0xEUXhsNDFQRnB3enFkai9lYnVhL3R3Ui9hQlYvd1FZUnllSFAwQlBQdnBB?=
 =?utf-8?B?YmU4UFdKcE1CazVmdTkxSnVRdVNXdzM4NUR2eE40TURLbmNXNFRyMkJEZUVu?=
 =?utf-8?B?aFZGV3dUOGZlVHRRYmcwTkMwR3lsNjJ3S2FMUnAvU29oeGFHVzhCWk1TYlp6?=
 =?utf-8?B?SWh6TjJiTGQvQnIwaHFXdGIwLy9tR1F3YmRNSnpUMDUzWVEydTVPWnoyRDFS?=
 =?utf-8?B?NEMvdDNtbHlvQldLNkE3NGRZNE9TRGQrWk4zeGhURTlYaXlKTVVlc29ZdXBh?=
 =?utf-8?B?ZnhnMnJQcFBpR1AreFJUejlpazlFWFYwVyttaU5hejM4bHRpUXBnZG0zNmd1?=
 =?utf-8?B?SVZreS9BcmloZmJOL291QTVNWlhJUVp4aGI5ajdrVWNqRHNaMUhDWDY5QVV5?=
 =?utf-8?B?V2V4YmhjbUxxQTFHa2tYWmJJeGpNMG1aeURkWkZlT1dldks4b1EwZTFyaDY3?=
 =?utf-8?B?SjBvVmYvSUVoOStDYnZGSHJaTUp5dTU2WkVhdml3dHVQSUFZUy9UNEFhUDRU?=
 =?utf-8?B?eWQ5RmNtd1JiZk5xVGp4Sk9WbUx4b1RiSEVOTy9IYnpXWjRreVYxTDFBeTBF?=
 =?utf-8?B?VDhqQWJMRG5WSDg5QzlIa084RzhQaHBBa3Rld0VmVkQ5K2d0YWdWWVJEQjhw?=
 =?utf-8?B?OWQxQ0R0N2Y0MWRJaWk0RVdOWU9DYkU3WXdhTFNyK21oRkNOT2M4RHE1RW8x?=
 =?utf-8?B?OXNwczRJaXpjZVBIZHVaQjNJRWg5MVI5dndkeEV6aGhVSytWdEg2dVMySlJI?=
 =?utf-8?B?TTZmejRMQWE4TGFIRjVMb3FMa3BsT2o2TDNiT2tJeHhNeW80T1R3R3Z4MGhH?=
 =?utf-8?B?MklXZ1k2YXBOU3JuRDV0b1JSYW1VWGw2TWNscEJHYnI4dlFaYTBRcDRRZTZ6?=
 =?utf-8?B?NkRMYk1nTit3cUtkTkdHN0tqR2pvay9WZTAwbkl4Y3NSZXFUaEwydkhvazAr?=
 =?utf-8?Q?gzpTCBzk2QtPM7aRhIVFi2h64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64160302-6dfe-4170-7864-08ddecb07ba1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 19:14:49.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVU61gIdH28ZIQB+AWjcwJSNjybw8/d5Sqeh3gJxQjbv1K1PHib7S07ELm5UFkNrWtxGIZM5fQu8+4jpbYW73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

On 9/5/2025 1:48 PM, Nathan Lynch via B4 Relay wrote:
> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add support for binding to PCIe-hosted SDXI devices. SDXI requires
> MSI(-X) for PCI implementations, so this code will be gated by
> CONFIG_PCI_MSI in the Makefile.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>   drivers/dma/sdxi/pci.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 216 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b7f74555395c605c4affffb198ee359accac8521
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI PCI device code
> + *
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/iomap.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci-ats.h>
> +#include <linux/pci.h>
> +
> +#include "mmio.h"
> +#include "sdxi.h"
> +
> +/*
> + * SDXI devices signal message 0 on error conditions, see "Error
> + * Logging Control and Status Registers".
> + */
> +#define ERROR_IRQ_MSG 0
> +
> +/* MMIO BARs */
> +#define MMIO_CTL_REGS_BAR		0x0
> +#define MMIO_DOORBELL_BAR		0x2
> +
> +static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
> +{
> +	return to_pci_dev(sdxi_to_dev(sdxi));
> +}
> +
> +static int sdxi_pci_irq_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	int msi_count;
> +	int ret;
> +
> +	/* 1st irq for error + 1 for each context */
> +	msi_count = sdxi->max_cxts + 1;
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, msi_count,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		sdxi_err(sdxi, "alloc MSI/MSI-X vectors failed\n");
> +		return ret;
> +	}
> +
> +	sdxi->error_irq = pci_irq_vector(pdev, ERROR_IRQ_MSG);
> +
> +	sdxi_dbg(sdxi, "allocated %d irq vectors", ret);
> +
> +	return 0;
> +}
> +
> +static void sdxi_pci_irq_exit(struct sdxi_dev *sdxi)
> +{
> +	pci_free_irq_vectors(sdxi_to_pci_dev(sdxi));
> +}
> +
> +static int sdxi_pci_map(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	int bars, ret;
> +
> +	bars = 1 << MMIO_CTL_REGS_BAR | 1 << MMIO_DOORBELL_BAR;
> +	ret = pcim_iomap_regions(pdev, bars, SDXI_DRV_NAME);
> +	if (ret) {
> +		sdxi_err(sdxi, "pcim_iomap_regions failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	sdxi->dbs_bar = pci_resource_start(pdev, MMIO_DOORBELL_BAR);
> +
> +	/* FIXME: pcim_iomap_table may return NULL, and it's deprecated. */
> +	sdxi->ctrl_regs = pcim_iomap_table(pdev)[MMIO_CTL_REGS_BAR];
> +	sdxi->dbs = pcim_iomap_table(pdev)[MMIO_DOORBELL_BAR];
> +	if (!sdxi->ctrl_regs || !sdxi->dbs) {
> +		sdxi_err(sdxi, "pcim_iomap_table failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdxi_pci_unmap(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +
> +	pcim_iounmap(pdev, sdxi->ctrl_regs);
> +	pcim_iounmap(pdev, sdxi->dbs);
> +}
> +
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	int dma_bits = 64;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		sdxi_err(sdxi, "pcim_enbale_device failed\n");
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);

Does pci_set_master() need to come before dma_set_mask_and_coherent() 
and sdxi_pci_map()?

If so; there should be an error handling path that does pci_clear_master().

> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
> +	if (ret) {
> +		sdxi_err(sdxi, "failed to set DMA mask & coherent bits\n");
> +		return ret;
> +	}
> +
> +	ret = sdxi_pci_map(sdxi);
> +	if (ret) {
> +		sdxi_err(sdxi, "failed to map device IO resources\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdxi_pci_exit(struct sdxi_dev *sdxi)
> +{
> +	sdxi_pci_unmap(sdxi);

I think you need a pci_clear_master() here.

> +}
> +
> +static struct sdxi_dev *sdxi_device_alloc(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = kzalloc(sizeof(*sdxi), GFP_KERNEL);
> +	if (!sdxi)
> +		return NULL;
> +
> +	sdxi->dev = dev;
> +
> +	mutex_init(&sdxi->cxt_lock);
> +
> +	return sdxi;
> +}
> +
> +static void sdxi_device_free(struct sdxi_dev *sdxi)
> +{
> +	kfree(sdxi);
> +}
> +
> +static const struct sdxi_dev_ops sdxi_pci_dev_ops = {
> +	.irq_init = sdxi_pci_irq_init,
> +	.irq_exit = sdxi_pci_irq_exit,
> +};
> +
> +static int sdxi_pci_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdxi_dev *sdxi;
> +	int err;
> +
> +	sdxi = sdxi_device_alloc(dev);
> +	if (!sdxi)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, sdxi);
> +
> +	err = sdxi_pci_init(sdxi);
> +	if (err)
> +		goto free_sdxi;
> +
> +	err = sdxi_device_init(sdxi, &sdxi_pci_dev_ops);
> +	if (err)
> +		goto pci_exit;
> +
> +	return 0;
> +
> +pci_exit:
> +	sdxi_pci_exit(sdxi);
> +free_sdxi:
> +	sdxi_device_free(sdxi);
> +
> +	return err;
> +}
> +
> +static void sdxi_pci_remove(struct pci_dev *pdev)
> +{
> +	struct sdxi_dev *sdxi = pci_get_drvdata(pdev);
> +
> +	sdxi_device_exit(sdxi);
> +	sdxi_pci_exit(sdxi);
> +	sdxi_device_free(sdxi);
> +}
> +
> +static const struct pci_device_id sdxi_id_table[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> +	{0, }
> +};
> +MODULE_DEVICE_TABLE(pci, sdxi_id_table);
> +
> +static struct pci_driver sdxi_driver = {
> +	.name = "sdxi",
> +	.id_table = sdxi_id_table,
> +	.probe = sdxi_pci_probe,
> +	.remove = sdxi_pci_remove,
> +	.sriov_configure = pci_sriov_configure_simple,
> +};
> +
> +module_pci_driver(sdxi_driver);
> 


