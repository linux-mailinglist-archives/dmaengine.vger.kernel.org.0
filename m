Return-Path: <dmaengine+bounces-9558-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN4SGasdvWnG6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9558-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:12:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6842D888B
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 393C3301701C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC9367F23;
	Fri, 20 Mar 2026 10:08:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022141.outbound.protection.outlook.com [52.101.126.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF570365A0B;
	Fri, 20 Mar 2026 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001307; cv=fail; b=KUPj+Tra1URfaqQo8juzbdp77qaHSPQgMk7uFudAzzmH/ZX7xm5xl47GmTWHwSSCuQp7K6tr9rEvZhFE3EbRL8mIScOc410vOGCWlpZWM2hk6TtMD6vQ4rywkjZ9JCwh+ZAFn3waoEsSGc9CbQKAyz5c8S+g5ACsoYWreIwccUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001307; c=relaxed/simple;
	bh=ngGTtPl6kAmqBweK2CbZFm1jG+6xCt16v2bYHAbXybI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcQe47Wi/W9NtVJ/ABe+o4BQh3IdedJZFHQUgNN2wFhMZpYlvoC3lbI34KhEr0q9L0y+mr6aVFKoSFBOUS9c7lXJkhOg6K/qYVLXFRTv4LFF9wG2THQ1NETL8XxlvsEofSTU7JrKBQY4O7/WPZn9EA9aLEkICq4nSwBWpia3Qzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtdOC124/vT2qEnNFPtUkCs9uwWD5S5wapOzSoC8BIABarjjHOTvjTz6X7m22LLc88y68EIHAb5pXQt/LNGHR7A3wcBeKGW7mPBIxDI1C/565sJ8xPwmXKzNkyT2qoRe4Q1tLJ0LMJ8UmqbBMQ+NXI9+G6wYpdIMwBaDTBY/It46ogFmjhX5G6mGbfh8JeIxomQZjEQq+IhU98eyjOKXit+R9IHDgSwdSxxrPlPo+rWRf3AtZX41KYGjnzANgit7/SHelDlMm8bQbOsq+d38kf2mBsG9r7ecbgWluCBTnBjJCKhPWByvrTZcIS2NhyI/aXTjkqv1O69w6s0fE/3K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0DtKeMa4Pd2GvQ/CpXa+k2INvnblUOKZ0/9dT+1/Co=;
 b=mfJwiCePlYQq4cVGf9VIwX/JdsiUz5Q2JB2ZE2Iqv8i68/IaO+udC+uNEtmlUSlGB2dsAG9ZCS0UXlhElZn7UPH4VejCvG5wlqdBKY+1tnrLp7Hw6K0/9xCMj1Nz9a5TVExaW9H/pIXvKtdMMn8N4MT+gy8sZC+EIZu/AD48iE746lMbepxNERgGosX6Hv7zi/O8mOiXEwB4jkbk3rEWcBy4EKHFlQAK7i8ZkcQdbAP1L0oAsy1KOz0ISdrtL02fcanJgTHcGuBG4EQ8ulKZjT586NApeX2aeBm0Jfzn3HGjWhUGPuhGfNdVBFJeJBkSYAiGIm7f+PK0Xj06qx2bPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0236.apcprd06.prod.outlook.com (2603:1096:4:ac::20) by
 SEZPR06MB6254.apcprd06.prod.outlook.com (2603:1096:101:f1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 10:08:23 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:ac:cafe::76) by SG2PR06CA0236.outlook.office365.com
 (2603:1096:4:ac::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 10:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 10:08:21 +0000
Received: from [172.20.96.43] (unknown [172.20.96.43])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 173EA40A5A01;
	Fri, 20 Mar 2026 18:08:19 +0800 (CST)
Message-ID: <6d8520b6-04cf-4c57-939d-9baa5ec04360@cixtech.com>
Date: Fri, 20 Mar 2026 18:08:18 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: cix: add DT nodes for DMA
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-4-jun.guo@cixtech.com>
 <20260320-attentive-turtle-of-perfection-c38ed3@quoll>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20260320-attentive-turtle-of-perfection-c38ed3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SEZPR06MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f64f3cf-62d5-4153-1066-08de86689e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oj2SfV11l/ndXC/2ev76MB0r4+Y3WpyB5pj8G0OsVcJQxkE1obZl6/QHZaE18hFHtW8+9FYQB11qEJQ4wVpCbNgKt1WNNpQLAcM0ThDyJpDZJAsPQC5QmWnNXz3cBLWOlnqgIrnn0/Hqv/u9vn7rGrpES4iWiVqTusyouYnqS4ZsXOvAFiKNJZ3Q2qxZDWZfZ1Q4crolDbQjOvnUA9ZJ8pMCjP+bMIMIhsmVlomXK3uhy9B8/UWiQrMeys2+d1Oa1JKcL6DsZ8UmSta2v13fqnIIcmgb/QZgYdSOThJaDUaz9s8qHEY3JHcvGalfQqLRlYs44cZJtnGpUVztYAzz88R3kSBTlTdOC9eh4xNh1IEGyi4lJC2fnEWJiqGRPQz+9/05sAYZq7YfmTMR/7i7IdaUY4S9tBGu+e96jpb1IgQg68sTcbBdotExD24ipUcI1nLuwyUZ20Yi4vC3TNlS6RleHUo0nKqXBpaftHpcfDz1+xWbtKpMSyQ1X8bHvc0V9mPPQhtKJyyHQi0TN+wOXdeckRQp6DMFxL9PafA3ywI/tTbwRZ04en/Zba21Ok+6RY22QywK5eQp4UIXjdXKmYOk/VAFAeI5/vmkVmjq5fh6yR0jwPhgF/7dEYTtQXhUDFDiz6DfRQkoNbPhoA3naEuYVz2N9zIKedvqNC8/Rld12JYCQx9MhljRsmEmRcxKt1RDJIFSZNo7xKq68JbBo5nros+f2uRPRfLgi1fjtVIVnkBw4PsyYrpwCUBUMhO8T6IlusQepNY5C6O2GDp19w==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W9BzTzyH8wLqphb445SousjOp6TKwvFAPw8enGQo5PfI6/9caizQ4Sajf8XCVn5ekiGhLykfK8zQfarHtsAfx0yra63dADTUxjcIIu29u0R8gyZ4tAtNB4PUfrZSy1oDSNPMw7FX6OjeRomxKjtLG2O57FtvlMmQWqUwsFRi/pgYXojBn3ZiWaY1+5Pz2Of+o6xohcVbVAxpMxnLIASGxWLEtEDqXLY4qch5rfQ3r6iPExRR5pjFtPP7tUL7C1hreagoXPueoIsfgvhdBmRS7aBRv1n10RuDxRfVXppQY3QIMSU4GjciNQibcCjqRAdPmE5vTLCIc5mylWJ+xUP4nfdvrilKUyrTAFTdKbrfUhYEak4yAlfRqywaErQK96do7IXjOXntRFZHrDPvjUanJG/ZFX0qyLouv3sdDMBJlpwpoWUZDxaHb/7sexoOs3kE
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:08:21.4928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f64f3cf-62d5-4153-1066-08de86689e03
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6254
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9558-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[cixtech.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.399];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB6842D888B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 5:13 PM, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Thu, Mar 19, 2026 at 06:17:23PM +0800, Jun Guo wrote:
>> Add the device tree node for the dma controller of the CIX SKY1 SoC.
>>
>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
>> Link: https://lore.kernel.org/r/20251216123026.3519923-4-jun.guo@cixtech.com
> 
> How useful is this link? It points to exactly same code, so what does it
> tell?
> 
> Drop all Links from your patches and read the docs how they are used.
> 
Thank you for the reminder. I will fix these links in the next version
of the patch.
> Best regards,
> Krzysztof
> 

Best regards,
Jun

