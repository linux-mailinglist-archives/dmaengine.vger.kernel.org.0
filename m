Return-Path: <dmaengine+bounces-3664-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD39B826B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 19:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DE6B217A3
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57B1C8FBA;
	Thu, 31 Oct 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="C8YonVM6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7241C9DFB;
	Thu, 31 Oct 2024 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398581; cv=fail; b=c+yDhmDkyDPBk6F5A30MwKXE1r5cFsqCvm0HTf2DMk3fRmBfpOXLcqt5t1G0edJnA4OY0GzqWdIe1mPQ4tKrd4u8KXEkUBXDZtcmWpk34Qn9s3DD8AB0e1SlN8UDP4qfjduBG4lJOMrTv+ARF0RrAdRma2xXj3pNB9Pmj7vFxzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398581; c=relaxed/simple;
	bh=nNjMyayQjcJNdegjgSKDArxXl6n3ldB0WGnEFPYZEQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LAy9YPwv0G0I+Y1AzyIJofWxy07Lbb6pWaaCpvzP+jXkVO/E9R+HbSQGMkMdAnUmNsb0z1Za3Y4dbtmiFi05M0Ha1J+T9LlI1AiXI9Lk9LGzEUxiGptV7RC979IO+Lx33X/LtKTNk/9RpH9shiYezlto1zS82WHG6oI+J2mbX/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=C8YonVM6; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VARQ5N010526;
	Thu, 31 Oct 2024 11:15:41 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42kfwh47jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 11:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqxH1W3grf+RR1gDbhVPLUaTbrhGZE02S9oVMhniGKkHzxqDtcX3g4NW+zPp2AWTlRUK+5+KkdzUot2lfWrThQY0S/iqA2S7Owd+vovi4AkReOR/UJU5havyS/nE65W9Asrfw/TRcfYI+tKMakKeGxPxxfYz02c5pdZtuCIIKuVOMQHtKutp4sWTFm04i0uLvSbuZtmOcxzcZQI89JkkZ/f0dUkQnWDvTrWpd0xpKVZAtWAymWeZUfBM0O2IMf6f57L5Y9Ra/uMtqxnUyZvC3R4nptJlYLsmnXfbnETlBT9/1NhorK1EbmOaS6mGmKkQtKZKp77cPXiNtPRF8i7pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gllz7mVQotAEWLKRF70blJ1erxJLUl4+m9tX4u9UGRQ=;
 b=euYduChvOhcCzgLF2tNyK8KGsU7OXhtiqW9XAhadPM5VotrAv9kni6JuWDRgtdy/TMHcjbYC7ZAF2T251r0LW+uz9tIQa9L3RckZuIl7O1mmJ0b4RWkjaQneg3gORDdZLwTdn1TE+ZbgU4TSKqaCKt1RrZK2QvcIzJrir4Iq9nLqYcehbshfoSTz2FwAAs5j1DYHU/5n45HzzCZSG2Euj6uUlzFirFoEOlxjY5j2iFDIViINB78qKXVBDIPGhuA5yy2zgm3P5KlAgtAa4QELQosPEcpBU4fLqnP2yX1D9nUNoY8pUUsSVqqyqLZ6FQmXh/pVpsqPYBhKUvmzuG2YPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gllz7mVQotAEWLKRF70blJ1erxJLUl4+m9tX4u9UGRQ=;
 b=C8YonVM6WT5wPvq8b65PfGJeUueTCKKaX9uyILQcflhPM00cY3IsaakHgH8ExyTkCzCKEYU3CFf4TdT0oOJ/WVKoSZwApyw/I8VB3deKmQKDPZYf/iqjQqxYCLqrli+83sAft0YP21jEBC8wm/8YoCf8kAlxVUOsnn8i24rKBUU=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SJ0PR18MB5139.namprd18.prod.outlook.com (2603:10b6:a03:43a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 18:15:35 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 18:15:35 +0000
Message-ID: <f3ffb5fc-7e85-4949-a326-7515e491d43d@marvell.com>
Date: Thu, 31 Oct 2024 23:45:45 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 01/10] dma-engine: sun4i: Add a quirk to support different
 chips
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SJ0PR18MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: b22176f5-1af4-406a-c156-08dcf9d803ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFQreDJRR2ZpcEZpbXhVeWdYb2VaenRraWdvM1FuTlJjWDNJalBDVmVRUXNF?=
 =?utf-8?B?Q0YrZktBSUZiNGVjNWREU3pPeFFweEJMUlBJaDl0cmhZU2xHTDFhNzJoUDJE?=
 =?utf-8?B?WFA5UDJlazBEU21peDM3eDBUbkluMFZVczBMeXVmZGsxNkw2Q3JzQ1Z0eGU1?=
 =?utf-8?B?cmh6NFlQd3J4Mms2TXJNTkZLbEJhUTE3MFh4RDJXamYrd284SThJTzdIU3Rv?=
 =?utf-8?B?U3NHcWk1VStJU2l5MjJwdFZvbkptR3F6dGpEZURLNjRVYjNoVkZDUnhVOWtJ?=
 =?utf-8?B?Q2Uwam1NcEdJYzVpUnpGdEljQy82aW92dnhsTFdBRm9DQUwycnNUZWtCNHlv?=
 =?utf-8?B?SlVOc2N4d0NHNlQ1OGJUTnF2c0RscUFDanByYnFXajZKaWR3Z3JJYWs2UFhI?=
 =?utf-8?B?MHhaVEZHZFllZnJJUGVCQjJWSzIwT3BCUERrMG1PelovMExMVUxKZk5Qa1pX?=
 =?utf-8?B?NWd1RW1oOVZFZG5tbnk1RTJpRUNYWXJZTWd6eEthcXRwUVFWNUhGQmpRS0lR?=
 =?utf-8?B?djErSEdrZ0FPNnJhbEkzaEJqcE55V05LRmFOTEgyQjduQkVlK1BNZ2JlRUd5?=
 =?utf-8?B?TjZHRDRsQVpnMzFDYVdPQlpaN0NjVnEwTWFqWnRXRjJLYjRSd21mNWhGMk5P?=
 =?utf-8?B?UWJ5U1dNa2lSSDNhb3E3SkRISnRPSjBtSGF5ekVOYXJIQ1hwVlBSYVdtc0NK?=
 =?utf-8?B?L0dkTmZCNmlzbTBENkVTM3hndHJrakE1MEVjRWc5TDl5OTVrb0Mzd2FoZHJY?=
 =?utf-8?B?cUIwZ3BhNHB0WHV1aVlRTVVET3BDbFNOaWtzUnBPSEJxU3huRWNLQkRKWlYz?=
 =?utf-8?B?ZjB6eWNSelBSM2pmTXh1eGY2TlFaZ0Noa08xcGNQMFU4bGhvVzJ4K2VFcmxG?=
 =?utf-8?B?OEJrZUtBUzN2YUdsRGJFRzBwekJPenNUSVFZeHVLSFdmSUxHa1lxWHpCSWZU?=
 =?utf-8?B?SWZUUHppaERuUnpmWWNEQi9yS1ZjcVlxK1Jta3lnSUpLMUlkRXdSbUIzWW0w?=
 =?utf-8?B?SUNFT1l3WmRKa2wxd2w2NS84bElRUDVwZzRMQlo4YUFQZFB3U2VZOGFpcWxE?=
 =?utf-8?B?RFk5SG43aDVpSUJVREJwaWpCaGczbjVFak9mMVdBM2M2NTFPWThVd1docjB1?=
 =?utf-8?B?cmppZm56OWtLbTVCd1RuczE0cExDUFRSYXZxZnlwNnNiZDh0SVRES3ZRTVRn?=
 =?utf-8?B?U2g0UGJmSVhPS3YwUm5MQnEvbUxDUWN5N21COERQcmJ1V3FzR0JHK3pPOE84?=
 =?utf-8?B?ZWdIeXA1bWhxQkZxNkdrTkM0YWN5emxsS3lpTkFiU2IwcVJ6WjV2N04vamsx?=
 =?utf-8?B?blAzd3VLWnN4Z1hhMDVKOUNYMnBRd0RSUTNITzErWmJBSzZBbGFaRkJQN3JK?=
 =?utf-8?B?Ykw0Z2VyRGpFZWZ5NTNWUTcxMzAyelM0ckFzUUlxSk44L0JQNXNBVlo2QUl6?=
 =?utf-8?B?NHlHNS9Dd2gySVdJUU1aVmsvMFZzNFMxenhsMDVqdTN5ZDgwMlE1bEVmcnFo?=
 =?utf-8?B?bGdXeHFyTmtEZHh1dWhERzMwS0plbllza3ZGY2NSRmxGc0tuV2c3UWs3Mlpp?=
 =?utf-8?B?bXJXQW9MOXJpQzRyQ29GREtBZDQ2YXFhY1hUZW8rd2JLU3dJS1dseDljY0Rp?=
 =?utf-8?B?TjF6Yk1WK3phUHYvVHZwZ1ZGWDFKMGlRN3hqT0c4dlZtb1hEMjdtSTY3Q25T?=
 =?utf-8?B?MGovYmZiOStTYVUxd3hoTUxKc2xYM3N2aFdLZk94eVJwd2xWR0h0M0pjWkY5?=
 =?utf-8?Q?HxzgTLeWbwnUKwqjgv4vRfDR932/qweXHmwDQ19?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VUeHNTaHliUkxqem9uTVJ3UTF2S1NIaXdmenJoL3R5NE4zQVpyaVMwT200?=
 =?utf-8?B?RkFLVTA3SmhZRDFyYWgyNnh3em1MTWo3V2E4LzBqMXcvZ3VIelBPSDRSYVVE?=
 =?utf-8?B?T2tIVUlvUVAzZm9lcTBkK2FVWDhtUVk0SWRjcWhoVmJaVTNUem1IekhZT2Np?=
 =?utf-8?B?QThKZElSMnMxZ0RTWFBGOXdHYWwvUkdNZW1CQkU5MFgyclNlU1ppRTN3bnU0?=
 =?utf-8?B?c1liTHpsOVVDZ1ZyaXpLd3pKNDVXQUI2OHRiZCs4NUE3NDhWYXliSVBmd2pa?=
 =?utf-8?B?bWRTUDAwUHM4cy9uMjJ1TUxzcjZibzlZM1MvQTZUdlNuSkFTQWxZVUpNUWhs?=
 =?utf-8?B?L1daRkJHSTlSK0Juemk5RDZEMmlaOHN2NE1UUnh6UTNWYnY2RDJBUTFlczJF?=
 =?utf-8?B?aHdEeC82MEVvN1hHdDBkZTFUQk5pMkFSbytGckpWdllqYnJpenFPdkhJRldQ?=
 =?utf-8?B?UUtCVnh5a043UjFJMkVRTXdhRFZrWDZFYXl3cGJXRUhVa2tabFhscDNQWWl6?=
 =?utf-8?B?RFVZa1RRNHM4ZjVid2VaMVFWdldSSzQwTmI0dFNIRE9tY2pKd01VTUVrUHFo?=
 =?utf-8?B?ZnNXcWp1Ny9KS3dZY2c5WVFtSHVZQ0NDZmNGQzR2LzVjTnMwWmh3VWFCdE95?=
 =?utf-8?B?NUt0V1o5a05vQVpoaHhabFRQK01YY1lqYSs2OFI1NmpLUElHaU9ZcVYxbHA4?=
 =?utf-8?B?SlBKUEFOazV1ZCtRV0JiQ2RJKzJpSzhxbHNMaXlmN3lRZ05GRUxMZEtSOVMv?=
 =?utf-8?B?dm1oTUxWb2djcDI1N2xyM0hobkFreStnZGlZTHBvUUZVZHgvVm02dk9Wd2dX?=
 =?utf-8?B?YW5OZDRxWklFdnpOYzdleTAvR1FTT05GY29GVXpVV1V5ZmNGWWtsWWNoOWJj?=
 =?utf-8?B?alYxNXZuczhSa1N3RWxtanFvcjF4dkNJTzJtMFB2NzdzVXNiWGhER2paaUxJ?=
 =?utf-8?B?VlNOdTZIRURQT0c1U0szTTB5OVdkM1NVRm5Bb1Y5d1JhMnppWGkwaGhFd1F5?=
 =?utf-8?B?cTA2Q2U5TUlvWmpPaWUyV3VRREZCeWhMcFl5MGkvejAzeHFUM2Y5Y2JoUGUz?=
 =?utf-8?B?L0I1Zm50aWdEU3BNcm5YdEdzbnpiVFRRa2dVVWw0QWVON28yUGtuYlhHSWI0?=
 =?utf-8?B?Zno5a3gySkZMdkpIMjZ5UHdTam15ZFpKbE9qMzZlMW15RVhNRnBKVDRuV1Vq?=
 =?utf-8?B?aC9kaFJNdWpqci90R082cGtnNVd1Mkt1VFZrQzNVTHlyRkxWQytVaWRST3J4?=
 =?utf-8?B?U3lhVWEwWGc2UmFLZzVBRlBsalhwR1cwZlhWZGp6VmcrckJteEd2dzBoZmts?=
 =?utf-8?B?RHVJbUdCb3I0aU1YSlVNTExVWFZMeXN4K1ZSd2UzcENDeUpFV0ZQYVRKWHlU?=
 =?utf-8?B?Y091WnRsMkIzSFMrOTlnVWhqZW5zQUpRN21oMm54SWZ6WXYyWTZxRjd2Vkxw?=
 =?utf-8?B?UkNOSngzNzF2RGVaSDVyTUFTcGZONVI5WnNHRllZSkRHYWJCeGJNS0U3WVp2?=
 =?utf-8?B?aEMwdGxwYjI4MHAyeTVjNmo5Umw2S2xORXN4cHFxc3BFV0tiMDN5QmZHWjNp?=
 =?utf-8?B?UTBtZ08xRGNyeGRpS1VFN2dramZKTkVDZ0o1eEpPWXY0U0I0UkNnWUhER2ZV?=
 =?utf-8?B?VkpYZjRTSHBiZzMrYXlDN1dDdHdDcjl2ZzlqOWpZTHFoMThBK0FmcVNBZ0Rp?=
 =?utf-8?B?RmN4WHBodjg1dU96RVpFejVQN1ZGVTdZL0syQ0lrYzBVV0dtTitROGRpTjI0?=
 =?utf-8?B?NzBmNGlhMDZjdHFZYXh1Wnc5NXhXUmh6OEIrOUo1RURGWDUyRHhPWmZhVEZU?=
 =?utf-8?B?Zm5CM1F1RDFBU3gzNENxZnJycnZWdnNUYmt6TEluUldGTE9MRFZvVEZHdTE5?=
 =?utf-8?B?Q1RscGc5R3p6VnNKZmtzSWhMcXdOZjU4V2xlQ1dQemhpZXd4MFNjSlM1MEh5?=
 =?utf-8?B?c3BKYzRZSTg0QlkzaFZjejdYTG40Zml5MFNZRmk1bWtISTN5N2FUWlRCelFN?=
 =?utf-8?B?R0VDZTVDS1gza2FoemxxWU9BN281RHBhZGdDSENqV3l4Y3ZObE02Q095UWNk?=
 =?utf-8?B?UUhUZWlHVkl4TXRJK2xXN20zNXZBb1doRGQ0MlN4KzRvSVZQanA2Yi9KOUx5?=
 =?utf-8?Q?d5/BKJeIQViLdyGWnTVKa4/I5?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22176f5-1af4-406a-c156-08dcf9d803ad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:15:35.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMIb0YWx7L5HjFblWsavS99mAEZvtBJHyNsaqMOxNSJGYnynJ156Crkx12I+Zwm96Gny0a1cKQJEHA7ySCtURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5139
