Return-Path: <dmaengine+bounces-10066-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNRsNsdT5mmwuwEAu9opvQ
	(envelope-from <dmaengine+bounces-10066-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 18:26:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9642F786
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D234F307ABE2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A72BE05E;
	Mon, 20 Apr 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vdGHzZcC"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F241C6A;
	Mon, 20 Apr 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699006; cv=fail; b=VX1mevjTvF3x1MnntyAzmka859rdpraBpVHbpMoRLw2EQG2NVF0Tbzyqxl+/D++9ZVEAXklv20d0jCUtKIW+8feO4+L7TLeMuVk/r5akN6ap77hoCY24nAlWddSlOrpesN418yXqzJfDJKYXrx9ZlSgtebE8CqjtK4jXVUr6k/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699006; c=relaxed/simple;
	bh=nTb19nvdjandEA6OWeFtWmuLDsbkT+f2V3schxej6qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RjfMFagUB1nzz08r12bxsNMf8dOmoZGy2LbEMMBHUBbf5Bg+IoG71gF76L1wFZ1MrdKSqNe+i4Qxa2uZh1Rkov7473D647deUwbWN263AGLqCgZilonWnTr0cMVUCwQ9SecNj9f2ttGnqxfWn5AAqvIP+EznDNa3nhzELD74yo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vdGHzZcC; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4O3+ulsWge/UD9QGpZuk8DnFe0A4yvKcSCMKfKkaNszgBiXpQ0RKQA9Kmy8HjuUSz+d9Keca7rz5esNdUZZ18P/214q+VLBBKpfi5DYjMHB/vLXLBRlouQ98FJNgFa3IpUsAOsMciEzTqE+7bVrBiG0ExPog/e8ztOgGPiy7RXTMJ86JMkaOZomPKBB663bUn+UJlOwavT0Mg6WrBruBpR0WVz2kIslyn8T8BdYU5Q/Bx4G2dHNtvzrWeZk75hzKFFPsHj61wxvIJoiYan6OhYkFHsVmYqxMKQWvsL3rUjW+kxNbX/7FZlPfGFp6mG9bX2W6bPR41dJ1HzTFo0DKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOcXcgmiAiFVOzVltynIQkZ6Mp5zWWEcvgnIjueq2kE=;
 b=GdVxMJdIWRuUyq8f4ne78d0UGa4FGZlFvjp8GlT/CZZWVuf5mKy6DqZukItncj2zLx3NIsaSq1XFXbwgeQI802tY68SU/XPJaIdTJEM66Md1ouoq4c8y2ucXjpHVVTJ4R01165bIocPhY98OW1btfqttzZkkxU9QP5FJbUaPglgWghdLrcDTHSM23b41SLnPC5Ql3mCFx6LqIfC2nQTHFdPeA4tlguTBqWYy3bnLpDbH+Skp9o+L1ztzqEjMNaeC7534yQtZrZgxVxwFaZs5Cdn5+forMiWnMi9mz30sym0h8wqh4sM7E6FeXyPBeuehhTzNgE6NxHYe0fplSkuqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOcXcgmiAiFVOzVltynIQkZ6Mp5zWWEcvgnIjueq2kE=;
 b=vdGHzZcCbiuiGkCI1wPCwXaASwEnJHYcd6TP6wokkhLwB27x675xQtPrg4PYU7rWjcamx0XIQwaN1uX+Ya+5MtS4Fo75mqGToeuogc7LDMwtqIkCQmYenJkjcGvZ3yjqQRUDSOf4owttXf/QKUP9TKvA3QFZCqsB+6zZiA/yCPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 15:30:01 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 15:30:01 +0000
Message-ID: <4412b1f0-70a0-4581-8272-464cacf6d5e2@amd.com>
Date: Mon, 20 Apr 2026 10:29:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] dmaengine: sdxi: Add PCI initialization
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-3-1d184cb5c60a@amd.com>
 <aeXJhhPgfGjGZa__@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXJhhPgfGjGZa__@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:610:e4::12) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: d2149e77-cab1-4d3f-b8aa-08de9ef1b038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ssz7tjFj8nMx83aiV34VfH+oqmiCExBn6zcN4iyWFmUfesD0W8IpslGbbUR3NcLttYmz8vmDYk/quRbP/jufuKGS1XaLCiia5pZ79WXLJyAhaIsV1XdZ7IQ4gnpkKAJutfwQeCSzJ+RVVPSlam27e+v6zkaoGbUjHVwF/e3U4f6WG4fBr2YW1N5w84kxhXBpkvehA4FlTjPOA4JEodo3vanto+6wgbKwGEBHAAEx6wgTf4x79jeltHeyrF6MHVGqEksDLu3nbffapFaZ1/EcRuWGkYP0UwXxK49YmsHKXVKWUFlIhAjTMfElLSigjkguQG/M4azrUCvsrvL0zg3nIVy6hY0ip+59WvQ6dB8YCvIb3K0OHLXkq3+a9iuNHy1ZO0tC7lBZhw1ZrRl8aCvPTgGNIoZT1WjtX0RBCeRZxPIMsaSTaRIBWCq4/+XyXyIdZFScIUvPWxt7R4RSX7Asw3YV14d+7KNgm4Fl+QKUY5xK2rnt/IW+bqEWf24S+MKHPsufDofjPhGgc4Xs5T61FJOS/zX//OBdeXt73c36RVbG23R+wglJd2/lgZuakRky6dLnabTUZpYACKdvAxUU0mbNT6NE2bxbKTROxhOXqzdxyicRyvC+wTzQkDXT9ppft9GpFZ0J+6PdzoChGr+61Gcw6lYJfoJanBqUOgRRo+vEgW0roiqN0nskwMUb0amQDjqBbZVSehpJAHbAS2iSulIufiUfbwwvCtXENz+29H8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkt5dFFubWVSK3h3N3lCMWd4cXlhTWs4eWQvN1Jza3RnWG5kM3JmZmd2U1pY?=
 =?utf-8?B?UzZvc0JMdFRhNWozdU1lVWRKMGRjUVZyK0tCaU50TTg4dVlESXZ3bVhDZzR1?=
 =?utf-8?B?YW50QUZQM2VnMTVxOXpCY1R1cVBvUjJubnZGN0c1ajM5TUFtandrcmF5NWxE?=
 =?utf-8?B?OXFHNzF2UDM0YWtxdG04QWJaclRhakYwckdRaE54TG81VzZyWmpCNXNpSHh1?=
 =?utf-8?B?eEdwU1hNOUtNMmRHMGFhQnY2eVNWUkdNR0cvWUZJWUJLRWFheWxzWGdXSVlJ?=
 =?utf-8?B?aU9vTHVxTjR3OGVGZTdRS2lFMjhCKzRFWkYzTlZXSXF4WGIyOThqL2ZWT1lX?=
 =?utf-8?B?YWFIRmRWZkpVSC9qWlgrbWhub3ZPdy9aS296T3JvT3JtQmRSbCtLK2Mvd2xu?=
 =?utf-8?B?WXJCRi8rU2VtV2pvWEhVL1NqMHNGZktDM2lOWksrcCtpVHo2UFI3MkMzWWVl?=
 =?utf-8?B?T0swMXlyeWpLcTVWVzE1OGZQc0RpRjRpc29hSXhJYVdLWUkvUFZ2VlFrT2s3?=
 =?utf-8?B?R3FiUGFjUWJjMk9FRnRVZmE3VHU2bktXQ2Y0bEY5Qldxd3FGZ0taejl0M1E5?=
 =?utf-8?B?RHJEKzkxMFVIOE9KMzZGWVFYeStCcGNVRXlzRktkWWVTUUMzSDJpaVI3K2pE?=
 =?utf-8?B?K1lqc1R6Q1hyVjh0SjV0NEltd0ZnZmo4azRuOTZqbTNaUWt3ZlVUNUFCYVBR?=
 =?utf-8?B?b2sxUlB5eVVPM2k4SjlQenFDeDhFaUtMRGt4aVFvUml4YzZmM3h2OVl0QnQ5?=
 =?utf-8?B?OHcvYm5LbXd4UUxvc01BQmljclg1ck9NQ3o4UjV5blY3Ymh4TnQzT0hIdHNO?=
 =?utf-8?B?RlNaZnMrRDZ1dVgvaWlKNXNXSmlWSDdhRXlLK3JMbDYycEQ2NVdlY1dhK1R3?=
 =?utf-8?B?YjNGTW9pMGtaeS9pbWkzN091eFcrTWh0bkhvNlgyaHFkMFJQenZOUGdjQmhX?=
 =?utf-8?B?VUFzT3NLdHEzaXBwYU5xcG1iNXJXT3hNM3hFNGY1UHVnWVdYUFNHdU9CSUdZ?=
 =?utf-8?B?eFZTTWJCQzRYNWUxYXVOMS96bXRaL2Q3dkhMWEhWYVRsV2poaFBJTVI4OHJm?=
 =?utf-8?B?QVhta25nclpsSFlBUVgzNHYzeHlPR1U4LzJWTkk0UTZ3U3dVOFh3ZHYyczNJ?=
 =?utf-8?B?Zk0yNmowbXdaUTVEeDNXeW5LSCtEL3J5R2V0aTFCeTg1eEF6dC9lYjZoRFJO?=
 =?utf-8?B?MXF5Y05oejBuNlpXMUZTaHB1eDc5dXBUQm13VUZLOGl5VGtEY2l6RTZwZUY1?=
 =?utf-8?B?bXV1ZTNtSVYxaXBaSWhIcGVPNFVLWCtFd21tZjZpSTZIc09wY0FuaTlvbXcw?=
 =?utf-8?B?eXJxMTMrMnlEU0ovNTlxcFk3VGtrYTI4am50eXVheWVBOUJrRVMxQnU4SG95?=
 =?utf-8?B?Z21uWUdPMXdoVVBYZ0ZHNXJ2ek5Oa0VEMVJ1NVBTVVVPSmNkazBLUTYzQzR5?=
 =?utf-8?B?V2psS1NsMFFjeFR5MjZKTFQwblF5MzhFZElldHJOV1lwSllGbzUxTzRKKzEy?=
 =?utf-8?B?VzZseVN6THJVMC9yTS9PNVhDMjZuODRPQTNhd0x6OWZUR1J6M3JKNWtuYzVR?=
 =?utf-8?B?OStVN0craUM3a2JuL3BsbWJaOURzbXRVTzhMd28wdEJZcGg3dE9pd1BmSGR3?=
 =?utf-8?B?VGZkejNWUXFXdnlvZVFPb2UyYnNIeGlKWDNMWkNiRFdBYnFtMnJzb2pLdngz?=
 =?utf-8?B?K1o5QmQ2Ynd0c2FoZDRjOU1TN1ZjNEw5cXlTSzNvSC9zUklhOHJ1ZWVGYmsz?=
 =?utf-8?B?QU4vVERZRUhmd3dzUW5ncHZzZjBtWjhkaDAvM2lQNG05WTBzY0hVUmR4WWZD?=
 =?utf-8?B?eWVGR0prZWNaZEJBaWM1WGQ4N2x1RGt0eXp5K2xUb3k3U3ZoQnlyZVhGQ1hB?=
 =?utf-8?B?SlI0N0tEbXUvZWdSN2VVblgrS0FTVVROSGp2bDNtRlhlMTJhU0JDcHZoTFZz?=
 =?utf-8?B?T3pBVE5OK1d3bkZub09tKytrUW55Z2lNU1dCdXhkRElEa1FIeGVtTHVGY3Z4?=
 =?utf-8?B?MEc2QmljaGltdERXRDNYakw4QndNeXMrSnNMNWhFanRMYy9tR1ljQVF3ZVQx?=
 =?utf-8?B?K2pjelFpQUdZU2ZSRjhzR0h4ZDRzTGVhQmZiU3dQam14cUZRb0J1Y3FhRjdw?=
 =?utf-8?B?dy9EWkFIZ29tUmJYaGNhOG15Z2NtcHUvMm1ML2ZCTlpObmRVdWdJbUhVdzE5?=
 =?utf-8?B?TTBJeSthSldFdU5FS05xV1Jmc0pWL1Axdm1qOGxsN3Yrc1hZU3ZEVHJCcVVl?=
 =?utf-8?B?VUxJSlY5Nk9nUGpZL1NSVkJlZHZya2Z6ZVhnSk01b0NCZXJLSXZpS0gzSlR4?=
 =?utf-8?Q?u/9ZXeGhUULEyMd3u1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2149e77-cab1-4d3f-b8aa-08de9ef1b038
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 15:30:01.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLDceeuifvToOz28t/tOv+CMdSNFTUbb18zM4bLFANGuUF98o12BS3Lxf/qPYVCJiERLfMmqbYM+aFh/yWVpOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10066-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FE9642F786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 1:36 AM, Frank Li wrote:
>> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
>> +{
>> +     struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +     struct device *dev = &pdev->dev;
>> +     int ret;
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to enable device\n");
>> +
>> +     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to set DMA masks\n");
> 
> Needn't check return value when mask >= 32.

OK.



>> +     sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
>> +                                         KBUILD_MODNAME);
>> +     if (IS_ERR(sdxi->ctrl_regs)) {
>> +             return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
>> +                                  "failed to map control registers\n");
>> +     }
> 
> Does check_patch report warning, suppose needn't {}

I don't think so, but I can drop the braces.


>> +#define SDXI_DRV_DESC                "SDXI driver"
> 
> If only use once, needn't define macro.

OK.

