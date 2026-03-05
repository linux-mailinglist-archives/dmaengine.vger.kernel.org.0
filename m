Return-Path: <dmaengine+bounces-9285-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONyHHSnPqWk+FgEAu9opvQ
	(envelope-from <dmaengine+bounces-9285-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 19:44:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D4217170
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5634F3078EBA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363483E5EF6;
	Thu,  5 Mar 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W9/68gUQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azhn15012028.outbound.protection.outlook.com [52.102.149.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727F364E99;
	Thu,  5 Mar 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.149.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736277; cv=fail; b=rtC9tkbB7UyLpXGpUbja9ZeQ4G5zuicz0C0YVCrc7tKyP3j/YonywhoU3R3ofeLE2m6gLu/QiJBoyDHmTj/vWoPuPsEFv53CpRw3ZpOZ9gOYYj2C9DqdvnGE+JOqBMoN7js7eAcRQO6iWG+ES3IOLo0fYs2NB9B8XN9lMv73iAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736277; c=relaxed/simple;
	bh=Ai+6tZHycv8EaTo4HgjE8WOEg/4a16+15V9pRuwGUDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EqNYumterzLvjUjHG3SIh+usRK9OHCJwxCkll9wXCdVQFWIYzcC0vdWrlYwM5JSEd1eeq8aApMn7HgJCrM9vomeCVxbEle0oa6D1xKavjtzAXNzTpQHE9NwVrZH9JTaPlPNBySaV6pfjB+I6UYW9T0jHiITuNmGgVr0e5KGhPvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W9/68gUQ; arc=fail smtp.client-ip=52.102.149.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1SAZpS6ZaqJsZXYfrw0RRTjWhLEkVCZ0eRYS5trB/7Q2VsGTnhObpl8iDfx8B9N8kndbqF5SBGIVLbHzevP/fDuSoBCTgPqveyabi2XLTk5NBFvzGAWuOOiYeuJdzmnmJ3+4uieG+YgyQLRAZper+4V/GDRa3Z5bw0PSWxsrbJ1vPzuiPcAh2+ffK7+8QUZs1LPjCO5l+GIrFVmFDFYohYXeeUucaqe1XWO6JiVeDhPPFLm1v5Ohti/bQ8suSvPc5XZNSXiObtQVyXLyb212k2EyVSPET7vOE6KX6uyyPx0NXpXMwn3I98ZWrBjXB1yGeJ8W+SbH3KeZOkmfFbPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/InfKTyXkgN1PvmXo/6+5rZe0iozex09wg2bfgN7qQ=;
 b=kTsXxskQVid1/icpPYxJ3smD1Rs/AOogtaAvFoMuQcOjanA0GCZ9nDYegyP5vZ3m6MNoxXv0UnTGIUCJJnSqxZxsjEfg45CN8X6dpA02p5wmwGHHrGaYdQesKrwZY0z8/s52903LwWDx6kux5sBDdJel72rbe2Tm6z2pObNMocI2v78IeMoA4tTM7lZJtsbiJbqUxuvLcWWf74dUSGVrVAQd1sg79UEDx+uxPo+BW98Cn/uK9F/8W4hMGm1CE1LXE307BvJn4Id5OE8voAzvoSFG6HX7Ge1JFsU3Ji7R2PWOs3IVGUNKRcofFSiFOsqv2g9cpgPdBKmLV7nfaVaEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/InfKTyXkgN1PvmXo/6+5rZe0iozex09wg2bfgN7qQ=;
 b=W9/68gUQ8B15ZaovfWlonDrEKpyySDIGS0lQ01xTpovJOTwnTRenSu9VaQSOLUQvzHlWQ1pbyRS2cn1w50KITU+hzqzu5e+xarG/Z7PjqrxILm05/BFrQwTUcYLKLiJuwfA8loTeEqOnQdNF1MX5oiWGqlRIw+YNedv3zhBrogw=
Received: from PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::15)
 by BY5PR10MB4243.namprd10.prod.outlook.com (2603:10b6:a03:210::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 18:44:33 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::9c) by PH7P221CA0061.outlook.office365.com
 (2603:10b6:510:328::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 5 Mar 2026 18:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 18:44:30 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 12:44:29 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 12:44:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 12:44:25 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625IiO7G2857803;
	Thu, 5 Mar 2026 12:44:25 -0600
Message-ID: <aa2899ff-a8d9-4740-b256-266f7073f0a9@ti.com>
Date: Thu, 5 Mar 2026 12:44:24 -0600
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
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <c768706e-f063-44bd-92cd-f3984ad3bfbc@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BY5PR10MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3e5d10-6700-41b6-26fc-08de7ae73c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|34020700016|376014|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	01QlmEKCQw7H221QOm+anKMleDiJ9ZE4YBF+79avqADBK4K/enYpewwf3vBq4SGmocoJwpZslIeVWQnb9k2Fgul6SJzHoCKkMhpivWEvyoPgzyiDdjnt3znfqeTsAUwol7bgEb2970jkp2EJlhpScUj3W3ZTzu30KPWWhzriMlj7TYyJAEKfoFRbhzOgYBHU0DJjJ6kBI679tMMbk9Y5qoV/E3xPReQ2CaSYOHuSOuuxJyX9a9tNmZ7V2yQqJBLs3UvDmQpITDrHigp9dm9lrCTUPhpuobKP94ea3+B357wVkI+dLTOzTwlFBzBkAwVYSCmc53/m5APAigdmqzzHUpWMFfOM/Ud64GH81EkMI6NupKVlMuQqNV+XUIZdeOAJo+vDdcm0luCi+UVW2A7haYelsQM5jvAoGrXd5i4+sYzdSa8d2sgvic0z+LcOCsuOiVOekGqDvyUJOZyBsMmKHtIhIpYLbV/SztG6CNNuqkq+z/i1C0UY40C77vZjdTEmFFbR5iyrtbtGUwV5kUGoAQE27Sa0mUxuamjdp1HGH1BR47e+NvV+JK5gdpXLScvxxi65efhcB5vOiWNywvLcW+oYt5RPZI0hDxW95nQ3xLnq4/UPYLZSq+wBuaLrwfStkePFp0Qk05W1DQrly3zwEOw9ezDFXc4P3WgOAgaKXNZDKm2oDjVR650IltpJ2/lWs5dAY9zyqUOzJfTxdEaq9wfLjQfqn7X8OPSxf0AoNHzbEBbN1t2n1Ztpv9pH2kmhD2QYmTn9XpsRWzfjDLZZpQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(34020700016)(376014)(921020)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4FuUm2GQ70MA6Za6CwN0A8qOHHhEcmC3rNs0LekX1f7ImeEC62VJbClbsFHY39fyVoLLKaD6zH/iPc/9gTzX4fBnSgcTigasGu1Z/U5Q6D72mIiK+Wbu7R4H6ImS1o9HlxNBeKmhpgXN90cHxU7T4XVslTSa3PN5w9xNm+FtUbFb3OM6EOxSE+vJ844dWnfuf9FbZ5I5HWbLO2jI4Rf4yoAldUKB+jMoBM7bH5FZ4NypLb0SD6Jc1nqi3B2kxic1HeGQMRQVLuT0bimeV/F13OAS/X5juiFb6pOi+97TCNKFwU3SWEjgQJUw0SzmO4vt8nEQWK2VjPNStDDCJbmNTfarqAaMZm4U7QVmBoEtuRA9i09ii0srbqgExxj36Xxyv+K/R2qc8FhS+1Wvia6bYnXE4bAYN//2PXMQHumMPMnEOn9tSizTkmTLORB0JrKi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 18:44:30.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3e5d10-6700-41b6-26fc-08de7ae73c5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4243
X-Rspamd-Queue-Id: 172D4217170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9285-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/5/26 9:59 AM, Krzysztof Kozlowski wrote:
> On 05/03/2026 16:52, Andrew Davis wrote:
>>>>> The code is not correct logically, either, because functions like
>>>>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>>>>> handle reference counting, thus they must modify the handle.
>>>>
>>>> The reference counting is handled outside of the ti_sci_handle struct,
>>>> the contents of the handle are never modified after it is created.
>>>>
>>>> The const is only added by functions return a handle to consumers.
>>>> We cannot return non-const to consumer drivers or then they would
>>>> be able to modify the content without a compiler warning, which would
>>>> be a real problem.
>>>
>>> This is the same argument as making pointer to const the pointer freed
>>> via kfree() (or free() in userspace). kfree() does not modify the
>>> contents of the pointer, right? The same as getting putting handle does
>>> not modify the handle...
>>>
>>
>> In that argument, if we wanted the consumer of the pointer to not free()
>> it we would return a const pointer, free()'ing that would result in the
>> warning we want (discards const qualifier).
>>
>> If you could somehow malloc() from a const area in memory then free()
>> doesn't modify the pointed to values, only the non-const record keeping
>> which would be stored outside of the const memory. So even in this analogy
>> there isn't a problem.
> 
> I am not saying about malloc. I am saying about free() which does not
> modify the freed memory.
> 

And if you look, kfree() in Linux takes a const pointer. We also do not
modify the content of the pointer we are given either, so we should
be okay using const by the same reasoning.

>>
>>> The point is that storing the reference counter outside of handle does
>>> not make the argument correct. Logically when you get a reference, you
>>> increase the counter, so it is not a pointer to const. And the code
>>> agrees, because you must drop the const.
>>>
>>
>> The record keeping memory is not const and can be modified.
>>
>> And where do we drop the const? The outer "struct ti_sci_info" was never
>> const to begin with, so no dropped const.
> 
> We discuss about different points. I did not say the outer memory is
> const. I said that you drop the const - EXPLICITLY - from the pointer to
> handle.
> 

Only because container_of() forces the const to be dropped, that is out
of our control. But we never modify handle though the non-const parent
struct.

> And that API which gets a handle (increases reference count) via pointer
> to const is completely illogical, because increasing refcnt is already
> modifying it. Just because you store the refcnt outside, does not change
> the fact that API is simply confusing.
> 

If the refcnt is not inside the const struct, then the contents are not
changed, therefor const is still correct. Even if the content of handle
were in fixed ROM, nothing would break here.

>>
>> If the issue is that the handle is not const inside that outer struct
>> we could fix that,
>>
>> struct ti_sci_info {
>> ...
>> -	struct ti_sci_handle handle;
>> +	const struct ti_sci_handle handle;
>> ...
>> };
>>
>> And with that change even your original commit message example issue
>> goes away,
>>
>> struct ti_sci_info *info = handle_to_ti_sci_info(handle);
>> info->handle.version.abi_major = 0;
>>
>> would now fail to work to compile.
> 
> But you cannot do that for other reasons in your code because you DO
> modify the handle in all the APIs which you call "pointer to const".
> 

Show me *any* API that modifies the handle. The *only* time handle
contents are modified is when initialized in probe() and functions
called only by probe(), never in any API function.

If the thing making this confusing is that the const gets dropped
by container_of() then it seems there is a new version of that now
that explicitly fixes that issue we could move to[0] with a small
modification.

Andrew

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/container_of.h#n26

> 
> Best regards,
> Krzysztof


