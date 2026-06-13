Return-Path: <dmaengine+bounces-11502-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TiTBEcBzLWr8gQQAu9opvQ
	(envelope-from <dmaengine+bounces-11502-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 17:14:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF17F67EE39
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 17:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="CL/vAmrZ";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11502-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11502-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B40283013B47
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E72336EF8;
	Sat, 13 Jun 2026 15:14:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64132BEC34;
	Sat, 13 Jun 2026 15:14:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363644; cv=fail; b=mR4EcL8kg8L9l+0zkxD/sWAkYpKbTzJtE9yqMzNxolzBLONiWmBqMuYa4ClFAufndyEhg8wDvxU82ydJ14SjGJahxYHz8EOayvcueYXXB6afEbBJqvOpXbJUWgLmZ/2H905Cw8i5j/OCsoErCTQCor/zTB4R5tLU78G7buVZPk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363644; c=relaxed/simple;
	bh=GhPqMuo7+eovf3t6yKHOUqKKckv0EmV7WI4u5W1l8Ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJ4I1RZm16PhGUeHeoLV6IX5Y8q9WC9k53eDtuMXqtC6QwxcSxodhE1kHIg6KS/Twg8VR0j7Zshez4WSJw6JHY9BPAp7GbBmsNoN63hU1inqKE7SS2aFycbA651efFgmG91NCM0VYx4/4V1weQqfO4pv/NNaUTRMIaSmLyEodMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CL/vAmrZ; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEsbPnj4CMp9LtX9+Lnc5s8fG600WiO/4NIfpWp7o4LgUPeM6aNUGsvi3CVLxqVvites4ykc+fnVQFmjuk1GIR5bM7Rg1tsgXMag9ZhdHItScIf51Rsv1vCNGsVtwuPt05RK41JWT7VkgzJZEBmCs0W+jj/qpJZdY4cEYqBzcRdOM+nn0CfbvWobVCSVt8R/CRUfd16ewuvqmMu2hEazgeOlUdlb9Onbjm8VGsd/3wFItVSivPyTNBf/Roq2sTIGJuFUIKjSU0+TN/NLUbyTcovCKuykRSWxF9b1/CbwMjiATaQiMlQ9bDfzrmA2/ciZyjNxYm/vW+34jKy+F4VS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJeXC01ZX0Kv+gxjFzn/K1eK83NitK/Fkiq1I+/HdHM=;
 b=xqK1SB5oYyXTE0jddLOshQi3yWe8zdu9mvt5r9BTFV+3XISEFBilqNzevBWYzDgWnewRzMl/O/zFdpg7rRJ5kaSSfy3244/TTjXkYZkDsy0htMYP+zA0dSZodShmEXvvpPhhiB/vZ7Q7xG9KqNJ/not6AxKd0OdyQyzExjiAdzAYOEaFyStRKJbWdivGsLayVZ91KZPnMoN9FFD1PrmmeHGDZ+NzmQgYO9Db08yIDQfvfFwDAuxj9oYr5gwzmhTVaTOmHi3Y3AeDDIBgHaCp6D5s+2IcV8OYXa9zGm3vwN8CT+5joholVuz4yFQY1ZSEqPbxfNVl4x97NpLvvTAtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJeXC01ZX0Kv+gxjFzn/K1eK83NitK/Fkiq1I+/HdHM=;
 b=CL/vAmrZ5rasZM9ozLPDCV0zxOLzMGWpGo8G/2h7XAKU0za7FE1VmofU/W9OvYDLx79Xuy6ympagqMjd0OytUDGMtfYjJIhZFO67H7pa20VbNWwJ9iib/w2JfxvR1PZFM+mmFcwGsb45ak+p1R9oKhBWJesVmiwSSrPUQvHSpnE=
Received: from CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 15:13:59 +0000
Received: from CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4]) by CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4%6]) with mapi id 15.21.0113.013; Sat, 13 Jun 2026
 15:13:59 +0000
