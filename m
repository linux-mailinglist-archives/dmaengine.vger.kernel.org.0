Return-Path: <dmaengine+bounces-8681-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFpHNzywgWn+IgMAu9opvQ
	(envelope-from <dmaengine+bounces-8681-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 09:22:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AFAD62A0
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0336301841B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957D395D9D;
	Tue,  3 Feb 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PfcRtVoS"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536121ABC1;
	Tue,  3 Feb 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106937; cv=fail; b=Ew31b9QLsVsNvqY5ZDQfCJ9eiMRPB8r49fHDgqZrqGXNzXHkHQQMp/uE8cMEbv8AWTUy6ONh/BAeYwiQ7UdmofAK4vlzCQ59s8/lmQ4GiAUwG3pv5hpFs+GDi/iXqbeLH6pCmqK7XWauao78AKV/0kjUCxD+qUq16ROO0Elr02A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106937; c=relaxed/simple;
	bh=rnOtGh+6bCg9JxwaXRTD0/dma9fc6iUP0qLTHQiq+Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYhhVDh32GQkhe/92ifSCwKtksOitKnK2kYZMVYzsyhaRqbi4USEg2oNy9t4FTIRUYy2nhaODZy83xkQuI81rh8Isjo+wj5nvGyTUW83YQBXH6uXsUkGlVHsSm8CH5igjAysM2hZoseGqm2uYZ4tR+y1e4ckBFQHf+O+QtAu1Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PfcRtVoS; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFh5knt1SGgSHzJuW/KtFKxvkr6438CiofDqWP70RA0KUWkSLnK6UeSAEBFAy6vzxLz2GRG5N6R47ucyLs8GxfMt2TpaXW4I0qPGznDcLP7NtS/VxRS/ReK6/bZ+PbkgAJs2yXMXU20+yKlHtfkS4PQTc3iu66dnanbTi4FJi+5v94cseJ6tjOYkSAw9Jp0huk3O822xT3DirAFVRusZwLx8BQ1koHN4ov7Ti1rEUJr/oLYachRcRpU+sbpdd3nnDvO9OXIi8cT7bYcX11Woh8BJDt27skYoq0tNgXLBVlG7FqoLXySIZ55f7pBEDVnvabWydM2vZHDThpkTpQfRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b2djF6kYQEb8MIvztBfQVDWIZgTPrl/cDjCCDXcIL8=;
 b=Ip++jQnVvoSbqttiUSr8aw5NbDqJ1uspD0jC2N2vjK4tXCjLTX8nBhWOkVeemHBrRkap+D72gEjlmegKiSBHuaE2x8FKxfuLDxasvpHius3ZUIHSYi3iExoqvMnXVrfJueA4xlawnXLPGy7KUDjxBAsmLYdJ94AnjF/XabZf1t8HBTSRaf5JW3b0LrG5Aa10TMqtMLtxsAk9Mkbpq5Js7zuj/x8IqErIpmy628D4bPvOY8YBhUFtoGTWbPTkJiAQlYtx19MEFO0ZoMxmYRT5f1Cj3oKU9aPbQW0IHU0zeVyIqMngtLmBJkYJ/NWpL5mfkC6XL7LZ09LsC1mwNN+B5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b2djF6kYQEb8MIvztBfQVDWIZgTPrl/cDjCCDXcIL8=;
 b=PfcRtVoS/wiRUSto1ItsNCL9RluabpF5wXE2vQ55am1QK0I2Jhb6TWi8DvMQToz9/PBHxUsvRSrJu53b3opN7/ucTLRypESOnbPJhc7ghGC8Yo3g1BDCCfpJop6nuRPhOr6VB8LIj/UTQQgZduJos8CLp6P0SR3Bg/icluYycdA=
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by IA6PR10MB997611.namprd10.prod.outlook.com (2603:10b6:208:5dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:22:07 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ff) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 08:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 08:22:06 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:22:05 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:22:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 02:22:05 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6138M0153190785;
	Tue, 3 Feb 2026 02:22:01 -0600
Message-ID: <7abbd45d-e688-41b5-bde4-5d97877f3267@ti.com>
Date: Tue, 3 Feb 2026 13:52:00 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] dmaengine: ti: k3-udma-v2: New driver for K3
 BCDMA_V2
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
	<vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<vigneshr@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-16-s-adivi@ti.com>
 <98c254c5-94c1-49b0-b361-617639b781d8@gmail.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <98c254c5-94c1-49b0-b361-617639b781d8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA6PR10MB997611:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0e94d0-1577-478f-8175-08de62fd518e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnhWdlVWcTV3cWpYNm8vQ3VTbHF4N2kwNnNSMGM3RHpxRVBvRkRhbkdwM1Fn?=
 =?utf-8?B?MHpSNkNTZ2pzSnlSMlZ0blYza3RvNnN0SGdaL3lvWjErU0FIZkZvV0xZYVg2?=
 =?utf-8?B?T1djYVdOWlhGNkcyTlF1S3dyRitxZDhrSnJsejJBWnRqbTJOUDhWT0p5UVpj?=
 =?utf-8?B?UmQ5eGxVUGJtTW1lTXhUVUovQ3lMRVh3eUJXSm1MUnVXbG93cUI4VEhRMFMx?=
 =?utf-8?B?UGN4QUh1OTI4N09keFJSTGJ6bytMSUZvdEprekJjM1NaT2x2Nmt3d0tJa0dF?=
 =?utf-8?B?eFNvbldBeWh6VWpVVXdCcjNvdm5HVUh4ejJ0RTMvM3dhWWdzeDJ1ZkROVEhs?=
 =?utf-8?B?b3l5cUd2UW5VWFZUQmxGR09yRmFPdW1IandtYUNjQnVabVkvYnZDL2ViSWd6?=
 =?utf-8?B?ZXladU54azhMK2IrQ1ZXRGlHc2x4clAxV1NGc3JrRm4xQWd1Wno1ZXpTRE5F?=
 =?utf-8?B?b1k0M2FRT29WZFJaZ0RYa0p5SWNrMThwYmhwUjBWSGNFNEdxM1hCd0NlSHdo?=
 =?utf-8?B?VDlYcFc1bEdUNFE4NCtwZFZBbzZhUFJFdjVvUDZZc2xMR0JGTWxRdlFGbU93?=
 =?utf-8?B?WlFYVTRkZjlPdWtPaElRWG1YVkxRSGZGakN0bjZ3Y0plSkRLOEZOL05ycytm?=
 =?utf-8?B?d2NGMDBkSUxXT0V1Yy9ERXFnanRodVllcHduWmNCcTM3UmgxTitWMzl2c1dL?=
 =?utf-8?B?UWVXSU9USFZMOU5ZV1htcHFBQnc4akFRTnhXZzkxZHVUbE5wcmgxdzl1S1RI?=
 =?utf-8?B?YzhURDJ4bjlSZkR1UUg1Rzg1L3ZoemNzS3ZSYzVlZkJFOGdnY3BQWVFKMk1F?=
 =?utf-8?B?T1Q2czRlak05Ny9kTjBieGxHaWdoekQyZVVxRVBrNWFabjhTNnJlenlLbUsr?=
 =?utf-8?B?WkhxWHJlaG01c3R4cXViZ1ovU010U3lEMkNQWWdoaFBiOEVQV1J6NGxJZG0y?=
 =?utf-8?B?UFlzc2xENnpIbVQ2YmxYZGtuYXJiL3V1bDZEZzNyNklHL0FjcEVHRk53eWlw?=
 =?utf-8?B?REJHc0ZOWk5wc29vSDJ4RjRaaFNtaUIyc1FmRHpNT1BCVVh5aUg5aUN2a2pr?=
 =?utf-8?B?aWdPbVFwVGtVUFhPdUFLNG9ZS2tJWkk0MHdOSjgyUDUrNG1tT05hR1RTNTg1?=
 =?utf-8?B?OXJSMnFCSFRiaXBaazUrdngzVldiUFZ5Z3VXd2dYTENKM3FBa3ptb2JkL3Na?=
 =?utf-8?B?Q1NxOFNDQW1GWU91VjdrbDRNRHVEZkJCaEg3MkZjNmVOUGc2aC9ZSXVwQUFS?=
 =?utf-8?B?WmhXQ2JtaWFNSWJTVkJNSEpKY3VDckVoMmlUWUtwUGU0L2JkL3dLVVVkcjF1?=
 =?utf-8?B?UDB6QlpDeHNGL0tCbWpxMlFqSTk3Uys5cGxGbExNaFA4SnYzc0pMaG56cGFt?=
 =?utf-8?B?dUErRXRZNDZVeFJrY25JdElua0V1aVlTTTFZeG1pUW5yL0Y0dGdCUlVwamRp?=
 =?utf-8?B?cW9NaWlIdUhzcXFESWJ2anJZTjl3cW5MUS9aeXVFYlNydWVzMTYvcFpzVEla?=
 =?utf-8?B?ZDhreGUzL1FrK2orRkl0YWkzSlBGVDh6NmxRcU5RenNTcFZVYkNhMEtFTUhF?=
 =?utf-8?B?ZnRvRFlPM2poazd1RnBNM2FQdHBNc1F0bjUrSFQxWHJ5elZ5UnpSVXJTMTUw?=
 =?utf-8?B?NVdsTm1YWnJWWE9vUjRrYmQ3ZjhpNFoxNU1NYUpVUWlvL2UvS3V1cURDODNL?=
 =?utf-8?B?WFhibm1EbTJNK0FFYk5yMVRmVFFXaTFUQUZkd3A1K3ozcWtNeGwyWGx4VWNn?=
 =?utf-8?B?dzRDbDdoMlJ1MXc0amlPQW92RlFHY1pLcEtvZXJ6SzdxTkN5U3RZanpCdDUx?=
 =?utf-8?B?T2twN25uWmhCQmlkSFhJOXV3Q0Q3Y0N5UnB5Q3pacCtQUUpjM2NmbTRCbjVM?=
 =?utf-8?B?VFdhOHo2bG1yQ3lrRGpRTGxKaGRNb3B1RUV2MWhoYmE0TFZOREFmRjI4NHVH?=
 =?utf-8?B?Qy8yQXlJc3BqV2VJNWhXUHZZTWNWdWlpRmgvU05FemRwVmZxWG0vdEhqNElQ?=
 =?utf-8?B?ZXhrN1NVcmFWZXBvQlVYQk5seWRKL2tXektKbDM1QVp1NnlSb3liVTJha0dq?=
 =?utf-8?B?Y1FUY3JNOGtEalNaZXJ1VnlpMGJMejcyWnhzM0FQcGduK3VVMTZDbW5KSlE2?=
 =?utf-8?B?QkxGNzM4bFY1OVI0TDBOc0x1SnZwcTAvbFNZVE1BMWJuY0lNaHZ5Yzlha1pk?=
 =?utf-8?B?ZmJTQWV6c1cvWmlHazBPSVQ1YmE1MjExNFdDTkVYL200VmQ0TEZsQkd6S0Ex?=
 =?utf-8?Q?ZZdLqd4inpHcI1BUIUZw/qvyfbwKoT7OT52gxa1Tyw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YA9boEr+3PKxmItqGgAVaVBVAQTrw6JUqjVzWxLwgkHpf1TEFI4FSO7aSCMrkPW8KX8dWy0FaBli6Jy5npXx9I6ocW3U3tmH5aFAritekY2/tbY6/slZYwEZkKPt1th2xoJBm75aqMU2FTPBijkBT1fOWSM5t5CBAALxZCWtCC8qmKZaB1AippYys3XKAsL5ZQQnOwwEmv1bsljytx43slv9BpnLTdKhGWvBydE90BICDTQHC41OUNsjtxurKVT5nwfFCjPFid4VIBYWAL2gH2B7IjmtekF6/FccHUQ4Cstu/OE/AW9tn2ZDe3kKDG1OBxPM5e8DckhfaDcQIVkfoRRbogRIdyeLv6iUTZXmywD2mdDTuVVDLCfHtI2tmaseugXxRO8bGO+8U2LKIsW2P9Iy7+NNww/VzJEcABxM+4xO1mG7cqLmRhWIZ+rh4km3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:22:06.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0e94d0-1577-478f-8175-08de62fd518e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8681-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 52AFAD62A0
