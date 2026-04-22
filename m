Return-Path: <dmaengine+bounces-10081-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIqpM+ya6GlNNQIAu9opvQ
	(envelope-from <dmaengine+bounces-10081-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 11:54:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCB4444F0
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82C6C3003D2B
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864563CAE60;
	Wed, 22 Apr 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkHlL+6G"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29332A3FD;
	Wed, 22 Apr 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851689; cv=fail; b=qU9ooQd4IeA8nGeRngJXTz/OyB+M3K1UCqAie9Sef6IEXbmpwI6hgKogfo6egqOww3rxn824WtHkijpXG28Zo3lB8ydowpk28o+b/3Qdfs4r90D2ZWYh0Qc+5i2xP+um94dxfEmnkiorrMh+Fk715TVNPgSL9sSudxqEAaJ7FR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851689; c=relaxed/simple;
	bh=YIV1nyGrEs1zhOb7tpII+KdRtIrEFv3IbyGsgaJxRu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aOmDt3kydNdtCYMy4Ys+osTt4fKr1Al4FgYupDaLqLBaBOiyZprBnH8zvapcOccYV7VFMd/hfCaF3Lwvjp0kIXd+Df1trz6fRKs9H+ARbX1n53cPS+SuiZ5FvWsuw/Yzx3zBrlG0tvMhelbcpA31xGVVnPbRfrWi7v5nqZNW0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkHlL+6G; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9MihpbJMgIai7AtXwG2WqBp+aUaJNhOLqPByHukvvNWIRtNeagt3F03fChg/CdKtqSmodnZHh6tw4mf9v/NefqYa/S+LTtSqQz8cpht7k6gRqM1ZgBDCX/9JdXgNz2AnctwDTOiBijVOtwsMlbU+QjYD4WG6YPsA9OWAxr7NBrJvhCogoAKnpOy5HnWdb1qizzU6J7y6Jc3Bc7LarNlt61ULS3+1oIN1nWn/hdPP9Z/8lcFp71fsFzjMUwLyiIH/fcY0iehZKMHHnHSaroMv8z4yJzaG1pOY+1t27msAuqgOdm2yvZul2IC/rrnBvEIPf6Rb5GOgQIw2cCNKE6Zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcC5TJkOb32B/zAifzmv3upvGK3f6pYPGCYUsfVrNoc=;
 b=dlkfzM4QB59uF0ifqYfqQHrdfMGSlKRNJg8J0w7I+kJd6PvJ4/+uW5I0gVVejVGaW53updCCwgonDAwuni4mnkRLnsDIBZYjdIy0PgIbleYs8VsoR5d6YJdN3P6Uw2McPhZtbBcZJw+OJacD3MSULywvsmwXdgTEbBd0jccTNVlT2FLyfiofdHedC9bcsWAUrD3LwAQ+P4+DCKhkOzXADdf7dL3elRuE53p9LVgg/VYpLXzRZAIT9di8h4TKipCfwkKr+4DZKSmm4ZbLFrhQXnkp4lYIe6qYeU9uzUx5jukK+0CJUA5xAAP6URrgq6qUr8/T1hyt6ym7tqzrZyHzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcC5TJkOb32B/zAifzmv3upvGK3f6pYPGCYUsfVrNoc=;
 b=XkHlL+6GVf/KCdptep8BJ3eExMg58qN4qk3mQgQpGYEDNR6IK0g2lGy6PgrMFEifG8svGVWapLapiMQ5woQu1kga6Od/GxT/6fEtgB+Qb1fk4ypYZg9aFrf7tKyB3uGkxKijj2XTWUD5S7PKHVuEjflSd1TKiysXgDxNsgRv1/j/32Q6Iol03HNdz/qIEZTG4VVwnBf4u6CYqxbhYPFvdv6/UVIAgQYXtMtCm6IoAHGDSl0MD71WdtNOlmMNHdMfFSaFCQ7N6t9PP81d8VM4Ye0SILfwa9V+4JRofPVphq+ZRGOyS+21GVkV4lirSBUrBcXfDz7LfjcVse5KXHrVUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7843.eurprd04.prod.outlook.com (2603:10a6:20b:235::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:54:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:54:44 +0000
Date: Wed, 22 Apr 2026 05:54:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dma: arm-dma350: enable ANYCH interrupt for
 shared IRQ wiring
Message-ID: <aeia3uoz4g8tlBaV@lizhi-Precision-Tower-5810>
References: <20260325112159.663881-1-jun.guo@cixtech.com>
 <20260325112159.663881-2-jun.guo@cixtech.com>
 <932db8ad-a9d8-47ff-bf3c-62a54c42bb76@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932db8ad-a9d8-47ff-bf3c-62a54c42bb76@cixtech.com>
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e2c7b0-309c-4163-0200-08dea0552e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	pSVbxbU3JmPjHdR3RxnSAiOB2KnU7bffWd2DelwNSMZZXHPaRTBgcEuMTKHmoAcXBUkvMfLuv+j/Tt2llrcmjSFZ7x9N9S5215e9FOT8BDIi4g+AhYfV2YfE7KKlfe2ViJIPyltidwL60ec31ZtNE0kJ6J22zURcYoCKkAQeMhmI0LYnBR7VoTZzgjc4TZKWDn9jD14hiSGEc8IU528dGqb1fiVApQu7RoyYLSnXpLKUt0rKyvBykPpUFOfEcDL8XJoplfZgPzLYcVW1TGju0KwzutNEjoynJrDr9f4817bsbu6RzmtvTpLaKddOaseXA10R1b1lDpSsB5WB+tDhVfBHMjd1N+2/5xFJAco9inGi4EsTrRXIELmsAozF3TLpThEjwfbP12GikSWSNCjitrip/zQpk7ko/k1+e0x+D3qOKruSjkvjJWyrW60YPC1IE/EVwHGcOeBCMu0o/PBRfsn1abSY7cAdrhQDbdHHrzd1gAjl67LgzRvaDnqiwUdlVJvCJP5iFrWbGPv6mvcWGME5OFcuqlKPrkPqskBNIs0qGwMAvwXsWTyHefJW4J2pBXVwrXXxtEPxXc7YBNSEG6ykvFZUp7YmxE4/bsd2L+gLsKy8NK2SxWTHcVOLBYff3xLnElyz5Jq/aWT5UoDTbdaUHyJXTv3Z/Et4fRsOsKhrNLrY5HjEL+D6T0T2aqVymd4F1TNhqA3wPsvOo0WeOvey+nS2miJawhcw5YjoD8vyof4/LZsejdyGOQx73hX4hfQRrh9HnXXFgF/dfKN9PfoqBpP7uaE2scdOxZFB4vE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk0rWXMwQ29KTUc3Nkt3N0k4dHVXMXdCY25CcUhNbFJpRTNyY3F5ZUtkQlB6?=
 =?utf-8?B?a2hmZmd5cUxwL2xhQVJzczRkd1h3bTdLN1VFY04rUXRYM1R1emMyRExJaFV4?=
 =?utf-8?B?ZUZ6eEMxRys0cGJ2TU1pNVFTMjJrdzFzK1JKbWhHdVBNL0RXNVZDWHRTZ2Zt?=
 =?utf-8?B?K1p1YjNqVGxobWppeXhJVnBlbXM0ekJJM2pEU3FXYTRLQURZaWZJVHFsTnNW?=
 =?utf-8?B?RkNzcDNpYWVrRnh1L2lNWkJXYVdFTS9RZWRrWFdURzFPVExvY0tHZXFKaVNm?=
 =?utf-8?B?MFIyOU1ubHhBL3llUkc2WFY3MldGSmVXVjIxcHRtN0VJSzQxNUdOVVRxc3hz?=
 =?utf-8?B?eWF6WmhmaldjbjlDd2VxUVN5UTFncnJmSXNIczJuQnoyTGlMUTdUOUd3Zjc2?=
 =?utf-8?B?ckJnZXJRZ2RzeHFQcXowNnVpTEhSQWt3MVpFTk9mWURPVnJYRDJFa2Y1cURj?=
 =?utf-8?B?aGtQVWI5U0l2WXF6VjZQZTZaaGtFZkVxK01rZXNLSCtEQ3dWaWMwU09mK2dX?=
 =?utf-8?B?N0R3andkemluT1FsQ1JaY2UyaGxuVXQ4NFdLMXhtL2kybDU2eXVrNDdQVkw3?=
 =?utf-8?B?NWVlR1JWUXF3L3hrTUlLTytxNXNORlBQWGVzbEFFVVB1M0taVm56SEtweHQv?=
 =?utf-8?B?SDFFOHBZS1JMQzl4Y0piYUhDU0F1SktmbUFGL0dEVGF2WXQ3VkF3ZFJhZDF1?=
 =?utf-8?B?ZHZCSEIzOVVVNkp5UnFzTDFkYllDQUs1SkNFWnZGNFgvRzFSVmlLWWNrVjc3?=
 =?utf-8?B?MU91anY4WW5OUE5MNkFCRE9FWk5qWTl5ZFJUUGRmbFlLS2pxMFpDd0NvQmha?=
 =?utf-8?B?Z2RlNmJPK3UySUxuVW8rMURzdTZZWUdzN0hPY1JVcERBbTJEMHRCbktjMVZl?=
 =?utf-8?B?Q240OXdtT3VuNWtVTGNhdmM4UUlsQ2JVbFZqd0lJejZxZFNKZ2oyalRvZlB4?=
 =?utf-8?B?blZKSEtwR3NxbjJUWU45YUtWbXI1SkJVb2wrVkpSZDkyY0NadUhDMkp6QTBX?=
 =?utf-8?B?R3FmUTVDU1BSaDVwWGUxQ3NqMWNqWjRoTlZ3cWFNRXpodkpjMGVSYUczZVQ3?=
 =?utf-8?B?cGI3T0R3TXNFQTVLZ2luazl0SExDeWs3YVNWNEFHdVAzakNSeVBWcDVrTk1N?=
 =?utf-8?B?Q1hFdFNLSnVaQjQ2MDZ0MGpLUmQyc2ZPZHJEclViSDJEdnE1ZjdGd3FGM0xM?=
 =?utf-8?B?WjE0OEY2ZW9Wa09HYmxTa00xUEF3UDhLY1F1ZzhObUJzMzNOZkZ2UUpNWmNT?=
 =?utf-8?B?NzFNcW90TEhINVFWcW9WSU1zUlJOS2h2dEJPYTdjWXFqd1NjZ3VnSVhwSVNT?=
 =?utf-8?B?amtJU3B0RVVad2dGTHhnM3RoN2NoaWFEMXZ5UVBRT1E3VkE5eXQrKzJyLzI1?=
 =?utf-8?B?bXN3cXFMYVNraHMxWmhNNld5blJoejNhNlFra3JDSEhiRWFSV3BLQzV6bWhF?=
 =?utf-8?B?RCtNenBIaFlpd3lXblJhd3Y4ZTJBTFU1UmlzUjloWDF2MlpMWjI5bTdZTnpo?=
 =?utf-8?B?cW96V3AyQXo4M3Bnc3kxL3I0NEZzY0Q2blBNbkRGaElqS3JVWkhvZHdBZFVG?=
 =?utf-8?B?SHVzbEZkR2VNaENzMWUrbm80S0NCR1BqalhCRWFDWktqZVk4bHZkYi96VWR3?=
 =?utf-8?B?cnNSWGczaDlhTzlBSUQrTmhjSmlqVE9lMHc3RHRiUWV1eWhDYVdZWVdramxm?=
 =?utf-8?B?Y0hSRWVCRlNUc3VreFZadllDbnVCcXBjWVZoYU5xR0VXUUY1d0Y5dWRWaVl2?=
 =?utf-8?B?dlpyMmxFSG9oTk1SVzlxTGtVQzhKYVljaWtIL0JnOEtmdm1OaFpjaG0vSWJI?=
 =?utf-8?B?b0Vrb2cwSVdZS2pIcnRzZksrWkdqaTRlMTNjc1JQSWt0U1VxMjFuL0E4RHhC?=
 =?utf-8?B?T0FWWkZBT1hiWFJtTXlacDdTQjY4czI2a3lVWEIxUTNLZzdwUFg2QzhaN2dQ?=
 =?utf-8?B?TGRhajc1TnhiaVJ6QWxxYmxKNkxjaHpvT01RME1WTnplKzlhWnd1YXBac2tF?=
 =?utf-8?B?ajNnSm5Vcyt0dWNPQjdQMWdPdmk1M2FNRXNCcHI0Qm01Rkh0ckxoR0hRRFBu?=
 =?utf-8?B?RTVlMGhhTXFhK0xzbHllOGJqU1dURjQxWmNxd1F1V1pQSHo0b25BVmdJQ3JW?=
 =?utf-8?B?YjIyM29RMUN4bXpkTmpMaDdnNFZvQVdQck9kN1lnSFFBYUpvQlVKb2J6eE5X?=
 =?utf-8?B?WGNzNzZPM1Y5YjZkMzVESlNFRGI4VEdEQmxiWlNEMlNwOVNtRUxjQUFOdlUw?=
 =?utf-8?B?QkEzeWExOXRoQ1VvOU4zdGJ1VlNQTzkzMXVqK3JmdU5NUE9MekFmTXZoNjBF?=
 =?utf-8?Q?uxfig8j6NXT3GWNrl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e2c7b0-309c-4163-0200-08dea0552e90
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:54:44.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw2Qr0V3/HA5MiaAu/E9mi6uYzs/pSptAj476RJ+bNs3FkE4W9FS7UkDrJpikbdXZkwoF0AIMnLdmkEYTPRrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7843
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10081-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cixtech.com:email]
X-Rspamd-Queue-Id: 7ACCB4444F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 03:24:11PM +0800, Jun Guo wrote:
> Hi Robin,
>
> Just pinging. I’d like to ask if you have any comments on the latest patch?
>
> On 3/25/2026 7:21 PM, Jun Guo wrote:
> > Enable DMANSECCTRL.INTREN_ANYCHINTR during probe so channel
> > interrupts are propagated when integrators wire DMA-350 channels
> > onto a shared IRQ line.

Your tag is wrong

dmaegine: arm-dma350: enable ANYCH ...

> >
> > Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> > ---
> >   drivers/dma/arm-dma350.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> > index 84220fa83029..09403aca8bb0 100644
> > --- a/drivers/dma/arm-dma350.c
> > +++ b/drivers/dma/arm-dma350.c
> > @@ -13,6 +13,11 @@
> >   #include "dmaengine.h"
> >   #include "virt-dma.h"

extra empty line between header file and macro


> > +#define DMANSECCTRL		0x200
> > +
> > +#define NSEC_CTRL		0x0c

why need two layer regiser define, your use DMANSECCTRL + NSEC_CTRL，

why not use one macro for 0x20c

Frank

> > +#define INTREN_ANYCHINTR_EN	BIT(0)
> > +
> >   #define DMAINFO			0x0f00
> >   #define DMA_BUILDCFG0		0xb0
> > @@ -582,6 +587,10 @@ static int d350_probe(struct platform_device *pdev)
> >   	dmac->dma.device_issue_pending = d350_issue_pending;
> >   	INIT_LIST_HEAD(&dmac->dma.channels);
> > +	reg = readl_relaxed(base + DMANSECCTRL + NSEC_CTRL);
> > +	writel_relaxed(reg | INTREN_ANYCHINTR_EN,
> > +		       base + DMANSECCTRL + NSEC_CTRL);
> > +
> >   	/* Would be nice to have per-channel caps for this... */
> >   	memset = true;
> >   	for (int i = 0; i < nchan; i++) {
>

