Return-Path: <dmaengine+bounces-9278-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDHCEP6mqWnwBgEAu9opvQ
	(envelope-from <dmaengine+bounces-9278-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 16:53:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD6214E51
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A4CB303AF3E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E33A7F70;
	Thu,  5 Mar 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R3ZLuUf1"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azhn15010054.outbound.protection.outlook.com [52.102.136.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B417BA6;
	Thu,  5 Mar 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726006; cv=fail; b=ScpVBpuBfO8Z7XLFGQlNVLdYZHlqZMWp433lwhlLovSMpGM3t5H3AAYvEnRH6HI6Y0Y9qNMcvF3ugACoQZaDsprfTSChyIBGxM9MDnkLvhu6xUCIWKHa/4eptchP74vTURMhqUBiJRZChmFJrZGvwgtVbv/udrSNNBOHA+C2084=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726006; c=relaxed/simple;
	bh=4CU6pj1Pdx9dFWWZih4uLUYlVQ4b5yH5sFtB+BbuCKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r9neZKE6GacpCW1ZZxI0KR9QbATfit3qO3M9tKXow59FQfh6BVeY5/+6HsNXrWPersRT21kmzA4aZoCbqZuc58+mKcGgtIO37ay5SnPVH+gU5g2alO+s3iX7JVJCc+GhipMUqZjad8ho+HP6eUzjE/DaDlJ/6/lDykE9lupJdLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R3ZLuUf1; arc=fail smtp.client-ip=52.102.136.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1Bmw1vKquT3VjRpzPjkpN6gHPOxBx8IFBwu/C386sYhEcbK5K+BbCdjQFks7mcvi00pVi6EUFoxREsUo/onwSMDbDw6ND7+CSol+iFLVwA3faIKMQCCLRfrEeTBUptuRFi9k4ibmQ9LYEkNms7qnbqkC+mWc8L1yxl5R7AK3wA106btjLts7eJ3jicyOq1tIfkAM4jCRaTCrJJS+p1/5pUx/jweMv7Lurcwv1iWopYRyMP9rxXRUOfPsXzBIVzKIDbJ80qPHkuS70D9IqE8ORW6eqe+u/84uADiFdL/C4j1ZbWcxmUZjOUxzT/hzWRDts+EGT486adHuTP6vYLDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw2aixUH/tbZ9jCj1bflRepifdxlK0lsktfGzQGgb8k=;
 b=FUOBUKn9Ll/P/FPBH0fex0m+XTBHFFSIUCRYjybVD0rTZBw1CQdFpGm6Rx86oF6XLIyowmN1JjS4TgaQuBBH+A3rV8DW9xjc+i8B3MHKPTODMDC+uve46PdTUOSzvYEFrofImIbwLeWdS/sbAcQcaR5rES62K4HnhFLNfXxnBKPFCWGQVt6no7I5x2pb/CX5aRFlkYrdpryIVc/+IqjQR1Ijg1zkG6A83k/F92an7mrAiPAP1uUaVmeTMk6ucuMS/6p6PfzYIrDlREkV/N+hHFfK37aRik1wQ3aI8VgfZE6XA3qzeGikNLValo5xuCKStfU8VU9/CaDYN6/0uRWmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw2aixUH/tbZ9jCj1bflRepifdxlK0lsktfGzQGgb8k=;
 b=R3ZLuUf1ZzqUynMhcFJ7IxDVuE9cyRoDScGafBGdSQIW8wKbkKpA8OYqscAzQuivtUA+BCzUkMGqA+/hrcSJJp7zwT0cCRMFk2x2X+/QIfCEqMIwnr24RzPNDNkl4VI6JFvUhH1ZYParhgA78rcNeS0Xks3o43ZceyIuBTzdgok=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 15:53:22 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::29) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 15:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 15:53:20 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 09:52:50 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 09:52:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 09:52:47 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625FqkZb2607208;
	Thu, 5 Mar 2026 09:52:46 -0600
