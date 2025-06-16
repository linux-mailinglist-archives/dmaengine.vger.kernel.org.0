Return-Path: <dmaengine+bounces-5498-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF2ADB882
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 20:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248C03A3D0B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1006289349;
	Mon, 16 Jun 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kDp+mE6N"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966E289372;
	Mon, 16 Jun 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097290; cv=fail; b=F3C05Vk4HzpccCvzPQwxOuX67UGJM8mZPnaJoEesu8v+ZWNTSRZJ2ZAKkEo6qfvbEUgLJZ+S8LTbP4ovZKe5xQwkU2ZTT1rHDOzyB2xmLkHrXjSQKxhgWgXFTTgV704GadHac/4Tvvy3lZmhaYLnFcuxT7klNNhhTqwPjsS77yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097290; c=relaxed/simple;
	bh=d+Is0PW9xZofqITptt6mKCNjjUGdTOti8YVEPpdjZ6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=taVo9zj8m0qkDbAplF0G+6F9HWEYxkfCb+xoVrEUsNfVJ8DwOZdl84/A162ZpePon9c5H6wmati3enhaL36+nFQRiAbAZqRf5htO409dCr4+89jWBkkpPJcVRwyF/Cx+vAxcv7Lpd6RdSiRpQQgIL7wzojidlzGTqdWXdDbX7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kDp+mE6N; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntr6vMLTttu8t7fQ6lKFX78TAyJGbt9Gs6N2UB+TICp9jGM8eny42RWb6JeC4hdv8NkMpW5dvo+zNTOn+oRu6DYkbRF5rPi/FLOV7CEupsHZ8Q0pPZoSO3ttvNOcFa7ByLD3hMT0qr0lvqsphzrvSTLO85E+p+OX9ynHLXgs429IRALw3cW6gQG9sRVsjWD8QQmsyqsxXU/M2P/KIu3JtD4dF12VKwHIAWE17+1d2c92pQ9RraUN85dJEeR8c9Pc0m3eQ/Qc0mzgcNNfkwme4YODhCXb3GODvL8XDNLJgMA6mLK+v2f6DxIdhaJZv9q5EVQsf4bOZQMuAODj/xf8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUIqkubiZQrNHXuLBEwdbSZKbv4zZQecO35h4n1r3F4=;
 b=a+QA/TXoDYehyd6ua94w2eBQoF5UuWdFBTncf6oLagBGUgbeGFxzPj67qBxtrf5i55z/5gOBwT/USQw/FqyNHkGiypvHe3kmFgqlernDM5XNOBi4Pw4B4r02kon39r0f1peRC+mXLOe7VVhbSvYRhiA2ivp5UPG8HkRtFeNHJUVBJk0j/obHn6Lbz+jANotZxCnOHuC3gdiQT3XB7es5px8CNkNcs93oklsGwpYI6S6UmsClGoewhZVMJowo29urHzL7kUbc7cajE7R9BW/iqnQxjgq68LZcziiUstffRp5FsFJAEcSSSclFORiShj+wRFPQeMLAWfxomloXebXNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUIqkubiZQrNHXuLBEwdbSZKbv4zZQecO35h4n1r3F4=;
 b=kDp+mE6No7YBWTpn9saSnSMb2dm9XggbG0Y3zNe3vFbhjGbcWgLecxQXyUXXiqDuo3r99NT2tKoXQNUjwb+76KHu6MHRrU7GLGBipnoxOru4hb2SwgNp3UouWbr4isiS2VrGBSB+zVW2LRahj/rZ2SOjWwTh3Y1kbFhUB/P69tJXKBXpnS0ecuXAhaNN7VbZunp4+XozqeBXXaNV59GZ/4xRJTaIJlcqEF1ELQj063bDMRuVB+qCuRE1/oNFtjw9QvuY+Z/GJGcnya3ySpNOYlO0mynj0SsE5zt7kP0Kq6agI/wvmbUDSZK4+vlKGHCxlmj/Lz3zaQoQIFLRS9RKxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 16 Jun
 2025 18:08:04 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 18:08:04 +0000
