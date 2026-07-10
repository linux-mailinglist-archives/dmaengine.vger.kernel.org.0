Return-Path: <dmaengine+bounces-12320-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HFD+MXwPUWpT+wIAu9opvQ
	(envelope-from <dmaengine+bounces-12320-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:27:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBF73C3A7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=jp+cbW4S;
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12320-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12320-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B98430097EA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1D362152;
	Fri, 10 Jul 2026 15:22:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB033BBC5
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 15:22:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696936; cv=fail; b=VxOpGSZSmkhkvKAI1UISFV05oBYjN+PTdad0GqF0UgomVFNX5SEQzM+kvj3aOVW9ujX+c4xaMGePpEiix7Bv4NjdrZBTXpTL6WQ2RJ69RWwQIdFgHV7pgZv4tseCw8MeOgNDp51BtrSuCLLXVec+YCiVfZQ1hQEaTw9BJTWJ5EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696936; c=relaxed/simple;
	bh=sDavUdrSfMJTseT8aL00Tm+l89izW7JpvvLtLomiZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0HtqduE6fcC+Wr9fB1EsBhWvIVa0gvhB4IfKdoTU2Uo9EULT6s3reBVjBBhXqsT85xclmFtyURzywT6bHgwG1xgcMazhCxcjKqvrJ1tvxwUXpqA5Aywbhj/y3l/oGZXCr4+i6NJhIlA05KYyCCLUK4j2NnCTBXcl7yhnStUtb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jp+cbW4S reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGh3dfF3CcKTQyU4Ttdd1FJsi6mecWpkka9jARHipfNaw7BrUzzs/ABQDHVhi5xdUlI64eIxfkUej8rrIl1mMgKXwpp8kKpqsnbyfn1P78P/MP1Zt03QA80KogMqfPEIM+5B3BJlLcoe8QoGq3Ik8zq5SXXg2Zl2mgObCuFcVf2H0dps3Uwe++D8kiixwO0+ZIitrKZB4l84J2Yvbgp8QXhtPW96vhT101Rj4d0xkrSs+4mNjC3l2otj8yk82a99u+sO7Jamvcnva7YumaX77BC+9toIzeaCFEelzlHGFucjsNg8INRveH1GLIIn59HVIpom5f5WWsobG1ET+6IbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7J6NAzQ1KbGL3WPcLaxVG+d+cxmpMxYJNQ8ryd1JUI=;
 b=KYRx6Yyz34Wvo6hkmX3LEJyzf4Vv9PFY0OwRUKZm+hDKcFGwjOzI88ejmbeOaDYbJrhzQDfw0Y6k/oCQxv4DtehNcLGdOkazft9b9xRbJzJ4amahT76Kx0NQRYYQCsDHQ6uPqQLfgvo3gHtbDs5y1SUx65MlDSmuf8C0cTTU6XGDAxqJIX8a2DZHWT4eV26ShXt5GWLgmId7bdPveUihDcIakLt/Hz0Dr6PDKrtjUUKoS71ojuxTzXPBJXYARe9lxM0LUdOlZjH88qAJlI+J2MbRHCzRYflzw4hFBU4WV2R/NyB0U05oOJAZC/36eRCFMQZEFl8MvA4z/P22SuZsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7J6NAzQ1KbGL3WPcLaxVG+d+cxmpMxYJNQ8ryd1JUI=;
 b=jp+cbW4SbYSh5Jy+ExXyfc3I7QA60+xRcVW0Zb2k+Gfn3WTU2/xnVvkxlE5AUVLZH3tDLfteTXL3PUUU6uNaEyxlKxmlbNA+4CGFy7/zj+/kgDEsPqCvF5Wf4/ypGJVgm/y8x6Wth/aF5nB2ZgD8G5iZajo6goYxpsJGQ8Xaf65wiD7KG1mgds6ppQYnOv3xbQL7qmWX2xbFfIWwIqLn6fTANDbqdvSSHS3NPPsPnS+24RoMFmrtGNCY3/39iV0akfQIySrNeInyEsYB2+dpPbHP0W6iV4PThHGSap2rhBrFQTacl5vSXbZJIswkpwfDtsacgSZRx+bYgcNDZIbokg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 15:22:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:22:12 +0000
Date: Fri, 10 Jul 2026 10:22:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <alEOHECW4JWja9bm@SMW015318>
References: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
 <20260710-fsl-edma-dyn-sg-v6-2-831b96be3f31@bootlin.com>
 <20260710122206.E38231F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710122206.E38231F00A3A@smtp.kernel.org>
X-ClientProxiedBy: PH8PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e2fa82-582a-43c9-6579-08dede9703bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3fujMZQW72jLoRRjd7Us6cqIKWA5qhvBW1CZi89ezLS9yUejimAHYhUpiUiNtK7AWr2mn5duYXisHxiIx6090PmPFs3FntyMB/zLLniF2QNUadZxaxDvgeMgnGQelcJFlmIvBjSdOThcAxPVyNt+Cshbw97Zr72HRTpcqYnMUQug+poY+zpC9MPFNxYswLabZh6Dk7SYbvp9vWt3oD/1mc1uQj09fNNoes59w0MmgYZwfTZRbppRANAwcPGx05V3bPbmHqltt1RLlnVa00B619zgbChNlVdQe273OdGXkL1Aew5+tCdnNhUSIzHV5RMi5b2HoWHuOpg+r1MPFca2oMdprXX0zn3VSEgvMy3K6L+O7FN3wfWjbcjrBNSaTdh0LRpPrAEAxqB7ZMncFBDJHVknHjDwi5vtLs1RSQAsHGOnYe2AkCxAP5O2m91uqtScO2qt6Tn0vanLhs4zw9Wy8h0xPxjHeD8ZPEQGWoiRLABBeKDgiQj1To1MUY3/VxDtoqbgWHn73XRwZPY6lDaMTZ1IFTzP6nI4a7oyy5cGTIpyWewFrDLHOFUHsxWzMPs9jeDLmIl2jkWTYxGaElg3QepjqXbBKGdkwY5jpo+nZYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?yy8VtNjS0eDPzpbu3WBA5aRnitY+Hvvxx0bbFvfOoaQ2tiy4RCk+KtsfUJ?=
 =?iso-8859-1?Q?GAH3dY6Dn+Q4pw+fwxX4Fn/gRN7+pEBOXhykw6/vBoUNvaoHoELdxpsH75?=
 =?iso-8859-1?Q?N3gPfBDzbpbB3T88TZpMXNsBDyKN2QMYxjI3f9nkSG0l4K1kpdbJmF59ae?=
 =?iso-8859-1?Q?kCqq12Pbqr7LXs+gJZLDRsFOehqVXLQ02et1BNHH8XD0r2j+rY1Y+PirLC?=
 =?iso-8859-1?Q?w72waAMdqIby78gUDqhivcP2fLO/G/TP2AlqbLmpvT2k2ZTqB4LaDUB9/k?=
 =?iso-8859-1?Q?ZKvfg8f0+GIHBvkDqif0nNFXbV+MaKU31+1T3qLtiLduN6OHWBy40Glt62?=
 =?iso-8859-1?Q?uP5VUml4TWuqSVAdDeSxYZOHuZW7zN+VKBgHBmg71TlJzcXsltzr3ygcnK?=
 =?iso-8859-1?Q?YX/HudmoU5Dubda/tNjDO7xa34Cs/Akic/Ilxfii09X7Un5Njdrn/jayQu?=
 =?iso-8859-1?Q?bPqj5/win6jQuV4EzYZ/f63OZUxMtBNPKpwU2cZAYqBAVUpxv8ICl4eAdW?=
 =?iso-8859-1?Q?mvk8cFJjTq9ZdoUCHy9EZcZPubnMLn2RDvEp5+QYqLYSHbcR8AcWB/VE1e?=
 =?iso-8859-1?Q?k02yiPynSPX5W7U+obQTBOUrcAg4h0VwKpw1aaxo5kt7rm+2VVHyfdx3uk?=
 =?iso-8859-1?Q?4dmGZaFKjGAL+L7Wmz/nX+Uu8jaPGv1ENtWHKwe07Zc8VOv1fFJmyyY/GK?=
 =?iso-8859-1?Q?gi8cFVH2tUMYl9OIsH0HNK4bn4EY7uV6vzB+7c/0TK/1ZNDjiKnE24AxZe?=
 =?iso-8859-1?Q?jKqMg2LAj6JychPilpW2UfrNIy95MNZ00z0wwwAdPh6VOjy4zRM2TEb8UW?=
 =?iso-8859-1?Q?GPoIo1wBgjsvW2STYp1Bdv6Kt5DjIiapTkzb8RcfIKrOb5WCvZvPOyp7d9?=
 =?iso-8859-1?Q?9zr3SdIOUIG/uy8i70PeMtiRI5350D8oZlGEqgq2rZ6yaSBah5KnY5Im1Q?=
 =?iso-8859-1?Q?Wta9SYdO2LzJCgeEirD4Z/4ZtVFcX74FKFwdbk0eUD1MUYWe4yJD3iq3JN?=
 =?iso-8859-1?Q?jdETCCeun5yde+iBZP5/6r9bwa+e5xh5wQh7zazqkghLdgkgPNvWsq3Yfk?=
 =?iso-8859-1?Q?E9GfVZGEDDjlbxOHLK7fRuDkscW3kIW5dmrL432EGeKTXozJaYyE9wwCHZ?=
 =?iso-8859-1?Q?GoOxD2e3JwDfWVVnirbTTrS282zbMrvahTiNVSuPCN3YyatnL8QBOnBY5e?=
 =?iso-8859-1?Q?srFOMDaSoMxrALcgKdSOhIfxHtuj2+ALU0dindKPffnYNF5UchRN0ql+qp?=
 =?iso-8859-1?Q?6RAfKJoT2NhXY1PrO5CE42e4cMe5wGDWm9Di32/agB7L9f1/HWwCTDBjGL?=
 =?iso-8859-1?Q?UZniMuyuk20CD1Y1Ei4DC+UpANlPWInCGRFcD9hJ1TIwI2aLAHJ6kK5A24?=
 =?iso-8859-1?Q?N8GiK4F5NVLq1DCGlLAwsq3DlKScAcFEn5CNE17vhOD+p5wo3whZ7ntIlD?=
 =?iso-8859-1?Q?v7esPUGBobz24qsVNqpTKVocCp9vtyULA2jbq67Ys5MtlvzwKDMlEEgNzk?=
 =?iso-8859-1?Q?17qByiasVWFysMcYtiKvVfGL8hZA8GI1ipKyTasNz0xnfSjxcZ+OpquXnb?=
 =?iso-8859-1?Q?rG+TjzyxWr5ht6OsXJYCsHqDaQ5r8vR2xukRcGCsdqFODIeBq44Pl9ot+i?=
 =?iso-8859-1?Q?l8IhEhBNplBUScSYcy9YFQDS9ivZD/u8w5SKS1euah8PtUfWMmM7iun+Kb?=
 =?iso-8859-1?Q?x6stzlIlPJxC4mT+Rh1sXjHScv0YKwinsK24D2Ms2EgUDgVxgZlGjEdEQO?=
 =?iso-8859-1?Q?XNll1YEvDPL7+EDpHnpx4OXnmLVjCJeGPR7ghr5T0EFPSh0i5d+J1WbVzT?=
 =?iso-8859-1?Q?MXCgFUir+H8lFGGvOfVv/mQqGFV+TP7O/nYScHjZmwHm+U8PygvG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e2fa82-582a-43c9-6579-08dede9703bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:22:12.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw5/cN4o9SmUL9UofBGp5vzJuT1QJ/cIZLfCMN8N8s6GpJuHCjFhz674wedG1yZQcn1BvbaqyYtcqZml5zPlWVWsmrMy9YK1Q3sWpDVm4iB0aPFUpK4/JmdQOmtVz0TC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12320-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:benoit.monin@bootlin.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FBBF73C3A7

On Fri, Jul 10, 2026 at 12:22:06PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Dynamically linked descriptors are incorrectly re-executed if the hardware completes the entire scatter/gather chain before the interrupt handler runs.
> - [Critical] Dynamic scatter/gather chaining loses the `link_sg_id` on multi-TCD descriptors, causing the interrupt handler to incorrectly reap actively executing descriptors.
> --

Overall is good, please check above sashiko report issues

Frank

>
> --- Patch [2]: [PATCH v6 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather chaining ---
> commit 7b2e56fb9781985df561a9463fc3de1f384eab25
> Author: Benoît Monin <benoit.monin@bootlin.com>
>
> dmaengine: fsl-edma: Support dynamic scatter/gather chaining
>
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> > index c10190164926a..6cca5dca8d60a 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -58,11 +61,29 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
> >  		list_del(&fsl_chan->edesc->vdesc.node);
> >  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
> >  		fsl_chan->edesc = NULL;
> > -		fsl_chan->status = DMA_COMPLETE;
> > +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> > +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> > +			fsl_chan->status = DMA_COMPLETE;
> > +		}
> >  	} else {
> >  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
> >  	}
> >
> > +	if (!fsl_chan->edesc && fsl_chan->status != DMA_COMPLETE) {
>
> [Severity: Critical]
> If the hardware completes the entire scatter/gather chain before the interrupt
> handler runs, fsl_chan->status will be set to DMA_COMPLETE above.
>
> Does this condition then cause the handler to entirely skip reaping the
> completed intermediate descriptors?
>
> > +		u8 link_sg_id = FIELD_GET(EDMA_TCD_CSR_LINKCH, edma_read_tcdreg(fsl_chan, csr));
> > +		struct virt_dma_desc *vdesc, *tmp;
> > +
> > +		list_for_each_entry_safe(vdesc, tmp, &fsl_chan->vchan.desc_issued, node) {
> > +			struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vdesc);
> > +
> > +			if (link_sg_id == fsl_desc->link_sg_id)
> > +				break;
> > +
> > +			list_del(&vdesc->node);
> > +			vchan_cookie_complete(vdesc);
> > +		}
> > +	}
> > +
> >  	if (!fsl_chan->edesc)
> >  		fsl_edma_xfer_desc(fsl_chan);
>
> [Severity: Critical]
> If the intermediate descriptors are not reaped because fsl_chan->status is
> DMA_COMPLETE, will fsl_edma_xfer_desc() pop those already-finished descriptors
> from the desc_issued list and re-submit them, causing duplicate I/O execution?
>
> [ ... ]
>
> > @@ -924,14 +945,74 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
> [ ... ]
> > +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
> > +{
> [ ... ]
> > +	first_csr |= FIELD_PREP(EDMA_TCD_CSR_LINKCH, fsl_chan->link_sg_id++);
> > +	fsl_edma_set_tcd_to_le(fsl_chan, first_tcd, first_csr, csr);
> > +	fsl_desc->link_sg_id = FIELD_GET(EDMA_TCD_CSR_LINKCH, first_csr);
>
> [Severity: Critical]
> This embedded link_sg_id appears to only be set on the first TCD of the
> descriptor.
>
> If fsl_desc has multiple TCDs, when the hardware progresses to the second TCD,
> will it load a link_sg_id of 0?
>
> If an interrupt fires while the second TCD is active, would
> fsl_edma_tx_chan_handler() read the hardware CSR as 0 and mistakenly reap the
> actively executing descriptor since it won't match fsl_desc->link_sg_id?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com?part=2

