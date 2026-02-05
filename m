Return-Path: <dmaengine+bounces-8748-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SlYkF0Y9hGkC1wMAu9opvQ
	(envelope-from <dmaengine+bounces-8748-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:48:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A1EF164
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EEC33012BEA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911361E9B3A;
	Thu,  5 Feb 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VPOG1AX6"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020136.outbound.protection.outlook.com [52.101.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9142AA9;
	Thu,  5 Feb 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274113; cv=fail; b=r+rDxJ+iMzo85fr7esLpGau84b9me7Vff7wm+ubGOiClqvULYMnHobhQcAPFrDnVAC+bjAlzWT64CNky/rn39havVP4eHhJVVVg8frXRj1YBEQe1WRT6xQ71k4e2s3ZOBt8Rdj5kc1KQXZZZ1GFLfZK+Gjho9J9fB0bQaf3dS68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274113; c=relaxed/simple;
	bh=bpSYCDWnipM/AiM52FoLgLxSVrI2XPsAyMLxQnAvNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cQnbDoFcpabIAQaxpG79AzfBL9d6n4ubtrJIFLkOlrr44aX/+KtzoWfE0V3zs8bvc6uANNBjkqhQzEOZiw6UecaeAXjItqKtOLUCG+fhHWZ5fvCbSgWHxdjjkudAy4XlVGFju6st+d33PgSfNNN6Zrdf1Yswb8X9byNRGhOIFF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VPOG1AX6; arc=fail smtp.client-ip=52.101.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b24bToAJ3LKnxN+PuQWEX2SRE3jGytJUg+v0RDf/AQhQRgn2+q6uNflFvl/6p0ucI0EDJjm/PuqZ7cL/ER8P8F6+jWTpdFOu2kLVTWMAOW4AoDnq6+EsYbcOrvusSMP3eYjjnhnIEaIyWm5w8hCzZXv8UM343Ca7uDwiWNaeEzBJ1GuwlNHWnqOFReP54kMAda5Yq6jU+QmGxYJl/CtefUNad1E2mqcMStDUxhBzogtJO8WmQKdklnHIgtek0mIh97zBwRmmH13z6gunoz2/d4J1Iu5air8qkRPiB38aOVroxJrML9ci6AZkDsDGvH1rMsXjQTz/AV2+Joi3Hg9udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+aAX2K/9ZHnbcM30fnGrOuvromW0dTf3NJ+h2yAg4s=;
 b=CC5cf+sKc3nAiWfZSv5upZF8UOe7GuPBh7rVh6X1/hiLoco6xYUXjXkePKhiBscbIFQ99jWR2rwoW6v5e7nE7UJo2aNpm6HVM+9Ffdx3Q3tV2SPLWhKKDe6cT3QijduHvPRQLCMQGkUVEAEbc1ZxayNbiNtEDVf+uAKB5uIAB3nqBFyL57Ubjd77izVCNETrGTz0+R8dHSbl1+ck0rL82cDbmAQCZ+eyqPAeBCpX+voiKry5Ir7jCF5H422NuZyluH/bz6nLaVcqmzzQfnfhMpq550iE23VKbVyT3ZTGDbYbVCKc/Sy2i+zcQE9Syxxn3gqIbCLVqx6GY66uj1gtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+aAX2K/9ZHnbcM30fnGrOuvromW0dTf3NJ+h2yAg4s=;
 b=VPOG1AX6aSDruA2QMuF0KhQH/kL8vTx4fFlSueMpL13Fa2PvKd6xONOneOjzDgtSM9b0/7KsSgTcTHKI+Hw3yHoCOX8reBq/nDXOKgx48f5ONsMG0FcvphfrrOCv7oV6kL7CRZ2BErx7iXS3VzcVsPHT4puuIb7DNZsbNpFB3mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5786.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:48:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:48:31 +0000
Date: Thu, 5 Feb 2026 15:48:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <2akk754wgro2fgs6wradkqtuzu3tfq5klidvy4qhosnk6lbgqs@7c7thld5kqn3>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-4-den@valinux.co.jp>
 <aYOFEe-zyu4ZHTAl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOFEe-zyu4ZHTAl@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f40baa-39f3-47f8-4ba2-08de6482932c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eFWgJfpd/tQ4oDzBQR5i66hlCfnJI4/XSGQWZslZ0WRnU7kOQTe5qklyqp6q?=
 =?us-ascii?Q?XEvZWr+cChewQ8PMzaFtB/zocFyJJM9WdS6gC5LV7ivAPYIIgprJ/y/hKaV4?=
 =?us-ascii?Q?z4jOewiY+Kh2DREnodPmTebLfIPRc4jRanz4ihvAh0Ks2cgrHVXhsNElYJe9?=
 =?us-ascii?Q?KhA7s+9ID+qElx1DjZUGk/Vqr+Ghkxo05NOfgRFM4yd/JiRVDMJ/BC2nIncj?=
 =?us-ascii?Q?lkjip6aieINcG6srVYbmHESVO8g0nMgnHpyjDLBVQOFn1P8GP3TfQuiM2L6h?=
 =?us-ascii?Q?ocSkcsY/Z98rTJqmayoubWmQLGSZP/MnNL4WZZeONC5m1VIL5ky/XIiTsk9+?=
 =?us-ascii?Q?k86c8ngBsqnV2/hS4y87du5SKbnTs80Z/2ed4BxruX5dh0Is4JiTbKugSh0m?=
 =?us-ascii?Q?maviYghILiFw2N2GtvyKQTlhamaxZK3lqpD2yt49lTZU1bv8bAKHGud2P4Nf?=
 =?us-ascii?Q?AcQLi1k1qVxVC6e3qoEIGnzibNkce7F+Lacvkv1265jBPfXbyNcnCa61wDd+?=
 =?us-ascii?Q?PoIkqZGvh5UDayf2ZwZw7zP433hvo016oay2Y5CpcJ/5a/hEJzgGxxxkuhYf?=
 =?us-ascii?Q?3zmb9oaZCrSEqjW2F4j6HCb037KBcvpcWjer76wXhciDh00/tjzBNeJ1Drt6?=
 =?us-ascii?Q?cPzviZw+pzzkBARcgmgH9fo/mrlaSrVuxT7nccWOb3dlqtqMgYoO+aD/dXQC?=
 =?us-ascii?Q?K4ZTFSDVp6vWmrsMWpgnizvYGcEIyplqlAf5gLRVHTC88SdiWvOPbsdZzN2M?=
 =?us-ascii?Q?WEqGJcUos8vfMcJNpXG53hVupETJbmkGBtgJ6JyGC2Dh7xLjHowgUMaIzT60?=
 =?us-ascii?Q?UgrYwAGbAyIaXNOap4KlRZ3/a45qTpdo+tumT79qSP4S4wFreVk3Id6Wj2R8?=
 =?us-ascii?Q?0b3+gMTo0Tk2oQyUvydFD+MsluIVUKWnRSIBwDFw0HK7dQnpwN787PQ5M9tf?=
 =?us-ascii?Q?2mXTqmJO2j0Hc6yGii9HN2wK/Oyh0YBbS2XWceVbA0dfq8jzgE0J3jPMhDF6?=
 =?us-ascii?Q?lzQwUzgjYQ07fhxE1xvYB6cPod8G50mRpp0XoKh7GBA6Nds9cWLM4eic1HEv?=
 =?us-ascii?Q?qlhQRSfgrYVPf17X9bxymiBGGokHZgBtQ7MXJl/rSkhkLvYHyfzLd7MggnIw?=
 =?us-ascii?Q?DvP0f/m/iVpQN8ziVbVCvgpXvDmD8Pu/NH0xuG9y+xEwPhF5n4IQ11woYZ3e?=
 =?us-ascii?Q?VMVtT6HRaA5KvNMUE6yah7rOfKOtg8cjoSvkLKSHsq5YUlBFfZ9uRu4XNbzX?=
 =?us-ascii?Q?e1LWO0iTj1v5BfLJRUwZWPn2QubAMRZsLATCGObLQQ3N1Hn+TfpJB2JwDqmv?=
 =?us-ascii?Q?tOvwL4XxjfJU6Xiig9qWYWMpPKqu+t9PUAGYUuV3D7LG0690rZ0bmKQBUp6+?=
 =?us-ascii?Q?SQtmkPlIls8gjDMZf7ZlIg6BobcE1nrrTPdkVIzEvx8naxDkwA34VqU25tMe?=
 =?us-ascii?Q?VjLf6Y+qpF3+6eSWc6A6n9cj/yBgd34jhKJuu/nMmpOm2Dz9QWw2s5DYuHsP?=
 =?us-ascii?Q?xvLiJYg/mf1Bga59WMBzhxVnQs8cIn1xBjT1X3fFOYqS/kyZTNo5bTh4ALiB?=
 =?us-ascii?Q?UfhbN4aXcLrCUhs/XMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hz2tY6gIHQntIEvrVubjjtIojZfyIE7tjuIyJxeXhwTTzU6S4OE2n5stbXm3?=
 =?us-ascii?Q?cyh01JGbLhZSR8kyUjZUVrG8wxWCFlz910+vg0CtfU80MYfYxzDIU4hp5sRh?=
 =?us-ascii?Q?pqOHVRxReiPx61dG6Y7+Uk01cCBOYkBGCeikhDD58U8EY6qBr1wiAJqrTsB6?=
 =?us-ascii?Q?ho4kWyYYCjXMKgGK96lv2//sFEAzpljgQx/HsprhS6UaIWGOpUpB054yKhOV?=
 =?us-ascii?Q?Pz7hfqp0RjCkC1WPbUrFjFHdXDI1l+bhDyzuAWR9kGmEO1E++rnejxBGXfIY?=
 =?us-ascii?Q?9Ig8WuWg1sHBvJMLPdslrIOQ6WIq6EnoSGTPBnkQ4LgI2+kgVEp7UTpffYjb?=
 =?us-ascii?Q?Hc808jMXHcByHrcRkdTRXo6mTY8yUAd1RTqvioMkF+/nBy3WSVwm0GHTGQyI?=
 =?us-ascii?Q?lgLUYWBXY2pFwx4ZfbXUl8IrR9AlYhkPRP5rZbQfOvZ1nSimSU32kWX76Ttg?=
 =?us-ascii?Q?xBWi865y/vVvLuustLpdM1uuSiNWvJs9gDXZnYwic7k3HoBloOWOiBj3C+VW?=
 =?us-ascii?Q?+0T7BWt4V5bzj46nGat8QieYf6Ol5k+B5w7iK69BVaaVpktrDoQkRPU6jTBl?=
 =?us-ascii?Q?KQaH2ew78xIrY3801JBek8/O834VfEgppUrudQ4H5NBk1YHLuO2ofFFlGB6L?=
 =?us-ascii?Q?WvAZ24DtEmrvwUZB6PD5LOGyd/dz7sjYAwb7oIWcK3KcrDVW8PndcIMVYEW6?=
 =?us-ascii?Q?9i2mzgjbEv8jFUXsYIwtof9BBRD4K54H+pPB6QCku26chB67LF/ul6eF2mJT?=
 =?us-ascii?Q?5aFIUnbUrooxPmWMEj7ASLSg3lGAPOXRxBmmIvESq8nzUMYWfEdiqMFwCNoF?=
 =?us-ascii?Q?gd+JBL9qcaz1UwCNFCmN2fLHp2Bb5B30lw6NfisnAQgc5/3BkbO1qW0/dHhy?=
 =?us-ascii?Q?9O8/zlpra1QxAAK/Kj5Nwu1KfJOYkTKVs6HvxJrKrcEBiZRoxRGliTzcZCQA?=
 =?us-ascii?Q?jWJ56153dIR4YIDObiAsJm5uF54TK3hhv4dIZtFAujRVDFNMIn1pzOYOLSh1?=
 =?us-ascii?Q?BEPpyyGUMOO0dR8gRkZh/UI+iJZnT+Y0hU0ar0EgqyPyjqWCCYL21+6lqLrm?=
 =?us-ascii?Q?/b1KvYQLAU0RJMxJm3p6pIq6YKOTAbDDtM0+t/qiw/0I7frirDwDpBlJZpPM?=
 =?us-ascii?Q?6OmOahZnNv3I8eeUnJPU3DQIqxjZTB10NpguTpX5gURMTqPXmtWiD8ujJm7L?=
 =?us-ascii?Q?/9+hWoxZxf7R1OZN42zkEIgfEf+dWwzvbsy2btGCxG9vJbQ/vMYdnpNNz8a2?=
 =?us-ascii?Q?MQpJtRVX4rDTO4Z7rgiw24Y9Mzx61N3iyWIhTNJgxiysHu40bGTEyZRFE5HE?=
 =?us-ascii?Q?t02wVCz/y3rd/CLg9IO33fbzz94oSa5CRKZCIyVscvWf75TEhAljcf9MATvu?=
 =?us-ascii?Q?2Mc+VeQI9Wilqpm2rccv6BpeSlBzov1pb/EEqY95W7OtNyecGq2CeUOpD/sc?=
 =?us-ascii?Q?VLFcQ2rhxNz/pFwqr4Vvu1UOlBaGbGWbE08HQK9mdn6cTbFLpxCfrvOsSVwk?=
 =?us-ascii?Q?ENqSckfKQyFyinqwAqUf8klm5PisM6yjnXaLe503b+ki4nQFx7OFx3Op+e0d?=
 =?us-ascii?Q?vghSWiajgcT0BRshk3PLxQD4gi5YYx9zGvGCdOdtLhJLWJuMrV4XMEafabA7?=
 =?us-ascii?Q?M3Lrz9BripGu+ZHIBaClrPKV/AHQiOb2/4W5b8L9LlTd9jfrVG6MffqLaWcj?=
 =?us-ascii?Q?kCwIu68Uo3J7FNcVZOGqrepS2mFP91E/snp6OhLd8Dtf3X5HhQy3Cp7Hp4Ks?=
 =?us-ascii?Q?ARqS6YAw8phTX4q04O4W2BmFs6cGk1YyBwdL4xyXf7Gx4IuPzDlp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f40baa-39f3-47f8-4ba2-08de6482932c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:48:31.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFt/pR2lpTXV/JpXS6MKB+CgguZ5LjXtl8bNFsgmb8HIKOXp8Jg7yAzevUf05gSQIXa6s/R2/A5zl0cy5Gf8Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8748-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: BB4A1EF164
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:42:41PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:31PM +0900, Koichiro Den wrote:
> > DesignWare EP eDMA can generate interrupts both locally and remotely
> > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > completions should be handled locally, remotely, or both. Unless
> > carefully configured, the endpoint and host would race to ack the
> > interrupt.
> >
> > Introduce a dw_edma_peripheral_config that holds per-channel interrupt
> > routing mode. Update v0 programming so that RIE and local done/abort
> > interrupt masking follow the selected mode. The default mode keeps the
> > original behavior, so unless the new peripheral_config is explicitly
> > used and set, no functional changes.
> >
> > For now, HDMA is not supported for the peripheral_config. Until the
> > support is implemented and validated, explicitly reject it for HDMA to
> > avoid silently misconfiguring interrupt routing.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 24 +++++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
> >  include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
> >  4 files changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 38832d9447fd..b4cb02d545bd 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -224,6 +224,29 @@ static int dw_edma_device_config(struct dma_chan *dchan,
> >  				 struct dma_slave_config *config)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	const struct dw_edma_peripheral_config *pcfg;
> > +
> > +	/* peripheral_config is optional, default keeps legacy behaviour. */
> > +	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > +
> > +	if (config->peripheral_config) {
> > +		if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > +			return -EOPNOTSUPP;
> > +
> > +		if (config->peripheral_size < sizeof(*pcfg))
> > +			return -EINVAL;
> 
> It is good to check here.
> 
> > +
> > +		pcfg = config->peripheral_config;
> 
> save whole peripheral_config in case need more special peripheral
> configuration in future.

Ok, while I initially thought a deep copy (snapshot) was unnecessary for
now, I agree it makes future extensions easier. I'll do so.

> 
> > +		switch (pcfg->irq_mode) {
> > +		case DW_EDMA_CH_IRQ_DEFAULT:
> > +		case DW_EDMA_CH_IRQ_LOCAL:
> > +		case DW_EDMA_CH_IRQ_REMOTE:
> > +			chan->irq_mode = pcfg->irq_mode;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> 
> use helper function to get irq_mode. [...]

Ok, my current plan is to keep chan->irq_mode as sticky per-channel state,
and factor out the parsing/validation of irq_mode (from
config->peripheral_config) into a small helper used by
dw_edma_device_config() and the new prep_config path.

Does this match what you meant by "helper function"?

> [...] I posted combine config and prep by
> one call.
> 
> https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
> 
> So we use such helper to get irq node after above patch merge. It is not
> big deal, I can change it later. If provide helper funtions, it will be
> slice better.
> 
> >
> >  	memcpy(&chan->config, config, sizeof(*config));
> >  	chan->configured = true;
> > @@ -750,6 +773,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		chan->configured = false;
> >  		chan->request = EDMA_REQ_NONE;
> >  		chan->status = EDMA_ST_IDLE;
> > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> >
> >  		if (chan->dir == EDMA_DIR_WRITE)
> >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> ...
> >
> > +/*
> > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> 
> keep consistent after "," for each enum

Ok, will add ", local interrupt unmasked" for it.

Thanks for the review,
Koichiro

> 
> Frank
> 
> > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > + *
> > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > + * Write Interrupt Generation".
> > + */
> > +enum dw_edma_ch_irq_mode {
> > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > +	DW_EDMA_CH_IRQ_LOCAL,
> > +	DW_EDMA_CH_IRQ_REMOTE,
> > +};
> > +
> > +/**
> > + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> > + * @irq_mode: per-channel interrupt routing control.
> > + *
> > + * Pass this structure via dma_slave_config.peripheral_config and
> > + * dma_slave_config.peripheral_size.
> > + */
> > +struct dw_edma_peripheral_config {
> > +	enum dw_edma_ch_irq_mode irq_mode;
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > --
> > 2.51.0
> >

