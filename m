Return-Path: <dmaengine+bounces-12345-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K5H3KtorUWpoAQMAu9opvQ
	(envelope-from <dmaengine+bounces-12345-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:28:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492073D073
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=HGbQ8rvi;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12345-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12345-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877BF300A381
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28A372070;
	Fri, 10 Jul 2026 17:28:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D652E62A4;
	Fri, 10 Jul 2026 17:28:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704534; cv=fail; b=da4m3sNgjt+xVwXMXRPgjiBpSZHEpIhHP5rNBWHcjxsQGFpvCj76zoVxmk6sKg1cbfX6syT+miUI7rX0OtH5WvwQg6Ld1QzJ8jZzT+QfQf/I9g6BMJ3kVqh1gSLKXKztby1Q9PHH9mgiAbtIYL2KwitUM2GzapEdrP0GBF27vzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704534; c=relaxed/simple;
	bh=7fi08I0froHYKiZNFBLfdtwgVnA1GgglfOjiIqqrkqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GAUtnKGajVcj4CWPNSm3Vow7cQkLBCxDEGMzcWe5cForkicL3rkv6r2ZNeMg2JbITjXsVUBUakjGYUgzBvFO8xmM74GybGZHCpX/hbb1ZHCAHCE6ZvoTkPnbpG9aciyoEbHd2MlZl+3mDlyiIRxa+4XjWOHSgfREbCUaPzVzc6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HGbQ8rvi; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5OGnSeCBgFLUta18Xyw0jzvQqRd4xtJG+KTnZm2HQxdDt3kKNrXsxmR423kiUbLnMXrE8DTR2Tw2auzQdRDyyqhuCN3rD2izQUe2axpYNOxrzIdxuxEISsDW4CVJtSB+eyGDxcfq4fGDCBdyAOo7cLhAfUGrfBut4QGsbGL0/7+tSGnuaSPBwujVyNaiuEuzPNfonogwpJTjct+b8W4N+aEwVt4FzJMO3AxfRBU2kusfEZQjRB1fTQO/h6ens7H9Ziah3o2NjvyYQR6H17Nkbyuh6BZJCbmd3bBr/sb47HVOEPeIbkwtNDRuPxBJhdU5G4SMRY9Ylac/EkSXLmWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYWw+xuPG/oKsAhUctXNmav70ZKrSgiZEUzEK88W5c8=;
 b=o7u3PJGS9RbU4Nrx2tmKFL//OZ+V8POxtwMnFHFvpqYWzE6ZmhmKfJk8S3YmIxo2DbN5Qk1ycxjhZXdOdawhjRFG/B1Jqdqdj8fwG8q9Aq84aqlYAQ2BiGooq8v1CgQasRV3h4lZ7VZdYnoVX3/lSux2qiFIqDdod+KIFwCsWJVI299mnVkAhjJFs4RL5PUgwzJFanpljQEI2ZIm99FnBLRFoa85P4WdQqqK0mtd/Cv3n7AH+lutG5n+CibZnaqM97dAF5uip1HWr8UVZJ/YpaG8LSEGOIdcCXOMyDMXmWmrATbZdp8hZjpg7IPpc3zoIcUoc0AdBmYW8oGrJ1wk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYWw+xuPG/oKsAhUctXNmav70ZKrSgiZEUzEK88W5c8=;
 b=HGbQ8rviokYe+8ZFjNd+dA786d+1bJHSMX9dOVtOMDnrgxx0X2o77zfFx5QGdm2l4tWlYIEXzDXcfu0WdxFNrFEI1o7qaWVmmwzcuA8t1e/u+BKmDQ9VPtvYGbaOaMe0ITe/MsRLSI6UINtz/8hjeYQzDLI+T9nej+tFmcIXlY8=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by LVUPR12MB999184.namprd12.prod.outlook.com (2603:10b6:408:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 17:28:49 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 17:28:49 +0000
Message-ID: <a7c49756-b042-445c-b012-e5162446f9cf@amd.com>
Date: Fri, 10 Jul 2026 22:58:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
To: Frank.Li@oss.nxp.com, Manivannan Sadhasivam <mani@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::35) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|LVUPR12MB999184:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ab760b-7fe9-4472-5484-08dedea8b42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|22082099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cBmthIDzJM1wQYMBQ3V6iOpwVSBI4kyqoQ6yWcrHU+fN6n393jxPuWLwDjAoCdWfX76RUDUispvGCRM6r+OVnMMC3aF/kSTDNLMSBR7tQ/G1rbcP3COuzML2dODYhQrk1oVKTLP7UCd1em//AfLiQGvUlYrkDcJH5mioQr0VNdAKuebZiS1V1K1VjL/ErrBb/XlB92UiDMOEnlAr7ePMYa/bAkslIebpi5xum43acCcorTM80Xqg8vikQRYASBN69C+KFLjxnLYpwYJE8FrGP8h6mndTWADVuankFpbTQGw0E3aSCrznD2fcCPKcRa7p2pCzFeZjBfrM9dGPLkYN4/JVtLWcDNBkYDlLqDKevWKd/oTrnT4dROe5njqRmKUcqE8ehIdWMWT4gGXimj0CRLY0NSSAukrTjBjeqbXBxDEb8tPV6+TIwhYMeulVDE9qgfWyYe9NpN6LKqj+xxbdLTPYgX2iwOfYNGKosPd8dydyvKbxAN/XeU4zeUXXSpgGq3F39rUXspdPqbhpgn7FG8YUxvzo5GXcV9pX3Sysfw70+PbWjr7LPNvO6oR6s6fPoByhmmSE8Lveiw9y4gFvx0ozpf5jv3h6MxheuJ3/iQ7N4MQPcDY6wb+6z6ONp2n71z6ZzPZcDVH7n4daSZbHHCGZaT76epoW7UtUaVNfde8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHh3dGhTMm5PU0dYenVEcE1GemlJUW04Z1VMb0xCZXFqTHpyTjJycENIL3Q1?=
 =?utf-8?B?bllQRTJaVmRxNFB3TmYzVm5tZHZJcUZzcXU3TVM4eHFES1pDMmswMDI0MkRx?=
 =?utf-8?B?YUY2TXZGN3FIelRRbUNsbHduQ3AyQzJHZkM5NTVvVzNNalBCdUJHTGlKZ2xs?=
 =?utf-8?B?aUs5Tm0rSElTU2dIZVpPK0RrZjJHcFhCck9wRWI5T0hkN2FWcXlkeGM5Q2Fj?=
 =?utf-8?B?cnZvNXA5OW1DNUpCMXZxU1lkemxGNSs0aWFnUGhYZUR4T1g3Nnd1Z3YxdDgy?=
 =?utf-8?B?Wjg0RnpaTE91V2RYUzE4cXJZdmJGOUVudzhPRmprSVBHcHptbzhkTlFhUDRt?=
 =?utf-8?B?WUVJbmIvenI5eEFSQVVGOGRsYklLUzk5dGNrUFZxSVVUMmtscmE3U3BJREFO?=
 =?utf-8?B?TzVZNkJtOW1reDRESnZxSjN0ZmkvNjBVaURIbUVteHFLdnZwYXNUTUN5UEJF?=
 =?utf-8?B?WkVGU3ppbEV4RlhZQTAwYUVhejJvUkp6T3lJMDM3dThIVlFucngwVWZ2eThE?=
 =?utf-8?B?QXhscUUxS2daMkkwUHI5aFRmcGs5cThNbzlrcFZaNnMyYU1iTWpOOTNWWVdv?=
 =?utf-8?B?MFNmM1VOUjRrWFYrZk00dm5GZUVreVdtdXpqV2JzMUNFRGlONFRHOFcvOWlp?=
 =?utf-8?B?MWFuRmpXRXRWWFlJTlpSVS9JVFcvamVDUlczL1h6WUJYRzRBa1M1NmdBTzh4?=
 =?utf-8?B?OUxlUnYvZllzTnAxbFgreTg1N3VKeHY5QjBNMDAxRTNWbHZYcldySTJXMHJF?=
 =?utf-8?B?T3BVQlFZNStxV1ZnNnlhZ1VRcjRMMmM3NTJmWks0YytGOVF2NHg0a1FWVVp0?=
 =?utf-8?B?SUF5Ti83dnp3UExoWHEvZkFUOHdqaHNZK1o4UDRYRmE4VHI5WUJkTGI3Y3Vo?=
 =?utf-8?B?Q3dod29pb1Y5YlpnUVhyTXNvYys0WDhYWCtrRXVFOXVyYW5zRFRFa2dOU24w?=
 =?utf-8?B?ZlRjb1B0NUpJTUxjektkMHlYTCs3RjRvMjFiY1hwb0NCNlpYSGFKTy8vWmhM?=
 =?utf-8?B?MFNsQ1ZuWWxERmhsMDlRUEFOUTlVRlp3TnRMUFlTdzlZMEtvVXZaM1hPcWhr?=
 =?utf-8?B?ci80SU9PV2ZoWm5ONUpiRFdKSWpjcGNYVm9oOUp0M3FKckFNdHhEaE9yalEz?=
 =?utf-8?B?QlR0ZG9ySDJFcVRicmlFeHFudVFqNGUySlpMUTFJMVlsZEc5VUs5V0h3dmxj?=
 =?utf-8?B?QWQ2VnRuTEx5aGc5VFNzaDNHYVpleVRaaXAwUktOaTYveUdyV2MvUWlFWXZz?=
 =?utf-8?B?VEdwR1NvS3A1SWY3ZTBSMzlTWjFZTTJkMlZzU2J4Z0U1cGU2blhSK05xUkc5?=
 =?utf-8?B?WDV0OUV3Z3pyN1FaWFBHdFpndU0yRDRDaDJ6TWdySkdMYUxCcnRCZFZwd1ZU?=
 =?utf-8?B?aHBhWkpIZUxLNTVlRkFKQXI3cFB5aXhqdjdVbjNnL2hCN0ZWazlpSzBDTFA4?=
 =?utf-8?B?UW1QM1BuRzI0RlNIL3Mxd0swNWgzRXBqaDY0RkhnWWZWL0lkb3VscGVaUmht?=
 =?utf-8?B?U1V4VzlCV0draFRiUFFmdW9VSFJOcGNZK1ZOaldtdjdnKysvN3I1eU1oNWxL?=
 =?utf-8?B?dENzdlBLaE1QYWxYQzFMdDdNTjd4ZFBZYU91biszYW5sMkYyMXhpYVU5KzRI?=
 =?utf-8?B?V3FxNlNqeklBdnJPam52TkNPUnhaSlN1RWxVQmp1WGI3enUybHg1NG9TN1FB?=
 =?utf-8?B?Q0VzUGRhOGc1MVVsNzgrTnlJV3U5cXl6czBOUi9UMjIrbWlvM0VTOHkrQWN4?=
 =?utf-8?B?dXRQME1xMkJGYzJaTzRFdmswU2FwMFBGakRTODdWZlMwcnpqbDE0cE5FaG4y?=
 =?utf-8?B?L3RtRGpIYk5KSU9DSUFZU0dIb2JrbjV6cVRwMDlLVk5jclZreXBYQlV0aXVL?=
 =?utf-8?B?aHNHandoVGx6dUJFMXF2K3BrQzVKSDEveDVMZWJEQW45aDhDandETmhNWDRH?=
 =?utf-8?B?SEs3SEJHQi9Ka256V3QxTTUyVjFyNTd1cUV3YndvbVorWHRWR2tkTTVHNklW?=
 =?utf-8?B?YkJ1WEtYUmNTWDc1MUxtcHFsM3lUMEhEc2k4bDhBWXhQbkQvVVNvaGF2T0VP?=
 =?utf-8?B?dU5aQWlRS0wyd2ZYdUJGRjFoV2FIUmYxdGQ5YjA2TXpmSGdBc1RMT1dvYlFj?=
 =?utf-8?B?RGFVTzVZRnhRSWpZeEhvdXdNZlBOR3ROa0FTYVkwd1dYcDY1MkFxc2NtbWcx?=
 =?utf-8?B?OURFUERMSTM5K1pZcFJPT0xaeGdmZ3FVRnR2NzFCbnZHekNPZXdYaFkwUlRr?=
 =?utf-8?B?UXp1UkZwK0t3Rk05VU51dVdaSGNzYVFuNng2OFRnSGpyRFBJaDZHdDZTUEdR?=
 =?utf-8?B?UU9wQ0N2SHk1QXk3TjBzdk1mUFBQaE9neC84MnhzU0FGZ0xkQ3RaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ab760b-7fe9-4472-5484-08dedea8b42c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:28:49.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzRKY95v2zjMw5l9aA3Y6WaeXgq6T3oGBKhzrMtwJbV+dn37NOuBwD+4/MHg7jWRY4cNmQXNSyresZIYkWwo0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999184
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
	TAGGED_FROM(0.00)[bounces-12345-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0492073D073



On 10-Jul-26 22:17, Frank.Li@oss.nxp.com wrote:
> Basic change
> 
> struct dw_edma_desc *desc
>         └─ chunk list
>              └─ burst list
> 
> To
> 
> struct dw_edma_desc *desc
>              └─ burst[n]
> 
> Flatten desc structions and simplify code.
> 
> I only test eDMA part, not hardware test hdma part.
> 

The patch series v5 was tested for non-LL mode for HDMA.
The testing included varying data sizes for transfer and running C2H 
(Write) & H2C (Read) for a specified duration on all the 8 Read and 8 
Write channels.
non-LL code works fine with this patch series.
For non-LL the changes are similar to v5 in v6.

Tested-By: Devendra Verma <devendra.verma@amd.com>

> The finial goal is dymatic add DMA request when DMA running. So needn't
> wait for irq for fetch next round DMA request.
> 
> This work is neccesary to for dymatic DMA request appending.
> 
> The post this part first to review and test firstly during working dymatic
> DMA part.
> 
> performance is little bit better. Use NVME as EP function
> 
> Before
> 
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
>    IOPS=261, BW=132MiB/s (138MB/s
> 
> After
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>     IOPS=266, BW=135MiB/s (141MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v6:
> - use size_t for nburst (sashiko)
> - remove unused field (sashikio)
> - leave pause and resume as it because there are other problem for it. It
> is not fully functional, need fix later.
> - Link to v5: https://patch.msgid.link/20260709-edma_ll-v5-0-e199053d4300@nxp.com
> 
> Changes in v5:
> - Fix cover letter typo
> - Fix double subtract found by sashiko AI
> - Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com
> 
> Changes in v4:
> - collect Koichiro Den test by tags
> - use addr in argument when set ll address, found by sashiko
> - fix iterate burst problem when exceed max link list, found by sashiko
> - Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com
> 
> Changes in v3:
> - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> - rebase to vnod's dmaengine topic/config_prep_api
> - Add non-ll-start() callback to handle non-ll mode transfer
> - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> 
> Changes in v2:
> - use 'eDMA' and 'HDMA' at commit message
> - remove debug code.
> - keep 'inline' to avoid build warning
> - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> 
> ---
> Frank Li (10):
>        dmaengine: dw-edma: Move control field update of DMA link to the last step
>        dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
>        dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
>        dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
>        dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
>        dmaengine: dw-edma: Add callbacks to fill link list entries
>        dmaengine: dw-edma: Add non_ll_start() callback
>        dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
>        dmaengine: dw-edma: Use burst array instead of linked list
>        dmaengine: dw-edma: Remove struct dw_edma_chunk
> 
>   drivers/dma/dw-edma/dw-edma-core.c    | 220 ++++++++-----------------------
>   drivers/dma/dw-edma/dw-edma-core.h    |  67 ++++++----
>   drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
>   4 files changed, 304 insertions(+), 392 deletions(-)
> ---
> base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> change-id: 20251211-edma_ll-0904ba089f01
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 


