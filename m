Return-Path: <dmaengine+bounces-8264-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E32FD2199C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A397301645B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297F3B8BA8;
	Wed, 14 Jan 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H74OJawc"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558F3AEF30;
	Wed, 14 Jan 2026 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430096; cv=fail; b=BQKqZUL9Y8ESuu94zvHUgdTonIROy1SUzH1PLDGpQGAtH/NkFQMkTsPm35Zxjg75O0+KCcvuFAOyM+rVDTJevjpst+rHOs4HrZWVN7ab2tfot7JyTK1HewZ0wJ/n4fcO0Pv+EcAUPUz923DDYK7PHLG+hZ+PH9p070Kxzz32FU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430096; c=relaxed/simple;
	bh=21acKHcUXVlPMxacbQqXbX1vyZkf2kl/iSPe+XoSPec=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UX9P9rj0QxfGHt32NTGIAXHkRwi2GTSHv9smQSeRK5QRmmRFI5DIJKu4jLUt1rKbsCqyqoaDxvIAYR69BkOWM47wJhWeR3NVOcww5c7Zn4FXgSxAA1FE5QSHEqxqHw8nEcxFnKEeF4PvH1V9mfNgu8uOzW3JLKkIP0X1FpAaO5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H74OJawc; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCjOVKpyI41h/5g8OiVQBh2WChueJ/SK/RP6ucBEP/aIIpIA0KQd23uuWkrckg2mZveAZq+l1maQUo8dNhhw5E7RYcnX8bCEn35NkFlvvzse5hq6L8iVV0dwmX+rNaDya5vq7rvGYJlBmVNISIqg6Ff9F0khvsLLEs4BmGFKpa049sMRoQdTruaR6ebUhYgcMgk/FgZUvaeahHaDM2FW54uI3g37bTfVeWEN3/lR+vtWiGrt8UdTKtqLX0JUj8LJOPGKXmu6FVwWkvGoqJWxaX3ROaqChbA2DCDGVrj9TmwmZm23NUWjyS4x572bUinOq2JxsX9vQEmfksHXb7cxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS97WSUBknWNAKTkbFQQbFes3npT1babZw9y8vo6ejc=;
 b=LaJu8v1PNIaHayLwdj6f2E2j4tyndHHO/6FXGPCjs/tfx5TeQJ3nTX+9Axv6Fk9q+nKieG7P/FsUfjlRV7qsPoStpcq9CwFauv2iiJUlW/pHBSIC+j8wjD3sApTQZVm4a7JDhDlUDjWS/+6O0+SmSlS5hJMuQqnJ9vCe3h4kUxJtOLYKxwn57Eo6q5I0BoWbOrVyJ5yODACSTto3b2McMArn0B/OF8w/Vxj1/9llPDiKz+0QJYkikRbMpafkFmspAvRdK/CYviHbWAcN+qxOzOX7C3r3lrYXfvzuxPIj4r43fYdSwtXmqXWXxRq6P+BcRn1H+UO3o2HeL2OjhL7CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS97WSUBknWNAKTkbFQQbFes3npT1babZw9y8vo6ejc=;
 b=H74OJawc8O+ok5hCamda4WzvgtyZrdP4ueqjGVcUO49q86g3VhdoM1rGb4oZS5dF7G9NSKMaaQU90sXZaDfWZBPcwpDKHMGkByZuxIBX8Vng/4lnCJqsG8ga5yQFYNVBkxjoATyY/sZDmJVlzLRwgNSSuHy/OlsgCZVmVGrX4mA4mKempC/2LKkvXBu3NzUrkgwQovCU0Ov1h7KjJQdBe3tdWIJ5JJSOhi+ZYWVVoIbu4PRMtJuSRh922JClFfsWKKhtwObi7kpCVkyzzQ44gFba5BPzwYKaeJII+KKOsztO8fC2ltgPUDe052JZMk+hF5qIuflw3e4uBGZGTy9O9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:22 -0500