Message-ID: <419770c4-a536-4702-99c0-76f641f43cdb@amd.com>
Date: Sat, 13 Jun 2026 20:43:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx: Treat "xlnx,flush-fsync" as a flag
To: "Rob Herring (Arm)" <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com, Suraj.Gupta2@amd.com
References: <20260612215233.1887921-1-robh@kernel.org>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260612215233.1887921-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9717:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c81bb0-2ffc-4289-5e68-08dec95e6497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|9063799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CzpF+Ydw4C1d5hROFfDq+AogfI0Z1k7vGwcQijqZG9nuNBTBqPwVsL7Qjxs1ZkGZx4v6ILrm5+isntcona71ayUSqK0c1d6AHCcfzlzxotlgTAVqTchyVJgm0wbfhp+0fLiq/Il/2HMcusUDnDcKLmMo6g65SYIjw7OceWttYwMsUWBk+Uv/zLmKKdNwyBO2QHz8Nu3vdiPJeXi90m/ozSfytzpPiuXqeCAadxq5EMSyh9NIyC83rzbZHt7j5IWBqClBUwEWEljiv6XuGpTVfMEqqs7Uw90iuDX5CuY60D2DrHzpp4QZPCijJHPsGPAn1TV4c+TNVDT3N/YRDK8RPpIkzwXn0SB7mCDzYctY5WRKz3b+2LL8870HRW7EsKbFtRG3AdiygTl4l363EvVWAg8BmYrNYxOyxCAAJ2NSA0Cre/37XcE90srhN3Z6xFsaaXOpr2O1oP/sUVofhNE0GVuHw4B17saSz/yOAFOFd87zR/Q9cRU5SWtOOpWH1SRIyJ+9MLP1sjz4ndMSLBoNvKf/pP7aNu/zCgOeyPiumQnRcZewQp/UmQ34u5/kItiw3XDQvb5GORUYPLpikG2VE8/Dl9G0tBUUlyS+C1/2UGxKQ/LCMqtBka2W/KqUet8JkpIVMBbyEBEfb+3tvxt0gVXjvO/MC48jsBYBhQV5V+ougIqXuAuecFATiw/DfTWM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9717.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(9063799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0xETytoNy9WM3lpUS94WmJZQThmeTVFelc3L1RJRWlJbUlGWjNHdzArbUVX?=
 =?utf-8?B?SzBuT05BRk80THdiRnI5L3M3Zjdvd3BSdnB2Vi95WnBJcEQrV25saUF6VC9H?=
 =?utf-8?B?ZFdxdlhnVU9UbVBRVGtLZEJzWWczRENpZEw5dGNldndULzF2djhQT2phaVov?=
 =?utf-8?B?U3g3RmJjemxKckx4VHRPWUZWQzBWa2c4Qk12UG5qMWJMV242NW1IZFR2aUJ6?=
 =?utf-8?B?cjdDS0dXVlMxKzFQUmVFVzNPVENCaEhOT002eng1WFNpY2RERC9nanRKaFNa?=
 =?utf-8?B?eERTbEo1eGxncUhSc0s1OHRLRktHaHRtNmpzbzUwcW5QaVhtY211c1FPN2ly?=
 =?utf-8?B?TzRTWFA1SlozWElFQUl1aHNHcEMxMHFKY2ZyRWRyRDBPZE1MUkdjdnFvcUdX?=
 =?utf-8?B?SEdNKzNCak1kYWJDTjE5NnZEaFcwK0NHT2tHU205QVpzR2FKMlgwUC9QcGlY?=
 =?utf-8?B?YjAvV2ZmTCtVL0dLMnlvbWFXaDFkcHNWU2FWUjVQd09ZZzVLekZYbjlZOHVi?=
 =?utf-8?B?NElFYjQ4bDc1MkhBSnZ3WjNJSWJKbDVGY0pZcjkydTJjRnExZjlJUVFGS3FK?=
 =?utf-8?B?M0lpcnZxK0cyNGNJR0xKanhWdzMzQ1ZpTHJYUzNJenV1TmZjT2QydnFXcWZw?=
 =?utf-8?B?UVNZQlovN2FmMGZ1anZWOFZQcGduZkpDVHpFTng3MkRBeWV1YWhwWmlocVF0?=
 =?utf-8?B?aVFnNjMzM0xXMktkcW94WW5janNjQ05URTE2RUhzb3lGZDlCSDZ6ZGlVY2c3?=
 =?utf-8?B?aFhKdlJxMC96SnRuUlVjMEpjdm1IM2VndGw3NWdaZEFkcythSytFWkNHSWlC?=
 =?utf-8?B?cWdoaTJUQmRtL3IweWJNTGJHQnJzeHk4UmQ3a1o3RkxTby9PekhVQ3BCTS9Q?=
 =?utf-8?B?OVJzT2VtQTJieW5QVytUWUJNV3ZuUWY2eWY2VDcvZ2RIU2RCclhPZjZjQXJs?=
 =?utf-8?B?aXBabUxoMzA1WnR0MVVjN1lTcmVZZjhNRTdpRTNsRStZOURXNE43UGY5d1N1?=
 =?utf-8?B?V3plYTZFK0d3QXlyMVlNQkJ1VzYxM2hwbGticjkwODRtVUlyVlNBTHNNUmNC?=
 =?utf-8?B?RTQyNGcxU1lpd1J3QjlZNGUyOGNVclZyVlh4dEtKNzZQQTdURWMrRERuYUtX?=
 =?utf-8?B?QmJXR0lRcUhiTFlVM0lENWhPYVR2SXBHUGZtMk1BekV5MkhGcDRlb1p4NEtZ?=
 =?utf-8?B?TkE5ZVN0MUszbXRWZWo1ZnRKVDBaaWRKNDI0MGZya0k3TUV4eDZCY3lROWxj?=
 =?utf-8?B?M2RMNmh0U0FDU1MweXp3Sy95NllPZDU0Q0VmR0ZFSHRJQi9hRVVTck5hUDda?=
 =?utf-8?B?S29icGFzanlBQStzbitlb0g4ZVFPWUtkQ3lWelpBM0lVTHZ5ay9DaWI3bWVs?=
 =?utf-8?B?TVJ6encxMmlEeXpudGp5L3c3dFpURkpDUWl0ZE1kWlcvS1IwRUxnQ1NWMlJu?=
 =?utf-8?B?WDBWNXFLTVJKeVVIaFdvVWFuNnQ3WFlNeGsyZ09UNTd3dWprd2ZjRWlNMWV4?=
 =?utf-8?B?ZUlOTUtKZlhPNCtGTjRyditZL3dLcmZpMXhGOW01VE1adjkvOVN2SmhyWmRx?=
 =?utf-8?B?eUpuMHN5RGxVb2lnNklBNjRLVHZNeTV0bGxWN1htRDluUVFFenlqa1EvblVU?=
 =?utf-8?B?SWtPSzFlTEdQYkR6bXRpRnlyOFBYYk9YLzNkT1hadzBLeEUvRUluL1JMbnRu?=
 =?utf-8?B?bUpZcXlja0dTZEsvL3l6V1ZNVkdOTDFMM2dkOGtETStxK1RhM0VwbnJFLzZQ?=
 =?utf-8?B?azBhZEtXZDNtTGpCVU1vZ0xsbWdzSkZuWEN0S01oQ3ZOL3c2USs1UW54NGhz?=
 =?utf-8?B?MGp6TzlCY1VaNmUrV3VXZUxNL1o5VGpKZUtHSUJ1Wk1Bb25OVWtxdnVZaytl?=
 =?utf-8?B?aG1FbVNQc21pYWl3ZnpkM3BxWGNRcTR1SnNkejZZV3hrNWZHQkx1MUZSVXJ6?=
 =?utf-8?B?VXdnc1lxM09PUUdPUWpXOGxxaE1CRTBOdlVSenlpc3NzaFoybUNBcG9sSE1p?=
 =?utf-8?B?Q3dEOGRNNHVWNGd2UzdjWDhQRDAzZDdZSUduNzQvL2dUT3RuRGo4U09zYnI3?=
 =?utf-8?B?SWpYU0RKaUUxNkdsMmlxSjZvMGJ3Y0lnSXE1Yy83UDNwY1NtMXpUUTBVb2RS?=
 =?utf-8?B?ZEp5dE00NUQwT3B0RWJxaUNIQjZzclBEejZqUC9MUW9xTmV1bDV0LzlJVGsx?=
 =?utf-8?B?WkYveElrcnpnUlJzdmc1TTRNWGVybS9QU0RBZ2JpWE9UYkZiZUZQMGZnTnBp?=
 =?utf-8?B?QmhSRERwYXFxL3c2cS9Hay8xN1NGWWlWMDByclNRMnp1UlNGb1F1dkVWZ01Q?=
 =?utf-8?B?ZkRGeVAxakNiaFZycjZad1VJZ3k0NkRWZDZGZi92N3drV2FLT3BtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c81bb0-2ffc-4289-5e68-08dec95e6497
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 15:13:59.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kj/sAJdcSaIe+si7urkqAEivuQXosuVZwIF5KxGdI44GvTJXCBf3QQYbOhAYRJ34
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11502-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:harini.katakam@amd.com,m:Suraj.Gupta2@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF17F67EE39

> The Xilinx DMA binding documents "xlnx,flush-fsync" as a boolean flag.
> The driver read it as an integer cell and warned when it was absent,
> which does not match the documented property encoding.

The original .txt binding (before schema conversion) was not a boolean:
xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
It takes following values:
{1}, flush both channels
{2}, flush mm2s channel
{3}, flush s2mm channel

xilinx_dma_device struct stored it in u32 flush_on_fsync. However yaml
conversion silently changed this to bool which was incorrect. I think
we should change in YAML to make xlnx,flush-fsync as u32?

> 
> Use the boolean helper so the driver follows the binding. Leave
> "xlnx,irq-delay" as an 8-bit property read because the hardware field
> is 8 bits wide.
We can skip about irq-delay mention here.

Thanks,
Radhey>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 404235c17353..cbb23fd6e096 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3262,11 +3262,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>   			goto disable_clks;
>   		}
>   
> -		err = of_property_read_u32(node, "xlnx,flush-fsync",
> -					   &xdev->flush_on_fsync);
> -		if (err < 0)
> -			dev_warn(xdev->dev,
> -				 "missing xlnx,flush-fsync property\n");
> +		xdev->flush_on_fsync =
> +			of_property_read_bool(node, "xlnx,flush-fsync");
>   	}
>   
>   	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);


