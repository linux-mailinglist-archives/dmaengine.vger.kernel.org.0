Return-Path: <dmaengine+bounces-9350-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJQVNsDNrmnEIwIAu9opvQ
	(envelope-from <dmaengine+bounces-9350-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:40:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3B239E12
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF93D300E49B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6C3CE49E;
	Mon,  9 Mar 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kjo+SFQV"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59E38E5ED;
	Mon,  9 Mar 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063572; cv=fail; b=Pkf1Gw9yKf/a7F6PeEZl6K4o8WQAnW5Iwxn4ulNd/0tuwUINd73RHUTVC9s1kzQ4AOIDFy2pkYWCrkT6rWuPy7gWFkMmfzTNF9Msj2cTmhXM3LCusS/S+FZm1pHqqc07GYu+zIu0qizAYN1Wu5MAh3jVX7oMnukZyPvSAQ3DUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063572; c=relaxed/simple;
	bh=KmGiNTGmcB18G5yhTQG5sD4cTkQUsn3K5VM1SCUUFHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d4vrOS1OD8rChgVXJ5ZWRxUhxs2XnJ30fZM9dyZGdaA6wshTSy8SpwumNqkVvQHFAAL3EBWRCT3UKwohBJkkSlZOxRwcSr2NogQyKDdkfY2l/6VIA7mpI+Z71NSYRhl02oEj7wIiRE77J1HgSQi3Cq/sbiVtALJjPS9NeG14UVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kjo+SFQV; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo9wUOOf5MK3XILPnqM+s27sbweHxcJoBIC4Uw3Y7QPEh7Elb/7GMb8iCwaDahnZ/A/qkqhYJ6HEL1G/RU4IQz4ScFiz1PFScBxIP3SWZKegMflh5vOQgCbtZk+vgZdVmhVj7uACcQlWIxSv09u3wqpwQosZ/5hyK/btnD9Tw7IIb0N5si1J/ECZsegcnkvBIIhZdMDw8JPXDqKU0QcabwuA0+SKUbA7hV5TBocP3nCy6rjw2AAo4WmVVDETsf2inI+wMWPg+jQAmsn7ozWKf2d3rgxH1fIDmQqFARukGRFUrMnx5kLAxhllfDjkVVCc5wLHU5QXC4K44zfrsCtTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHB7E9rvIK3PIs7krEYIUdRpKD6Ij8/0f1N99mop3Nw=;
 b=ABWVQqomxSyo0nv5eT1n+nDSwzRZKvajl6z7oDnBEGdM95o9gQm+mwaowsdQBA/bq+JtvJxETVuwZItBHUNZeBfXQn64OEKqxJMYJQdt49Pvo1mQwG1WB/xDrJPq+2SbTmaab5Nyb3xNzSW6IeCYx8nisfaA/TL9QI5FyPl/rSTcO+mZ8LUlBTtawYDSEwRpeYRIcaRj87iAQRztAF/jRLuEVnAwHYzm3VJt4+leKOMjiseYnzJKUNBPaZ5Xn/CGOaxExMzhEOTPOn9wcb9w4scLpCb5533hbwpfBdQE8L1rg6jXrUAzSnGp69pP+OS2dXGPNUImAuFxWd3X5Z5GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHB7E9rvIK3PIs7krEYIUdRpKD6Ij8/0f1N99mop3Nw=;
 b=Kjo+SFQVyDdLqYCLWRj1X6T8+liFszL2Kgw9jBneRjhEP+g3e6PmqQuRYUjXrTh3iBebaA8cVnwBjKjYANE1VLCzBY7+OYuASFNAqmhaGrplm73gNT00NCaECJhU/vExEEm6rv4/wY4dKCUjW3ngAua9Ge9qwX0uy4EUAS7NVKM=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 13:39:24 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 13:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 13:39:23 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:39:23 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:39:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 08:39:18 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 629DdHNi1182586;
	Mon, 9 Mar 2026 08:39:18 -0500
Message-ID: <512c8f92-f56e-4bb7-a6c4-aef7c4120bce@ti.com>
Date: Mon, 9 Mar 2026 08:39:17 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: sci: Drop fake 'const' on handle pointer
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, "Vinod
 Koul" <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bjorn Andersson
	<andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Dave Gerlach <d-gerlach@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
 <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
 <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
 <2d852f07-0bd9-4076-b0dd-93425ed237f4@ti.com>
 <c768706e-f063-44bd-92cd-f3984ad3bfbc@oss.qualcomm.com>
 <aa2899ff-a8d9-4740-b256-266f7073f0a9@ti.com>
 <7aa1e643-a557-439c-a337-20575adf1e35@oss.qualcomm.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <7aa1e643-a557-439c-a337-20575adf1e35@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: d717b4b3-0775-4cad-2cf4-08de7de14674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	4r6gJI54oASuTREFVtD5zQzAStqRMfRzWIO5+2FOQef9MFsTRwPjBhrE2U7hFOlLhRPrRG3rg8bZqUscgc27yW+ZR8TnwlrL/iPRZjcWSED5K0f39RafBizsODKl4l3qaJsWiQWn77ssLhunxOqLF45cnQ1fUmccT3e/WpHOaSrY8XuHRb9WHnpm7dEumSauGYeidDr+h9LhipQWCSo3WA4Xax5s6rh2zu7wRg6hLjr3xqhcPs5t1Xv0yfuwmPWqLxkNHHd5+EiAYQsoUIKsx9h0kYOrBp6LsGAHTGenU8p0+r+DdMI8itClxs3nMQ9CSp0Za32M02ABOb7dV0JBHk5J4M1lzLCZAVKEiA0ZZhiCAgTZSVgWQ7zcx7eezyQzy+EKK0cdCeb+odQxqoKiSL+zVBM7ZAQmHb7l/t1C6nqQAAbuFRPsDVLkV1BwWitFwzyL66hMMAi5kuq7Q8xG2G1UpWdZx0meISEuym7wTD0CNf567hdmLnhy7nBDz0Ier9TFh6l1dwTC0QYrwzLGuir3gWfLPjJz+Izm7sjlq7AzYGiOZFmnNHtZTIFgeiEJivWD6LpHL8pWuQMWVzoOgC91i7chbxcK+CyJ+uuRTK6OCIeX7ir9SCFGDfhNvUaS9S2Cj59Vi0rtJVURwEYCo8ioPhitSz1RxDyPKe2Yg7Wr1XeJWLA1pu4+T9Og8b2nZPz0na8IpwjatTKrFLeVuCcVgFuZ/jM5uUW45BJYPxcECwG13OKKpxp2VdDvkvf30cXw5aED3M5FCbHEcWfwNwalxSz3BqoFljp0iOVsHhB3KaxPrDNbm30ZhqiXzjHN
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5j+x3jwTJvfMeRrTLYr6h1qr6lXnOTzmUccfV0AoKrOLUCLzjYlJ76OBhsZv3lN/R1UZOxa2gm2BPlGcrlEJqG6++FMLrSrCtkRJ+0dlNcYx//UNUGxx+OvNbqJYvtAN66N9ghk+bNCDEOpun1d7mUfjXLH/hS3pLBR0MafeUYp0Ffk19atfgFiBHZmTBn9eXkCH6hhLAJrV/HiP+TghzVHq+z+fETOB0dDj0yXOriIFdjtFJCBeO5naFfKlo5vqUdZb5k36oRV+0HeIRvBOPRoKYVhhM4YdpXl4QNVsKCk/wtboCvioolZMCADDzCwZYIrJQyapa1I8b3PLynXx6qz+flFcBY9ZWracT7iXDOSd+81erXhbWbZyb5Rbw7Sp0Ii5ikbn/uEnDknSImO5PQaud4HzngFSiwZ87kS2kIoaI39AEmPlZAUU9Jh8tuwL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:39:23.5522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d717b4b3-0775-4cad-2cf4-08de7de14674
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Rspamd-Queue-Id: DCF3B239E12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9350-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ti.com:dkim,ti.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/5/26 1:49 PM, Krzysztof Kozlowski wrote:
> On 05/03/2026 19:44, Andrew Davis wrote:
>> On 3/5/26 9:59 AM, Krzysztof Kozlowski wrote:
>>> On 05/03/2026 16:52, Andrew Davis wrote:
>>>>>>> The code is not correct logically, either, because functions like
>>>>>>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>>>>>>> handle reference counting, thus they must modify the handle.
>>>>>>
>>>>>> The reference counting is handled outside of the ti_sci_handle struct,
>>>>>> the contents of the handle are never modified after it is created.
>>>>>>
>>>>>> The const is only added by functions return a handle to consumers.
>>>>>> We cannot return non-const to consumer drivers or then they would
>>>>>> be able to modify the content without a compiler warning, which would
>>>>>> be a real problem.
>>>>>
>>>>> This is the same argument as making pointer to const the pointer freed
>>>>> via kfree() (or free() in userspace). kfree() does not modify the
>>>>> contents of the pointer, right? The same as getting putting handle does
>>>>> not modify the handle...
>>>>>
>>>>
>>>> In that argument, if we wanted the consumer of the pointer to not free()
>>>> it we would return a const pointer, free()'ing that would result in the
>>>> warning we want (discards const qualifier).
>>>>
>>>> If you could somehow malloc() from a const area in memory then free()
>>>> doesn't modify the pointed to values, only the non-const record keeping
>>>> which would be stored outside of the const memory. So even in this analogy
>>>> there isn't a problem.
>>>
>>> I am not saying about malloc. I am saying about free() which does not
>>> modify the freed memory.
>>>
>>
>> And if you look, kfree() in Linux takes a const pointer. We also do not
> 
> The slub, but that's the only implementation being I believe frowned
> upon. The mistake made long time ago...
> 
>> modify the content of the pointer we are given either, so we should
>> be okay using const by the same reasoning.
> 
> That's a mistake so you cannot use the same reasoning. It's bogus and
> bugfree to take a pointer to const for any kfree(). Just poke MM folks...
> 

Don't act like I'm trying to trick you by picking some bad example, you
picked kfree() and it just happened to showcase my point.

> 
>>
>>>>
>>>>> The point is that storing the reference counter outside of handle does
>>>>> not make the argument correct. Logically when you get a reference, you
>>>>> increase the counter, so it is not a pointer to const. And the code
>>>>> agrees, because you must drop the const.
>>>>>
>>>>
>>>> The record keeping memory is not const and can be modified.
>>>>
>>>> And where do we drop the const? The outer "struct ti_sci_info" was never
>>>> const to begin with, so no dropped const.
>>>
>>> We discuss about different points. I did not say the outer memory is
>>> const. I said that you drop the const - EXPLICITLY - from the pointer to
>>> handle.
>>>
>>
>> Only because container_of() forces the const to be dropped, that is out
>> of our control. But we never modify handle though the non-const parent
>> struct.
> 
> That is not true. You could use container_of_const() if you wanted to
> have const. You explicitly drop the const, code would not work without
> dropping the const and this is the problem.
> 

There is no dropping the const, the parent struct was never const in
the first place. Only the handle inside the parent struct is const and
it can stay const and nothing would stop working in any API function.

>>
>>> And that API which gets a handle (increases reference count) via pointer
>>> to const is completely illogical, because increasing refcnt is already
>>> modifying it. Just because you store the refcnt outside, does not change
>>> the fact that API is simply confusing.
>>>
>>
>> If the refcnt is not inside the const struct, then the contents are not
>> changed, therefor const is still correct. Even if the content of handle
>> were in fixed ROM, nothing would break here.
> 
> I am talking about API and again you go into memory correctness. So
> again, very simple: any refcnt get taking const data is bogus.
> 

Modifying a refcnt stored *inside* a const struct is bogus. Keeping an
external refcnt about a bit of const data is perfectly sane. When the
refcnt goes to 0 nothing happens, it's not like we go an free() the
const data or anything. The refcnt exists just to print a warning if the
count goes negative, nothing else.

Andrew

> 
> Best regards,
> Krzysztof


