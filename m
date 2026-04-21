Return-Path: <dmaengine+bounces-10077-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HLUF5bW52mzBgIAu9opvQ
	(envelope-from <dmaengine+bounces-10077-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 21:57:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E6843F1FF
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46305300F5FD
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D33242BE;
	Tue, 21 Apr 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DPaDZqo/"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1802773F0;
	Tue, 21 Apr 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801255; cv=fail; b=MhjJbJlhITOTfNvQjrfGIIp402x/gWU5JxsS0l8Yeq69TdrPKDjekjXgOMO2cmy+0qbbJYhZZ9MvgttBsb/ADc70plFMwolAiix1xs2JcTTExL6QlLyZgXCwQ0WqNwD0YaXBDPpiMAVSjNY3vuOj3tMn/qe7yMajJ56v2F1+/KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801255; c=relaxed/simple;
	bh=YawQOF+/LLf/7pj02pknEcoUMTE6hU35hd/fOHYK6Iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCynnZPCwkP11WpDvT/th46nWZgKtsY5A9lxWuIK6i+lNSs8gW2QZZAY4hKH04hAs14TPVDiqM8sEbN21r2HR/iOh0AfHbRB/mlgfc1djm3t7wRSAE2IYNImOhMYtbYNdD+l/Lros81aZoI695x4RXJg0F3LRP1fOMo85fAbBxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DPaDZqo/; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdqN9y+0qTGmyrxSQyZSU35HuAdS2zJUpnJnD3SVPRnOeJUWRDMvm6UmVX1KpeKdRQIxvWvDU4V5TL17BCbDpLEFmyphGvtRsZzlQCaupZjx34qDcf49huIqBlUSVGrqt7KNuc5ATpkunlwn5ZmRiCUsPZ5j6H8dL7ocevN+DOd90p6Ww3mcneQEneWfzHebxDAoumvlRFsdOPg6Z0m1FaZsWex3i+oQaOsICNzWy1rYTL+2FUQ4VmCWn6LIFJdA7osKriiEO//bccBPpwd16jl8GKhqiTOBJv5jhqhHE0mQXScZnUKVjki0wvLyFRLZpx0BYljl2R0twdGzwgR0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEEDn+nvOGiUEoT+wDLfU2NhgYueKoA4gCfXTqrIUlU=;
 b=SDFepfwgbQS2uHsoTGjjBAHa/XUDy3Ifzo2BgJgFccI6ScKGHeBpIkUv0Zmiq5hxI4jQw1uZp9KTLmhDftUFU1sMbBCWFX2BRd8ndgItdu1FVyvOK2bvS6heWHoDc9NhE+PcPg4X79nQm6F7PSMi/PudwcJbahO8koCALs6kAV2fLZtXFKQeDBUi4ggXTEdufG9Fp4UaK2OlzhYUALc9DX/oR9AbK6FgM9MjJ5nsP2F8yeagubLjGGcHaa2YcaCu8zIhBx6W0PfEiICAIOSyJOT0e1ERolPJMcf0C577FlqQd3dQq7eLX2K7mKug3KfVVGEHUKvklK7Ef1rcaOfFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEEDn+nvOGiUEoT+wDLfU2NhgYueKoA4gCfXTqrIUlU=;
 b=DPaDZqo/kjgSZkancHdrdL1BmxBu2JQYDUdpNSQYiB9T/38rdcZ2Xhb9sESKHmtHsz8/RRK3rk+8aEChCEunqFfT7jdl+ILyYY5vOryAYc+OXKsQYGFI3CB214TPB7X3D9s43rBRBbMX35yLlr1pYWJZZwWodn7/APTN/RdkT4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:54:11 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 19:54:11 +0000
Message-ID: <a209d10e-305b-4ca7-85c6-b5f5fab13fa2@amd.com>
Date: Tue, 21 Apr 2026 14:54:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] dmaengine: sdxi: Provide context start and stop
 APIs
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-19-1d184cb5c60a@amd.com>
 <aeXo0VyXMhnZH0h7@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXo0VyXMhnZH0h7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::11) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: a23752b8-0524-490f-d7c5-08de9fdfc195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eqFGwtLCgIhe7jOtgOOUYtkf8IZQ5/1o+GPFZyuQIjSXYLNR5oHGrZSXxjVVNJmBRcYSp7BYqYMNjw8b2WYhzeGcQNaRXuVAxcnHSxqhP1An1FYOxef3f1WRXpuo/abSfuUvO/CQa6jxqaojbsCuKQh4oLIZIYmwubNm7oS9vs+31VsUoUk83IAcPy9FKjEXeAn0kXivrt4+Tbzkb6bFwJs250nWiktMdspeGvql0jdaywtLy3cNjdgZRX8GhqXn5k6/sMP+/zBf/LX95yjm37xVp1N828bLUVzDs0bYFPiMA15YSvJ0+mp6n/5BeQrRiAd7Y5ftlQqkrZAXKkDFJSZDvoPHYVnsplO8hRacx8jly3hnl473oRNJOz0bc52BdhF4kuLr+wvSvCP4J/pNyefvoQdxmEXLOGywxK4XrMgXCp3P7htA7YvwyVU4NW6acGiVbF+D2q+3DjHPmF9jgejD9T3XqQ6m6XUQ2UvXq7ghurMtOd+WYRR2/BtAzSwuYammqn9FKrXXRT4hOdSYxAI2Ad/9LWBXbV57TRoUO+tpd0s8a+g/mZAmrE2VClAqO6evBHz3LEzk0dKomqe43Qm4h29CfB4QuR10Zso5UdHQfjSsgXTKWSjdwoytJRvBwxQyuilRL0k9esTaMvJXWJaMvrVucnMiXvu4Da39/0JZcpz1t04wKZCx2M0KTHam2Ioc3/5MqRmZRBAwZ9HNETqctEoa1O8xnnbFpQ4+Tfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjIvYlJndTJFVzIxci9pYTdKRms2d0dhY3dlOERCQ2tTc2dtRTBvUzNVYi9E?=
 =?utf-8?B?M0ZiUm4vK0tqSGoyUUltTDZmVmg3cGN5UDNXcURUUmtxZE0yMTJvM3ZjNnZZ?=
 =?utf-8?B?NzcrMko4K0JtUmVVcFBveGg0UmlnWGxzemp0S2wzOENHazJhYlhtOWpRSVZl?=
 =?utf-8?B?UDlxU0RVUGluRmhyVFVrVmMxSEVqV21EemQwSC9tK0NiTzZJME9qQVB4SE5s?=
 =?utf-8?B?RFAyVzlLWkZGYjJUdFBJZVFSa2dIYTVtUlYwNmZoTzZ6M3pYclhweTk4ZmFJ?=
 =?utf-8?B?RnR6VTdQdGk1QXZLckQ4U1NRamFKcDNRSEhCMkNFdXpITDB6MTJHOS93Qmd6?=
 =?utf-8?B?OUtkdUUwMmFEK0VJSkYzZ3kwZXZtT05jK1dRblNHcy9vMmNrU0MvVHYyaFhV?=
 =?utf-8?B?K0JhRWErbmNwaFF5SllqMng5VUxXR0MraHBuRHI1T01DR0ZBZ3YvUER2OFdI?=
 =?utf-8?B?UnpkWm9vbXNzVTl5VG9hZGxUTjdtcjV6Y3JoOFhidms0Zi9tTzQ3eEozQmpW?=
 =?utf-8?B?NWd0djAvcm84akJUa1YvaHVKdElMcDJVT21oeWVjVmRKcUUvQ2dGZVAwTnBn?=
 =?utf-8?B?bjRtak4yUytjR1JOYWZaVXgrOUc2MG9PNWNEblRTRDVrTzdiQ2EzM01IYm8y?=
 =?utf-8?B?cWdRQ2dwWitaTUZJYjlWV2JJM2oreUNuMWNqL0NVRkVBZlJmdWQ3c3F0ckFm?=
 =?utf-8?B?UGkxMTBwRmd1UDJQeHU2Rk02a0J3Ymh3dGl1bW1ZL1NzNDNOZzdYR3VnU2hI?=
 =?utf-8?B?ZzcxeVgyaHZsQ1dMaHNJWWg0T2hOVGxMSEZ0QlN3TklZVzd3Ni92UXJaVWRv?=
 =?utf-8?B?TDlURUpmZ3dXRWxiSnpFK1hPZ3F6UWlQU0owaVI1bGlDY1RLN0FGUmx3YzEx?=
 =?utf-8?B?ZE5HS2NiMGgvQ0xWUlpmc3ZCbkdndkhiY3MxOS9VWURVaVc1NVpoNEpyc0ow?=
 =?utf-8?B?dUtRaGdwTGU1c09GZHFFUFZsUitJbjZjTWhQc2VNWjE0NmxjUlVTVjNVTFhp?=
 =?utf-8?B?YmFZQUtoa3dGcHVEdUtnNXYwNllPQXptVUNCL2d2Rzl4OXVDekx0TncycEVn?=
 =?utf-8?B?RHRHSWdhdFRKYWJvTUxrSTQxSERiUVNDMU9zZ0ZtaGc3QkZ1Nk9rN0dTdGdZ?=
 =?utf-8?B?RzlRMU9NY1ZBUlVjSVc3ZURUM01sN212WWV2YytuWitwWXlEbDFBUlVPeVJN?=
 =?utf-8?B?QTlmVkV2ekhoN0N2YWU0blh4b0ppNHVFbGtVaXZscGRlQVN2RWszRTlNWTU4?=
 =?utf-8?B?TlVyVmc1eW95OUE4eWxya04xWTVrRWNtRk5EVWJsY1JaTHEvVUlocEMyb3NI?=
 =?utf-8?B?WHFyd3ZpNFM3UHl3ZVNhTnAzSzJxanFTYkJjdVlzaFZuNTdBWXdaQ1NtZlFv?=
 =?utf-8?B?dkZZaWh5OE9pWk1FcklxZDkxeWJkeHhrclY2NVpaQVNKREpDOGd0VDhRc05J?=
 =?utf-8?B?OFZYNlVQdmVoRzZUaU1lem1TekpZSUpiOXFjSkNyT2R3eVlrL2JWbTRHdGUy?=
 =?utf-8?B?bjVicXpuNzdsMUlaN1lKM3hIYzhnRENYK0pjMmJNTytUdVhvU2MyTHVMb04w?=
 =?utf-8?B?RE5YcTNzZ3l5TFErWkRjUDFNSXVVZkNTQXpKUlBNeDZlRXdzS0ZKenJvVm5s?=
 =?utf-8?B?NGdWUlVzYkl6SlNia3VQdFU1b1FFM21CcTJ4aWNOQkZvbkdVMGxtVDZUeWp3?=
 =?utf-8?B?SnVLREZhZjEyekhmT2RmVEZVbEt5RDd0aklaTE9VQXZnQlFVNnpWc2VKQnJl?=
 =?utf-8?B?MmJHQkdXcFppTW1VdUk4dnFpNzlHZXgvdlpnOE5hNFQwMllhb2hCQk44MjRC?=
 =?utf-8?B?bitWcnpMYlJ0Z2xsLzNIVjlJUnBhcXRGazhJTG5obndxazcwd1ZtK3E2QndJ?=
 =?utf-8?B?Y1RDREJSTXhDN01Lc0E5ZGRDVzcrMkNtMXZVemYyRW53S0F6dEJzVERtYW1w?=
 =?utf-8?B?Q05ZV1NOQTdSb2RUMUJQcmFXZ05hV0hTaXV5N2NYSHNIeVNmaEVkazM1d2VZ?=
 =?utf-8?B?UnZuS0xLQjlrYXBpSnFKTTAwQURXQTNNeW01MU13WVZOOVNqenFmR1dkN0FQ?=
 =?utf-8?B?eHNMY0QxMUJsUmt5RXRXOUZLUHR6RC9mVXp3dTJmdXdpZCtZQ09odEUzYk94?=
 =?utf-8?B?cDNDbW5TR3YvZUN0UFpUVllqbDNIRFNBSVJYUjNseENjZUhOVjg3SU9LRmdG?=
 =?utf-8?B?Yi9DRWIvQXNsaGpFV25JZFVjVjRTVUtZY3NYd2s3clcxNXkzWkVrZVpkemI5?=
 =?utf-8?B?N295M3pJM2phc1hXNnYxL3lPUDltajZYYTF0ZmRlSm4vTjVMdHJqOExYcnFo?=
 =?utf-8?Q?Og3faCj+58w3hXjzhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23752b8-0524-490f-d7c5-08de9fdfc195
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 19:54:10.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z8a85C/cXUwQehupvZSVapSSvdQE5GJO0BlS+/b+z69yPDBjtI9/UDeO5ynFJpLOiRrE8WkP2X1qITXa6nJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10077-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4E6843F1FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 3:50 AM, Frank Li wrote:
> On Fri, Apr 10, 2026 at 08:07:29AM -0500, Nathan Lynch wrote:
>>
>> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
>> +{
>> +     struct sdxi_cxt *adm = to_admin_cxt(cxt);
>> +     struct sdxi_desc *desc;
>> +     struct sdxi_ring_resv resv;
>> +     int err;
>> +
>> +     might_sleep();
>> +
>> +     struct sdxi_completion *sc __free(sdxi_completion) =
>> +             sdxi_completion_alloc(cxt->sdxi);
>> +
>> +     if (!sc)
>> +             return -ENOMEM;
>> +
>> +     /* This is not how to start the admin context. */
>> +     if (WARN_ON(adm == cxt))
>> +             return -EINVAL;
>> +
>> +     err = sdxi_ring_reserve(adm->ring_state, 1, &resv);
>> +     if (err)
>> +             return err;
>> +
>> +     desc = sdxi_ring_resv_next(&resv);
>> +     sdxi_encode_cxt_start(desc, &(const struct sdxi_cxt_start) {
>> +                     .range = sdxi_cxt_range_single(cxt->id),
>> +             });
>> +     sdxi_completion_attach(desc, sc);
>> +     sdxi_desc_make_valid(desc);
>> +     sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
>> +     sdxi_completion_poll(sc);
> 
> Do check polll timeout?

Well, sdxi_completion_poll() will spin indefinitely as currently written.

That's not great, and I'm reminded that maybe it ought to be checking
the context status while polling the completion block as well.

Ultimately I want to convert administrative actions like this to
interrupt-based completion signaling though.


