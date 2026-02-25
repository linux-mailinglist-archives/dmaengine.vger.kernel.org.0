Return-Path: <dmaengine+bounces-9081-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFrJDnrmnmkCXwQAu9opvQ
	(envelope-from <dmaengine+bounces-9081-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 13:09:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860F197079
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3E0302D512
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4943D310636;
	Wed, 25 Feb 2026 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZhqQQfQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B7221F24;
	Wed, 25 Feb 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021177; cv=fail; b=i88w+IMEiu1HFy5MH5G3A/2dWB3KuRMM846MkpW7fTyVUIzdWIYh30CVVfjfjNklcMalcncubqamHfVTNsU2lP4H5gzXmQ/9pWO4aiMl/UM4C8gGZRd4tYMKzNbalSdmRgfp/z6B7BXH9YI+V8tc+YqXbjEMYl4V7Cf+x+nlF2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021177; c=relaxed/simple;
	bh=kn0iUMd1QUnJC+2fHRBcETYxTo7vexQz4JKQJ/mtw8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmJ+1pKX9+zHnaH+ROlwsWLEkrMz6ZdkOPiy/W0AqSUxQrOIWEiyeNlBviB6s6u0yXF7cKBZdw/3ROIHw7/noJkG0Xk5E879m9qDSLsvBDskG2bFyaxeHXPDMHnq0Caqo7EVKugbyUszxMKaDu/ddCr2ZKEeZk7S4tWwvmGGJnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZhqQQfQ; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brhQBThlGqD3TBYk2t21Pwu+1FHNTku7s7wE4GArNFNXBmiTTL1Pyv6yoAMerj2ocmas2ESpahUIKD48S4m6FSo/m0HhvjJUr6lRC0f8PrF8EYyqFfDUqSe/3qZjUuJOGjnhDftiaEKcb/k5rDbmAzKmY6cZwabB0qwsdGqrZPSr/aGDhKlRWKTU1paKF7z8aPmR18bgbb2bsUNDgEALMYFK0qxN6CDIZDtIKsEMbsV5aM5yUAQdMs5kSF5rbBKXIQIoAfSZH9QCoV0CTsFiegAXF7iB3gGcyhtkSJOQcQw3SSLiF8hIregUjcAVRfpv0JyBW7jBZ8IhYAF6hJx0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulRj1wcknTa5LFvXjRJsfXxAr/QerJ2x+1A+0HFYbvU=;
 b=BIeqOzWhAGfcxZeQubBUnqrlgSeJykK3XnBMsPV0ILg4+fK2hwhR/N6ps3ZIq3MzqqzEMBfKySVIesggMt5rwlqU5WSeJuYOBOijeFSh5btKMgyrEGLlKDkxVOK/2wixabjQuv8K25x3mJIFgD29BRPl5R6CNJWaY8bCiQ9JDsg6gy4EsWya1rn2V/gF9vXrKvr7XbPJUu/Zhr3IYt1rFt2Q88byL2UseWCfHJV70YIgxblrMjQ8MiuBV+BEDo7sLtPjjVeFvbZw8GUlD/gwdToSOXwvCQATbKHPwepC42tCAtMjuI8+zgqh7wS6mHJ685JD70PcBeIwHz2hFYVT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulRj1wcknTa5LFvXjRJsfXxAr/QerJ2x+1A+0HFYbvU=;
 b=RZhqQQfQWswJPpXfJBI3ZgwftwRuwPARK/G+pNDb2OgpSquzqjVy1VpTW0DbVpt8K3TURCq3Xaqw8+Oxr82TLLm+5gL9wEryrfezOoZKla4nvDO3tYdObf1HwtAVWo56L/g5VzTvVgr9Ji95Qer9mFPjYXI/+EVHJSTxx8kHNTU=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 12:06:12 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:06:12 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjwgABxvwCAAOnmsIAAvjoAgAEKjvCAAHWzAIAEwNdwgAHz+ACAAMV0oA==
Date: Wed, 25 Feb 2026 12:06:12 +0000
Message-ID:
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
In-Reply-To: <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-25T10:14:27.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|BN5PR12MB9486:EE_
x-ms-office365-filtering-correlation-id: 5edf87df-4a82-4b65-a658-08de746644e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 QRgRNdmfdZV4EJQkZ6yVZ4F2dlMyS82B5F3HQ41qkbwwMVwt2KQYMbS97zaaB/OZM6g4sUBmlQ/rxHIDJIEPQrZ783ax3NA/k8Wp2yViivRHCVuoBIhv33BCHDc6j7s60JiPN9mdDLfCPeHDuico3xNbFzTEnIZPPltSzpetuSwtQa0hAFp+E98wBtckQfrBue1m/B7PUjtBRrTue7Ws2C3S8LozagFdBJGgoPVbdP7KBpSvqY2X5/3BjdKxvec1eDW6P1KXvSGDyvUxcmKoENCoz6WBs5/yOJrAcCrIpwtXAWC0N+EwQctmrGAU7o5ghvUsqCHX+DXCx/FGAT1ClcvQiQaeVfTymGnfP52nrW0QQOxOrW3Lx4SNEhXRoqPALwLuUdhs5PovaXLcpWh0jb8l59ystQEe9R3WSOWaXas9f9BXVCcGOw3nnXpV6sz5drby2NQ8NDSWkvZYn7KDWEELV9hNXB6kH+g7IHemOXzu15WxoS6j+YL6bQ/FQwmbkQejG3lIbZAMf/Hq1W/aywX8fZ2V5ML7cy9k2PxVgVuPlh9uHg+pPCzqx1X93Lzbkq4Y/Qlby82rgf6KzghlSeVY8jpXsq2pWYXZVAX9UyZGcVryp0S+WWM2S1kTFs3+DS7WJ8KA64OzoLzulsj2PLkx1ZR5lL3wH8CsRaMqbXDaQgXGqsDyUg/e6m+MAi050qAeXzTQDbIvrRDh3JW3Wr20mUmfU3MQ/8xIPMY5uW40Af6Zw7o891Kyl1oN1H5oUXVuKQAll8xTbbKRDjLxaK36EBwI+q7d0nJUT/qNF+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4jnyGbUcj/f3DC80g4GDfJELApqY3Dwo7aEM6pZ1PgEKcPpSG24PUPP7AdJh?=
 =?us-ascii?Q?d+FD9mStMTBd+yjY3bkWNxRWJ5nakKXBxr39IyXQdQwdmmZvtDx1S55J8Ebo?=
 =?us-ascii?Q?Pdu6WKIeBIH/k9W91Kqy9Mjt9dm/+383nMAezL60im4wpfNHgR+XLQYMSje0?=
 =?us-ascii?Q?YcSYvczVUlZ/7MRfpZFUO/pGMeLtPzUFONcOKWPxGT4MFRn1xzv8JM14HSnQ?=
 =?us-ascii?Q?y84T/Za1kx85OcyULbqG0F5X7hTDZa2FiLohOg1IUkUUi5uNb68+/lBCY0PA?=
 =?us-ascii?Q?rtYkmWNkd9BA58cjIZJZEV2LiiclFvm32GCX9oV2+2Pb2IgRYF/v8lOt/xFs?=
 =?us-ascii?Q?vLLqhm8kCSfqisaaQlDSt3etxZG9axz+OS8ONlS2dmFdeoWtXBmO4Y6EZAla?=
 =?us-ascii?Q?7hSpCNh9RBj72gRZCKwxB8e0UmF5qDULbDOCd1750gZKSuavgd50VVtToZ69?=
 =?us-ascii?Q?JvDOzL27JB3nvX9S6AnrqmVnKk+xV4i2AgmH7cWj9rXv/DUe7b4w2q8vC7yt?=
 =?us-ascii?Q?Mm75TDbE527cXMauAdx0fR4bFHP92m3sfDGl7d2Fh+BqHJmaK0l48idQELYd?=
 =?us-ascii?Q?g7tgvU5fbMrj0mxyMGgEDMyOyPoKM/MqaEABVeoDo2tDYIINtiFCbMmOktau?=
 =?us-ascii?Q?G1VnL1IAzbkAdZI4+I4uQzuHcdx9tL5hvFA7rGa30Q12uHD69daDk6XNZPNi?=
 =?us-ascii?Q?JTeTfYJxEpuhqMGdku7OVc2ff1+BLNNHEEFbaX0G5x8Rmo36AP3BbWWhyWJX?=
 =?us-ascii?Q?GTqdjVmGBR8THVLPlCFavmGQwH/qKF//OwMOt/iJxTk6HC/t+dIjpoQ8oot3?=
 =?us-ascii?Q?cSs12y/BLVKQ+h9xdPxH46QzitEfL+cWzvSv4qDdQFPaQHBkCdJONHicGw/J?=
 =?us-ascii?Q?j34MECcPWoT9MR0f0cwXbVlGJuujOdtZoREt/Tp/Qdc59iP7jEQaGmtwaJzA?=
 =?us-ascii?Q?/vCgGS/LsOqg1jLTs/uRBBIZnmGDvn4CQp3eVrHkPROAuZHdLnikR+jwJC9w?=
 =?us-ascii?Q?eiWmlkTwDQ2iAJt9/PWomZVVJKQowA4AKvh7LjWXiEAa7UkQHrX0Q0tAk5qD?=
 =?us-ascii?Q?Z9QC0dXJa4OUl31PPffGBgfwvY1qwosRAqYD2EnmBFW9GxdaniE2aDc7lhX7?=
 =?us-ascii?Q?/P00WcIK+nhRd4W3miRZNeX3VAfXldQplpK8cF91CTcaQ7z2Hd4iv+xgPlEo?=
 =?us-ascii?Q?kjtWdFAqXIbGEyz2XGvLCgyimKvwAZqIHhxuj8A9gLG9/M3nj5H0fO3OJzYK?=
 =?us-ascii?Q?WQ+OELhVbzO5n2C56ypAJ82Tpbj2qA0U2QefgYuvC0XFzXulUrV3M78C12rb?=
 =?us-ascii?Q?RP1DjLsyCn/SAXjWP9rtD6Mv9mezFATUPjUI8ABMVgM1QYs3ng+kHe+NQCKy?=
 =?us-ascii?Q?vWufO+P0FKxFNrDdEAyaGc7Zc9C6/w40pw6DojHMJEMvUzH/o175Y7XIb2By?=
 =?us-ascii?Q?lCLpNQnz2XixCnxg5+ZrWAOiySb76J6S4GD/ZyDqoxiJM9VzaU30grPeicD8?=
 =?us-ascii?Q?uYeeYha8UMDRM48wCEeN61HVSRmmtnY1TC7B6YOvmhweZO04J+ugW+R15o6S?=
 =?us-ascii?Q?cI+n/hD9sQkx6SbiioBP+3HO3aZdTrXnrpXlrF+uVQ8qGG1+k4Wdreo+VjmE?=
 =?us-ascii?Q?N2sYy0iIaM7tXCT9frI4S4BRzmHrK1SNJ49ux0+kIXLFnKLY1ZihBPQhDM55?=
 =?us-ascii?Q?YNmJn58qKJ2usqqM3jlKMxMyYr+CRxNiI2iqY1SQkGidmZoH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edf87df-4a82-4b65-a658-08de746644e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:06:12.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrIRAdzQiXOs20gi1rFctkIVx4JX6TZDi7c8ZVjYH97gbdfeZmtphe1w3OauZxWePS/FKNkkmDRBbh3o5bjkIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9081-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9860F197079
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, February 25, 2026 3:58 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Friday, February 20, 2026 9:33 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > mode
> > >
> ...
> > > > But if it about writing a new function to check the LL mode
> > > > support then I think the current variable is good enough which
> > > > provides good readability and do not create any ambiguity compared
> > > > to the ll region size
> > > comparison.
> > >
> > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So we
> > > add more cap flags in future.
> > >
> > > Frank
> > >
> >
> > Hi Frank, could you elaborate what you mean by adding the cap flag?
> > How it is going To help identify the overall chip state?
> > I do not understand what is being implied here.
>
> non_ll in chan means current status, which indicate one channel work at
> non_ll mode or ll mode.
>
> here dw_edma_chip means hardware's captiblity, indicate if hardware
> support ll mode.
>
> Distingiush hardware limition or current working mode.
>
> Frank

Thanks for the explanation!
Hardware supports the LL mode / non-LL mode, just that there is no
piece of code available which can perform the non-LL mode as only one
mode was supported initially by the respective developers.
So, providing it as capability does not look justified as in any scenario
hardware is capable of non-LL mode. Theoretically, non-LL mode should
have been the default mode.

The non-LL mode is not a hardware limitation either. LL mode needs extra
configurations and in the absence of that, interpretation could be, enable
the supported other mode which is non-LL mode.

With the current non_ll inside the dw_edma_chip, when non_ll =3D false, ind=
icates
It supports both the modes LL and non-LL, but requires user inputs to enabl=
e it.
With non_ll =3D true, the dw_edma_chip or the hardware has no choice but to=
 work in non-LL
mode only. This is the interpretation for the flag in non_ll.

With the capability, would it not make the statement, that if non_ll =3D tr=
ue, it supports
non-LL mode but that does not mean to be mutually exclusive and not support=
 LL mode
at the same time?
If there is a requirement regarding the capability then it can be taken as =
a separate update
but I am not sure what purpose it can serve wrt non-LL functionality.
Please let me know your thoughts on this and lets conclude.

Thanks!

> >
> > - Regards,
> > Devendra
> >
> > > >
> > > > > Frank
> > > > > >
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Frank
> > > > > > > > > > > >  };
> > > > > > > > > > > >
> > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.43.0
> > > > > > > > > > > >

