Return-Path: <dmaengine+bounces-4290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949FA2898A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896D01888428
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818422D4E5;
	Wed,  5 Feb 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X070M44t"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029822B5B9;
	Wed,  5 Feb 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755613; cv=fail; b=LZ/bBEI2cE4SrE35cmB9zUYCojQUdqXQI74TyCHunC9ov3JLy2koO3JMDv1dGPRinTE7LhD7+ONf3PA/lHpGipKuBXJUStoSnbw3VrOB4n1WLXA/8gyIxxrxsz/64hr8xoboUSdQ3D91HBsObXeJXC4cJIxiQwcIhHbXGkDw+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755613; c=relaxed/simple;
	bh=tEaErxRucqpHVOAwmEdcqMcfl8brMBtBaDw1DDnZUQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuMdimrjWj6SR4Bk7qvF9fVzn186P9YkEM8N6MCL5ohyRKxap6x2z240WLuJcqIFZwf9g0kP+Rp3S6vm0RAVCKPiODc0LpkpH5DS2G1991ODo9igEQb2TItPrlmlBpk722gy/bfvo/uHoW/hkv9Y17Ljxb5j5O/EDZRrNppaO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X070M44t; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYw5JC24cEdkXhqCJ8PqZNMNqR/+/2a22xpuiwzxvsHGOsVJPJ4deUmArvbLBdWZGV7Z5QGN1fiYIh2f7Ujiwze+peD2rOw8hBqwt2E34G0iTzLsldDWHN2mi/GSAZNK8k6nqrDO8fT0Z+QIR6p885oV39J9OZ3oc1tIUewjwGR+Xj99bdtV63sQc4sl19XSKikUOjqGWowdiSKIDsnysN83KO/M9pDiKrRSZZsAktj9p+JC+lOZ/sGxbdQ82/nXxjKi9pvb+m485LeQY3aKCO7amczoF6+HYObdu5z0QDKsvMq3Ad89o3ku3yjvz7PScZbnd23Y0DkQshs9nmNuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4SWCAd6F/qOCy3y38oydJZGlT6k2IFktvF/FcDzkXY=;
 b=fiEM1s6nxJ1O/qJx9K1H+nMVSA/RG6kS0vIMcooD04pEEvrfuXNyU54T/Qh6ZIA8LN3ohd+Y7KBhSMB0n3ezJqAiS9UWlt5y5KHkEZDakOXMR+hOFhTnXncAlevVdDnl8Cnxdsyq4oh2ZDuzUsPEKFgy4a/Lz3SVhNbUvf/LvxjYjLpaNr5OXdK606yGww6U9dajm4XIkClxSIqq9l5DWXncowjh18ls8kTVHZ8ZqvpyZzoY868/2thqG7BKE6fmqDxfAVi9WVlAajOXcE6lCv4z4ZY0i6IFZsddS2YE+zF+Qg21JMAO+gwPy5eCRZ5xzVVwymIuiRXcr4tXZV46eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4SWCAd6F/qOCy3y38oydJZGlT6k2IFktvF/FcDzkXY=;
 b=X070M44tCWLiaLy/w4d+mAH43plvwC0YobDKNfalfJ8BskHwdBLbvyy9GKclgjFuz72iyOhtuKlx3R31ZiTrPR8A+MFGsyHlY4EslXtcMcs5vu6yz+apiFefyeiRtQmBELYflkDu5je/zG9/90lzaYnfQkomvb92VTEdDw0liw6ItnQUa/WPCb1/gCUhr6rYqCAL1w7gUKbSBXPk2g43J1uopGOriZ4xH7JDQBorP95/RXmWcv2gSV10702keebVZnmSSOjGFeCIdszp4OmRUCmXg3QplsPT5rMUMedKU+V4WjnKirRlGR6YxmNOSt5rQMJ952es+y3wsxOr7ucVKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 11:40:05 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:40:04 +0000
