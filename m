Return-Path: <dmaengine+bounces-10080-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEmPNmuU6Gl9MgIAu9opvQ
	(envelope-from <dmaengine+bounces-10080-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 11:27:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6318443F3D
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A942F30069AE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921181732;
	Wed, 22 Apr 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtHtlA9X"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2343C2785;
	Wed, 22 Apr 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850020; cv=fail; b=itH8qWRMDAbxGincDQtPSFRy8h4Tpb0y92yqubt/FtSXkylapHEx5ExYXNOkFvJkEv/5oQY6yXhnLi91jwDLaqhT6H1zh9ChD6wyZSds7zIYVmyAyKS4rcpbFlwPSyQPNgNzNovYQp8sGKlxI8kQ/Z/6zowaR3caOCq+E9Eafvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850020; c=relaxed/simple;
	bh=BTpq4WGxdB9HgpkbQths38aFNV8TsWeG40KPIypiB6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zd+bIYJDO1iRo4U9nLvIu/E8MBwHwjMap7JcZVtFgSDlFhz0RhJtgIPGw+uyStuzb+0OTAbSHIIar+KKenG1eiE8oVuTvJ8t4ZZpZnnbaQHDovZ24nSU0UWTOkRwlYPfM5lqupjc9XAT5a2NZ23t0+ijVa0hH5El1XW4Bj1XEl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtHtlA9X; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgmwE9Cqn2kLlJfYZF0t5LVpWjrh/zkZLl3+vwk2nyorMEsCYrtY2hgJZzrgRQREa14pBO6vo3+uLEba9DwH2BwKFr3AZyKoP67uB/UkC/VmFEJp1pUuQgyxLOBSC5qe1fsVtAILyh9Jvkc61rQAb7VS14/12o/zvttqlTiAh0K4pXDP6wZuo0b9FyJNa7Md+ui0OTeWde/ChovYir36WSCZGFjHGp0E1p/dNqc44WM08uth5SfXlE/a9Is1bzzqq4eTDWc6HfIIDJ8pN1yhrj5QS1FdMVuaHpIExEZCaKU6reOeUF6u8jbSTij0eifqNN/cTMP9ix0/+TZfZBnHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hd8cjdoO5//MNLKSU5zzRL5/KZczjt0FjznJjlsCws=;
 b=eagPOiZNGiFyvV22latpNvP9tKIzA0AIN2Wgcob78JTMYV053ZT3gDnKZiot+sezbw46XaDXmXYkgkpF49ybaV8q6s/jDyT56RnvWsBLnBXdmdXilLhzF2tC711YejNqcsPTVeUXGl8E8pfP6quCtfUMzVU4Rk5b+D+vPj/XlivOLVQ4tge2gK5smDhQO2WU5H3JiPlCpOmJeO8WoOdbxPAVNpXU8V6yWpUgw3ZKytzE4mp15XhAhfUAsWBKpnOppj2Tj0pIzw302VCQ6ZIalIX4MNrot/pkpvCzCc8ipX9Cy8ocKqGZGVPASiYXD55x0ksSEK8CnIcw278GXqLjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hd8cjdoO5//MNLKSU5zzRL5/KZczjt0FjznJjlsCws=;
 b=PtHtlA9XhbMmcP2fhKfedcR+z+BQE6H4hKCARPY82aaWi9x2iLe5S/pjpV0KLkbxsxrFMfSPx4/0oc7PwMdwlDLvTpCOS84W1VdNKc6UCU/xdeQ/sdc7aAru5hVU05LzFSs4wDC9LzrCGOD4TmBOI1gC29QnxDEjp4BH8tw+QaHF08BO8tv4u5Z6jUaDHePkVUIZLBXifZHOd63mmSG2LDBPHPE8Pq9/adQn4zN2itU2MB8Sv+AEl4f5wxG5BtxggrEFfeJtaCHcfhTRRA+0LK1QLh7vlR44ruizpMtarIaCFXu9aXoVgD0ErSA0VcGiPE+a1OP83CB6ppPsCKNpfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 09:26:54 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 09:26:52 +0000
Message-ID: <98255b77-dcef-40c8-8851-91e723b82ea1@nvidia.com>
Date: Wed, 22 Apr 2026 10:26:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] dmaengine: tegra: Fix burst size calculation
To: Kartik Rajput <kkartik@nvidia.com>, ldewangan@nvidia.com,
 akhilrajeev@nvidia.com, vkoul@kernel.org, Frank.Li@kernel.org,
 thierry.reding@kernel.org, digetx@gmail.com, pkunapuli@nvidia.com,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20260422064134.1323610-1-kkartik@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260422064134.1323610-1-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0516.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::9) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: c840477d-348c-4a61-2ca0-08dea051497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	D4/LNlJWqIj9pp7vKni/pZwa1W5yoWdDVGu3jiDO3TMx56dPzCzNTfIQvFfhtEHewFGI2O1Z1UJ9QSnyv/9adWo6bEsazJwWakN6SVzQ7wY89jT35VvM26iGfizFPc1id4l/UTocpRDDKFJyixDPXOe97M42wth+uvy7XrVp7skKSlyzo2VJYV9g7lsqEe26HXTG/jHjL9s4SA7/wTnKiGboTIR03Tf6YtborIRvn2t1D5stxTeGm+4AzwqvCUyY8fmUmKmky8hCh88OOA0YjIRuNUyoTAdRZSQowrOTWFR26SLgNYZB02PRSQ5bkzYzpQgGO8PE5JySP5yt6/5bSKKeuKejp1IepiEO3VPB4Lm5oOM3ylFDotKRpi4W79OvoC5aPmLgjFBMSXfO8KtKGqxx0NGau76aoUhL7fQHz4I3wcbA/x/aa+EJNfXwTzJN43X/iicE+1JnzT444g35hb9QVYb945+jZlAWn5qDArejHU/qCZx18AMjUjJCECS3iy4YopIez51xDjZQ0oEJlTOjupD9gRZ/vc7FIisxuPM/PNEqVyG19xwOynEe6SmfNvK+iTUMe6vdZt2zvWfYMl0IbXfaZCQ7VQM2NQZLrOfjTXwZmQsd70Htd/ZGxTnLw0jXLx/WCDDcD7m1WTMb3sQiMNwrkfefk08due53z3JXgomT3NsbH6pVxVhRjw2E5Aez2zaA/ARRwfMN7vNfQtIbBBwo+zxXPlogAEqxpKtGHgB9shrIYUu5YHiCazdGJ6hBjBd8IqhupCrQv7p02g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(18002099003)(921020)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFXeWtaaHp0UTVmb0d5R2Q1MnRIdEtMRzF6dVVWZ29lVkhDQ21kK2h2ZkFp?=
 =?utf-8?B?SnBNVzJIYkRVRGsyRnNNWlc5SXhvcW15c2F1OUNVeGw2ZzI0Q0VPelltejVz?=
 =?utf-8?B?TnlmdjhBTjA5WnZIc3lkRG93WERGS1E3UlYrd3lsOWEvOFg2Y0RaSHppSTNh?=
 =?utf-8?B?QlVNeU5pNk95R3BwdWYvZWJvb2dLSXlodFQ2bnNXT01xTjE5UUQvUXAyTzcz?=
 =?utf-8?B?RWQ1ZkR0ekNueE01bmRYTisvQkIwTkc4YW81ckk2bThJQXRlVUpLRzV0YzZs?=
 =?utf-8?B?aGNvdm0yakxhenJPMnpscHZWNkVDSnJYZHN6MFVEalZQYnVNRmk0alJyYmRR?=
 =?utf-8?B?UENtaFZBQzFkb2Q0eVlJd09ZNjhaOGp3U0d4OUpaN21nZ21kbytUaTkwZDFu?=
 =?utf-8?B?UGFDZHhyQXJSL0lDWWptOEhnTEJqSVE3Vld0ZUVmZUcvN0F6WVFIN2wweTJC?=
 =?utf-8?B?S3dzWjNSSXJDdG44eW9OcmtkbjF5bkF2aEQ1S29QeHZuZEhXdkpYYlhTNTdD?=
 =?utf-8?B?L2dQUkFoVzVlai9DaEowa1Jjc3d2K0xMcCttQnpTa2pEWEVaQ0dadWFsZ000?=
 =?utf-8?B?dVlmZTc1K1lzUCt4SXZMZ203UW9zUTBpQ3g2ZjFXWk9POW9oZFp1anV4SzNy?=
 =?utf-8?B?NHpqSEZxZCtZS2toY1ZaY0IrZXBycW1WYkdJNVFjUlNxaGNiWnhuQnhBNW5E?=
 =?utf-8?B?T0ZsYkt0U0NyYk5rK1NiTmo5SlZQRUFpSklGcHVheU1yU2tMYWVtRkRpQTNq?=
 =?utf-8?B?bzVSRkRNMjc1RjNTc2FVNE03L1Z5c3U2REczZVlwbE9mSUtlM0VPakdiSm5l?=
 =?utf-8?B?RExoc281TExqMjI5NGswLzBoZFJkTkJkWXZKZnhaVC85eFUzT05VV29Ed3I1?=
 =?utf-8?B?NzdrdnF3VUh6UnVxcXBoaS9jRFFoU0FFdnEzdjJHRVFpUGdwNFIxd1hDS2Jv?=
 =?utf-8?B?L2oxNXlEYXB3R2RQY2duRm0yTFluMEJLMzgxdVV2bFpUWnBITlg5bFJISm5v?=
 =?utf-8?B?V3VWdS9WL3UrTWlCM2wrbXVaR05BTlZ4d1g5ZXlVc3k5amFvN05LdmkrNWpW?=
 =?utf-8?B?MXUreTNaUEh0UDZublVxam5kNU0rUVpDOGpaak0yYTNCUjNjaVgrbVNLOE1x?=
 =?utf-8?B?L0dxenVMTmlnS1JoQ0hZUkVscjcxVy9PNk9waG5qNHk2bGRXQ2ZSdUVoVFVt?=
 =?utf-8?B?bk5nWGlLRC9BWGNXUTJOWGtTaHFITGJyVkZRUXJTakNsSUtLc2dWR25NUXpj?=
 =?utf-8?B?cEVISG9ScFppTjUrM1Q1T0thNHJpcjdXNWRrOXZkNlhEUzVwdGtBSHJDOFdl?=
 =?utf-8?B?Mi94NHNiMzRWSUhPWUtSV0QvM2tFVWdUWHZwWnBtQW42RTkyMldZbWdEamxS?=
 =?utf-8?B?RDFjRUhFNEd2SlR2RTlUcGxJaWZUR1lSdVhXOHNJZ1B6OVZkS0VEQVdSZzVF?=
 =?utf-8?B?bysvVzQxNDJxWmczbHg4VFh0QzFzUnY3bVBmNHVVNUVyY1dnTCt6K1FtZDBu?=
 =?utf-8?B?OHltblp5LzZPQWt0ekcxdklYTXFpUWVVMDg5dkp5RFgwQ2l3N0FOYi9sT09Q?=
 =?utf-8?B?S1FIOWMyV21seFdJL0ljTVVMb1NQQmlWUis5bWkrYkU1eXRtdnF6TXlqNWlY?=
 =?utf-8?B?WDAyRU5ya2ZLMVRYUmVVMEh5cEdhdXFkRklqejV1QlhhbjFCRUYvZ0dhSEh0?=
 =?utf-8?B?dkhnVVI2OFYrcURuWlB0NlRPT2RTdC9WWTh1UnRPbWdDZnk5MW1GUUZ6a3Vo?=
 =?utf-8?B?SEUvS0JFTTlrSDFQL0J2QWFRd0hCRU1GWlJWcHJjMnJHZkQ2djhhTmVMdFhF?=
 =?utf-8?B?aW5sdVI0U1I2Z1U0Kzc2SUFObW54aEVsK0FjZ2FGU2hNaXI1SXNvYzVhMVVl?=
 =?utf-8?B?d1plYzRVU1FILzU4ZTBNSER0eFlIbFN0akxzR2hpeWVkWG0rczkwbWlqeVhZ?=
 =?utf-8?B?S24yUkdEbk12V1Z1ZzRHZEJkci9OVHNZKzlRRDBKZ21FaVlzenlPaTBMRjBQ?=
 =?utf-8?B?YWZLYThtam5WckthRXRMb2NCT0liTzhnYW13QjRFZDZhRERpNlhDczZVM0dM?=
 =?utf-8?B?QW5MZW1mWFVSOVdCSlBrWlh2VVRETWhWSDBET3VCeklkZmxmNnR6RldKNkdW?=
 =?utf-8?B?c0hkcFNWSjZKcVVKYzMzcHhISk5ndi96VWI1N3ZOREpyQ3VIRzQxMWIrQ2NI?=
 =?utf-8?B?WWdPazQ2WXJld0x2OTh4My9Da2lLRWFTRVNDMElBc3hhNlYyTVBQT0JxWm5I?=
 =?utf-8?B?eGpROGNpYVNlSnNjaXNjYU5CZENLZHVndEpuKzVQWFdmU3k4MytPbEtSOUQ1?=
 =?utf-8?B?MkdVdnI3OXFjS0RNUVNYT0FxY3JSTzZaaENRUXIwN0x2WVZ5Skw3Uis0UWZq?=
 =?utf-8?Q?fdD7bW0OVbSKF4ZCD8y2EseFt4MnRaPTY/o/dh+SXujE+?=
