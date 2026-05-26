Return-Path: <dmaengine+bounces-10970-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN6AMM4xFmqQiwcAu9opvQ
	(envelope-from <dmaengine+bounces-10970-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 01:50:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2935DDAB9
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FC063094C9C
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F33DB628;
	Tue, 26 May 2026 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="drbQ9TFq"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB213D3D0B;
	Tue, 26 May 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839074; cv=fail; b=SgNgNr7YYqU18xswm0rvPyJYn0uJzm6IhL8awJYUODS6uxeyoEBz9A9a0c6A3xXy3uRmKJMwWg8Aw17m5VlHoNKbgHTV0ohq1TZIQp2XB5jsWVLRUINHQlE0eMPXndJmfML4/HSzE7zP6CDxR8PuG/DteCW4F8zy1d3650fguQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839074; c=relaxed/simple;
	bh=4GlpOFIz29/v1x2BA+qLalb/xEiGdvcqWk641Or3XEs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLQn8GEEJ06QidJ3V3OD7DovoUWHG5SXF2qXqeWBuGZMM5hu4ESQcCsUo/c1ZSF2ozsUlN20+UnhQV4ysrqPuWmVYVo+3CvZJZi3Oqwo/x6OEN8kHhoThB90eFNnXyodiEvxMFfwJrVKHdPGfM00TNTTsTFEroHXXInqNcfL/YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=drbQ9TFq; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+hG4by5hNj+ScFJl8eKz/asUtwsabSg28QOiC9mRYu9GjvlG4Ob2FSGNUn2UyzsaP4dHOsmCY+zdeZYCDYwOFtDlZao7ALmNDfXik4FnpV/60e+RPlPTuWYogz11b8/uMIJI/U1PSD2UapBAjph+oEiFHyv1qzCopYIq6bdozItkuOJO2STTsWQmIcNiLvtE0w/hDcgkzve857oSpvot223+QKFoSZZxscmoxl3DSc6JrRgElGDXOGo1bK3ZHM4UUO5xJcZlb63dH1djIL3y/46UWzabM6L8H9HYWZoOfgPGvpPXLuiSQAcvkHa0de2GIMoP+liPSD+Ayo9aKRtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wTM/dwOfd7Rx8DUyZthcUBtw0EWm1qAjug8jb+uMJQ=;
 b=qBwSD3rcmvSZLKX3zIbqif99b1A0VzH8F0b03YrvBCH/0h1PEgSlXFpVurvvpXKwPdPPEGwRzrIGpLBy7o4A+4k6qZEtSqyLn0RIpgaK4s8RINuXqichLeqmXW+zfQOUgbfQhrWTSrIZ9u70tAUoo6pZJF6LB/gxKcYZrf2j6Ljv9JAj0S/4a9QnmG9Y2sgsORzEm1VoWQ2XKEFaNM5HaDgzX+BvDrnP2PrEkJOyvSCv3o+pkkQJHCBOQ6WbM7MwtuT5vfml6aadjKfmv00Gblh27J0xbjttbXuBwUlbqPJM5cMWMR9FCWZIrnXfR7t0dYRo90cSUpLvRbuy2pV4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wTM/dwOfd7Rx8DUyZthcUBtw0EWm1qAjug8jb+uMJQ=;
 b=drbQ9TFqjuib7/WdsZV0H8wS5308ntRZaQPknOvD0+rxIvnpBFp2SZDDh6d99KEIfSKDoWw/cWM+xCXoNZCYQxRvFVn2UH4q6atqka9Qq4WxComry9qUOfo7rX4bujs35L/h8kh06wu7gz+IYFInH7YbhnBjAAeWCJl6DN8SBok=
Received: from PH8P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::26)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Tue, 26 May
 2026 23:44:14 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:2d7:cafe::57) by PH8P222CA0016.outlook.office365.com
 (2603:10b6:510:2d7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 23:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 23:44:12 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 18:44:12 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>, Nathan Lynch via B4 Relay
	<devnull+nathan.lynch.amd.com@kernel.org>
CC: <Frank.Li@kernel.org>, <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2 01/23] PCI: Add SNIA SDXI accelerator sub-class
In-Reply-To: <20260512235013.1F769C2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
 <20260512235013.1F769C2BCB0@smtp.kernel.org>
