Return-Path: <dmaengine+bounces-9112-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLHtB6Vtn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9112-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:46:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9819DFB9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B726E3138F5F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B8318ECD;
	Wed, 25 Feb 2026 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J2K1UuMd"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A6318139;
	Wed, 25 Feb 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055742; cv=fail; b=VLfroRT2HDFXVf2N+3M65hLKoiYayux7emCmTI7ehhjC1DO6rPILrifATAOzp+iVujfZrI3UifKRQO1NZDnMYIpx1bQxeCx2J/RxOyOE6dHQuB0T5VH0w66S3ze9oP8LioNsgwStQq7CmRNCadqg7gI00ISR+B06YCIir79GvLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055742; c=relaxed/simple;
	bh=apHkQQl+djGg1tnK1vukz6SD3mrQAzdl6jgDbv5Ej3U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VYiPYdrD9X9hIOZiK4gv5vwKAT4ML9+gaeik5DLNsg7vwhddm/Oba5HvIQ4Vae/cbZh3+vbwjQU20XeCGqLVIBanQTMxAmVnVgj+l/QAegX1+I7TMjmsFwE2WuLKeXRtTDxWLSThfiLGc0QP4lbl667hBnteHb0Lwn7NALttn3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J2K1UuMd; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ1eGv4EVKR6YsETFjKeZsjQLjbDJavW+cK/9hQlEvVi4GP8XrgGtNl9jU31gK+vJGYJr4i3PI6gkwLbSx7pVLqu6m+wAPUxgWgT/317vv1czDVBz7G5A3RHtj+YQbhbC/0d8bwj8htFEdBGutVMm4LaLTTssAMaSDTaqFX9JB+sYgqsReIMi+Z7mh9nsJ/HV7UXKyqMMr4WseOfLVKdeLGtt7NI9wct5Vvb1HFqwb3H7011GpvgGVyZzQ+a57htdKImcYfL8fLbWRVmb989c6O8C7lNj87oWysy2fhI6q4KpvhNY79SE82d6oj7WxeRPOF6oRSxsw2FngQtK4k8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f3Xl10sUcv5NrivbasFl6ywrrwJuG/QqMrkUnqU5X8=;
 b=V1167JmiuMyEHwdF2FTnGBo1CEYxR1X4tc3QtAZ0MC4U37HFp80XK9GZ5S3twBALePf1r9mRNaeDa2PosA8Eg+Ksdgtoej96VD+jWXe7r56XRBSYLKL2AHiozyeZCNfd+RTT6qiWqPv5uy/GfA1TowG2kOxRX2aHl2hM9lnw3HWX0Pb8dFM9qEZhWYx7ZIa+IkFnnj7cVzys3fSZScpbc+fUedf5ywmppk5Or3NZ+N0nC7iNO5RVx4EBYZK12dCS/Tbk8W8H1ukgsMiukusYc+7iFx78Bpfw9Yx6IgxAcCq5TRft0OJMEmPu1gqZc6778JcNXOQmWE14fIPudU8oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f3Xl10sUcv5NrivbasFl6ywrrwJuG/QqMrkUnqU5X8=;
 b=J2K1UuMdHF+ZBinqAoYO9DWuHcabuH9Hrv7qrhxN7I4JJ8bRwzh4YW7PxP6MQzkr8hf7w70Q/eMgWyywCEPG4ACfVrCBzSLmbQgPiG0SnqVjIVdgHoQwLRe7Qr6UynXLUFpTWM29gvKI5h3DEb6DnZhGyBF7WPYWzJFWluhb5iAia9AegIwKFXyD5FEYmeXFBDjBce/wZs5X9k7RW1QrElS7onrkm+M0mV5MVOX8FCxcS56EcVpPxVKmJ1NBwsgLRv4bT9CeRhmRpgl5wZBsmiQ8gc7kONu0ArSmYeaPpM72eTJqsbeiWTlLAI7KM9BLrjwkjr+yxQeG2ir1f2UxpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:44 -0500