Message-ID: <61a3c7e9-f3cb-4bc2-a10b-5e44fa2cdedf@nvidia.com>
Date: Wed, 5 Feb 2025 11:40:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-3-mkumard@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250205033131.3920801-3-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 935b0123-42e0-4358-b871-08dd45d9d564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXRjelhtU2NKYlQrVWc3YlE4VFRBZ1dqcHdWVGt3YVN4SE92R0lpSHlaRXU1?=
 =?utf-8?B?TmpuZUlkNjlkTDNqTFJyVlk0V3JNVXZuVDlzeVF3emFPeWtadE1vczJhTHpj?=
 =?utf-8?B?eGdTTjgyd2VXcElLUzdlT3UvUkw3bldNam9oMjNISTd2MlJIQmRtVlV5Wlpa?=
 =?utf-8?B?ZEFDQ25BS0V0OHhsT0ltKzF2Mmw4YTAvSUczTTExYTYwaGcxcU9lUFpEZlVU?=
 =?utf-8?B?ZW9TamZlRHRmeVVlNDJMLzFTTXlhcEtsemhPeHJjeWpPTjU1L2RxQzE3dHJR?=
 =?utf-8?B?N3BrL1FJYUtQT2syckxKYWR2Z0cvOEMzTGJuMHpKS05TTEF4eEJ4cGdPTlps?=
 =?utf-8?B?RmNzSnhhckNSVUl5bkJlSEdZeXluai9iczZpdWFaTkpZSDY3L2NiNzllWlJG?=
 =?utf-8?B?YnBhQ2p3dHJ3TXp1SmY0d1JsR3N4V2FZdVgxUnZadWNsNmNlR0lqSXdoMDRM?=
 =?utf-8?B?WmV1UmorMG1SdG1XQUFYb3pKN2tpOW4rUTRKRmxnUzgySGQ3dG9aVnVFRENC?=
 =?utf-8?B?eW5uZ1RyWUdONXd6QzRPVTh5cFQweXo2WVBGVjhjUlRBR3ZWWlc3MUQ1QzhN?=
 =?utf-8?B?clpIK0ZUNjVtb20rNXUvdTc2NjNmWGpQY2c0V2NPWUloM2tqRGcxakhBa1Mr?=
 =?utf-8?B?RWkrL0Z5dE9aMWQzT3B4Um0vUE41K1V1cjVtcmNuOVloZDNySllHSjdxaXNx?=
 =?utf-8?B?elN6Z2ZRNkRIQ0hCaTBoN1hUelBLODlBL3p0cmYvV0x1Y2JjazhwZlkxWGVJ?=
 =?utf-8?B?UGk1YTQzMUpITVVQclRjU1lwRnp2N0MzeUNGWVk0UUFPd3FmR3VzQXRHSWho?=
 =?utf-8?B?TCtLeEVDQlVLQlV0dFJQNUhHOU05eXNwS0NzaTA5VVZ3ZnlrZVloYkY2TkJB?=
 =?utf-8?B?cEJIOW9UdGZFU3hLMFROeHYxci85bWxYQUVTcHJ3bjk0TTB5QmJQK3BLRkMz?=
 =?utf-8?B?RFpLRkhGK25QMnBvemV3U2RZV1IxZEVRaXRQU011UlJYV0ZYc3Nkc080TWdh?=
 =?utf-8?B?NWtUcENwdE1BTUI1anAzelhKR2dpWVg0dVlkYVFyM3VqcjR3THhYeUcwRGdW?=
 =?utf-8?B?U28relFDczdvYXRuSHVxYXlGcFFLc2R0OFhna0tzc1VEcnEyTlFGRFVoT21G?=
 =?utf-8?B?NHcvanM2cEdKNVB2UmFrNkdIYlhRVzdRMlRaV2krai92TTJSemdXdnp4b0Fw?=
 =?utf-8?B?RE9sRCszUmc4Nkh4UGpQWEk4YjZtOURjbnZGOW9qM0YwazRZMjMzZlhSUGNx?=
 =?utf-8?B?cUlKNW1FY00zWS9MekxvR29iNW5iSWNXNkYwbDA0eWg0ZS93dEdJWldCRnMw?=
 =?utf-8?B?VEQrQnRrTzlIbjVZaUF6a0h5bnFaWWcvc0JScEMzdDd6QlFLNERRUytwYks2?=
 =?utf-8?B?b3dzUnQ0d0hqTGtxdWc0RkRLOVcwR3BIY0FwbHRESGJUK2Jtb1p1OTFKOUt2?=
 =?utf-8?B?by9GcHBObDVqU0txVTdHbTh0Um9nUmpGSWdQNkVXNjVkZVdKbjRMcHk5VU50?=
 =?utf-8?B?dDBVSXlGa21ESEtxK2ljTVBOYlBPYkJ4S2w1Nk5kR2JFU1laUnkxS2VsMy9m?=
 =?utf-8?B?c2pINk9kYVVtMnVpaXRuMENtRkVkVy80WWphM3JWS0swZHRLajlQS0xaMDJH?=
 =?utf-8?B?ME8wVEFnK3U1SDJJWmJyQjkyS0hzVTN5K21OTlFWYzBRdDlUUEwwNlp0U0lN?=
 =?utf-8?B?UGdwNDQ3WFFZaXdjQXZLQTUvelVWcHBaaUhjN0lRNEdEYjd2RW90ekcvelpT?=
 =?utf-8?B?ZFVaVktFMlU0YXNnUDBVeGdYaFFJeXVkVGJLbElMVFhVR0l0L3JXdCt0amdv?=
 =?utf-8?B?MGdLWmFLSWdVTEtiOSs3VDhCdEhHMnBuTjBVenBtU0tqNDZKbHRMb3Z3NzBl?=
 =?utf-8?Q?FLtbz7pREGX+u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxRWXhQUHhSSmY4WS9kYzVQbTNTTTlxSmU4bWR6ZUcxeTN3bDlnUzNHVGVv?=
 =?utf-8?B?TTBPL3hOOVFvbHBIdFo1WnRCaHZ2aVgxZlhzWDF5RWNHQllHRjdQc1lUbUI2?=
 =?utf-8?B?UFVtSUxObFRjU2NPNGVoZFdiM1lzRTRpcS81QldhaStpelZZa2VyeVI3VzNR?=
 =?utf-8?B?RWtIT3QyTEZRZWVYZElVb0lhMGZJSVVOcGN2UGdYZ3liQWdYc2FEKzRqeitj?=
 =?utf-8?B?NnRlZTN2aG1TVW5oYXBRS0RGSTNRUitjTUV3UlVCeVk0MU5Xd2Z4bitJZXlV?=
 =?utf-8?B?TVgzTVFoQzRIR3kzVjh1dkwzTU9rWHZzM3ZtYmNmdzlKMzVsTXd1ck1FOTJQ?=
 =?utf-8?B?ajN1Y1RiUDNrMDdNUTVqNmZXV3A5STJtaWNIQXFvZ0FJVER5NHBrUFowWVJI?=
 =?utf-8?B?ZDlZU0tvRVJnak5TMDgrelFzYS9mSnlZKzlEbEcySmE1elEzZHFHa0g5UWtL?=
 =?utf-8?B?S1AwZHRzQ3RkSTZPMnRNZ1RPUzhvQ3ZyLzQ0Smp4SlNaaUtaNTNTRGhwQm9M?=
 =?utf-8?B?Zlk5VW5udVIxVWI0RFFaQ2hkQXZzUkErcnk5TC8way9SZWl6YUdPUXpqUmNu?=
 =?utf-8?B?bExjZEpLZlZ6eFZFN3R0SkdRQ3pOR0lxUW83ZmVOSFQ2U3YxdjAwOWFablZw?=
 =?utf-8?B?MHRCN0x2QSt3UDN2ZmV6ZE1LNTZOQ1dUWDJRV2x1dTR4TUtYSDByQWJsblVO?=
 =?utf-8?B?U3JGSFd5ZkdwUDN2WTd6NTFNNzZnTGxMQWthU0VwL3U4NmtkMzkyZ3BRRVR2?=
 =?utf-8?B?WFZ6R1NxcG9STFFlWUpySStCZWR5VS9NY0Rwa2ptUHRJRjdGYnZnSEpCalBD?=
 =?utf-8?B?WVhNNVBSdk9ERWdaR290cFhJNmNlVFZWdkpZWTNmUFUrUlJ1dDJQNzRWekVK?=
 =?utf-8?B?SjZ4QlR4WUN2MHhHY0xNVzdZZUdhWVRRQ1BKU3RkTDBHU3d1NlFaMVJuenZI?=
 =?utf-8?B?RlFnSTg1aXFwanJHZzhhc1dlU2FkVk9hMnlrdW9QV0JtWEM0bU82SDEyUFl2?=
 =?utf-8?B?ZEY3eTJDMGU2eFA3bGJLeVdpYlBDQy81c0hXNW1aUm9qMEJsUGRWUzM5anQx?=
 =?utf-8?B?eC83U2phdmZIbXpucFBacHNLVnB4TkhBMVg3OUpEb2M0T1V3OEhNNjA4cEJ0?=
 =?utf-8?B?Vk01Z2dFZEIvbS8yZnpyY2lLdnQraWhDck1KYmsweTRjT2dyalRINDI0aFBM?=
 =?utf-8?B?Y2UxMUxvZ3M5eG9vSkphaFdZcE04SnZMaklnUHgzN1A1TE9HT2VCK3g5dWlp?=
 =?utf-8?B?bnJsWDV1Wm5NQXlFeDlibStZOHk1d3c3cWw3NVpTbFpsZzJqNzdqQnhWL0RH?=
 =?utf-8?B?YU1JaHVkYmpvbTJPYmpQaTRsemI3STMzTjhJSDlMRTRTc3N5QzFhdC9pU0Ru?=
 =?utf-8?B?UnBUUjN6ZUV0N1QyWldaTzZHMCtUc2FuRDZ1OXl5TlVxc0tkYWRmUlhHaTFh?=
 =?utf-8?B?cHZBTGdieWlFNW1MVWlyRXpVR2x0NEt6MmxRK3BweTNSRlVIeHJXa00raXMr?=
 =?utf-8?B?ZERhQVhTeEd0SmMvTkI2USt5ZksrVTdxZUV5Z1FZalAvclQ1WEJSWks3dWYz?=
 =?utf-8?B?aHJDZWdXcnQ5M2hZcUVCcWtQQ25PbmJjcThLR29RTENjR3FPVGI0aHpVTkVw?=
 =?utf-8?B?d08vU2tpVVhvWllFSi9jdEVUa2xHRmwxNHJSd2EwWmIwa2dpOVZYVTlydUov?=
 =?utf-8?B?dkRCcTlaUmo5SVNDNDZjanNPdWRRTXZvNitOQ3Z2ZWpHeGZWa29FNEZXMm4y?=
 =?utf-8?B?WGU0SXd2cjNlTjc1WDY1QzNVRVkzOG5SQ2Q4OThPYTFHL1FzbHZSN3VTUFFJ?=
 =?utf-8?B?L2pTR0dEaWVIS0lNcFgwbUN5aklnRVh5eVk1eWZpdjFpNWllRVcrRzhPYllV?=
 =?utf-8?B?WDNhOGxieG5SbTAxOXRJY294QmtJNGhaNEpRajJmKzlpSU0vSFNuWmp5VFlS?=
 =?utf-8?B?dFRkKzNocWpibkdSV2l1QkFQNUdNZWhBNVAyYVpVVFNuU0ZXVmltRCtYZVcr?=
 =?utf-8?B?TldtK3FkdDhQM2ZWdzRQb3RnekY2ZUZEZk4xNkI3RU9Ja3NaZjJiK1pTOFc4?=
 =?utf-8?B?ZGxCNElSUlYxREx1OUwzL0VDc2lheXZQM0lhQ0FXdnpPcTlEWmJjbXNGV0VM?=
 =?utf-8?B?VVUycEFNQ216czVVTE9ISXdOSG4yVzdFNTcwMDhWK0trcDY5czQ0cHowbHoy?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935b0123-42e0-4358-b871-08dd45d9d564
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:40:04.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5bUJPESO+s4JrwVIaL+BC/Y1CezF9EOQOXnDNm5+PwuADPSMOiENrfIKTEn9UspE0xBhmI4YI6LgK7osUNfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636



