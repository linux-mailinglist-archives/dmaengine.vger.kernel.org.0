Return-Path: <dmaengine+bounces-4517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A866A3A887
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 21:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C599116F118
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6991B0439;
	Tue, 18 Feb 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bj3n5VTm"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FD21B9E0;
	Tue, 18 Feb 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910018; cv=fail; b=OuYfK5ZxJ1m/ldFoH06xxjVVKmYAzF8k25vYUzYI0fg1bpayDU480prOBzhf/rVQYGidTHyIcL1ojP5zRgc35BGTT9+wJxNRRoi/QZ8SktCRcpq0uh/6/tohDQ3sQyvhQ7iZBn/NtGJ04gZ1MVhZiZgkuJcjYd/28mw57Y09Pas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910018; c=relaxed/simple;
	bh=HmxAqSb4b6MS9kOfKKiNLV9XJnM7iwwrJ+J5DKZ7DKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjX/tNA8TN3IVzfBjDlMin+H0G3ZQud/HC67EYv0vYiWNvAG4PACYZMlZ/GSx+sxhoVjiD3BIQRfj+AZfUtiD278vwR7iFOniEa1hGwt7AcWgLsOHQe8IAvo+mLZGHLS9iHah1R7mX07aYWNVJMx915tSOfFwNNTbS3AR0dVI4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bj3n5VTm; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCoCMSPmEpWtgzJEJCuYGKHQGRYHF1w4aLNZHbAaMEhMRmFHb9X/GgIHgvVX54OV0CTPd7LDDd1w2DrTNB+YU/7DYhkoffr5Y+PWcyORdrlbapxpwAbDrqNM1UoLmpR3HjvhHb8XZJAJyBa4kgBvEQgaVw+nGcIRE1RiYAH2ZKN3gKGlLAN+kKfb1TfyOu1eKpjG47TN4sUgaOBHPrqzIEqGLEX1Epa6Zb/xiUXA2/NOTxcGhvwRm+2c3WH0Wl5ZAKujeXJaojeNHDmwVTQyyUpYb9ET2H29NAQ99Q6SK6oOZ4t9d5th2SvexqWGElD2g2EdDYuDHsFs4NL/EmMkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SFzsr4pbKpN9tJSMhIi3XHtMa8iWdv/1G326BfJxRE=;
 b=WPdxbm3pqHwtF9EWhfPn37qs0W6daOHQg2/d4mG0XUXvZYX6DlCb+7yjtdUrD2k47qv3MabUvOMGJdol1BqNUyWz6BMBXG8wgvC/PLWlWG/9ml5A9KD/yJ/BvpGe6lKC0Xzm0TAGDRcrs11Y2crXvq1ZAJPppFkVN7kufTIhoVJbKWep0TGT8d4xM0OEl+hncU6nUa27Be8OhqiLqI2hOah5zyWzBYcs2818pJT8T6DRVrDdsbL+GBT36nqL5ck4Mccb8kHRgWjU6ZOU8oZ6bVnU7nUehi0Pkn6RFPAjaZZPAlCm25MnMToIonLeRD89HEXvcmRYw5f0KGjayF9qHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SFzsr4pbKpN9tJSMhIi3XHtMa8iWdv/1G326BfJxRE=;
 b=Bj3n5VTmjSaGvEym9drdNc/bKl0yHQ2AqUu1E/BCNgfYDIxtCXpDXazaxnG+14dgSTlG4QbLmQ2wFcFlKYoRFNqFcDDeD1F7xDR5iffa5nZb/ElZjYzFyGo52DWmJzgfPkN8Yi8aTXKxcMsVNSjWjkB85hk371O2HlYdZ3QJbkKIyUaY5cqJvdgMVIOeWRJ+gfgdOaKct5NWNcGJMup5tUhf3AYQWqnjKlvf1g0hNIl4Se0wpCdY+fQA2/2ShmrvATOy3g2Wa0JdJBl5cF1pwp5aqV3ypUMGPk3hKuRnhRxHuIFf/F9y4ZAVmBSOHH+Um+ihsBjLMuky4A3l9oQ1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 20:20:08 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 20:20:08 +0000
