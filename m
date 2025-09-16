Return-Path: <dmaengine+bounces-6544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE339B59EC8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21657A191C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D56E2F5A12;
	Tue, 16 Sep 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rmiJnvE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wn/3nJha"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD532D5AD;
	Tue, 16 Sep 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042373; cv=fail; b=FqHuv3Z8UXRCSCefSmZFlJP6yezG/pmoAcxFJuZLf1HD2e5heqCe+Gqp33MouJlzhYXhnZm1lNg+SnM8zEGm2hmQqhKthh8LiR7DfhqtGXWjpwGgd55Ny2RqB66+22HGiLJnJy3zQO5h6j37pFD1xuFyb6LpSns6OxVTfP4GePE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042373; c=relaxed/simple;
	bh=pqeT79DxyLtyFY4XSFY6SzKIanVjrDTXsXtjmU79r6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ndTVqfndJ5+7qg2O9Z8vNR4Nhu7EC/MyRhpoc6FoPNgHaOV8Lub8jWXoXEAfUZvcPyVvqjgL2Rj039lfiekSJO7JZBXsLkamkmBoq5OzV/ows3SG5nzmDROdxNFzVR4CnzaxLO5Jx98ZdHccpY7fdGcEfWZF2TFJH0G5tkhtIsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rmiJnvE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wn/3nJha; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGNIIk025423;
	Tue, 16 Sep 2025 17:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R49X8Rl8hu0IV6Zkv1XCEQw+XWv7dgdw/nOT7Bg9fhA=; b=
	rmiJnvE+hGNHt/CaSSQfBQ0RqwMpFaaZKpPj0m2ZrI6B159kANpBQ7r4l8e/qWyC
	N2B+jPvDGFiXXq96Rg38EFJON3s1kmSDD8yZNWROe3Qw2+FIcJGIbsOyD3qQnef8
	YuLKBv+kbYofKKaiKkZP+A/UEKupaS55Gp32T3Y2rwAK9+YkInGxqCpT9eIOdfXm
	UKWpUvs0HdaoxF9Dh0VNqGrnfj1FQ/X/zba6jFI7NN3rsN+Wjs2AnhcwQVT/h+UH
	DfMq/w6NSEMz0FDC14CxWHvzky5IBx/MlihCZX8866+dUD77e2jvkTX9vgTF6x06
	Rh7T5LVkqOGldBfhYZFD2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v52x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:06:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGVgK4036776;
	Tue, 16 Sep 2025 17:05:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cptj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm+SS3glLG7b2j5W+mZTNzy5FCjcaF+aiGBaBoulrKKmnzX8LFCSy+ruGT+eQ52hGkwjwl/2R0PckY6bIb2NUBrUCErBkT5hDiqRYNyb+cZZPnyMaPFLCeu9Bzn0BEr3kRFcbEicol8md+Esh/ExZPXhw+DGiVDfYll/Ztxpfu4VZVopbFcX7eN/AcXLjAZCvN/N0u7hOk2Ou4bnxZvEJnNrlqP3Woc+IwkKIlUvYOqJ8XLDtWiF1Gko+v5BCzC0DU9fIRZnT9W+/MJ8H8Z5d8OdrcShax5NTDBGSACvcPDpFRhgIJZFelkGeItJ9qX8dSSvl7TW3ieZ8iepkgPBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R49X8Rl8hu0IV6Zkv1XCEQw+XWv7dgdw/nOT7Bg9fhA=;
 b=TLIObiUlII/PAwimeNTpB2e6HoNHOcCpclqldZJzB820DCvPLrlmLZQA8UtCqfw638G2oA2uZy5S8k+6L4EkrwnftWIWzaL9AMjQprC8XecVv8Oow/bstjOSZYzAX9XALFlORs5js27t8x+gaAkz9jOzAcCji8ubzKzie7uaTB62Oklq9KBSLXb6NH/VmQOmaZ0nCEFpqvFIitzwwoFr5ZR72w+iTPp2JACVgffYmm8AXWLlaczcWPW+5/Gxh0v1ehXJtjaRS38hyUwti1dHA7VCSqwcr56l5jjibTW/LWJISBXnczmSjDEmrtVrdp2Q/g5xR6oXOLV2Bc2m4ZppZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R49X8Rl8hu0IV6Zkv1XCEQw+XWv7dgdw/nOT7Bg9fhA=;
 b=wn/3nJhatvLl5plAsu5od7s7rOG+SHqR5JiRLSYxK2mBwjOOysGktBUr9ygM+CRqlwQD+DrQy7dg8KRba9gBiTBcDGNObMcO6M6ACxFzi0Ri4iKh5R4IbdjStwneyNIqR0uXNMLRsrsH2aUEfTaYVA/6Kfx4MCI30cjDXR42exo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 17:05:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 17:05:55 +0000
