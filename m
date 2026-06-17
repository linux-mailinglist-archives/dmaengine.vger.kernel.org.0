Return-Path: <dmaengine+bounces-11577-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0bEREWeKMmr11gUAu9opvQ
	(envelope-from <dmaengine+bounces-11577-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 13:52:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD26994C6
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 13:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Tun7JeIz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11577-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11577-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54BA930AD693
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A643B2D06;
	Wed, 17 Jun 2026 11:43:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70139891E;
	Wed, 17 Jun 2026 11:43:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696625; cv=fail; b=ox7bgvs/Uc0ZFb/LSAoCox7FURQ/io1sfctPOthiTHlhGlZ1JRd0enBldUbuuSMRr1xcH83VPeRu22yASD7AlkfmBnN1iK7IvaAPJ2ozveuRBpp2zRd2isjWVTl8rVcYi58Szo+DNy/rYN8iBIf5EmKxh8/3f6BOcB8DIzrkqJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696625; c=relaxed/simple;
	bh=HvEE2IgvWrHGAZbNOJD4+8eCqEx2XdmgNNmY6eNMbTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHBT/x2gBvGkRfgarxqQvu4nSxLbEV9N4dl0Uo1wT6DmB/SStwYKlbgm1HHo2tChLwF5jlOmnikxSmIH175xlM+nCIK8n7dcCyvRooksS13d7+EGqZGz9QEHWEkk04J0Cqa/EtELl9WbuhzccWL8H3sC1ZhQatKoU7VxSUnXkxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tun7JeIz; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd4n05B/FFbM+0H+cNouARWhwe+4mGaRWd9KxAGyCQqeYs9xf8U3VHk+iPNpEdYi3RV5EVCak1mgB9s8BGQUE5EUg3cNMAzfmEXwZ+9wXnxYx5/e/kJdhsYUC1S7Vzggo11WSUj7hZmFG4l+oFTkHbNrwKd1aOj26MSBe/o6TavUwD+rT+k+fVKyr2nN9tCrcQltE3aAEtPkoBSFelroTjxeQM5/5fThiP0ZSJETjlqk+vW3EITIQMhbLtzguPffakKYJiCJwHI8Gjayd974YaPdJmXmSeTX1uYi+uVQ69YH55CAqyLQtRILZUu/zCQOXfECfwhKE0dA02rgxO5Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTWoRBkggG4lnIHT7Fs31N+4CiUhiE9U000PmEtCKiM=;
 b=Pr64pZ9vfgCEzHueLePqRX1+gHDS7Byxi9IUjXmWO4OSvqH+GQq1M4abNiMuU8PZHnDut4oOVTf46SvBqswUytDVBeVIbSDKowc7xPQzguinYMiAYsVmqCAIpnz276nJal+ahRuLN2gjbe7/mzbfY9BNbRcUXfclLw1+XDA5HrAnoa/ocPVZA/ws/ID3AQowqjUrQbkq3iUc0FGvqUQwR+sKVWlaR6qSNoCbHT9MJHv0txaVr79GBJQhRNysAR3HcvkJ9Vvw1Qh3RjqpytdzRxzLE3ZKuPJpS1esD8IF9OrxYK2Ocr8OSPSR/5Ng8XljlORfYdHYMFK67RJs51rGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTWoRBkggG4lnIHT7Fs31N+4CiUhiE9U000PmEtCKiM=;
 b=Tun7JeIzDn+8LzHJpMMlsEpf8XSl1OgNr1r3jP3DaGLWwpOpdGT37ehGgV49OFae2vqWBm6gF09oVpvl2xTyLRD5p8GFQM49Yh+PCUK/hRet8aZzXxhI1Qf4Xo3aBIy9j61n5rvvRHsjKL/Rn0hINxkzeaZ+FtNxQU7Em3KxPZI=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:43:39 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:43:39 +0000
Message-ID: <4ffb23c5-de2e-44f6-8d15-0f9ac563b609@amd.com>
Date: Wed, 17 Jun 2026 17:13:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/2] dmaengine: dw-edma: Add non-LL mode
To: Koichiro Den <den@valinux.co.jp>,
 Devendra K Verma <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, bhelgaas@google.com, mani@kernel.org,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
 <20260318070403.1634706-3-devendra.verma@amd.com>
 <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0286.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::9) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 127b3588-f095-454e-2fc5-08decc65ac6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jTmSjVKbqcDuiqJBps6neu7TEeiPth3kleYsDlX9M1nECZ//pYC4v2irkgcQqZ3qmK3vNaDI4UcYjPyuSKaqny3P5m30VxQbcNDlzHbpcCwC0tRt5oPOx33NQIfEt++IULOx1pQgS50S3dCai1vK661Mqxm1JArfMcbIbYt9A+my3Rs7mYjzJIueJ3llu7xwLjiqJ+pJ/+Y018qtRcsj/jghQ4eKQaxEry5cLI+yWMgr7AbOt8C4xwJiQTpco8Ofec59jvMWliFGEDdfIPAoqedHLYhirBNYKwSIG1DSBte0BT8LX7Q50MgHxj1rxvSk5o05i+DfY3Yh97b7riXeu5qoxQqVtCp7VP1pd1Aj3S2XyVJpGW3KAfFlOUyZstZl3mxw1Ng9Zuw528uWloKsr3CNThrvZrg/EnQg2xg4ODVEALb6BocADS10fo7ktjetN4929ptLRtosRgLp6RS7DwF5C9FjdIVpo3MkAJNfi1JK/L6ANbTZQAFzN+CtGPte19LQfZ4UYgC4Vn2hjft7RslmIPJ2Fdl3HUL/lETdNNYyt3GgJYJRv742lPrYQ/pTvs2br9SAbxYZUwVgOvXOBrsPlZveuGse7xtPST+j8mDQv4ZFqXfYkmwzeDbg/vY2hwJmXNi0DZh5lQueIBrip+IKytpwB1LWxkTboRG2mzlC0balMGcsOC3rWmAbV0XNxRQRxsyeu1GXSXA5naPVdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllxOWJRQ0pXS1ZyNEt0ZXpaaEpvTWVqOFk0M2ZDU0lwbHN2VnIveXpETHVZ?=
 =?utf-8?B?akNQOGhXdWw5MVdLZU0zM0QzTzJ4dUZrR1BFOUpPZlBhczVXbmVxdHNNRERQ?=
 =?utf-8?B?WEtXTHdGOHlib1g2ZTVPaDVGVndvMzJ1L050amNFY1gzMFFibmxVdzAvK1Br?=
 =?utf-8?B?bEhTYm05TkIxK1Nhcmp5bVlZOUNtOWRod2dCbm5GcTJFKzFweWJsVU9WRWlt?=
 =?utf-8?B?djRiTnFvUnRocURUcnFNZ3dDb3Jpc3hKejd5N3RtYlBxQS8yZjAzT0M3UDFP?=
 =?utf-8?B?cnE4UTJwd1N2Yk9LRi9LSEl0cEx5UVViNGxLQTU5RUNMcVpQZnZoODUwVjdC?=
 =?utf-8?B?bEhZVFF2VjhsQldvMjlySHIwN29GRi9MVVRRc0tFdGYvLzN0Vk5pdjNVbFp0?=
 =?utf-8?B?MThkWkRoR1pXSlUrc2ZVczhnSm9uZE5FbnZvRG0wd1NSbW9abWpON0szczJh?=
 =?utf-8?B?VTVFZDNvbTFHWGVobzI2emJIMnR6Y2JadTkwWkJXY2NhNkNqQmZhMXE5ZVZL?=
 =?utf-8?B?TUxETVpCVzc3TFJrYVFiQ0taTDlVVk5nQUtDTkhlalVPTFo2VXhqL0lnQWlx?=
 =?utf-8?B?bzlweExoSTNCRyszL0l5OWozNUVsVStBUDYrVVdmcityYnZKaWtlcTBoRnRC?=
 =?utf-8?B?NFEvUlJuRVdOYUhtQzhiQlNGei9GcmlEMWRiL2NTZXc2MERFYkdWRnZ5ZTh3?=
 =?utf-8?B?cDlOdlZRMWR6UjZIeUI3MzA0UHBXZVRYZTFFWXhJcHpxVkZyaEZ0T3IycVZu?=
 =?utf-8?B?bUZZM3ZrMjdYWEozRHZreDQ3QVhETXhFT2ZIZy9oK2JZN2hnczQ3S2RvK1o0?=
 =?utf-8?B?QUFOanRUOXQ2c0hPU3gvSzQwSDhCUk5KbVFCM0d4ZkVETGd6b0k2Z01aSCtD?=
 =?utf-8?B?N0FYNFpIQjY1SitocDdmQ3ZzNzg1SGxCSVIvNm9pQUJ2L0xMZWhDc1pkREFt?=
 =?utf-8?B?K0J3UWFYRnJhTVREUExPTnc3dEFIczdwdEJuekEzK0tsaXJxVHNWOXBYaFNO?=
 =?utf-8?B?K1Vzaks1N2M5c043NTcwMmNyRUNQYXlMUkdqbEZhQ3kwT1lxT3RHbVVnR1ox?=
 =?utf-8?B?VXBMNHlzaG9HbVQ2eWhVb29yQjJndUVmR0FYZFNWNUFxc21xY0M3TFlYYm10?=
 =?utf-8?B?a0E3eURFZmhHWlRFU3ZzR0xTVDJkc09GdmJ2SzRyZnM0SllEajVBL3F1Q3JM?=
 =?utf-8?B?UHZwZ1doSXhxc2hsOWR1K250MWVGdktQdm1zVHBRT01xeHcyaS9oNmhCU05a?=
 =?utf-8?B?ZEczZkZZamU0a2FPQnhHenNVMlZRajRXY25KZjF3MUdXVm5WTUlYMWJLMU9a?=
 =?utf-8?B?Z3dRZ2pJOHFyWnZXRFFKd0RSVGliWHo2bjE4K2VKdm5VdjBhNWVHait6NUZW?=
 =?utf-8?B?bzdnZVZjM1Y5NXY4VGREVkhURklPSHAxVkhTM2M4K0QxNGozQXhXV1ZrTVlE?=
 =?utf-8?B?dTBVeWJjUzN0WnoxTVpzREduY0syR3RPdTRZMzU1WDRNVG5ab1MycFgydCtZ?=
 =?utf-8?B?WmNuVnJVamhlUDQ0Z0RjSzJhK25tdW0xZlFMVXkxQ0NSVU5ZM0o0aDB2bFN0?=
 =?utf-8?B?SUVaRnExWUdGRTVFc0pWbitnSUFsb0FvNXlGTnVyVFRGcWlqNHNIc2VqeEJw?=
 =?utf-8?B?VFowOTM1WkNVc0lPTEZTN2dZSDFzd1VXYjc0ZmtSUG5HNFNpeTE2c1YrdkhX?=
 =?utf-8?B?VG1ucmhkWEFTNTRudEwyVncxYk1yVWI4YWtyY2xDQlpBdGZxa2lyOGdpNnhy?=
 =?utf-8?B?Q2pZK0ZpL1BzVE92YU5mc0ZMSXIzRm5DdXhTTW9LN3Qya20ycCtOLzZHcFN1?=
 =?utf-8?B?THRNaTJJL0lIdkNBdEhnVE5JdmJwQlI1YTAyeTNyd3dQd2RvT0ZxQmVSL0pK?=
 =?utf-8?B?NkR6THMyQWlDZ2JvTHZRY1U1YWZPd0c3Z21IbkwrSERnSlhmMFBBcHg5N2pR?=
 =?utf-8?B?UnBpYk5GVjB3RmpqSkpabS9xVnRRa2s5ZWxsSnFoU1A1bWpaUXpMbzZjRnds?=
 =?utf-8?B?NWR2S01YTWljeVNlKzJHbzZVTndBWitaZ2c5bk5hRlNYUW1HZEJLTnBXYjdY?=
 =?utf-8?B?REhFT2o2QWZPQmJhcjJaZkZmQXRxOWY4dHVSaXZDVEo0MksySHYrQ3loMC96?=
 =?utf-8?B?UE4vYWFXbmNWYjYySUVISjhKSE1QY1NaVWUwdno1bVpKNm9pMTNKeFVwdEpX?=
 =?utf-8?B?QmdmTmh6UmxXSVUxVVNZQ2JPZHMzUWE5cmJUQkxJbHEyY3VhRnJ6eHBiejdQ?=
 =?utf-8?B?ZHdpN0xLdStlUmJtdkRSajJWSEFZOGYwRmJXOThIMlNwWjhDZ0dTSWd6c1VT?=
 =?utf-8?B?U0V4TzFkZXU0ZnFhOXk3RUxCZGk2Q2NnaWhBczQxdTVYcG5LUFh1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127b3588-f095-454e-2fc5-08decc65ac6f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:43:39.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m1wH+GPEPN+SD7qgAt9N7B5vQdzxJZsglmMLPA1G03jEn0T8IPgxtPj6RY7TCF9SPe1nPvH/TyRJArMV663gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11577-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DDD26994C6

