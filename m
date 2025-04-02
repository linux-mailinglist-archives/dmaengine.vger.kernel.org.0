Return-Path: <dmaengine+bounces-4802-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45BA798C4
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 01:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C3A167070
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA21F4C8F;
	Wed,  2 Apr 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lK+/kGv/"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E71EF0A3;
	Wed,  2 Apr 2025 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636295; cv=fail; b=pxkpc+zQ2b0M+rExiHXfR0jiPWbfVrQ6KalAYEVW4DN7OclKoro3VhaXEKPphPDW4EkexW5L9xoY9+zH/A52ffXSw203iQ2ELUbVoELBVR6Dk1ZThzZXGF/K68+SPXbsj1eNeDnMcG9zZAoFtsFg0yKgijpYbI92KyzJXUXtoh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636295; c=relaxed/simple;
	bh=pvB6txvCrib9OPSTESsAm61SI0JsFPl252O7/auqmoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvvRT3lZ5UNXbrE9UOcTeOue+LvYLXsQ0j2q8qc18YcEfvVgtTiJ2pGmZ4ue/IBcb5gxZqJF+4YlllkBDqY2s0iD6CxJjHJIPgr65y/KtgF2typ+NfcXl5hnYTMT4CVkeIG1ZF1F9Xem0z6EkRs4Y/puemUHfydMvC6gZ/fnIQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lK+/kGv/; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8ynRwhMGy9xshx8l1OTcJHNaiMyijOw8ugXOkqfKCyGwadROJ2ZnFOztHzE2xUHfvrsEFs7untn87IxxjTUZdbUWS7oeS1ULNCkJwrhfdaUmDvtfrrfls9rf82QRNZK+nEaX2u/hRBDTk2CbMsZNslR3slKReDzNuwBhZFx+kMMTkT2BAdNbK2vwlKf+4hBHZLPlpSuZ4P8UFqu2e3XI2Oo+Us5SJYe8IsKAJCHzEkvgO+hasHPmY6doMZd1e7jUc8OMnOuapYCE15SP4o1YSi5tJE6/u+n5eRHF3TmKTp9kvKQ7zGlHzKsLHIuKqtCC0gr1/0CBlQJJWnkWzjLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8//cNkNZBsebVyejTKRStE6RbDAWgPOXWA+HcDp2kWI=;
 b=GL9A75TgpSGbVMYe1har4vZPLfESAv/2aVsFHPvcGxWmRgu7VII/SM7IoS6y0ZjDlMnMW3oWjrvLPdsu8cj+ReyEIkZTTJClvdr+TYQTpJsrTEx6RxnWYs0BXLooeNvNMinqFumsBd8xk3rJJ9e/nw+G5PTv/9jT+sv4pFVNASCmTPwRI4F7keWH4cD8XRFilXgypjaOedjQ30KQr/W/KBC+L1r6/ok/2KGcWgVryi7E8aTSV9K8plrV0guYKJqU7SURAy1rUNdiyaUAGYVd/Oivy6IQ2M1N/xfoS8G2L9H/w4NHNVH9welQfa5WHIhw1P4RI48L4vrOR2eJL4XgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8//cNkNZBsebVyejTKRStE6RbDAWgPOXWA+HcDp2kWI=;
 b=lK+/kGv/I9XtIJgEDwzchazX7xX53F4juUw95ocbos83tnkSeXpmPPmIyQ4iIk42pESlpSxDdjFN7C2bUjgMMpoS9uMilmN3qV4lCo/ceg1zzx2kf6mL3yI6Vw11uz7KhyQqI8EDLK5c62terVAp0oTh60chUBbWXL/V7dY8p8qbYHNF/L5vGfCkWeZg6vSCTEuM6XoJKqaa9jf64rc3DBfvGGm2jDoEALVcu26kIcdwcaceqv8HLytkBgkSxlqvM7YF8RI8ZLECIHjgFuJx95lecP6OdjuVggwi+As6wB85jRgeLev/bOOobELZKA2nrn//S0puNbd+fCNUoTULiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 23:24:50 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 23:24:50 +0000
