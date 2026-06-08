Return-Path: <dmaengine+bounces-11302-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uoPSL2CmJmo9agIAu9opvQ
	(envelope-from <dmaengine+bounces-11302-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 13:24:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E655A6E
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 13:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=mmVM0e7X;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11302-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11302-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6C6303C432
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9F35B12B;
	Mon,  8 Jun 2026 11:18:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34980363C6F;
	Mon,  8 Jun 2026 11:18:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917503; cv=fail; b=iya9fW1eJCwbQ52oQrHOxLPAfGWdOFEWMveVmUsNbeuAXEpmOFidNlgP0NavwcbzpBuchZYPGH35FFmsEvmtQ2wODMJ4QCZpxz5l0ry2yP4pNOVHT2KkYMGth+sUMAczur4/6Bam1npV4d43ZBcSW38Ruh1iY/m50AJLj43QDYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917503; c=relaxed/simple;
	bh=jq/2otyhl9RUHgDISBgtSPYwO3x6OH9oB+OBG1gsoGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0vTIjpFwsSUSfPw4CkTchOWVkjM/yLtCtsBSEdUvVPEhUeMyolYjMvpGcIK/H1Z21lDUSZ71nRvzAi34Dn4t2G9HOtQG5SANEgQN5lhSpCYJ0I82b16OBIdpOWcKtq/UsLJgERUXTQp0Tr7Rnv3zMJl77/hofasdoSXorGAsEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mmVM0e7X; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+B9rdwcPEy48kHdtNBNmWJ3Jow0pjUjEhKHFBZoGixKR5PsCX56R8Elyip9raCpXq97Jnzx4yqwYaye8fd0e8RN9eP9twLGvvW3Od73CxPV+r2oKpwoNz1mYmJOdLRNQqNzN7EBwWmio4J0+FsXUmxBOeaILaBAqIjxkCC6JKHdD0Gw+8ssrr4PUgbnj4ahHwtbpReE4w5P01046IgDgR02VgmB3QapGoimnlFksq4kGxiWjcPFDYyIyHS2iyglyRtpV2P/HFTLks80gPalXsu7THH3MavnzHnPWzweqhhgzVGCn/zdCNpiPR/z1UuV7tnjJjVRWHuqQkRRXSlFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRZ+QMocnIxVEULV19vrEZuAmZkfChsYfM9ZQfr2k/g=;
 b=dL7nRronMGck3daevF6gYYIN3Bl+GdVP07kbpW7dDxB+mJgwDHECT9PeltTvKWu8x6w/7hREs7pNLS+1rcd9Phh9h8UuTy5R1n2MA9MWDffq7uCJNnH3n03Jqpde8jsWy3iC9tg9l7XNBNcNA2qUzBdkD+0WUUOCxtxyP0riO+dUv20Jt6azh/sl9qebd92AiwHThO22+nfWDFLeelQRn2DWn/OQBNoBw1R8fxKfGT2cEhhgyuCM+ZOfLc78s0ugLnaE4k0fzogOllI9GM6wxrrnGEIPngjumvLhfXh9s9rZy+iWSi0AHs3ZDt05i31+ixLCYkZwMX3Ud8gxz6898A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRZ+QMocnIxVEULV19vrEZuAmZkfChsYfM9ZQfr2k/g=;
 b=mmVM0e7X/RGhivYt194gEKVN9MBCWgom6dJ7de+UESh+ZRCzlzY26gm9mT3EIMThZJWYOwdGZ5T8pMqawJp0FZxi7jfIx2syrXHYZ95AKBNnSZJqCyv1DxB3lDHxSVa8epm3dZQti5ujUABY8KQxXD/LDly6MREC6qx289uH4cc=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 11:18:12 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:18:12 +0000
Message-ID: <a28adc76-044b-4666-bda0-d7f9a8d52a63@amd.com>
Date: Mon, 8 Jun 2026 16:48:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Frank Li <Frank.li@nxp.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "mani@kernel.org" <mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
 <aiHY5V937ygrQ7Zt@lizhi-Precision-Tower-5810>
 <BL4PR12MB94822DC255780FF60297532595112@BL4PR12MB9482.namprd12.prod.outlook.com>
 <aiMSTaRe1sBhojaw@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <aiMSTaRe1sBhojaw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0230.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 8083ec66-7de8-4721-7f8a-08dec54fa07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	I8wu1PgAXOl4BpjkjTwqx4Mf/DIKLWQiPb/F2WPoE0KxXhjTfpOh369F1Evk1kVBaBzIs8y/lmK3avmlKHxNYFaya/iPvxnnxBBirSDwri9YddO94wkMhCQlTGI8Paj1hqgOAwhlSsuWDES9ID74mBmbK8kHAtmxosTd77VinL8tQhplQoBNy4/xqcxfy3p7vSCQ6qT0hFIrOGMN6wA1L3yven0CJGN8Q8yCSX79FTgwUrSC3OWXPaXSDdSp4he+cbxDhfDV2lxwgCe1Hcad8z5/EPTEJ/JS+wckY39G+AZwYv4dDZ32d+mbyFMZe2dwlcTemSkgyO/oefPK/gZnN8KaaITB/ehNJLDoaJ4mFVnsP9UKaTH44l7TSKScm/lTA3nh8+3JKGP8h80MxN2QmZZ2D47DTpr61SzFzcWDZi6bR9Z2bg+u7rFbLQSCjqvOl+YVtzSx36tisqlYQqKTQ3Ce0V9tFMu8usZ5NLauQgCVw9vW243D/nmMvkJZXDzgzQNI+hNmpD+AJ1ieJZHWi9/IHaRPDyuM0GDOuexUR7tFo8D5fE0kHyM/VWfCFkhKLnEMdKsF4Fu6XHr3OQ7cMh591Y75HwstgQz7hDBlqnmUhHCg34VvQ+C0WozYVbijHFLtXPnWKr4Ry8sVEGdVZGmmwR15mTysm9Vx5fWm7MOKUtwTBxfQ/LQARdG2a+ws
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUttQWhUSDQ0U05BdjFCLzgydHFHOWI2YU5aYmc5L01UdkJDcjNVTkZmaGZO?=
 =?utf-8?B?RDZ2RVNqM2RDZWhCTEdqSi9WR1BYbVNSR3dLL0Ztc1B0a2orS2lZNFd4YUV0?=
 =?utf-8?B?d09PN2FDQWNIMy96aVMwbGxoZXVrWTg0djNJcEpaZkd3ZzV3V05oenB4T3M3?=
 =?utf-8?B?bFpWejBML1dlTGZycDhHWXRUZkdPa21oY3RwUkRiQ0ZJcmN6aWdYTEd4RDNQ?=
 =?utf-8?B?MHZFMTlNNHQxYytpeUdkeVREbVljM3FNM0dFSEdpcXEwSHdxVWpoWE0vYXg0?=
 =?utf-8?B?RTk3V1RiRWxsZGVSdVRBQVM4SFhNZDliaW9sNk5hbDZycFYwSVhvN05DUDQr?=
 =?utf-8?B?VTNIUXBBdkpxd1BWVnorb0twR2djZlU5dEhJSkRnQk0vaWdIRHRWY1ZOMFV4?=
 =?utf-8?B?bWFKTDhwekY3NWRDOXVmNlc0WW5lMzhtdUYxY2xQMndadGJzYTArUEhNaGNw?=
 =?utf-8?B?dTJEMWRDeGhCdzRtUGtIbW53SGRKazIvdDZvRmVKSEg4N29LdjBnVmhGZVlK?=
 =?utf-8?B?R2JqMW9HQmVLTHduUEFzNXdWdmxSQXJvODVJaG1iWXpTK3l1YXZkZ2F0VVV2?=
 =?utf-8?B?RGVoWXl4RE1lU051YkVRK2NrdzdxSzhiMWR5MUZPNEptTk9XdGZhMFQ2ZGRn?=
 =?utf-8?B?NXBJQS9GY1pJTEc4Qk9Qb3VMeVNjUzQrYk54ampXYmpDMjlaZ3V4Rk1xU3VD?=
 =?utf-8?B?M0JlcEUzTzVyTXViVDh3azBNMWtsN2VUTk9SYk1VRHVjeUlMVmNZd3o4eGJ0?=
 =?utf-8?B?QkZwN2pSOVh1Ym1iZWFtcTI0YUZSQnVtWC93WXBxL0dBbVBTTGZqWlZZUWw2?=
 =?utf-8?B?aW5yem0rWkdtdkZJVW4wWUpiN3VjNXBKZ3NCTWFCNEx2Slk3TVBHbVpJZ2xX?=
 =?utf-8?B?Y2FIWnlycVp3NWtXVkU4cjFmUE9BMjQzd3pYQlkyNEZsVHUyTFhJUVJ2VVJy?=
 =?utf-8?B?b2YySnJCbk5ZQ2hKMEJzQ1RpTXRIMWtkSnJvcDYvQ0kzd2NQbEJxWG9UVjkz?=
 =?utf-8?B?YlZHdmcyVWYydkxZRmdWZnZTSXhXS05DMkR0NCtSVDgvdmVjL0FwTSszb2tF?=
 =?utf-8?B?cjJ1emx4M0sxaHJBLzk5YjFSczYyaEhUV2E0ZHUxVWJIYWMxVFlZRUF3dGpy?=
 =?utf-8?B?Mms1Z1I3eVUrSUIreW9tYlYyaHREcUVTR2lCbDRhU2NZM2pienZzRXN3SDI5?=
 =?utf-8?B?b1dtRE9BRmV1UHQzajNwcmg2aGw4RXpCZXhkOUZMK21WZGdBMzlHc0Ywd0Jz?=
 =?utf-8?B?THdPV1UxR3pXYUtSaWlGU1BjbThBblRiNVlOSjk4c3E2L1NDVk16OVV4WnM1?=
 =?utf-8?B?RlFiOGUycTIxYTRGb2VodlRXWENuRkQrOG11S0F2dE9ZWDRybkd4SzM1RkVl?=
 =?utf-8?B?NWpqb0RNOTlXU0x1WVpoU09pTVNXY0hGUGRnRElvY1VoaWNwYmZXaDl4UGVv?=
 =?utf-8?B?R1NRV0k1VnV2WndTMG5ZdmswT1Z3b1NWckgvck05dlRLeWxzU0ordTQ2MnZ1?=
 =?utf-8?B?YVNnN3NRWWprMTRzNjArV3YxTmNHMjhRb0tmejR2R1ZManM5eDF2ZytidHE3?=
 =?utf-8?B?NlpaalhJdi9jZHB5cy9mMWNRQTVKSVZhUC93bHdxYUxoOWNRajh1b3NwQThO?=
 =?utf-8?B?Q1l2TVdtQXd5eWdBUFdlTldFaHVVb0FiOGdhN2lqWmNuYVpBaEl2NFpxU3ND?=
 =?utf-8?B?emxVRVVuU0s4bXpkMzlKd0Jjb3lrNFhLUFNqZWlsbmNTOHdwM21qREFEMHBs?=
 =?utf-8?B?V3ZXbFgyMkhTK01sclRMNDJpWEJPdGFLbGtMZHExbk83VmJsb1g1Vi9YWnRQ?=
 =?utf-8?B?R1UxTWZReStzQWZvcWh2cHh1cmpaL0JsaWZiRk1wN1NGL1laVzlnclJJbytK?=
 =?utf-8?B?RFNNck5ZcVpVK1VHUllBSFJBNlZ3WlVhSFZXOTdBc0l3cjFBbEFNU2Jtb051?=
 =?utf-8?B?YU5XdXdPdk5OU0RUaU9VQy8zelVkTS9KRWU5MitIYWNsbDlzYS9HM2d2Lzcy?=
 =?utf-8?B?ek9PWmlBRVEzU1ptVmpFOUk1RUNXWnRHTXVkK05xN2plWEc4c2xvbEl1bWVo?=
 =?utf-8?B?emMrNFBTUnZqdmRMSytyZHpkWUU4VisveWpzalJxRWU2ZjlaQnZzNGxOekxZ?=
 =?utf-8?B?Nnd4RVp6V1FYK2NGRUtVVEwwN3F2ai9LYVlpelVSS21ySGJpMHp2UGNQWHVR?=
 =?utf-8?B?cG1uQ1BmK1VLK2NxYkY3cFpVblR2dnpreUJKRVpWSDI4SG0vS0hPaDZrbWxp?=
 =?utf-8?B?bU1XOGJ4UnNuUG9Jak5McmpyL2o4YmxKQ3NaWmtSSEdIdm5zb1BrWmVPWkV2?=
 =?utf-8?B?RXlWdW9jUUFKZmpNcGRRSlUyNi9UeDBqL2hDRFh5MDBuRDN6ek9jQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8083ec66-7de8-4721-7f8a-08dec54fa07f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 11:18:12.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFhuKC+rw62tBgS8xmQ2OnX/Aizy8slR7JJzHAlC7pGAeY+OZ2vGA3+5+hKtjHbINhYW/c5IHNGMIGjc3zH5Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11302-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1812E655A6E

On 05-Jun-26 23:45, Frank Li wrote:
> On Fri, Jun 05, 2026 at 11:48:05AM +0000, Verma, Devendra wrote:
>> Public
>>
>>> -----Original Message-----
>>> From: Frank Li <Frank.li@nxp.com>
>>> Sent: Friday, June 5, 2026 01:28
>>> To: Verma, Devendra <Devendra.Verma@amd.com>
>>> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
>>> Frank.Li@kernel.org; dmaengine@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
>>> Subject: Re: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W
>>> Channels
>>>
>>> On Wed, Jun 03, 2026 at 08:11:47PM +0530, Devendra K Verma wrote:
>>>> As per 'Designware Cores PCI Express Controller Databook', Section 7.1
>>>> - Overview, HDMA supports 64 Read and 64 Write channels. Current
>>>> controller driver supports up to 8 read and write channels only. In
>>>> order to utilize all the channels the controller driver need to have
>>>> the channel related structs and variables as per the number of
>>>> channels supported by IP.
>>>> Following changes are made to enable 64 Read / 64 Write channel
>>>> support:
>>>>
>>>>   o Defined HDMA specific macros to reflect the channel count.
>>>>   o The count of ll_regions and dt_regions in dw_edma_chip and
>>>>     dw_edma_pcie_data shall be in accordance to number of read
>>>>     and write channels.
>>>>   o In dw_edma_probe() configure the channels as per the channels
>>>>     of the IP used.
>>>>   o Changed mask types to u64 for higher channel counts.
>>>>
>>>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>>>> ---
>>>> Changes in v2:
>>>>    o Fixed the pre-existing bug related to GET_CH_32
>>>>      interchanging the channel direction and id.
>>>>      This bug was not caused by any version of this patch.
>>>>    o Fixed the issue when using for_each_set_bit() for mask
>>>>      of u64 type.
>>>>
>>>> Changes in v1:
>>>>    o On review recommendation of sashiko bot, in the function
>>>>      dw_hdma_v0_core_off(), the loop iterates over registers
>>>>      as per the number of channels enabled and not on total
>>>>      number of channels supported.
>>>>    o Changed mask types to u64 for higher channel counts.
>>>> ---
>>> ...
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum
>>> dw_edma_dir
>>>> dir, u16 ch)  static void dw_hdma_v0_core_off(struct dw_edma *dw)  {
>>>>      int id;
>>>> +   enum dw_edma_dir dir;
>>>> +
>>>> +   dir = EDMA_DIR_WRITE;
>>>> +   for (id = 0; id < dw->wr_ch_cnt; id++) {
>>>> +           SET_CH_32(dw, dir, id, int_setup,
>>>> +                     HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> +           SET_CH_32(dw, dir, id, int_clear,
>>>> +                     HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> +           SET_CH_32(dw, dir, id, ch_en, 0);
>>>> +   }
>>>>
>>>> -   for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
>>>> -           SET_BOTH_CH_32(dw, id, int_setup,
>>>> -                          HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> -           SET_BOTH_CH_32(dw, id, int_clear,
>>>> -                          HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> -           SET_BOTH_CH_32(dw, id, ch_en, 0);
>>>> +   dir = EDMA_DIR_READ;
>>>> +   for (id = 0; id < dw->rd_ch_cnt; id++) {
>>>> +           SET_CH_32(dw, dir, id, int_setup,
>>>> +                     HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> +           SET_CH_32(dw, dir, id, int_clear,
>>>> +                     HDMA_V0_STOP_INT_MASK |
>>> HDMA_V0_ABORT_INT_MASK);
>>>> +           SET_CH_32(dw, dir, id, ch_en, 0);
>>>
>>> why SET_BOTH_CH_32 not work for 64 channel?
>>>
>>
>> SET_BOTH_CH_32 works, but this needs to be done on the channels enabled for the IP.
>> HDMA supports maximum of 64 channels. So if some IP enables 8 or fewer read / write channels only then the number of channels come from dw->wr_ch_cnt and dw->rd_ch_cnt. Now the logic is derived by individual read & write enabled channel count. Earlier, it was assumed that user will enable max of 8 channels which would have worked well using SET_BOTH_CH_32() but as the channels grow, the assumption that equal number of read / write channels and that they are set to max count are enabled might not hold true.
> 
> Make sense, please wrap your reply, it is hard to read
> 

[Reformatted the comment to fit within the visible window]

SET_BOTH_CH_32 works, but this needs to be done on the channels enabled
for the IP. HDMA supports maximum of 64 channels. So, if some IP enables
8 or fewer read / write channels only, then the number of channels to be
configured shall come from dw->wr_ch_cnt and dw->rd_ch_cnt. In the new
code the logic is derived by individual read & write enabled channel
count. Earlier, it was assumed that user will enable max of 8 channels
which would have worked well using SET_BOTH_CH_32() but as the channels
grow, the assumption that equal number of read / write channels and that
they are set to max count are enabled might not hold true.

>>
>> - Devendra
>>
>>>>      }
>>>>   }
>>>>
>>>> @@ -79,7 +90,7 @@ static enum dma_status
>>> dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
>>>>      u32 tmp;
>>>>
>>>>      tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
>>>> -                   GET_CH_32(dw, chan->id, chan->dir, ch_stat));
>>>> +                   GET_CH_32(dw, chan->dir, chan->id, ch_stat));
>>>
>>> why need swtich id and dir here ?
>>>
>>> Frank
>>
>> This is the correct order of arguments to the GET_CH_32. The second & third arguments shall be direction and channel_id respectively. It is a pre-existing issue reported by AI bot.
> 
> AI found existing problem, need seperate patch to fix it.
> 
> Frank

Removed this fix. Will include it as part of separate series.
I will upload the next version with the above recommendation.

-Devendra