Message-ID: <be1e6979-135a-4b6b-9149-c037e1e1b10f@oracle.com>
Date: Tue, 16 Sep 2025 22:35:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH RFC 07/13] dmaengine: sdxi: Import descriptor
 enqueue code from spec
To: nathan.lynch@amd.com, Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-7-d0341a1292ba@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250905-sdxi-base-v1-7-d0341a1292ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 057c15d6-19ef-4440-0269-08ddf5434c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1FQY1RsUTBzU3E4QzY2bnNWcWYxUCtOK0RrU2JMUk9vSjlLUU9yVExHcnJk?=
 =?utf-8?B?YStHQlEvQUtwWmVOSjdqZUlSRlNRbUdXWG9CQWZLc2tmYm91Y29QbHA1SERy?=
 =?utf-8?B?V0JxVWF4N3Eyc2RVcFd1OWcwVXA2M3ZHTTYwTE8rQWY1K3RNOTFERUU4dzlx?=
 =?utf-8?B?bFRQMEJkOU5DNHpkRndxazNyb2lZc2pJdnk3eWRuNEpSeFkvZEJGaGtENDlU?=
 =?utf-8?B?S3d3K2JybEhpTnhaSjd0RHJOVnRZbitwVU4vd3gzdVNpeVNmN0dtTS94SjNG?=
 =?utf-8?B?dVhvQlJFUFk5Z0g2cFlDcWp5VGN4M3dvaHlCWmhQYThEZDFVK0M3STUzem1o?=
 =?utf-8?B?UFkxVVlBVzBBL2E4NEkyaXN1UXVKVDBwVkxlZ2NRb3hnWCtlbGdUR2RaVk52?=
 =?utf-8?B?d3I5UHRsM2pPbjZ5RWhvWkpQVTNqMlhwR2RZTVMyVHNIVlJLOThHK1BlbzVM?=
 =?utf-8?B?bHFNN2s4VmdUbUg1cXhaNjZEQjYyNU9EU3NZTHRyRFBkc0dMVnBxOUM0V0k3?=
 =?utf-8?B?RFByWlBwWjNqWFZCN3dwWGdIRTFFTldBb2FjNzBPcXpOSkl4c2QxbHh3K0tn?=
 =?utf-8?B?K0xuOXhHblJENVhEVHpST2h4Q0lQZGVOdnZHQUpwWlNXWFE3aklvaGZRZXlP?=
 =?utf-8?B?VUtKS0NVTU1OTTFTdm13bmZDc3dWZHNYSUwzQTRuK3ZSNXRWMG8rOFlpUTl4?=
 =?utf-8?B?a0ExMXBhS2sxMmpnNjRJMVFFZENLY1NDVXlqOCtOWDhLbDdBcnFDa0dKQ0tj?=
 =?utf-8?B?Q1FvMlFXeXVzd1FRYzlBRUVpL0xpMlozazlyc1VMY0MrQVBUbWdwbVp5bFE1?=
 =?utf-8?B?Y21pR1BhR2xRaHFuWFpldHhXOWxTMzFqSlV0WnhmMm40QUNPVXk5RkRxK3Bj?=
 =?utf-8?B?ME1lVVovK3AwN2NmU1grOFI3R1BNWEdscFROU3Y3T053M1hwaEZtOUJ6VEhj?=
 =?utf-8?B?YWhGTVhkc0szYmZGVDVCVHc3QTZJbXJnS1k1QVY3L0xpRkxuc1RWRndyQWNZ?=
 =?utf-8?B?ZWYzeGM0OXdZNElaRzZ1ZGdXUjNkcGlXNHg1NG9rb2o4ekliNmpFenpKUEtC?=
 =?utf-8?B?Q0RCdkh2N0ZCbzNhM3oyRysyajRqdXlqcG1nYlhNeDN1MFBPREdLTUFhOUVh?=
 =?utf-8?B?WStCSnZDQzJqZitrUFpLd1ozeVdJdERMZGh0eUJVbTF5RU1KNUY4SElNWEJj?=
 =?utf-8?B?OEZTTXZGc09XUi9sN0g5bnhVSWxFNEUrMElGQ0pURXF4WllZRlY3bFJTUGVt?=
 =?utf-8?B?RHBsL1I3MkdSVnlWcjh2QlBENjgyNkYrOWV0Y0ttY2llcm9BeURXOWxEWVBi?=
 =?utf-8?B?TXhkZHhFcCttUkhKVkRONld2NkkwMW13MmNBaDlValdpbklsNWFPU1Q4eVkw?=
 =?utf-8?B?UEY5U3FxRWYyQ3dEUnZHdGFmYTJQdVhkc2hsWDlNbFhjQ0pBSEFCLy9tSmhE?=
 =?utf-8?B?NmxpZGFsQ2lnNDRMdFZHbVpmY3VDNk5Sc1dsaDNmWVk5ZHVjNUtaZFJBekZZ?=
 =?utf-8?B?YW1RNlFuYWhLTzFrTEhmOHJmYWc3TitEOEY2RFFhMEROc1ZwcWhHUGVEbkYx?=
 =?utf-8?B?OXJYQzdQL3A4RStINEJ3TVVSRVBNcFFWZnJDOE9SUVo4ekx0ODdhYVNHeVNz?=
 =?utf-8?B?c3NzWGNkWlJXYkFyYnBZVDFLV0F5YXNhcUdtSXMvVEMzK2NaeFViMFZsbkxJ?=
 =?utf-8?B?ZG0wQ1MxK2RRaEdPZmJ3VndCVFJ1Vm1MME10eFp1UmFJYWh1QmNOTjVxcUsv?=
 =?utf-8?B?WDR0bHJ6Q1VvaytYWWVPZDRVcHd0U0N1Z3lRTHdlYUkrR3lXVDNqSU5WTzJS?=
 =?utf-8?B?RTZlaVVlSGs3ck44Z1BxWGR5NFFtMFUrekJiN3FteGxOK0xZVWNtZUtxc2hF?=
 =?utf-8?B?aVJxMnlSbVl4cCtNS2ZmT2hhOURhMytObHc3dklOMG9QZFpURXhMTytDeEhu?=
 =?utf-8?Q?O+MB00HnZbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek1xQ0ZkRmN6SlVySWtzbTBZeU04eFJwTHkwNmt1SEMrQXQxWUpDNm1uWkNU?=
 =?utf-8?B?SG1FU0VwQXdkbjlObW5BdGJjMWNmeEVTSUNDNFZvVVNIYWpKMnI1OWUzS0xj?=
 =?utf-8?B?WHNQcHVJem9SY01qYnpqclBtMlRNY3Q0Z3ArbmREM0ZydmM5SHdlOW00YmhK?=
 =?utf-8?B?VEtrSS82WndjMWQ1dDhBU1RmcEozT1A0OHdmVjNKSHMvdnQ3Y2REUzZZb1cv?=
 =?utf-8?B?a3U3SHk0ZzNCOG5meVEzcWxuNjdYTlM0WDJPSmlkZTBGQXY0Z200QlpkQk44?=
 =?utf-8?B?OCtPZEx6eTYxWGlIb2liNURRN0FwY2JQeFA0VVA4M3phTi9xbnRCVXY2ZkVF?=
 =?utf-8?B?ckliVHNSWHdib2RGUXBMVkRHdnY1VHY4S0hIMUJjTGVjbXZKRy9RWFMvNmUx?=
 =?utf-8?B?RkY5b1hMQ3Q4Q3ZZNEdRTFEvaEp2Y0pNVEJJYXlLQXYrUFpFeE5qNndjeUlK?=
 =?utf-8?B?NWtjMkduZEw3dTJmbnkybU5BQno0NmJPR1pDMlpleG4xRlhrUGJPOVJIWW9P?=
 =?utf-8?B?amlHZktxMDJoUk1GUWhFMWFVdGJWODRwRDZNRGttcVl5Sk56Qk9lY1IzZlN0?=
 =?utf-8?B?MmdYdEhnZGtxQzRlUHRRS2ROdTZRWXBaNFVUU2JHYzB6U3gyL0kxRm51VW40?=
 =?utf-8?B?b0VDTnNvd3BmSnFBMCtBMEkrUnkrMlA5c1JrQ3dBN1E2MGovYWlVVVlyakFO?=
 =?utf-8?B?NU0rZUJRSDdmeFpUL0RUbTZtVDgzdlRnN2pIWmNwalJzZ1pjaXZyWVVYc0NH?=
 =?utf-8?B?MEtaSFNYZ1U4OGFDd25WdVc3Y1d2ODBoL3Nsa2oxZ1BpK3VkMFhDcVFWYWND?=
 =?utf-8?B?NDhSdHUwVmYyUThvSDk5TE5lamdoZ1FmU2NwSjd6THR1dEhLY1p2elF5eE5K?=
 =?utf-8?B?Wk4vVWdyVlo0eEhRQmdrOUpaWDdnK2F3aXlCekI3TFdNS3Zubm5wZlRYYWxY?=
 =?utf-8?B?bkQvU1hsWXBmQzJweFN3dWtVbDRsSTlXMkJBNWVieE0yeUlFZ3Q0QVhzUHFQ?=
 =?utf-8?B?Lzc3M2ZtVldwd0ZYRTdQeENBaE5XWElEeEFVTDdZUDI5QzZQT3RsWWhZVHdU?=
 =?utf-8?B?R2FRVWFaeXRqVE0vRHJqaGlkR2crSmZuaTQ5RzgzbGQ4VUNZUWFjNjJqUFM2?=
 =?utf-8?B?Z0NUWmpLWW0xVHg5cXVkYXFEYXAza2JuRGtJMkhRWGJrb0dZRlcwK2NSS0Nj?=
 =?utf-8?B?eWhkeFNtZEEvbGEzWmh6VTk4dE4rdDR6OUdOU29KT0E0MjlKZktNcVdHSDVP?=
 =?utf-8?B?Ry9mNFVYRXQ3VXEvWVZpQUhSczZUUU9PTk9mZVVTczJSWCt1VUF0SGFQcGla?=
 =?utf-8?B?Lyt0TnMxcTMrcFREYVd0WDQxSldMbnlSbnY1VDh2OEgxQjhEYitqdXQrUmg2?=
 =?utf-8?B?V1Y1eTVIOTlCMDNVWXN1SFR3VHFVMk5QenV3eU10NnNKdU9jZ2N5bnNUYkc3?=
 =?utf-8?B?YUJaaVNVQUVJQVJDNFJsMGoxWENINmdna1ltZENHeGNxdDZheTB1Y2xXeEJY?=
 =?utf-8?B?cTBtRTdsSXpsWmROVVlDZmpiTjFJUi9pSGJiN2hsd200LytldFd5SHBYSyto?=
 =?utf-8?B?YjZ0TWZ2dytFeDIyOENYQTdjUE9rQUJwd0xDRlFyS2xxNlZ1aU1pU1JsenJ6?=
 =?utf-8?B?bzliTHFIOEdkQWdFZkUwSnpqd0R4ZnZWaWNFZkhuSmNmWFNTdzd1MmFiQTNQ?=
 =?utf-8?B?MUhhTFB0cm96QkFaM2JReGlweXlRQmszZEZxUUF5UTVFZEswc2o3UitiUkRx?=
 =?utf-8?B?U3JxdVV1RWlwU0ViL1c0TVJ0SW1zazZ5QnpWY3Bmc05uTDBpUXRVUlVuZGUw?=
 =?utf-8?B?emdDNktVZEFVSm5pc3QyOCsvc3RCQnFJczdqNENNemhFNHd1Z1A2V0tsUlB1?=
 =?utf-8?B?bDBZTDFoZXZFY09uRGlVc09DTjZCRDQyWnU2MFZPdnlBVDYzTkpodWtFZEdS?=
 =?utf-8?B?Zi9vUUlrTVJKU1VkZUlRZk5pbFBGUzUrdEkxTjRtMyt6bWpYQUp1dVhIQkhZ?=
 =?utf-8?B?bFFlQmlHcDU5R1pVWnhIL25Bcm9YMHdSOVNjWXl1dk1hTG1qdzZqSmh1WGUr?=
 =?utf-8?B?Tjd1UTN2dWpZajlDTlo3NEdwZjlldnB4R0hoT25QZmFrWWtFQzlHMkdWWTk0?=
 =?utf-8?Q?+l0V+POH8c6kX10yHcXmje3bK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PBOBTib0ZXFODo4pfmcDajzYvJ/Lf8oE9jwu52MMvEEUhwMDfBk5GY84lI3RFc500HQzriidSyFTtHdphftfXnA4mdadNcU0hRslug2kbAFb4bVYONT0GLrKW02P453b5X+A8f9zWV6Tq/txH6lVIRCtE1FzxYebyXLCtkaFPfhRfb6qYRuBAaybIxxS1+ks3WV10qj8ubRpwLKd24fMVNzSiTEP0Hc7TBoicbabC2DrBcSgCR4eECiRbTSbDYPw3/p6YFHNs3WEE3L9apdt6844PmztdCBlg7fHA5SJoKyhtdBgPu2G9gNN7UoZ5L9U9xuzxQrgK8Myvud+49B0vL1NeiPcM2qNRarC/uchyQlZSNi8egUjl1k+gwIElljZLaRb4KWo8Bg4PA74cBzLG3Jx6N2X6lJT+Y8PRueUnoD3ILWwWhAZsDbQ+BF2Pbm2TfJCB5BJ6dxeRlaw6Yv0GTDNeb8ovJhgRrSvDCq4YDwb4UqPxB6fYKntNAMZ7W8jaKbXwP9UnHXiV4Emsy44XIK3VnbCP5XuJn3Dvl/dWoo26WDM5Axgna9UqiDL4MpNBK33B3soPXCBcRyrQFXgWc8dXTLaWwJDvFqPNtkoQXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057c15d6-19ef-4440-0269-08ddf5434c77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:05:55.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWbLUXR342u2EceoNUEsQ5icxHeyOWs5rdATePkphR5mVH/HS3X/0F6vdTCCsq4GCWRXO/vYHBKDi6iwWSoGqFZ6eyfxNzMu8WGvWyz7UGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=776 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160158
X-Proofpoint-GUID: wjjTpUYySieq-WsOzd7JsRwTJN_xzdGO
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c998f8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=RspIY8LuLf_UBURfD8IA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfX0rJCDRq8vxR2
 vAjPH/WILXfO4tvvAwWoQCZ/oZBU0MNF+MMImzPUgE5fAOT9DKFg9aYyrempNZypJ3DeZRzH85a
 VFy/9r5FGI4pgfBqjdw96nnSlEZrewFB07ymFlO5mk6z/tPTJjzDO2snR57/PPvfBJFdcorzjrD
 xztSWCAVAftI8ZVJ3X+nuHr/gBXe7QwIPyoINmqKNZo6BD1EJMIqjt6bNSD51J0o6BFpXjgUfb7
 SLryPRrng1yyVhKSctnO+1LNjv1AVvPlC4Z/ILiUEGZO4UWq048ZRCay8fWoATJeNvUFpt8/AHi
 gF8BYnwL+ynotZLi73WPpChSfLcWGljUfHsP5E3TXIK/uk2guPm9uU6lN7CgdWPKKOAs/XEzoTx
 sgoE5Bm8r6tsMq0bU43aiNFBiuLjpw==
X-Proofpoint-ORIG-GUID: wjjTpUYySieq-WsOzd7JsRwTJN_xzdGO



On 9/6/2025 12:18 AM, Nathan Lynch via B4 Relay wrote:
> +		} else {
> +			/* Single-Producer case */
> +			WRITE_ONCE(*Write_Index, cpu_to_le64(new_idx));
> +			dma_wmb();  /* Make the Write_Index update visible before the Door_Bell update. */
> +			break;  /* Always successful for single-producer */
> +		}
> +		/* Couldn"t update Write_Index, try again. */
> +	}

Typo Couldn"t -> Couldn't

Thanks,
Alok