Message-ID: <bba06b90-5673-42ea-aa97-6c55256af6b2@nvidia.com>
Date: Mon, 16 Jun 2025 11:08:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
To: "Lantz, Philip" <philip.lantz@intel.com>, "Sun, Yi" <yi.sun@intel.com>
Cc: "Jin, Gordon" <gordon.jin@intel.com>,
 "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
 <c9dae480-b5bf-4028-a398-bafb9d206f50@nvidia.com>
 <BL1SPRMB00111E4D037AA0922A61CA0C8877A@BL1SPRMB0011.namprd11.prod.outlook.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <BL1SPRMB00111E4D037AA0922A61CA0C8877A@BL1SPRMB0011.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb3acab-0621-44b8-a105-08ddad00bcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWh3WlN5aHRqaE04ajV0VUlHblNNWUFEQjlSTGhWRVdmZDkya202UHNPZVlx?=
 =?utf-8?B?YURhSnUrcUlFZE1RSjJnRDMzTVVDd2g2cVVjcjB5WW5zNWtqSVZPV2J2d1c0?=
 =?utf-8?B?TU5aejhBMEI2aWpSbVh0ZzY5eXBXUy82akYyL2Fwa2VUUHl6ODdoeXFTV1li?=
 =?utf-8?B?amdobGI0clRUMEtHWFFCQmlIa1ExRTYwNmNqMUc5YVhBNk1wYmF2R0lwRWl3?=
 =?utf-8?B?ZndibG9FT3lPVk4xOTJsVUpFSVZtUXpBU2ZzK3NkZnVuQ3M0dWRkb1dQVURP?=
 =?utf-8?B?SERVNTd5T2tjbWFNaVczTjBkKzZxL1ZGK1ZubGVhZlFJN3UydEF1cUZkZjc3?=
 =?utf-8?B?OG5TbTMrdk1xVm1EUHdiQ2VMemtWRDk1U2o0Vi9xZU12VEIwbTFIMzkzL25n?=
 =?utf-8?B?QUJ2OTd2NUphM3d5V1kxd0UxV0ppaVkvc29uRm9CL3BBbWtDZ2h5M3F5aUZT?=
 =?utf-8?B?d1JvaWUzdngySU8xNk1mNHJVK2xOMEdHeGpjSXZ4SVkwWEdOdHpQMnNlYzZu?=
 =?utf-8?B?MFV4MW9kcUlTNEZrQmZ2QU9iTzdpa29SNUZjV3RjazJPdEFUMWJqS1BOOTlN?=
 =?utf-8?B?dklYTXV5ajhTRlAxcGtKdkVEWkUxRnNJR3JZQTV4U3BEeU1CZExRc1pTME5q?=
 =?utf-8?B?T2VJSmxZaUV4M0xWOGRqWmlhRUFvR2JJU0hVUTFTU0xlNUpMWFBzNjdBeTRa?=
 =?utf-8?B?TXJEWkhhVWJ1RjNsZkpUR1hBcjRlSnNQYVpjVFlBemtTRzBWTEdqMFhlTmJ1?=
 =?utf-8?B?dzZXQ29TT05LdXVIRmZzSTJGbDVCUDk3dnBrbG5BUVJsTlFSRXN1N0dEV2NJ?=
 =?utf-8?B?UHBTVGwyU00zQUZsUFFOOVVDdWZCdmNYd25yc0U3ZzhaRVRKamx6NmZJVTE4?=
 =?utf-8?B?SmxyYVd2YlY2K0pwMWZ6OFI1WHo4UXRGa21vUGE0MTF4MFdpR0oybnpCd2V0?=
 =?utf-8?B?ZlNNWU4vazlaYWVOVU51RFY0djd3SWlPdWUyYkdjalhNQU11bDd2MUNJbjZW?=
 =?utf-8?B?a1FrTGozSTA1UXh6YzlibzFGZC81WnpYWjJydU5kTzMrTDJkVDZtY3E2TlVI?=
 =?utf-8?B?V0ZySkViMEl6cGJLejd0R3BQSTBSREtqZktMWGNvanN6blpva2d2Z25nMHYz?=
 =?utf-8?B?VXdmL1VsZGgrak82ZUlQci9MbHJlWm0vV3ViOGhmNDRWdVNxcDlYUHFZaU90?=
 =?utf-8?B?d2FuM0cvN3VXVjdCVittWUFBZDdWQ2FiMWgxUjQyYm1YTW1PeGwrNHJKZmRm?=
 =?utf-8?B?Z0FwSDNWOEQzbnFmM29UaFNSWlMrZU9uOHA0ZC9OZlJRSWZiNmZHOXhiaXBm?=
 =?utf-8?B?TVI1YVNXc3Nrc0FzUHgrbTdKcysrbEs1b1hkQi9KYnFvMzZmVmd3SEMrZndy?=
 =?utf-8?B?eEh6alJTOEFLNGwwdE5tby9UNDNZbVVRbGlUVWdIWkhBRWdEZ3l0cEd6b2Q0?=
 =?utf-8?B?WjhIbllkUGZSaUtodUlnYXBEZWxvWnhoYWdPODlabVBxMXFVYzJVd3VqMXdR?=
 =?utf-8?B?VXdqWUk2Sm5QZ2dEbUxVa213Z0xQb1hWQ0RMVVdNWDNGNnpZSWs4eEpoOXZG?=
 =?utf-8?B?bEhsYjFoMnA4a3BHcU1MUzdTZzExV1FjREF2bllCaEJ0ckpRRms1Zll4YSti?=
 =?utf-8?B?SlFidm9TV0t3UzhNSndXdDd5ZnpuWmtka3ZTb3dEMWYrNmJzU094dzNaU1NY?=
 =?utf-8?B?djUvOFhNajJKMnc5dmc4bzBSWVl5a280VFZ3WDg4QXcvczhFWDJwTmhJMncr?=
 =?utf-8?B?VjN2eXBNTEo5aUVSQTJPMjc3MFBnWUhYUVJzWVd5Y2NWRGQ5cWtpTUt1aU5T?=
 =?utf-8?B?K3huQ1pwcC9tTXA5c3Y1WEQvL091Z2dkaWR6QkgxTzhhcFNxSmVDUnhycCtO?=
 =?utf-8?B?NU9qalB2alJnOVB5ZUZibFBjUHJMS2RNVmJVRUhxQUZ6WllvbnhTRVVTVTVN?=
 =?utf-8?Q?Sb9GZSGOMAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGw2ZnhDYS8xNy82V3pHK29wT3dCRThTTTd4aDRuY1hla0tUVmNZSmhFOHFV?=
 =?utf-8?B?MXlUVEl4bXdWMWdVME44WTZaYnVsWHJqMko3SUNqNzFnazViZUhNWUllT28v?=
 =?utf-8?B?YnpOVGZ5ZXVXTzFsLzIrMDZVQjBnV0JhT2ZIc2kxVExMdTRYSGlqeEpnaUFJ?=
 =?utf-8?B?SlRFdU53QXNWWjFXejhJUVRRaS9CM2N4NDZiYUxSeXNzMjdEam5uM0YxN0lG?=
 =?utf-8?B?cDNJczV0Q0VSaWhwc0RjM21ZbzJOVWZwcFJlTXlqeklBOGZSZ3BFU290eFgv?=
 =?utf-8?B?Rnp0Mm1ZcTk4MEQ0b1pWUUc3enZibXpRN3FSSEtuY3VNRU5ETE9UaWtYVXZL?=
 =?utf-8?B?SVBkSmNMYjhKN2NKdnM0ckExQVJydEVKcTd1SHB2UzBSR2E3VURGTjFVTWxX?=
 =?utf-8?B?MjlXMjhtcGlHbUxrTktSMGJoVFBjci9VWlNMTkhJWTZoUUs4SmRIRFZQZlJk?=
 =?utf-8?B?VGVkQUovU1RYeWdJMVM4MU82VXBQUnY0Q055VEkvNUFKdVBGWEp5cjVielJH?=
 =?utf-8?B?N0NmN08xK1VoSFI5YWlobFpxUDJNMW1ZWGxiK2FOWHpWMjdHU1k2ZDZ6dVgv?=
 =?utf-8?B?bDVraXR6WEdYdDQvUWZUSzA1cFR2ZmttQXY1OGJ5L2NySjVsM0hhdEFHVkxD?=
 =?utf-8?B?NGIzUSs2UEViU1R2Uml3REJoeXdmNitvSWZubWRCcU5pdUtBYzY5eTZkSk9C?=
 =?utf-8?B?azVJNlVncjdFcnFIU0RmdXlxZ0FSbk95TjZSVGI2c0xXNnowOVEzb2xabVo0?=
 =?utf-8?B?cmtFMW9DZ1U1emVBT0dWY0ZSSTY5b25VeXZPeFVIdVZPUWpxU1dRTDM4QjFS?=
 =?utf-8?B?T2VnRlVPL1FidlBWNXROUWFPTzFESWhSN2ZXRmpMMzI2aEVISGV3SElWa3Rv?=
 =?utf-8?B?THJwRlNsem9MeUpUR1NzMjFCUjhzWngwclJPTFgwaDY0WW03OFFOWDZBM1N1?=
 =?utf-8?B?dG1MK0ROSFBUTjFEeXJpZ1pwMEgvM2F2TThCWU94SkVjeGJBVE9MdnIycWhh?=
 =?utf-8?B?c01yZTZNUFhKS1J6cVdSRlNZSXFUK2U0RUJQWGkraHpOMUE3RFp1elJlREFF?=
 =?utf-8?B?RHB3dmdDVnB1ajFKUk5zbmsyeVFOQ2o4MkJXQW5xbWV6T1ZKL3ZGQ3BlajFE?=
 =?utf-8?B?N0p2K2lHMTFPS3hBaXY0bjFOdW96OU5BMDl1cGhBSS9ZY2FZTENIQmV5UTVK?=
 =?utf-8?B?VWpRZG55TVVJVGpFWUp6NkZBMWdkcEYveVhqMjNXS1JaeHZOSzd4Q2xWTHFH?=
 =?utf-8?B?MDJXbUUzNkNRSWNqL1B1WVF0WGdQaXcxZEF0eFRxM2VSYSsxUkV5S1BEK2lr?=
 =?utf-8?B?ME9NS2RFb3FwcFRsRlhrc1dGdDhvbXNLaDhpS0w2YjNnZ0RUN1dxYzIzbWxV?=
 =?utf-8?B?aDlrd1NoTUJ2RlAvUGFndmJEajFJd3hsWEZ0WkdqSnp0MmJqdEFuSHhUa2lY?=
 =?utf-8?B?UVd2cmM3V3N0cTBWdVdrUHpldkNjbExPN2Mzam55TFNXc0M1QTdoNmFDMXJz?=
 =?utf-8?B?VEx1MFNGWDBjSnhHczlES0ZRR3ZyRnBxMlg0RCtxNklvbExoZFJZdkdTZmhr?=
 =?utf-8?B?cjE5a3k3TFl4Z1V2UUJacmI5SHdTaXlKMFNBTmZMR2NpdDlnUE1XdFg3Rzh0?=
 =?utf-8?B?ekg4M3MxeDg5TXpUQ3lVZWl1WFZmTmcrK3d6QUpkOWpDV0d3ZUxzTldrZlFR?=
 =?utf-8?B?TDdrVllxTjNpRG5hclV5RVRPd1YyUFRsTVA1U3Nza3VvK2FVTEVFQU5GbGxK?=
 =?utf-8?B?cGNDS1FweC9YYjdud3VxMXRHTzFvMnN3ODZiTmFOWVBMU1loWXFHNzM0Y3E1?=
 =?utf-8?B?UDcwZmp5aUpQQmVxSVRMNTVTbmFpSXRLU1dTMkxoL0crYjdvNEMyb21OVlNV?=
 =?utf-8?B?a1F4bVNZMHRNdDlvVUxydnBSWU0vVXJxNmRaQk9PdTBSTkc5VFZjcGFhUHhX?=
 =?utf-8?B?WkJiUGNOdldGUE11bGhIclBjdGo0bjVsNUVEVjJDT3JrT1p6a2hsbWdKMzZ4?=
 =?utf-8?B?bnMrQ3YyNlZPMzFGcWJQT0hSNkRqTEdGbEw0ZCtWUFZIdS9wMVVkM29kQm1O?=
 =?utf-8?B?TTBBUm5Ub0pMSFhBT3FnSlZQam53SVlMUWZCVG9XZzA3T2xzOHkzZG9JV2lo?=
 =?utf-8?Q?XWe5CZNExJzRidV3vsYr8+nHH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb3acab-0621-44b8-a105-08ddad00bcf9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:08:04.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZseYj7hlkhaPl2aNEyMWbF+dMgF00XsRlSlhfGg77quoKwUHB5mI9g0SP7KcQVKzkgDkReutaStVEDNZos3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