Subject: [PATCH 10/13] dmaengine: imx-sdma: Use devm_clk_get_prepared() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-10-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=2225;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=21acKHcUXVlPMxacbQqXbX1vyZkf2kl/iSPe+XoSPec=;
 b=cwe9Sy6Ap6bqFSaH5e/csn2BMTEID4usThz6sWIQK/yiegonvpZ+OqnqM51IWDoyTxPAY7X1h
 1xzNgB+mDJsDm76V5shBXXI2NWyNMctxQrXkaEWG2vY8I0xZ4j7FTGc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 03aab890-3227-423c-6cbc-08de53bd0e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NvUEFBVGpTU1NNRVN4dVdJYVFmNDUxVno2dG4zdU5SbVVDTHpXeGhKZlNM?=
 =?utf-8?B?REZRTkxHVHptWXJnUUZwUDNuRExZR3NjQjhqSGJNNjhMUjQzdmpjaFJ6LzVV?=
 =?utf-8?B?MWIxbXMrQTZZeHZJRTdYVUQwNEhvU3lhVHFtS2tubU1icDVRdTdsUmlFaGE5?=
 =?utf-8?B?aWw3bld5YW1zVjV3V2N3MytWOFRtMllYOFE4MDNFeFljdkJUajNVOVFFYkZQ?=
 =?utf-8?B?VWRMcjNNa3ZaSWkvTjRhOE5kaUZwbW1sUi85b1RVUzZoTXJHY0JaV2t0dXJr?=
 =?utf-8?B?emx4RkxNcUZBWFZ6TmF3a1hMNVV1bnd4MnBtenpORDc5OVEyd25BWHQ3YnVt?=
 =?utf-8?B?b3hhRlBGY3BUdU9MencraktKZjU3YTBQYjJ1SWNacFRJcERzWTVzaDd2VWpr?=
 =?utf-8?B?a2Z0Wm51VGRmVGQvQVpSRDdieS8xdXdBcWo3UkhZVmJiOHBPRFhsRnRHckdR?=
 =?utf-8?B?b0c5M1o2b0N6L3JaNXUvaFVxTjJoa0t3cEVySDBLZ1BuRnZ4WTYzRkhuKzg0?=
 =?utf-8?B?MVRwa1JldHByUzQzS0hLa2NNcGgwV2lMVG83clBUZDhkTmJaVFRsdlNrdE8x?=
 =?utf-8?B?WWorZHJWa0RXcFI0ZjFUdmp3dDFVdzh6QnB0UjBZY29tTXV0TllpQW5RdVRT?=
 =?utf-8?B?WjRNNTEySlVSc1RJNkFsOTlsdzd2Qkh1eE5ZWWJFTHp4eFpKMEZ6c0RZbFFl?=
 =?utf-8?B?VHVqbzJ1aUJ3ZTA5VU1GbUc0V1g1RVVnUTUzSStNNjArWW80NHR3YmQrY0Jp?=
 =?utf-8?B?dDNjUEpJSHlaWnB4ZE5NaWFqenBZemVWZ0VHcEZXMDNSM0ZhSWZkS1RSRHhH?=
 =?utf-8?B?K0JPaXRWVTFFWForeERkb1RvVmxGV2ovY2lpWWtkNklKcndFRlJSSVB1ODFq?=
 =?utf-8?B?akwyUHc0UkdFcXRhdXBvQThib2pQenM3WHZKamRJSTNYdFdCcDhUQU9KdzZH?=
 =?utf-8?B?SkNXZEtFQUxERzdCa2xod0xCN0hmYnByWUVJaGtQVFd3TnhSTTlNQ0U5Rm1F?=
 =?utf-8?B?bjhIUGJHR3FLdmRMNS9YaGk5dTNXTEFkbDIxNkVtZUJYSklKRkgrUDRyZUQ0?=
 =?utf-8?B?RVRIbDVOTUxqUGhlK3NENlpSSVFsMGdvU1VDTEVnL1dqR0gxL0xPcVUyb3JL?=
 =?utf-8?B?ZW5sOFVUbklyb1ZvRWZwZE5YdVE5a2hFTEJOMkZZZS8xamxGam8xNUN4VzEz?=
 =?utf-8?B?eHNKSitzaEZYZGs2Y0dqMjdBc3E2bWphaVl3dnFWTUJDSFVkN3NVTlRkUFR2?=
 =?utf-8?B?c2h4NFNGUVFwS1hJUkZhWVA4b2hndDhNSW9EMDMvMkxQLytzTElBb1NFS3hD?=
 =?utf-8?B?VXhrR01qMmtWU1VsUnpPTDJHTmR2SjQwU0packRtUml5clVybklUclhyYlht?=
 =?utf-8?B?TVlJWlpEMWlGL3hLOUZhajlLc0l4cHhhY0lrS3N4YTEvSjlHNlM4dEl6R3pN?=
 =?utf-8?B?WVBjRkp6b05FN1YyRmRRSFFUcUZsVkc3Sk9Zak1wS05SR2dibTFBNHBQM2o1?=
 =?utf-8?B?U0o3SGV6TVpYWW9za09wT0hnUGdWNzJhK2doMVVNMkVWL1NXUHFMS2FhMGxM?=
 =?utf-8?B?Y0JTVFE5c1cyeXRDeXU0SkExOEJNLzZ2RHMrZjUzVFZid2p4cTVHZDBrdzFH?=
 =?utf-8?B?WGFIVnEvK01naTQyYmF4QlZjR1pqNWxiZ3ZsSjRjclFnVzV0K1IyelVuZ2VO?=
 =?utf-8?B?VTFXa1NaN3Q0YkovdFAzbkpORVlzdzRORC9HZEdLS25rQ2NIay9jY3BnRjM2?=
 =?utf-8?B?TFJBVzc1elFXc1Y4QjRNRUlYaXQ3MFlLTEFJZVVCckxWR3plNG1aS0gzY0lU?=
 =?utf-8?B?WURNMVpiSWwvVWxMMDZKdm0rd0ZRWEMwNmJUZ2RBOTNTZUNRYTByN3RmK0ti?=
 =?utf-8?B?dFNvS1EzLzVaUlIyNE4rWTlZNmtmNnppenUxR25taHJLM003bHZrTDN6Qlpn?=
 =?utf-8?B?eGszTUZNQ1I3emxCaWpmMlNBYXA1UzZlR1dhNFNKK1YvY2F4NnAxZGhMMFZx?=
 =?utf-8?B?dWIrUFp4ai9icjFXWjRoWFJ0eTJlbTVJV0crM3lDQ0VTRTlITzZBNmtIK2hj?=
 =?utf-8?B?SGRMeE51TXRNb1FjaUJmUEFMNmRudmhJU1pxb01lYWd3cmVzYXFVc3VvOHRQ?=
 =?utf-8?B?U2FSeUNTelZnUTV1U3Z0REdCOURqb1NocmRYRWswbThlRG0zeGlOb3FXdHdF?=
 =?utf-8?Q?Rn+EB3t8enHtGMlots80Ltw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWxiZXJEMDh6Sk4vOVpJOUdVMysxMXp1T3Bkc0ZhU1VCdmEwdmk5UGpHbC9y?=
 =?utf-8?B?ZUlkU1ZsN29nbmRvcndTbC9Canl1YlJvTWkxWVZyYzloa0taM3daUTlOZnhS?=
 =?utf-8?B?ODNIL0I0RXlDcHpydmx1MUI0ZmxpU1M2S3BJUW5QUDdUa1pJcXAwTVJJQzRD?=
 =?utf-8?B?dlNtb1g0Skh3cEdwWDVkYlhXNWp5NnlORWxBNkhub1FBendBdjB6ZGI2alhW?=
 =?utf-8?B?WTlMbURpTklaRFlhZ21pc21OWkJJZWtvVkFUT1FtSjY4WkZlcDlaOWI2MFF3?=
 =?utf-8?B?OSsxT1ZnR3hiWll3Yk1iYXc2dkRrbGR5dVFVdUUwb2x5MVZwazhPNExBVHlx?=
 =?utf-8?B?bFJhK3RJelQzYXhLWWhGdGdwQWhuZk1Xdnp1TUtSTzFHUGtFeVJ1alRnQnpU?=
 =?utf-8?B?d3piUlFnSTdjMmYxYkZUcWNEaGxrMyszUXBsb2p1eDNHOXdiMHVhbXpacURD?=
 =?utf-8?B?RGdTSFZDV2xIUTUxMStGUEU3bll2WDAwb0dxQk93azd1WExjMXlXakFKaUtM?=
 =?utf-8?B?TmZNRUJ6SXpmVytna3Q1UGJBckJXMm4xelB6NXlNQy8ySDF0TlhhY1IyWjBY?=
 =?utf-8?B?TjlESys1a0JHNmdEcVlGVUJLbnBpVlFHa3ZlcVArUEpzUHovU3pkaXU5dDNJ?=
 =?utf-8?B?RTRIT1Fwa0s3V0d3UGxjVTFkOC80NHZsdTNsbzFqdFFDQjhDQlhrOHQ2M1VR?=
 =?utf-8?B?TmZYUHcyOGowU3JvL0hZN0ttMHR4Q1AzZ3RhTTZaNjI1TlRldEZ3Uk8yRmhJ?=
 =?utf-8?B?RVAvZERiZkVvM3RielBpckN4cjJJVjBFWUkxRmpYNHN4TjhKSUlCTzVqNEtY?=
 =?utf-8?B?L0Q0L3puelFDYWFyajZicGlsME93UFNKU0FwODJpZFY1eW02bDJQeFRRajZZ?=
 =?utf-8?B?SXhVcHNUNEt5VzNGdUlyaHBtQ2g3aDBCcUNiT1pCMFA1SGtqNnRhK1dJVGRU?=
 =?utf-8?B?bHVGUWJ2T1VNbG0vR0VnZlpuU2RnTFRub0ZJUTRpbDRWaUp5bWo2Yk0yVWFk?=
 =?utf-8?B?NFQwaE1JZ2hmd2E3TVY4dElQZDc3YzdoQkNuY0hDQ2JmOU9rU0JGRDNLM0lr?=
 =?utf-8?B?VmpOTmUzQkl5V1UxREE4TmV5WHVhajEzWUkzWVNseDA5UE4reGw2WkZ5ZUpp?=
 =?utf-8?B?bHI1eWFHaDhDVGFCUmVDc1J1SEtldkJmd0FCbFNGQ1NFa05zV24zNXh2c21G?=
 =?utf-8?B?WkhZcWVWODF5S3NObysxMVFBWVBNNFR1TDZLdXZZWUFZRDZzUDdaaUphbDR4?=
 =?utf-8?B?QmR3cUIyb29waFh3a3NCVWswaC8zUU5MYVVYdllVYkx6aE1ITWIyOXplU2FK?=
 =?utf-8?B?NlNRbE5KdlNJNjBHRFlyQWZwYkcyM3E2Sk5rbEEyNUczZ1VrUDJjNnpFcTNk?=
 =?utf-8?B?MDhIVzRNY0pFM1k1VTZLNUJWeEkvZXYzL1c5OFZpOStKdjM0T3FOeWFmUGwv?=
 =?utf-8?B?TVk3dDRaZWdVOXJsb0xjSEI3TmMxM1RCYzNId1Z1aDBmN1NlNU9XcWpQMUU3?=
 =?utf-8?B?NXNyeTkwdDhjQmloUDdqMVo2ZktnKzhyL3BWb01Cb1Jiay9WKzFxU2k0bGE2?=
 =?utf-8?B?ODU1a1phTkM3dm9HKzRXSUxINTc3Rmk0RlZNTTNpdkpEQ3l5NUZRTkdoM29z?=
 =?utf-8?B?c2pEcnN5S29namdOck5oeTlZMXlpVkpNYU0xOWdFRTljVTA5UC9QbVhhT1Nu?=
 =?utf-8?B?YTc4WDgrdWxnclhscWM0RFlKdDdkbUNJa0FwSFhLdGJrWlQzckFkN2hJYjJ3?=
 =?utf-8?B?SDB2VVlKSmk5WXdFN2tYMG5COEJyNXBsYjN0VFU1QkdhSlBhQ2N2SVR4RVNJ?=
 =?utf-8?B?NDNOdWYweXFBWVR6TndtNDVHQ2FUa3h2N0ZjZnMxalVxT1pCR2Nvc0FxOE9m?=
 =?utf-8?B?cUZESksycXFKV3NyZ3R0UlpiUzVaOXpUb0xuc2dLeDQrU1dyUTgvZy9kVGN1?=
 =?utf-8?B?bktyaXFacE9yRk4yM2J0bkJTeG9LcFlIL3BYbm82dXhsNXdHVnpnRVIvaUhy?=
 =?utf-8?B?Vzd2U2U3aVRPN21YRStsQUhVOHZ0SFhPa29kKzI5RU9iMFB6K0JPc1loQUJQ?=
 =?utf-8?B?OGlSaWlPNHFaZXVqS2JwQWswMDh6cVJSSi9DQ0l0dnViNW1mMVpRekdxaVF5?=
 =?utf-8?B?dmhtbUVnNmJydDJIeWdVQTJKVDdkM1gwcXlhT1FCRm5tWXZsUW82cXR3Qm54?=
 =?utf-8?B?RkZ5OTdyRitlUTZUeXZ1NSttYnk4Y1o0NVJPeTRpbkFIS2ZVT202aHpMYW5x?=
 =?utf-8?B?ZWJMVXY0ZmFJcXpzRFFTTlpQZ0tYVnJEOU5VQW1wUkI2NEpiaXV1WHY2eEJn?=
 =?utf-8?B?eTFVVUVzQUxyOGZ4Smk3Nm1FVTVxOFZqbVVKbzNVTnRmWThSYzJHUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aab890-3227-423c-6cbc-08de53bd0e3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:18.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7mRzrhC+D+RyszTGNS+yLBwnacK/xSw3C+x6KvL/CV9sua/OI4pBmuVIUAzaTJYH8RuCzWFkH3j96yxyfdA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use devm_clk_get_prepared() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed9e56de5a9b9484c6598d438f66a836504818be..f7518f567ecd707575e73803a94c2c1d4762f3f4 100644
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
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
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
2.34.1