X-MS-Exchange-AntiSpam-MessageData-1: kE3RkLtJjG6cow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c840477d-348c-4a61-2ca0-08dea051497b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:26:52.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwlcCKIOPSWwLBjrX6T9ybYO+4LwvNHCw4WZjx/1JOp5N+PGjqNhcdhUfpfbZNxJ+miBeNB4IdhkDNVLnA7gAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-10080-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: C6318443F3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 22/04/2026 07:41, Kartik Rajput wrote:
> Currently, the Tegra GPC DMA hardware requires the transfer length to
> be a multiple of the max burst size configured for the channel. When a
> client requests a transfer where the length is not evenly divisible by
> the configured max burst size, the DMA hangs with partial burst at
> the end.
> 
> Fix this by reducing the burst size to the largest power-of-2 value
> that evenly divides the transfer length. For example, a 40-byte
> transfer with a 16-byte max burst will now use an 8-byte burst
> (40 / 8 = 5 complete bursts) instead of causing a hang.
> 
> This issue was observed with the PL011 UART driver where TX DMA
> transfers of arbitrary lengths were stuck.
> 
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/dma/tegra186-gpc-dma.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 5948fbf32c21..0aa3a02b2277 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>   	 * len to calculate the optimum burst size
>   	 */
>   	burst_byte = burst_size ? burst_size * slave_bw : len;
> +
> +	/*
> +	 * Find the largest burst size that evenly divides the transfer length.
> +	 * The hardware requires the transfer length to be a multiple of the
> +	 * burst size - partial bursts are not supported.
> +	 */
> +	burst_byte = min(burst_byte, 1U << __ffs(len));
>   	burst_mmio_width = burst_byte / 4;
>   
>   	if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


