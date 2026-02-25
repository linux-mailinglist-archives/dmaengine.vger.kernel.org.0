Return-Path: <dmaengine+bounces-9102-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMB9H2VWn2mIaQQAu9opvQ
	(envelope-from <dmaengine+bounces-9102-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:07:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652B19D0A2
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3576130210E8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC52DF6F8;
	Wed, 25 Feb 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDH9SL6r"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFB301719;
	Wed, 25 Feb 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050014; cv=fail; b=Eu6Xrygbw5ht7DqX/jPq1NWRWTpYfUM1wZNV52NJ0W4Cqq1kjJycdxCQuP1vIdMaGfg0CJPT7KCQcQURWVng8pIKcm+aOSpxEQh0hMzfJCvG1+QrY1/7Y5KQkPLUJpcdkB7BxmVdOzMzAqnr8R/Vhyi4hli+ZQ49jjsqxv2Isu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050014; c=relaxed/simple;
	bh=1K2IPoo6q6csB+PeISZbUo6eTjQqzvOB5YNuIWKuPmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g8d3du74MkMLiajloCJqq89l3fm5IUv8bFIMjgu6tcoG8+Lul4aDPbMIvOjUKikVeEfZ6prKE5VzcCnr2SQsCC84CgO6u03E6rhRYWZbwMmIvOwH5feBdpUZr8+5RTuVEiwm2y8u54buqFO2hDRMBag7nHKaQ9XF2q4KB9Zt0Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDH9SL6r; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu1GzuUw6jX3RC+HKSQF00vW42iZ1A1SZzsOxC+Upkhf53Xqu6k5hJr1IaXlTijTEHVNcsGvlHTjRDU6sncKw74sr6IkcZh1pdcBS9IIDQOgqUqixHpX99EG2zD+UuLZEp7OCRqWcYqt+raFJcJibTnutxnypZP9nFOVK2JTvcHAatKXTzYKBcJ1bPWfIpnHMMuzpxgOUkMDHlDW/P1M04MZnczStDEfOc4HxWOtlWA4yOSDQtdM5CDyFQG9B7SgLJLURZ69IOI5AKwx9OJniU9dkpG56gmNj0RtsPk4bVetAKuByYPOTzvZH8p517GYQmCAPC6CXfU6rDJE18nRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlmkO4hjs2uqtxQTcvGphw20TDxkC8ULDb346zyqJpo=;
 b=wWqtvzfSQvr8ZE/NsJu5RRGdDh9l5J+WBVY5Aitskb+P5rS77yQmadGtFpT+eppo2tG14bv7570mYbdEBXVOjgAck3NRwffUl1m5a0n7p+83ZVpg4CbBIcEXed+JZUcdno+udkvWfMU9hhZnMJJO0VJ13EnEyduabY7eJa6LfQFExbpjtqTO4YPiKRF5PJpagoZ9c60qhrTJAN3yseB4coZ/9ll0/SzIzg4Pay+Q5L1bNELsog8LvlR3O1yRB/S5cXyCTIkaKUSrS/7WNUL6AGiXBnJHhzEzjiQ+xp3NjPa5ipOMuwqPunDQWuLjVnNonDOJGRO7Ys8YVHUvEPmLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlmkO4hjs2uqtxQTcvGphw20TDxkC8ULDb346zyqJpo=;
 b=QDH9SL6rVlzNZL9xtbnI7qvB4QjPfIxhfd5J1wDVBHNnx6+MX7bBe6QMw0KV7A5Jeo3NKhlKDLjbMfrLRUiYzAbOPxj1UQ083Qw3LEzlVnECyjfvExnQYXauXXrzDaxIbvMq56mqoAHhRN80hxUkvv36IZbR41Y9zCqkvA1GtcMV9AK4eKnnIVMYJ0pIzhFGBJHzZDpuBiJPJMGKuj7n/LOqPZczLOMvjIRxaHdcG/r2gzKcR8E0xOqdqISxbgswpQWxsuFTG3iKvfdtorhQleBXsG74hvAQdIEwVSIPqC/NBNaPEDwRqISFr1zjxozkWEfad2wiTYs5vhu4kKv2Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 20:06:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:06:47 +0000
Date: Wed, 25 Feb 2026 15:06:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, akhilrajeev@nvidia.com,
	vkoul@kernel.org, Frank.Li@kernel.org, thierry.reding@kernel.org,
	digetx@gmail.com, pkunapuli@nvidia.com, dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra: Fix burst size calculation
Message-ID: <aZ9WUPglQp9NTGax@lizhi-Precision-Tower-5810>
References: <20260224083455.333330-1-kkartik@nvidia.com>
 <aZ4jwJ330VUXBNuE@lizhi-Precision-Tower-5810>
 <a2efd470-6c66-4686-8cc2-ce767aac930a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2efd470-6c66-4686-8cc2-ce767aac930a@nvidia.com>
X-ClientProxiedBy: PH7P220CA0163.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b57066-8023-489c-877d-08de74a967fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	4OlMwUqbxW5rrlLMjiT4kXh5XowIUpc8wpk0QdDG66R3549uHSo8rDghGe8C3ce4zTpUVIwA1c4kTEQv4R3DCNMRFPklLslu91MM73zUbSBM/capRtwcl+l1U7/8ij+hrNQZaV2RbZ1UYgDi9bh5ZuWHQSlrjHhpXnFGwNTd55wsNs0PdivBSHr1kExDAKjR57dpZ5b0c1Sa+MJuMR/4YFohdB+t/qIvV7zzUjOfVuEdXi7nUnUBZhH0oNCgxkW9lB5jrOWJvXpMRa09dExJFw4A505Pjyh+ds/Marxg8Sx5UeXtAQUr576dM/JXwVGAJqtTCblE9oKOtV5fXeK9L8ds+RvRUh8RSORoyrxxZbDu3rjqg0gg5oEXNUMzHURcHPsL4Za/IrfA5sTfEWDHb0TohDPlYqhwULfmWi5gkx9jBzKFI2bTUdj1O4NPUGtYVaCqQlOaExGsFs+YgdjusjPKuuhSULlRYUnrxLh52xJdlvjpxBiE8hdC2zwkFAO24aUeFsjiZiCJ29JsyXF8S9F71CCJfLTJOb7g9BqN0PjWJBgGvdob97VrOA0M67xBS4o9wxafMomAjRhqS+PKCwQu67ABOaZH3AHTxSvR3zceXdewuUwvX4g6cZtGmSKewjC0UuQNxVF1oug5O6jtiaLVSuxP/LTpFoGzTL4oJhaI43e83rt62n281d1qzWol9lFN917rz1YU3dg8X2HwApnWiNZiLf/2L/LIKEvpqU7CKmPGPvgBbAjNtqOcUSM0crZsuUHgZMER5155rIDawJQ+u/hoH5R3oJwv4W9yin0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1F0Rm9BUko3TzZnU25CTGJoVU5IWXBaeHArYTQvYnM2cjFKNjg3YzRJR0tr?=
 =?utf-8?B?VE5jUTF6SEJDMTU2TGF4WDJnYlZra2N1RHd5SU50Q2dMQ1Y2OG9LSVBEcWZW?=
 =?utf-8?B?ZE5sZHVjak9kVG1wbkwzbkNlakhWUFhrTHd5cHZCTi9TZ2NOT3pMUVozMFR3?=
 =?utf-8?B?bkpKTnhiME4rTXUrRXd6UldMSS93cGlzRklJY2ZabnlJQVd2TXF1OUlCSkxT?=
 =?utf-8?B?RVVaTGRrc29jYkpsUUlwTFNBOTd2ai9sV2R0SnZBUVN5ZmsxS0lMb1pYZWtB?=
 =?utf-8?B?bmtRb2RSTkpzUndJTXRuMjYrNDNqaVBHeldjZlQzVGhqV1lZd0NEUGpTNU40?=
 =?utf-8?B?SGJ0YmtRMklNbWZFZ0tlcDcrTUdZZkdUQjNuV3dWYUtoNWlaUzRZM2pjZGQv?=
 =?utf-8?B?NGZiM1p1OVpBanZueGwyL1pkMCtVZ3VKdXpUUkVBRGhGeXlTa0N1eG1wOEg4?=
 =?utf-8?B?RnQrMjh4bit5Z2NyVi8yTUc1REV2UHM2clYwbVN4ako0UWtZWm56VXAxT0dk?=
 =?utf-8?B?V3ZNZFVNZUlnbW1pVW9GM0hUZkVKSlJyWUtjZXlaZnY1OUNFbytzcEh2dUxU?=
 =?utf-8?B?M2REK3B6VkpzcmVZV3FtdFVMcEIwVE1ZcFJkN3F0Vmdqcmw5dkIrWkpiY3JR?=
 =?utf-8?B?ZGhVbzluUjNhWWsvREFXK1J0TDV1SmJEM2Y4TFNwVWc3L3JhQ0tSeXUxdEp1?=
 =?utf-8?B?aDk4aVJYV3NuUGNROGNjQTlKenhNWjlNckpNVk1EWG5SQ29qTDNLNlB5VmR5?=
 =?utf-8?B?azRGLzZYN1RBUGNnaTl6VVE5UDlaWlVndEhweWRlS24yOUNFbjhoKzBDKzVJ?=
 =?utf-8?B?VUo2Z2loNmt2WFZlWCtOTWNDSVRGYklMSkhNM0hUS0dFcVVrbW1POWs2VnVQ?=
 =?utf-8?B?K0Z5bEJrNnlLYkhYSW1JSmxGbDV0ZWJPZ0VCaFlOWENIb3BDQUtrOFN2QmdN?=
 =?utf-8?B?SW9hekN0RDd5R1BnQXRzelZUQVdCWjN6N05wQ3FZY3lFWHkwYkVtR1Y3MWk0?=
 =?utf-8?B?cUFMYWUvTVQxWWxQTWhQUTV0Um9jcGNtNUpXT0ZDcHBoWXk2VmNhelpFYS9j?=
 =?utf-8?B?TjhJOTI1VlZCRkhGOXYxL3R0UUhIZHVTdVIra25LdmpWOGVvUHFVK1lFOVJm?=
 =?utf-8?B?WmFkenlWWGtJdGdXRDZxQUJQRzJNcmdrYUdSY1lnZVF6cVRlNTJ3M25QRWJz?=
 =?utf-8?B?SnRYUXRUUFpXMkdKMTlqNWdjUndjSWFyUkZzV1ZzQ050Z1VIUkMyYXZwK0RW?=
 =?utf-8?B?YUx4N1ZJTURZV2c3MVdBZW5YL3REK1ZDUWNHMTRma3FQU1RRbXdKMWhBSXR4?=
 =?utf-8?B?RnVkWlZKb2RBNDVGUkF0Q0lUY3NuWkNmaThaaGUxMElsU1NSa3JXdE4wbTQw?=
 =?utf-8?B?S1E2Y1VWQ1ZSZHNvSzN6Skh4dVlCMlVhMEs5UnJUeUwvSkNNbTlQWlo3MGZL?=
 =?utf-8?B?RWZ0WFk3bEdKQk9nbmp2VmNvNHlUbjNNVTVHVVJBeHNvTWI1dGluQjRRb2lF?=
 =?utf-8?B?RTR3V25tWFlmZ0R0YkJoSFRPVGtmeVhNV2VxWTRKdHpJcWJ3SVZ4VmlMRytK?=
 =?utf-8?B?amlVQ3lTVDEzQ3NqNjN4Zkx2L2xEaE9kSHo0c2pyV09VM2dtRGVqVUtBUnBi?=
 =?utf-8?B?ekkrUlVWcDBnZ2o2aURlM2hVTHB2NE9JN0tCMVlNV3BVVXRvVHZ2aGxrS2tm?=
 =?utf-8?B?N2dwU0g5Y29YZTkyMHlYZlI1cHRoM3F1YlRKTG9BSXl1Z0xpRUhDek1WTCtH?=
 =?utf-8?B?QWY0OUxSR1dtYzk3dERrdCtnVnd3Wm9kb1lWSmRCbVhGaDJxcFJEcHBuSE84?=
 =?utf-8?B?UUg2MmZuSHVYQ3Z1SGd1c0pqejVNMk9yd0lVMWJlZEljOGJ3ZjJJL2NubU5V?=
 =?utf-8?B?SC8rOUJvckdsRUFDRWE4QkJ3b1VkZ2ZjcU1KUzhGSkhiaHVlcm5XeThFT3Rx?=
 =?utf-8?B?NjJxMWZtcE9HaTBoK0Z1UTg3SGlLLzlqbjVPYUpJKzgxOFhWanZqN2pHeHBG?=
 =?utf-8?B?eC83RXBXT0NjU3B5aVVJbkdBY2JJdzZveEd2Z1F4TFJ4YXQ4R1JmdXViazZu?=
 =?utf-8?B?TmhhZjZ1ZkpSRzJTanVsNktrL1hhSURDUTRJTE1zNktVb2lGVWhCeGVpTFJy?=
 =?utf-8?B?SHQ5YldlaU9DbEN4QWFLWGVrZ3BNR3RkanFKeU9DUkdXRTlWRFVZL2FNRFRG?=
 =?utf-8?B?Q0M2VmpyQW5pVkk4T0RrT2IyKytkZXkvcUJRakNyWHBkMmRrSnNQQ1FuSjlY?=
 =?utf-8?B?TDk5THVEViswMnRWR1JlZzByRndsMnZVVGJ4WEFMbTJ6WWovbjdKb2ptNUZl?=
 =?utf-8?Q?prAS+bQagYiUj9nwlt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b57066-8023-489c-877d-08de74a967fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:06:47.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U2omfn54nuzh3BxRGXPGkzdMZEpVRgSi1e1DUvlsAnqA9Y6ULzDMFDd4eqjsVbxgk+2dxgJUa7BoIHPs/mXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9102-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 9652B19D0A2
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:36:18AM +0530, Kartik Rajput wrote:
> On 25/02/26 03:48, Frank Li wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Feb 24, 2026 at 02:04:54PM +0530, Kartik Rajput wrote:
> > > Currently, the Tegra GPC DMA hardware requires the transfer length to
> > > be a multiple of the max burst size configured for the channel. When a
> > > client requests a transfer where the length is not evenly divisible by
> > > the configured max burst size, the DMA hangs with partial burst at
> > > the end.
> > >
> > > Fix this by reducing the burst size to the largest power-of-2 value
> > > that evenly divides the transfer length. For example, a 40-byte
> > > transfer with a 16-byte max burst will now use an 8-byte burst
> > > (40 / 8 = 5 complete bursts) instead of causing a hang.
> > >
> > > This issue was observed with the PL011 UART driver where TX DMA
> > > transfers of arbitrary lengths were stuck.
> >
> > Suppose set burst size by UART driver through dma_config_slave. it depend
> > on uart's watermark settings.
> >
> > Optimaized method as your example is set first transfer burst length 32,
> > the second transfer is 8.
> >
> > Frank
> > >
> > > Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> > > ---
> > >   drivers/dma/tegra186-gpc-dma.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> > > index 4d6fe0efa76e..7df0a745e7b8 100644
> > > --- a/drivers/dma/tegra186-gpc-dma.c
> > > +++ b/drivers/dma/tegra186-gpc-dma.c
> > > @@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
> > >         * len to calculate the optimum burst size
> > >         */
> > >        burst_byte = burst_size ? burst_size * slave_bw : len;
> > > +
> > > +     /*
> > > +      * Find the largest burst size that evenly divides the transfer length.
> > > +      * The hardware requires the transfer length to be a multiple of the
> > > +      * burst size - partial bursts are not supported.
> > > +      */
> > > +     burst_byte = min(burst_byte, 1U << __ffs(len));
> > >        burst_mmio_width = burst_byte / 4;
> > >
> > >        if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
> > > --
> > > 2.43.0
> > >
>
> Hi Frank,
>
> Thanks for reviewing the patch.
>
> The primary goal of this change is correctness. GPCDMA requires the programmed
> burst size to evenly divide the transfer length; otherwise, the transfer can hang
> due to an incomplete final burst.
>
> While dmaengine_slave_config() allows clients to specify a maxburst based on
> their FIFO configuration, DMAengine does not guarantee that every submitted
> transfer length will be divisible by that value. Since clients may submit
> arbitrary lengths, the driver must ensure the programmed burst size is valid
> for each descriptor.
>
> This change simply makes sure the burst we program does not exceed the
> configured maxburst and divides the transfer length, so we don’t end up
> programming something the hardware cannot handle.

Okay, it is fine.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>
> Thanks,
> Kartik

