Return-Path: <dmaengine+bounces-9044-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDN+In2RnmnTWAQAu9opvQ
	(envelope-from <dmaengine+bounces-9044-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 07:06:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F2192441
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 07:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52DA3039EFF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2A2D9EC4;
	Wed, 25 Feb 2026 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K2vK+4Mf"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F324A078;
	Wed, 25 Feb 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999597; cv=fail; b=BXhYpXcuQsOVamplTKSLyyueUwU8AG2+gWXJIyfDojVFwgB2+IdMkjaMtj0rSMRov0CCzDk917PjZ3d5ub5baSa4JxCw75EixDgRZu3Agkf84Yx17nxXYe/Qd0IJV1srXxHs3zil85STInE4LD2fGfNXyDejQD/oGdl5VM4noy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999597; c=relaxed/simple;
	bh=iQM3aWniz5JWNTEi1RlDBNBT0NcaOiWNkh5sZ0ygVCU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jBGWUVV1jEOZcSjtn6PFBBFFtIngJ8jy/Mwof7AsJKG3c3sB1vrt1pq/QZs4IedTWbSVqrLZkFyhnkUEOjxqPpRcIwKbx3ZapqoezER9usRkP6bwEZZDfvSfumap2dce5m4JTzIQ6FbEfIj9zP4ux3YMYVOamiq6VwpKeQsxEW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K2vK+4Mf; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UblmyJj9YPZiHLTlQGcNyvk4PyqzT//kU1rBe7UFPyvtmdSnP2CbrNUrEB4QqqgE/BP0e1sdGv9lgX7h3UGeWGq41i1byHWT5YeNs4w+aw0dmLUJI5ypYO0EUp+OL1fEpulYEuwhFJK6MJYAHZg7kP9diueHOkLUx/J3c+nhqtGx7Eq37N/XJo84l4RX0S8bvL299cd0Jh8PP2d/oFPSy/qa6234F2GHE80qGzmAn0hXIqgrgyrHkGXTtTt4zawhONcCHPN3Buydexsi4CXCDunCqcCfFg62Q9k7nd4woFZT/Uq1r34HumxnUWGz+DtpLuANpbfMN9Ib2a7NC/eG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LORTqSxgBbSZCyptb92zT+ayEhjl7xF7Q7NdWDWMuBI=;
 b=TdNehuhFgfa/e1740EygP0vTf/R+y/PvXiHhdBfNmLXLtBkeB8jZkcEdlI7evbriKyYHKJ5WrDMIsVEeJQpJHNXNjnD/2KgEEnx9lcPOhoEaxeNfuHfQxuue1zOXD3fKXZ3/PkCCAC2MWahQCHpOl0w8FLKfziAoslas5S1NELGbvmnbnU/9M0Z0/D9jMGCN3ELAeo6TcM/O91AKoYmR/Kz6rsNQxH28oyP+clFJCZElw6F0aZnj2CRNGj6LS46HgMxuTjCAhoetuBlDYs0zxgZ+3vEmKzN9h8LSzKVtdDyIC2QKEiV9QR5htIgIAV2/KPeDC+be15ExdwDSgISvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LORTqSxgBbSZCyptb92zT+ayEhjl7xF7Q7NdWDWMuBI=;
 b=K2vK+4Mfo0fEOl0bj/Kn0jH6sSkqyflWCZbvsQHRgz524up0VlJsd9Em/eagg4gvtvB/N4g58A8UpDyRFxwLzqQPPyxKQQs3Dh0aPTugNLsraRk7AXvQq60wtxJN1Rdv6W5JT1N/rVnuWCYT3AFvbTPaVjm5tsBdPaEIL+ylMtBAFZm5Vp7RfFC+YCjm1nkidrN+13PfiajeiLKGIiPwfXWTNaqDPhjXZpiDDmA5c0NxUzwsShcKaBF/Y/ea6FwxGo5IrYElEzFFZVCycJ8jvwu9GXJADdSRP5zvZ95VTtovHg8Kam+BahJpzlKmx/7Rd2rBPXm4HXTLDHxyZggMMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:06:32 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:06:32 +0000
Message-ID: <a2efd470-6c66-4686-8cc2-ce767aac930a@nvidia.com>
Date: Wed, 25 Feb 2026 11:36:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: tegra: Fix burst size calculation
To: Frank Li <Frank.li@nxp.com>
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, akhilrajeev@nvidia.com,
 vkoul@kernel.org, Frank.Li@kernel.org, thierry.reding@kernel.org,
 digetx@gmail.com, pkunapuli@nvidia.com, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260224083455.333330-1-kkartik@nvidia.com>
 <aZ4jwJ330VUXBNuE@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <aZ4jwJ330VUXBNuE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ee7cf7-0d87-4b2d-7bfc-08de7434061b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdoOVRFSFNyZ1draUZIY2c5SkxaZUhPUXhnazJZLzhGdFhFWlpvUkE0V2Np?=
 =?utf-8?B?MGIyRkFNTmpyTDhEb2J4R24zb1Z3QUp0VUQraEZidk10WkV6N1lQcW0zTUZE?=
 =?utf-8?B?K3gxa3JFNkJCWWdoc2NWaWU4NFkwSFdYZW9zZkZPYXpzZlBydVZ6SGFETFhh?=
 =?utf-8?B?UlBWQzZhbFIvTW5JMmhYeFBWQnRMOEJHQWgvR2grQk9sL2E3akdZc3p4U054?=
 =?utf-8?B?a0k0SjBpb1NteEgyVXpUK2ZyRGdDZWdCTXR4aW51REZvTnlsWTF4aEVNbVg2?=
 =?utf-8?B?dkdvUGtpcXpJMTRVeGdqN1E3ZHVwV3FQMDB0S0Q1UG5SUG05RWlaa2hWTEdH?=
 =?utf-8?B?TTh1c0FuS1o0Y0tEZFlPdUxRSTUvVktiaEY0RnRzWjg4WW0zV1lhVUtGUnhD?=
 =?utf-8?B?SHBBc1FhR3RzQzBYemZxbVZWTkwvei9KNmRkb0NsU1BnVzhuZi9SQjNHQVBr?=
 =?utf-8?B?TTVDRFYyZ0xTZDRoM3JhM2hXN0lneWlIWC9Ca25DS0hvSUVySzlpVkUwVkp1?=
 =?utf-8?B?WDJDV3JLaXNSdUJrS0oxZGhWcnh1Vk9yamV5UUhvblQrQkxQcmZBR24rWnlI?=
 =?utf-8?B?bGdDcFpmM29RY3NacFJpUkhXTzgwWFhUOVJMM0VFTHZiWjNDcWxBQjVFSW9l?=
 =?utf-8?B?b1J0NDRnY2xmQ2twOFlQNjRtZktCQTRLM2FPTTQxWjRReDl1dnYveVlGYkpm?=
 =?utf-8?B?VHBRcWpUMW1selpOVHZybDNEenlMSDg1Sy90SkIrSUxDL2tlQlNQQWlYcGs1?=
 =?utf-8?B?SXlmakpDa3BxSWYwaXhkT3dQdjVUQWFQeHJqK3NZY1cvRlllZVVERGZsZjJS?=
 =?utf-8?B?S2ZLK1VlM0JZcXdjWVFXek45Ujg3L0cyQ05TRjBZZVZvbFlpcmdWdVF2QUZD?=
 =?utf-8?B?cldObWNxNGhHeC9Wa3N1dHRmU01MY0t5V1JjQkRibG9YZ0Q1dGxlbDc2Rzl4?=
 =?utf-8?B?RStnOHZTZkdLVU5KUHNSTitEVnF2RDVSSCtRNVRNQjBkTkgydkFOa1hsd1hN?=
 =?utf-8?B?N3ljYlZzZlduNzlXTjF2dEhwRjRuc0RvUldQQXoxUzI3NkcvOStnaU1TMDB0?=
 =?utf-8?B?MW9uQUdiSjFSeFBBVFU0ZThrL0t6RUdHcjVZRjhWb2hKUkM2Uk1zSkdSM2NW?=
 =?utf-8?B?b1VuRzNqeFlzYzBiL3hjZE9RNkMrZkNOQzk3b1pvbVd4MGJnRGtxaUlEK1cr?=
 =?utf-8?B?dUIwRlpXWVBmUDRCRXlFamlEVnNtTkV0Vnk4Skl5MitlUExxdzAyR2JLTjc5?=
 =?utf-8?B?WGpkeGxucUVET0s3bklyOTFwRkh1Nmp0MEdUdTdHa3lvN0dnOXhrRGV2blFU?=
 =?utf-8?B?cGVIQkhjWUpiOEQ2cnl2RGR0Yno3bTJ3MHZ2RTJXeEJXZ3QwMG9FZTZYMWh4?=
 =?utf-8?B?dHFQY083cTJDaDEwc1NpamtpRitpUG5lMTE2RCszL0h0VVJHUUpvTlE2d0NR?=
 =?utf-8?B?R0NwYWxYTkIxbUZia3YwMjJJems4MkI1MmJxaEFNQmtnNXpYRzZ1Z3RBSWt3?=
 =?utf-8?B?L0g2UlMvWFpmVEdCekdobm5rc2dwYlFHSTBpZEFxd0drdFJDNmx2MnhkNVVX?=
 =?utf-8?B?QUxCbGRPTXdUSDdva0h1VnVIRU8zb0tOdFM3Qm5pZW9jMC9IbkhIdkVLT3FF?=
 =?utf-8?B?azYwUFI1NEpLc1piOTYyd0V3Q2p1SS9vWlVjRWpYdEQ4VDlxK1JwY2NkN0pp?=
 =?utf-8?B?MlhkYm9OOUIvRzVUWU1xSXJCQVVUMG0wcUVrNE96cnBsS0FVV3Vsay9zYzUx?=
 =?utf-8?B?R0dyemJwaXNXTUxXdGFQQ2VER2pOT3Z3WENIdVhpdUUxOGtzUVpGRkE1YlBw?=
 =?utf-8?B?NVdXcE1CYzY5ajVmUUYyYkxsL3VnSjdZS2QvNDZ2QzdVUms0VTluOEpTSEVJ?=
 =?utf-8?B?VlY5eEg2M3hCdFhPRUV5TEd3blYremUwY2Y5Y2lleXFpMEtnemZmSCtva1Rh?=
 =?utf-8?B?YVBJbjI5NjJlazdTMGdjcHNNM0pOd1FrNEdoSmlSUmVGT2IwQkVRTFE4STh4?=
 =?utf-8?B?eGhGZHlnb3dNSDNpbkZEbHpTVy9mSXJRaUxZakJ1eVhsbHJReHY2SkF5UUZN?=
 =?utf-8?B?akczaFpRUURBM3FZZzJuSE5LTmtUNWdSdFVFYzkrQUQ2VEwzZG1rVmNqakla?=
 =?utf-8?Q?qqFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXQ4d0ZtWlVwdUd6ZnhVNmJGcjBvZldLcmsvTWFxdHBnUVR3L1lXVWovZUpv?=
 =?utf-8?B?WEJMUVUrU3hpV2dMVXNYNFJibGU5L1YzZ29hdkdpYzROZGx2MXNvc0xkUWFP?=
 =?utf-8?B?aGI3d2Z3VE0zN0tqTU1LdXBaWkx6cW5MUSszZjB5RGJUSzIyeWhlb0hrSE8v?=
 =?utf-8?B?R3orUEprMFlvZzNpMS9FK0t3RGU5dDdwcEM4ZUp4SUphUUM2S25rQ2hlMWNL?=
 =?utf-8?B?Y3F0eGRtVy9jSDhnbG1ObTg1a2ljYWtpa2ZkRW5LRVBOUUpMTDVLSUdqZHBy?=
 =?utf-8?B?TUZQdEdsa1crYWtTV0pScnJsRlhxa0RrV25pcVZpNVRRbXhDd2JYK1pJRkYr?=
 =?utf-8?B?cHVpSnVGV1lGTVd5b2YwelFYZThQY1FtTEhxelhQRURDemFoZHF4dHhPa1g5?=
 =?utf-8?B?eWxtUnI0bUUwTGNCK2FLZGc4Ri9WUGl3QS9CZ2pydGMxNy94S081WUYxUFdw?=
 =?utf-8?B?emU4dThsN2hWajlpZEh2RFJnQ3lMU1lFWlZqVFN0QTlEK2pEWVg3NUZSZksw?=
 =?utf-8?B?MUEzV25WcCtkekh1bkZ1RFhZYXo3WHRxSGwzdDFrZVdVUWRRRjV5TVpKL3Fy?=
 =?utf-8?B?MXAyellKTlYzdXVqNldpM0d2MWxpZFUxcHJNcVpGTkdlYk1uT3BhdzF3Rjlu?=
 =?utf-8?B?dVc1WXNzamVCZ0xTc0pPclZjcDVleC9qUDJiZm53SXUxdHNhNGc0RkE4Yy9C?=
 =?utf-8?B?VEtQcGdoVFpZcE8wQW1ZOTV3WUgxUmwzNDJoOWNnd0tWc3BpWFUxT0E0M2FF?=
 =?utf-8?B?RHVBZitSUXR3MjNkcUdnbExTZWsvL0FEVzZTSFl5UjJCaHR5ck0rcm9YbTFo?=
 =?utf-8?B?aCtCZHJqdWpEbExWUi9XRDhIT0NGR2xldkxtWGJ2TS9DSDZ0eGh3TWZ4TUE4?=
 =?utf-8?B?R2ZURm81Tm1veUxnc1lRQ3g3WHh2bGlhNUVBTzNHRGdWaFo5MS9uK3JvSVkv?=
 =?utf-8?B?ckRvY1dlZW1zeDNxQzU0eWlzWlBQbzlkKzFPRGlzV1htaXpjZFFBY0o3Si9R?=
 =?utf-8?B?dnU4aWluWmY0cVJzcU96akJDQ282eGZOaHZBYWR1TXIyWTJNUldDWWlZWVRU?=
 =?utf-8?B?SU5qTmZwYTh5NjdJZ2RlRmJiL2tVMlpDenZlQUs3cmJ5UE9pTmd1MzFWN1JK?=
 =?utf-8?B?MjRSQ1BYeXdXTFJtWk9PTWNjYmc3T0cwTGcrdmlzZkozRE9YYVUvUHo3bURo?=
 =?utf-8?B?SEdoTitZMXh6TGpKeGRsS215T1FuN2lTY1pHU1J4WjBMaVVCaUp4cDZhUTAr?=
 =?utf-8?B?TUN3Nk9sV1dvRXpXSEhRUGV5WkIwdTFyeG5qSG1CNXU0d2RYVXp3aGpuelo0?=
 =?utf-8?B?Zm41a1ZnaGhIQXZUTVBhYUtDby85UitjMWxSNmJMUDVkQk1Sblc3U01BRWQv?=
 =?utf-8?B?ckIwRWdnM2JUbzFINmpGRldmZ00yQkhZSGNnN2VGQVdRRTNnZVRha0poRzRS?=
 =?utf-8?B?WS9CaXVzWUtkZ1A2LzVsTzhUL1lZazJxZ1A1bWMzY0JXSHUwNWRNMEt4cmc3?=
 =?utf-8?B?Mk9QSzd0Ykl6eVRpQU91ZzFGek54Y2lmTVJrQnFTM1dyRmFYUGlXbWJVSHF3?=
 =?utf-8?B?dW9rdjcvOFBqQUxxR1JTSWJYU1phMm9Bb0ZPV0UvVXArMTNDdDV5a3NkSzZO?=
 =?utf-8?B?NXRBZTFIUURnenJwWWtCZjQya3hxZ3pZT3dtMnA2U2RPWFlEeXFFSU4zenNy?=
 =?utf-8?B?d3NiYVhIeXFTYUdtckdqY3liaEc3anU0KzRXeG5NTXpITXVlb0JTNzJqbm1r?=
 =?utf-8?B?SFJqSTlMbjJhL3ZERmNQbFZodmZueXNhZHk3eTZpazBSbVQ4YURxRTZ3c1Y1?=
 =?utf-8?B?aVhDbXA5TksxcVZhOWxWM2VINFpaWnBQZU5VaU4ySnFINTJVUDQ2Y3AxbVhz?=
 =?utf-8?B?R0xkUGV2NWxXMTNOaVEwNTFJTjhUZ0Z6NmoxbE1QdXA3NVg5L05VeXhVdVQy?=
 =?utf-8?B?cTJyMmp6dG9oTEhHRFg4OEJuVnVUc1hhRytjYk14V3ZOb1g5VlI0YTk1T3lX?=
 =?utf-8?B?UXpuWE9HOUs3M2tuRW5aMC9WMDRsblVTUDlSWXI5YTQyamVXaDVRWDMxMW9y?=
 =?utf-8?B?enBGSlUwQ0d1Tjc4WjZnamJjWC9NNDVvbFJMZE9ISkRROFllczZGRUdDODBZ?=
 =?utf-8?B?RFByRVYvTzdGUWFQMW5XcXNqczdsN21HUjRjYmhXSHZFdHhsMVhWK3RKd3Zy?=
 =?utf-8?B?QUVjYVdDWUwxUzc2R3hqZ3Rjd1ZwQlhKbzNGcnZnc0pHeHlSV3A1eXY5Y0NL?=
 =?utf-8?B?ZERtMks4MDlOZ0JqUHVXWElHcWdBWFdFV1Zja0dZWHZmMFdpaWtocW0vY2h2?=
 =?utf-8?B?N2xVQ3krUUxiY2JsZUZHM1pVZmxrUXRhemRQVFVpamE0WitlR3dMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ee7cf7-0d87-4b2d-7bfc-08de7434061b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:06:32.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsiwQpJVEeuantI+I8Ftd3Ful6s0en5VDWkxaIaTWMk9Lo1TLcJacdt6zl7FlUex/S7sZKShFvJOHWuFiQJBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9044-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kkartik@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A0F2192441
X-Rspamd-Action: no action

On 25/02/26 03:48, Frank Li wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Feb 24, 2026 at 02:04:54PM +0530, Kartik Rajput wrote:
>> Currently, the Tegra GPC DMA hardware requires the transfer length to
>> be a multiple of the max burst size configured for the channel. When a
>> client requests a transfer where the length is not evenly divisible by
>> the configured max burst size, the DMA hangs with partial burst at
>> the end.
>>
>> Fix this by reducing the burst size to the largest power-of-2 value
>> that evenly divides the transfer length. For example, a 40-byte
>> transfer with a 16-byte max burst will now use an 8-byte burst
>> (40 / 8 = 5 complete bursts) instead of causing a hang.
>>
>> This issue was observed with the PL011 UART driver where TX DMA
>> transfers of arbitrary lengths were stuck.
> 
> Suppose set burst size by UART driver through dma_config_slave. it depend
> on uart's watermark settings.
> 
> Optimaized method as your example is set first transfer burst length 32,
> the second transfer is 8.
> 
> Frank
>>
>> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>> ---
>>   drivers/dma/tegra186-gpc-dma.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>> index 4d6fe0efa76e..7df0a745e7b8 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>>         * len to calculate the optimum burst size
>>         */
>>        burst_byte = burst_size ? burst_size * slave_bw : len;
>> +
>> +     /*
>> +      * Find the largest burst size that evenly divides the transfer length.
>> +      * The hardware requires the transfer length to be a multiple of the
>> +      * burst size - partial bursts are not supported.
>> +      */
>> +     burst_byte = min(burst_byte, 1U << __ffs(len));
>>        burst_mmio_width = burst_byte / 4;
>>
>>        if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
>> --
>> 2.43.0
>>

Hi Frank,

Thanks for reviewing the patch.

The primary goal of this change is correctness. GPCDMA requires the programmed
burst size to evenly divide the transfer length; otherwise, the transfer can hang
due to an incomplete final burst.

While dmaengine_slave_config() allows clients to specify a maxburst based on
their FIFO configuration, DMAengine does not guarantee that every submitted
transfer length will be divisible by that value. Since clients may submit
arbitrary lengths, the driver must ensure the programmed burst size is valid
for each descriptor.

This change simply makes sure the burst we program does not exceed the
configured maxburst and divides the transfer length, so we don’t end up
programming something the hardware cannot handle.


Thanks,
Kartik