X-Rspamd-Action: no action


On 03/02/26 12:07, Péter Ujfalusi wrote:
>
> On 30/01/2026 13:01, Sai Sree Kartheek Adivi wrote:
>> Add support for BCDMA_V2.
>>
>> The BCDMA_V2 is different than the existing BCDMA supported by the
>> k3-udma driver.
>>
>> The changes in BCDMA_V2 are:
>> - Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
>>    needs to set in the RT_CTL register.
>> - Static channel mapping: Each channel is mapped to a single peripheral.
>> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>>    directly connected to GIC.
>> - Remote side configuration handled by DMA. So no need to write to PEER
>>    registers to START / STOP / PAUSE / TEARDOWN.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   drivers/dma/ti/Kconfig            |   16 +-
>>   drivers/dma/ti/Makefile           |    1 +
>>   drivers/dma/ti/k3-udma-common.c   |   75 +-
>>   drivers/dma/ti/k3-udma-v2.c       | 1283 +++++++++++++++++++++++++++++
>>   drivers/dma/ti/k3-udma.h          |  117 +--
>>   include/linux/soc/ti/k3-ringacc.h |    3 +
>>   6 files changed, 1429 insertions(+), 66 deletions(-)
>>   create mode 100644 drivers/dma/ti/k3-udma-v2.c
>>
>> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
>> index 712e456015459..ada2ea8aca4b0 100644
>> --- a/drivers/dma/ti/Kconfig
>> +++ b/drivers/dma/ti/Kconfig
>> @@ -49,6 +49,18 @@ config TI_K3_UDMA
>>   	  Enable support for the TI UDMA (Unified DMA) controller. This
>>   	  DMA engine is used in AM65x and j721e.
>>   
>> +config TI_K3_UDMA_V2
>> +	tristate "Texas Instruments K3 UDMA v2 support"
>> +	depends on ARCH_K3
>> +	select DMA_ENGINE
>> +	select DMA_VIRTUAL_CHANNELS
>> +	select TI_K3_UDMA_COMMON
>> +	select TI_K3_RINGACC
>> +	select TI_K3_PSIL
>> +        help
>> +	  Enable support for the TI UDMA (Unified DMA) v2 controller. This
>> +	  DMA engine is used in AM62L.
>> +
>>   config TI_K3_UDMA_COMMON
>>   	tristate
>>   	default n
>> @@ -56,14 +68,14 @@ config TI_K3_UDMA_COMMON
>>   config TI_K3_UDMA_GLUE_LAYER
>>   	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>>   	depends on ARCH_K3 || COMPILE_TEST
>> -	depends on TI_K3_UDMA
>> +	depends on TI_K3_UDMA || TI_K3_UDMA_V2
> At this point the glue layer should not have dependency on UDMA_V2 as it
> only receives BCDMA support, which is not used by the glue?
>
>>   	help
>>   	  Say y here to support the K3 NAVSS DMA glue interface
>>   	  If unsure, say N.
>>   
>>   config TI_K3_PSIL
>>          tristate
>> -       default TI_K3_UDMA
>> +       default TI_K3_UDMA || TI_K3_UDMA_V2
>>   
>>   config TI_DMA_CROSSBAR
>>   	bool
>> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
>> index 41bfba944dc6c..296aa3421e71b 100644
>> --- a/drivers/dma/ti/Makefile
>> +++ b/drivers/dma/ti/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
>>   obj-$(CONFIG_TI_EDMA) += edma.o
>>   obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>>   obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
>> +obj-$(CONFIG_TI_K3_UDMA_V2) += k3-udma-v2.o
>>   obj-$(CONFIG_TI_K3_UDMA_COMMON) += k3-udma-common.o
>>   obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
>>   k3-psil-lib-objs := k3-psil.o \
>> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
>> index 0ffc6becc402e..ba0fc048234ac 100644
>> --- a/drivers/dma/ti/k3-udma-common.c
>> +++ b/drivers/dma/ti/k3-udma-common.c
>> @@ -171,8 +171,13 @@ bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>>   	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>>   		return true;
>>   
>> -	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>> -	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>> +	if (uc->ud->match_data->type >= DMA_TYPE_BCDMA_V2) {
>> +		peer_bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG);
>> +		bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>> +	} else {
>> +		peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>> +		bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>> +	}
>>   
>>   	/* Transfer is incomplete, store current residue and time stamp */
>>   	if (peer_bcnt < bcnt) {
>> @@ -319,6 +324,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>>   	size_t tr_size;
>>   	int num_tr = 0;
>>   	int tr_idx = 0;
>> +	u32 extra_flags = 0;
> nitpick: reverse christmas tree order
>
>>   	u64 asel;
>>   
>>   	/* estimate the number of TRs we will need */
>> @@ -342,6 +348,9 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>>   	else
>>   		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
>>   
>> +	if (dir == DMA_MEM_TO_DEV && uc->ud->match_data->type == DMA_TYPE_BCDMA_V2)
> I would add the evaluation order in reverse to skip checking direction
> for UDMA_V1.
>
>> +		extra_flags = CPPI5_TR_CSF_EOP;
>> +
>>   	tr_req = d->hwdesc[0].tr_req_base;
>>   	for_each_sg(sgl, sgent, sglen, i) {
>>   		dma_addr_t sg_addr = sg_dma_address(sgent);
>> @@ -358,7 +367,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>>   
>>   		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
>>   			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
>> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
>> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>>   
>>   		sg_addr |= asel;
>>   		tr_req[tr_idx].addr = sg_addr;
>> @@ -372,7 +381,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>>   				      false, false,
>>   				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
>>   			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
>> -					 CPPI5_TR_CSF_SUPR_EVT);
>> +					 CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>>   
>>   			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
>>   			tr_req[tr_idx].icnt0 = tr1_cnt0;
>> @@ -632,7 +641,8 @@ int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
>>   			d->static_tr.bstcnt = d->residue / d->sglen / div;
>>   		else
>>   			d->static_tr.bstcnt = d->residue / div;
>> -	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
>> +	} else if ((uc->ud->match_data->type == DMA_TYPE_BCDMA ||
>> +		   uc->ud->match_data->type == DMA_TYPE_BCDMA_V2) &&
> Have you thought of adding a version member to struct udma_match_data
> and use that instead of distinct different types for BCDMA/PKTDMA?
>
> Here for example you would not need any change as the code is common for
> both v1 and v2.

Hi Peter,


I'm preparing a v5 and wanted to align with you on the handling of 
different dma

variants (udma, bcdma, pktdma & v1, v2).


Frank suggested moving toward feature flags (capabilities) in the 
match_data,

rather than checking type. [1]


I want to get your thoughts on Frank's suggestion before I proceed. Do 
you have

any strong objections to using feature flags? I see merit in that 
approach for

scaling to possible future DMA variants in K3 SoCs.


Thanks,

Kartheek

[1] https://lore.kernel.org/all/aXzXYMixFpuornQF@lizhi-Precision-Tower-5810/

>
>>   		   uc->config.dir == DMA_DEV_TO_MEM &&
>>   		   uc->cyclic) {
>>   		/*
> ...
>
>> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
>> new file mode 100644
>> index 0000000000000..af06d25fd598b
>> --- /dev/null
>> +++ b/drivers/dma/ti/k3-udma-v2.c
> ...
>
>> +static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
>> +{
>> +	struct udma_chan_config *ucc;
>> +	struct psil_endpoint_config *ep_config;
>> +	struct udma_v2_filter_param *filter_param;
>> +	struct udma_chan *uc;
>> +	struct udma_dev *ud;
> nitpick: reverse christmas tree order
> also in few other places.
>

