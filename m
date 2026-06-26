Return-Path: <dmaengine+bounces-11819-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PlCVKGyaPmqIIwkAu9opvQ
	(envelope-from <dmaengine+bounces-11819-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 17:27:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F04076CE782
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 17:27:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=oEiJJIEz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11819-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11819-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7464C3013A82
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FB37F000;
	Fri, 26 Jun 2026 15:26:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F337B3F9
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 15:26:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487606; cv=fail; b=sZexnn5CYKgaSgnFq8NZ/abOIUHOTLY0VZ06DJxTbKVvDifNqjfzswMGwXhLK3UQj8eAqanWqrlfDI+/pYC8j7tcJ/BUV8zk5JTg5OKOh80BdZCcXi3qWEmFYNJ+4fExhc6hkF4+/4qbYQ/o2LAfI5TiRgFgkgr1V6264D4RVxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487606; c=relaxed/simple;
	bh=rpR9LkYV1hmN/b5h2T0iiiuMjEmMyRZFaTt9vfeUhtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxdB+vEK6dXp+w7mEL9GRsIQMQ3Cwh4VePxQds0MN0OR1gSBKAInGdIqtbQMSd+4j/Mg1QHgRtJgHeCaAkstb/3STFAwAMdptAwDIuKAhXTPnz6AMB/abYCR7hBdRfpZJN5gvgkpL5ymoFS/OSt4gYUqYHVNLgeo0xlXIDtx8x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEiJJIEz; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRuIK1JJZ6UFPWgYN/HGmRc69gqZXncfiMi2uHpKw/84j8ptmH3nj2PkHF/ztlqKqJ/nkidGkDchYDrxTdZd8HojeS9CMosc/4A0U+tPVYrG0rGqRtd0hPvCg8Hbjy5c8hGXU9DfGWZkUr3EoylM1dQET5IamC5ycOpraC1v1mBbQib368Lu6T9L/jZB1gr/HFtSJbZNqXKWjDxdiKtv3ISHY+l2+TI9VbiB3ZDch/eL04iS7FlnnqWB+Tjl7NX3UjLe0RNO++6E88MW5NfFpu3ennAdH+GfVKzBQlIe8nCemSQa7TAG8tvNlAo3efIaPwaXd3Gj9fVWZjziE7oSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xFdHiqlS35MscSY9dJA1+H2sYQ4jQCU/gr+E3jfV08=;
 b=q1RN0+Ikc4XadGSwNZUzaR5XbAcnOwKd1GTp8JRNte9TgVrzuRMQT16O3NyCu46fvo25F8tzOsCNxthEEJcRQUVisKHSDsm9tybFmV6GawyzzlmT376HnjVwDFyYd0NpBmXCOYqTw+0dCUvnjxe8LCo+2TaCm7M7PGksOiFLEs+RvTILFxaX6Oj3bk1c6QmSGM07BJWgnzvPKAs43tKM/f/n45WxYk2vZNzyYoyal9R+UrTvFqp1Pm63/bL3+/QLPgMZQP4ztutOefoojclZ8D2YcraspsLxnugJUsgbQkvSLWp2f3ALerdQ3ekkMxqv4DKrIvE3krUDjn8ScKnsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xFdHiqlS35MscSY9dJA1+H2sYQ4jQCU/gr+E3jfV08=;
 b=oEiJJIEzXbVsX/4+/LHahFyU3BoAoEbBlPiVv3bcgTXOS9VItZgpDZfynStkg+XywZvz1gF0wC+LVUVp828NybJNRAVK8oCBElAghNqHTI2r3YFqwQM3PTOsh1Un4yLuYYQSU0kAjMd/jz2B/nhwJfhOqGK68y4p8haMUTQLTro=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 15:26:41 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:26:40 +0000
Message-ID: <3ac6b44c-febb-4c20-a737-aba34de5c208@amd.com>
Date: Fri, 26 Jun 2026 20:56:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: sashiko-reviews@lists.linux.dev, Devendra K Verma <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <20260626134641.87D161F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260626134641.87D161F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 355d00a8-f45d-44dc-8683-08ded3975239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9UbZu1fJonkufeJfaPW0ew77oAt7m8D01fe2/bOZrPD/Qq332gdmSNy6R6zqtgXixQ8lj/Wr+wk9hJiUp6GcDErkLkS+fnWgohVk7NfZal8CaZBdsRsPKfkO0htQqJKoA03jLAc8LAVpZK8wwFQ2fzoQNS+fC2uQSNfchDM5xnUXkiRnOpvop58/hO2hnp8jGEuGOk+ugHUlO4wliwvDE6fWq4u5Kr6D9oGLaSu/Tb6P0+wBquBLwJa4NdaXXbNA2qfxfQqKmeXE5V9gKRDEdgG5nHsfrawZMn/AZXt3Qn0lqfgVOnTtKDN1QRJSmVS43D28dBK+UoTOe877u/bdPd7jxl1J0f8PjZZzhmGYXxg5nLlZAJDTCSg28CatTDRGL+SOX+IXo+KvcgcpfFna8itm+uxYaLWVPnPY+qEoa37bG+HiH0G6b1Z7F2HMnZgNC5C9K6HGUibVViWe+fXY5p/FH0J0oQ3MVLBgNSPBaZAAPGn3w2xRRpylBVJKg86T1pabhVRZZyZiK+qDhjMIpTlWajN7elARWE4PzfqDuX9lVLrxRkCzALXCEwoDX74KqWVFKD1JmgYhnwzcUhsC/DQ7bijYOm+4C2qwkP7mrDAP/8hZD/nLJqnuD/7tWgpd8bZVk8l4EF/L8gGr5pJZF/ICFfziTAvb0zBewxAM2Yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU52MUZudDVtdERncG1DbEJHSU12NlFFWGdKbHNTOSt3bmdHVnZFRWVKQ0N2?=
 =?utf-8?B?THpMZmg1b1hOY0NPVFFEUm82Q0JUdzQwVnRVd1BNcXgzQzFyWGVJeFhPNVVp?=
 =?utf-8?B?L0VpQnQrY0lwN1hIMzVCMi81UmNQYmFWdkE5Sm12ZmtLeEJaeFE3ZGRRL2ZP?=
 =?utf-8?B?OEFDQkkwVDh0aXJSQVNYMUllNjF1VUlwSWNkRkdZV0syc2lRbUZtbnY5K3U4?=
 =?utf-8?B?VlAzMWxRbFhZRjZsSm53c3RwYmJBU3B5eUNCY2Uxa055N2p6c3RoakJ4c0sr?=
 =?utf-8?B?MjByWjhWWjVMMmkvMlMwK3cvSnY5c2dmMEswUVZOUmwwYU5WaWcybTBienVa?=
 =?utf-8?B?UE5vMVMyQm9RcGQxNFhZYmV1SThFRS9vUE9YZE53ZHFURmEwNnBYeVZyWkdz?=
 =?utf-8?B?RTdrTVNsOVFJdkY5OS9xTTlVRE5wNVFRTy8rbDhOWlF2V2ViZ2tKdUZGb1Yx?=
 =?utf-8?B?OEJoOVdPeVlCNWFJVVdORkhvMEJRMVJ5UExyMXRDZyt4WWhCRURJZy9JczJP?=
 =?utf-8?B?SUNuTnR3Y3FIRlhiL2F6QWo5ak1UQWVzR013K2Flc2Z0MkNWU005blYvc25G?=
 =?utf-8?B?ZWxMVEdSNi9KWktaUnZQMUJkNE1xNEwrOGhPOU5McnJrT21PSkpocGJGU0Fr?=
 =?utf-8?B?cHU3QzVONXJEYTc5RXRUZ21za1hiMUF3eEUwRml1RkhpVWVYWXRsT2xQMXF4?=
 =?utf-8?B?bDNnRDFtdDF6eW1qVW1jNmhIUkp2QTA5enl0RFduenFOanp5bTRQWjQ0bGlF?=
 =?utf-8?B?dkJNRkVaSGorMDZvQVNlRG1xbmFTYWFWZmVLYWZVclZrU0hZSUYvKzBxVmVv?=
 =?utf-8?B?UklpemUxYzk4TGRjTGV1V0Z0d0R1Tm5GUHZZUURySTdzLzJZT2tZajNGc3Bz?=
 =?utf-8?B?aE9lZzVCSTFMT09SSWV5VU5DYUNnRnMzMkErYTl3TzFjVUdiQ0RRdFlyM0dD?=
 =?utf-8?B?Tm03NFlDVkpCREh1VnhCQStGVFVXTDNadXVEVEFIeXBzanNLcHVoVk5YbUw0?=
 =?utf-8?B?NGY2OFlDbFVYUDZlc2EzRWNhN0dna0NBWDFGUzBnTDFtbkFtVUZjd1UyK1Ra?=
 =?utf-8?B?Y1lnd2xhK2RtV1B3b0srcDRSc0Q5MzRlU3pNRDFKL2twdjBRUnNuZ2VnQm9W?=
 =?utf-8?B?MTlvOFRLT1VTWGFRZld1eXpjTFBLdmxpRG1xNGljVnB0ZHd6VHVGVTlPR21i?=
 =?utf-8?B?NU8veUZ0TDBRcHFTNWo3dk1mRzJuQjN1M21PZ3VSWmk1MFE2L2RobmltMElk?=
 =?utf-8?B?RTRtOVU0WEJOTXNvM3R4MVdPbWNrQkYzVFVQemU4cVBIWHMxay9BZjVuZ01w?=
 =?utf-8?B?RldoRGs3eEkxdENZTEF2ZnBlc0ZJWUxVTlIrZ0loK3FPYnZTV2c1U1pRZEdE?=
 =?utf-8?B?dXhJNG9ta1ptcXRLczlMWUdWTXdhQmJJSW9DUWFFcDZad0JDUGpmL0F1aXlQ?=
 =?utf-8?B?MGx0KzY1SXdaQzVTU3hIdjJaZCtrMWxFOWNZdkZjM2dwRXRKR0s0VnFpK0pu?=
 =?utf-8?B?QWd1VkNFYS84RFVVdU1jWms1ZzNocmNQS1FuOW1rMDNBb25TVHI4eWdnZ1Qy?=
 =?utf-8?B?ZHJ3VExLQy9Nd1N0dkM3S2pzRzJOcS8zQVNCVjAyandjNmsxZ3h3ZVBpclNt?=
 =?utf-8?B?YmMyRjUyUGY1eGxsY05jd3JqWFZ0WTRiMVJwRDlLUS9RdnRqNkFTZnZ0cVg5?=
 =?utf-8?B?c1FwLzh2ZXpZdVZhZm1VT2xubTRmelRxY3J1RisxNnRWTmZKcXdHYUhYL1lN?=
 =?utf-8?B?YVo5TmVDcXp5eWhlaVdFZGNYbDZheDMxb3RXMlN6cXNwSVdhSHlFaGNyTWVN?=
 =?utf-8?B?dXlDL094QWF2M2ZjVEk3L0RQYWVMeHpFSHZ5ejZ5Nmlsa09zN3cvMjBHcGcw?=
 =?utf-8?B?V3J6QWp0SFBBUThrUzRQM25UeGRGV3BEUzRrS3pXQW9HQjd3UDAwWWYwbkFT?=
 =?utf-8?B?bGVLQngwcmlGbmR5Q3R2RittZ1BSOTFVM2hvNEJpbVUwTDZwcjhidlNaZ1BQ?=
 =?utf-8?B?MGpwelkwZm9rR3NQaVI0ZzRFYVJtMG9GWEZLL2dGSWdjVlRvdGlYQWRCSkxE?=
 =?utf-8?B?dTdNaFZWenVWVVoyQ2JpL051QStYZUlzb1NHUXRvNXZveUlQQitxazFpOVRo?=
 =?utf-8?B?TWNCQnRZalBCTmRUS2VoWnBVU045YjlLSmdTVU1VYUJKVzNjSTNwaEl4WDBJ?=
 =?utf-8?B?TU85Rk9FaFdCUXFUZlh3aFB1V0NMOHVMMHBlVXRydGNGRzZ5VTZKL0RBZEpE?=
 =?utf-8?B?cnlKSytKcnpTeU8yUGdzL3hzTkJTdVVpbCtGeVFPOVVEMDNjMXgwYUJvUkYw?=
 =?utf-8?B?RVFNcG5Wa3EyazJ3TElDT2NtakQzTVpiZGIvOFJzcDVjeDR4d1ZOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355d00a8-f45d-44dc-8683-08ded3975239
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:26:40.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KS5A/Br73RhhxFcyuv3734CNtknqbDp1sDlUOqHpqi0b6sjR44LDFXlrgGs+Z3pEb4Ur5s/t8g52GF8y1LeJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11819-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F04076CE782

Hi Frank, Vinod

Do you have any suggestion about handling of the repeated comments from
AI?
On every version of this patch the similar issues have been raised and
I am replying with the same answers as many version-times.
Please suggest so that multiple replies to the same queries by AI bot
can be managed.

regards,
Devendra

On 26-Jun-26 19:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The DesignWare PCIe controller integration rejects eDMA initialization for HDMA platforms with more than 8 channels because `dw_pcie_edma_find_channels` and `dw_pcie_edma_irq_vector` unconditionally enforce the old 8-channel limit.
> 
> Pre-existing issues:
> - [High] The arguments `dir` and `ch` are swapped when calling `GET_CH_32` in `dw_hdma_v0_core_ch_status`, causing it to read the wrong hardware registers.
> - [High] The driver requests shared IRQs before the interrupt context data is fully initialized, exposing a NULL pointer dereference window if an interrupt fires early.
> --
> 
> commit cc43ddee72586cbf9f93d80ae20f2b0a9e539a31
> Author: Devendra K Verma <devendra.verma@amd.com>
> 
> dmaengine: dw-edma: Enable HDMA 64R/W Channels
> 
> This commit updates the DesignWare eDMA driver to support up to 64 read and
> write channels for HDMA. It introduces HDMA-specific macros, adjusts channel
> counts in device structures, and switches bitmasks to 64-bit to accommodate
> the higher channel counts.
> 
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>> index c2feb3adc79fa..adf1b3939f96c 100644
>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
>> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>   	struct dw_edma *dw;
>>   	u32 wr_alloc = 0;
>>   	u32 rd_alloc = 0;
>> +	u16 max_wr_cnt;
>> +	u16 max_rd_cnt;
>>   	int i, err;
>>   
>>   	if (!chip)
>> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>>   
>>   	dw->chip = chip;
>>   
>> -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
>> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
>>   		dw_hdma_v0_core_register(dw);
>> -	else
>> +		max_wr_cnt = HDMA_MAX_WR_CH;
>> +		max_rd_cnt = HDMA_MAX_RD_CH;
>> +	} else {
>>   		dw_edma_v0_core_register(dw);
>> +		max_wr_cnt = EDMA_MAX_WR_CH;
>> +		max_rd_cnt = EDMA_MAX_RD_CH;
>> +	}
>>   
>>   	raw_spin_lock_init(&dw->lock);
>>   
>>   	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>>   			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
>> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>> +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
>>   
>>   	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>>   			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
>> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>> +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
>>   
>>   	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>>   		return -EINVAL;
> 
> [Severity: High]
> This is a pre-existing issue, but does the current probe sequence expose a
> window for a NULL pointer dereference if an early interrupt fires?
> 
> In dw_edma_probe(), we call dw_edma_irq_request() which registers a shared
> IRQ handler:
> 
>      err = request_irq(irq, dw_edma_interrupt_common,
>                        IRQF_SHARED, dw->name, &dw->irq[0]);
> 
> However, the interrupt context data (irq->dw) isn't populated until the later
> call to dw_edma_channel_setup():
> 
>      irq->dw = dw;
> 
> If another device sharing the same IRQ line triggers an interrupt before
> dw_edma_channel_setup() completes, could the handler dereference a NULL
> dw_irq->dw pointer?
> 
> [ ... ]

