Return-Path: <dmaengine+bounces-4887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EAA8929E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 05:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92023B0342
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36C1581EE;
	Tue, 15 Apr 2025 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4bvUiCox"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6C2DFA28;
	Tue, 15 Apr 2025 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688761; cv=fail; b=Pv1J3zgvKx4OlnY48QozLKkBvXa5/zP7xdqidavWvNNplDtgyOGu4TyszFBHZjK/D30e5pbiUUaZCipDDC35geDNEXOIqQ1HcFlnAt0djuZ3RCpwqh0mMn/hzl0fqHqbZ+VJAjtNaahqRJHSCDrhwJ1GLTdTBtq2sIjh6zdgHgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688761; c=relaxed/simple;
	bh=FFNHdrMAzIPi3060D4TGf2//qnE/p6Ee15VS3ha5/ec=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLwryShTrguh5sP1Enh0AVAuw9B1y/BlhL5vgntIKOzDqvJH2KxVfp1VvgAvyzchvmwWT3GMX21/6sj2kf3rxoMS1D0vEuJBJ3ixAYSdHoNd5phwum5+c4c2xFChQ8FIqFqW0QHE7b0JV2g382eY8Qx5JswiDg93V4zLkK3VZKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4bvUiCox; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drUGXLzihTaf1xzYNZgF/9R97oawA5bhAzuLQlP2xcvp0koMOnpFOv8ipm2adTn5BruDn0Mt1S2RSGdmKBmlEczIoKpkp88QvaO1sZ3VUPCFc2iRSHnwIv+Bisd+rd6t4C0kWeeuOKTz7dZhUyPaDNLkcpANiplkymQKL7O+Cq4OcSOK4ev61zZkqVq06fjY6DHrAuq28qz1Ml6kgM2cASWUx4rn7xHsjXG9eErKWE8Px7OWBj6UC5DEUJQXzxD5rp2BFaFdFCZg3PabCpqUiJK81rPkLTPhkAxQPbxswQG9nu7WunjY3Edjsgcmi+WGq+1X2bdtAMVEbLeG0ZCuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG7/75T/aayYej280xUgyvgvooWqvIVa7Q+2weM9fNg=;
 b=pK+LTzOQ6/hV3UDwxoeuNyR8iq8Cuk5GR3HeC7q2yGWewi2+WBFe5xzJ4TCq6KAhxKvtg2T5+f7I0BnioueOECGZ3l7gQ4EqxZLWf1fhYzfq3o1wF+qRLVD6PM5d65Fi1FKd4htjT99A9+B+oLkALYJhoCO6ovjK4mi5RjXUs4kKEbIGwtFY4AS8lrBzWSCN1DK4V0LQOg8GamF9TuWcrRHEmlA8g0MRmQ0zc0Fk2Vqd3/U4wG5sJCBbX1YcU9GZmJ03YmdhrY58h91Fe+eYe7PAsetXFvMhhQJxlBKrKorkqU5hV785INyj+67+NDOvl2p0cYNUTFBMXrBaDSV3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG7/75T/aayYej280xUgyvgvooWqvIVa7Q+2weM9fNg=;
 b=4bvUiCoxTJdC7sBKCB8y55nWbuw/3Tb6tkJNCoWspVPZ85ZaeYtzQvivWWpDOb6Vh1qofGThensVvzD6NlJpWL9AirTnuMWDizVOKlPc1ckaupWcrQchanhb91gXvn3gjzfxeDQdHmutTGd/U0gc5ZwrZBHrV7vnhpcKnUlu4Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 03:45:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.8632.017; Tue, 15 Apr 2025
 03:45:56 +0000
Message-ID: <bb0ef9d2-a100-4dfb-8754-ec8fa33ef6ba@amd.com>
Date: Tue, 15 Apr 2025 09:15:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ptdma: Remove dead code from
 pt_dmaengine_register()
