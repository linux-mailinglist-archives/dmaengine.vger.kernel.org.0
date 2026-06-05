Return-Path: <dmaengine+bounces-11193-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1XMVOfgXI2r+iAEAu9opvQ
	(envelope-from <dmaengine+bounces-11193-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:39:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E837764AAD3
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 20:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=mTW93vI+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11193-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11193-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FAA0305D7F8
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0CA3AB5DE;
	Fri,  5 Jun 2026 18:29:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F2399369;
	Fri,  5 Jun 2026 18:29:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684159; cv=fail; b=c1d5MSwmx2SwI7UTeX22dnuGjnY+wJJXWMWjRJan8uJxOn5Ieguvm/5HNPc8kfyhYVhzACeoxCulRsqaoKoTGVgf2LsxfMqEC8X5egyXlV+n455NZSc1KAGFMUr7emRQ2jaAyM9ucwyRCvjwcUJYEh3wDiYIvYTB/g/5ivnuAcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684159; c=relaxed/simple;
	bh=xUPWecNASgTP9XbLtJWuv5ovqwbLC0/lQ/upQ7kVwME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PMkOeBRr2PsnPMtoctMkdU1z8Y2rz0ZbwBQaHy9568iGxBv9k/gAk9rbbRsI9ewoC49tylexvSHHGXwDOPLC/HtuIQ8N7CjyuXmB+3vPQ6ygntNXlf9W91rxp3Jts0b6ueRXEkAOHmUa8a+9VUd4Uf3fIASc/YAThXPiAnUd7xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTW93vI+; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSADWMkOmds7gzyyrZikLwr53CKPgIgO/CtipBpMGVvbotOJ3MJ0wsqwi9Ljr+0uF16yz/adVCuWDWIJhNjYy3+H+kuDfjld0y9BQ8CBeA1r1Sgu+p13HAohXQDh/LwFFS0CQsNBpTv6wEge4X29JX3hIQKAVdfk9a4Omoyy3oHbFxMwaIg+dkBYh+nOJkwfcs+eU+usVBALXCJIj5aJfEAkWkL+Vtm1pWDpiRLvjv5JHpFri6AS8BJB3RxCVatYnyWMEYO+3xH+HlA7eSMUgc/7Tpk9KphUszYo1GXWvQMONR6YuWSroaffMrkHbM0CWXVEcvw98nuhvq0MxZjUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC8fcTrDFxyZxzOALGC8ZA4sh58VykdDmdhoOHjbQas=;
 b=jXshM0wReoYDmqu5EM4WjU1y0FUDSRmCwZPo2bz1BNO99xIOPppm0WSpPKG3EkiATlXDuTEuBdGUE/7h9h59RtdZ2koLHVBkrPoAXBEOiHmvd98Ece9yVEKF3ej3fXOV6c0Qx6UqyAA2u/A/g1vke6AjDaEyDFQ82zGw8Ry+tB6NYXg5t74iSUujv45yqAK1jkMMVozK8I+pvI/9jAhWopjW3Vyg0xteQfMlVhju/dpBCCYRFnnhTIwmHVQcW46oDEZ3Xr6p/y6daWu47rojBQlbxYRoAJJ3b/B23ExLfowxUvyJw98A4XNwQInwSEkRLTIAYC6+nYe+8suPdGO9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC8fcTrDFxyZxzOALGC8ZA4sh58VykdDmdhoOHjbQas=;
 b=mTW93vI+7CCknMmolSnUZEPy7KjUaF2GR1IHv2yY9PUmthtU20v0mMTtUR4p8y3y5o6vtPJWW5wITBmo2X/lirW/k2mX9zRw//dNs1HPJ8aOQKR9UVSB/+lvNSiLgvNZu2Hy1U1ah6UXb/hOJTMi3KK6wkQmsAFltXmbNAPN0JGEHK/P9m4YMbfYNlYaOdQn9rpK6xjyH+7nKZCLDgT/yIRq78lqghwMPK2VRgJ7yiJVaQ0e0Qk6+oJmdyvuC9Hk0/TYebgzcM6Q0+jHGrK7kYa4msLSYyOjy/ZAFyqAZHlFR1iskEOXmlXOirTrbC8Wiz2hu0FOA+PjHHeryaJJyA==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:29:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:29:15 +0000
Date: Fri, 5 Jun 2026 14:29:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: fsldma: convert to platform_get_irq_optional()
Message-ID: <aiMVdfz5_jrO9nXZ@lizhi-Precision-Tower-5810>
References: <20260603191951.5729-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603191951.5729-1-rosenp@gmail.com>
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: be7fc26e-9ff9-4c93-a6a1-08dec3305902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|56012099006|11063799006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	gyvLCu4q1WbKnGrBjjGNErpQ6AKffCsMKVngmO7l70q3fj/6vqrMfgqQZjqDo+kEhK8zAcodY0oeRea80kZeQIj2zXf4EY6++2mr+6MADDnHw/d5XcPsL19LEcAJGsejdpmDs3wvdRlcbkSXdM3kMw375ovHHBdJXbaOz/7j19jmTrVQo78s9/knqGrXRWpKVmGUe8skAo45VkyVBQ5cGpW543ZAzl3rMPXmVS5Rb3qcGXC/VIA22RVP7AhKbDNT7hmhXuZYHfKO7gTKLwNsbXYxsHOaLdQorIOT+G8QvBGfyRfy3BizcdmSeDQ63iGg/9mjorJ1NKeeu78s+Zq9ztaUEliBmQqMBGlTk0SFscq2zomxDTAYkLrq6N6QO8kcFNOYyBZgwcXgTiO3cd4zCKktL09xE/U40bKboLUiCblppLEIllJxn7C5PShHw/BLkEwMFwj7uvxkm/Y33A3Hee8ulcUrS8De0ho376E1e451iaFL3wpmRFloEQ/zNJ3Z0Y13D4w5lwq0cGO+v8/NbC1I3LUaZl7jLpdvNoyicgCQRAQSTWH0RMoAJ8vXr1avWCBGpglU6Y9dKbNtYNA0sq1a8khgg6KLD+97OYs8Sc9CSyrNX/P/91WMMEQYJenemt0W+xpi3hCG/O0s1/uJ46fX0twf9Q/ZIRwk8MuYWJ75vBXfCxD5GZCI9L4m2BtXeC3fi6Mat5x5jfpo+xPkqzQFB/Zgt4LhD+Qo8jty52KcC2IUG3M9euINz/XFd3e0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhGYmFXOW1tWEcvQlFLY211TTJxTjRhYXErL0d6elduSHR3SzNxRnRENVpF?=
 =?utf-8?B?MTNqWk9aQmY0cjlKVEprK0psU1pvc3NRTzdvZ1N6ejlFSjFLTCtUQTVXcXVC?=
 =?utf-8?B?dGc3M0FUa2NrZTBDdFFpcEtvWm10R0pocHpTTWNRWjljMGZTYnd2VUtlSWU3?=
 =?utf-8?B?MEJZdk9LLzQ5a29iVzdSamxHODBMNGpuUGFDNjhwcy9DbUo5dlFVeTEwWUow?=
 =?utf-8?B?cWhRaDQ1NjdOYjU5K0x6cmwrczR2aXNQLytBbTFUcjkxRGhya2kxUjFRU2p1?=
 =?utf-8?B?SEg0UVg2QXQ3aC9pTjdaRHVLdnJiMmorTlUwK1VEK2NMSjBoVytEZHYvTWtx?=
 =?utf-8?B?SElQVmlZeFNqNlU0Yjg2bkFHZVRQeE0xUzhPcTRtb2N1Si9MWXRoQjA5bkFr?=
 =?utf-8?B?T09RUmN0WWliQ0tROGVvaGdFdG40Mm5BUXhxUTNMelJmbjkzOGlQdzRnczhn?=
 =?utf-8?B?bERCaWl5VStXVVBZUTdaUWFYWjNONlBwbkFYSXdBU3RreWtOaHJqeFA4Z3M4?=
 =?utf-8?B?dmtDdlNqaG5YdTcyM0VXcFVNQlR6d211b1lhUjI2cnoyODFwNmV5Q29xVXlh?=
 =?utf-8?B?QmN2M1lJMExHeGlOa2hNZy9rbnM0VHpxM1FWSDEzZ25oSHhwM3pkNGRiZHBq?=
 =?utf-8?B?TVFkeit3clV2UlludzdyS1oxYjcrdDRSOFB4TWdiT0lZRkRTZlRQd0k2Tlhn?=
 =?utf-8?B?cmFJcXBmK21ScVdjZ2VHUE5TWjhieTFlSEdJTkdIenpMQXUzVU5XQnFLVHJ3?=
 =?utf-8?B?K1ZOZG8rWTRKTXkyMkZUblBBelRybEVpRGRWU3RFaEF4cDZVd3BIbXpvb3RM?=
 =?utf-8?B?aE5kQ21TbHNUdHdIZGI3SWhEWmN6blB6RkNMNEg4Ti9JOFdiSXo2b28yampw?=
 =?utf-8?B?KzZQbFpnZ1ljcGJ4R3NJeVJlTUl3N25ld2N4cXl1ZVh0aEMwUDAzeW02ZytO?=
 =?utf-8?B?eldjU3FZZC9QVE92alVLeTR1OWtZOE5UbDBueC9jOWMybmRrSkw2Z1RvU0h3?=
 =?utf-8?B?Sm1kMmJuZzNPa1NoS1NuQkZyQnh0SVp2WE51ZnkzUmdoVTRZNmtTR2g1QUxu?=
 =?utf-8?B?NEpUWEIwS3hTSmE1Rmx4S1VpMEJSeHlsaHdTcDVlSmRDNkRYOGcwaXZZQlNI?=
 =?utf-8?B?YnAySHcyQ1BDV1YxMWxsZ3cwNkdCQ2pBVHFTUUYxT2FQdThDclQ1YUpNd3g1?=
 =?utf-8?B?Z1ZWbmU0b0NPVi9ySzc3OElib1UyQStBQThJN2VGZUY0cEovYU4yOWYrVy9k?=
 =?utf-8?B?SFJhck9aSUxKdVZ0Z2c1UWxjM3RySEJxN3lmVm93WlBMeFJjdmZzTzc3UEVF?=
 =?utf-8?B?L0hkWlFudGpkM2g3RktGdnhNNm5MOE81VW5BOVBMblEvWFJURVVmQVZmMkcr?=
 =?utf-8?B?Q3oxZzkvaktZMkQzWXlvRnZYL1JwZ2lTVTVlV1pLcVNkZHhBdGMzdVVMMytu?=
 =?utf-8?B?MUVPUEcwUWgwS3h4SGhnWWtIU3pLTzQwOGNmV2NKdy91MXlxYVBhdmpvUXkz?=
 =?utf-8?B?QkFXcy9zQk1VYjM4NDF5b0ErLzRCYWh0S1JpbG9ETGNqVjhqL0I4K2pkcCt3?=
 =?utf-8?B?Y3lmREp0WE9rRlNvdFVweTFUZVN0YUhPR0xKN1RqRzRscExtaGRkZzFSYmtm?=
 =?utf-8?B?WEFQWGdhQ0lHb0hnWW11dlRvV2VWMmF1MHloWGhIanlTZmwya2ppZGdaNVEy?=
 =?utf-8?B?UkU3ZnZnOU9pMm9oaVJMNHFvZDQ3MU5tcG9nak4wVlNCRll2dis3Qk9pcUVV?=
 =?utf-8?B?ZjBTM21mWW9IRVluSzhUS1FFT3hNK0xxand2bzc2Tm9SbXBTa1V5amZ1NnVG?=
 =?utf-8?B?SUNWUnNIYWNhWkppbmk0ZWhNaG9mMEtlL2dtUkpFKzYvaGtsb2lwc3libi9u?=
 =?utf-8?B?WmlTdmE2bExkb3Q1VCtqVzlpblNRQzJBZW10WDB0RE45Ym16bTlsSnJMSG84?=
 =?utf-8?B?akEweUVMSERYV2hjdVIzYjVrZ2NUeVRhekpEZGloMFlPb0pxQ2YzdTJBZkhi?=
 =?utf-8?B?a0NpTm5pYVErN3VlcjhHQ0VRZkVGMXd2Y1k3YW1RNVJpRXJuTUVkNzdZUTJv?=
 =?utf-8?B?QmpxK2k2dTFrVEY4cnpielUrdzB6alhJaFhLRWN4OXkxakYwZHh2dHAyUWZF?=
 =?utf-8?B?TkQ1dGc0dHVtRTVmR0prRFBJaDNRaWNlQWhqZVEyVmdVMXRJWjBsSVhBVU4w?=
 =?utf-8?B?ZUJFSExua2tOSHdZWmtiM2kwRVFTUWtTREg0azc5VHdOQ0FjbTBXVWxzY1pW?=
 =?utf-8?B?KzJ0ZDB0Rm1UVEliMlpUVHQ0TTBUMlFLcnJ5L2JoSDh4LzlmclBOUWhKbTR4?=
 =?utf-8?Q?c2BRpTyMqduW75jAh3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7fc26e-9ff9-4c93-a6a1-08dec3305902
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:29:15.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB2uNjiJzyV3qY3MeBYSPN3Ba1AJ8OXC1G7WUaEYiHEJIVgaOr7l/effH2qd+8IqbwAZOvTh5hiYJAmSygCzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11193-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:zw@zh-kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizhi-Precision-Tower-5810:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:from_mime,nxp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E837764AAD3

tags is dmaengine: fsldma:

On Wed, Jun 03, 2026 at 12:19:51PM -0700, Rosen Penev wrote:
> Replace the per-controller irq_of_parse_and_map() call with
> platform_get_irq_optional(). The controller IRQ is optional — when
> absent (-ENXIO) the driver falls back to per-channel IRQs. Any other
> error is treated as fatal. The corresponding irq_dispose_mapping()
> calls in the probe error path and remove function are removed.
>
> The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
> device_node rather than the platform device's of_node, so it is not
> converted here.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 98d02809ade5..08a8090178f8 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1239,7 +1239,16 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
> -	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> +	fdev->irq = platform_get_irq_optional(op, 0);
> +	if (fdev->irq < 0) {
> +		if (fdev->irq != -ENXIO) {
> +			err = fdev->irq;
> +			iounmap(fdev->regs);
> +			kfree(fdev);

should goto below error label

Frank
> +			return err;
> +		}
> +		fdev->irq = 0;
> +	}
>
>  	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
> @@ -1301,7 +1310,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
>  	iounmap(fdev->regs);
>  out_free:
>  	kfree(fdev);
> @@ -1323,7 +1331,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -	irq_dispose_mapping(fdev->irq);
>
>  	iounmap(fdev->regs);
>  	kfree(fdev);
> --
> 2.54.0
>

