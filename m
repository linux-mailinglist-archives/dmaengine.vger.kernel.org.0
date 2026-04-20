Return-Path: <dmaengine+bounces-10067-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KfxBDl/5mklxQEAu9opvQ
	(envelope-from <dmaengine+bounces-10067-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 21:32:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB543353A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250D43017F89
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579A3559E1;
	Mon, 20 Apr 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/w2F6j7"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA52E3B15;
	Mon, 20 Apr 2026 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713524; cv=fail; b=NJZmKJdsj7lJ+4bflktRue6UFSU8bdva9YEJ3BXowD7NWKnjKsGTRV8NVYzJ/GQkyrG51h+V6vG8wHCZG6lFtz7tY6yCg160PGFANy09kNxiaQ18V2lQWePkyOg+r6bDlH0SUlIRIzNYX0aDvrBjrcGl+hvhR+xUwtXoX3vlufA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713524; c=relaxed/simple;
	bh=mFtXIsYgRJKBEXA0m6fjiWTuWKKHa9e/m6zVN6GVzcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GB10SQeGD8BVgLEg6HwmwCCdGjB33RjHNLXc7+M9M20KikPiBubCCWB+/KGD4CCr8xLERquNWFM9xwkcv3NbB5Bwx9qVuWPFR5Bx1Pqm77Hil690GbY+2CBE9eppeKHWzUiA1SCup8LLqIRsR1+yEzqsKZVu4WEKr0IXSpnR2E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/w2F6j7; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mP+yLXVfkRvZL5UxnW9UyibuJKalKYSsN64esx7jXE0jxkhvJthj3MUKaqsXhwlaLPIr+mkmveuv2el9flsjfwVv5DED16/+TzTMAZP+7BSxKvkfUXhj8dE4C97MTLvfUqQJp00nrujsD+pJ3330pf209BFWRvWBwN26s4tigWpOvTh69EQ0cBRF6RH2eTo5iIcVF1ovrY6RGNCyK+bIABlfC1qqyW0kCSc84YS/v8S3eiJBUS6zjLL1GxaKCs80H5nnOQH3d0uUaCIwbHjBgnLH1IIH5uavcSDkNcMqaVhRHNztrbFdhBQkdFriD74dNpPX86V9kqoZTZSDTopgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzhiIYdFGDchsll+CyG492M8jxGbtf91XTqTzqvF+0E=;
 b=k00X/wIhWMJq7WyjY2lyqQqoyD63RqPgDJRssgogfObGhd//2v/i8yFx0nCkxNWTUv8LSdrfW8QCzmBJVTz8tvNNgJGfPLeXKKkCUlHWBK1Oto8pBygGTqFrFAPE50qWADjr8tn9qi4uRcaXWuoY+Qw6d6eBD/sgYSNIWTNEFe9yKZ8TRRPlnubSpipK4DfE5wGotYq3iA7nAIxB0TzvObGcAlO2mUfa539hcMsWX6D+RkoMWuSKaekARuFjDPPGorzLkaz5/RL6cOFdzidHK3xtFmaJtX1EDppRTTQoJDEf/j09lAtQjWvdkUk/fnrk1iwg017L62Lfh6jjQygxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzhiIYdFGDchsll+CyG492M8jxGbtf91XTqTzqvF+0E=;
 b=F/w2F6j7aO2ShkH3dH3lHvSEmioMGkk8DMHbg9BlL1F09SpWUNtCtqEIOz9aJBhss0oT2UG9MJioEWbQDQ4DSoAaV6a6WozkjJ0A3sSSjZ6l0ezJgNPnWwqoXG+jlck8QljHVfOydZ2egiVYgZjEqkpy0Clv3dy1L8ebquhTUlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 19:31:58 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:31:58 +0000
Message-ID: <7d8cb403-74b9-4140-a60e-88ca08d31663@amd.com>
Date: Mon, 20 Apr 2026 14:31:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-4-1d184cb5c60a@amd.com>
 <aeXM4IChNyCX6vGp@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXM4IChNyCX6vGp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: e7761c1c-2e36-4e23-2e96-08de9f137cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o1agM7QK1KJ59ILxKAythJEaiY7WeW9/0it9BTsiFg74TfQMgS5lgjoTFWbJfGkP7uDIpzmE03T54kRjTmRG7NoeKTkmWKUxGL0AZhoDk0pxWxaQ3v8OtJlZ7mq97Uppo6+Lcdgmp5IO7T+qpN0F8C/kyn1hc1YXjWUP7YMoETMwGvubBVBKU19AzZrI1SVR7eRDVPlpRrSSSyyCV4DAC+ZOh71t0BQfOMSAXRc4N4nYQQVN+m+umtO7aQuomGGm7yotajZ0XQxrerBmxRC77sQjhPnZ2fZyiAD30L0QwPjesRBeiWyeOgKJRKCVR9SdqC4ffCoH4gYIDyD/1UX0mtK3JEHkTmiXm2tpN1MpqiMMKVTwBBO+A/umnh4NObmP+2l8QvYjDeIZ5YTrsU/uXCaIDRpC9HelsOqWTCYDE0w6aGzZsGd2YSGHrUfelA8xp341Ve+0Wj2eiU9OGX41dXujTd9GaZI/UAY1IkIiBFJ/Ud9HfuG8/cXxB8JW9xnAzSOXUVAS8O7fVfj+rK/JFP9X60lHprhIcIA2pePnR8XMlTCx22yqZRng5Feq4ilTBGfn8GpoU5kD5nBnKBvQDohkBh4oswNylchxlkLRfT7xQH/+zfw/N3DQLSBxFfoXAQtWQGqzLwt/rEkPF9Coo/13HI6qSP9E7Ti2M5BBaz2jcokqqO0LnYtbC+laNR/H7jt1xUfjJtgCT+9iNkJwu471ZRW/rFcTLgDpO+aKeoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck04SXgzS0RYSEpHMWFHYUM3dk5jZFdBL2o5NDhoY2Q4ZVpHR0xJTi94OFlR?=
 =?utf-8?B?bE9NNkxlN0doVjBHdHhHZzN5QkxxZXBmbEV4alh5ejlvL0hQQ2cxcmF2M1d2?=
 =?utf-8?B?YUIxMkt6NzhlNzNoWGRUVk9TdnZoYWhQR0ErNTJJV1RSbmZocitTSHVEeXg0?=
 =?utf-8?B?UUJPODByRCsrNFNraTNoWWI1NWdBcHFVSGZLWm1XRHpCUXUxcit6YjZ2QXBh?=
 =?utf-8?B?eXVpV0xIalU2SXVCY3dLNkt1eS95Tld2M1hlNEEveTRkQkZHcHVaY1ZNR0xm?=
 =?utf-8?B?L1h0RnBIelJSb1JtNUJsYzhZNE9HM0M0bEdHNjYvL3NtYTloVHZVdlppd1BI?=
 =?utf-8?B?eEVXUWxwcXJETTJKZTBXTlcyWVhNcjJxTXZyYmVwOHZlMVd6YS8zRmJjV0I2?=
 =?utf-8?B?RDBHNng5QitUSTBvd1Y0Y2g5djBRRzZ1dmV6dnZSelNRbVQ2Z2xBb1RZNG42?=
 =?utf-8?B?aThPaDcxNzYxU1VWc3FEekd6N3dwUnJ2d2tiejZSK2RjTklNMWJ3MExFczRv?=
 =?utf-8?B?ZjVwTFhPdlNhd3lrVVhraXZIVC90QzBEZTdxZnBIRlNvL0s4cVI0WTFjTG1H?=
 =?utf-8?B?bHVOb05SMG43V3dnT1FVY1lYRnkwaS9DRmVmOENQSWJhc3RrOE9xRlgvUDBx?=
 =?utf-8?B?S2lwWlVBbUFzNEJBU3QvSENvQ3R0R2pHWWRXZ1FFRWtZeXJPWUNuSTZ0Mktt?=
 =?utf-8?B?UTN0d1kvYU1yMVpKNTFodmkzOFIwb3ExUkk1ZnRCOFNDajBPZXkrTUdncGk4?=
 =?utf-8?B?b1huOUxWTTlpMDBBOE9lNUJiL3BzZ3oxb0VVTkwvM2l1aGNzQjdxd01MWGFT?=
 =?utf-8?B?VW5zOVp0ZUdNOFhJdTlwV3FHQVA1a2gzaXdGeE1JQitXZ0tBcmF5UmFIQXhD?=
 =?utf-8?B?UktrL25GZDJ1REFuUHV4bzlaYm1ZZmxndXlQdWNrQ1ZoTGNmQ2U4NExSYTBr?=
 =?utf-8?B?Unl6cnl0MjIrVWc0QVBGRFp1bjF3eU9aNlpJUkc5RVZzZThyRUxHSHdubzZC?=
 =?utf-8?B?UVJxTk0vMVBJQStKMUJaMjdSMmJad0lkM1lFQmlQZTBTNk1NYUI0blhNUzNB?=
 =?utf-8?B?MzN4cnhpZC9JajNoMnRGT0k1ejBDK3gwWFptNTEzaExFM1VkR0pwbGpQNGp1?=
 =?utf-8?B?MFdXMm1FVHBLOFY1cGRXQ0gvVnBWMVpGUWhESW80NkFzSldPQXpUNUdGYU9X?=
 =?utf-8?B?RDFjZklHOVBxNlRuVTBZK1FJTUJUUUU4NU1Ndk00QStpbU5mMG5hL09tY2xo?=
 =?utf-8?B?YzZtU2tjanMvZUtDQ3pwWFhPT3R3VFc3bndpRTlGQVg5cnpMNmJ2MnJEcXp2?=
 =?utf-8?B?WEVvMURLTDVsdnh1ZmdvNGhlTXpzY1ZGNk93bmI5dVlMYXozKzZib0tSdXd4?=
 =?utf-8?B?NzlSUk9rNDNQajU0OFd6MW4wNTBtWm5sM09MQmEwTUFIOGRVZDg2QkJCWU9N?=
 =?utf-8?B?ZG5DN2E1b3pzMHBSakRBdithdWs5ZkFzTyt6amZxVDhyeHF3WGt0OEhCWkdO?=
 =?utf-8?B?RGNSVlVJQjBlVmdINUx0VTh0OTFJdGYxT3dZcG5pWGhMU1hOTisyZ1YwMkNn?=
 =?utf-8?B?bkg3emRGV1l2aTM5ZU95YWhLakZ5cWR0bURDbGRFK05TNmJ0QThZWkVkRXdV?=
 =?utf-8?B?RmZyWFpUT3dUS0ovMG5ROUxnSll1bS9wSGRabFl4dHZnYzhGNm1aRUFpamsv?=
 =?utf-8?B?cXk4a1FoSERpb0w4TzZjQ0drcVRXemJXVU92TlN0YWxaSlVoUHUwVDJWa0xE?=
 =?utf-8?B?NnNtY0JSSnE0YnlJV0lOdTN0MGhQY2tGQi9yWTkyT0d3RXlUK01TR3NUcUZS?=
 =?utf-8?B?Nkh6YTAydW82UHhndFFkcEJya2R2ZjVLVDR6ZFlGT0ExR1lMbk9NRW0yYk5G?=
 =?utf-8?B?cnl5NW03WWl4aVdtR0hsK0lqcEw2dDdRY2JuYU1FMHc5VS9KNDNUN3lBVWJv?=
 =?utf-8?B?Sjd0cnVGVmEvQm1CKzBGZUgrRFZ1RUY0RXBOQ1BTSGphSmpnUWtERDNBOExo?=
 =?utf-8?B?Q1ArblYwUjZwQm55bUlVLzJjS1I5THgrRkJlNHhqSHE0THBWWG1CdHYyVmZa?=
 =?utf-8?B?ZGtiaDM2NWhWZ3VDOEs3UkhPWGtNOTMvNndIWk9ubkFldk56dDRyRkwxYTlq?=
 =?utf-8?B?Tld3Y1lkSmhmT1hHOTkwMkNCQmJqbXh1WXF3eXBmMzFUdmRxYVZXcGYrNGpa?=
 =?utf-8?B?WWNSdGxjL1FyZ3hSWXJFNlRKWDVaVktnL0xuZUFJOUpNUmRiVUNzQkw2NE1j?=
 =?utf-8?B?aU5abTRoaGttVDUxLzRYMEJ6R3d6ay94a0tpbkdiL3FzeWRuQTNXenVrWlRr?=
 =?utf-8?Q?eovgiF6+ZqXoZnsVM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7761c1c-2e36-4e23-2e96-08de9f137cb9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:31:58.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uzf77Ad2qRQdRpnAuVV/6pYyBdmSHX+emPiDgN9xl3AFxOqfozlZvuk/SeIv9qLjZVoN2ueSEcQErhyim93Lbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10067-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: 72DB543353A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 1:51 AM, Frank Li wrote:
> On Fri, Apr 10, 2026 at 08:07:14AM -0500, Nathan Lynch wrote:
>> After bus-specific initialization, force the SDXI function to stopped
>> state. This is the expected state from reset, but kexec or driver bugs
>> can leave a function in other states from which the initialization
>> code must be able to recover.
> 
> Move this paragraph to last because this major funciton is
> "Discover via the capability register ..."
> 

OK.


>> +/* Get the device to the GSV_STOP state. */
>> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
>> +{
>> +     unsigned long deadline = jiffies + msecs_to_jiffies(1000);
>> +     bool reset_issued = false;
>> +
>> +     do {
>> +             enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
>> +
>> +             sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
>> +
>> +             switch (status) {
>> +             case SDXI_GSV_ACTIVE:
>> +                     sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
>> +                     break;
>> +             case SDXI_GSV_ERROR:
>> +                     if (!reset_issued) {
>> +                             sdxi_info(sdxi,
>> +                                       "function in error state, issuing reset\n");
>> +                             sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
>> +                             reset_issued = true;
>> +                     } else {
>> +                             fsleep(1000);
>> +                     }
>> +                     break;
>> +             case SDXI_GSV_STOP:
>> +                     return 0;
>> +             case SDXI_GSV_INIT:
>> +             case SDXI_GSV_STOPG_SF:
>> +             case SDXI_GSV_STOPG_HD:
>> +                     /* transitional states, wait */
>> +                     sdxi_dbg(sdxi, "waiting for stop (gsv = %u)\n",
>> +                              status);
>> +                     fsleep(1000);
>> +                     break;
>> +             default:
>> +                     sdxi_err(sdxi, "unknown gsv %u, giving up\n", status);
>> +                     return -EIO;
>> +             }
>> +     } while (time_before(jiffies, deadline));
> 
> does read_poll_timeout() work?

Maybe so. Thanks for the pointer.


>> +#define sdxi_dbg(s, fmt, ...) dev_dbg(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
>> +#define sdxi_info(s, fmt, ...) dev_info(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
>> +#define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
> 
> suggest direct use dev_*

OK. I guess these would be more justified if the driver were adding
SDXI-specific information such as group ID or sfunc to the messages, but
it's not as of now.