To: Eder Zulian <ezulian@redhat.com>, Basavaraj.Natikar@amd.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250411165451.240830-1-ezulian@redhat.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20250411165451.240830-1-ezulian@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 65785678-8418-426a-2832-08dd7bd006d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3ZvaXE4amNIaC9TOXRib1pXTnJ2UHAxZ0RkWm9OYVlsTG5LMkdhR25FeXJZ?=
 =?utf-8?B?eVNDRWZnbjZlQ2FlR0ZoaHRweXQ2TWsva3JiWjdVKzJHeWd1dDN6UlNjd1lL?=
 =?utf-8?B?Vk5SZmlIOXMxSFY1bHlydFAvNE1oRXhab3dyamdXUmJybVlOdUQxMjVDR21R?=
 =?utf-8?B?bldSbFowVGRlVjVsY00vbWdmSWp4U1ZiK3k2UDJDVXlaeDRSZ2V5NWwxVWZU?=
 =?utf-8?B?a3lXeWgxN1RtT0xNdC9BUWlVaWs3WkZRbzFkZWxRNGJCMU93SnRnMnJXb2sw?=
 =?utf-8?B?K3dZQXN2ZWJWeEN1Q29EdkFleC9YWFZwS1AyRGRoeHE1bkprRlNCU2RqeFc2?=
 =?utf-8?B?MWowTGdtay92Ylc2STNBZUhXOTVUWlp0eUo1bUcrYjhTZS80YnJCRFdiWEFk?=
 =?utf-8?B?YmpQMytvTHpOY2FYa2p3bjN4R05rSnErZkNFbk9ERzVsSmJnQ00yb3hNTEVF?=
 =?utf-8?B?SDVRZWVuTGpYSVdDN0NhNHJUZmwxU3hQTDZEeU9OYWhKVTR1cmw0QmZGU3hr?=
 =?utf-8?B?YUpNWUgyNXVyK1FzTzZieWRUT05ZTklKTGpEaDgwbnhWQm4wRWdKeEM2QlV0?=
 =?utf-8?B?cnJQSHFzbFJERDZqc0JHT0xyUFphOGp2ZTFlak13Q0x3TnlTbzhrV0lua2Mw?=
 =?utf-8?B?Z1BacDd0TnFTcXpTTXFpK09pZ3hVdjJIK1FNOGx1S3dsU2FPNVFkb1lqTWJD?=
 =?utf-8?B?dlZYTlQ4ZUwzVCtXZ1A5Qkt0SU1UY002S29RbUxnRGV0YStMUWJPMUxyZWFJ?=
 =?utf-8?B?bE5LeDFVcHJVZC8raUsvRjhEcmpJcU1mS01EVm9ZOEU4aWtSNzc3THJGZnN5?=
 =?utf-8?B?bnRVTE04dzJzZnRMRTBuUTVBZUZMbFJxd0lIclIxREZ4ZHhaMkI1bGZrMUpy?=
 =?utf-8?B?Nlp2eTVDcXorTFhIUjQ0WjZTUmlZMjIyOVpQbGtJTEFmN05CN2lBNTNEUlpp?=
 =?utf-8?B?T3kzNVVPVGNaUERYWE8zaE1nUzV0WGtDcDk0dThuVEZkOTNPaktVTjVqQXRO?=
 =?utf-8?B?L3YwR0VqYzl3RWV1dEhYeTBrVjVUaTNOTlNYa0YwbDJsWGdaSmp5TDJVeHZJ?=
 =?utf-8?B?VWV6NGk1YVBFZlpWeHkvUUcrS1lFOGVQQzNCL3ZCRnV5Z0EvY3U1TG1GeFdF?=
 =?utf-8?B?Ry9PVG1GVDBXTTRMQmxrcnNtV0ZZbGhLUHE5S2cxckltNmpRYzd0cXZpVG1q?=
 =?utf-8?B?cjhpRThwZU5CMy9IdjNKMStqcWptN3NJWmFiejRDKzZQaHMzUHQ0c012VEdq?=
 =?utf-8?B?dCthY1IrTzNLWGtWZThnVnk4aHM4UmtsTzhVR3N1SllWUm9tSjlIYnBJd0FG?=
 =?utf-8?B?REZtNXF6NUl1d29DVUQ1aElQdXQ0Mll2L1ZlWEwwMkNqYUprb0NxQ3ljaEl3?=
 =?utf-8?B?aTlvVjkwQWFTclkzOVNYUmQvc2gxNGFHLzk4QXNYbUQwU2ZDTUxOanR3cTE0?=
 =?utf-8?B?TzFBcTlucVZJYUNPamtoN0szTW41TGNmbWp1ak0xdWpENGlCT3lRMnFacWhs?=
 =?utf-8?B?WnFHK25hTFJRMXlsR3NGWkJqUE1NVFVXRCtxL2RMRGRIaU5NN04wZXRJZDRD?=
 =?utf-8?B?T0xjaC9CL0s3UGwzU1plSmd2UFNhblZvdm5sSlBtWlVqczB2bE5RWlcwdTVR?=
 =?utf-8?B?a2Q1OWViZnBxazAzTWV5TEI2bE1uZ3NueTNiZE9JQ3lVOWR6WEJzN3VlV1ZX?=
 =?utf-8?B?WDlhdWJsRUNqZ2xKRThURkp2UW1CbEFWd28rcG4ycWJnVkpyaDl0SldJU3JU?=
 =?utf-8?B?SXRhd1VMY1d3eUFYTVAzcHRiOFJoVjFKbmQ1VjExZjJJQ2pJNmRDOWFMcGwv?=
 =?utf-8?B?K0lmRmNRVFJodjRib2thS3l4My84R3lhQ0JqK0VTZnhjRzc2YU1XZVZhdy9s?=
 =?utf-8?B?MFhnM1U5SXBqSmN4dG9KQkp5RnJpQi9lRW9jYy85Qkk5NHRwblJ4VGJCQklv?=
 =?utf-8?Q?dk3hgK9gEdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDB2YWthdm5JTEtZSk4vTHBXRGZFTGVzRlZHRDgzVzVIcDZ1alVHYXhvRCtw?=
 =?utf-8?B?QnIxM1FXYWVSMU01RUMxanhHV1puUjZrbjRVc25KbC9vamdISFFDTTAxR0pW?=
 =?utf-8?B?YnF1WWhOY000S2dacXpjMTFscXJlTDFQNThkQlNnME9RRnZadXVEQ1FkSE5r?=
 =?utf-8?B?V2FpWkpWMmc0Z2hyUS9MS3FtRTU2WGVUTWdFZnNReW9uWGdMb3FzcjJoVXhj?=
 =?utf-8?B?d2pUeWVFTXpFRy8rTlA5OXlvNVFTdkFxSk45aXNIY25UcTJPd3Ztc1lKWkwr?=
 =?utf-8?B?ekdHSXJLZjN3Y2o3OHVRRkJPdmlMRW5HOUpEL3ZidGk5OTl6aEpBcXZ5b1dn?=
 =?utf-8?B?MTNkTThBUWVPRGRndkk5Z1M3Q0J1UHBvKzBBQjROS2NmYldLcU9kRFhxTkxB?=
 =?utf-8?B?OFRucDJSQVI1NVZJdHVuZlBhbmNPbnZSK1p2WlBsOVUybXU0ZFRUK3k1aUxO?=
 =?utf-8?B?RVdHdXJaOTZ2dU1lMVhGM3NqaEhaNEs2ZTJoT0pLcldLdUZNZHBhaVJ6b3J4?=
 =?utf-8?B?NFVJNkVRTk1YSG55RXphYlVrVjcvMCtWbHJzd05wbXZTYTl6SGs0eFFzNWc4?=
 =?utf-8?B?akUzWFdsL3BpM0Vqd2oydjBMOUZFVWN0SmZNZ0tRNmJkTlNXazNhTmFRRENT?=
 =?utf-8?B?cG9nakROVUxzQXo4RnNDZjFJSTRwNk1BWUYwYUVCWG5MTzk5NmU4alFmaVkw?=
 =?utf-8?B?MFJNd0VzWHZNZHl2SWZFNFRqT3c0Zm5yY014NzN3c2x1YWZKVmE4QU91RzdY?=
 =?utf-8?B?V29uMXlIV3liTFZFVUg4Z1pOdTR3NGNPbXpGVVljS1ZoTy9JTWFnWmVpUWgz?=
 =?utf-8?B?MW41N0swNWR3YWJqLzBMYXlEdGhVWjB5cDJxWnJJRTFxL0MrbFRhSWR3UGJs?=
 =?utf-8?B?Sm8rYkxZc2VGdUM1UUZiVEhrTXhvVWJCQkZJUmdlajcxUnZTOWxIcXRtcjEz?=
 =?utf-8?B?VitQczlvcWlQV3JPM1Q4TWZiSkVGVXcyNmVZdG96RGs0dERzS29KM1pmU3ha?=
 =?utf-8?B?ZzRWd3NMUy9lNFRYckFMdjV2akRBM2pSUlppbHE1QVR3alEwckRSdGhMQjFI?=
 =?utf-8?B?bFpWT0RGTTNnMlAreXFQVVMwMGE2ZjFGQjJBZEpZQkw4S3EySHdIMWl3Y3FF?=
 =?utf-8?B?Wk5kMnR1NFhZQU1WcitxeGdPbSs5MVJDTW4veGdRZTMxc01pYWsxZ3BrRElE?=
 =?utf-8?B?TlRUQWgwQ3kwU1FLV2EzUU9IRzFGU1pnMmdTVVNSVVphUlo0TEwzeHhMQkth?=
 =?utf-8?B?TUpFVHpPblVpZXAveXpnSGQ4TERYYm9ueUE0QUhScTlvR2VvVGJoYTJNWHBG?=
 =?utf-8?B?aGl0L2p4WTRiSUZxanVERVlUeHVyZWNmbnFpUGp2dk9ncGFmYlZWZGVOTThs?=
 =?utf-8?B?VGVxd09FWUMvRXRlemxOd3Nka2FBdnlkQ2RHK3BCd3JNS2d4b3FnZitVeENS?=
 =?utf-8?B?RE5qQ1VUbWlxN0trMU9jUGE4eUZNd0FGaGxDME1wUWxEYlMwcU80S3pCZll4?=
 =?utf-8?B?VlFEdFRVUDJQRkhudFFSd1ZtUUtuQm45VGZCSlNHVTdTRng4NU9RS1FXV3A5?=
 =?utf-8?B?aktzVXJNR1ljUmk4SnRsZlh4dFFKMUM3VUJwNWNyUFRqUEFRYzFQbnlyZzQr?=
 =?utf-8?B?SGZ1ZTgvaWx2aGNhWUR5RzZjaWRQSmFtVnhQTENwd1RaOTBBVzN5a3BnWmZB?=
 =?utf-8?B?TjFhVEMvd1Jzc3ZuWDdVOWs2VGpaZlFuWXVYZFo1MHFDclduWnA1MDhJdHF0?=
 =?utf-8?B?WkE5R0orckovbS8xY3B0Nkx6NU1sWE43OGxKTjhWRm1IT29lcFZraDk5TTBS?=
 =?utf-8?B?dGtxVFA5NEptNWpSSWF3M0Y1emlOMHNJY2NNNGIyZTUwYStwSHVWMnRrQ1U4?=
 =?utf-8?B?Q0g3M0l0dWh2MnVENlI5ZW5uMitXSHJUSm5XS1p0VEhtTWNERC9Md0VnVzBr?=
 =?utf-8?B?aTh3QjY0cENBa3dQRU9CQlgrWTVEek9Hc1pVNzU3dDR4L3N6V04vMjEwWkZK?=
 =?utf-8?B?a3ZBdGZNY3g5WGZGempiVks3MzBLMlFtZU1VOGp0ZUw5UTRtUDl3N3BueFVa?=
 =?utf-8?B?ODFoMFFwZTV4aHo0bjh0ZnZQU01CNkNubUF6d0JtMThNUHBkZnhQclRLcmpE?=
 =?utf-8?Q?5qEPVGkP9wxQTZBFNSe+HKM16?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65785678-8418-426a-2832-08dd7bd006d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:45:55.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9x+LR9gT4PdziXtQ6MMKSPlsn4lKYvRCQ3iQCdGIJhsp0k+QLJtWUKMhM1KwkBP+M2sl/T8jhFgpY24RQkTFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271


On 4/11/2025 10:24 PM, Eder Zulian wrote:
> devm_kasprintf() is used to allocate and format a string and the
> returned pointer is assigned to 'cmd_cache_name'. However, the variable
> 'cmd_cache_name' is not effectively used.
>
> Remove the dead code.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 715ac3ae067b..3a8014fb9cb4 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -565,7 +565,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>   	struct ae4_device *ae4 = NULL;
>   	struct pt_dma_chan *chan;
>   	char *desc_cache_name;
> -	char *cmd_cache_name;
>   	int ret, i;
>   
>   	if (pt->ver == AE4_DMA_VERSION)
> @@ -581,12 +580,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>   	if (!pt->pt_dma_chan)
>   		return -ENOMEM;
>   
> -	cmd_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
> -					"%s-dmaengine-cmd-cache",
> -					dev_name(pt->dev));
> -	if (!cmd_cache_name)
> -		return -ENOMEM;
> -
>   	desc_cache_name = devm_kasprintf(pt->dev, GFP_KERNEL,
>   					 "%s-dmaengine-desc-cache",
>   					 dev_name(pt->dev));

Looks good to me.

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj


