Return-Path: <dmaengine+bounces-11866-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VZ3ROSlhQmpr5wkAu9opvQ
	(envelope-from <dmaengine+bounces-11866-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:12:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA26D9E2D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=AMne9q9r;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11866-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11866-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032AE300EC92
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0835F199;
	Mon, 29 Jun 2026 12:12:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298A314B6E;
	Mon, 29 Jun 2026 12:12:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735134; cv=fail; b=AcRD40mAi5B7/xKqvzEPKVObUmjVx6Kzq8Hf15h9kOKfTpH4bs+VVtAT/0z8ATVThZ3JyDIvLOoBNtpPg32Srt2oIvvrhPgNLFBAtx43HcRVwoI3ue+qaZMSxMoepzYlJLu8QXwMeeQwDLe0zpiRlAOuBrzR8rLIDwNEfPPTpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735134; c=relaxed/simple;
	bh=x8NReviFzEchm4EfeVPENBcYU0w60D/B3f46wYr2eFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbIB7T86lTjsNHJ2xGyU9ElU5EdPTL0Ao8ekyaOJ4U/pmd6ZtGNT06MIB0a5fDSWn7DLsKMUGWlF8kzT3Dl8J+AW+dvmV8v401tGVq+cV8RlZ/cDt3i0IgBBOaTTBv7bSatS6E5AK9qTeyb1m0koiWbGSJ8vmzzge/wzvNWmHLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=AMne9q9r; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAWdqa2487992;
	Mon, 29 Jun 2026 12:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=x8NReviFzEchm4EfeVPENBcYU0w60D/B3f46wYr2eFE=; b=
	AMne9q9r4e/9XgMBbuujXugDzyfraUKOLTjNneDCl9Aw+zUxCv0MqoZ9g7u/MSpH
	jRj/S9p2ZWsgZrFYTLS3IIh0Soep6ktROuY6zL+ds2kDYOGC8BKdlcjHcqtT2//b
	BzEovIospye/mMiM9GL2ftLCBfHjhKB542NlxVZhK4B1un8aMs/A3YUqT9WdAJGz
	kYdzRN1J8i8WaaaMoK6KZPsXTnJ8RXxL7UyT9AV9VV7Q6L4+HfXebgjziqVqyjqo
	Ef7wB1OnZxUhosNLbWByj86X9DfX3taguUDMyllNLneE/kryb68VzFODL11GH0Id
	Gf3T6+9116A7ClwqijVwPw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f25g5j2xb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 12:11:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsQVw8dBv2NXfr983RJ40H0PsJahIz6dI642FQ9jwKQ4Pm6n41MH4ekE5dbjgGpAQKNIwu1RB9RqlvJJiKcxTtqy8CnsAck4btfUH5OE9ulbK1Lr3BzqRUNYixiYzh5sB7yAV+uk0UjsBcBqLjbJ+z7Xtv8dYAwIZZ/GvSqZG4ewClqjUAB9tHaM7r80jFBVn8kJ2578VfZkmK/OcO5BOzsXFEjtteKwRNTRlGVDL7LbCy0Gz6fKFRqv0EypaUXYqZMwpypKNI/273ySc5XKuddSlbjWE5oX9GMFxSOP80JQy2ATAy0+rwgiG2aAFhO0xEjcSvtj9hzaXa/ODLaN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8NReviFzEchm4EfeVPENBcYU0w60D/B3f46wYr2eFE=;
 b=aP3Hb8SkqF619qcg2DpGAEt/72i6l4O3WQoicItjik++52xa6oaEQs34tg23AlKWauOuwr4JLe21s6jYhOSDAnfYoT+tvzPa1jhbCIrXaX1fjcAseXuhmtYJKsfpapWATtfYKIz3go5Hhn+M0qUhfDzl2C5gdzyBkZe2e6fF06iujxW4xQrSFGYTwzbcstxIqoUQgzdiV1mDjeLWzhhqRqvOmtVU2/9c651GZ+w6wLNj3o7Q48taoBrf2UnCDfvx1fA01Gm4z4CElYS0It51zlrTrgoNcD+ihy/WD1dFgCPrbLgmQhos9i9kufbNLTDocoJI6sScco2wVpdlOQ+TjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:11:46 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::6b12:513c:c6c1:42ca%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:11:46 +0000
From: Bogdan Codres <bogdan.codres@windriver.com>
To: vinicius.gomes@intel.com, steve.wahl@hpe.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bogdan Codres <bogdan.codres@windriver.com>
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on initialization error path
Date: Mon, 29 Jun 2026 15:11:21 +0300
Message-ID: <20260629121129.1213335-1-bogdan.codres@windriver.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1782732745-9499-mlmmj-112abde3@vger.kernel.org>
References: <1782732745-9499-mlmmj-112abde3@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0043.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::15) To BYAPR11MB3606.namprd11.prod.outlook.com
 (2603:10b6:a03:b5::25)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3606:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: d001b0fe-5da2-4ff5-1c10-08ded5d7970d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|38350700014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xRxVV6Q7uNo3T2aE71kX5xNe3Ui4DYl+nSyDvaiYN1lyI3U8zfjjxSK9tRAgzSil86Xv3iWrX4HTYvbhRUWwbQ05zEtXAoBC7p3CaIEz4eh39ncIxJ3AJNVx8Q5R4q2u78OO26LWl7nZo4aQ/OPvtj069Z95I9sNFYbtPCrmL4Brdoid8n+3aTNBDmZ+N10ZDSNpbQigs5ztahkjC9axdQ6e7lWX6Cd4Lwo7DzFSJ568KSFt3yMOpCGzth0hvA971B6OJxAHfq4UWadINaJ2oxc0df8OdOdDizK8kCjr6t4hCD/ayb/YzdAjFeOeBXYAVk7O7w7POHMBicDZSzsGo7+3xUH3F8TkhiGn1NMqQS8ZBi/BlWzzeEPFEPSSTKcjAS/WUKFdBwvuKgIpjpk7O5ZhBBeeqhrBUbuIEsHvokwGZIvysAEB1Vg20AyyJacobta+JgBddn8TMIjSGNQqrzdpCL5b+f378AWJGwMVntY9ciomA5NmBExadkM6nVPHovqF7pAVH8YPplWXBAvpW495vF6dtKfnd3Lhewe/mVQZkovOfGls5VYrdtWnYkb6tH2IKZjlnHo7miJzVkOO0NysOd+aIONu/VNaipCYteC1tVIfAVSQyDPGivkYg5e08XSLsIr99ZETx5Np47JREsP4wUBiOBXMznHpHpAeAIjsB/Pe3xGTORYFY2W6Al+QwCETILDKSdyBNyawf309Gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3ljMCs5WmNGSFo1b2lmRzMzcUs4MXBPNTM0TVJEN0lEZE9HZTk4SXlGemdM?=
 =?utf-8?B?dTNiSUZjTlJ4T0l6emtVN3l3YzE2TGpScExFNEl4RHdUYmpQUmwwcEgzZDN4?=
 =?utf-8?B?RnFrT0pEYkdWalNFaHNaVzNZQTVFbGV0Qm9GNm83WDRpT1FrMWxWMEJvOVls?=
 =?utf-8?B?b3pYNmQxRCtuemQzZTE1clFJQzhWV0docEZPckxkeHU2WTVmcElGUklPZnF3?=
 =?utf-8?B?am5IUkhwZTVJM2p3QW9tL01NMFVMdXA1SDNGSzZpVnFaSUw4SDFkVHhlbUJK?=
 =?utf-8?B?ZDlpakx0aVh2eGNHKzZjSkFRV2ZtQ2FMVjY1Z1VsK0NHUHQ1Vk51Nkx2aFNC?=
 =?utf-8?B?SmJZYlJiUXVkREdScEhhNEZreDk2djhDNnBmNHdiZVZVRXorQm45OFptbmcy?=
 =?utf-8?B?aGJNRkJ5b2lWc3RhcUtHMmdPNkwxTkQrWUJybVA0ZzJQenRUZW9JWUN6QnJa?=
 =?utf-8?B?SjQzS1FYT0RhZUt3bXhtYlQxU1ltZ0dmdU9ORXJTa0c0UllpS00wUlQ4dUY5?=
 =?utf-8?B?UHlkM0NWWWhuN0tQN2ZCaEV3S0t3Z3ZPZGxrWUljeGd1WWJBdWt2cWR5WXVa?=
 =?utf-8?B?ZTVYcE8vQkhzWVFqV2xCNnR2a2IrSzFRdE56ZmlteVUrR1JMV3lJK1hZM0t4?=
 =?utf-8?B?WmZ4TGNaV1owRjkrZHFiWVNGVk43QVQrVy9BRDdaaEhwK3Z4MDZKMWN0VGFx?=
 =?utf-8?B?dmJJNWZGbW9QWXFObkVIVkpoUVFRWENrQ0t4NXUrQjZYTUk4dzdlOVo0czN3?=
 =?utf-8?B?cm5KdWRkSzNkbXcraGxMNFIyNUNDcjJpYnFkOEUyUFk5SVJaTytMYUhtZ3l6?=
 =?utf-8?B?TzB1UjhnZjlKaHlpc1dFUTNyS1ZZZkMzSlA3NWV2K2NsYjdQMWt1dTBxaVk0?=
 =?utf-8?B?N2xISkhLMHFHTzVnQzVPMjJmaG1Kdi9LL3phWC9zUC9iaFZYc1FFem9BU3Jq?=
 =?utf-8?B?RElFVk1MbC83WVdGYk0zVHE4Tm5NLzRhQS9jTDFKSmlEZ2pySkhvMjR6YzZV?=
 =?utf-8?B?U3IzcG9wbDlwZDVxM01mYlNXNjgzOGo1VEc0K3gvcWlXV1FQL1J0K1VNcUNV?=
 =?utf-8?B?YUVSaXY3eWR4RmdHck9qbU00QmtPSWRvQUlmMEM3aUdRL3pJZU5kQ0dtQ3A2?=
 =?utf-8?B?cWZyKzNYZkVIOHFxeDFteDQ1WithcEtiSk9yTU80ak1PeEFoYlE0YlRtZEdD?=
 =?utf-8?B?Q1N2Z25hMkNucjg3c1pMRkh4WHpaMmtLK0dzdC93R1NLMklVWkNLU0E5bGow?=
 =?utf-8?B?akN0SlU2M1NsNHROcnFMN1pCbEttMElXcXliYjV3NGQvTXZ5Zm44QmpZVnRK?=
 =?utf-8?B?THg0SXprbHJrSkYyNm9rTStKVDFZWE5GYUxFT1F6NkhCQXBsdFdRMXE3ZDBB?=
 =?utf-8?B?OUFBVmYzSmNRYW40SUtnVDdFRTdzbEM3VVdsOGhVaGJiRVV6bzJrQmZ1N0ww?=
 =?utf-8?B?T2ZHMFBpdWExdHpGVDBEQkcvTG9Va3lRZlg3dFRJUi8rKzM5Y2E4R0xOQ3Z6?=
 =?utf-8?B?aFhWdnJLS1JydjYwWTlORU9OajljLzhYbFZ0RzJ3ditOTzFoczQzWDJVakdv?=
 =?utf-8?B?d3lKbjNDSFJrUXpYb2xScTNXMVRNZGVNM1l0ZzRlaXRybXdPUFcxTzFNWWty?=
 =?utf-8?B?dHV4RkZGdjFUSkZRb2VwVjNYRW9TK2NoZ3dzQktIU2JRM2hmVEduYkhpS0ts?=
 =?utf-8?B?dG5nOWoxV05sK3dCYmFNaE4rbmlpU1hQV2VSRTh5VEFuZm1PdlA1Y0NDdGYz?=
 =?utf-8?B?S2VKeDdmUnlucVFUbTNZOHdUdmlFN1RSdGkrd0VOTWtaTnlDbENYZDd0RWtJ?=
 =?utf-8?B?Q21tcGcrTUlBWGhBajA2ditEcVhLeHBRQU5MY29yVlNXN1NzNjdQNkl0YkFZ?=
 =?utf-8?B?QnpxQzI4aGg0ekJZaUdHOTV6bmEvT3duTkxxbWh3RTRXa3RRTW9wUVBDOVl5?=
 =?utf-8?B?VjFrVW9xVlZ4WnlsWWZGY0hhZjdRWVpvMXRTaXpWbjdGTm5oMVp1M2NIVElG?=
 =?utf-8?B?NU8xT0FqQVh3cXBFeHg3SlpDTnc5R0RwZDZ5QXZZT2VQdGdpVktoczdBWXp2?=
 =?utf-8?B?R1FnTDhsb0JqczRDWDM2S0R1dnZPSFZiNEdFczNNbDZtN3laQzBSeDBOZmtN?=
 =?utf-8?B?Z3ZnNHhNM1E5SW9va1dzbzUwSC82Y3Zsd0d1a2FSdWZFa0pBa0lWNVNxbHRa?=
 =?utf-8?B?M3ErV2NLd0RzNkhDT0dISTF1cUFCOXZjUVBxMXhwNEprb1hrUmJ0UlE4WXVz?=
 =?utf-8?B?RnpUdHhwankvQzY2K25yemdVSmYrVWRQdnlhcE0reTJTY2RSSm5ndzhvdWNG?=
 =?utf-8?B?dko1TmNueHJuK0hNMDdaT3NZREFGSXdhb2RZNlR3a0FvNjJOWjFYWS9WK05s?=
 =?utf-8?Q?6RlGvBhsgxRGmX20=3D?=
X-Exchange-RoutingPolicyChecked:
	g/8DrwN2A4QuS9UPHaPu0isIZNFvs19OmvfsxSqyd+lphIHQSU8pppb8t4YjkFkOOVxt4HRMeRgtw5N81h80e/Nb5UzEqcFmQho3+e8xCg3IJ3zGzNe01Bj/4unF/qle6JyqQtj6QJAoU8ONt33YEMd5eihsN2GDD4eWFKMU9JlNqPdTQQK3u5dPAqkaEArAUNDeCFVYUL6GbhqmNXln+3myLXiPi3voN9DBGh3/y1szsFBvgsJHDazkYKvd32M+Y+CO50vjayTKa0M4PMD8i51x9AbK5Wi9XMCIJHzq9Lc6iSBMi/pHUMFoCl5YXI6TLoUdZYt8qfxtHwdEftVxDw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d001b0fe-5da2-4ff5-1c10-08ded5d7970d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:11:46.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVyPGhY+NmYzafuywa940lO7RiIY+yGExlL3fCbpgljVXm74r32PAEwnRQ0/+y97s6XhYxustB32Gd9+u15FhBDWNgsNmUYAheLQ/yojBoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfX7oVNLcpCA6M2
 ndf/mLhu2kfrHSdik1A4tjuJWxtxqN8SncjnIEFA3mU+lkXOwXeLdsEP5JTMy8KzlM7x759YYyU
 TzZcBXIWfL4b7n5nqpIJIyDFGbhtSQ6WAMCSuGyxqU0rTr4QQFv/
X-Proofpoint-ORIG-GUID: MG-LESSU1JaIQJ9L-LmMZDfmEly6SCnH
X-Proofpoint-GUID: MG-LESSU1JaIQJ9L-LmMZDfmEly6SCnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfX2GaXu6nDQ6jn
 xVuLfvMJjuEZL8y+fgaN1sOMiXZUzn7pVsvnTa9oFKxqzDFgwVFpRubs4p8ZxDV5kcd5GpYRmyI
 ijpFkvViY+/7Amz6D1nGqiSSYUNva/SJMqQ1142JeVmDXK0QJ7ms2EMiGdhHfOtVpCaAiVL4QiI
 VnvDfNqxHnT/70FSvdAWTBAQD97ivWOJ8Nz/iGqz+x1HTBMuVldcD5H8DQWKd2WJ5QUB23zi68l
 i1zQhM0V9hwCcdllIHoHz/1UKhNIAD9XvZXjA+KqOQ9k3RnupKGPVV3rjnqvfMKdJYHjh6daiXO
 o1mSRYBtnisL+nEop9XnhyU84ovciodDceUiSj6mzP4YL3YuRst5w509u+XvySio6B7iojEfRg5
 FkQQmlw/EBQsERcWOV/TFHAFvuVmqFr5KNBdtJtsl+3bD0KNRP2/SGslT/O4/WzkGlhB4+bJ5Kp
 jIEkQ6xwpRzX0CfBVjQ==
X-Authority-Analysis: v=2.4 cv=TvLWQjXh c=1 sm=1 tr=0 ts=6a426105 cx=c_pps
 a=Ba9BPv0Mt2atAB5a3SkMeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=UScbt_7TdepatLbSdNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290100
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11866-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:steve.wahl@hpe.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bogdan.codres@windriver.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdan.codres@windriver.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BAA26D9E2D

Hi Vinicius, Steve,
Thanks for the heads-up. I'm totally fine with being added as

Reported-by: Bogdan Codres <bogdan.codres@windriver.com>

on Steve's patch — his fix addresses the same issue I was seeing.

You can use my splat ad the reproducer.

Regarding the third patch for the dangling ->wq pointer — the idxd->wq = NULL after destroy_workqueue()
looks reasonable to me.

Best regards, Bogdan