Hi, Philip,

On 6/13/25 15:26, Lantz, Philip wrote:
>
> Fenghua wrote:
>
>> Hi, Yi,
>>
>> On 6/13/25 09:18, Yi Sun wrote:
>>> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
>>> capability registers (dsacap0-2) to enable userspace awareness of hardware
>>> features in DSA version 3 and later devices.
>>>
>>> Userspace components (e.g. configure libraries, workload Apps) require this
>>> information to:
>>> 1. Select optimal data transfer strategies based on SGL capabilities
>>> 2. Enable hardware-specific optimizations for floating-point operations
>>> 3. Configure memory operations with proper numerical handling
>>> 4. Verify compute operation compatibility before submitting jobs
>>>
>>> The output consists of values from the three dsacap registers, concatenated
>>> in order and separated by commas.
>>>
>>> Example:
>>> cat /sys/bus/dsa/devices/dsa0/dsacap
>>>    0014000e000007aa,00fa01ff01ff03ff,000000000000f18d
>>>
>>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>>> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>>>
>>> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd
>> b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>> index 4a355e6747ae..f9568ea52b2f 100644
>>> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>>> @@ -136,6 +136,21 @@ Description:	The last executed device administrative
>> command's status/error.
>>>    		Also last configuration error overloaded.
>>>    		Writing to it will clear the status.
>>>
>>> +What:		/sys/bus/dsa/devices/dsa<m>/dsacap
>>> +Date:		June 1, 2025
>>> +KernelVersion:	6.17.0
>>> +Contact:	dmaengine@vger.kernel.org
>>> +Description:	The DSA3 specification introduces three new capability
>>> +		registers: dsacap[0-2]. User components (e.g., configuration
>>> +		libraries and workload applications) require this information
>>> +		to properly utilize the DSA3 features.
>>> +		This includes SGL capability support, Enabling hardware-specific
>>> +		optimizations, Configuring memory, etc.
>>> +		The output consists of values from the three dsacap registers,
>>> +		concatenated in order and separated by commas.
>>> +		This attribute should only be visible on DSA devices of version
>>> +		3 or later.
>>> +
>>>    What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
>>>    Date:		Sept 14, 2022
>>>    KernelVersion: 6.0.0
>>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>>> index 74e6695881e6..cc0a3fe1c957 100644
>>> --- a/drivers/dma/idxd/idxd.h
>>> +++ b/drivers/dma/idxd/idxd.h
>>> @@ -252,6 +252,9 @@ struct idxd_hw {
>>>    	struct opcap opcap;
>>>    	u32 cmd_cap;
>>>    	union iaa_cap_reg iaa_cap;
>>> +	union dsacap0_reg dsacap0;
>>> +	union dsacap1_reg dsacap1;
>>> +	union dsacap2_reg dsacap2;
>>>    };
>>>
>>>    enum idxd_device_state {
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index 80355d03004d..cc8203320d40 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -582,6 +582,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
>>>    	}
>>>    	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
>>>
>>> +	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base +
>> IDXD_DSACAP0_OFFSET);
>>> +	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base +
>> IDXD_DSACAP1_OFFSET);
>>> +	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base +
>> IDXD_DSACAP2_OFFSET);
>>> +
>> The dsacaps are invalid for DSA 1 and 2. Not safe to read and assign the
>> bits on DSA 1 and 2.
>>
>> Better to assign the dsacap bits only when idxd.hw.version >= DSA_VERSION_3.
> The registers are architecturally guaranteed to return 0 on prior versions, so it is
> safe to read them on DSA 1 and 2 and there is no need for an additional check.

Although it's safe to read them here on DSA 1 and 2, reading a reserved 
value generally is not a good code practice in the kernel. I would still 
suggest to avoid to read the reserved values on DSA 1 and 2.

Thanks.

-Fenghua