Hi Koichiro

My first reply was auto-formatted as per the column limit but got
expanded after I sent it.
Re-sending the reply with correct formatting.

Please excuse for the spamming!
regards,
Devendra

On 17-Jun-26 08:47, Koichiro Den wrote:
> On Wed, Mar 18, 2026 at 12:34:03PM +0530, Devendra K Verma wrote:
>> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
>> The current code does not have the mechanisms to enable the
>> DMA transactions using the non-LL mode. The following two cases
>> are added with this patch:
>> - For the AMD (Xilinx) only, when a valid physical base address of
>>    the device side DDR is not configured, then the IP can still be
>>    used in non-LL mode. For all the channels DMA transactions will
>>    be using the non-LL mode only. This, the default non-LL mode,
>>    is not applicable for Synopsys IP with the current code addition.
>>
>> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>>    and if user wants to use non-LL mode then user can do so via
>>    configuring the peripheral_config param of dma_slave_config.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>> Changes in v15
>>     Rebased the branch
>>
> [snip]
>> +
>> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>> +{
>> +	struct dw_edma_chan *chan = chunk->chan;
>> +
>> +	if (chan->non_ll)
> 
> Hi Devendra (cc: Frank),
> 
> Sorry for dropping a comment now that this has already landed.
> 
> I'm wondering about the lifetime of chan->non_ll. This patch lets a client
> select non-LL mode through dma_slave_config.peripheral_config for a transfer,
> but the state is stored on the channel.
> 
> We use chan->non_ll in prep to choose bursts_max, then read it again later in
> dw_hdma_v0_core_start() to choose the LL vs non-LL start path. If the channel is
> reconfigured between prep and start, or before a later chunk is started from the
> interrupt path, couldn't we start a descriptor in a different mode from the one
> it was prepared for?
> 

The mode is implemented with the intention that after prep, the
submitted descriptor shall completed with the chosen mode. So, yes the
mode is decided in the prep call and all the subsequent descriptors are
completed with the chosen mode unless it is overridden by another prep
call.

> (Note: Frank's not-yet-merged dma_prep_config v7 series [1] also looks at
> potential races around config+prep on the same channel from multiple process
> contexts, as I understand it. But this seems like a separate issue, since the
> state is read again at transfer start time.)
> 
> Should non_ll be snapshotted into the descriptor/chunk, maybe as
> dw_edma_desc.non_ll, or is the rule that clients must not reconfigure the
> channel while anything is pending/running?
> 

I am not aware of any such rule which specifies that modes can not be
mixed but it would not be a good idea to mix both. Let me give an
example, in the non-LL mode the channels *can* utilize the LL-regions
for data transfers. If for such a non-LL data transfer where LL-region
is used and intended by the user then changing the mode after setting up
the mode to another one can cause data corruption.

Eg:
Channel LL-region = ADDR
Mode set to non-LL -> DDR destination to ADDR to (ADDR + size)
First non-LL burst -> writes data to ADDR till size bytes.
Second burst configured for LL -> overwrites the data at ADDR with
descriptor information.

This one causes the data corruption for the first burst


> Or was this already discussed, and there is some implicit restriction that
> clients must not mix LL and temporary non-LL requests from multiple contexts on
> the same channel?
> 
> [1] https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> 
> Thanks,
> Koichiro
> 
>> +		dw_hdma_v0_core_non_ll_start(chunk);
>> +	else
>> +		dw_hdma_v0_core_ll_start(chunk, first);
>> +}
>> +
>>   static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>>   {
>>   	struct dw_edma *dw = chan->dw;
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index eab5fd7177e5..7759ba9b4850 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/dmaengine.h>
>>   
>>   #define HDMA_V0_MAX_NR_CH			8
>> +#define HDMA_V0_CH_EN				BIT(0)
>>   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>>   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>>   #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 270b5458aecf..61d6064fcfed 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -97,6 +97,7 @@ struct dw_edma_chip {
>>   	enum dw_edma_map_format	mf;
>>   
>>   	struct dw_edma		*dw;
>> +	bool			cfg_non_ll;
>>   };
>>   
>>   /* Export to the platform drivers */
>> -- 
>> 2.43.0
>>