Message-ID: <0a6e68e3-0ff3-4826-ae81-a16c4502a0d5@nvidia.com>
Date: Wed, 2 Apr 2025 16:24:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_groups
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250309062058.58910-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: a74e67d4-095d-4553-04b6-08dd723d90db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlBiQjhFNjZ4eTB4R1RKbnlDYkI2dXZHandncEw1VUNBNHhuRmtRUGlpbTZL?=
 =?utf-8?B?MjR1K2FOUzBMdjVwVkJJRkw4VFVIYXNvZCttb2Z1bnMvbkZVWnRUK1ZGWllx?=
 =?utf-8?B?MWhlVTBjMHZlYjY2MXphQkVMVUs2SjkwTDdTZFg5RERGRmhROVVHVlkvUCtw?=
 =?utf-8?B?K2UycWFESFFFWXlCTkNMdFhQczZhbFhBM0FSSEZoUDhPa2hnQWxZQThacmxE?=
 =?utf-8?B?Y2czdTZjZUV1UVUxclJVakdVYnc1c1RsTS8xZkNlcjRuUGg3eXd6Qy8xSlBk?=
 =?utf-8?B?WjJxb3czT1VoVVpIYitNc2ZVZk9aazYwUjljYXpzMWpPU2c1aUJPMitSeENj?=
 =?utf-8?B?R2gvZmt5RGRBOXVNeThrQmlBY2dBQzBCR1JTMzJSSWR1dUplS0VQTTNPRlhr?=
 =?utf-8?B?aEM3bDZYRVFzYkJWTzVqQitHSjF0UkpRa0Y3TzRycDRPVGJtZSt3MEJGZ0ZI?=
 =?utf-8?B?aG9rREl2OXNEWFF6a3d1ZGMveEprbEhVWVphTUJFNTd3UDZiaU1mWXlvSEM1?=
 =?utf-8?B?RURmbW4wT1NWMStNSVFYZmNYT3h6UHhaMnh5Rlp6WlJnbExTWjVtZzMybXdQ?=
 =?utf-8?B?NHVkbUR2VU92ek50WkY4UDdJcDIvQlI3MW5Ja1R4VzBqMlE2ZFNEOTFpd2Yv?=
 =?utf-8?B?SFgyNXdRRkZLQXBsS2pOcHBlV2JDemFES0xqMW8yZTJLZUQ2UnFEa0J1QzRn?=
 =?utf-8?B?NGtzeXhLSTVmdmdKR21pZjhDQ3Eydmc1aEIxdnpZMkNLR3VvZjFDQVkyUlR3?=
 =?utf-8?B?TTF6cVgwajViQUthWlkrYWxKK1dwRkFVdFhBVHIvV2pPaXVFSGw1Y24yZ25w?=
 =?utf-8?B?by85UmQxcXRzRE5MVEg3VFFsdm00YVBzb0NRZGwvbDRsdC9pVTc5aDBXTXcy?=
 =?utf-8?B?RllHbVNhWFNLWWFzYVY2QUpCUWhlbjg0S1dkL0hJeTN1YXFxUnhQVWFqejJ6?=
 =?utf-8?B?T3ZXTlVVTXRTT2VJSU9vVlh0bnZjRmI0UExVWnJRQTRxNjkra1laK2wxREVR?=
 =?utf-8?B?bWdXbnIvbTF4VllHZ3RqNkkzUkFxL29CZ3k4RE1zRXh1eGdDZ3UwVGJQeHRv?=
 =?utf-8?B?dFlxWFVZbVZ3OFdmNzR3T3d4dWtpVjlreVlXZW5Gek5YTnArSTFHUW5sai9k?=
 =?utf-8?B?cGkweDZUOFpsdHN1MExGYTl4NUxKVVoySjRLeEhqcUJtOGRuOXBRaW91bHJw?=
 =?utf-8?B?eEtYeERQa2FNcGhrRDJtZ3ZWZW52Z2pkZHhYOVJOemxBYWJQLzBkaG9ad2Ir?=
 =?utf-8?B?VWp4VEJGVWhENU9GRENIemF1NFlZazIwVjdzL2tla1cxUy9CN2dSTngrcjhp?=
 =?utf-8?B?UUlZN1JXNFpmRTR1ZGpNNHBSWXhTc2sxZXFSblNack5GSDZXbDRNUnZPVmZn?=
 =?utf-8?B?dm5PQndQY2orcG9zdHk4YWxiN3k0UE9mZy9WVnQ1N2lRSTlqT3VkalNDeCth?=
 =?utf-8?B?WDYwZGY0MFdhSlRUNEcwbSt2N3ByUVZCTmVPY1ZNVkwrK0JRdTUrNHVGVncr?=
 =?utf-8?B?aFAwUGhsZkVaSC9pTWtYRnpjTDJyUWFkSVJmbnQxdWV4Ymh3eEkyRmttZnhY?=
 =?utf-8?B?ZUNCaUhoME13dzhqTjRMeXJ0OU51bVJKZklVTHl5K3Baa0hiUnRuMFJlekVp?=
 =?utf-8?B?N01Lbk8zbC9qZXVBSXE1Ukpld0QyUllXMU1icVFETisxTkx1WEJZbndkR0o1?=
 =?utf-8?B?RUgza1VSUGkvRDNVVHRFUUlyWjhEcm1XanBIM01RTTlVRDRxc0g1ZWJibVB4?=
 =?utf-8?B?c2FxNHY0N2Iva1dackpISlgvT2lCdWlVRWxTUURKRGJvUVc2a3NaQWdLSmlG?=
 =?utf-8?B?VXNzdzg2UGMzbks0UzB6KzZKUlIwVWt3NGlaNkROVlo1bE1EZktkOGMzWVhl?=
 =?utf-8?Q?AxQK1h8/SCfCK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3IrRHlnQWxXQ0ZoNXdzNE1SUDM1dFhld1ZlcE1pU240b0FlemxzVko0bjRu?=
 =?utf-8?B?dUZXNXhyRU5Mb3FaYWZzcU5RMXZqZjNraWIxZ2d5ODJIMUkwWFplY2Y1UFd0?=
 =?utf-8?B?NVlIZCtCMkhFdTd5dDBpUy8vdUJDLzlFb3c0cWZyWi9kQVB0UFJsdDBNM1o3?=
 =?utf-8?B?bkVHSHBYMnc3VmtzQWtISHdYUTRvWWNoZlpOd3Zuait1dnRXMGZRNmRTNmtz?=
 =?utf-8?B?S3JrdWdadWNTOFIzWFRNYkl5bEpKSmNOd3MrOVphZDRiblZGaFFoS3ZNK29F?=
 =?utf-8?B?RmUxempzc1grWFp2dXlHVi84NjlFanVUSTlIUE1xWkZWcmNFNVVCZXdxZUM3?=
 =?utf-8?B?OVRsYTNjTUQrUURLQUN0SVdiTyt5bGlMbnBPR0lHditVU05lUjhUajJqbmVK?=
 =?utf-8?B?TW5mVi9rbW1mcytYRzUzbmhNREhDMUJxbmFOUVlKZ1lxL1pmWlFUdjBUTDV1?=
 =?utf-8?B?TCtyTC9FTFN6WXluVkt5RkFLTnhkYUs0cXI5NFFNMW4rZkRFc3gxTDBPZ05P?=
 =?utf-8?B?RmsrUTRIbnRIeGt4N25ITnVrcThmVzdYK0d5MEdwNnZwNy9XOUFuYkxaTkNj?=
 =?utf-8?B?WFlueUttWC9GVitabms5SnNldGJGNk5ZTmt6eGFGWU9LSC9DVXFaRDhVVktU?=
 =?utf-8?B?Z0g0T3Z0NGRmVHJDWGVzU0s5TkJoa2JJOGV6YWI4RDh0N2ZVVE80ZTZDa3ll?=
 =?utf-8?B?K21hZ0V2MWhCa0I3aHllM0pNSHZWK2swV1JacllBOFNXVVV2WThJVlpaSzY5?=
 =?utf-8?B?RURlVkRGUC9uZFFaMzlBU1VEN0RrQTlOS2ZHRk9haWZqVFZjRXRnUVZEa1Bu?=
 =?utf-8?B?ZS9pdWtuMmxyUzkza2FocFZoR1U3L1hGMExCV1dsS0VxQm5QdUYwdkNJTXo3?=
 =?utf-8?B?UTBIUW1lbG5BenRtTndUNFRIZFo5UlNydkZLZ21XUFZRU1B0WExLaU03dlJZ?=
 =?utf-8?B?eTFTQW10MEM2MVNSTE5aeThNbjAxK1NkeWJYWkNNTGxqWDcrcEs3Y09oY29W?=
 =?utf-8?B?Y0x4bGN1R2FLT1cwdnFSWFJHVWNMUE40bEhsSzZlSFVRSW5IQVVRb0taZmEy?=
 =?utf-8?B?N2hzU05LTXhTVDg4bHlFdzNBcGNqbjM4R0pLdnpJd1dSMVZQNGN3VnY2VzlK?=
 =?utf-8?B?ckZHVmxYelRYMjB1b01rT3Z5dFB6OTY4Sm1makxVTldod2toLzFUWUdkaVNv?=
 =?utf-8?B?bExuQ1NFMzRmS2padjkwNFJxeHpNQ3hLYjN5WndTeDdRdDdjaDdZcmhnKzZI?=
 =?utf-8?B?MDNPUUtUWEZVTjFhU1kzYkRsaWNhUFlycXpud0hWbmJ6a1UrVlNRNzY5UjJr?=
 =?utf-8?B?L3N6K01udzI2K0srOExuTytuZlhSdEVEVThXV0xHRkRXN2FDTll3WHNBbGU2?=
 =?utf-8?B?QkJwci9ydGVRNGlRMm1oczFzMElnQWFBSzd2TlJOVkk2UHd1MkJUV0hkaU1V?=
 =?utf-8?B?YzRXbUp2bmNJOVZUcUwzSkl0aXgrcklkN1Bhd1pucnd4RXVZcFdQRWtweGts?=
 =?utf-8?B?VlZZUVl3UEVLM0FvQ0FPVmVlN1VQTG4wcGhFS2lxTU9CU2R2QittcEtEUVZJ?=
 =?utf-8?B?bDF4NDR4a1BaWE1sSjBEWlNWY2IwcGtrOFAzZmZTYlNBTmpiZ3VDVTNDVmNM?=
 =?utf-8?B?TTAxc2FZRStaY0F0dkQyNzZOU25SYkhsVklpTHc0MDFJS3BTeFhmVzFDUkVt?=
 =?utf-8?B?UGZrR04xN3hBMVNHTDY4eXVkSG9LV2xZQzN4NVBuQU1McUdyVEw5cmdVdDNU?=
 =?utf-8?B?aGxyZVhCcjB6RVZvVFkxTDBySlF5OGxXZTc2RDN1ZjZKMHlzdDFOQU9hR2di?=
 =?utf-8?B?TC9nR0N1dEwvSlhDcXNhK3k3aXllOG1oL3o0eTBkRlBGQUdBVGc2ZjNndDZD?=
 =?utf-8?B?UTJwTk9XNXBXbEtHa1FhbWdaaW56T05ET2UrNnQ5OVhtaTZiNnRJa2hTbjl5?=
 =?utf-8?B?eXcwM2tKSTlnUCsxSmlsalhuc3haemFteGNaUkJraEgva0NWVStqQUY0cGJX?=
 =?utf-8?B?RW9SK21JVHZiRFM0b2Zvbk1DYjU2anY1UDZ4UXFVZUVkMlRNUUFpWjAzU3Rj?=
 =?utf-8?B?Y1MvZWhPaHFtemw5aUtnMVhsaEhYL0xyN0ZCYjhycENDSVAvMlZuZUxGNDRO?=
 =?utf-8?Q?k05dUq/87joRXGl72Fo5RVMwO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74e67d4-095d-4553-04b6-08dd723d90db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:24:50.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haiiP4x0vYUi/21/kLf3jSm6hM5cM6LvXLcU3fqzCQwtlHA+J62zXwLFj8NaJGRQx15gNKa4olyiTKPkv7jhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161


On 3/8/25 22:20, Shuai Xue wrote:
> Memory allocated for groups is not freed if an error occurs during
> idxd_setup_groups(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/dma/idxd/init.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 635838a81e0f..fe4a14813bba 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -326,6 +326,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> +			kfree(group);
>   			goto err;
>   		}
>   
> @@ -350,7 +351,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   	while (--i >= 0) {
>   		group = idxd->groups[i];
>   		put_device(group_confdev(group));
> +		kfree(group);
>   	}
> +	kfree(idxd->groups);
> +
>   	return rc;
>   }
>   