X-Proofpoint-ORIG-GUID: YLeuk7WCHBw3p7QIRlA9_PkaMA5BFiop
X-Proofpoint-GUID: YLeuk7WCHBw3p7QIRlA9_PkaMA5BFiop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi,

> 
> Notes:
>       Changes in v2:
>       * Whitespace
> 
>    drivers/dma/sun4i-dma.c | 138 ++++++++++++++++++++++++++++++----------
>    1 file changed, 106 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 2e7f9b07fdd2..d472f57a39ea 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -13,6 +13,7 @@
>    #include <linux/interrupt.h>
>    #include <linux/module.h>
>    #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>    #include <linux/platform_device.h>
>    #include <linux/slab.h>
>    #include <linux/spinlock.h>
> @@ -31,6 +32,8 @@
>    #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>    #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
>    
> +#define SUN4I_MAX_BURST	8
> +
>    /** Normal DMA register values **/
>    
>    /* Normal DMA source/destination data request type values */
> @@ -132,6 +135,32 @@
>    #define SUN4I_DDMA_MAX_SEG_SIZE		SZ_16M
>    #define SUN4I_DMA_MAX_SEG_SIZE		SUN4I_NDMA_MAX_SEG_SIZE
>    
> +/*
> + * Hardware channels / ports representation
> + *
> + * The hardware is used in several SoCs, with differing numbers
> + * of channels and endpoints. This structure ties those numbers
> + * to a certain compatible string.
> + */
> +struct sun4i_dma_config {
> +	u32 ndma_nr_max_channels;
> +	u32 ndma_nr_max_vchans;
> +
> +	u32 ddma_nr_max_channels;
> +	u32 ddma_nr_max_vchans;
> +
> +	u32 dma_nr_max_channels;
> +
> +	void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
> +	void (*set_src_data_width)(u32 *p_cfg, s8 data_width);
> +	int (*convert_burst)(u32 maxburst);
> +
> +	u8 ndma_drq_sdram;
> +	u8 ddma_drq_sdram;
> +
> +	u8 max_burst;
> +};
> +
>    struct sun4i_dma_pchan {
>    	/* Register base of channel */
>    	void __iomem			*base;
> @@ -170,7 +199,7 @@ struct sun4i_dma_contract {
>    };
>    
>    struct sun4i_dma_dev {
> -	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);

Is this macro "SUN4I_DMA_NR_MAX_CHANNELS" referenced elsewhere? If it’s 
not in use, can we clean it up?

> +	unsigned long *pchans_used;
>    	struct dma_device		slave;
>    	struct sun4i_dma_pchan		*pchans;
>    	struct sun4i_dma_vchan		*vchans;
> @@ -178,6 +207,7 @@ struct sun4i_dma_dev {
>    	struct clk			*clk;
>    	int				irq;
>    	spinlock_t			lock;
> +	const struct sun4i_dma_config *cfg;
>    };
>    
>    static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -200,7 +230,17 @@ static struct device *chan2dev(struct dma_chan *chan)
>    	return &chan->dev->device;
>    }
>    
> -static int convert_burst(u32 maxburst)
> +static void set_dst_data_width_a10(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(data_width);
> +}
> +
> +static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
> +}
> +
> +static int convert_burst_a10(u32 maxburst)
>    {
>    	if (maxburst > 8)
>    		return -EINVAL;
> @@ -233,15 +273,15 @@ static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
>    	int i, max;
>    
>    	/*
> -	 * pchans 0-SUN4I_NDMA_NR_MAX_CHANNELS are normal, and
> -	 * SUN4I_NDMA_NR_MAX_CHANNELS+ are dedicated ones
> +	 * pchans 0-priv->cfg->ndma_nr_max_channels are normal, and
> +	 * priv->cfg->ndma_nr_max_channels+ are dedicated ones
>    	 */
>    	if (vchan->is_dedicated) {
> -		i = SUN4I_NDMA_NR_MAX_CHANNELS;
> -		max = SUN4I_DMA_NR_MAX_CHANNELS;
> +		i = priv->cfg->ndma_nr_max_channels;
> +		max = priv->cfg->dma_nr_max_channels;
>    	} else {
>    		i = 0;
> -		max = SUN4I_NDMA_NR_MAX_CHANNELS;
> +		max = priv->cfg->ndma_nr_max_channels;
>    	}
>    
>    	spin_lock_irqsave(&priv->lock, flags);
> @@ -444,6 +484,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    		      size_t len, struct dma_slave_config *sconfig,
>    		      enum dma_transfer_direction direction)
>    {
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
>    	struct sun4i_dma_promise *promise;
>    	int ret;
>    
> @@ -467,13 +508,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    		sconfig->src_addr_width, sconfig->dst_addr_width);
>    
>    	/* Source burst */
> -	ret = convert_burst(sconfig->src_maxburst);
> +	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
>    	if (ret < 0)
>    		goto fail;
>    	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
>    
>    	/* Destination burst */
> -	ret = convert_burst(sconfig->dst_maxburst);
> +	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
>    	if (ret < 0)
>    		goto fail;
>    	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
> @@ -482,13 +523,13 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    	ret = convert_buswidth(sconfig->src_addr_width);
>    	if (ret < 0)
>    		goto fail;
> -	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
> +	priv->cfg->set_src_data_width(&promise->cfg, ret);
>    
>    	/* Destination bus width */
>    	ret = convert_buswidth(sconfig->dst_addr_width);
>    	if (ret < 0)
>    		goto fail;
> -	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
> +	priv->cfg->set_dst_data_width(&promise->cfg, ret);
>    
>    	return promise;
>    
> @@ -510,6 +551,7 @@ static struct sun4i_dma_promise *
>    generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    		      size_t len, struct dma_slave_config *sconfig)
>    {
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
>    	struct sun4i_dma_promise *promise;
>    	int ret;
>    
> @@ -524,13 +566,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    		SUN4I_DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
>    
>    	/* Source burst */
> -	ret = convert_burst(sconfig->src_maxburst);
> +	ret = priv->cfg->convert_burst(sconfig->src_maxburst);
>    	if (ret < 0)
>    		goto fail;
>    	promise->cfg |= SUN4I_DMA_CFG_SRC_BURST_LENGTH(ret);
>    
>    	/* Destination burst */
> -	ret = convert_burst(sconfig->dst_maxburst);
> +	ret = priv->cfg->convert_burst(sconfig->dst_maxburst);
>    	if (ret < 0)
>    		goto fail;
>    	promise->cfg |= SUN4I_DMA_CFG_DST_BURST_LENGTH(ret);
> @@ -539,13 +581,13 @@ generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>    	ret = convert_buswidth(sconfig->src_addr_width);
>    	if (ret < 0)
>    		goto fail;
> -	promise->cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(ret);
> +	priv->cfg->set_src_data_width(&promise->cfg, ret);
>    
>    	/* Destination bus width */
>    	ret = convert_buswidth(sconfig->dst_addr_width);
>    	if (ret < 0)
>    		goto fail;
> -	promise->cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(ret);
> +	priv->cfg->set_dst_data_width(&promise->cfg, ret);
>    
>    	return promise;
>    
> @@ -622,6 +664,7 @@ static struct dma_async_tx_descriptor *
>    sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
>    			  dma_addr_t src, size_t len, unsigned long flags)
>    {
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
>    	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>    	struct dma_slave_config *sconfig = &vchan->cfg;
>    	struct sun4i_dma_promise *promise;
> @@ -638,8 +681,8 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
>    	 */
>    	sconfig->src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>    	sconfig->dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -	sconfig->src_maxburst = 8;
> -	sconfig->dst_maxburst = 8;
> +	sconfig->src_maxburst = priv->cfg->max_burst;
> +	sconfig->dst_maxburst = priv->cfg->max_burst;
>    
>    	if (vchan->is_dedicated)
>    		promise = generate_ddma_promise(chan, src, dest, len, sconfig);
> @@ -654,11 +697,13 @@ sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
>    
>    	/* Configure memcpy mode */
>    	if (vchan->is_dedicated) {
> -		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM) |
> -				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_DDMA_DRQ_TYPE_SDRAM);
> +		promise->cfg |=
> +			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ddma_drq_sdram) |
> +			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ddma_drq_sdram);
>    	} else {
> -		promise->cfg |= SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
> -				SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
> +		promise->cfg |=
> +			SUN4I_DMA_CFG_SRC_DRQ_TYPE(priv->cfg->ndma_drq_sdram) |
> +			SUN4I_DMA_CFG_DST_DRQ_TYPE(priv->cfg->ndma_drq_sdram);
>    	}
>    
>    	/* Fill the contract with our only promise */
> @@ -673,6 +718,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>    			  size_t period_len, enum dma_transfer_direction dir,
>    			  unsigned long flags)
>    {
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
>    	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>    	struct dma_slave_config *sconfig = &vchan->cfg;
>    	struct sun4i_dma_promise *promise;
> @@ -696,11 +742,11 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>    	if (vchan->is_dedicated) {
>    		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
>    		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
> -		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
> +		ram_type = priv->cfg->ddma_drq_sdram;
>    	} else {
>    		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
>    		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
> -		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
> +		ram_type = priv->cfg->ndma_drq_sdram;
>    	}
>    
>    	if (dir == DMA_MEM_TO_DEV) {
> @@ -793,6 +839,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>    			unsigned int sg_len, enum dma_transfer_direction dir,
>    			unsigned long flags, void *context)
>    {
> +	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
>    	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
>    	struct dma_slave_config *sconfig = &vchan->cfg;
>    	struct sun4i_dma_promise *promise;
> @@ -818,11 +865,11 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>    	if (vchan->is_dedicated) {
>    		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
>    		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
> -		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
> +		ram_type = priv->cfg->ddma_drq_sdram;
>    	} else {
>    		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
>    		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
> -		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
> +		ram_type = priv->cfg->ndma_drq_sdram;
>    	}
>    
>    	if (dir == DMA_MEM_TO_DEV)
> @@ -1150,6 +1197,10 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>    	if (!priv)
>    		return -ENOMEM;
>    
> +	priv->cfg = of_device_get_match_data(&pdev->dev);
> +	if (!priv->cfg)
> +		return -ENODEV;
> +
>    	priv->base = devm_platform_ioremap_resource(pdev, 0);
>    	if (IS_ERR(priv->base))
>    		return PTR_ERR(priv->base);
> @@ -1197,23 +1248,26 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>    
>    	priv->slave.dev = &pdev->dev;
>    
> -	priv->pchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_CHANNELS,
> +	priv->pchans = devm_kcalloc(&pdev->dev, priv->cfg->dma_nr_max_channels,
>    				    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
>    	priv->vchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_VCHANS,
>    				    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
> -	if (!priv->vchans || !priv->pchans)
> +	priv->pchans_used = devm_kcalloc(&pdev->dev,
> +					 BITS_TO_LONGS(priv->cfg->dma_nr_max_channels),
> +					 sizeof(unsigned long), GFP_KERNEL);
> +	if (!priv->vchans || !priv->pchans || !priv->pchans_used)
>    		return -ENOMEM;
>    
>    	/*
> -	 * [0..SUN4I_NDMA_NR_MAX_CHANNELS) are normal pchans, and
> -	 * [SUN4I_NDMA_NR_MAX_CHANNELS..SUN4I_DMA_NR_MAX_CHANNELS) are
> +	 * [0..priv->cfg->ndma_nr_max_channels) are normal pchans, and
> +	 * [priv->cfg->ndma_nr_max_channels..priv->cfg->dma_nr_max_channels) are
>    	 * dedicated ones
>    	 */
> -	for (i = 0; i < SUN4I_NDMA_NR_MAX_CHANNELS; i++)
> +	for (i = 0; i < priv->cfg->ndma_nr_max_channels; i++)
>    		priv->pchans[i].base = priv->base +
>    			SUN4I_NDMA_CHANNEL_REG_BASE(i);
>    
> -	for (j = 0; i < SUN4I_DMA_NR_MAX_CHANNELS; i++, j++) {
> +	for (j = 0; i < priv->cfg->dma_nr_max_channels; i++, j++) {
>    		priv->pchans[i].base = priv->base +
>    			SUN4I_DDMA_CHANNEL_REG_BASE(j);
>    		priv->pchans[i].is_dedicated = 1;
> @@ -1284,8 +1338,28 @@ static void sun4i_dma_remove(struct platform_device *pdev)
>    	clk_disable_unprepare(priv->clk);
>    }
>    
> +static struct sun4i_dma_config sun4i_a10_dma_cfg = {
> +	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
> +	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
> +
> +	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
> +	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
> +
> +	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS +
> +		SUN4I_DDMA_NR_MAX_CHANNELS,
> +

Or else use "SUN4I_DMA_NR_MAX_CHANNELS" here.

> +	.set_dst_data_width	= set_dst_data_width_a10,
> +	.set_src_data_width	= set_src_data_width_a10,
> +	.convert_burst		= convert_burst_a10,
> +
> +	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
> +	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
> +
> +	.max_burst		= SUN4I_MAX_BURST,
> +};
> +
>    static const struct of_device_id sun4i_dma_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-dma" },
> +	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
>    	{ /* sentinel */ },
>    };
>    MODULE_DEVICE_TABLE(of, sun4i_dma_match);
> -- 
> 2.34.1
> 
> 
> 


