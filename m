Return-Path: <dmaengine+bounces-9149-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AArHJDJnoWkJsgQAu9opvQ
	(envelope-from <dmaengine+bounces-9149-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:43:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD01B57C9
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10E4830082A8
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC9364929;
	Fri, 27 Feb 2026 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="jojYaKgn"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023117.outbound.protection.outlook.com [52.101.127.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17131FE45D;
	Fri, 27 Feb 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185390; cv=fail; b=F0u2t7OTYCrJp8yBvdUdzK7pFvCflI0jXpGILvMTyX17JR0p7+p8UTn0srTk++BLcBQGozWe/xfmCdTP2x+xwHUa/+w05ITBp/em/Hz3Fd8NGRqYOUBbwJJLXedoooEOSeeNdMcqK51RK3y2xz4VB51X9h01G2rCV1Ekj2o8hJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185390; c=relaxed/simple;
	bh=35YhYgv8F7EcJsPtvKhaYtl5ijDN4DNaGM0UM6ry+uo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBatCeDmgetjB4PQgt+WjF3DOxp42MiJ8D3SkdxenyBleBUGDuhqUX3kZQRMDMtXBhwwBTC+lmmIMkodAJmDuSB63sdK8LrzlRCmCz555C4wQNdzB3KMfSl0dI3UjWpRVGkh3MMDKPTz2VIupUBLDfS4e1ysN+ooHl6CycF0EV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=jojYaKgn; arc=fail smtp.client-ip=52.101.127.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxeDGUUNQR9yDdmaFTbQUGA0L638TqXmJp7JwHsrNijglY3I5VlKP7nficO9QQbxGUEBmchU/+rlwpiz17PB1Fdnw3rNYJa8TWxavlfy4AmwwKjCMFcoqMyiJ5KLtDWEG31HcTYoIVlDvPF/KejJEwFW8q0wVDP6zw1RJmxfQ/MibG/cO9CZVIjTPNaA7WdWqaBx6S4v0CbFEpgnEiIpm6UrA2OuARxWvG95kQT8cWLpyuGQVcNQe0i2PXOG0PGaOS2rxyJshOKWS9SpMRKTGj2AY7J36ZqKOsQG0qahWcTl5HFtHmMJywNzbIpOXDR199egb3P7tKwc0pqwR+LvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2IhjF1adrBOpitV3ujpp67wuen5qXICjqM+01VX/A0=;
 b=pbSTszNCQiKM67r7NyXnFJUaIJD80NQ36PGKutWslo1Wm6vOi5Oa8jgYLGQ6ySFHStSdOeu/YNOd84vzkrdmfizzlJFZNAY7Q8MQKdODMOc9dpD2x7k/uFj9EoB7ElNmZoj8Ew4jmRo2BTXpDRiFR+SjMW3wvDYH0UpEfXs1pERklUInb54+TUXpuiX/wgPDyfsKjJeKGJ/+/N8vuAK69V0DXyszFLbJSEBNjz971M1L3xqHVafiBHzmSEjQT1FXjwRp6PejPcQ9C3GWYBq5Qz9himHGdXu7eAfobhdtFsPFyhlINzW4RpYHQV9V4nM8sj+sIvgY7SzN8EWzsm1L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2IhjF1adrBOpitV3ujpp67wuen5qXICjqM+01VX/A0=;
 b=jojYaKgnGBbkRuZ+sqhnbf6Poyjtp4CsjnD7GIkBMcuIkR8rECKQPH0Qt2g98TqCW3Lx+078X16ToxWNGjl0q2y9amhmE1M9nRomydd48i4q1h93MlC7X3oq9jZz3fzkcrPoCjO0RKKfbQD4Isfg+tuKn8BfFrPvxX5VviM+3Bj5vRhOCuuurQ8/naIbHb1Yz2AtX2mK/Le+S6Zzi/8Ns48girbiAolgNoebCkvaQFnqr0l1a6AxlbmcFzGdlLDVvXmFAFF/fcCypi8w6Mg07nAMPMSsbI7bYnsEM2PSpZdLt3dLPPgWaR87O5kk6emUAqArtwogqQfqf+jLU5G2Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY0PR03MB6497.apcprd03.prod.outlook.com (2603:1096:400:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:43:05 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 09:43:04 +0000
Message-ID: <4fa16352-5f74-473c-a568-406e3ca24395@amlogic.com>
Date: Fri, 27 Feb 2026 17:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
 <20260227-amlogic-dma-v4-1-f25e4614e9b7@amlogic.com>
 <20260227-crafty-just-cheetah-7ef8a2@quoll>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260227-crafty-just-cheetah-7ef8a2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY0PR03MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: f31b1690-4753-4d66-ff11-08de75e49ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	ksSXoEJ0BLk1SqnOKTLS+hituEoGGGqyr1bMXSc7KWJtbhcJS+bJezsHfJ3jC6DaW0Q7U5JJQydlTdRIaj+11RSMQP7wATXUFsvDG4ugsXd77O5prHPRY0d0sFS7bQf2i8ybn0zeKTp48j26oojx9SH1PNdJILdDRokcwfIHNgHmqsnCppIIbRvUVEhhy8TnGyr4dRu/6VKvZaBZMYhR9aSn+J295vtEnoHVs+YPbl+osFjOrTlOAwkff/toAH89nE7iamVEzHG48E0kMBDHb0uqIEO8DYOeCVrCnd6DY6W/klbHKkm15SodwaFhOOxuATouEWw5rtmo5TSOQ06w4LAjRhpOKCNrDpIzCh+BhQ6JuvZUsTd6CpwlRJFGmI+zibWWmJWmT7iN9WoayEg+8cgliKn0dMY2UeLePVgCBcqokCmChSC+PgKuIe9/H7Kr1OKpuACFPmShkoDFQnmPZJND8LG+v21PrVTXL1pKrNlDs8qRl/4ZBDGQFjjQnFms7lo5ZZUaJQKjycXlMKjXrMf1cGQm//vSu5jE9XI4eSl75VOyhZxE6UOUnK5EmAnfjVnCnEsk2mViojo0axot5Lum9lab7rVI2bI/CXdAZhi/kp+2p6Niy3jF5fUYwwRQzkkFIHC6h17vRyaQpcHikq8lSJZRJAmiIyN99sLdUPDnR3BjVIoWcIwwfcSQTr4Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnA2ZGptTzgzbjc3ODJlVnFZNTdaMkprbFBVTytGbWs3R0Qxc2ZvSGZUM3JN?=
 =?utf-8?B?dkdrRjRaNXRBYkFWK0l6WTRoSzhobWNsenJERlU5ZGFyN2pMZFZYb3pZd3k0?=
 =?utf-8?B?RjFHeWNhdkk0b3dJNkhhaktiay9OQ1BTVkNQTWt2RlZObXJGUFFEcmNaWCtq?=
 =?utf-8?B?T3hiSk9tQVpibldLeTIwUWN5SnZWV2R1NUIxSXhRalFUYTByVExaRmhkVUNp?=
 =?utf-8?B?Qmc5MlN0bDFUeXVtaGRBU2pmeWNoSVZoSk41TnR3cS9mVnN6UDM2QU1CRmVV?=
 =?utf-8?B?emkzTDJ6VmRGUmpRcXg0VDkyNE1YWmx0c01NaWZONDNScnhHMVJsNWtIYmcw?=
 =?utf-8?B?RFdQNURBTHdHdmRaUHZZblozRjdjS25mam8wTTVjbjRONDNETTM2Mnh0bkxY?=
 =?utf-8?B?MlRHeDg0a2tiNVNwZ1VWZ1pKSk5MektTVUhTbmsreVd6cFMyeWVjcVJuUEFB?=
 =?utf-8?B?SnZOY0RuaWZOUk1PcEMzSEtNNjU3ZVhtaDBERWdLbDR0TVBpRXlpSWVXdVNw?=
 =?utf-8?B?UVovZGVySk8vbkxaNy9lcDZVRUZLS0J1N3c2T3pzN3doZHNJR2Z0WVBsaG5I?=
 =?utf-8?B?aklsYlExWmFSZkZpbGJyd1JIbWdOdVpRQUdscktCREFydXhRMW8wOHF3a0JY?=
 =?utf-8?B?cDZObFpvTjhSY3B4dTVYQ3ZqT0I3eFVjRnZYTDFQSW1LQkg0V2lmcDdSVWpl?=
 =?utf-8?B?Z095UHFYbERuaG02NFg3WXExT08ydkJySzFDZ0RrcWQvOTJGaGVsdkFGZ3Ux?=
 =?utf-8?B?dG5vV0lsLzhadjZjRDVydXh1UWFIcnlxZWJRbHRCR2k3Rk8zd0xkZTZMRjF6?=
 =?utf-8?B?S1lwNGlUb21QK1VyUGNhNk41L2ZiR1hYUlQzMTlhWk5SRW5STE9IWnM5VHpQ?=
 =?utf-8?B?UnpQVkNWTlMyMUN1Q2ZESTBUSm0vbHZJYzBTbVBOcGNSbkxUb3BRa1JwbjRG?=
 =?utf-8?B?RzlqanRTU2tJVWY1ZTUxbzJIZk9kNWtUdlhHSmdmSUhIdUhucXE2cW13ZFV2?=
 =?utf-8?B?YXRZc0d5N2M0anhBMTV3RUtzOVViVjFNN2NyaGIyVjYrVXFQRXJuditqTkFL?=
 =?utf-8?B?RDFWM21tQ2lDYlNveVpaZW94YktsYVZicUNWeEhhcTg2aURnZ2g3OG0xRDM0?=
 =?utf-8?B?MWRrcWdVM1lZOWI3a2dRc3V3VTJWLzJYOEQyRER6SjdZUk5lV2FJVG9BMlRI?=
 =?utf-8?B?OW9YZlZHR016V2VGNzVDYWprajZ1VW5peTRiclFvelFkMDNXd1NKQVVtMzdm?=
 =?utf-8?B?dytzRFdYVmNnVnc5TG5ZeWVTZDdZcjYybXNodkRZejZjTE1wY280QnFlVVN1?=
 =?utf-8?B?d2ZDRDNOOU1uazQvUzdxOFpFeW5mSzNITmJ3Y1lJK2hQTkVvRVovb1FoQWlG?=
 =?utf-8?B?QXU1N3FjdEgwY1JjZ0kxd3BsdE9qRThuNkhuMmlnVVRLOERWTVpCcU9lc3dh?=
 =?utf-8?B?d3Q2dnBON2lQNmxnMmZCK085TjBqZGptNW9RZW5iN2h5OERsMzQ0QTZUWTd6?=
 =?utf-8?B?MWprZjBXQ3cvbEtMbmVrK25LeVYvb1FXeWhDVlU0TVpVWXM3UGNVWXV0cElM?=
 =?utf-8?B?L2t3TEhKREU4OUtiOEx4emZTU2lNTzh1TVhFNUpBNEVVaXpGaTR4RUpJTmgv?=
 =?utf-8?B?OVZoVVVmNDVKNTRaU2k2V3ZLSE5qSFEvMEhmSWo1cWdtNGdXWllvK1daQnRo?=
 =?utf-8?B?TWY5d29TZTltMDIvbGQxWXlXK29yR0dMNW9xcEphYmhmcUxlSjhPaGNZRjJB?=
 =?utf-8?B?VnVISG5xOWI4c3lkb0Q2QVNNK3o5NkpuQXhiRDRqRDAyS0dOY2x3YlpzVXJn?=
 =?utf-8?B?MmxGWE5uKys0MnJmV3pLMlBaa0VUQmplZ0dFU0cwRUwrckM1ZmlKd0krK3BL?=
 =?utf-8?B?cFhJdXl4ejJvaloyTm8rRnN6dFBaelFuNDJ4Nmx4MDdvRGkvd0xkcGdXUmdI?=
 =?utf-8?B?aERDZlBrM3RaakVrM1dzZmt4Y1lrdnF2UTZ2QVdmanVjRm5ObEpvakc2dzlx?=
 =?utf-8?B?U1RhK0lSTHhuakM2dE9zQTRvVGVRbTFmSUlSYnlGZ3BITEZIdDFBMDdxV0Rw?=
 =?utf-8?B?ZGRxa053aGNheEpuL3hQNlI3Y3llVDFaUmtBelVtb2dsYk9iL0tsQy92KzFj?=
 =?utf-8?B?K1pUcjBPSUlQbHY1VzlCWFBMWDFRUFVvb24vS29ISk8yeGhpMWEzNnFoTm9V?=
 =?utf-8?B?SlVkYzFtZC9GeWZHNjh5WTJQQ09rR1pzNDNBRmxFcHROeDBJT3R2V3JoTWxB?=
 =?utf-8?B?RlV0eWpDZVBnL3lGOXROSnlPbFZUeUZ1OHY2cy8wdE5UVzNMcHp6MEp5ZDhr?=
 =?utf-8?B?UFhXRWpOM1hFQ0xhQkNiRzg2bEJ2cGRpRGJmYm9tYURJSVowSmJxUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31b1690-4753-4d66-ff11-08de75e49ae5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:43:04.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S36PZJx01Uqqdy88KPcPQQxjAx/ojnTrp8Ked05qo1Q4K0dONpAM9RO2Zbslsbk1j0h60lCqE+SgPkJYxWoi6omG4SuvUH1BIguwSUShT6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6497
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9149-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlogic.com:mid,amlogic.com:dkim,amlogic.com:email,fe400000:email]
X-Rspamd-Queue-Id: 17BD01B57C9
X-Rspamd-Action: no action

Hi Krzysztof,
    Thanks for your reply.

On 2026/2/27 17:18, Krzysztof Kozlowski wrote:
> On Fri, Feb 27, 2026 at 07:20:53AM +0000, Xianwei Zhao wrote:
>> Add documentation describing the Amlogic A9 SoC DMA. And add
>> the properties specific values defines into a new include file.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++++++++
>>   include/dt-bindings/dma/amlogic-dma.h              |  8 +++
>>   2 files changed, 73 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> new file mode 100644
>> index 000000000000..efd7b2602c33
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic general DMA controller
>> +
>> +description:
>> +  This is a general-purpose peripheral DMA controller. It currently supports
>> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
>> +  for the same peripheral use two separate channels, controlled by different
>> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
>> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
>> +  there is no significant difference.
>> +
>> +maintainers:
>> +  - Xianwei Zhao<xianwei.zhao@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a9-dma
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: sys
>> +
>> +  '#dma-cells':
>> +    const: 2
>> +
>> +  dma-channels:
>> +    maximum: 64
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - '#dma-cells'
>> +  - dma-channels
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    dma-controller@fe400000{
>> +        compatible = "amlogic,a9-dma";
>> +        reg = <0xfe400000 0x4000>;
>> +        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clkc 45>;
>> +        #dma-cells = <2>;
>> +        dma-channels = <28>;
>> +    };
>> diff --git a/include/dt-bindings/dma/amlogic-dma.h b/include/dt-bindings/dma/amlogic-dma.h
> Filename must be the same as binding file.
>

Will do.

>> new file mode 100644
>> index 000000000000..025ecc42e395
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/amlogic-dma.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +
>> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>> +
>> +#define AML_DMA_TYPE_TX              0
>> +#define AML_DMA_TYPE_RX              1
> You sure you need AML prefix? Your clock constants do not have AML
> prefixes. What other constants do you expect here?
> 

I will delete AML prefix in next version.

> Best regards,
> Krzysztof