Date: Tue, 26 May 2026 18:44:10 -0500
Message-ID: <87a4tl91o5.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 818b5630-c2b0-424d-da6b-08debb80b093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|13003099007|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZtAP9S5KWUiJgkImsTZc+HFgKF9X47OGx05dUE9M9FFbBCd1Kp17N3HDQMJRFWl9uUPYvxrrGktYV7oEECvMn+v3vtj98tWMrU15YwNNnLG6c/TxPQsA24TJitdyLnBGnry7pT6D+U80ZQszVKaWRZxcG2T0UPUHZaVEz3G4f1lDc+f19ObTTkRVsLsnHtbjCu8xkpZF+MYcX7COSyv37QymVYJIE31u2YCN57kUR5pj77wtBFbuunGuYVO83v8b1AaUS7XjagGR0K5UYplZTe14KrRCfuKGSgco9RzgonegerX6zepNdUdVMvfKh0T397grS4Pie1brC1bbojb0zdsVLhcUUifN9vcfWdzkUKascvz32/a67ip/MLNLQEhF+SCwfYnMxlQTwAl7+r+a4NlQd//5/vmD06STj80mMncynY9SrUIDNo+jDXJDCGYGC62JdhkuPzwWYAKs69LVlP32DJH609xzURySSxHYELcW7BT6wsHqgu9YpwrFdenb4OUjg7xu1pxBMLf3cv776FjBv/TpSk/adeo720EIqCCw1/H8u0PS0lp1u4g6s2toPRlhQvKkepVWT6z9og3gY1nZ1vvIU+m+hxd7QsqnDPKpRv0KtK16iNarecPBJ3J5aAnpjkEpSs9jS8ON5O0/gYdfLeDTxC6nNVqjKO27lwM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UB2AZhX7SlZHPWhJS2OpaERb+EdENFyZCT/F7T0mOIBJeG6UJP/MlOfnVycOO8OEgfSxuqgI9I4Mlb3IVlvW24blnwpsXKMo7EDVEaT3oLe5yicQcXgRhEk0X9KhZ9nCR6GppO4qv786IxCrpmpjA1avCevNalkV0Tausr9wvYzwYV9iEwe/2R+H/ODGFoZDopLfIrkDwxqFLFjQKMIYzvbtCKkWWs6XtlLaKbHb1CHbQMAIRP2u1Ec2CbipsoxxxUHW0pyoUfjT3WPYJ+pAj1yP3LdFQd+i+J8CMkod29a5PPyFUrpD3V6fM7I70e1fIDcvmTETnZhjm3MHtCEMKtlpQY2m4io+oFV8odZShMFly6U26hZZrVnWSnHE94EjiQ+zvRA68re0RHYNpdNU4ayIvbpXoZDW0G15HZgO34/ueOEuCxuhnbgQfvCfNIxO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 23:44:12.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b5630-c2b0-424d-da6b-08debb80b093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,amd.com:email,amd.com:mid,amd.com:dkim];
	TAGGED_FROM(0.00)[bounces-10970-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B2935DDAB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] PCI_CLASS_ACCELERATOR_SDXI is incorrectly defined as a 24-bit =
value instead of a standard 16-bit sub-class code.
> - [Low] The newly added PCI_CLASS_ACCELERATOR_SDXI class code is missing =
from the Rust PCI class bindings.
> --
>
> commit 5c21a6a19a3c154b4d13c65d1905d5ed4e273dd8
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> PCI: Add SNIA SDXI accelerator sub-class
>
> This commit adds the sub-class code for the SNIA Smart Data Accelerator
> Interface (SDXI) to the PCI IDs list.
>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 24cb42f66e4b6..83ab3f27eb5a2 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -154,6 +154,7 @@
>>=20=20
>>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
>> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
>
> The commit message mentions adding a sub-class code, but is it expected to
> define this as a 24-bit value?
>
> Other generic sub-class macros in this file are standard 16-bit constants,
> like the adjacent PCI_CLASS_ACCELERATOR_PROCESSING (0x1200). Drivers
> traditionally apply an 8-bit left shift to them when populating ID tables:
>
>     .class =3D PCI_CLASS_ACCELERATOR_SDXI << 8
>
> If this standard idiom is used with a 24-bit macro, it will result in a
> malformed 32-bit class code (0x12010000) and break device matching. Should
> this be defined as 0x1201 instead?

I had wondered about whether to follow this convention but I didn't see
a strong reason for it. I'll do it if that's what maintainers want.


> Additionally, does this new class code need to be added to the Rust PCI c=
lass
> bindings? It appears to be missing from the define_all_pci_classes! macro=
 in
> rust/kernel/pci/id.rs, which explicitly mirrors these C macros to expose
> them to Rust drivers.

Seems like a reasonable suggestion.


>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-bas=
e-v2-0-889cfed17e3f@amd.com?part=3D1