Subject: [PATCH v3 08/13] dmaengine: imx-sdma: Use devm_clk_get_prepared()
 to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-8-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=2209;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=apHkQQl+djGg1tnK1vukz6SD3mrQAzdl6jgDbv5Ej3U=;
 b=HX7zQFjW0S9HGC3QDEMQr+NUXE9mrDKupwuDjMYcSzmhoYSZ+ZYuSb1rSJFIgDgAaRyKvYQjL
 CUir8P/e3zhAaK2zoVP7FFWDvO0Og5I9q8pDtgxjqOr0ifWcsuUjNjn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f9c174-5e8d-4279-6c25-08de74b6c02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	jpQZuw+21XEl5sqgL6lJbczh/iqyP8aMOVPRS3jp4Hd2jB8zuS7gp1+v2+PRV76HxJnEDLJ4zM4xhUVZlXCFGxxEuGAtGl8gMaPPUvjHW+LOpTjB997on2pCSyYUCJcS8+i05w8h6jH/K69ZQSawP3fARf1nOaBRcbdgCEMtRUY8SHPCBQmtXEEvzG6HVMcGZlNClWSppWH67ayJQrHs3X/5zNhOSqKXPM+ZLnFoIIW+NBIcPUETPl77IPaJzXtZMKRGU0gpUUzXHDsj0m3XuCzebfOpbZe39mY+6LsHDNPr3O3dPVI24depnp/UuvfdRZ49GgQNo5xhX80CeWbSBspdxMduGEFvtxhxAdNVx2jB8KNu3ctMtwNfr0lTIUmmCA9KMnnsD7v0/RBnglFMf1LhkhkEFA4j9wIhJLm+hWfRpFFzF0FMzQ57mn+6sGohjXH33zzsHPt7E51EhphTJOfW8yu5QNrmXT2t4Sf7Jr+O5TAhaW18cS0lxxv2JTIWQ3olAmYGEMoe05QcSfHlciqRwG9Ws9Dg3TtEfU0pc3LdX89Y93s5qT1JSF/biCC/LMGgjxGNhSw57naPg40LFKj/G7GGnfdQUdTcKcn7Shs4S68rz/Jqpkg23FHdajzhn5De/ZXQb0ojSPbTwqlk5YGpdprGW8tSECyz/05Q5irOL76AHpJqSTUst3+ajddyvrG53uGIBLMq54LhzyFMxgEDM62bCs751DdZzsNZj6jDm/wSIUKHDT3GW1YtzRx0i12GzTgh24xF83qgSlciH+SnpgkiQz0T/6WAtpWdSPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWZBN3lTM2RpVjJsdzYvMzNzaGhVTEhXdTExR21ZRXVmZW0rZHFLYVJSaGZE?=
 =?utf-8?B?cWdzU3kyd3FmN1pyU0R2RDIrbysyTmZTclpPSUJqY0I2Wmx5ZW91U2g2NytW?=
 =?utf-8?B?RExVZEFRZ1kwOEtYSnhLQmhDVUNhYklSZnp1SUNNUW00S0N5Y0UwbTFLZ3VW?=
 =?utf-8?B?bVNnakp0MjdhKytUeitZOUk1YkY1QXNaMHZqWXpFSUx2aVo1WGdreFFRWmdY?=
 =?utf-8?B?Z041ZDZEYWtGYmw2am5WLzh0QU1FbFRnY1dRYmcwS3RrZC80T0hXZEQ2RWU1?=
 =?utf-8?B?a3BjQlQzT1lUeFY4ZFlHUUNrWU5FVjIvajIyT0Z2M1Z3RkNPbGJjdERBa21x?=
 =?utf-8?B?VTFQTTdkaG1UL01VaFhFN1l4cjYvWTJMSGRSbkRrVHdEYVJZMHZhYjk0VXpx?=
 =?utf-8?B?d01HVStRekFoS3JQNVF2alVGTjNpMHlUK3U3UUdYU2FUeUdXbjZqVXlLb0Ew?=
 =?utf-8?B?YkVJVXNncXl0QVVMU3gxTmd5cHRRNWg2TXlSeURXRXlrd3FHdCt2ZjJWeUFk?=
 =?utf-8?B?TUFvSDVtRlplYmxKNXo0UjdUTDFTNllRdzhYM1IycWNrdG9pK1kvQlMrME1D?=
 =?utf-8?B?WlIzM2p3bFF1TG9KbXA2cHRkakxzSGQwR0FJcEVtWmRTdEdOMWVKRGtlWDc5?=
 =?utf-8?B?akx4SWJnYzJ3MWFjVFRLSGh4dnVBbllRRDF3Vzk0aXpIak5zTW9XZC9tOW5a?=
 =?utf-8?B?VEdSZEszVVZZVWIrSDNsYWVkNktkM2dFNnk0Q1RxaWtwZ1FXejhxcjZlczM2?=
 =?utf-8?B?NXFway85VFNYUVAweDNRQU1kSzNCejZ5bjI3eWhncEVHZ1lLSzdyYW8renov?=
 =?utf-8?B?OWNQM3p2dll3RTV6T09zVHlzbEpsM2NqaFZLKzJSQ2VtZExaM2dkS3ZHTCtT?=
 =?utf-8?B?T3lZMGovV0dNK0J4VEgva0tWQUZwdHBTUEtkRjhKcVVSZmVYakRveXpoNnRz?=
 =?utf-8?B?ajBFR0NDcXFQV2VZcDNrbmcxc29TM1FqMnFVK2xPZDAvdzRZazB0Z0c5QXNZ?=
 =?utf-8?B?RCtDQkQ4VFJsRjdDWW5uRWNWTHlrSjI5VHpGckxEdFdYbzlSVTN3VXQrbXNN?=
 =?utf-8?B?ZDg5LzVEVlRQOWk1VWhrakExdkhrOGtseDNRTlU5U0sxMldqOUJRaXJWeWVk?=
 =?utf-8?B?ZVFwUzF5VWFJQThyQVI5bDhYYTBqdGtMSGFQVlM0L3NhQk01WWs5VWNzZHhi?=
 =?utf-8?B?dW9yM3VYeEM2UlFQb1NIYk8vMTQ2RTh6ZktQakdxb3FkbkpTSmRzZGVUdWZ0?=
 =?utf-8?B?bDZHVjVFTFA3a2ZzZlZrZ0pZMmtuZXkrR3BiREU3NDlpVmNoeDlXMFp2YzdF?=
 =?utf-8?B?V2hIbEhQS3RJa0dmOHh1N25RM0JPanB3RWp6bEN2RkVtdnpHRWs5eVBzU2pv?=
 =?utf-8?B?d2ZuSStvanU2d3hoTS81M1RYWG5tQ3Y3MWJvbUNITDRkM3o1QlFqSHRLQVVj?=
 =?utf-8?B?SUw0WDlxWmh2bGpDazlENnhYT29RUjloVXR0NWJpYkNHTFVPUzNKRCtmbVdZ?=
 =?utf-8?B?WWduZTFiMEdzWWkvU3BjSWttcHg1VmcyOUcyVUFnODV3S3grWk5nSUlST2lw?=
 =?utf-8?B?bU1wQWk0RkZ2bk1SYlhoQWFVMkxYMCsvd2ZWYXY0aVZndlVwajFXQy9oYnRZ?=
 =?utf-8?B?b1pVdjVtVFI5YlNiNit4eGM3MGtQT0cxWWNXdEhMTlY2RU5IUFE4MU11ckNJ?=
 =?utf-8?B?aEV2emVGeXlRaTEwNnZtYTM3ZDUwNG5OVEh6UlN6czNnb2pWZUI0Y214VXB3?=
 =?utf-8?B?cXpmS3BzSW9NY0FONEdpWnl6ZHVET1ZVK3FPcEh4V1ZhOThidm1WTUU2R3Ry?=
 =?utf-8?B?dEJNbVd3S3lvVFFHc0RtYjQ2Z0RxMWV3djdUSjRjcnRBRklTdU9IWmlvU1FR?=
 =?utf-8?B?d2UvQWpYTUtOVzdIK0hjNEdsd1k0RHlqWUgvSnBvZldoZkFYUnFjNUQyelZa?=
 =?utf-8?B?M3RLZVErSVJONkxRRi94ZlQ5WHVlRHU4OTR3bW5ZeEhYQUVOWmowZkZNS3NV?=
 =?utf-8?B?dHM0Qmd4NlRTMThlTG1sL1BzeDVoV1ZOc2FFRytaV3p3czFyNUhRbmVmZVE0?=
 =?utf-8?B?UHliWi80eENxa3BEUnRXeDg0cGZZb2gyazhCZnJ2eDlMUnJPNkc2RDFKZHFJ?=
 =?utf-8?B?R2FFZldPU2ZUc1R3QjZjbUExZ0lhWXdyRm81VGdQM0pMVk5ObnZRcHltSis0?=
 =?utf-8?B?WVpZakl6V2VVMkhVZjRPNlo1eGVtdVcwQUFqYkhqUlRLSXNpUFo5dkF5Y3JR?=
 =?utf-8?B?S0xpUy91eVpjOEg2eUlrcjBCWUJTQkZLWTlHaS9NL0xXekZqWG5DZ29LTFRx?=
 =?utf-8?B?NXl6Q0pNaWlRSHRqdzk0MzMxS2lNT3hEOTdpSC9WQ2ZBbnUvdWJJdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f9c174-5e8d-4279-6c25-08de74b6c02e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:19.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8me/268nfkvq03zvDs9zTKXbQiTm4D5G6d5njcIJNRWDcfqcPei2XtgKN/Mtcxapt8GpnEYDo7/5Q+hXaAuhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9112-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: B1D9819DFB9
X-Rspamd-Action: no action

Use devm_clk_get_prepared() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4c8196d78001201bd354bbdb8057440eae625030..187e8e573fdf437a0d614548f1aa777a0ba3e24d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2265,34 +2265,24 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get_prepared(&pdev->dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get_prepared(&pdev->dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	ret = clk_prepare(sdma->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare(sdma->clk_ahb);
-	if (ret)
-		goto err_clk;
-
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
 				dev_name(&pdev->dev), sdma);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc_obj(*sdma->script_addrs);
-	if (!sdma->script_addrs) {
-		ret = -ENOMEM;
-		goto err_irq;
-	}
+	if (!sdma->script_addrs)
+		return -ENOMEM;
 
 	/* initially no scripts available */
 	saddr_arr = (s32 *)sdma->script_addrs;
@@ -2406,10 +2396,6 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
-err_irq:
-	clk_unprepare(sdma->clk_ahb);
-err_clk:
-	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -2421,8 +2407,6 @@ static void sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
-	clk_unprepare(sdma->clk_ahb);
-	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];

-- 
2.43.0


