Return-Path: <dmaengine+bounces-6543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A39B59DFD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697AD1C02326
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7927FD48;
	Tue, 16 Sep 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G323BBJ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G3x3BEAV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E931E8A6;
	Tue, 16 Sep 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041027; cv=fail; b=R8NoYMkTCQCD5KxTcm8NnTFlaby6BEkNvd4hK9g5rBtJUDadk0GFWaJMV9Yft3H7O6mbUD1EeEx13/R6VlLwgKPAy4BnymuJNKenlABY4TQ4gK3kMPs1EMwkS2gP/Rw99ZUFCul7K8RflFSMyobuiiUibyEztbVDQdqjKhGNSS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041027; c=relaxed/simple;
	bh=KK20OrCSqsISOCziR0MLgghN2cDf4ARyduPZSdjJ8/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HzM/mwrG/LFX48d4Lzx4trJ22W+piyLlbvv7fWWfNbLDMKZ5/cu25tiQqpGEJBR/u5B7o/ZeQxzNFz9qdgOmafMvwPvaP3Rm1b1C15wgqVUgwZAxbr/eG+vPPP/6vg8Me3xac2RpTWa74hFQIJiiQNX4iRZo7dWRXV5vj2ByIuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G323BBJ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G3x3BEAV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGNDv8013873;
	Tue, 16 Sep 2025 16:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pg4pFm4FOy0fi4TxXc72Hhq2/+TTeJQdliUiWcq2q7Y=; b=
	G323BBJ3M8ZNlKqbnHm7+61eNPeYMOJBCf/5NqktczaFKGiY8230AUCru57AZgiH
	zrSP6nwSywfrK+VN/oxY/Qic7lOyOvO6KScLkX2ChepPlyn+VCP4HfRcRnOvCD10
	KwWPTxRbsY7nzu3eZdj+uEkR5gP4a0nN98bx2boBJLpGpX7y6RLJ+lL+Ll6pKTnr
	wZgeoAlQkDQqDNGa2IeEL89wf8V3CK/hB1UW57nwfbqd7ydKgOo66ZPh9WUL/fr1
	X7ITtkVXA6AmupP1+bxnB/nPy+vHkq8C6VH0bWr/YGGMZtBo5JewabLV+mdGQmz5
	XtrZotCLUYBcGrBqom7gog==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd54vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 16:43:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GFAUYx035128;
	Tue, 16 Sep 2025 16:43:39 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2jxmuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 16:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5zhOKGR0Nrof+9XiPZPZ8AxikCX5IcJrhPNkeHCbH/M1No+Clv1cubxLsxZQ3EuDXJTOXVT4GFPZOBs7vub9Sn2nbvEFrnjCPNhktnvDmVE5l2PtouZOvShcC4P2a8hY8cOw570Y79B7zEhboT4QvyOD/fzxTIYuSbrYD03plbJYxf1rwDWwmWApG+MvBuB+mljDHX+m1mS8fe8Us5MyYbd/4jFRy0TKpq+kj4QE1/A954/6zONU9Gu3KQbNZ7SlMRNVSvUAsDYIVnLgEM38XhGejXsil63qg5Dx5i9lU3GInjyhbFZpjR1KUijmdfKcoKeQcHBwrbuhSZKjPIEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg4pFm4FOy0fi4TxXc72Hhq2/+TTeJQdliUiWcq2q7Y=;
 b=FW5zYMzC6UWO9qXJ/7LNaK/KnWXohQnTA3oQ8hqa+1p51YfoOmzVe5a5S5iGwwHfkRz31WJXie+mgZNFryLhrfcneNl1EoHbcVeZl8krfUw6IXxdHDFVD7kLUKSB9uhZHaXttYj1TUaKUL9i22gC5M6KQRQLdXTwIYdyGvajeNMN+UofeO7GPpueyojzegyp37a3HFkmcCs2A6Tq6Vtw9sEfZ7Hakf1K5KOBnVy5L2jk27OMgq0LeONrjuDb4MadXitqiF25RdM6soidgJC6V81ZPqGUEUjg75o06yeRdFdn1dXb/7BK68LZdA0IDyRtygZum2ry+f1hK2udRXF7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg4pFm4FOy0fi4TxXc72Hhq2/+TTeJQdliUiWcq2q7Y=;
 b=G3x3BEAVEYZY0HcDO4NwxBK2k/8Z1yAcUtZU9w2Jus46DUzZkIKfQrPIQyTBR09Y2jS4T50PFguEQxubXQJMAy+KpsBfKuMqe9/QFG94KOXmwb9BWsJA9WfEk4uzrxLa+Ut5y1Jw0zaEB9Ym+P2G8rSgH2chdGqxWFaH0mwMQyA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB7737.namprd10.prod.outlook.com (2603:10b6:806:3a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 16:43:36 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 16:43:36 +0000
Message-ID: <50af8136-5433-4a2e-8490-b1d200969cf0@oracle.com>
Date: Tue, 16 Sep 2025 22:13:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver
 support
To: nathan.lynch@amd.com, Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f519eb0-c6dd-4e07-01d4-08ddf5402e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JHTmQ2emwveUhJN0JBSnJpYlp6MTIvbXBpU28rUk5EU3F5VkJaT3RsS0Nv?=
 =?utf-8?B?YmhJcUp4czVLR1VFb1ZkbWNKdDFraE1xMGlSNVhEWkR6VUtvejJIVnFmQmI5?=
 =?utf-8?B?dGpuTzh6VjkzUFo4TTV5YzFQWlpUMFFRT1J3Z0ZOU0pjNGFyM09rOXFkR0xZ?=
 =?utf-8?B?UmNpU3ZFbmFGa1gwQWZmL28xMyszcXhKbmExdVNPSmZHcDNBSHZZZkt5VmtX?=
 =?utf-8?B?U2xCZld3enZGSXN1MFd0alkzbDFxdUVaM2xuaUxKN01RbzBoQncwc3E1NHFR?=
 =?utf-8?B?QUticms0RmZHTmZGWmpTMmlnYnprLzRRclhuZjg1Y1Y4OWZNWVQvem5reEZX?=
 =?utf-8?B?TjdFQmlkTkp4YzFzeW5TUHBXTDc3WDNrK1gyaGo2N3FmaTMwakQ2LzRRekJJ?=
 =?utf-8?B?MEFjRTZVaWZPQWlPVk95eGVsZmZMR29nMTdybUFmRThpVHdrL0d2cVB6V3ZK?=
 =?utf-8?B?a1lYZHFDQzgybHVHZm9sRXMvQnUzTE1jbENaNGFlbGYyNU40RjV6Ty90c0t2?=
 =?utf-8?B?NE0rcmpKK1pwUnlvMXpxWVBHVklvU3hjSkxxdGsvcDZZSlYwYm9ud2RJdVFu?=
 =?utf-8?B?ejhaU0Q5UlJ3NXMzR0c4MG5yUW5kckxPU1BCYlc4cEdUbUlyd3A1RnNXUFNn?=
 =?utf-8?B?dFArd2dxV3cvRDBsOGhDcHJBSDFSdW5sdDU3Tm1XSm9QR1FzVXdqV0hwbnly?=
 =?utf-8?B?ZEtWYlcrYThjVTNjOXhpcHVXRXBuVTB4QUliTXUzSHpyRURCNGtCUTM5aWp5?=
 =?utf-8?B?NzdaNTJWQUdwQ0ZWLzFBTjV5TmVmRmdUZngyTTFjRGhxM0NkMVYrQWpFb090?=
 =?utf-8?B?d3NnNnlKZDkvSzF1MFVBRG5LempUZThObnUwSzNEczUzbnRZNVFNMkZUdFcv?=
 =?utf-8?B?WEgyb0J5QWR6YUFxZ0xTd0ZGd0pkZnpCNGxtZGpZT001SUprYyszcFNNaC84?=
 =?utf-8?B?NHV0dU91aU9XVldDbjVKby9LeEw2Snc2Qml6dS9ib2ovSUxIMGgyVEN6NjVs?=
 =?utf-8?B?REVkYlM3S09VSHJaMHNWM3hQV1VGbXAwc2xsMDZpSFZ5YUkxUDdlRVh5QVFz?=
 =?utf-8?B?RXlxSWk5OEI1elp0UmJXRUNrSW9CbWVWMnJkdVlQUUpEWkVhSHk3KzZiSnl2?=
 =?utf-8?B?K1lPNkdacG9QM1NDVktKQmp1eUpvQlZFOEQ0VUJBY2xSQWZCNitia3U5QTFt?=
 =?utf-8?B?b0lOazdxWG96TzltUi9pNzdXc0RjTGV6ZDhKR3JSbnR4UXFwMW5UTUFPWHpC?=
 =?utf-8?B?YVMwNW9aT2hjQWs0d0VjcFhmNG5vT1pUcVd6eUFNZUNyT0wxSENBM0N4cEJv?=
 =?utf-8?B?L0V6dEpSOTJPby9OR3ppVnF6aThNY3kzajhoVlpSQ1Vqc3ByNWZxbDNFdHRH?=
 =?utf-8?B?QjhnQTc1b3ZlcUdHUHQwbzBtNnlGM0NyYWJuL3NCM3pyblIrTUR5bktyMFBE?=
 =?utf-8?B?ekF6clNBRnQ4VGhkVnRqWmhrbndxcjgwakN1T1hxSHJZRy91V2lOTmZxYmpT?=
 =?utf-8?B?N1U5OVlySnZwVlNQQmp4b2RMblozb0JCVVJHdmFCOEZ1UjVralVhUThaR2lH?=
 =?utf-8?B?VVZrM1h3RlRlWWx1WHlNaHREUlhnK0E2S3oxa052cWZFMDhLRGZxVjUxUjh5?=
 =?utf-8?B?R2tjMTRZRXNrTG5jaVl4S2hNS2p2ZFNXU1RnZDNQbmFNOXdIY1MyOHdtYmVo?=
 =?utf-8?B?eitEcVhUUkVRdkRKa0JoVzN3MWJWSVA1emh4QjhqWFU3cDU2UWs0ZzFEM29Z?=
 =?utf-8?B?L3lzTWIvUElIb3BicUNvRzg3RmQyUEN5dE1FVi8zYW5CazNDYnUwSS9uZWJk?=
 =?utf-8?B?NjVkR05IRWhmb1VKdHUwZ01IMVhvMFEyUEpLa1ZubjNGdXFnamNQMkVTcnR4?=
 =?utf-8?B?bVF0bkw0eG9oeHFnbUxaRldmUm9oRitQSzJPSDRleVM3WFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEpSbmZMUzlCc2g5blMxZXJoUU5teDQxTjhrUE8ySE5taDlGTjhZQnFQVndJ?=
 =?utf-8?B?amsxLzBjdnczVzBkVlRrRGIwenBud3hxeUl0VEgxajh5RVEzdFpOMlJOSmlW?=
 =?utf-8?B?WVhVbUpCZ0pUeWJrMXBBOEdkanZvc2I4djE4Z0JHSTNQM3NOckFGUzVuVmRN?=
 =?utf-8?B?cEhQNk5jdjdMcU5vcHhDUUozK1I2cXJVNUZQUG5VcFZTS0xCRmYrbUt3dHJw?=
 =?utf-8?B?eUZIQmNwcnNXZ0c1QlBJTUxHU0k5amh0ODN4NWVpMDBaWE4rVTRVeXUwV1FV?=
 =?utf-8?B?Q3haT3hkQ1lncVFjUDFqSDRTYVBQd3p5amdKUmYzR05qYkRKOC9KRzJCb2RP?=
 =?utf-8?B?RTVveWhKWUFoWFFCc1pGazcvcUpSQm82S2ZSTFZZc1FjellRSXN3MWU4SUM1?=
 =?utf-8?B?TDVmcFNxTDlxZElIdVlFSTExcTVJNGg1MzBKZldlSzA2Y3oySEJ1ZnBaTXVH?=
 =?utf-8?B?cldYaG1jZnB1ZTR5SWw5dWpPcEh0TWM1SS9yNEN5OGw4cjY5amsyRlJxY01M?=
 =?utf-8?B?N2pnWmZLNzRmVkJDU0IzR2Rxcy96OWFabS8rZjBGVkZCeGtpWVc4c2tPUjVy?=
 =?utf-8?B?d3Fnd05XZmZFcklEMGRYcUpHcnJ2NlQ3MGZDMUxYSWlOWlJONjZDZ0RIK09w?=
 =?utf-8?B?OWxyRk9id2RpMXJFYnRndk1EUUo1K21zcFQrODUvOTNNc2QvK3pldHFyamxF?=
 =?utf-8?B?UVFmNitZc3pUdmxYT0FuODk0aEI5N1NTaTkrQUtweFA3UWtNOE93SFBrV2xJ?=
 =?utf-8?B?NUtaZFhOcFV6VjF0MGxKL2pEbWI4MWsxOXJuZEtwVER0OSsxRlFNWlVBaFZ2?=
 =?utf-8?B?WFRINGhZUGtMaEEzSGM5aFkrUzZ0TlkySmxXeFhDcGpHNUdKRXNGTU00KzNj?=
 =?utf-8?B?dnFseUw3VnBEaUhxZlNvblNGREw1QkhnZ3ZPMU00cDNnczRXYUR5TGltcXpo?=
 =?utf-8?B?Y1NOTStQbnpKYWFGcDR6K05hbW1WWU9MbGtSQyt6RW8vb3B0V2lXREZHTU1r?=
 =?utf-8?B?azZhcmZuTnd0Um1rMDBISGV3SlJmaFdod09ROEx3dU1COGQvZFFpUUZWRmU3?=
 =?utf-8?B?V1pXZWd4MGhVZ2dSY01XNzJ2NERwdHVrdytTc3FNblZPVStveGMwMVFsOUQ0?=
 =?utf-8?B?Rk5oVE91blFQSVlCWk9Mb0VoQTBtbHJ1aytjZWh3dzJja1cwRERITWNGakdu?=
 =?utf-8?B?ZEVNc1k1QmlpWGNBY0k1NjBtQmxIL1pMOUMyd1R6ek1mNmxnR1pSeHRLLzRE?=
 =?utf-8?B?TDJCb1ppMHdObms0TUhWZCtqenJqZFFURTZsV216WHo4Vld6V1VESjFVejNW?=
 =?utf-8?B?cnVMNWtHNVlQSDJmK25PTUsvakNrcXpXSlVYOGZRSUt2TVQzQy9CVG5LNDRI?=
 =?utf-8?B?K0dVdE1KWjVtTmhBeS9hUjRCU2xSR1dmVnNldTVVa1hJZFZqTHUwTFZIUFZL?=
 =?utf-8?B?aWVDWnBIVVFaaUZvU05tcVNybHJqQ0MvZWNndWpiVUpwZGVmVi9sY0FJb3Y4?=
 =?utf-8?B?TEhWRFdVaVNjdi9jdkpHZGxVb0wzbytXYlNqQjE3K3BGWXdmcUVnVGQvc1ht?=
 =?utf-8?B?bWlZQVZhd3JRK3E1akpYOEcxd1QxTkltSDFZczFCNnMweUdTKyt4YTd3Wm5a?=
 =?utf-8?B?UXd4SlVkN1ZMYThkRGFSbEhIOEFPS0xuTG5CNkpMQ0NhUVlET3hxOW5hMUZZ?=
 =?utf-8?B?VTNvZ1BVbXNhbDNPZndFeWplK1R0NmlqZDdpdFNuM1VScnVjZzg2bEROSVBW?=
 =?utf-8?B?MjJoUFJ4UEVkSFdGNWRaRkdHRlZHK252VkdYc29SYVJLR1BOVTlpRTRFWmty?=
 =?utf-8?B?cFdqRlZROEhSbWh3dnpvZ29vQi8rdFI1aHZkT0FDQmt2QXJSR0xiUDhKVVFX?=
 =?utf-8?B?bnlQemdTZVVCem03YlBIZnZsRGdOV1lOYmtjcHpCQ2hNRzk2UmZ3cVFXZ21M?=
 =?utf-8?B?dkx6N1A0azJNcEI5U0pmTHBIM2syM3lzdk1SN1VmcmtoSStsb0FoUzZ5dXVj?=
 =?utf-8?B?U1RoVlc4ZUpWTXNaa05ZRm9qU2ZCeXlQNGpMc3dCVm8rcWpQeEtXZ2VsVGlR?=
 =?utf-8?B?WVVzYUdvK3k1K3lXRDFpaWZFUU42TEIxNGpOaDRoZk9wRDVsVGp4Y0JpYldi?=
 =?utf-8?Q?yhbB7np3Jn66lAAXO8rCSGZiy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bTzVll2FJjRP8fjwAYrUnjvdqcVQJLkG6RE/u2uSAVqzCXlXzIOKvSIl+Mf5M5qbBd+0GuzRB7OU9BIlihFzF7L2UJIDAmfZdIlJsldZlPgzelaAXH3H05eJCz/NkJKh9OZcheLidi28Y1CEefR7zg4GOgE2VK570z8BSb/Kp/YgVbX7RW19UWKX2NTdTiXG5UVysiJ9lVPQ9cjPKDsV8g3/6oEhgLEyPNbrvwrtvWe8sntC1+4hmxI6UYOhWKIlzGpkpZtcPatgUurGK77zZ954q7crqdqVqXWWtoPfiLHBMfRKXiDc/s7dW5+ib4IQfl4UyZtIjbBDx4sriMPjVloN22vdXfll4itQa/7u5d5TTksT4tVDvSYM7TwiYOv2lGUxcEyHs89kcSbCQ9A0N/PlkNpCt5nZ1A2ZVLOIWzyNm1Mju+o2sqGuYOceA1ERUgfUquUd12x4Ie/Gbb0pMkQlySdRTVfsaHrhKNm4uQ0bjFldAVznCwEAKmHl/AY5Hju/gXpM/Zj1ag/z6I6kcfQX65LyxyjTEuILgEAubRsmcD4339V18el3Xv3Vl4EHCb0sldpBPxFi/1P44o89ZGgIM8NfgTQhFEZsufFaQ1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f519eb0-c6dd-4e07-01d4-08ddf5402e6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:43:36.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsMD9NxS4o1MASz3tNc/V9MgSJ0BU4gN7PYNKMrfBxin0ECgoYP9Ta88dLhqPz0/TUSrmfYBGvOOlIDhLWJmlo0rk++5/0F/0yH9l7b9N1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX6XK4WGwW+Qlb
 uIbAm1Aw8AUtHcPqWCCkUYHMIaaxZKsE5pMT8ppARAVZ9pKAmLof5C3ejhD1IfbXlc8bTNaL/On
 9Gw8KqfMcMfv6XuE2Yz4TGh/519P6aDDKVs4ADB4NUcOr6cMmzqKtcG+S6d+oU1xEHeIRbmFBib
 jkQK+vci6RO6LtmpKB4HTDttEXg7Bu++fPFWVzRURs/3nX5aP+/DWvS8dhdKFu/qKU7HkINbMB+
 VP6LnzNoq5Laye88bhRFGq7gq7IJu8Iohh9NAKMyAHMOGF2pN3nomwo9QNZYJLdvJYzIAeMbepj
 LpkiSETUal5cSNs1sLXFWI5xMqGrMrBlca05m/kHYNQvjqHJhv9OT9yiURDtnNCKNznuq/CchY5
 1RJqeM6kxyRqT6XplmIRCvM7ZXS/Mg==
X-Proofpoint-ORIG-GUID: mX3L3ThikReJAO8Y7AfUk0rDcXbW5L1L
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c993bc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=gqGgUjZnPQIA0dfnAFwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: mX3L3ThikReJAO8Y7AfUk0rDcXbW5L1L



On 9/6/2025 12:18 AM, Nathan Lynch via B4 Relay wrote:
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

typo pcim_enbale_device -> pcim_enable_device

> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
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


Thanks,
Alok