Message-ID: <2d852f07-0bd9-4076-b0dd-93425ed237f4@ti.com>
Date: Thu, 5 Mar 2026 09:52:46 -0600
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
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: faeade3c-2292-421e-a379-08de7acf5328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|34020700016|36860700016|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	isAOi5PEPDP7ViXm6eoNCuTBE5jEstc33/p5kT6opN/amQuk1g1TuryGDR7zhJz7r8Tect/1heIGghmXwqvYB72ePI01jUAMTwRQQl0jIS8poNsHUI4/Nrav2bBKER3vrTW1bpREWrBYF44O2+LB4UaLo9jcHhQeUNpESzovOSYM7y+M86Ir9QCE5e5g4A3Rh0Neywe6AavTUOgJGfq8UN8uP8hk3ZX132a4AE7sxXuJN7otvy1gdtSR5oH8T9sJ7gLSNH+TZFxvEPwQ+hduUD0zLwa4vAB6gFbrQuwQ84TOJEN07Xwsmvlelshds/n0kNdycf2sx4IPGMHyuIm4uuK3aPUAW9ektWrzp08hVHgvvniuZeImDt9hmOHHLI/cKGqr/VXFdC3wNuTE5QqdB+wsZyVU22gZv/JKlkg14+J9kG3jfLQJ1Cfcg9igJIZC+F0H38jn454OP2UP6Q4g6R1sPXdaevHg0xjB2G4jDQoTcUl9ZyJdoTQcg81l2TqihppQIYixmPk/5IWf7vpyrYMSrXhNaqVKRXhOoxRI46+KcWLMjBGxePyxyua6Vs5jMWhpsglo30UuXlijDnxJ9TJTGIYnFRUyJN8cuRxlTutBdGi7PgJNJKH2fCdhanK+guVelKeCWiUHVvHTHHAa26dloKedsxBXPKVqrO/bMvA+216XCoSvSACxPjENWzacsaN+DowN/JHNczNP0Ixm9XYNWiTrmtL2aH+dVe46qL0lMwKhpvI4dqpJag/Ho7c8qHy/de1Ab0Y3jRtVpmq/k5bfcAWvOZw/uVoGWrasQooc1jODuCCY0wDUeuutZWGC
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(34020700016)(36860700016)(921020)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z3YY2E7hUfuEY3JAhx3IxLufg9olywII8aAIQ6K358EATpEB9WQrFe0pQhaX8jfZUQ3arRFivRBtNAJiSWE9NFr9dzkI93+i5i/4qYNONy2FjgZRQAa2AxRJ1acUBN4XhOBv3hJqMyp6q7mQGseuK2MjG61R/Zd3aJr39ueS3AJQbXXUe05k24fWssjeiOhwzX777h+k/ayT79JlFBAM/ATnaFQHu/LPR5cJD/JXK9MfXweqTCOo5P30IOfD+rLEuKcjmZ7BSMeHNpLCupm8He57ageCYAwXSGzD9h53/UckDUZ76uyLOiqq6KE+d7Wih+Erfs/UrPAsms4i8qeJiBTxDLCtWF7iVcdLFSLWc7SIlOymvxAix8X0mMdxVPwQWMpSGUaPD8pWVi0Xmug0V6SXRYsjwErhERZ3tYa7KEsaIa1moAho6YxNXaNERcTj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:53:20.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faeade3c-2292-421e-a379-08de7acf5328
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Rspamd-Queue-Id: B7CD6214E51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9278-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/5/26 8:59 AM, Krzysztof Kozlowski wrote:
> On 02/03/2026 20:12, Andrew Davis wrote:
>> On 2/23/26 2:24 PM, Krzysztof Kozlowski wrote:
>>> All the functions operating on the 'handle' pointer are claiming it is a
>>> pointer to const thus they should not modify the handle.  In fact that's
>>> a false statement, because first thing these functions do is drop the
>>> cast to const with container_of:
>>>
>>>     struct ti_sci_info *info = handle_to_ti_sci_info(handle);
>>>
>>> And with such cast the handle is easily writable with simple:
>>>
>>>     info->handle.version.abi_major = 0;
>>>
>>
>> The const is for all the consumers drivers of the handle. Those
>> consumers cannot do the above becouse both handle_to_ti_sci_info()
>> and struct ti_sci_info itself are only defined inside ti_sci.c.
>>
>>> The code is not correct logically, either, because functions like
>>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>>> handle reference counting, thus they must modify the handle.
>>
>> The reference counting is handled outside of the ti_sci_handle struct,
>> the contents of the handle are never modified after it is created.
>>
>> The const is only added by functions return a handle to consumers.
>> We cannot return non-const to consumer drivers or then they would
>> be able to modify the content without a compiler warning, which would
>> be a real problem.
> 
> This is the same argument as making pointer to const the pointer freed
> via kfree() (or free() in userspace). kfree() does not modify the
> contents of the pointer, right? The same as getting putting handle does
> not modify the handle...
> 

In that argument, if we wanted the consumer of the pointer to not free()
it we would return a const pointer, free()'ing that would result in the
warning we want (discards const qualifier).

If you could somehow malloc() from a const area in memory then free()
doesn't modify the pointed to values, only the non-const record keeping
which would be stored outside of the const memory. So even in this analogy
there isn't a problem.

> The point is that storing the reference counter outside of handle does
> not make the argument correct. Logically when you get a reference, you
> increase the counter, so it is not a pointer to const. And the code
> agrees, because you must drop the const.
> 

The record keeping memory is not const and can be modified.

And where do we drop the const? The outer "struct ti_sci_info" was never
const to begin with, so no dropped const.

If the issue is that the handle is not const inside that outer struct
we could fix that,

struct ti_sci_info {
...
-	struct ti_sci_handle handle;
+	const struct ti_sci_handle handle;
...
};

And with that change even your original commit message example issue
goes away,

struct ti_sci_info *info = handle_to_ti_sci_info(handle);
info->handle.version.abi_major = 0;

would now fail to work to compile.

Andrew

> 
>>
>> Andrew
>>
>>> Modification here happens anyway, even if the reference counting is
>>> stored in the container which the handle is part of.
>>>
>>> The code does not have actual visible bug, but incorrect 'const'
>>> annotations could lead to incorrect compiler decisions.
>>>
> 
> 
> Please kindly trim the replies from unnecessary context. It makes it
> much easier to find new content.
> 
> 
> Best regards,
> Krzysztof


