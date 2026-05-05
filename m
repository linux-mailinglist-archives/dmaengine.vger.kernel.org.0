Return-Path: <dmaengine+bounces-10219-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD71MkPz+WmcFQMAu9opvQ
	(envelope-from <dmaengine+bounces-10219-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:40:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2594CEAC6
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23879301DE30
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6447CC6C;
	Tue,  5 May 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FwPYh0op"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3847A0D1
	for <dmaengine@vger.kernel.org>; Tue,  5 May 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988037; cv=fail; b=duRTC2pH7C95pq0Nj32OD+VP6JaqhQHMGNPAq1nKboBX3/+pjevOmM1Svtm7jfzb8IgTp4UlkeVcnAYix0Ud8nBOyvXncGbrRamPOd4xs+AfnqAkI0rIlazLii6dhJkQEGElDnXMQxtJRXYLS59+Ex/JLqahMfqmTLDFkvKRn5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988037; c=relaxed/simple;
	bh=Ife1aIL7sXXgm+M/b8lPyCn4Oah8vMAM9bUE1mCZBRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xru/embHJD6gzrf1QELZlbb/Yqr3xyR1hwDYKvW5HiW0itQrDmy0xQZhe39vnhvy7Y6cEyZ4uYI4qMrnOX2v1CrefxqfKXYJVymyjYXV/uXLAnQ3Es3sXsH6Z6ld/BiuQMTiB3nLR411guzd/3JX2aOs6qLFU0leN7oVA3/sfJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FwPYh0op; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCjBLUo5St4FO+kZg0tvRXe9ZRSa+zGT+2d1FRHAiLyJAuC/EFlhgn6dKN/FRMFwSiXc2to41BCuWqe8arg/iOEmFGae1yEXLpwLjC5yvg+3evAcJM3bHDndj/TQUPq0A7P61V+2jdfem6XM/l+RSeRaxPxdrYHCmg9ZJKgXw5z9EYt5Eo4lv1PEhsK09L3qBuT6FzH0gKYaOCRBGY6sksepBdHbsX8CcNbqrwRty3N0hmqUVFgZCzwdHab8TGqVKdvaPFDb+NePpZPRFug9wPG4SYyyAC3t9zuN1rrdG/Z8Auc/mG1BihU54/73pzRyc0fW3M3Okz+k0ApUDy3uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3uZ/1hZ0MGK6INjLihizjMJkuLuqHQOxDNuSFafUY4=;
 b=MEbwOZYj+PaPGIOxzIL45c4wK+j/xQAksJP8Uk1tebNZH0JmPOYH70th25W0cTBwxqnDZAPv+bEmanz1yd4elZ+PDoNkJ9i606E/oMCG3lXxCtwqvTv9yjw81wLSxr+HqK4qbbGDk/RzlKUpHjeL6mwLDSst5Dlkea1dSfJEbhLfjdlT8v6Z2RnHPX3FDW03u2OnseOVAgKSgkSjAK6dOmYx0O/t8Tdw2dOMiu02Lg8BMIms1/pG6BLzWXKsOvJUO6T1ERMOcCHJCX+1HwwB+PP1Au8qjngpLnLeaCLSIpbQXKc8SBhQnnzpU2elOfoIo2b/6ITEQGD+mScR10rt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3uZ/1hZ0MGK6INjLihizjMJkuLuqHQOxDNuSFafUY4=;
 b=FwPYh0opH6eBhgtbefzMFhXBFFfljOeVwwsGEb3tyKlvKHulP+7f/5POeSNBlVsxBnQiDYYpUW6qSHApmTyWcuuXLg7lYlmRD65s8ZmYRJOe6/cM/BlP6U4nv7R3nECATyFcCDq1pm288UBnKckv2Ecn7poeT/X1HSLGCIsoCYo=
Received: from MN0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::22)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 13:33:54 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::34) by MN0P221CA0012.outlook.office365.com
 (2603:10b6:208:52a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 13:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 13:33:51 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 08:33:17 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 08:32:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 08:32:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 645DWsRF3059280;
	Tue, 5 May 2026 08:32:54 -0500
Date: Tue, 5 May 2026 08:32:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <dmaengine@vger.kernel.org>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
Message-ID: <20260505133254.c7kfeh62ujdl7y2d@cheek>
References: <20260504031209.618949-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504031209.618949-1-rosenp@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: c97467f8-83b9-4e2e-a6ee-08deaaaaf218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SElSdaNBsnJdQjKPqQFid7DRjNplkzkNQXX2+1Urh5PmT18sV9DTDh6FXfwbKfShSe2nwjVD3JhzGymu/8NDB8tAo4sEFt7FUZL6lFqQyItsEgT2GqaH7geL22NWHaqrv0PsxHLcLO+tlkFzKPl6sK3EBvFfOBIJteZNQF2y0GVx0NLTA1peW9Bw8+tGVv1xRLb9uA1r2XklWjG4XNnB5ov8BCsnAMfydgPL2sanTsT5O47TCFgOZBER6j4KKHr0JoCc9LCoMPIz/TqIMAraBV+qejUgNSvVYr7ia9/GJzqh6bKJC//DkxLprkbX0Scmbz6HsbTbCbK8bsOEI7KAieVde8DpuQTYiUSzKOmqH/rVXhw2YHMlJwxrKRmXsfPeDM4/4cALV97s/7CugWEiLimlxg0zj2NuWecfoVUIC8Z873qkBZHvHJ+13VhSzsPg9QXdto+axFF/gP4PhEjILpG8eJfS0RBB4P70UZckc6qCJJLuaSr12xbQbrhYIjnOVLNcNiIBQzVKhNRWZeXMYlrURsiz9qfvWGfpH6j/u1p+xQSOwEanrZmE+XZvu6HRibCtDJRA78Q+XTu7Hnbf91Qy5NnIzeJkPFL+Oy0ggBdLWG1nCdUq9S4NnBs4Qzd9bt0J++nCa7TcR3E2Oi6luSwxByYn3nkrs3omU844L/0vYL51LZ5ALqJ682F9mBHTnI3PGezoQuQbxWWcHcdj8h/YdBsHM0aIqgrywoePFNY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KEHMtdzQebsIrbyCryyK6eMcTvoS6AnlnisMpSp0IPLt3DJ66ETQwqhLPI+2mxJchL7u8b+AQkZUvHO/BTFk+M/kUtjUnEpKHez6R0rHpNx5IUtCy/HNOWfLVMrbbtDGI34P7wS3w7P6eVetAObbXfM/585JHVnoOmhAtM0mKeDqowqiBvu1i8Tu0nBJcqRmVCEmab4s/e8P/qxqMYGwEu+T0V9EAKk+gD26C/b1fP/JcrsQy4HbcMxDpmZRUL8q6Te/NCZxwlQaJqcIrLok5oTsEhBZ73Jr8bS4ZyT7SksbuLhewdPscVFyrw4xgIvlyjt/atsZRFvaRZZBvi/2s0AaT0mQTuIh33iFJJk4T9I9a6ifGTKlSpkrpgtZOh3iWQXaMixgs9h2cC12BYa/G4ogdxOX/O41DdT4ED3B4ZoFoRIsZ08wW1K1/Mc0/0V7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 13:33:51.4841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97467f8-83b9-4e2e-a6ee-08deaaaaf218
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Rspamd-Queue-Id: 4C2594CEAC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10219-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:url];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]

On 20:12-20260503, Rosen Penev wrote:
> Use a flexible array member to combine allocations.
> 
> Add __counted_by for extra runtime analysis.
> 
> Fixup k3-udma as well since ti_sci_resource is used there as well and
> needs fixing up to use kzalloc_flex.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add k3-udma fixes.
>  drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
>  drivers/firmware/ti_sci.c              |   7 +-
>  include/linux/soc/ti/ti_sci_protocol.h |   2 +-
>  3 files changed, 98 insertions(+), 91 deletions(-)

These files are maintained by different maintainers - Could you split
the patch and send to relevant maintainers?


[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