Message-ID: <693fe8b5-ff99-4363-8c9d-9641ad24ba10@nvidia.com>
Date: Tue, 18 Feb 2025 12:20:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_groups
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250215054431.55747-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bf714e-0f8f-453d-3513-08dd5059a39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWNtTFY3U0U4amlIelliMnBQMXYyV3YyQkhMcXZEWXJaZjFQdWltWFFEYnRP?=
 =?utf-8?B?WC9UeVF6QisrUmtWWjlmRWtFWEQwbitqNklTWXNBRVUxSHZMUTA4TnJEQ282?=
 =?utf-8?B?dlQ2aTNnaVlzUy9vb3RoRmtFbzF1bEdVS0tyYXhPdzRNdlhBSGdPZFdSMGh6?=
 =?utf-8?B?RGoxOEtTZXVGMUV4U2ZURXVGcFNuZ21YRG5YS0QxcXpzOTZuK1hXTFRtWjl6?=
 =?utf-8?B?enM3S0RycUNvdnBoczJBdjF5R1BBODRDNVVoQ01rMDM4SUU2UE9yU0hjY0NS?=
 =?utf-8?B?SHoyVDY0amZ4R0NsQjlxNWFjdFhSVEo3bDlSVzdCenQ1Z2VRcEdydVZXcE1F?=
 =?utf-8?B?bXM2ZTQ5aklTU0hZVzYyY3hwcmQzb2dIYS9sSTREZHdUMUgrck81U3RBTmwz?=
 =?utf-8?B?dVFPYzI0aHRkU09xZEhnMTlEY0RTWk9aSEd3cG9YVlhuQXJQczVjanZnTFdF?=
 =?utf-8?B?SCtHQjJXbm9ub0VjTUtpMDBwb004b2ZnRFpodUJZT0IwZmxKUjBvZXRPS0hJ?=
 =?utf-8?B?cUZObnlXbC8vTWNhSXl4VUNTT0VNOGpWbk9kUFNQRHF0TUduaU90ZE5heGZQ?=
 =?utf-8?B?TXdYa0FKTXNqZ05EOVdXY0c4THl0VnQycyt6TzB0bnBDbWVvSzRSS1NXOHNP?=
 =?utf-8?B?UDhRbEhUYnArVmI1ZjZkWCtRN0NUd09hTmJoL3k2UHVSK0V5b2d4a243VEJh?=
 =?utf-8?B?ZFJxU2liVmJRVlhlTkdHaG1UejVWNWpFbmk5TC9UR3h1cEUxM1l0bUh6TVMr?=
 =?utf-8?B?SVhMSjV3UUdNd2V1ZzlBQWVZelVSSGpxMllRTXkzRVV0OU0wendSMTdycFNr?=
 =?utf-8?B?emVjVnlxY2Z5YjhjT0tYaDBhS29MemgybURxRzR3K2FJcHlzZFVzR2kySUNJ?=
 =?utf-8?B?ZWtNeVpaTThtbjNJUm96YTh3QjBUSU83RGJkZUpNTDNNRnRQK1pjL0FvNW9y?=
 =?utf-8?B?OUVvOERtV2s5WGpqVmVHaHYrbU1NbmVUNExPRXJpc2Z6elhBMDI3UHlyUHZU?=
 =?utf-8?B?Q3RWS0IvUkp0T2VYOHVpTWFUNTBJNHZtL0ZXSHJuYVVoQW9CSTNYb095TWdJ?=
 =?utf-8?B?NWkrdUhkQ0p0RW5rQVFYRHczcm1mRTBFbThwMU0raDZYMnhTUVB1VTgyRE5t?=
 =?utf-8?B?VkMyK0JsSG1zdGhyMXJWV3BkT0N4VFNTbFJPUXNhcVU1Rk1JNVB3cG5vUHdo?=
 =?utf-8?B?bUxyQzNFY2ZJT0I4YXJpa3VkMDF4VDZBRzJjSW1oRHpLYWdiMWE1Q3I5OUV2?=
 =?utf-8?B?T0NzeC9sakUvSURpcHpZd0Q5WFlkNzRPTGV2cnV4OWJ6ZlZyWVpJaUo4OEdO?=
 =?utf-8?B?dXN5WDdHWndlWlNGUEU4cUo0SVBzSzREcGNYeE5CRWduU3Izbi8wZnFzNldS?=
 =?utf-8?B?ZWdOdzVva2taR2Z1SzhwZUJBVGYxOFNXcmx3K1hLS3BxakU3ZnZMV0tRU2Vt?=
 =?utf-8?B?eGFjM0VUc0JFM25QdWR4VkRtZkFqY1FIVlM4Ujhtc3lBbkFrQzVIdnRlMGpS?=
 =?utf-8?B?RW8wNWV4UGhLUTZsdnFKdGNFTXVHMDBqZmgxTFFOMG1MRkQrVlVpYXRNbkhL?=
 =?utf-8?B?L1ZQNjNuRFpTNkRYak9Nd2NwbGdhQndHL0tySnBDK3F2UWdSK24ycnFXRUlk?=
 =?utf-8?B?UlVFZUF6blplR2VmQncyVjFQSVdBdEdjWmdtNmxkbGZGYjFncWhmRFV2dkpx?=
 =?utf-8?B?SFpBQ3BkMmhjYnh3VlpYVmcyYVBGL0Rya1loankyNUdDTnljYUdtcWRJbndP?=
 =?utf-8?B?R3daTlZjdDNaVUhwdFBRWEk5RTFQOHd5Qm9XamZ3U0VYbkcydzdQWWFMRC9E?=
 =?utf-8?B?ZFc1MTMxS0d0bFdGUDdLYUFPUDA3RE9oVzEwbWw2b1dFUVovRlVnd2V6N0VJ?=
 =?utf-8?Q?ez2/UXXrSCEfE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUkvUHVIZlVxc3gvbURmZDhhcklFaS92UFNYdDByS0pCMGs3OHh5Uk5OTFIv?=
 =?utf-8?B?eWdzNnYrUXJZRjI1V3ZJK2hpMERMZ2dFeEo1ZVJCTFg2MFVjMmxjQ2c3LzJW?=
 =?utf-8?B?dFZFb2VkK2hvc3lONU1ONVpJcEg1MGU0Q1pLam1NU2JDOGs4V3B6VGc5dDY5?=
 =?utf-8?B?cnNnWUcvc1RNNS9Xa0pUK3c1SVpyUGsrMHZKUEJFRnFybGdlMjVRa081L2tm?=
 =?utf-8?B?d2RndnNUc3dZdGtiTGpCckhpYTBZUGtLbVI0UC9zS0x1VnFOWUsybFNWcldX?=
 =?utf-8?B?V2Z4b24yYlFqMVAxU2lXb0tEOWtTTkVpMUNaSUIxRFI4b3d3K0U1a0J3NXda?=
 =?utf-8?B?Z090Wm5HSjE5K3lHcGdCTzlQaDR3T3RZS2doZjQybTUxc2tVNlYvQnlQMEtY?=
 =?utf-8?B?YkFRZWNBZ0VKZWJRNFZvMzl2amVTNXJxYktaWEdibHJad2p2T2RIOUpYZHZs?=
 =?utf-8?B?ZTRtN2xHNnMxWUs2RzllQ0lJdzNtK3JoUFFFSTBkaWhGb0VJZkwvMUVLRC9x?=
 =?utf-8?B?R29ra0w0dmc2R1V4bE03bkZ1T1h1Wmh5MFU2T2owdHJ6dkkrQWNRRXhVUkdE?=
 =?utf-8?B?ZGV5ZGZwT1R1VkZQK1V3bE5KKzZxbkNnNnlzeWpUN0lVVHQxTWpsTDRTSVJ1?=
 =?utf-8?B?Wnh1a01DRVhCVW82THdRY0g0QUZLNXVkbG1QbTc2ajNlcS90VGdPSGl5K2xG?=
 =?utf-8?B?RzlpR1RxeFpGQW56a1l4ZC8zSXVLZHBwSDFMUjVLMDZHU0VlZ1hrU1ltN0Zz?=
 =?utf-8?B?VzhaN2UyUFJUTkNDTHJLNjRBcWZYYkVhUVBrNU4vS3RsQ05hQlp5Q242Q1ky?=
 =?utf-8?B?dUQzY1UzVzlsc3YwVzJueklHaTZIakFmTTFhN1E4ZS9haTBYYjZnTXE0S1JN?=
 =?utf-8?B?N1pXeXdlTUtPZTlSejIzN3RYNmpyMGxzUDZucTN3UGdONDNCV1l6UU0rUkRM?=
 =?utf-8?B?RGtVZlZibGJTMHBHbkFkbmxxelBMWnN5U3czU05KNnNkZEhyQWRsOUViQlJy?=
 =?utf-8?B?Ti8wQjR4Zm4xemVIWTNQOUMvVjFJZkRGejAwbWxlUEp1N0NsSE9waDUrVjRP?=
 =?utf-8?B?aTBTb2xPUDZyUnNLbGZ1Y2lZRTBkVTY5bzBkR216Q2ZhQkVueEpTUzQ1YStU?=
 =?utf-8?B?eHlVYVMvbC93RWsrNHVsUCtSeWxWd3VsRG5mK0lwRCtWeXk4ZS9qQzVvNWk2?=
 =?utf-8?B?MkpIeVE4enYrQktNSVVHOFcvc3htcDk4S0JYeXBiWWVMRkZCWG1HdmRmYnJV?=
 =?utf-8?B?ZWtSNjR2WjcvVVhqSUhKbCtEWWp4b3JJTjY3REs1MjhNM1g0cGNyQnhENXFG?=
 =?utf-8?B?QVl2enpmRFFPT1VMU0ErY20rNVZwclB4YjduU2NtWW4yOXpjM3pWZWlYTWw2?=
 =?utf-8?B?YWdlRE5HNVY0Y2dlSzJzQzFmd2szYTBIMzkwd0tUUHU1QS9OcWprWXNTeUcr?=
 =?utf-8?B?NGo4MWNTOVpXMFpzMHJGYXlTRjhIUHdQTXFnWXVlVHpsR2xCenByOTY5bDhS?=
 =?utf-8?B?SnRLVWlyZ2wwWUppWitYa2FsMzlOVHorb3J0eVd6TitKS09pbXFPcnhONWVW?=
 =?utf-8?B?ekIzVnA5ZHpSVlZ6SkEzb2pXZzJjRndkRFZhV3ovUWZSeDNpSG9UelRRSFlO?=
 =?utf-8?B?b1NURVRXYUwzZ3R3QUZjL2p6aGdBTkxTNzV3bzRXbDE1cGtGaTJnVjBHL05v?=
 =?utf-8?B?cWl0NGpybEVtVzFncnVCdVRpODlMemtlbXUvdzBqTit4SmhQV1BSREhGL3Fo?=
 =?utf-8?B?QjZkbUFsUGhsd0p3ZXBVRlIwK1dETFJEbkVwTzhYSnk3U3hWdERydlljQmZN?=
 =?utf-8?B?aW1qMGdlTmZqVi9LWkRqMEYvdFJOMzJvSXNSTWFlQXhZdnQ1UytENTlkYnRz?=
 =?utf-8?B?WVdCQkExZ20rZzNkUzkwN0s1eENsL1NxVEpJOHN0bE9kOTdadHFqcWI4TU9F?=
 =?utf-8?B?M29VOTcrU1kxZCt1dmdmV2wzV2RJaUtYNTFSenlER1FaaTdDRW1ickFSS1F4?=
 =?utf-8?B?K3BNcjd3SENObHhiUU5LOWpoM3NLdEtvMTBXNWZDRm5NamxSTE5oQnpoY09o?=
 =?utf-8?B?bGo4RFkrU1Jja3RMZENDemN4Z2Y3RUszM0FPNFMyU0lNY3ZpYmd1WmhFVXNM?=
 =?utf-8?Q?QTLvlk4EVEts2oMHucppLfcgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bf714e-0f8f-453d-3513-08dd5059a39a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:20:08.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofjLrKkWQk3HZVQBCBAv2kTmmG4HXlpIPg52cLenOKxHQZUBrw/Xi9nDLewg4clYi9d+hclLuSr7SOxBBzkv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hi, Shuai,

On 2/14/25 21:44, Shuai Xue wrote:
> Memory allocated for groups is not freed if an error occurs during
> idxd_setup_groups(). To fix it, free the allocated memory in the reverse
> order of allocation before exiting the function in case of an error.
>
> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/idxd/init.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 4e47075c5bef..a2da68e6144d 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -328,6 +328,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>   		if (rc < 0) {
>   			put_device(conf_dev);
> +			kfree(group);
>   			goto err;
>   		}
>   
> @@ -352,7 +353,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>   	while (--i >= 0) {
>   		group = idxd->groups[i];
>   		put_device(group_confdev(group));
> +		kfree(group);
>   	}
> +	kfree(idxd->groups);
> +

What happens to the memory areas previously allocated for wqs and 
engines after idxd_setup_groups() fails? They need to be freed as well, 
but currently they are not.

Maybe a separate patch cleans up the previously allocated mem areas for 
wqs/engines/groups if there is any failure after the allocations?



>   	return rc;
>   }
>   

Thanks.


-Fenghua