On 05/02/2025 03:31, Mohan Kumar D wrote:
> Have additional check for max channel page during the probe
> to cover if any offset overshoot happens due to wrong DT
> configuration.
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index a0bd4822ed80..801740ad8e0d 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -83,7 +83,9 @@ struct tegra_adma;
>    * @nr_channels: Number of DMA channels available.
>    * @ch_fifo_size_mask: Mask for FIFO size field.
>    * @sreq_index_offset: Slave channel index offset.
> + * @max_page: Maximum ADMA Channel Page.
>    * @has_outstanding_reqs: If DMA channel can have outstanding requests.
> + * @set_global_pg_config: Global page programming.
>    */
>   struct tegra_adma_chip_data {
>   	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
> @@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
>   	unsigned int nr_channels;
>   	unsigned int ch_fifo_size_mask;
>   	unsigned int sreq_index_offset;
> +	unsigned int max_page;
>   	bool has_outstanding_reqs;
>   	void (*set_global_pg_config)(struct tegra_adma *tdma);
>   };
> @@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>   	.nr_channels		= 22,
>   	.ch_fifo_size_mask	= 0xf,
>   	.sreq_index_offset	= 2,
> +	.max_page		= 0,
>   	.has_outstanding_reqs	= false,
>   	.set_global_pg_config	= NULL,
>   };
> @@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>   	.nr_channels		= 32,
>   	.ch_fifo_size_mask	= 0x1f,
>   	.sreq_index_offset	= 4,
> +	.max_page		= 4,
>   	.has_outstanding_reqs	= true,
>   	.set_global_pg_config	= tegra186_adma_global_page_config,
>   };
> @@ -921,7 +926,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			page_offset = res_page->start - res_base->start;
>   			page_no = div_u64(page_offset, cdata->ch_base_offset);
>   
> -			if (WARN_ON(page_no == 0))
> +			if (WARN_ON(page_no == 0 || page_no > cdata->max_page))

So no one should ever specify the 'page' region for Tegra210, correct? 
If they did then this would always fail. I don't know if it is also 
worth checking if someone has a 'page' region for a device that has 
max_page == 0?

Jon
-- 
nvpublic