As this is pre-existing issue, it shall be taken in a separate patch
series.

>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 632abb8b481cf..61064de293b85 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> [ ... ]
>> @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	unsigned long total, pos, val;
>>   	irqreturn_t ret = IRQ_NONE;
>>   	struct dw_edma_chan *chan;
>> -	unsigned long off, mask;
>> +	DECLARE_BITMAP(mask, 64);
>> +	unsigned long off;
>>   
>>   	if (dir == EDMA_DIR_WRITE) {
>>   		total = dw->wr_ch_cnt;
>>   		off = 0;
>> -		mask = dw_irq->wr_mask;
>> +		bitmap_from_u64(mask, dw_irq->wr_mask);
>>   	} else {
>>   		total = dw->rd_ch_cnt;
>>   		off = dw->wr_ch_cnt;
>> -		mask = dw_irq->rd_mask;
>> +		bitmap_from_u64(mask, dw_irq->rd_mask);
>>   	}
>>   
>> -	for_each_set_bit(pos, &mask, total) {
>> +	for_each_set_bit(pos, mask, total) {
>>   		chan = &dw->chan[pos + off];
>>   
>>   		val = dw_hdma_v0_core_status_int(chan);
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible that
> dw_hdma_v0_core_ch_status() reads from the wrong hardware register by
> swapping its arguments?
> 
> When checking the status, the GET_CH_32 macro expects the direction first,
> then the channel:
> 
>      GET_CH_32(dw, dir, ch, name)
> 
> However, dw_hdma_v0_core_ch_status() passes chan->id before chan->dir:
> 
>      tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
>                      GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> 
> Could this lead to incorrect channel status checks?
> 
> [ ... ]

This issue shall be taken in a separate patch series.

>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e3153..da7a5cc93ad43 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>   
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
>>   
>>   struct dw_edma;
>>   
> 
> [Severity: High]
> With the expansion to 64 channels, will the DesignWare PCIe controller
> integration reject valid HDMA configurations?
> 
> In dw_pcie_edma_find_channels(), the code unconditionally enforces the old
> EDMA_MAX_WR_CH (8) limits:
> 
>      if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
>          !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
>          return -EINVAL;
> 

This particular function targets non-HDMA platforms which suggests that
increasing the channel limit will not affect anything here.
This code shall be retained as is. It is not affected by increase in
limit for HDMA channels.

> Similarly, dw_pcie_edma_irq_vector() enforces a maximum of 16 vectors:
> 
>      if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
>          return -EINVAL;
> 
> Do these bounding checks in the PCIe controller driver also need to be
> updated to handle the new HDMA_MAX_WR_CH and HDMA_MAX_RD_CH limits, to
> prevent the device probe from completely failing?
> 

This shall not affect the working of IP, with minimum interrupt count of
1 also IP should work. If required, it shall be taken in a separate
patch series.


